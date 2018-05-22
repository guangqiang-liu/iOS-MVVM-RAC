//
//  NSObject+Property.h
//  EasyModel
//
//  Created by ileo on 16/8/26.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PropertyTools.h"

@protocol PropertyDelegate <NSObject>

@optional

//包含需要赋值属性的类（已包含本类，不需要再添加）（当需要给父类属性赋值时调用）
-(NSArray<Class> *)superPropertyClasses;

@end

@interface NSObject (Property) <PropertyDelegate>

//返回字典格式的数据
-(NSDictionary *)propertyDictionaryValue;
-(NSArray<Property *> *)properties;

-(Property *)propertyWithName:(NSString *)name;

@end

