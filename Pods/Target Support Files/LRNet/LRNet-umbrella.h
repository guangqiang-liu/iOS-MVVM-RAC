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

#import "LRNet.h"
#import "LRNetModel.h"
#import "LRNetStatus.h"

FOUNDATION_EXPORT double LRNetVersionNumber;
FOUNDATION_EXPORT const unsigned char LRNetVersionString[];

