//
//  WLNetServer.m
//  WLNetServer
//
//  Created by leo on 2017/3/28.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "WLNetServer.h"
#import "WLConst.h"

@interface WLNetServer ()

DEF_SINGLETON

@property (nonatomic, copy) NSString *hostKey;
@property (nonatomic, copy) NSString *wlHost;

@property (nonatomic, copy) NSArray<NSString *> *whiteKeys;
@property (nonatomic, copy) NSArray<LRNet *> *validNets;

@end

@implementation WLNetServer

IMP_SINGLETON

+(void)configWithHost:(Host_Type)host{
    NSString *hostKey = @"";
    switch (host) {
        case Host_Product:
            hostKey = @"host_product";
            break;
        case Host_Pre_Product:
            hostKey = @"host_pre_product";
            break;
        case Host_Develop:
            hostKey = @"host_develop";
            break;
        case Host_Test:
            hostKey = @"host_test";
            break;
        default:
            NSAssert(NO, @"无效host");
            break;
    }
    [WLNetServer sharedInstance].hostKey = hostKey;
    [WLNetServer sharedInstance].wlHost = [WLConst netHostWithKey:hostKey];
    
}

+(NSString *)hostKey{
    return [WLNetServer sharedInstance].hostKey;
}

+(NSString *)wlHost{
    return [WLNetServer sharedInstance].wlHost;
}

+(void)setCustomWLHost:(NSString *)wlHost{
    [[WLConst netHost] enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([wlHost isEqualToString:obj]) {
            [WLNetServer sharedInstance].hostKey = key;
        }
    }];
    [WLNetServer sharedInstance].wlHost = wlHost;
}

#pragma mark -

+(void)validNet:(LRNet *)net{
    NSMutableArray *nets = [NSMutableArray arrayWithArray:[WLNetServer sharedInstance].validNets];
    [nets addObject:net];
    [WLNetServer sharedInstance].validNets = [nets copy];
}

+(void)invalidNet:(LRNet *)net{
    NSMutableArray *nets = [NSMutableArray arrayWithArray:[WLNetServer sharedInstance].validNets];
    if ([nets containsObject:net]) {
        [nets removeObject:net];
    }
    [WLNetServer sharedInstance].validNets = [nets copy];
}

+(void)cancelValidNets{
    [[WLNetServer sharedInstance].validNets enumerateObjectsUsingBlock:^(LRNet * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL contain = NO;
        for (NSString *key in [WLNetServer sharedInstance].whiteKeys) {
            if (obj.tagObject_copy && [obj.tagObject_copy isEqualToString:key]) {
                contain = YES;
                break;
            }
        }
        if (!contain) {
            [obj setLoadMode:RequestLoadShowLoading];
            [obj.sessionDataTask cancel];
        }
    }];
    [WLNetServer sharedInstance].validNets = @[];
}

+(void)configWhiteListKeys:(NSArray<NSString *> *)keys{
    [WLNetServer sharedInstance].whiteKeys = keys;
}

@end
