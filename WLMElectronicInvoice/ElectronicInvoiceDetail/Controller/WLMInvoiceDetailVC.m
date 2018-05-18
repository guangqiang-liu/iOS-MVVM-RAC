//
//  WLMInvoiceDetailVC.m
//  WLMElectronicInvoice
//
//  Created by 刘光强 on 2018/5/4.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import "WLMInvoiceDetailVC.h"
#import "WLMInvoiceDetailHeaderView.h"
#import "WLMInvoiceDetailInfoView.h"

@interface WLMInvoiceDetailVC ()

@property (nonatomic, strong) WLMInvoiceDetailHeaderView *headerView;
@property (nonatomic, strong) WLMInvoiceDetailInfoView *infoView;
@end

@implementation WLMInvoiceDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"开票详情";
    self.view.backgroundColor = bgColor;
    self.navigationController.navigationBar.translucent = NO;
    
    [self setNavigationItemRightBarButtonItem:@selector(invoiceInvalid) withTitle:@"作废发票" withTitleColor: textGrayColor];
}

- (void)renderViews {
    [super renderViews];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.infoView];
}

- (void)invoiceInvalid {
    
}

- (WLMInvoiceDetailHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[WLMInvoiceDetailHeaderView alloc] init];
    }
    return _headerView;
}

- (WLMInvoiceDetailInfoView *)infoView {
    if (!_infoView) {
        _infoView = [[WLMInvoiceDetailInfoView alloc] init];
        _infoView.frame = CGRectMake(15, MaxY(self.headerView) + 10, SCREEN_WIDTH - 30, 320);
    }
    return _infoView;
}
@end
