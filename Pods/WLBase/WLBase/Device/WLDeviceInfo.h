//
//  DeviceCenter.h
//  WalletLifeAPP
//
//  Created by ileo on 2016/11/24.
//  Copyright © 2016年 QianBao. All rights reserved.
//

#import <Foundation/Foundation.h>

//提交审核时  需要选择idfa  广告标识符
@interface WLDeviceInfo : NSObject

+(NSString *)uuid;
+(NSString *)machine;
+(NSString *)systemVersion;
+(NSString *)systemName;
+(NSString *)idfa;//当限制广告标识的时候，返回idfv
+(NSString *)idfv;
+(NSString *)udid;//设备唯一  多app共用
+(NSString *)applicationName;//应用名称
+(NSString *)applicationScheme;
@end
