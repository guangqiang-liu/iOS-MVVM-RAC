//
//  WalletBase.h
//  WalletBase
//
//  Created by leo on 2017/3/21.
//  Copyright © 2017年 qianbao. All rights reserved.
//

#ifndef WalletBase_h
#define WalletBase_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ReactiveObjC.h"
#import "SimpleHeader.h"
#import "SimpleViewHeader.h"

#pragma mark -----------------------  单例


#define DEF_SINGLETON + (instancetype)sharedInstance;

#define IMP_SINGLETON \
+ (instancetype)sharedInstance { \
static id sharedObject = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
sharedObject = [[self alloc] init]; \
}); \
return sharedObject; \
}\
- (id)copyWithZone:(NSZone*)zone{\
return self;\
}


#pragma mark -----------------------  NSUserDefaults


#define NSUserDefaultsSet(obj,key) \
[[NSUserDefaults standardUserDefaults] setObject:obj forKey:key]; \
[[NSUserDefaults standardUserDefaults] synchronize]

#define NSUserDefaultsGet(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]
#define NSUserDefaultsRemove(key) [[NSUserDefaults standardUserDefaults] removeObjectForKey:key]


#pragma mark -----------------------  DEBUG


#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] \n " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...) {}
#define NSLog(...) {}
#endif


#pragma mark -----------------------  数据有效性


#define IsValidString(str) (str && ![str isKindOfClass:[NSNull class]] && ![str isEqualToString:@"<null>"] && ![str isEqualToString:@""])
#define SafeString(str) (IsValidString(str)?str:@"")

#define IsValidArray(arr) ([arr isKindOfClass:[NSArray class]])
#define SafeArray(arr) (IsValidArray(arr)?arr:@[])

#define IsValidDictionary(dic) ([dic isKindOfClass:[NSDictionary class]])
#define SafeDictionary(dic) (IsValidDictionary(dic)?dic:@{})


#pragma mark -----------------------  版本 屏幕 适配


#define __APP_V ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"])
#define __IOS_V        ([[[UIDevice currentDevice] systemVersion] floatValue])

#define __SCREEN_IS_3_5   ([[UIScreen mainScreen] bounds].size.height==480.0)
#define __SCREEN_IS_5_5   ([[UIScreen mainScreen] bounds].size.height==736.0)
#define __SCREEN_IS_X   ([[UIScreen mainScreen] bounds].size.height==812.0)
#define __MAIN_BOUND   ([[UIScreen mainScreen] bounds])
#define __MAIN_TABBAR_HEIGHT 49
#define __MAIN_NAV_HEIGHT (__SCREEN_IS_X ? 88 : 64)
#define __MAIN_IPHONE_X_HEIGHT_24 (__SCREEN_IS_X?24:0)
#define __MAIN_HEIGHT_NAV (__MAIN_HEIGHT - __MAIN_NAV_HEIGHT)
#define __MAIN_HEIGHT_NAV_TABBAR (__MAIN_HEIGHT_NAV - __MAIN_TABBAR_HEIGHT)
#define __MAIN_HEIGHT     ([[UIScreen mainScreen] bounds].size.height)
#define __MAIN_WIDTH      ([[UIScreen mainScreen] bounds].size.width)

#define __MAIN_RATIO_320_FIT(w)      (([[UIScreen mainScreen] bounds].size.width)/320 * w)
#define __MAIN_RATIO_375_FIT(w)      (([[UIScreen mainScreen] bounds].size.width)/375 * w)
#define __MAIN_RATIO_H_667_FIT(h)      (([[UIScreen mainScreen] bounds].size.height)/667 * h)


#pragma mark -----------------------  bundle

#define __BUNDLE_MAIN_PATH [[NSBundle mainBundle] bundlePath]

#define __BUNDLE [NSBundle bundleForClass:[self class]]
#define __BUNDLE_PATH [__BUNDLE bundlePath]

#define __BUNDLE_FILE_PATH(filename) ([__BUNDLE_PATH stringByAppendingFormat:@"/%@", filename])

#pragma mark -----------------------  storyboard

#define ViewControllerFromStoryboard(name,id) [[UIStoryboard storyboardWithName:name bundle:__BUNDLE] instantiateViewControllerWithIdentifier:id]

#define ViewFromNib(nib) [[__BUNDLE loadNibNamed:nib owner:self options:nil] firstObject]

#pragma mark -----------------------  font color image


#define FONT_SYSTEM_Light(s) [UIFont systemFontOfSize:s]
#define FONT_SYSTEM_Bold(s)  [UIFont boldSystemFontOfSize:s]

#define FONT_PingFang_Light(s) (__IOS_V >= 9 ? [UIFont fontWithName:@"PingFangSC-Light" size:s] : FONT_SYSTEM_Light(s))
#define FONT_PingFang_Regular(s) (__IOS_V >= 9 ? [UIFont fontWithName:@"PingFangSC-Regular" size:s] : FONT_SYSTEM_Light(s))
#define FONT_PingFang_Bold(s) (__IOS_V >= 9 ? [UIFont fontWithName:@"PingFangSC-Medium" size:s] : FONT_SYSTEM_Bold(s))

#define Color_Hex(str)    [UIColor colorWithHexString:str]
#define Color_HexValue(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define Color_RGB(r,g,b)     [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0]
#define Color_RGBA(r,g,b,a)  [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:a]

#define Image_Name(str)   [UIImage imageNamed:str inBundle:__BUNDLE compatibleWithTraitCollection:nil]


#endif /* WalletBase_h */


