//
//  NSObject+Property.m
//  EasyModel
//
//  Created by ileo on 16/8/26.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "NSObject+Property.h"
#import <objc/runtime.h>

@implementation NSObject (Property)

static char keyProperties;

-(NSArray<Property *> *)properties{
    NSArray *tmp = objc_getAssociatedObject(self, &keyProperties);
    if (!tmp) {
        NSArray *extra = [self respondsToSelector:@selector(superPropertyClasses)] ? self.superPropertyClasses : @[];
        NSMutableArray<Class> *clases = [NSMutableArray arrayWithArray:extra];
        [clases addObject:[self class]];
        NSMutableArray *pros = [NSMutableArray arrayWithCapacity:5];
        for (Class obj in clases) {
            [pros addObjectsFromArray:[PropertyTools propertiesWithClass:obj]];
        }
        tmp = [pros copy];
        objc_setAssociatedObject(self, &keyProperties, tmp, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return tmp;
}

-(NSDictionary *)propertyDictionaryValue{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:4];
    for (Property *obj in self.properties) {
        id value = [self valueForKey:obj.name];
        if (value) {
            [dic setObject:value forKey:obj.name];
        }
    }
    return dic;
}

-(Property *)propertyWithName:(NSString *)name{
    Property *pro = nil;
    for (Property * obj in self.properties) {
        if ([obj.name isEqualToString:name]) {
            pro = obj;
        }
    }
    return pro;
}


@end
