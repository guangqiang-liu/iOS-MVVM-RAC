//
//  NetStatus.m
//  NetRequestDemo
//
//  Created by ileo on 16/6/23.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "LRNetStatus.h"
#import "AFNetworkReachabilityManager.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <UIKit/UIKit.h>
#include <ifaddrs.h>
#include <arpa/inet.h>


NSString * const NetStatusDidChanged = @"NetStatusDidChanged";

@interface LRNetStatus ()

@property (nonatomic, assign) Net_Status status;

@property (nonatomic, assign) AFNetworkReachabilityStatus reachablityStatus;

@property (nonatomic, strong) CTTelephonyNetworkInfo *telephonyNetworkInfo;

@property (nonatomic, strong) NSString *currentRadioAccessTechnology;

@end

@implementation LRNetStatus

+(instancetype)sharedInstance{
    static id sharedObject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObject = [[self alloc] init];
    });
    return sharedObject;
}

- (id)copyWithZone:(NSZone*)zone{
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        __weak __typeof(self) wself = self;
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            wself.reachablityStatus = status;
        }];
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        self.telephonyNetworkInfo = [[CTTelephonyNetworkInfo alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateStatus) name:CTRadioAccessTechnologyDidChangeNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateStatus) name:UIApplicationWillEnterForegroundNotification object:nil];
    }
    return self;
}

-(BOOL)isWifi{
    return self.status == Net_Status_Wifi;
}

-(BOOL)isNetworing{
    return self.status != Net_Status_None;
}

-(NSString *)currentNetworkStatusDescribe{
    NSString *status = @"未知";
    switch (self.status) {
        case Net_Status_None:
            status = @"无网络";
            break;
        case Net_Status_Wifi:
            status = @"wifi";
            break;
        case Net_Status_WWAN:
            status = @"蜂窝网络";
            break;
        case Net_Status_2G:
            status = @"2G";
            break;
        case Net_Status_3G:
            status = @"3G";
            break;
        case Net_Status_4G:
            status = @"4G";
            break;
        default:
            break;
    }
    return status;
}

-(Net_Status)currentNetworkStatusTag{
    return self.status;
}

-(void)updateStatus{
    NSLog(@"update");
    if (self.reachablityStatus == AFNetworkReachabilityStatusReachableViaWWAN) {
        self.status = [self WWANStatus];
    }
}

-(NSString *)wifiIPAddress{
    return [self ipWithType:@"en0"];
}

-(NSString *)WWANIPAddress{
    return [self ipWithType:@"pdp_ip0"];
}

-(NSString *)ipWithType:(NSString *)type{
    NSString *address = @"NotFound";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:type]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

#pragma mark set-get

-(void)setReachablityStatus:(AFNetworkReachabilityStatus)reachablityStatus{
    if (reachablityStatus != _reachablityStatus) {
        _reachablityStatus = reachablityStatus;
        switch (reachablityStatus) {
            case AFNetworkReachabilityStatusUnknown:
                self.status = Net_Status_Unknow;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                self.status = Net_Status_None;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                self.status = [self WWANStatus];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                self.status = Net_Status_Wifi;
                break;
            default:
                break;
        }
    }
}

-(void)setStatus:(Net_Status)status{
    if (_status != status) {
        _status = status;
        [[NSNotificationCenter defaultCenter] postNotificationName:NetStatusDidChanged object:nil];
    }
}

-(NSString *)currentRadioAccessTechnology{
    return self.telephonyNetworkInfo.currentRadioAccessTechnology;
}

-(Net_Status)WWANStatus{
    if ([self.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyLTE]) {
        return Net_Status_4G;
    }
    if ([@[CTRadioAccessTechnologyHSDPA,
          CTRadioAccessTechnologyWCDMA,
          CTRadioAccessTechnologyHSUPA,
          CTRadioAccessTechnologyCDMA1x,
          CTRadioAccessTechnologyCDMAEVDORev0,
          CTRadioAccessTechnologyCDMAEVDORevA,
          CTRadioAccessTechnologyCDMAEVDORevB,
          CTRadioAccessTechnologyeHRPD] containsObject:self.currentRadioAccessTechnology]) {
        return Net_Status_3G;
    }
    if ([@[CTRadioAccessTechnologyEdge,CTRadioAccessTechnologyGPRS] containsObject:self.currentRadioAccessTechnology]) {
        return Net_Status_2G;
    }
    if (!self.currentRadioAccessTechnology) {
        return [self cuttentStatusBarDataNetworkTag];
    }
    return Net_Status_WWAN;
}

-(Net_Status)cuttentStatusBarDataNetworkTag{
    
    NSArray *subviews = nil;
    id statusBar = [[UIApplication sharedApplication] valueForKey:@"statusBar"];
    if ([statusBar isKindOfClass:NSClassFromString(@"UIStatusBar_Modern")]) {
        subviews = [[[statusBar valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
    } else {
        subviews = [[statusBar valueForKey:@"foregroundView"] subviews];
    }
    
    NSNumber *dataNetworkItemView = nil;
    for (id subview in subviews) {
        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            dataNetworkItemView = subview;
            break;
        }
    }
    
    Net_Status status = Net_Status_Unknow;
    switch ([[dataNetworkItemView valueForKey:@"dataNetworkType"]integerValue]) {
        case 0:
            status = Net_Status_None;
            break;
        case 1:
            status = Net_Status_2G;
            break;
        case 2:
            status = Net_Status_3G;
            break;
        case 3:
            status = Net_Status_4G;
            break;
        case 4:
            status = Net_Status_4G;
            break;
        case 5:
            status = Net_Status_Wifi;
            break;
        default:
            break;
    }
    return status;
}


@end
