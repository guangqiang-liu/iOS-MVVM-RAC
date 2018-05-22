//
//  WLConst.h
//  WLConst
//
//  Created by leo on 2017/4/7.
//  Copyright © 2017年 qianbao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLConst : NSObject

+ (NSDictionary *)netHost;
+ (NSString *)netHostWithKey:(NSString *)key;

+ (NSDictionary *)netPath;
+ (NSString *)netPathWithKey:(NSString *)key;

+ (NSDictionary *)appConfig;
+ (NSString *)appConfigWithKey:(NSString *)key;

+ (NSDictionary *)netError;
+ (NSString *)netErrorWithKey:(NSString *)key;

+ (NSDictionary *)dicWithPlist:(NSString *)name;
+ (NSString *)valueWithKey:(NSString *)key plist:(NSString *)name;

@end
