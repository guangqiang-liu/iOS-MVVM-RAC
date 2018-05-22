//
//  UIView+SimpleFactory.m
//  SimpleView
//
//  Created by ileo on 16/5/5.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "UIView+SimpleFactory.h"

@implementation UIView (SimpleFactory)

+(instancetype)viewWithFrame:(CGRect)frame{
    return [[[self class] alloc] initWithFrame:frame];
}

+(instancetype)viewWithCenter:(CGPoint)center size:(CGSize)size{
    return [[[self class] alloc] initWithFrame:CGRectMake(center.x - size.width / 2, center.y - size.height / 2, size.width, size.height)];
}

+(instancetype)viewWithCenterX:(CGFloat)centerX top:(CGFloat)top size:(CGSize)size{
    return [[[self class] alloc] initWithFrame:CGRectMake(centerX - size.width / 2, top, size.width, size.height)];
}

+(instancetype)viewWithRight:(CGFloat)right top:(CGFloat)top size:(CGSize)size{
    return [[[self class] alloc] initWithFrame:CGRectMake(right - size.width, top, size.width, size.height)];
}

-(instancetype)resetBackgroundColor:(UIColor *)color{
    self.backgroundColor = color;
    return self;
}

-(instancetype)resetTag:(NSInteger)tag{
    self.tag = tag;
    return self;
}

-(instancetype)setupOnView:(UIView *)view{
    [view addSubview:self];
    return self;
}

-(instancetype)resetBorderWidth:(CGFloat)width borderColor:(UIColor *)color{
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    return self;
}

-(instancetype)resetCornerRadius:(CGFloat)cornerRadius{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    return self;
}

-(instancetype)resetConfig:(void (^)(id))config{
    if (config) {
        config(self);
    }
    return self;
}

@end
