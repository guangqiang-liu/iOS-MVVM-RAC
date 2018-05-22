//
//  UIViewController+SimplePush.m
//  Pods
//
//  Created by leo on 2017/7/6.
//
//

#import "UIViewController+SimplePush.h"
#import "NSObject+Method.h"
#import <objc/runtime.h>


@implementation UINavigationController (SimplePush)

//-(UIViewController *)popViewControllerAnimated:(BOOL)animated{
//
//}
//
//-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
//
//}

@end


@implementation UIViewController (SimplePush)

+(void)configSimplePush{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIViewController exchangeSEL:@selector(viewDidAppear:) withSEL:@selector(SimplePush_viewDidAppear:)];
    });
}


static char keyPopIgnore;

-(void)setPopIgnore:(BOOL)popIgnore{
    objc_setAssociatedObject(self, &keyPopIgnore, @(popIgnore), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self ignoreViewController];
}

-(BOOL)popIgnore{
    return [objc_getAssociatedObject(self, &keyPopIgnore) boolValue];
}

-(void)SimplePush_viewDidAppear:(BOOL)animated{
    [self SimplePush_viewDidAppear:animated];
    [self ignoreViewController];
}

-(void)ignoreViewController{
    if (self.navigationController) {
        NSMutableArray *vcs = [NSMutableArray arrayWithCapacity:self.navigationController.viewControllers.count];
        [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (!obj.popIgnore) {
                [vcs addObject:obj];
            }
        }];
        if (![vcs containsObject:self] && self.navigationController.viewControllers.lastObject == self) {
            [vcs addObject:self];
        }
        self.navigationController.viewControllers = vcs;
    }
}

@end
