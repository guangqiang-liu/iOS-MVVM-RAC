//
//  ValuePropertyObject.h
//  SimpleProperty
//
//  Created by ileo on 16/9/8.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Property.h"
#import "NSString+Unrecognized.h"


@class LRModel;

@protocol LRModelDelegate <NSObject>

@optional
#pragma mark - 赋值
-(BOOL)willTryToValueWithKey:(NSString *)key value:(id)value;//当从dic取数据赋值时调用,返回YES 赋值，返回NO不赋值
-(LRModel *)instanceObjectWithProperty:(Property *)property;//返回property对应的实例
-(void)didValueWithProperty:(Property *)property value:(id)value;//给属性赋值完调用
-(void)didValueAllProperties;//给赋值属性都赋值了调用

@end



//保存赋值只支持基本类型，NSNumber,NSString,NSArray,NSDictionary
@interface LRModel : NSObject <LRModelDelegate>

#pragma mark - 赋值
-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
//给属性赋值
-(void)fillPropertyWithDictionary:(NSDictionary *)dictionary;
-(void)fillValue:(id)value withProperty:(Property *)pro;

+(NSArray *)instanceObjectsWithDictionarys:(NSArray<NSDictionary *> *)dics createObject:(LRModel *(^)(void))create;

@end
