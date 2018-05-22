//
//  NSString+CGSize.h
//  SimpleView
//
//  Created by ileo on 16/5/4.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (CGSize)

-(CGSize)sizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth;

@end
