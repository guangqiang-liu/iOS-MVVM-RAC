//
//  WLBViewModel.m
//  WLMScanOrder
//
//  Created by 刘光强 on 2018/4/12.
//  Copyright © 2018年 WLM. All rights reserved.
//

#import "WLBViewModel.h"
#import "WLBViewModelServiceProtocol.h"
@interface WLBViewModel()

@property (nonatomic, strong, readwrite) id<WLBViewModelServiceProtocol> service;
@property (nonatomic, copy, readwrite) NSDictionary *params;
@end

@implementation WLBViewModel

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    WLBViewModel *viewModel = [super allocWithZone:zone];
    @weakify(viewModel)
    [[viewModel rac_signalForSelector:@selector(initWithService:params:)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(viewModel)
        [viewModel initialize];
    }];
    return viewModel;
}

- (instancetype)initWithService:(id<WLBViewModelServiceProtocol>)service params:(NSDictionary *)params {
    self = [super init];
    if (self) {
        _service = service;
        _params = params;
    }
    return self;
}

- (void)initialize {
}

@end
