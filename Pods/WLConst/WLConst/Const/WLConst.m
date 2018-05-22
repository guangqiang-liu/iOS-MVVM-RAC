//
//  WLConst.m
//  WLConst
//
//  Created by leo on 2017/4/7.
//  Copyright © 2017年 qianbao. All rights reserved.
//

#import "WLConst.h"

@interface WLConst ()

/** 缓存-仅供本类内部调用 */
@property (nonatomic, strong) NSDictionary *consts;         // fileprivate

+ (instancetype)sharedInstance;

@end


@implementation WLConst

+ (instancetype)sharedInstance {
    static id sharedObject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObject = [[self alloc] init];
    });
    return sharedObject;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _consts = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    return self;
}

+ (NSDictionary *)netHost {
    
    return [self dicWithPlist:@"WLNetHost"];
}

+ (NSString *)netHostWithKey:(NSString *)key {
    
    return [self valueWithKey:key dic:[self netHost]];
}

+ (NSDictionary *)netPath {
    
    return [self dicWithPlist:@"WLNetPath"];
}

+ (NSString *)netPathWithKey:(NSString *)key {
    
    return [self valueWithKey:key dic:[self netPath]];
}

+ (NSDictionary *)appConfig {
    
    return [self dicWithPlist:@"WLAPPConfig"];
}

+ (NSString *)appConfigWithKey:(NSString *)key {
    
    return [self valueWithKey:key dic:[self appConfig]];
}

+ (NSDictionary *)netError {
    
    return [self dicWithPlist:@"WLNetError"];
}

+ (NSString *)netErrorWithKey:(NSString *)key {
    
    return [self valueWithKey:key dic:[self netError]];
}

+ (NSString *)valueWithKey:(NSString *)key dic:(NSDictionary *)dic {
    
    NSString *value = dic[key];
    NSAssert(value, @"未配置该key");
    return value;
}

/// plist属于const，可以做缓存
+ (NSDictionary *)dicWithPlist:(NSString *)name {
    
    /// 如果有缓存，直接从缓存取值
    if ([WLConst sharedInstance].consts[name]) {
        return [WLConst sharedInstance].consts[name];
    }
    
    NSString *main = [[NSBundle bundleForClass:[self class]] bundlePath];
    NSString *path =  [main stringByAppendingFormat:@"/%@.plist", name];

    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSAssert(dic, @"无该文件  %@", name);
    if (dic) {
        NSMutableDictionary *tmp = [[WLConst sharedInstance].consts mutableCopy];
        [tmp setObject:dic forKey:name];            // 加入缓存
        [WLConst sharedInstance].consts = tmp;
    }
    return dic;
}

+ (NSString *)valueWithKey:(NSString *)key plist:(NSString *)name {
    
    return [self valueWithKey:key dic:[self dicWithPlist:name]];
}

@end
