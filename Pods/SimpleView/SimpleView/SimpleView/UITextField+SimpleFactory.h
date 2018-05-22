//
//  UITextField+SimpleFactory.h
//  SimpleView
//
//  Created by ileo on 16/6/6.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (SimpleFactory)

/**
 *  工厂生产UITextField
 */
+(UITextField *)textFieldWithFrame:(CGRect)frame textColor:(UIColor *)color font:(UIFont *)font;

/**
 *  设置提示文字
 */
-(UITextField *)textFieldResetPlaceholder:(NSString *)placeholder;

/**
 *  设置键盘样式
 */
-(UITextField *)textFieldResetKeyboardType:(UIKeyboardType)keyboardType;

/**
 *  设置TextAlignment
 */
-(UITextField *)textFieldResetTextAlignment:(NSTextAlignment)textAlignment;


//#pragma mark - delegate
//
//-(void)handleDelegateShouldBeginEditing:(BOOL (^)())handle;
//-(void)handleDelegateDidBeginEditing:(void (^)())handle;
//-(void)handleDelegateShouldEndEditing:(BOOL (^)())handle;
//-(void)handleDelegateDidEndEditing:(void (^)())handle;
//-(void)handleDelegateShouldClear:(BOOL (^)())handle;
//-(void)handleDelegateShouldReturn:(BOOL (^)())handle;
//-(void)handleDelegateShouldChangeCharacters:(BOOL (^)(NSRange inRange, NSString *replacementString))handle;


@end
