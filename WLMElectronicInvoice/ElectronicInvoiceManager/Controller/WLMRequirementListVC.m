//
//  WLMRequirementListVC.m
//  WLMElectronicInvoice
//
//  Created by Qianbao on 2018/5/10.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import "WLMRequirementListVC.h"
#import "WLMRequirementListCell.h"

@interface WLMRequirementListVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataArray;

@end

@implementation WLMRequirementListVC

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
    self.dataArray = @[@"1", @"2", @"3", @"4", @"5"];
}

- (void)setupTableView {
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [WLMRequirementListCell cellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"WLMRequirementListCell";
    WLMRequirementListCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[WLMRequirementListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
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
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
