//
//  UIViewController+WLNavigationItem.m
//  WLBaseView_Example
//
//  Created by 刘光强 on 2018/3/15.
//  Copyright © 2018年 guangqiang-liu. All rights reserved.
//

#import "UIViewController+WLNavigationItem.h"

#define kNavItemFont [UIFont systemFontOfSize:14]

@implementation UIViewController (WLNavigationItem)

- (void)setNavigationItemBackItem {
    UIButton *itemBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(@"WLBaseView")];
    UIImage *image = [UIImage imageNamed:@"icon_back" inBundle:bundle compatibleWithTraitCollection:nil];
    [itemBtn setImage:image forState:UIControlStateNormal];
    [itemBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    [itemBtn addTarget:self action:@selector(popVC) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:itemBtn];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)setNavigationItemLeftBarButtonItem:(SEL)btnSel withTitle:(NSString *)title withTitleColor:(UIColor *)color {
    UIButton *itemBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [itemBtn setTitle:title forState:UIControlStateNormal];
    [itemBtn setTitleColor:color forState:UIControlStateNormal];
    itemBtn.titleLabel.font = kNavItemFont;
    [itemBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
    [itemBtn addTarget:self action:btnSel forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:itemBtn];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)setNavigationItemLeftBarButtonItem:(SEL)btnSel withImage:(NSString *)image {
    UIButton *itemBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [itemBtn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [itemBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    [itemBtn addTarget:self action:btnSel forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:itemBtn];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)setNavigationItemRightBarButtonItem:(SEL)btnSel withImage:(NSString *)image {
    UIButton *itemBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [itemBtn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [itemBtn addTarget:self action:btnSel forControlEvents:UIControlEventTouchUpInside];
    [itemBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:itemBtn];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)setNavigationItemRightBarButtonItem:(SEL)btnSel withTitle:(NSString *)title withTitleColor:(UIColor *)color {
    UIButton *itemBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [itemBtn setTitle:title forState:UIControlStateNormal];
    [itemBtn setTitleColor:color forState:UIControlStateNormal];
    itemBtn.titleLabel.font = kNavItemFont;
    [itemBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
    [itemBtn addTarget:self action:btnSel forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:itemBtn];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)popVC {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dismissVC {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
