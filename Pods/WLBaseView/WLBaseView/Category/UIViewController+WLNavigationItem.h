//
//  UIViewController+WLNavigationItem.h
//  WLBaseView_Example
//
//  Created by 刘光强 on 2018/3/15.
//  Copyright © 2018年 guangqiang-liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (WLNavigationItem)

/**
 设置导航栏的通用返回按钮，默认直接执行pop操作
 */
- (void)setNavigationItemBackItem;


/**
 设置导航栏的左按钮
 
 @param btnSel 按钮的点击事件
 @param title 按钮的title
 @param color title的文字颜色
 */
- (void)setNavigationItemLeftBarButtonItem:(SEL)btnSel withTitle:(NSString *)title withTitleColor:(UIColor *)color;


/**
 设置导航栏的左按钮
 
 @param btnSel 按钮的点击事件
 @param image 按钮的图片
 */
- (void)setNavigationItemLeftBarButtonItem:(SEL)btnSel withImage:(NSString *)image;


/**
 设置导航按钮的右按钮
 
 @param btnSel 按钮的点击事件
 @param image 按钮的图片
 */
- (void)setNavigationItemRightBarButtonItem:(SEL)btnSel withImage:(NSString *)image;


/**
 设置导航按钮的右按钮
 
 @param btnSel 按钮的点击事件
 @param title 按钮的title
 @param color title的颜色
 */
- (void)setNavigationItemRightBarButtonItem:(SEL)btnSel withTitle:(NSString *)title withTitleColor:(UIColor *)color;


/**
 popVC
 */
- (void)popVC;


/**
 dismissVC
 */
- (void)dismissVC;

@end
