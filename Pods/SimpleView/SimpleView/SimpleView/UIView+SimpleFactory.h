//
//  UIView+SimpleFactory.h
//  SimpleView
//
//  Created by ileo on 16/5/5.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SimpleFactory)

/**
 *  工厂生产UIView
 */
+(instancetype)viewWithFrame:(CGRect)frame;

/**
 *  工厂生产UIView
 */
+(instancetype)viewWithCenter:(CGPoint)center size:(CGSize)size;

/**
 *  工厂生产UIView
 */
+(instancetype)viewWithCenterX:(CGFloat)centerX top:(CGFloat)top size:(CGSize)size;

/**
 *  工厂生产UIView
 */
+(instancetype)viewWithRight:(CGFloat)right top:(CGFloat)top size:(CGSize)size;

/**
 *  设置背景颜色
 */
-(instancetype)resetBackgroundColor:(UIColor *)color;

/**
 *  设置tag
 */
-(instancetype)resetTag:(NSInteger)tag;


/**
 *  添加到View上 addSubView
 */
-(instancetype)setupOnView:(UIView *)view;

/**
 *  设置边框
 */
-(instancetype)resetBorderWidth:(CGFloat)width borderColor:(UIColor *)color;


/**
 *  设置圆角
 */
-(instancetype)resetCornerRadius:(CGFloat)cornerRadius;


/**
 *  设置配置，返回自己为ui，用于配置自己
 */
-(instancetype)resetConfig:(void (^)(id ui))config;



@end

