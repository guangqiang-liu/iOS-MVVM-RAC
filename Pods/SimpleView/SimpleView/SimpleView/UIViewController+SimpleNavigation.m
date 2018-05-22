//
//  UIViewController+SimpleNavigation.m
//  SimpleView
//
//  Created by ileo on 16/4/11.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "UIViewController+SimpleNavigation.h"
#import "UIBarButtonItem+SimpleFactory.h"
#import "UIButton+SimpleFactory.h"
#import "UILabel+SimpleFactory.h"
#import "UIView+Sizes.h"
#import <objc/runtime.h>
#import "NSObject+Method.h"
#import "UINavigationController+SimpleFactory.h"

typedef NS_ENUM(NSInteger, BarButtonSide){
    BarButtonSideLeft,
    BarButtonSideRight
};

@implementation UIViewController (SimpleNavigation)

#pragma mark - title

static char keyNewTitleTextAttributes;
static char keyOldTitleTextAttributes;
BOOL registerOldTitleTextAttributes;

-(void)navResetTitleColor:(UIColor *)color font:(UIFont *)font{
    
    NSDictionary *textAttributes = @{NSFontAttributeName : font, NSForegroundColorAttributeName : color};
    objc_setAssociatedObject(self, &keyNewTitleTextAttributes, textAttributes, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (self.navigationController) {
        [self tryRegisterOldTextAttributes];
        self.navigationController.navigationBar.titleTextAttributes = textAttributes;
    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIViewController exchangeSEL:@selector(viewWillAppear:) withSEL:@selector(SimpleNavigation_viewWillAppear:)];
        [UIViewController exchangeSEL:@selector(viewWillDisappear:) withSEL:@selector(SimpleNavigation_viewWillDisappear:)];
    });
}

-(NSDictionary *)newTitleTextAttributes{
    return objc_getAssociatedObject(self, &keyNewTitleTextAttributes);
}

-(NSDictionary *)oldTitleTextAttributes{
    return objc_getAssociatedObject(self, &keyOldTitleTextAttributes);
}

-(void)SimpleNavigation_viewWillDisappear:(BOOL)animated{
    [self SimpleNavigation_viewWillDisappear:animated];
    if (self.presentedViewController) {
        return;
    }
    [self.navigationController.navigationBar setTitleTextAttributes:self.oldTitleTextAttributes];
}

-(void)SimpleNavigation_viewWillAppear:(BOOL)animated{
    [self SimpleNavigation_viewWillAppear:animated];
    
    if (self.presentedViewController) {
        return;
    }
    
    [self tryRegisterOldTextAttributes];
    if (self.newTitleTextAttributes) {
        [self.navigationController.navigationBar setTitleTextAttributes:self.newTitleTextAttributes];
    }
}

-(void)tryRegisterOldTextAttributes{
    if (!registerOldTitleTextAttributes) {
        registerOldTitleTextAttributes = YES;
        objc_setAssociatedObject(self, &registerOldTitleTextAttributes, self.navigationController.navigationBar.titleTextAttributes, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

#pragma mark - 设置按钮

static char keyButtonTextColor;
static char keyButtonTextFont;

-(void)navResetButtonTextColor:(UIColor *)color font:(UIFont *)font{
    
    objc_setAssociatedObject(self, &keyButtonTextFont, font, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &keyButtonTextColor, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (self.navigationController) {
        __weak typeof(self) wself = self;
        [self.navLeftViews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [wself tryResetButtonTextColor:color font:font WithView:obj];
        }];
        [self.navRightViews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [wself tryResetButtonTextColor:color font:font WithView:obj];
        }];
    }
    
}

-(void)tryResetButtonTextColor:(UIColor *)color font:(UIFont *)font WithView:(UIView *)view{
    if ([view isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *)view;
        if (button.titleLabel.text) {
            button.titleLabel.font = font;
            [button setTitleColor:color forState:UIControlStateNormal];
        }
    }
}

-(instancetype)navSetupLeftBarButtonItem:(UIBarButtonItem *)barButtonItem{
    [self.navigationItem setLeftBarButtonItems:@[barButtonItem]];
    return self;
}

-(instancetype)navSetupRightBarButtonItem:(UIBarButtonItem *)barButtonItem{
    [self.navigationItem setRightBarButtonItems:@[barButtonItem]];
    return self;
}

/**
 *  设置按钮nav barbuttonitem
 */
-(instancetype)navSetupLeftButton:(UIButton *)button{
    return [self navSetupLeftBarButtonItem:[UIBarButtonItem barButtonItemWithButton:button]];
}
-(instancetype)navSetupRightButton:(UIButton *)button{
    return [self navSetupRightBarButtonItem:[UIBarButtonItem barButtonItemWithButton:button]];
}

/**
 *  设置图片nav barbuttonitem
 */
-(instancetype)navSetupLeftImageName:(NSString *)name action:(void (^)(void))action{
    return [self navSetupLeftImage:[UIImage imageNamed:name] action:action];
}
-(instancetype)navSetupRightImageName:(NSString *)name action:(void(^)(void))action{
    return [self navSetupRightImage:[UIImage imageNamed:name] action:action];
}
-(instancetype)navSetupLeftImage:(UIImage *)image action:(void (^)(void))action{
    return [self navSetupLeftButton:[self buttonWithImage:image action:action]];
}
-(instancetype)navSetupRightImage:(UIImage *)image action:(void (^)(void))action{
    return [self navSetupRightButton:[self buttonWithImage:image action:action]];
}

/**
 *  设置文字nav barbuttonitem
 */
-(instancetype)navSetupLeftTitle:(NSString *)title action:(void(^)(void))action{
    return [self navSetupLeftButton:[self buttonWithTitle:title action:action]];
}
-(instancetype)navSetupRightTitle:(NSString *)title action:(void(^)(void))action{
    return [self navSetupRightButton:[self buttonWithTitle:title action:action]];
}

/**
 *  设置间隔nav barbuttonitem
 */
-(instancetype)navSetupLeftSpaceWithWidth:(CGFloat)width{
    [self.navigationItem setLeftBarButtonItems:@[[UIBarButtonItem barButtonItemSpaceWithWidth:width]]];
    return self;
}
-(instancetype)navSetupRightSpaceWithWidth:(CGFloat)width{
    [self.navigationItem setRightBarButtonItems:@[[UIBarButtonItem barButtonItemSpaceWithWidth:width]]];
    return self;
}

-(instancetype)navAddLeftBarButtonItem:(UIBarButtonItem *)barButtonItem{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.navigationItem.leftBarButtonItems];
    [arr addObject:barButtonItem];
    [self.navigationItem setLeftBarButtonItems:arr];
    return self;
}

-(instancetype)navAddRightBarButtonItem:(UIBarButtonItem *)barButtonItem{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.navigationItem.rightBarButtonItems];
    [arr addObject:barButtonItem];
    [self.navigationItem setRightBarButtonItems:arr];
    return self;
}

