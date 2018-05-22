//
//  UIButton+SimpleFactory.m
//  SimpleView
//
//  Created by ileo on 16/4/11.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "UIButton+SimpleFactory.h"
#import "NSObject+Block.h"
#import "NSString+CGSize.h"
#import "UIView+Sizes.h"

@implementation UIButton (SimpleFactory)

#pragma mark - 图片按钮

+(UIButton *)buttonWithFrame:(CGRect)frame normalImage:(UIImage *)normalImg click:(void (^)(void))click{
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    if (normalImg) {
        [button setImage:normalImg forState:UIControlStateNormal];
        [button setImage:normalImg forState:UIControlStateHighlighted];
    }
    [button setExclusiveTouch:YES];
    if (click) [button onlyHangdleUIControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
        click();
    }];
    return button;
}

+(UIButton *)buttonWithCenter:(CGPoint)center normalImage:(UIImage *)normalImg click:(void (^)(void))click{
    UIButton *button = [UIButton buttonWithFrame:CGRectMake(center.x - normalImg.size.width / 2, center.y - normalImg.size.height / 2, normalImg.size.width, normalImg.size.height) normalImage:normalImg click:click];
    button.width = MAX(button.width, 30);
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 11) {
        CGFloat gapWidth = MAX((button.width - normalImg.size.width), 0);
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, gapWidth);
    }
    return button;
}

-(UIButton *)buttonAddHighlightedImage:(UIImage *)highlightedImg{
    [self setImage:highlightedImg forState:UIControlStateHighlighted];
    return self;
}

#pragma mark - 文字按钮

+(UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title textColor:(UIColor *)textColor font:(UIFont *)font click:(void (^)(void))click{
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    if(title){
        [button setTitle:title forState:UIControlStateNormal];
    }
    [button setExclusiveTouch:YES];
    if (font) button.titleLabel.font = font;
    if (textColor) [button setTitleColor:textColor forState:UIControlStateNormal];
    if (click) [button onlyHangdleUIControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
        click();
    }];
    return button;
}

-(UIButton *)buttonAddHighlightedTitle:(NSString *)title textColor:(UIColor *)textColor{
    [self setTitle:title forState:UIControlStateHighlighted];
    if (textColor) [self setTitleColor:textColor forState:UIControlStateHighlighted];
    return self;
}

+(UIButton *)buttonWithCenter:(CGPoint)center title:(NSString *)title textColor:(UIColor *)textColor font:(UIFont *)font click:(void (^)(void))click{
    font = !font ? [UIFont systemFontOfSize:[UIFont systemFontSize]] : font;
    CGSize size = [title sizeWithFont:font maxWidth:300];
    return [UIButton buttonWithFrame:CGRectMake(center.x - size.width / 2, center.y - size.height / 2, size.width + 10, size.height) title:title textColor:textColor font:font click:click];
}

#pragma mark - 空按钮

+(UIButton *)buttonEmptyWithFrame:(CGRect)frame click:(void (^)(void))click{
    return [UIButton buttonWithFrame:frame title:nil textColor:nil font:nil click:click];
}

@end
