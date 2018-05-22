//
//  UILabel+SimpleFactory.m
//  SimpleView
//
//  Created by ileo on 16/5/4.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "UILabel+SimpleFactory.h"
#import "NSString+CGSize.h"

@implementation UILabel (SimpleFactory)

+(UILabel *)labelWithFrame:(CGRect)frame font:(UIFont *)font text:(NSString *)text textColor:(UIColor *)textColor{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    if (font) label.font = font;
    if (text) [label setText:text];
    if (textColor) label.textColor = textColor;
    return label;
}

+(UILabel *)labelWithCenter:(CGPoint)center font:(UIFont *)font text:(NSString *)text textColor:(UIColor *)textColor{
    CGSize size = [text sizeWithFont:font maxWidth:300];
    return [UILabel labelWithFrame:CGRectMake(center.x - size.width / 2, center.y - size.height/2, size.width, size.height) font:font text:text textColor:textColor];
}

-(UILabel *)labelResetTextAlignment:(NSTextAlignment)textAlignment{
    self.textAlignment = textAlignment;
    return self;
}

-(UILabel *)labelResetNumberOfLines:(NSInteger)lines{
    self.numberOfLines = lines;
    return self;
}

-(UILabel *)labelResetAttributedText:(NSAttributedString *)attributedText{
    self.attributedText = attributedText;
    return self;
}

@end
