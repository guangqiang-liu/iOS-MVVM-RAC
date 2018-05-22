//
//  NSObject+Block.h
//  CarCare
//
//  Created by ileo on 14-10-14.
//  Copyright (c) 2014年 baozun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ActionUIControlBlock)(id sender);
typedef void (^ActionUIGestureRecognizerBlock)(id recognizer);
typedef void (^ActionUIBarButtonItemBlock)(id sender);

@interface NSObject (Block)

-(void)onlyHangdleUIControlEvent:(UIControlEvents)controlEvent withBlock:(ActionUIControlBlock)action;
-(void)onlyHangdleUIGestureRecognizerWithBlock:(ActionUIGestureRecognizerBlock)action;
-(void)onlyHangdleUIBarButtonItemWithBlock:(ActionUIBarButtonItemBlock)action;

@end
