//
//  CAKeyframeAnimation+Simple.h
//  WalletMerchant
//
//  Created by leo on 2017/2/20.
//  Copyright © 2017年 qianbao. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

extern NSString * const ANIMATION_SCALE;
extern NSString * const ANIMATION_OPACITY;

@interface CAKeyframeAnimation (Simple) 

+(CAKeyframeAnimation *)animationType:(NSString *)type Values:(NSArray *)values duration:(NSTimeInterval)duration;


@end

