//
//  AlertMgr.m
//  WalletMerchant
//
//  Created by leo on 2017/2/17.
//  Copyright © 2017年 qianbao. All rights reserved.
//

#import "WLAlert.h"
#import "WalletBase.h"
#import "UIView+Animation.h"


typedef NS_ENUM(NSInteger, TAG){
    WAIT_VIEW = 170513,
    TOAST_VIEW = 170514,
    CUSTOM_VIEW = 170630,
};


@interface WLAlert ()

@property (nonatomic, strong) UIWindow *customWindow;

@end

@implementation WLAlert


#pragma mark - config

Class<WLAlertAnimation> Animation;
+(void)configAnimation:(Class<WLAlertAnimation>)animation{
    Animation = animation;
}

#pragma mark - waiting

NSInteger waitingTime = 0;

+(void)showWaiting{
    waitingTime ++;
    
    if (waitingTime == 1) {
        
        UIView *bgView = [[[UIView viewWithFrame:__MAIN_BOUND] resetBackgroundColor:[UIColor clearColor]] setupOnView:[UIViewController mainWindow]];
        bgView.tag = WAIT_VIEW;
        
        UIView *view;
        if (Animation && [Animation respondsToSelector:@selector(waitingAnimation)]) {
            view = [Animation waitingAnimation];
        }else{
            view = [UIView viewWithFrame:CGRectMake(__MAIN_WIDTH/2 - 30, __MAIN_HEIGHT/2 - 30, 60, 60)];
            view.layer.cornerRadius = 5;
            view.backgroundColor = [UIColor colorWithWhite:0.3 alpha:1.0];
            //            [view resetBorderWidth:0.1 borderColor:[UIColor whiteColor]];
            //            view.layer.shadowColor = [UIColor whiteColor].CGColor;
            //            view.layer.shadowOpacity = 1;
            //            view.layer.shadowOffset = CGSizeMake(0, 0);
            
            UIActivityIndicatorView *wait = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            wait.center = view.boundsCenter;
            [view addSubview:wait];
            [wait startAnimating];
        }
        [bgView addSubview:view];
        [view addAnimationLightenOutFinish:nil];
    }
    
}

+(void)dismissWaiting{
    if (waitingTime > 0) waitingTime --;
    if (waitingTime == 0) {
        for (UIView *view in [UIViewController mainWindow].subviews) {
            if (view.tag == WAIT_VIEW) {
                __weak typeof(view) wView = view;
                [view addAnimationDieOutFinish:^{
                    [wView removeFromSuperview];
                }];
            }
        }
    }
}

#pragma mark - toast

+(void)showToastTextTips:(NSString *)tips status:(Toast_Status)status time:(NSInteger)time{
    
    UIView *bgView = [[[UIView viewWithFrame:__MAIN_BOUND] resetBackgroundColor:[UIColor clearColor]] setupOnView:[UIViewController mainWindow]];
    bgView.tag = TOAST_VIEW;
    
    UIView *view;
    
    if (Animation && [Animation respondsToSelector:@selector(toastViewWithTips:status:)]) {
        view = [Animation toastViewWithTips:tips status:status];
    }else{
        view = [UIView viewWithFrame:CGRectMake(__MAIN_WIDTH/2 - 25, __MAIN_HEIGHT/2 - 25, 50, 50)];
        view.layer.cornerRadius = 5;
        view.backgroundColor = [UIColor colorWithWhite:0.3 alpha:1];
        //        [view resetBorderWidth:0.1 borderColor:[UIColor whiteColor]];
        //        view.layer.shadowColor = [UIColor whiteColor].CGColor;
        //        view.layer.shadowOpacity = 1;
        //        view.layer.shadowOffset = CGSizeMake(0, 0);
        
        CGFloat gap = 9;
        CGFloat height = gap;
        CGFloat width = 50;
        
        NSInteger tagLabel = 49;
        
        UIFont *font = FONT_SYSTEM_Light(14);
        CGSize size = [tips sizeWithFont:font maxWidth:200];
        UILabel *alabel = [[UILabel labelWithFrame:CGRectMake(0, 0, size.width, size.height) font:font text:tips textColor:[UIColor whiteColor]] setupOnView:view];
        alabel.textAlignment = NSTextAlignmentCenter;
        alabel.numberOfLines = 0;
        alabel.top = height;
        alabel.tag = tagLabel;
        height += alabel.height + 5;
        if (alabel.width > width) width = alabel.width;
        
        view.width = width + 5 * gap;
        view.height = height + gap;
        view.center = bgView.boundsCenter;
        
        for (UIView *aView in view.subviews) {
            if (aView.tag == tagLabel) {
                aView.centerX = view.width / 2;
                aView.centerY = view.height / 2 - 1;
            }
        }
    }
    
    [bgView addSubview:view];
    [view addAnimationLightenOutFinish:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [view addAnimationDieOutFinish:^{
            [bgView removeFromSuperview];
        }];
    });
    
}

