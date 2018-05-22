//
//  WLModal.m
//  WLModalComponent
//
//  Created by 刘光强 on 2018/5/8.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import "WLModal.h"
#import <QuartzCore/QuartzCore.h>

const static CGFloat kCustomIOSAlertViewDefaultButtonHeight = 50; // 按钮高度
const static CGFloat kCustomIOSAlertViewDefaultButtonSpacerHeight = 1; // 分隔线宽度
const static CGFloat kCustomIOSAlertViewCornerRadius = 12; // 圆角半径

@interface WLModal()

@property (nonatomic, copy) NSArray *buttonTitleColorArray;
@end

@implementation WLModal

CGFloat buttonHeight = 1;
CGFloat buttonSpacerHeight = 1;

@synthesize containerView, dialogView, onButtonTouchUpInside;
@synthesize buttonTitles;

- (id)init {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        // 必须调用此方法监听设备旋转才有效
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        // 监听设备旋转
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
        // 监听键盘出现
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        // 监听键盘消失
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        self.buttonTitleColorArray = @[HexRGB(0x999999), HexRGB(0xFF4B4A)];
    }
    return self;
}

// 创建并显示提示视图
- (void)show {
    // 创建提示视图
    dialogView = [self createContainerView];
    // layer光栅化，提高性能
    dialogView.layer.shouldRasterize = YES;
    dialogView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    self.backgroundColor = RGBAlpha(0, 0, 0, 0);
    [self addSubview:dialogView];
    
    // iOS7, 旋转方向调整
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
        UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
        switch (interfaceOrientation) {
            case UIInterfaceOrientationLandscapeLeft:
                self.transform = CGAffineTransformMakeRotation(M_PI * 270.0 / 180.0);
                break;
            case UIInterfaceOrientationLandscapeRight:
                self.transform = CGAffineTransformMakeRotation(M_PI * 90.0 / 180.0);
                break;
            case UIInterfaceOrientationPortraitUpsideDown:
                self.transform = CGAffineTransformMakeRotation(M_PI * 180.0 / 180.0);
                break;
            default:
                break;
        }
        [self setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        // iOS8, 仅把提示视图居中即可
    } else {
        CGSize screenSize = [self countScreenSize];
        CGSize dialogSize = [self countDialogSize];
        CGSize keyboardSize = CGSizeMake(0, 0);
        dialogView.frame = CGRectMake((screenSize.width - dialogSize.width) / 2, (screenSize.height - keyboardSize.height - dialogSize.height) / 2, dialogSize.width, dialogSize.height);
    }
    
//    [[[[UIApplication sharedApplication] windows] firstObject] addSubview:self];
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    
    dialogView.layer.opacity = 0.5f;
    dialogView.layer.transform = CATransform3DMakeScale(1.3f, 1.3f, 1.0);
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.backgroundColor = RGBAlpha(0, 0, 0, 0.3);
                         dialogView.layer.opacity = 1.0f;
                         dialogView.layer.transform = CATransform3DMakeScale(1, 1, 1);
                     }
                     completion:NULL
     ];
}

- (void)buttonAction:(id)sender {
    if (onButtonTouchUpInside != NULL) {
        onButtonTouchUpInside(self, (NSInteger)[sender tag]);
    }
}

// 提示视图关闭并移除
- (void)close {
    CATransform3D currentTransform = dialogView.layer.transform;
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
        CGFloat startRotation = [[dialogView valueForKeyPath:@"layer.transform.rotation.z"] floatValue];
        CATransform3D rotation = CATransform3DMakeRotation(-startRotation + M_PI * 270.0 / 180.0, 0.0f, 0.0f, 0.0f);
        dialogView.layer.transform = CATransform3DConcat(rotation, CATransform3DMakeScale(1, 1, 1));
    }
    dialogView.layer.opacity = 1.0f;
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionNone
     animations:^{
         self.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f];
         dialogView.layer.transform = CATransform3DConcat(currentTransform, CATransform3DMakeScale(0.6f, 0.6f, 1.0));
         dialogView.layer.opacity = 0.0f;
     } completion:^(BOOL finished) {
         for (UIView *v in [self subviews]) {
             [v removeFromSuperview];
         }
         [self removeFromSuperview];
     }
 ];
}

