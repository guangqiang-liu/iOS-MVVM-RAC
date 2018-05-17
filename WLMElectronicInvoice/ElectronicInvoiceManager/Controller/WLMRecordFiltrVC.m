//
//  WLMRecordFiltrVC.m
//  WLMElectronicInvoice
//
//  Created by Qianbao on 2018/5/11.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import "WLMRecordFiltrVC.h"
#import "WLMRecordListCell.h"
#import "WLMEInvoiceFilterView.h"
//#import "WLMRecordSearchVC.h"

@interface WLMRecordFiltrVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, strong) WLMEInvoiceFilterView *filterView;

@property (nonatomic, strong) UIButton *filterBtn;
@property (nonatomic, strong) UIButton *searchBtn;
@property (nonatomic, assign) NSInteger selectedState;

@end

@implementation WLMRecordFiltrVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"开票记录";
    self.view.backgroundColor = lightGray_color;
    [self setupViews];
}

- (void)setupViews {
    [self dataInitialize];
    [self setupNaviItems];
    [self setupTableView];
}

- (void)dataInitialize {
    self.dataArray = @[@"1", @"2", @"3", @"4"];
}

- (void)setupNaviItems {
    //筛选
    UIBarButtonItem *filterItem = [[UIBarButtonItem alloc] initWithCustomView:self.filterBtn];
    //搜索
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:self.searchBtn];
    //item间距
    UIBarButtonItem *itemSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    itemSpace.width = 9;
    
    NSArray *naviItems = [[NSArray alloc] initWithObjects:searchItem, itemSpace, filterItem, nil];
    self.navigationItem.rightBarButtonItems = naviItems;
}

- (void)setupTableView {
    [self.view addSubview:self.tableView];
}

#pragma mark - load
/*
-(void)loadTopFinish:(void (^)(CGFloat))finish withScrollView:(UIScrollView *)scrollView {
    [self loadDataForMore:NO finish:^{
        finish(0);
    }];
}

-(void)loadBottomFinish:(void (^)(void))finish withScrollView:(UIScrollView *)scrollView {
    [self loadDataForMore:YES finish:^{
        finish();
    }];
}

-(void)loadDataForMore:(BOOL)isForMore finish:(void (^)(void))finish {
 
}
*/

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
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (UIButton *)filterBtn {
    if (_filterBtn == nil) {
        _filterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _filterBtn.frame = CGRectMake(0, 0, 40, 40);
        _filterBtn.titleLabel.font = FONT_PingFang_Light(14);
        [_filterBtn setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
        [_filterBtn setTitle:@"筛选" forState:UIControlStateNormal];
        [_filterBtn whenTapped:^{
            if (!self.filterView.isShowing) {
                [self.filterView show];
            } else {
                [self.filterView dismiss];
            }
        }];
    }
    return _filterBtn;
}

- (UIButton *)searchBtn {
    if (_searchBtn == nil) {
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchBtn.frame = CGRectMake(0, 0, 40, 40);
        _searchBtn.titleLabel.font = FONT_PingFang_Light(14);
        [_searchBtn setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
        [_searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
        [_searchBtn whenTapped:^{
//            WLMRecordSearchVC *vc = [[WLMRecordSearchVC alloc] init];
//
//            vc.invoiceRecordSearchBlock = ^(NSString *search) {
//                NSLog(@"%@", search);
//            };
//
//            [self.navigationController pushViewController:vc animated:YES];
        }];
    }
    return _searchBtn;
}

- (WLMEInvoiceFilterView *)filterView {
    if (_filterView == nil) {
        _filterView = [[WLMEInvoiceFilterView alloc] init];
        _filterView.clickedItemCallback = ^(NSInteger state) {
            self.selectedState = state;
//            [self loadDataForMore:NO finish:nil];
        };
    }
    return _filterView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
