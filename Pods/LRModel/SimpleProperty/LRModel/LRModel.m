//
//  ValuePropertyObject.m
//  SimpleProperty
//
//  Created by ileo on 16/9/8.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "LRModel.h"

@implementation LRModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [self init];
    if (self) {
        [self fillPropertyWithDictionary:dictionary];
    }
    return self;
}

-(void)fillValue:(id)value withProperty:(Property *)pro{
    @autoreleasepool {
        __block id newValue = value;
        
        
        if ([PropertyTools isValueValidWithProperty:pro value:value invalidCallBack:^(id validValue) {
            newValue = validValue;
//            NSLog(@"----invalid value:%@   forKey:%@  class:%@  type:%@   newValue:%@",value,pro.name,[self class],pro.type,validValue);
        }]) {
            if ([self respondsToSelector:@selector(instanceObjectWithProperty:)] && [self instanceObjectWithProperty:pro]) {
                if ([pro.type isEqualToString:@"NSArray"]) {
                    NSArray *tmp = value;
                    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:tmp.count];
                    __weak __typeof(self) wself = self;
                    [tmp enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        LRModel *instance = [wself instanceObjectWithProperty:pro];
                        if ([PropertyTools isValidDictionaryValue:obj]) {
                            [instance fillPropertyWithDictionary:obj];
                            [arr addObject:instance];
                        }else{
                            [arr addObject:obj];
//                            NSLog(@"----invalid value:%@   forKey:%@ index:%zd  class:%@ newValue:%@",obj,pro.name,idx,[instance class],obj);
                        }
                    }];
                    newValue = [arr copy];
                }else{
                    LRModel *instance = [self instanceObjectWithProperty:pro];
                    if ([pro.type isEqualToString:[NSString stringWithCString:class_getName([instance class]) encoding:NSUTF8StringEncoding]] && [PropertyTools isValidDictionaryValue:value]) {
                        [instance fillPropertyWithDictionary:value];
                        newValue = instance;
                    }else{
//                        NSLog(@"----invalid value:%@   forKey:%@  class:%@ newValue:%@",value,pro.name,[instance class],value);
                        newValue = pro.initValue;
                    }
                }
            }
        }
        [self setValue:newValue forKey:pro.name];
        if ([self respondsToSelector:@selector(didValueWithProperty:value:)]) {
            [self didValueWithProperty:pro value:newValue];
        }
    }
}

-(void)fillPropertyWithDictionary:(NSDictionary *)dictionary{
    NSArray<NSString *> *keys = [dictionary allKeys];
    NSMutableArray *tmp = [NSMutableArray arrayWithArray:self.properties];
    for (NSString * key in keys) {
        NSArray<Property *> *pros = [tmp copy];
        if (![self respondsToSelector:@selector(willTryToValueWithKey:value:)] || [self willTryToValueWithKey:key value:dictionary[key]]) {
            for (Property * pro in pros) {
                if ([pro.name isEqualToString:key]) {
                    [self fillValue:dictionary[pro.name] withProperty:pro];
                    [tmp removeObject:pro];
                    break;
                }
            }
        }
    }
    if ([self respondsToSelector:@selector(didValueAllProperties)]) {
        [self didValueAllProperties];
    }
}

+(NSArray *)instanceObjectsWithDictionarys:(NSArray<NSDictionary *> *)dics createObject:(LRModel *(^)(void))create{
    if ([PropertyTools isValidArrayValue:dics]) {
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:dics.count];
        [dics enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([PropertyTools isValidDictionaryValue:obj] && create) {
                LRModel *object = create();
                [object fillPropertyWithDictionary:obj];
                [arr addObject:object];
            }else{
//                NSLog(@"----no creat instance   or   invalid value:%@ (+instanceObjects)  no a dictionary object",obj);
                [arr addObject:obj];
            }
        }];
        return [arr copy];
    }else{
//        NSLog(@"----invalid value:%@ new value:%@ (+instanceObjects)  no a array object",dics,@[]);
        return @[];
    }
}

-(NSString *)description{
    return [NSString stringWithFormat:@"--%@--%@",[self class],self.propertyDictionaryValue];
}

@end
