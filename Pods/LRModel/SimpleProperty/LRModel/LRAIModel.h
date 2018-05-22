//
//  AIModel.h
//  SimpleProperty
//
//  Created by ileo on 16/8/31.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LRModel.h"

@protocol LRAIModelDelegate <NSObject>

@optional

-(BOOL)needAutoSaveUserDefaultForProperty:(Property *)property;//返回是否需要监听该属性，并保存userdefault
-(BOOL)willSaveUserDefaultValue:(id)value withProperty:(Property *)property;//将要自动保存属性

-(BOOL)willClearUserDefaultProperty:(Property *)property;//将要初始化一个属性

@end


@interface LRAIModel : LRModel <LRAIModelDelegate>

-(instancetype)initWithIdentification:(NSString *)identification;

-(void)clearUserDefault;

@end
