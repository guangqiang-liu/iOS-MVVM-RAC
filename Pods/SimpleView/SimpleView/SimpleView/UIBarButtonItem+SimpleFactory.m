//
//  UIBarButtonItem+SimpleFactory.m
//  SimpleView
//
//  Created by ileo on 16/4/27.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "UIBarButtonItem+SimpleFactory.h"
#import "NSObject+Block.h"

@implementation UIBarButtonItem (SimpleFactory)

+(UIBarButtonItem *)barButtonItemSpaceWithWidth:(CGFloat)width{
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = width;
    return space;
}

+(UIBarButtonItem *)barButtonItemWithButton:(UIButton *)button{
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

+(UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image action:(void (^)(void))action{
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:nil action:nil];
    [barButtonItem onlyHangdleUIBarButtonItemWithBlock:^(id sender) {
        if (action) {
            action();
        }
    }];
    return barButtonItem;
}

+(UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title action:(void (^)(void))action{
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:nil action:nil];
    [barButtonItem onlyHangdleUIBarButtonItemWithBlock:^(id sender) {
        if (action) {
            action();
        }
    }];
    return barButtonItem;
}

@end
