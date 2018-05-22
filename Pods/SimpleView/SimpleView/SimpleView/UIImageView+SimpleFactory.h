//
//  UIImageView+SimpleFactory.h
//  SimpleView
//
//  Created by ileo on 16/5/17.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (SimpleFactory)

/**
 *  工厂生产UIImageView
 */
+(UIImageView *)imageViewWithFrame:(CGRect)frame image:(UIImage *)image;

/**
 *  工厂生产UIImageView 中点 原尺寸
 */
+(UIImageView *)imageViewWithCenter:(CGPoint)center image:(UIImage *)image;

/**
 *  工厂生产UIImageView 原点 原尺寸
 */
+(UIImageView *)imageViewWithOriginal:(CGPoint)original image:(UIImage *)image;

/**
 *  设置contentMode
 */
-(UIImageView *)imageViewResetContentMode:(UIViewContentMode)contentMode;


@end
