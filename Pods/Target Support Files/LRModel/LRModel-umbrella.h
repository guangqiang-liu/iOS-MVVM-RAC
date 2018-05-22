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

#import "LRAIModel.h"
#import "LRModel.h"
#import "NSObject+Property.h"
#import "NSString+Unrecognized.h"
#import "PropertyTools.h"

FOUNDATION_EXPORT double LRModelVersionNumber;
FOUNDATION_EXPORT const unsigned char LRModelVersionString[];

