//
//  WLBViewModelProtocol.h
//  WLMScanOrder
//
//  Created by 刘光强 on 2018/4/12.
//  Copyright © 2018年 WLM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLBViewModelServiceProtocol.h"

@protocol WLBViewModelProtocol <NSObject>

@optional

@property (nonatomic, strong, readonly) id<WLBViewModelServiceProtocol> service;
@property (nonatomic, copy, readonly) NSDictionary *params;

- (void)initialize;

- (instancetype)initWithService:(id<WLBViewModelServiceProtocol>)service params:(NSDictionary *)params;

@end
