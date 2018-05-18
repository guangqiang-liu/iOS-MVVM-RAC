//
//  WLMSelectApplyMerchantVC.m
//  WLMElectronicInvoice
//
//  Created by 刘光强 on 2018/5/16.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import "WLMSelectApplyMerchantVC.h"
#import "WLMSelectApplyMerchantCell.h"
#import "WLMEInvoiceIntroduceVC.h"
#import "WLMEInvoiceIntroduceVM.h"
#import "WLMSelectedApplyMerchantVM.h"
#import "WLMSelectedApplyMerchantModel.h"
#import "WLMResendInvoiceVC.h"
@interface WLMSelectApplyMerchantVC()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) WLMSelectedApplyMerchantVM *merchantViewModel;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataArray;
@end

@implementation WLMSelectApplyMerchantVC

- (instancetype)initWithViewModel:(WLMSelectedApplyMerchantVM *)viewModel {
    self = [super initWithViewModel:viewModel];
    if (self) {
        _merchantViewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"请选择申请开通的门店";
}

- (void)renderViews {
    [super renderViews];
    [self.view addSubview:self.tableView];
}

- (void)bindViewModel {
    [super bindViewModel];
    [[[RACObserve(self.merchantViewModel, dataArray) skip:1] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSArray *array) {
        self.dataArray = array;
        [self.tableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.dataArray.count;
}

- (WLMSelectApplyMerchantCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    WLMSelectApplyMerchantCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[WLMSelectApplyMerchantCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    WLMEInvoiceIntroduceVC *VC = [[WLMEInvoiceIntroduceVC alloc] initWithViewModel:self.merchantViewModel.introduceViewModel];
    [self.navigationController pushViewController:VC animated:YES];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _tableView.backgroundColor = bgColor;
        _tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = 70;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
