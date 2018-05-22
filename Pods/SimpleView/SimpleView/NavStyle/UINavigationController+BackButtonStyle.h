//
//  UINavigationController+BackButtonStyle.h
//  SimpleView
//
//  Created by ileo on 16/7/20.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UIViewControllerBackButton <NSObject>

@optional
-(void)viewControllerResetBackButton;
-(void)viewControllerSetupDefaultBackButton;

@end


@interface UINavigationController (BackButtonStyle) 

/**
 *  配置右滑返回手势
 */
+(void)configNavigationControllerGesturePopBack;

/**
 *  配置返回按钮  在push之后调用UIViewControllerBackButton
 */
+(void)configViewControllerResetBackButton;

/**
 *  配置默认返回按钮  在push之后调用UIViewControllerBackButton
 */
+(void)configViewControllerSetupDefaultBackButton;


@end
