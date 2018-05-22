//
//  DeviceCenter.m
//  WalletLifeAPP
//
//  Created by ileo on 2016/11/24.
//  Copyright © 2016年 QianBao. All rights reserved.
//

#import "WLDeviceInfo.h"
#import "WalletBase.h"
#import <sys/utsname.h>
#import <AdSupport/AdSupport.h>
#import "OpenUDID.h"

@implementation WLDeviceInfo

+(NSString *)uuid{
    NSString *key = @"WLDevice_UUID";
    NSString *uuid = NSUserDefaultsGet(key);
    if (!IsValidString(uuid)) {
        uuid = [[NSUUID UUID] UUIDString];
        NSUserDefaultsSet(uuid, key);
    }
    return uuid;
}

+(NSString *)idfa{
    if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
        return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    }else{
        return [self idfv];
    }
}

+(NSString *)idfv{
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

+(NSString *)systemVersion{
    return [[UIDevice currentDevice] systemVersion];
}

+(NSString *)systemName{
    return [[UIDevice currentDevice] systemName];
}

+(NSString *)machine{
    struct utsname systemInfo;
    uname(&systemInfo);
    return  [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
}

+(NSString *)udid{
    return [OpenUDID value];
}

+ (NSString *)applicationName
{
    NSDictionary *bundleInfo = [[NSBundle mainBundle] infoDictionary];
    return [bundleInfo valueForKey:@"CFBundleDisplayName"] ?: [bundleInfo valueForKey:@"CFBundleName"];
}

+ (NSString *)applicationScheme
{
    NSDictionary *bundleInfo    = [[NSBundle mainBundle] infoDictionary];
    NSString *bundleIdentifier  = [[NSBundle mainBundle] bundleIdentifier];
    NSArray *URLTypes           = [bundleInfo valueForKey:@"CFBundleURLTypes"];
    
    NSString *scheme;
    for (NSDictionary *dic in URLTypes)
    {
        NSString *URLName = [dic valueForKey:@"CFBundleURLName"];
        if (URLName && [URLName isEqualToString:bundleIdentifier])
        {
            scheme = [[dic valueForKey:@"CFBundleURLSchemes"] objectAtIndex:0];
            break;
        }
    }
    
    return scheme;
}

@end
