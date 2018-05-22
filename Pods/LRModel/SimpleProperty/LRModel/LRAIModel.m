//
//  AIModel.m
//  SimpleProperty
//
//  Created by ileo on 16/8/31.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "LRAIModel.h"

@interface LRAIModel ()

@property (nonatomic, copy) NSString *identification;
@property (nonatomic, copy) NSArray<Property *> *observerProperties;

@end

@implementation LRAIModel

-(void)dealloc{
    for (Property *pro in self.observerProperties) {
        [self removeObserver:self forKeyPath:pro.name];
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.identification = @"";
        [self loadValueFromUserDefaultAndAddObserver];
    }
    return self;
}

-(instancetype)initWithIdentification:(NSString *)identification{
    self = [super init];
    if (self) {
        self.identification = identification;
        [self loadValueFromUserDefaultAndAddObserver];
    }
    return self;
}

-(void)clearUserDefault{
    for (Property *pro in self.observerProperties) {
        if (!([self respondsToSelector:@selector(willClearUserDefaultProperty:)] && ![self willClearUserDefaultProperty:pro])) {
            [self setValue:pro.initValue forKey:pro.name];
        }
    }
}

-(NSString *)keyNameWithPropertyName:(NSString *)propertyName{
    return [NSString stringWithFormat:@"%@-%@-%@",self.identification, [NSString  stringWithCString:class_getName([self class]) encoding:NSUTF8StringEncoding], propertyName];
}

-(void)loadValueFromUserDefaultAndAddObserver{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    __weak __typeof(self) wself = self;
    NSMutableArray *keyPaths = [NSMutableArray arrayWithCapacity:self.properties.count];
    for (Property *obj in self.properties) {
        if (!obj.isReadOnly) {
            id value = [userDefault objectForKey:[wself keyNameWithPropertyName:obj.name]];
            if (!value) {
                value = obj.initValue;
            }
            [wself setValue:value forKey:obj.name];
            if (!([wself respondsToSelector:@selector(needAutoSaveUserDefaultForProperty:)] && ![wself needAutoSaveUserDefaultForProperty:obj])) {
                [wself addObserver:wself forKeyPath:obj.name options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
                [keyPaths addObject:obj];
            }
        }
    }
    self.observerProperties = [keyPaths copy];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    __block id value = change[NSKeyValueChangeNewKey];

    Property *pro = nil;
    for (Property * obj in self.properties) {
        if ([obj.name isEqualToString:keyPath]) {
            pro = obj;
        }
    }
    if (!pro) return;//无该属性
    
    __weak __typeof(self) wself = self;
//    NSString *className = [NSString  stringWithCString:class_getName([self class]) encoding:NSUTF8StringEncoding];
    [PropertyTools isValueValidWithProperty:pro value:value invalidCallBack:^(id initValue) {
//        NSLog(@"class<%@> auto save property (invalidValue:%@ forKey:%@ newValue:%@)",className,value,pro.name,initValue);
        value = initValue;
        [wself setValue:value forKey:pro.name];
    }];
    if ([value isEqual:change[NSKeyValueChangeOldKey]]) return;//值没改变
    
    
    NSString *keyName = [self keyNameWithPropertyName:pro.name];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    if (!([self respondsToSelector:@selector(willSaveUserDefaultValue:withProperty:)] && ![wself willSaveUserDefaultValue:value withProperty:pro])) {
        [userDefault setObject:value forKey:keyName];
        [userDefault synchronize];
//        NSLog(@"class<%@> auto save property -%@->%@ ->new '%@'",className,keyPath,change,value);
    }
    
}

@end
