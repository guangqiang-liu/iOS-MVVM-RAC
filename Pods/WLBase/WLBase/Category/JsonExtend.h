//
//  JsonExtend.h
//  carcareIOS
//
//  Created by ileo on 15/12/24.
//  Copyright © 2015年 baozun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSJSONSerialization (Extend)

+(NSString *)jsonValueWithObject:(id)object;

@end

@interface NSArray (Json)

-(NSString *)jsonValue;
+(instancetype)arrayWithJsonValue:(NSString *)json;

@end

@interface NSDictionary (Json)

-(NSString *)jsonValue;
+(instancetype)dictionaryWithJsonValue:(NSString *)json;

@end

