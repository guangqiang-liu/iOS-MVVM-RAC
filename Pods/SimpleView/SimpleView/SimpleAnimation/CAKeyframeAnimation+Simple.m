//
//  CAKeyframeAnimation+Simple.m
//  WalletMerchant
//
//  Created by leo on 2017/2/20.
//  Copyright © 2017年 qianbao. All rights reserved.
//

#import "CAKeyframeAnimation+Simple.h"

NSString * const ANIMATION_SCALE = @"transform.scale";
NSString * const ANIMATION_OPACITY = @"opacity";

@implementation CAKeyframeAnimation (Simple)


+(CAKeyframeAnimation *)animationType:(NSString *)type Values:(NSArray *)values duration:(NSTimeInterval)duration{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:type];
    animation.duration = duration;
    animation.values = values;
    return animation;
}



@end
