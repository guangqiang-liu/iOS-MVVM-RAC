#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "WLAlert.h"
#import "WalletBase.h"
#import "JsonExtend.h"
#import "NSString+Encode.h"
#import "UIView+Animation.h"
#import "NSObject+WLComponent.h"
#import "WLComponent.h"
#import "WLComponentConst.h"
#import "WLDeviceInfo.h"

FOUNDATION_EXPORT double WLBaseVersionNumber;
FOUNDATION_EXPORT const unsigned char WLBaseVersionString[];

