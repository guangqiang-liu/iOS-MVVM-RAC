//
//  JsonExtend.m
//  carcareIOS
//
//  Created by ileo on 15/12/24.
//  Copyright © 2015年 baozun. All rights reserved.
//

#import "JsonExtend.h"

@implementation NSJSONSerialization (Extend)

+(NSString *)jsonValueWithObject:(id)object{
    NSMutableString *tmp = [NSMutableString stringWithString:[[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:object options:0 error:nil] encoding:NSUTF8StringEncoding]];
    return tmp;
}

@end

@implementation NSArray (Json)

-(NSString *)jsonValue{
    return [NSJSONSerialization jsonValueWithObject:self];
}

+(instancetype)arrayWithJsonValue:(NSString *)json{
    if (json && [json isKindOfClass:[NSString class]]) {
        return [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    }else{
        return nil;
    }
}

@end

@implementation NSDictionary (Json)

-(NSString *)jsonValue{
    return [NSJSONSerialization jsonValueWithObject:self];
}

+(instancetype)dictionaryWithJsonValue:(NSString *)json{
    if (json && [json isKindOfClass:[NSString class]]) {
        return [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    }else{
        return nil;
    }
}

@end