- (void)addContentView:(UIView *)subView {
    containerView = subView;
}

// 创建提示视图
- (UIView *)createContainerView {
    if (containerView == NULL) {
        containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 150)];
    }
    CGSize screenSize = [self countScreenSize];
    CGSize dialogSize = [self countDialogSize];
    [self setFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
    
    // 提示视图
    UIView *dialogContainer = [[UIView alloc] initWithFrame:CGRectMake((screenSize.width - dialogSize.width) / 2, (screenSize.height - dialogSize.height) / 2, dialogSize.width, dialogSize.height)];
    
    // 设置阴影和圆角
//    CAGradientLayer *gradient = [CAGradientLayer layer];
//    gradient.frame = dialogContainer.bounds;
//    gradient.colors = [NSArray arrayWithObjects:
//                       (id)[[UIColor colorWithRed:218.0/255.0 green:218.0/255.0 blue:218.0/255.0 alpha:1.0f] CGColor],
//                       (id)[[UIColor colorWithRed:233.0/255.0 green:233.0/255.0 blue:233.0/255.0 alpha:1.0f] CGColor],
//                       (id)[[UIColor colorWithRed:218.0/255.0 green:218.0/255.0 blue:218.0/255.0 alpha:1.0f] CGColor],
//                       nil];
//    CGFloat cornerRadius = kCustomIOSAlertViewCornerRadius;
//    gradient.cornerRadius = cornerRadius;
//
//    [dialogContainer.layer insertSublayer:gradient atIndex:0];
//    dialogContainer.layer.cornerRadius = cornerRadius;
//    dialogContainer.layer.shadowRadius = cornerRadius + 5;
//    dialogContainer.layer.shadowOpacity = 0.1f;
//    dialogContainer.layer.shadowOffset = CGSizeMake(0 - (cornerRadius+5)/2, 0 - (cornerRadius+5)/2);
//    dialogContainer.layer.shadowColor = [UIColor blackColor].CGColor;
//    dialogContainer.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:dialogContainer.bounds cornerRadius:dialogContainer.layer.cornerRadius].CGPath;
    
    // 分隔线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, dialogContainer.bounds.size.height - buttonHeight - buttonSpacerHeight, dialogContainer.bounds.size.width, buttonSpacerHeight)];
    lineView.backgroundColor = sepLineColor;
    [dialogContainer addSubview:lineView];
    // 添加内容视图
    [dialogContainer addSubview:containerView];
    
    [self addButtonsToView:dialogContainer];
    
    return dialogContainer;
}

// 添加按钮
- (void)addButtonsToView: (UIView *)container {
    if (buttonTitles == NULL) return;
    CGFloat buttonWidth = container.bounds.size.width / buttonTitles.count;
    for (int i = 0; i < buttonTitles.count; i++) {
        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeButton setFrame:CGRectMake(i * buttonWidth, container.bounds.size.height - buttonHeight, buttonWidth, buttonHeight)];
        [closeButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [closeButton setTag:i];
        [closeButton setTitle:buttonTitles[i] forState:UIControlStateNormal];
        [closeButton setTitleColor:self.buttonTitleColorArray[i] forState:UIControlStateNormal];
        closeButton.titleLabel.font = H16;
        closeButton.backgroundColor = white_color;
        
        // 设置第一个和最后一个按钮的圆角
        if (buttonTitles.count > 1) {
            if (i == 0) {
                [closeButton drawCornersWithCorners:UIRectCornerBottomLeft cornerRadii:CGSizeMake(12, 12)];
            } else if (i == buttonTitles.count - 1) {
                [closeButton drawCornersWithCorners:UIRectCornerBottomRight cornerRadii:CGSizeMake(12, 12)];
            }
        } else {
            [closeButton drawCornersWithCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(12, 12)];
        }
    
        [container addSubview:closeButton];
        if (i > 0) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(i * buttonWidth, container.bounds.size.height - buttonHeight, kCustomIOSAlertViewDefaultButtonSpacerHeight, buttonHeight)];
            lineView.backgroundColor = sepLineColor;
            [container addSubview:lineView];
        }
    }
}

