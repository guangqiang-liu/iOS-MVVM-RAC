//
//  WLMInvoiceApplyResultVC.m
//  WLMElectronicInvoice
//
//  Created by 刘光强 on 2018/5/9.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import "WLMInvoiceApplyResultVC.h"
#import "WLMInvoiceApplyResultView.h"

@interface WLMInvoiceApplyResultVC ()

@property (nonatomic, strong) WLMInvoiceApplyResultView *resultView;
@end

@implementation WLMInvoiceApplyResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = bgColor;
}

- (void)renderViews {
    [super renderViews];
    [self.view addSubview:self.resultView];
}

- (WLMInvoiceApplyResultView *)resultView {
    if (!_resultView) {
        _resultView = [[WLMInvoiceApplyResultView alloc] init];
    }
    return _resultView;
}

@end
