//
//  UIViewController+SimpleStatus.m
//  SimpleView
//
//  Created by leo on 2017/3/8.
//  Copyright © 2017年 ileo. All rights reserved.
//

#import <objc/runtime.h>
#import "UIViewController+SimpleStatus.h"
#import "UINavigationController+SimpleFactory.h"
#import "UIViewController+SimpleNavigation.h"
#import "NSObject+Method.h"

@implementation UIViewController (SimpleStatus)

static UIStatusBarStyle defaultStatusBarStyle;
static BOOL defaultStatusBarHidden;

+(void)configDefaultPreferredStatusBarStyle:(UIStatusBarStyle)statusBarStyle statusHidden:(BOOL)statusBarHidden{
    defaultStatusBarStyle = statusBarStyle;
    defaultStatusBarHidden = statusBarHidden;
}

+(void)configSimpleStatusBar{
    [UINavigationController configChildViewControllerForStatusBarStyle];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIViewController exchangeSEL:@selector(preferredStatusBarStyle) withSEL:@selector(SimpleStatus_preferredStatusBarStyle)];
        [UIViewController exchangeSEL:@selector(prefersStatusBarHidden) withSEL:@selector(SimpleStatus_prefersStatusBarHidden)];
        [UIViewController exchangeSEL:@selector(viewDidAppear:) withSEL:@selector(SimpleStatus_viewDidAppear:)];
    });
}

-(UIStatusBarStyle)SimpleStatus_preferredStatusBarStyle{
    if (objc_getAssociatedObject(self, &keyStatusBarStyle)) {
        return [objc_getAssociatedObject(self, &keyStatusBarStyle) integerValue];
    }
    return defaultStatusBarStyle;
}

-(BOOL)SimpleStatus_prefersStatusBarHidden{
    if (objc_getAssociatedObject(self, &keyStatusBarHidden)) {
        return [objc_getAssociatedObject(self, &keyStatusBarHidden) boolValue];
    }
    return defaultStatusBarHidden;
}

-(void)SimpleStatus_viewDidAppear:(BOOL)animated{
    [self SimpleStatus_viewDidAppear:animated];
    if (objc_getAssociatedObject(self, &keyStatusBarStyle)) {
        self.statusBarStyle = [objc_getAssociatedObject(self, &keyStatusBarStyle) integerValue];
    }else{
        self.statusBarStyle = defaultStatusBarStyle;
    }
    if (objc_getAssociatedObject(self, &keyStatusBarHidden)) {
        self.statusBarHidden = [objc_getAssociatedObject(self, &keyStatusBarHidden) boolValue];
    }else{
        self.statusBarHidden = defaultStatusBarHidden;
    }
    [self prefersStatusBarHidden];
    [self setNeedsStatusBarAppearanceUpdate];
}


static char keyStatusBarStyle;
static char keyStatusBarHidden;

-(void)setStatusBarHidden:(BOOL)statusBarHidden{
    objc_setAssociatedObject(self, &keyStatusBarHidden, @(statusBarHidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self prefersStatusBarHidden];
    [self setNeedsStatusBarAppearanceUpdate];
}

-(BOOL)statusBarHidden{
    return [self prefersStatusBarHidden];
}

-(UIStatusBarStyle)statusBarStyle{
    return [self preferredStatusBarStyle];
}

-(void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle{
    objc_setAssociatedObject(self, &keyStatusBarStyle, @(statusBarStyle), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self preferredStatusBarStyle];
    [self setNeedsStatusBarAppearanceUpdate];
}

@end
