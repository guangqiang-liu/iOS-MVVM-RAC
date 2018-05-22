//
//  WLNetServer.h
//  WLNetServer
//
//  Created by leo on 2017/3/28.
//  Copyright © 2017年 leo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WalletBase.h"
#import "LRNet.h"

typedef NS_ENUM(NSInteger, Host_Type){
    Host_Product,//正式环境
    Host_Pre_Product,//预生产环境
    Host_Develop,//开发环境
    Host_Test,//测试环境
};

@interface WLNetServer : NSObject

+(void)configWithHost:(Host_Type)host;//配置环境   需在一开始就配置
+(NSString *)hostKey;//WLConst里host的key  用于在WLConst获取网络请求协议对应的host


#pragma mark - 钱包生活
+(NSString *)wlHost;//钱包生活host
+(void)setCustomWLHost:(NSString *)wlHost;//设置自定义钱包生活host(提供给Debug使用)


#pragma mark - 统一管理
+(void)validNet:(LRNet *)net;//加入生效数组
+(void)invalidNet:(LRNet *)net;//移除生效数组
+(void)cancelValidNets;//取消所有生效net
+(void)configWhiteListKeys:(NSArray<NSString *> *)keys;//配置白名单


@end

