//
//  NSObject+Method.h
//  SimpleView
//
//  Created by ileo on 16/7/19.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Method)

@property (nonatomic, copy) id tagObject_copy;//用于区分，存值，copy
@property (nonatomic, strong) id tagObject_strong;//用于区分，存值，strong

+(void)exchangeSEL:(SEL)sel1 withSEL:(SEL)sel2;
+(void)exchangeClassSEL:(SEL)sel1 withClassSEL:(SEL)sel2;

@end
