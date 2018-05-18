//
//  UIImageView+WLSDImage.h
//  WLWidget
//
//  Created by 刘光强 on 2018/5/16.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (WLSDImage)

/**
 设置imageView的image
 
 @param urlStr image url
 @param placeholderImage 占位图
 */
- (void)setImageViewWithUrlStr:(NSString *)urlStr placeholderImage:(UIImage *)placeholderImage;
@end
