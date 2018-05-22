//
//  UIViewController+SimpleNavigation.h
//  SimpleView
//
//  Created by ileo on 16/4/11.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SimpleNavigation)

#pragma mark - 配置
/**
 *  使得view从导航栏底部开始
 *  配置默认视图edgesForExtendedLayout为UIRectEdgeNone
 */
+(void)configViewControllerRectEdgeNoneForExtendedLayout;

/**
 *  自动隐藏底部按钮当push的时候
 */
+(void)autoHidesBottomBarWhenPush;

#pragma mark - Title

/**
 *  设置导航栏Title颜色，字体
 */
-(void)navResetTitleColor:(UIColor *)color font:(UIFont *)font;

#pragma mark - 设置按钮

/**
 *  设置按钮颜色，字体
 */
-(void)navResetButtonTextColor:(UIColor *)color font:(UIFont *)font;

/**
 *  设置按钮nav barbuttonitem
 */
-(instancetype)navSetupLeftBarButtonItem:(UIBarButtonItem *)barButtonItem;
-(instancetype)navSetupRightBarButtonItem:(UIBarButtonItem *)barButtonItem;

/**
 *  设置按钮nav barbuttonitem
 */
-(instancetype)navSetupLeftButton:(UIButton *)button;
-(instancetype)navSetupRightButton:(UIButton *)button;

/**
 *  设置图片nav barbuttonitem
 */
-(instancetype)navSetupLeftImageName:(NSString *)name action:(void (^)(void))action NS_DEPRECATED_IOS(2_0, 8_0);
-(instancetype)navSetupRightImageName:(NSString *)name action:(void(^)(void))action NS_DEPRECATED_IOS(2_0, 8_0);
-(instancetype)navSetupLeftImage:(UIImage *)image action:(void (^)(void))action;
-(instancetype)navSetupRightImage:(UIImage *)image action:(void(^)(void))action;

/**
 *  设置文字nav barbuttonitem
 */
-(instancetype)navSetupLeftTitle:(NSString *)title action:(void(^)(void))action;
-(instancetype)navSetupRightTitle:(NSString *)title action:(void(^)(void))action;

/**
 *  设置间隔nav barbuttonitem
 */
-(instancetype)navSetupLeftSpaceWithWidth:(CGFloat)width;
-(instancetype)navSetupRightSpaceWithWidth:(CGFloat)width;

/**
 *  添加按钮nav barbuttonitem
 */
-(instancetype)navAddLeftBarButtonItem:(UIBarButtonItem *)barButtonItem;
-(instancetype)navAddRightBarButtonItem:(UIBarButtonItem *)barButtonItem;

/**
 *  添加按钮nav barbuttonitem
 */
-(instancetype)navAddLeftButton:(UIButton *)button;
-(instancetype)navAddRightButton:(UIButton *)button;

/**
 *  添加图片nav barbuttonitem
 */
-(instancetype)navAddLeftImageName:(NSString *)name action:(void (^)(void))action NS_DEPRECATED_IOS(2_0, 6_0);
-(instancetype)navAddRightImageName:(NSString *)name action:(void(^)(void))action NS_DEPRECATED_IOS(2_0, 6_0);
-(instancetype)navAddLeftImage:(UIImage *)image action:(void (^)(void))action;
-(instancetype)navAddRightImage:(UIImage *)image action:(void(^)(void))action;

/**
 *  添加文字nav barbuttonitem
 */
-(instancetype)navAddLeftTitle:(NSString *)title action:(void(^)(void))action;
-(instancetype)navAddRightTitle:(NSString *)title action:(void(^)(void))action;

/**
 *  添加间隔nav barbuttonitem
 */
-(instancetype)navAddLeftSpaceWithWidth:(CGFloat)width;
-(instancetype)navAddRightSpaceWithWidth:(CGFloat)width;

#pragma mark - 获取 barbuttonitem的View
-(NSArray<UIView *> *)navLeftViews;
-(NSArray<UIView *> *)navRightViews;


@end
