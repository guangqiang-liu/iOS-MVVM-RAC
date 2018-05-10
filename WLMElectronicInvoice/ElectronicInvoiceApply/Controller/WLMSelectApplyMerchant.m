//
//  WLMSelectApplyMerchant.m
//  WLMElectronicInvoice
//
//  Created by 刘光强 on 2018/5/10.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import "WLMSelectApplyMerchant.h"
#import "WLMSelectApplyMerchantCell.h"

@interface WLMSelectApplyMerchant ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation WLMSelectApplyMerchant

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"请选择申请开通的门店";
}

- (void)renderViews {
    [super renderViews];
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  10;
}

- (WLMSelectApplyMerchantCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    WLMSelectApplyMerchantCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[WLMSelectApplyMerchantCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.dataDic = @{};
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
