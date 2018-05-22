//
//  WLComponentManager.m
//  WLManager
//
//  Created by leo on 2017/4/1.
//  Copyright © 2017年 qianbao. All rights reserved.
//

#import "WLComponent.h"
#import "WalletBase.h"
#import "NSObject+WLComponent.h"

@interface WLComponent ()

DEF_SINGLETON

@property (nonatomic, strong) NSMutableDictionary *components;
@property (nonatomic, strong) NSMutableDictionary *blocks;
@property (nonatomic, strong) NSMutableDictionary *storyboards;

@end

@implementation WLComponent

IMP_SINGLETON

+(void)registerBlock:(id (^)(id))block forKey:(NSString *)key{
    [[WLComponent sharedInstance].blocks addEntriesFromDictionary:@{key : block}];
}

+(id)handleBlockWithKey:(NSString *)key info:(id)info{
    id (^block)(id) = [WLComponent sharedInstance].blocks[key];
    if (block) {
        return block(info);
    }else{
        NSAssert(NO, @"未注册block ：%@",key);
        return nil;
    }
}

+(void)registerClass:(Class)cls forKey:(NSString *)key{
    [[WLComponent sharedInstance].components addEntriesFromDictionary:@{key : [cls description]}];
}

+(void)registerClass:(Class)cls forKey:(NSString *)key sbName:(NSString *)name sbID:(NSString *)sbID{
    [self registerClass:cls forKey:key];
    NSAssert(name && sbID, @"无效参数");
    [[WLComponent sharedInstance].storyboards addEntriesFromDictionary:@{key : @{@"name" : name, @"id" : sbID}}];
}

+(id)handleURL:(NSURL *)url{
    return [self handleURL:url info:nil];
}

+(BOOL)canHandleTarget:(NSString *)target{
    NSString *name = [WLComponent sharedInstance].components[target];
    Class cls = NSClassFromString(name);
    return cls != nil;
}

+(id)handleURL:(NSURL *)url info:(id)info{
    if ([url.scheme isEqualToString:App_name]) {
        NSString *name = [WLComponent sharedInstance].components[url.host];
        NSDictionary *sb = [WLComponent sharedInstance].storyboards[url.host];
        Class cls = NSClassFromString(name);
        if (cls && url.path.length > 1) {
            return [self handleClass:cls sbInfo:sb func:[url.path substringFromIndex:1] key:url.query info:info];
        }else{
            NSAssert(NO, @"无效 %@ %@",url.host, url.path);
        }
    }else{
        NSAssert(NO, @"未能识别 : %@",url.scheme);
    }
    return nil;
}

+(id)handleClass:(Class)cls sbInfo:(NSDictionary *)sbInfo func:(NSString *)func key:(NSString *)key info:(id)info{
    if ([func isEqualToString:Func_getInfo]) {
        NSObject *mgr = [cls sharedInstance];
        if (IsValidString(key)) {
            return mgr.componentInfo[key];
        }else{
            NSAssert(NO, @"key 为空");
        }
    }else if ([func isEqualToString:Func_setInfo]) {
        NSObject *mgr = [cls sharedInstance];
        if (IsValidString(key)) {
            if (info) {
                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:mgr.componentInfo];
                dic[key] = info;
                mgr.componentInfo = dic;
            }else{
                NSLog(@"传入空数据");
            }
        }else{
            NSAssert(NO, @"key 不合法");
        }
    }else if ([func isEqualToString:Func_setRootVC]) {
        UIViewController *vc = [self vcWithClass:cls sbInfo:sbInfo info:info];
        [self appWindow].rootViewController = vc;
    }else if ([func isEqualToString:Func_navPushVC]) {
        UIViewController *vc = [self vcWithClass:cls sbInfo:sbInfo info:info];
        if ([self currentViewController].navigationController) {
            [[self currentViewController].navigationController pushViewController:vc animated:YES];
        }else{
            NSAssert(NO, @"当前页面不支持导航跳转");
        }
    }else if ([func isEqualToString:Func_presentVC]) {
        UIViewController *vc = [self vcWithClass:cls sbInfo:sbInfo info:info];
        [[self currentViewController] presentViewController:vc animated:YES completion:nil];
    }else if ([func isEqualToString:Func_getVC]) {
        return [self vcWithClass:cls sbInfo:sbInfo info:info];
    }else{
        NSAssert(NO, @"未找到对应方法 : %@",func);
    }
    return nil;
}

+(UIViewController *)vcWithClass:(Class)cls sbInfo:(NSDictionary *)sbInfo info:(id)info{
    if (sbInfo) {
        UIViewController *vc = ViewControllerFromStoryboard(sbInfo[@"name"], sbInfo[@"id"]);
        vc.componentInfo = info;
        return vc;
    }else{
        return [[cls alloc] initWithComponentInfo:info];
    }
}

#pragma mark -

-(NSMutableDictionary *)components{
    if (!_components) {
        _components = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    return _components;
}

-(NSMutableDictionary *)blocks{
    if (!_blocks) {
        _blocks = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    return _blocks;
}

-(NSMutableDictionary *)storyboards{
    if (!_storyboards) {
        _storyboards = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    return _storyboards;
}

+(NSURL *)urlWithTarget:(NSString *)target func:(NSString *)func key:(NSString *)key{
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@://%@/%@?%@",App_name,SafeString(target),SafeString(func),SafeString(key)]];
}

@end

@implementation WLComponent (vc)

+(UIWindow *)appWindow {
    return [UIApplication sharedApplication].delegate.window;
}

+(UIViewController *)currentViewController{
    return [UIViewController currentViewController];
}

+(void)setRootVCWithTarget:(NSString *)target info:(id)info{
    [self handleURL:[self urlWithTarget:target func:Func_setRootVC key:nil] info:info];
}
+(void)navPushVCWithTarget:(NSString *)target info:(id)info{
    [self handleURL:[self urlWithTarget:target func:Func_navPushVC key:nil] info:info];
}
+(void)presentVCWithTarget:(NSString *)target info:(id)info{
    [self handleURL:[self urlWithTarget:target func:Func_presentVC key:nil] info:info];
}

+(UIViewController *)vcWithTarget:(NSString *)target info:(id)info{
    return  [self handleURL:[self urlWithTarget:target func:Func_getVC key:nil] info:info];
}

@end

@implementation WLComponent (manager)

+(void)setMgrInfoWithTarget:(NSString *)target key:(NSString *)key info:(id)info{
    [self handleURL:[self urlWithTarget:target func:Func_setInfo key:key] info:info];
}

+(id)getMgrInfoWithTarget:(NSString *)target key:(NSString *)key{
    return  [self handleURL:[self urlWithTarget:target func:Func_getInfo key:key] info:nil];
}


@end

