//
//  NSObject+Block.m
//  CarCare
//
//  Created by ileo on 14-10-14.
//  Copyright (c) 2014年 baozun. All rights reserved.
//

#import "NSObject+Block.h"
#import <objc/runtime.h>

@implementation NSObject (Block)

static char overviewKey;

#pragma mark - UIControl
-(void)onlyHangdleUIControlEvent:(UIControlEvents)controlEvent withBlock:(ActionUIControlBlock)action{
    objc_setAssociatedObject(self, &overviewKey, action, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [(UIControl *)self addTarget:self action:@selector(callUIControlActionBlock:) forControlEvents:controlEvent];
}

- (void)callUIControlActionBlock:(id)sender {
    ActionUIControlBlock block = (ActionUIControlBlock)objc_getAssociatedObject(self, &overviewKey);
    if (block) {
        block(sender);
    }
}

#pragma mark - UIGestureRecognizer
-(void)onlyHangdleUIGestureRecognizerWithBlock:(ActionUIControlBlock)action{
    objc_setAssociatedObject(self, &overviewKey, action, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [((UIGestureRecognizer *)self) addTarget:self action:@selector(callUIGestureRecognizerActionBlock:)];
}

-(void)callUIGestureRecognizerActionBlock:(id)recognizer{
    ActionUIControlBlock block = (ActionUIControlBlock)objc_getAssociatedObject(self, &overviewKey);
    if (block) {
        block(recognizer);
    }
}

#pragma mark - UIBarButtonItem
-(void)onlyHangdleUIBarButtonItemWithBlock:(ActionUIBarButtonItemBlock)action{
    objc_setAssociatedObject(self, &overviewKey, action, OBJC_ASSOCIATION_COPY_NONATOMIC);
    ((UIBarButtonItem *)self).target = self;
    ((UIBarButtonItem *)self).action = @selector(callUIBarButtonItemActionBlock:);
}

- (void)callUIBarButtonItemActionBlock:(id)sender {
    ActionUIBarButtonItemBlock block = (ActionUIBarButtonItemBlock)objc_getAssociatedObject(self, &overviewKey);
    if (block) {
        block(sender);
    }
}

@end
