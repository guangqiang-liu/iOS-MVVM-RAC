//
//  UIViewController+NavStyle.h
//  SimpleView
//
//  Created by leo on 2017/4/22.
//  Copyright © 2017年 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (NavStyle)

+(void)configNavStyles:(NSDictionary *)styles;
+(void)configDefaultNavStyle:(NSString *)style;

-(instancetype)navSetupStyle:(NSString *)style;
@property (nonatomic, copy) NSString *navStyle;

@end

@interface NavStyleModel : NSObject

@property (nonatomic, strong) UIColor *titleColor;//标题颜色
@property (nonatomic, strong) UIFont *titleFont;//标题字体
@property (nonatomic, strong) UIColor *textColor;//按钮文字颜色
@property (nonatomic, strong) UIFont *textFont;//按钮文字字体
@property (nonatomic, copy) NSString *backStyle;//返回按钮样式
@property (nonatomic, copy) void (^Config)(UIViewController *vc);//其他配置

+(NavStyleModel *)modelWithTitleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont textColor:(UIColor *)textColor textFont:(UIFont *)textFont backStyle:(NSString *)backStyle config:(void (^)(UIViewController *vc))config;

@end
