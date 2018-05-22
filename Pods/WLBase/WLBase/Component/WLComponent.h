//
//  WLComponentManager.h
//  WLManager
//
//  Created by leo on 2017/4/1.
//  Copyright © 2017年 qianbao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WLComponentConst.h"
#import "NSObject+WLComponent.h"

@interface WLComponent : NSObject

+(id)handleURL:(NSURL *)url;
+(id)handleURL:(NSURL *)url info:(id)info;

//在load方法里面进行注册
+(void)registerClass:(Class)cls forKey:(NSString *)key;
+(void)registerClass:(Class)cls forKey:(NSString *)key sbName:(NSString *)name sbID:(NSString *)sbID;//storyboard
+(NSURL *)urlWithTarget:(NSString *)target func:(NSString *)func key:(NSString *)key;
+(BOOL)canHandleTarget:(NSString *)target;

//注册block
+(void)registerBlock:(id (^)(id info))block forKey:(NSString *)key;
+(id)handleBlockWithKey:(NSString *)key info:(id)info;

@end

@interface WLComponent (vc)

+(void)setRootVCWithTarget:(NSString *)target info:(id)info;
+(void)navPushVCWithTarget:(NSString *)target info:(id)info;
+(void)presentVCWithTarget:(NSString *)target info:(id)info;

+(UIViewController *)vcWithTarget:(NSString *)target info:(id)info;
+(UIWindow *)appWindow;
+(UIViewController *)currentViewController;

@end

@interface WLComponent (manager)

+(void)setMgrInfoWithTarget:(NSString *)target key:(NSString *)key info:(id)info;
+(id)getMgrInfoWithTarget:(NSString *)target key:(NSString *)key;

@end


