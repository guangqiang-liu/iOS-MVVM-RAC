//
//  UINavigationController+WLExtension.m
//  WLBaseView_Example
//
//  Created by 刘光强 on 2018/3/15.
//  Copyright © 2018年 guangqiang-liu. All rights reserved.
//

#import "UINavigationController+WLExtension.h"

@implementation UINavigationController (WLExtension)

- (void)setNavigationBackgroundImage:(UIImage *)image {
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

@end