// 提示视图的size
- (CGSize)countDialogSize {
    CGFloat dialogWidth = containerView.frame.size.width;
    CGFloat dialogHeight = containerView.frame.size.height + buttonHeight + buttonSpacerHeight;
    return CGSizeMake(dialogWidth, dialogHeight);
}

// 屏幕的size
- (CGSize)countScreenSize {
    if (buttonTitles != NULL && [buttonTitles count] > 0) {
        buttonHeight = kCustomIOSAlertViewDefaultButtonHeight;
        buttonSpacerHeight = kCustomIOSAlertViewDefaultButtonSpacerHeight;
    } else {
        buttonHeight = 0;
        buttonSpacerHeight = 0;
    }
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    // iOS7, 屏幕的宽高不会随着方向自动调整
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
        UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
        if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
            CGFloat tmp = screenWidth;
            screenWidth = screenHeight;
            screenHeight = tmp;
        }
    }
    return CGSizeMake(screenWidth, screenHeight);
}

// 设备旋转
- (void)deviceOrientationDidChange: (NSNotification *)notification {
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
        [self changeOrientationForIOS7];
    } else {
        [self changeOrientationForIOS8:notification];
    }
}

// 设备旋转（iOS7）
- (void)changeOrientationForIOS7 {
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    CGFloat startRotation = [[self valueForKeyPath:@"layer.transform.rotation.z"] floatValue];
    CGAffineTransform rotation;
    switch (interfaceOrientation) {
        case UIInterfaceOrientationLandscapeLeft:
            rotation = CGAffineTransformMakeRotation(-startRotation + M_PI * 270.0 / 180.0);
            break;
        case UIInterfaceOrientationLandscapeRight:
            rotation = CGAffineTransformMakeRotation(-startRotation + M_PI * 90.0 / 180.0);
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            rotation = CGAffineTransformMakeRotation(-startRotation + M_PI * 180.0 / 180.0);
            break;
        default:
            rotation = CGAffineTransformMakeRotation(-startRotation + 0.0);
            break;
    }
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         dialogView.transform = rotation;
                     }
                     completion:nil
     ];
}

// 设备旋转（iOS8）
- (void)changeOrientationForIOS8: (NSNotification *)notification {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         CGSize dialogSize = [self countDialogSize];
                         CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
                         self.frame = CGRectMake(0, 0, screenWidth, screenHeight);
                         dialogView.frame = CGRectMake((screenWidth - dialogSize.width) / 2, (screenHeight - keyboardSize.height - dialogSize.height) / 2, dialogSize.width, dialogSize.height);
                     }
                     completion:nil
     ];
}

// 键盘出现
- (void)keyboardWillShow: (NSNotification *)notification {
    CGSize screenSize = [self countScreenSize];
    CGSize dialogSize = [self countDialogSize];
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (UIInterfaceOrientationIsLandscape(interfaceOrientation) && NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) {
        CGFloat tmp = keyboardSize.height;
        keyboardSize.height = keyboardSize.width;
        keyboardSize.width = tmp;
    }
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         dialogView.frame = CGRectMake((screenSize.width - dialogSize.width) / 2, (screenSize.height - keyboardSize.height - dialogSize.height) / 2, dialogSize.width, dialogSize.height);
                     }
                     completion:nil
     ];
}

// 键盘消失
- (void)keyboardWillHide: (NSNotification *)notification {
    CGSize screenSize = [self countScreenSize];
    CGSize dialogSize = [self countDialogSize];
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         dialogView.frame = CGRectMake((screenSize.width - dialogSize.width) / 2, (screenSize.height - dialogSize.height) / 2, dialogSize.width, dialogSize.height);
                     }
                     completion:nil
     ];
}

- (void)dealloc {
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

@end
