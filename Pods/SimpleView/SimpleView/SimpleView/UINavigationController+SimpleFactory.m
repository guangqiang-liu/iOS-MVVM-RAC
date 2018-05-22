//
//  UINavigationController+SimpleFactory.m
//  SimpleView
//
//  Created by ileo on 16/5/6.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "UINavigationController+SimpleFactory.h"
#import "NSObject+Method.h"
#import "UIViewController+SimpleFactory.h"

@implementation UINavigationController (SimpleFactory)

+(UINavigationController *)navigationControllerWithRootViewController:(UIViewController *)viewController{
    return [[UINavigationController alloc] initWithRootViewController:viewController];
}

+(void)configChildViewControllerForStatusBarStyle{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UINavigationController exchangeSEL:@selector(childViewControllerForStatusBarStyle) withSEL:@selector(SimpleNavigation_childViewControllerForStatusBarStyle)];
    });
}

+(void)configNavigationAction{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UINavigationController exchangeSEL:@selector(pushViewController:animated:) withSEL:@selector(SimpleNavigation_pushViewController:animated:)];
        [UINavigationController exchangeSEL:@selector(popToRootViewControllerAnimated:) withSEL:@selector(SimpleNavigation_popToRootViewControllerAnimated:)];
        [UINavigationController exchangeSEL:@selector(popToViewController:animated:) withSEL:@selector(SimpleNavigation_popToViewController:animated:)];
        [UINavigationController exchangeSEL:@selector(popViewControllerAnimated:) withSEL:@selector(SimpleNavigation_popViewControllerAnimated:)];
    });
}

-(UIViewController *)SimpleNavigation_childViewControllerForStatusBarStyle{
    return self.visibleViewController;
}

+(void)autoHidesBottomBarWhenPush{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UINavigationController exchangeSEL:@selector(pushViewController:animated:) withSEL:@selector(SimpleNavigation_autoHidesBottomBarWhenPush_pushViewController:animated:)];
    });
}

-(void)SimpleNavigation_autoHidesBottomBarWhenPush_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [self SimpleNavigation_autoHidesBottomBarWhenPush_pushViewController:viewController animated:animated];
}

-(void)SimpleNavigation_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [self.viewControllers.lastObject viewWillDisappearByNavigationPush:animated];
    [viewController viewWillAppearByNavigationPush:animated];
    [self SimpleNavigation_pushViewController:viewController animated:animated];
}

-(NSArray<UIViewController *> *)SimpleNavigation_popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [self.viewControllers.lastObject viewWillDisappearByNavigationPop:animated];
    [viewController.navLastViewController viewWillAppearByNavigationPop:animated];
    NSArray<UIViewController *> *vcs = [self SimpleNavigation_popToViewController:viewController animated:animated];
    return vcs;
}

-(UIViewController *)SimpleNavigation_popViewControllerAnimated:(BOOL)animated{
    [self.viewControllers.lastObject viewWillDisappearByNavigationPop:animated];
    [self.viewControllers.lastObject.navLastViewController viewWillAppearByNavigationPop:animated];
    UIViewController *vc = [self SimpleNavigation_popViewControllerAnimated:animated];
    return vc;
}

-(NSArray<UIViewController *> *)SimpleNavigation_popToRootViewControllerAnimated:(BOOL)animated{
    [self.viewControllers.lastObject viewWillDisappearByNavigationPop:animated];
    [self.viewControllers.firstObject viewWillAppearByNavigationPop:animated];
    NSArray<UIViewController *> *vcs = [self SimpleNavigation_popToRootViewControllerAnimated:animated];
    return vcs;
}

@end
