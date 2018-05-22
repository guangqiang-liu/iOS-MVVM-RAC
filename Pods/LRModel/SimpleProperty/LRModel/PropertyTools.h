//
//  DataTools.h
//  EasyModel
//
//  Created by ileo on 15/2/28.
//  Copyright (c) 2015年 ileo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>


@interface Property : NSObject

+(instancetype)propertyWithObjcPropertyT:(objc_property_t)objcPropertyT;

@property (nonatomic, copy) NSString *name;//名称
@property (nonatomic, copy) NSString *attributes;//属性

#pragma mark - 根据attributes生成
@property (nonatomic, copy) NSString *type;//类型
@property (nonatomic, copy) id initValue;//初始值
@property (nonatomic, assign) BOOL isReadOnly;//是否只读


@end



@interface PropertyTools : NSObject

+(BOOL)isValidArrayValue:(id)value;
+(BOOL)isValidDictionaryValue:(id)value;
+(BOOL)isValidValue:(id)value;
+(BOOL)isValueValidWithProperty:(Property *)property value:(id)value invalidCallBack:(void (^)(id validValue))callBack;

+(NSArray<Property *> *)propertiesWithClass:(Class)aClass;


@end
