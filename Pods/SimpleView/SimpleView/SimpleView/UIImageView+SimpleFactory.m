//
//  UIImageView+SimpleFactory.m
//  SimpleView
//
//  Created by ileo on 16/5/17.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "UIImageView+SimpleFactory.h"

@implementation UIImageView (SimpleFactory)

+(UIImageView *)imageViewWithFrame:(CGRect)frame image:(UIImage *)image{
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:frame];
    if (image) {
        imgV.image = image;
    }
    return imgV;
}

+(UIImageView *)imageViewWithCenter:(CGPoint)center image:(UIImage *)image{
    CGSize size = image.size;
    return [UIImageView imageViewWithFrame:CGRectMake(center.x - size.width / 2, center.y - size.height / 2, size.width, size.height) image:image];
}

+(UIImageView *)imageViewWithOriginal:(CGPoint)original image:(UIImage *)image{
    CGSize size = image.size;
    return [UIImageView imageViewWithFrame:CGRectMake(original.x, original.y, size.width, size.height) image:image];
}

-(UIImageView *)imageViewResetContentMode:(UIViewContentMode)contentMode{
    self.contentMode = contentMode;
    return self;
}

@end
