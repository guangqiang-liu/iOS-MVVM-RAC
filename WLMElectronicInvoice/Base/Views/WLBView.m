//
//  WLBView.m
//  WLMScanOrder
//
//  Created by 刘光强 on 2018/4/12.
//  Copyright © 2018年 WLM. All rights reserved.
//

#import "WLBView.h"

@interface WLBView()

@property (nonatomic, strong, readwrite) WLBViewModel *viewModel;
@end

@implementation WLBView

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    WLBView *view = [super allocWithZone:zone];
    @weakify(view)
    [[view rac_signalForSelector:@selector(initWithViewModel:)]
     subscribeNext:^(id x) {
         @strongify(view)
         [view renderViews];
         [view bindViewModel];
     }];
    return view;
}

- (instancetype)initWithViewModel:(WLBViewModel *)viewModel {
    self = [super init];
    if (self) {
        _viewModel = viewModel;
    }
    return self;
}

- (void)renderViews {
}

- (void)bindViewModel {
}
@end
