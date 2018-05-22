//
//  UINavigationController+BackButtonStyle.m
//  SimpleView
//
//  Created by ileo on 16/7/20.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "UINavigationController+BackButtonStyle.h"
#import "UIViewController+BackButtonStyle.h"
#import "NSObject+Method.h"

@interface UINavigationController () <UIGestureRecognizerDelegate>

@end

@implementation UINavigationController (BackButtonStyle)

+(void)configNavigationControllerGesturePopBack{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UINavigationController exchangeSEL:@selector(pushViewController:animated:) withSEL:@selector(BackButtonStyle_pushViewController:animated:)];
    });
}

-(void)BackButtonStyle_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count == 1) {
        self.interactivePopGestureRecognizer.delegate = self;
    }
    self.interactivePopGestureRecognizer.enabled = NO;
    [self BackButtonStyle_pushViewController:viewController animated:animated];
}

+(void)configViewControllerResetBackButton{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UINavigationController exchangeSEL:@selector(pushViewController:animated:) withSEL:@selector(UIViewControllerBackButton_pushViewController:animated:)];
    });
}

+(void)configViewControllerSetupDefaultBackButton{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UINavigationController exchangeSEL:@selector(pushViewController:animated:) withSEL:@selector(UIViewControllerBackButton_setupDefault_pushViewController:animated:)];
    });
}

-(void)UIViewControllerBackButton_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [self UIViewControllerBackButton_pushViewController:viewController animated:animated];
    if ([viewController respondsToSelector:@selector(viewControllerResetBackButton)]) {
        [viewController performSelector:@selector(viewControllerResetBackButton)];
    }
}

-(void)UIViewControllerBackButton_setupDefault_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [self UIViewControllerBackButton_setupDefault_pushViewController:viewController animated:animated];
    if (self.viewControllers.count > 1 && [viewController respondsToSelector:@selector(viewControllerSetupDefaultBackButton)]) {
        [viewController performSelector:@selector(viewControllerSetupDefaultBackButton)];
    }
}

#pragma mark - 右滑返回
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    UIViewController *vc = self.visibleViewController;
    if ([vc respondsToSelector:@selector(viewControllerShouldGesturePopBack)]) {
        return (BOOL)[vc performSelector:@selector(viewControllerShouldGesturePopBack)];
    }else if (vc.canGesturePopBack) {
        return [vc.canGesturePopBack boolValue];
    }
    return self.viewControllers.count != 1;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}

@end
