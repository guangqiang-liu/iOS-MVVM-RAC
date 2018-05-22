//
//  UIViewController+BackButtonStyle.m
//  SimpleView
//
//  Created by ileo on 16/5/10.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "UIViewController+BackButtonStyle.h"
#import "SimpleViewHeader.h"
#import "NSObject+Block.h"
#import "UIView+Sizes.h"
#import "NSObject+Method.h"
#import "UINavigationController+BackButtonStyle.h"
#import <objc/runtime.h>

@interface UIViewController() <UIViewControllerBackButton>

@end

@implementation UIViewController (BackButtonStyle)

+(void)configViewControllerGesturePopBack{
    [UINavigationController configNavigationControllerGesturePopBack];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIViewController exchangeSEL:@selector(viewDidAppear:) withSEL:@selector(BackButtonStyle_viewDidAppear:)];
    });
}

-(void)BackButtonStyle_viewDidAppear:(BOOL)animated{
    [self BackButtonStyle_viewDidAppear:animated];
    if (self.navigationController) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

static NSDictionary *backItemStyles;

static char keyResetBackButtonBlock;
static char keyBackButtonClick;

static NSString *defaultBackItemStyle;

+(void)configBackItemStyles:(NSDictionary *)styles{
    [UINavigationController configViewControllerSetupDefaultBackButton];
    backItemStyles = styles;
}

+(void)configDefaultBackItemWithStyle:(NSString *)style{
    defaultBackItemStyle = style;
}

-(instancetype)navSetupBackItemWithStyle:(NSString *)style{
    return [self navSetupBackItem:backItemStyles[style]];
}

-(instancetype)navSetupBackItemWithStyle:(NSString *)style action:(void (^)(void))action{
    return [self navSetupBackItem:backItemStyles[style] action:action];
}

-(instancetype)navSetupBackItem:(BackItemModel *)item action:(void (^)(void))action{
    objc_setAssociatedObject(self, &keyBackButtonClick, action, OBJC_ASSOCIATION_COPY_NONATOMIC);
    return [self navSetupBackItem:item];
}

-(instancetype)navSetupBackItem:(BackItemModel *)item{
    if (self.navigationController) {
        [self resetBackItem:item];
    }else{
        [UINavigationController configViewControllerResetBackButton];
        __weak __typeof(self) wself = self;
        void (^ResetBackButtonBlock)(void) = ^(){
            [wself resetBackItem:item];
        };
        objc_setAssociatedObject(self, &keyResetBackButtonBlock, ResetBackButtonBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return self;
}

#pragma mark - backbutton
-(void)viewControllerResetBackButton{
    void (^ResetBackButtonBlock)(void) = objc_getAssociatedObject(self, &keyResetBackButtonBlock);
    if (ResetBackButtonBlock) {
        ResetBackButtonBlock();
    }
}

-(void)viewControllerSetupDefaultBackButton{
    if (defaultBackItemStyle) {
        [self navSetupBackItemWithStyle:defaultBackItemStyle];
    }
}

#pragma mark
-(void)resetBackItem:(BackItemModel *)model{
    
    if (self.navigationController.viewControllers.count < 2) {
        return;
    }
    
    NSMutableArray *tmp = [NSMutableArray arrayWithCapacity:3];
    if (model.offsetX != 0){
        [tmp addObject:[UIBarButtonItem barButtonItemSpaceWithWidth:model.offsetX]];
    }
    
    NSString *title = self.navLastTitle;
    if ([self respondsToSelector:@selector(navBackItemTitle)]) {
        title = [self performSelector:@selector(navBackItemTitle)];
    }
    __weak __typeof(self) wself = self;
    if (model.icon) {
        UIButton *button = [UIButton buttonWithCenter:CGPointZero normalImage:model.icon click:^{
            [wself clickOnBack];
        }];
        button.width = MAX(button.width, 30);
        button.height = MAX(button.height, 40);
        CGFloat iconWidth = model.imgWidth > 0 ? model.imgWidth : model.icon.size.width;
        CGFloat iconHeight = model.imgWidth > 0 ? model.imgHeight : model.icon.size.height;
        CGFloat gapWidth = MAX((button.width - iconWidth), 0);
        CGFloat gapHeight = MAX((button.height - iconHeight), 0);
        button.imageEdgeInsets = UIEdgeInsetsMake(gapHeight / 2, 0, gapHeight / 2,gapWidth);
        if (model.hasTitle) {
            UILabel *label = [[[UILabel labelWithFrame:CGRectMake(iconWidth + model.titleOffsetX, 0, 80, 50) font:model.titleFont text:title textColor:model.titleColor] labelResetTextAlignment:NSTextAlignmentLeft] setupOnView:button];
            label.centerY = button.height/2;
        }
        [tmp addObject:[UIBarButtonItem barButtonItemWithButton:button]];
    }else if (model.hasTitle) {
        [tmp addObject:[UIBarButtonItem barButtonItemWithButton:[UIButton buttonWithCenter:CGPointZero title:title textColor:model.titleColor font:model.titleFont click:^{
            [wself clickOnBack];
        }]]];
    }
    
    if (tmp.count > 0) {
        [self.navigationItem setLeftBarButtonItems:[tmp copy]];
    }
}

-(void)clickOnBack{
    if ([self respondsToSelector:@selector(navBackItemWillHandleClick)]) {
        [self navBackItemWillHandleClick];
    }
    void (^BackButtonClick)(void) = objc_getAssociatedObject(self, &keyBackButtonClick);
    if (BackButtonClick) {
        BackButtonClick();
    }else if ([self respondsToSelector:@selector(navClickOnBackItem)]) {
        [self performSelector:@selector(navClickOnBackItem)];
    }else if (self.NavClickOnBackItem) {
        self.NavClickOnBackItem();
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(NSString *)navLastTitle{
    if (self.navigationController && [self.navigationController.viewControllers containsObject:self]) {
        NSInteger index = [self.navigationController.viewControllers indexOfObject:self];
        if (index > 0) {
            return (self.navigationController.viewControllers[index - 1]).title;
        }
    }
    return nil;
}

#pragma mark -

static char kNavClickOnBackItem;
-(void (^)(void))NavClickOnBackItem{
    return objc_getAssociatedObject(self, &kNavClickOnBackItem);
}

-(void)setNavClickOnBackItem:(void (^)(void))NavClickOnBackItem{
    objc_setAssociatedObject(self, &kNavClickOnBackItem, NavClickOnBackItem, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

static char kCanGesturePopBack;
-(NSNumber *)canGesturePopBack{
    return objc_getAssociatedObject(self, &kCanGesturePopBack);
}
-(void)setCanGesturePopBack:(NSNumber *)canGesturePopBack{
    objc_setAssociatedObject(self, &kCanGesturePopBack, canGesturePopBack, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end

@implementation BackItemModel

+(BackItemModel *)modelWithOffsetX:(CGFloat)offsetX icon:(UIImage *)icon titleOffsetX:(CGFloat)titleOffsetX titleColor:(UIColor *)color titleFont:(UIFont *)font{
    BackItemModel *model = [[BackItemModel alloc] init];
    model.offsetX = offsetX;
    model.icon = icon;
    model.titleOffsetX = titleOffsetX;
    model.titleColor = color;
    model.titleFont = font;
    model.hasTitle = YES;
    return model;
}

+(BackItemModel *)modelWithOffsetX:(CGFloat)offsetX icon:(UIImage *)icon{
    BackItemModel *model = [[BackItemModel alloc] init];
    model.offsetX = offsetX;
    model.icon = icon;
    model.hasTitle = NO;
    return model;
}

@end
