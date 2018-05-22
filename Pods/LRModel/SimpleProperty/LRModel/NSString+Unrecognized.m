//
//  NSString+Unrecognized.m
//  SimpleProperty
//
//  Created by leo on 2017/3/4.
//  Copyright © 2017年 ileo. All rights reserved.
//

#import "NSString+Unrecognized.h"

@implementation NSString (Unrecognized)

-(char)charValue{
    return [self boolValue];
}

@end