/**
 *  添加按钮nav barbuttonitem
 */
-(instancetype)navAddLeftButton:(UIButton *)button{
    return [self navAddLeftBarButtonItem:[UIBarButtonItem barButtonItemWithButton:button]];

}
-(instancetype)navAddRightButton:(UIButton *)button{
    return [self navAddRightBarButtonItem:[UIBarButtonItem barButtonItemWithButton:button]];
}

/**
 *  添加图片nav barbuttonitem
 */
-(instancetype)navAddLeftImageName:(NSString *)name action:(void (^)(void))action{
    return [self navAddLeftImage:[UIImage imageNamed:name] action:action];
}
-(instancetype)navAddRightImageName:(NSString *)name action:(void(^)(void))action{
    return [self navAddRightImage:[UIImage imageNamed:name] action:action];
}
-(instancetype)navAddLeftImage:(UIImage *)image action:(void (^)(void))action{
    return [self navAddLeftButton:[self buttonWithImage:image action:action]];
}
-(instancetype)navAddRightImage:(UIImage *)image action:(void (^)(void))action{
    return [self navAddRightButton:[self buttonWithImage:image action:action]];
}

/**
 *  添加文字nav barbuttonitem
 */
-(instancetype)navAddLeftTitle:(NSString *)title action:(void(^)(void))action{
    return [self navAddLeftButton:[self buttonWithTitle:title action:action]];
}
-(instancetype)navAddRightTitle:(NSString *)title action:(void(^)(void))action{
    return [self navAddRightButton:[self buttonWithTitle:title action:action]];
}

/**
 *  添加间隔nav barbuttonitem
 */
-(instancetype)navAddLeftSpaceWithWidth:(CGFloat)width{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.navigationItem.leftBarButtonItems];
    [arr addObject:[UIBarButtonItem barButtonItemSpaceWithWidth:width]];
    [self.navigationItem setLeftBarButtonItems:arr];
    return self;
}
-(instancetype)navAddRightSpaceWithWidth:(CGFloat)width{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.navigationItem.rightBarButtonItems];
    [arr addObject:[UIBarButtonItem barButtonItemSpaceWithWidth:width]];
    [self.navigationItem setRightBarButtonItems:arr];
    return self;
}

-(UIButton *)buttonWithTitle:(NSString *)title action:(void(^)(void))action{
    UIButton *button = [UIButton buttonWithCenter:CGPointZero title:title textColor:objc_getAssociatedObject(self, &keyButtonTextColor) font:objc_getAssociatedObject(self, &keyButtonTextFont) click:action];
    return button;
}

-(UIButton *)buttonWithImage:(UIImage *)image action:(void(^)(void))action{
    return [UIButton buttonWithCenter:CGPointZero normalImage:image click:action];
}

#pragma mark - 配置

+(void)configViewControllerRectEdgeNoneForExtendedLayout{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIViewController exchangeSEL:@selector(viewDidLoad) withSEL:@selector(SimpleNavigation_viewDidLoad)];
    });
}

+(void)autoHidesBottomBarWhenPush{
    [UINavigationController autoHidesBottomBarWhenPush];
}


-(void)SimpleNavigation_viewDidLoad{
    if (self.navigationController) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self SimpleNavigation_viewDidLoad];
}

-(NSArray<UIView *> *)navLeftViews{
    NSMutableArray *views = [NSMutableArray arrayWithCapacity:self.navigationItem.leftBarButtonItems.count];
    [self.navigationItem.leftBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view = obj.customView;
        if (view) {
            [views addObject:view];
        }
    }];
    return [views copy];
}

-(NSArray<UIView *> *)navRightViews{
    NSMutableArray *views = [NSMutableArray arrayWithCapacity:self.navigationItem.rightBarButtonItems.count];
    [self.navigationItem.rightBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view = obj.customView;
        if (view) {
            [views addObject:view];
        }
    }];
    return [views copy];
}

@end
