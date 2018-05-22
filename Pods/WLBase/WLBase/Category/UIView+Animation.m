//
//  UIView+Animation.m
//  CarCare
//
//  Created by ileo on 14/11/5.
//  Copyright (c) 2014年 baozun. All rights reserved.
//

#import "UIView+Animation.h"
#import "NSTimer+Blocks.h"

#define MoveUpTime 0.07

@implementation UIView (Animation)

-(void)addAnimationLightenOutFinish:(void (^)(void))finish{
    CFTimeInterval duration = 0.15;
    CAAnimation *scale = [CAKeyframeAnimation animationType:ANIMATION_SCALE Values:@[@0.98,@1.03,@1] duration:duration];
    [self.layer addAnimation:scale forKey:[NSString stringWithFormat:@"scale"]];
    [NSTimer scheduledTimerWithTimeInterval:duration - MoveUpTime block:^{
        if (finish) finish();
    } repeats:NO];
}

-(void)addAnimationDieOutFinish:(void (^)(void))finish{
    CFTimeInterval duration = 0.2;
    CAAnimation *scale = [CAKeyframeAnimation animationType:ANIMATION_SCALE Values:@[@1,@1.05,@0.8] duration:duration];
    CAAnimation *opacity = [CAKeyframeAnimation animationType:ANIMATION_OPACITY Values:@[@0.6,@0] duration:duration];
    [self.layer addAnimation:scale forKey:@"scale"];
    [self.layer addAnimation:opacity forKey:@"opacity"];
    [NSTimer scheduledTimerWithTimeInterval:duration - MoveUpTime block:^{
        if (finish) finish();
    } repeats:NO];
}

-(void)addAnimationFadeInToAlpha:(CGFloat)alpha Finish:(void (^)(void))finish{
    CFTimeInterval duration = 0.15;
    CAAnimation *opacity = [CAKeyframeAnimation animationType:ANIMATION_OPACITY Values:@[@0,@(alpha)] duration:duration];
    [self.layer addAnimation:opacity forKey:[NSString stringWithFormat:@"opacity"]];
    [NSTimer scheduledTimerWithTimeInterval:duration - MoveUpTime block:^{
        if (finish) finish();
    } repeats:NO];
}

-(void)addAnimationFadeOutFromAlpha:(CGFloat)alpha Finish:(void (^)(void))finish{
    CFTimeInterval duration = 0.15;
    CAAnimation *opacity = [CAKeyframeAnimation animationType:ANIMATION_OPACITY Values:@[@(alpha),@0] duration:duration];
    [self.layer addAnimation:opacity forKey:[NSString stringWithFormat:@"opacity"]];
    [NSTimer scheduledTimerWithTimeInterval:duration - MoveUpTime block:^{
        if (finish) finish();
    } repeats:NO];
}

@end
