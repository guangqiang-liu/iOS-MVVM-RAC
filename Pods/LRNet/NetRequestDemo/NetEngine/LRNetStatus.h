//
//  NetStatus.h
//  NetRequestDemo
//
//  Created by ileo on 16/6/23.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, Net_Status){
    Net_Status_None = 0,
    Net_Status_Wifi,
    Net_Status_WWAN,
    Net_Status_2G,
    Net_Status_3G,
    Net_Status_4G,
    Net_Status_Unknow,
};

@interface LRNetStatus : NSObject

extern NSString * const NetStatusDidChanged;//当状态改变时会发送通知

//单例
+(instancetype)sharedInstance;

-(NSString *)currentNetworkStatusDescribe;
-(Net_Status)currentNetworkStatusTag;

//是否联网
-(BOOL)isNetworing;
//是否wifi环境
-(BOOL)isWifi;

//IP
-(NSString *)wifiIPAddress;
-(NSString *)WWANIPAddress;

@end
