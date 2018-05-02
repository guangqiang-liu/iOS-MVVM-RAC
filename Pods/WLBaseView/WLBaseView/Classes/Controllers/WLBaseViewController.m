//
//  WLBaseViewController.m
//  WLBaseView_Example
//
//  Created by 刘光强 on 2018/3/15.
//  Copyright © 2018年 guangqiang-liu. All rights reserved.
//

#import "WLBaseViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define kNavTitleColor UIColorFromRGB(0x333333)
#define kBgColor UIColorFromRGB(0xEEEEEE)

@interface WLBaseViewController ()

@property (nonatomic, getter=isViewAppeared) BOOL viewAppeared;

@end

@implementation WLBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initialize];
}

- (void)initialize {
    self.edgesForExtendedLayout = UIRectEdgeLeft | UIRectEdgeRight;
    self.navigationBarHidden = NO;
    self.toolbarHidden = YES;
    self.titleColor = kNavTitleColor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kBgColor;
    
    if (! self.view.backgroundColor || [self.view.backgroundColor isEqual:[UIColor clearColor]]) {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    
    if (!self.hiddenLeftBarBtn) {
        [self setNavigationItemBackItem];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.toolbarHidden = self.toolbarHidden;
    self.navigationController.navigationBarHidden = self.navigationBarHidden;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.viewAppeared = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.viewAppeared = NO;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:titleColor, NSFontAttributeName: [UIFont systemFontOfSize:17.0f]};
}

- (void)setNavigationBarImage:(UIImage *)navigationBarImage {
    _navigationBarImage = navigationBarImage;
//    [self.navigationController setNavigationBackgroundImage:navigationBarImage];
}

- (void)setStatusBarStyle:(StatusBarStyle)statusBarStyle {
    _statusBarStyle = statusBarStyle;
    if (statusBarStyle == StatusBarStyleWhite) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    } else {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
}

- (void)setNavigationBarHidden:(BOOL)navigationBarHidden {
    _navigationBarHidden = navigationBarHidden;
    if (self.isViewLoaded) {
        [self.navigationController setNavigationBarHidden:_navigationBarHidden];
    }
}

- (void)setToolbarHidden:(BOOL)toolbarHidden {
    _toolbarHidden = toolbarHidden;
    if (self.isViewLoaded) {
        [self.navigationController setToolbarHidden:_toolbarHidden];
    }
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
