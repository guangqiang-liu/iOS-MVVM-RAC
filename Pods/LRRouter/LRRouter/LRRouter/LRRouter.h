//
//  LRRouter.h
//  LRRouter
//
//  Created by leo on 2017/8/17.
//  Copyright © 2017年 leospace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LRRAnnotation.h"
#import "LRRModuleProtocol.h"
#import "LRRModuleMacro.h"

@interface LRRouter : NSObject

/*
 调用注册方法，method为方法名，path为对应模块，params为参数
 */
+(id)lrrHandleClassMethod:(NSString *)method path:(NSString *)path params:(NSArray *)params;

@end

/*
 强烈建议在开发阶段打开LRRDebug，可以帮助定位到异常情况
 只需加入以下代码即可打开
 */
//#define LRRDebug
@interface LRRouter (debug)

//在调用的时候  建议在load方法里面加上这个检测方法  请放心  只有LRRDebug模式打开时才会起作用
+(void)lrrCheckClassMethod:(NSString *)method path:(NSString *)path;

@end

