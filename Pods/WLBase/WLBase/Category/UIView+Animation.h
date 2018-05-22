//
//  UIView+Animation.h
//  CarCare
//
//  Created by ileo on 14/11/5.
//  Copyright (c) 2014年 baozun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CAKeyframeAnimation+Simple.h"

@interface UIView (Animation)

-(void)addAnimationLightenOutFinish:(void(^)(void))finish;
-(void)addAnimationDieOutFinish:(void(^)(void))finish;

-(void)addAnimationFadeInToAlpha:(CGFloat)alpha Finish:(void(^)(void))finish;
-(void)addAnimationFadeOutFromAlpha:(CGFloat)alpha Finish:(void(^)(void))finish;

@end
