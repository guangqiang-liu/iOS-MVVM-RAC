//
//  UIViewController+SimpleStatus.h
//  SimpleView
//
//  Created by leo on 2017/3/8.
//  Copyright © 2017年 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SimpleStatus)

/**
 *  配置默认状态栏样式  ps.应用开启时配置
 */
+(void)configDefaultPreferredStatusBarStyle:(UIStatusBarStyle)statusBarStyle statusHidden:(BOOL)statusBarHidden;

+(void)configSimpleStatusBar;

/**
 *  状态栏隐藏
 */
@property (nonatomic, assign) BOOL statusBarHidden;

/**
 *  状态栏样式
 */
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;

@end
