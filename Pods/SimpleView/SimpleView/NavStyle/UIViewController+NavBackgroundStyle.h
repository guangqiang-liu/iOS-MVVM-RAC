//
//  UIViewController+NavBackgroundStyle.h
//  SimpleView
//
//  Created by ileo on 16/5/12.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (NavBackgroundStyle)

/**
 *  配置默认导航栏背景颜色  ps.应用开启时配置
 */
+(void)configNavBackgroundColor:(UIColor *)color;

/**
 *  获取配置的导航栏背景颜色
 */
+(UIColor *)navBackgroundColor;

/**
 *  设置为可配置的导航栏背景  ps.应用开启时配置
 */
+(void)configNavBackgroundStyle;

/**
 *  隐藏导航栏
 */
@property (nonatomic, assign) BOOL navBarHidden;
-(void)setNavBarHidden:(BOOL)navBarHidden animated:(BOOL)animated;

/**
 *  背景颜色
 */
@property (nonatomic, strong) UIColor *navBackgroundColor;

/**
 *  底部阴影 nil为默认阴影
 */
@property (nonatomic, strong) UIImage *navShadowImage;

/**
 *  导航栏背景透明
 */
@property (nonatomic, assign) BOOL navBackgroundTranslucent;

@end
