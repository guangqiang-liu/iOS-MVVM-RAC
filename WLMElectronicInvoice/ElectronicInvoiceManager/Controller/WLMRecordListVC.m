//
//  WLMRecordListVC.m
//  WLMElectronicInvoice
//
//  Created by Qianbao on 2018/5/10.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import "WLMRecordListVC.h"
#import "WLMRecordListCell.h"
#import "WLMInvoiceRecprdFooterView.h"
#import "WLMRecordFiltrVC.h"
#import "WLMRequirementListVC.h"
#import "WLMRecordFiltrVC.h"

@interface WLMRecordListVC () <UITableViewDataSource, UITableViewDelegate, invoiceRecordFilterDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, strong) WLMInvoiceRecprdFooterView *listFooterView;

@end

@implementation WLMRecordListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = white_color;
    [self setupViews];
}

- (void)setupViews {
    [self dataInitialize];
    [self setupTableView];
}

- (void)dataInitialize {
    self.dataArray = @[@"1", @"2", @"3"];
}

- (void)setupTableView {
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [WLMRecordListCell cellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"WLMRecordListCell";
    WLMRecordListCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[WLMRecordListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.merchantModel = nil;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark - getter

- (UITableView *)tableView {
    if (_tableView == nil) {
        CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
        _tableView.backgroundColor = bgColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = self.listFooterView;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (WLMInvoiceRecprdFooterView *)listFooterView {
    if (_listFooterView == nil) {
        _listFooterView = [[WLMInvoiceRecprdFooterView alloc] initWithFootView];
        _listFooterView.delegate = self;
    }
    return _listFooterView;
}

-(void)didRecordFilterButton:(UIButton *)button {
    WLMRequirementListVC *vc = [[WLMRequirementListVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
