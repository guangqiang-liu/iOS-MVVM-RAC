//
//  UIViewController+SimplePresent.h
//  SimpleView
//
//  Created by ileo on 16/6/3.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SimplePresent)

typedef void (^PresentBlock)(BOOL success, id info);

/**
 *  弹出动画
 */
-(instancetype)resetModalTransitionStyle:(UIModalTransitionStyle)style;

/**
 *  弹出界面，带弹出界面消失的回调信息，
 *  ps支持单纯UIViewController，或者带UIViewController的UINavigationController取topViewController
 */
-(void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion willDismissCallback:(PresentBlock)willDismissCallback didDismissCallback:(PresentBlock)didDismissCallback;

/**
 *  消失界面，带回调信息
 */
-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion success:(BOOL)success info:(id)info;

@end
