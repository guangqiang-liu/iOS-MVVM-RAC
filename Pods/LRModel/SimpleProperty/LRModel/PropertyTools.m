//
//  DataTools.m
//  EasyModel
//
//  Created by ileo on 15/2/28.
//  Copyright (c) 2015年 ileo. All rights reserved.
//

#import "PropertyTools.h"


@implementation Property

+(instancetype)propertyWithObjcPropertyT:(objc_property_t)objcPropertyT{

    Property *property = [[Property alloc] init];
    property.name = [NSString  stringWithCString:property_getName(objcPropertyT) encoding:NSUTF8StringEncoding];
    property.attributes = [NSString  stringWithCString:property_getAttributes(objcPropertyT) encoding:NSUTF8StringEncoding];
    
    return property;
}

-(void)setAttributes:(NSString *)attributes{
    _attributes = [attributes copy];
    NSArray<NSString *> *atts = [attributes componentsSeparatedByString:@","];
    self.isReadOnly = [atts containsObject:@"R"];
    [atts enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([[obj substringToIndex:1] isEqualToString:@"T"]) {
            if ([@[@"TB",@"TC",@"Tc"] containsObject:obj]) {
                self.type = @"BOOL,Boolean,bool";
                self.initValue = @NO;
            }else if ([@[@"Tq",@"Ti"] containsObject:obj]) {
                self.type = @"NSInteger,long,int";
                self.initValue = @0;
            }else if ([@[@"Td",@"Tf"] containsObject:obj]) {
                self.type = @"CGFloat,double,float,NSTimeInterval";
                self.initValue = @0;
            }else if ([@[@"T@\"NSString\""] containsObject:obj]) {
                self.type = @"NSString";
                self.initValue = @"";
            }else if ([@[@"T@\"NSDictionary\""] containsObject:obj]) {
                self.type = @"NSDictionary";
                self.initValue = @{};
            }else if ([@[@"T@\"NSArray\""] containsObject:obj]) {
                self.type = @"NSArray";
                self.initValue = @[];
            }else if ([[obj substringToIndex:2] isEqualToString:@"T@"] && obj.length > 4) {
                self.type = [obj substringWithRange:NSMakeRange(3, obj.length - 4)];
                self.initValue = nil;
            }else{
                self.initValue = nil;
//                NSLog(@"----->>>----unkown-->>>  type:%@   name:%@ ",obj,self.name);
            }
            *stop = YES;
        }
    }];

}

-(NSString *)description{
    return [NSString stringWithFormat:@"----Property----\n%@",@{@"name":self.name?self.name:@"",@"attributes":self.attributes?self.attributes:@"",@"type":self.type?self.type:@"",@"initValue":self.initValue?self.initValue:@"",@"isReadOnly":@(self.isReadOnly)}];
}

@end


@implementation PropertyTools


#pragma mark - 判断

+(BOOL)isValidValue:(id)value{
    return !([value isEqual:[NSNull null]] || ([value isKindOfClass:[NSString class]] && [value isEqualToString:@"<null>"]));
}

+(BOOL)isValidArrayValue:(id)value{
    return [value isKindOfClass:[NSArray class]];
}

+(BOOL)isValidDictionaryValue:(id)value{
    return [value isKindOfClass:[NSDictionary class]];
}

+(BOOL)isValueValidWithProperty:(Property *)property value:(id)value invalidCallBack:(void (^)(id))callBack{
    if (![self isValidValue:value]
        || ([property.type isEqualToString:@"NSArray"] && ![self isValidArrayValue:value])
        || ([property.type isEqualToString:@"NSDictionary"] && ![self isValidDictionaryValue:value])
        ) {
        if (callBack) callBack(property.initValue);
        return NO;
    }else if ([property.type isEqualToString:@"NSString"] && ![value isKindOfClass:[NSString class]]) {
        if (callBack) callBack([NSString stringWithFormat:@"%@",value]);
        return NO;
    }
    return YES;
}

#pragma mark - 
+(NSArray<Property *> *)propertiesWithClass:(Class)aClass{
    u_int count;
    objc_property_t *properties = class_copyPropertyList(aClass, &count);
    NSMutableArray *tmp = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        [tmp addObject:[Property propertyWithObjcPropertyT:property]];
    }
    free(properties);
    return [tmp copy];
}


@end
