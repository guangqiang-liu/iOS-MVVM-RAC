//
//  WLBViewController.m
//  WLMScanOrder
//
//  Created by 刘光强 on 2018/4/13.
//  Copyright © 2018年 WLM. All rights reserved.
//

#import "WLBViewController.h"

@interface WLBViewController ()

@property (nonatomic, strong, readwrite) WLBViewModel *viewModel;
@end

@implementation WLBViewController

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    WLBViewController *viewController = [super allocWithZone:zone];
    @weakify(viewController)
    [[viewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
        @strongify(viewController)
        [viewController renderViews];
        [viewController bindViewModel];
    }];
    return viewController;
}

- (instancetype)initWithViewModel:(WLBViewModel *)viewModel {
    self = [super init];
    if (self) {
        _viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)renderViews {
}

- (void)bindViewModel {
}

@end