+(void)showToastTextTips:(NSString *)tips time:(NSInteger)time{
    [self showToastTextTips:tips status:Toast_Normal time:time];
}

+(void)showToastTextTips:(NSString *)tips{
    //商家提示需要3秒   其他客户端提示1.5秒
    NSString *bundleId = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    if ([bundleId isEqualToString:@"com.qianbao.merchantappfortest"] || [bundleId isEqualToString:@"com.qianbao.merchantApp"]) {
        [self showToastTextTips:tips time:3];
    } else {
        [self showToastTextTips:tips time:1.5];
    }
}


#pragma mark - custom

BOOL isShowCustomView = NO;
+(void)showCustomView:(UIView *)view{
    
    if (isShowCustomView) {
        return;
    }
    isShowCustomView = YES;
    UIView *bgView = [[[UIView viewWithFrame:__MAIN_BOUND] resetBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.6]] setupOnView:[UIViewController mainWindow]];
    bgView.tag = CUSTOM_VIEW;
    [bgView addSubview:view];
    [view addAnimationLightenOutFinish:nil];
    
    [[RACObserve([UIViewController mainWindow], rootViewController) takeUntil:bgView.rac_willDeallocSignal] subscribeNext:^(id x) {
        [[UIViewController mainWindow] bringSubviewToFront:bgView];
    }];
}
+(void)showOnlyCustomView:(UIView *)view{
    if (isShowCustomView) {
        return;
    }
    isShowCustomView = YES;
    [[UIViewController mainWindow] addSubview:view];
    view.tag = CUSTOM_VIEW;
    [view addAnimationLightenOutFinish:nil];
    
    [[RACObserve([UIViewController mainWindow], rootViewController) takeUntil:view.rac_willDeallocSignal] subscribeNext:^(id x) {
        [[UIViewController mainWindow] bringSubviewToFront:view];
    }];
}

+(void)dismissCustomView{
    for (UIView *view in [UIViewController mainWindow].subviews) {
        if (view.tag == CUSTOM_VIEW) {
            __weak typeof(view) wView = view;
            [view addAnimationDieOutFinish:^{
                [wView removeFromSuperview];
            }];
        }
    }
    isShowCustomView = NO;
}

#pragma mark - window

-(UIWindow *)createWindow{
    UIWindow *window = [[UIWindow alloc] initWithFrame:__MAIN_BOUND];
    window.rootViewController = [[UIViewController alloc] init];
    window.rootViewController.view.backgroundColor = [UIColor clearColor];
    [window.rootViewController.view endEditing:YES];
    NSArray * windows = [[UIApplication sharedApplication]windows];
    UIWindow * lastWindow = (UIWindow *)[windows lastObject];
    window.windowLevel = lastWindow.windowLevel + 1;
    window.backgroundColor = [UIColor clearColor];
    return window;
}


@end

