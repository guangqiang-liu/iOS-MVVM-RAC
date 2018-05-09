//
//  WLMPackageSelectVC.m
//  WLMElectronicInvoice
//
//  Created by 刘光强 on 2018/5/9.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import "WLMPackageSelectVC.h"
#import "WLMPackageSelectView.h"
#import "WLMInvoiceApplyResultVC.h"

@interface WLMPackageSelectVC ()

@property (nonatomic, strong) WLMPackageSelectView *packageView;
@end

@implementation WLMPackageSelectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = bgColor;
    [self.view addSubview:self.packageView];
}

- (WLMPackageSelectView *)packageView {
    if (!_packageView) {
        _packageView = [[WLMPackageSelectView alloc] init];
        _packageView.packageSelectBlock = ^{
            WLMInvoiceApplyResultVC *VC = [[WLMInvoiceApplyResultVC alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        };
    }
    return _packageView;
}

@end
