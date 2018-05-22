//
//  WLMInvoiceQRCodeListVC.m
//  WLMElectronicInvoice
//
//  Created by Qianbao on 2018/5/17.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import "WLMInvoiceQRCodeListVC.h"
#import "InvoiceQRCodeCell.h"
#import "InvoiceCollectionReusableView.h"
#import "WLMInvoiceConfirmView.h"

@interface WLMInvoiceQRCodeListVC () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionReusableView *headerView;
@property (nonatomic, strong) UIView *headBgView;
@property (nonatomic, strong) UILabel *shopName;
@property (nonatomic, strong) UIButton *shopChange;
@property (nonatomic, strong) UIView *scanBgView;
@property (nonatomic, strong) UIButton *scanButton;

@end

@implementation WLMInvoiceQRCodeListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"二维码绑定";
    self.view.backgroundColor = bgColor;
    
    [self setupViews];
}

- (void)setupViews {
    [self dataInitialize];
    [self setupCollectionView];
    [self.view addSubview:self.scanBgView];
    [self.scanBgView addSubview:self.scanButton];
}

- (void)dataInitialize {
}

- (void)setupCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 88);
    layout.itemSize = CGSizeMake(110, 150);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    [self.collectionView registerClass:[InvoiceQRCodeCell class] forCellWithReuseIdentifier:@"QRCodeCell"];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

#pragma mark collectionView代理方法

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    InvoiceQRCodeCell *cell = (InvoiceQRCodeCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"QRCodeCell" forIndexPath:indexPath];
    
    cell.botlabel.text = [NSString stringWithFormat:@"{%ld,%ld}",(long)indexPath.section,(long)indexPath.row];
    
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (SCREEN_WIDTH - 42) / 2;
    CGFloat height = (SCREEN_WIDTH - 42) / 2 / 0.75;
    return CGSizeMake(width, height);
}

//footer的size
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
//    return CGSizeMake(10, 10);
//}

//header的size
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
//    return CGSizeMake(10, 10);
//}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(8, 16, 4, 16);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 8;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    self.headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
    self.headerView.backgroundColor = bgColor;
    
    [self.headerView addSubview:self.headBgView];
    [self.headBgView addSubview:self.shopName];
    [self.headBgView addSubview:self.shopChange];
    
    //    UILabel *label = [self.headerView viewWithTag:3000];
    //
    //    if (!label) {
    //        label = [[UILabel alloc] initWithFrame:self.headerView.bounds];
    //        label.tag = 3000;
    //        label.font = [UIFont systemFontOfSize:20];
    //        [self.headerView addSubview:label];
    //    }
    //
    //    label.text = [NSString stringWithFormat:@"这是collectionView的头部:%zd,%zd",indexPath.section,indexPath.row];
    
    return self.headerView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    InvoiceQRCodeCell *cell = (InvoiceQRCodeCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSString *msg = cell.botlabel.text;
    NSLog(@"%@",msg);
}

#pragma mark

- (UIView *)headBgView {
    if (!_headBgView) {
        _headBgView = [[UIView alloc] init];
        _headBgView.frame = CGRectMake(60, 16, SCREEN_WIDTH - 120, self.headerView.frame.size.height - 28);
        //        _headBgView.center = CGPointMake(self.headerView.frame.size.width / 2, self.headerView.frame.size.height / 2);
        _headBgView.backgroundColor = white_color;
        _headBgView.layer.cornerRadius = 28;
        _headBgView.layer.masksToBounds = YES;
    }
    return _headBgView;
}

- (UILabel *)shopName {
    if (!_shopName) {
        _shopName = [[UILabel alloc] init];
        _shopName.frame = CGRectMake(50, 10, self.headBgView.frame.size.width, 20);
        _shopName.center = CGPointMake(self.headBgView.frame.size.width / 2, self.headBgView.frame.size.height / 2 - 10);
        _shopName.textColor = HexRGB(0x434343);
        _shopName.font = FONT_PingFang_Light(14);
        _shopName.textAlignment = NSTextAlignmentCenter;
        _shopName.text = @"上海小南国南京店上海小南国南京";
    }
    return _shopName;
}

- (UIButton *)shopChange {
    if (!_shopChange) {
        _shopChange = [UIButton buttonWithType:UIButtonTypeCustom];
        _shopChange.frame = CGRectMake(50, 40, self.headBgView.frame.size.width, 20);
        _shopChange.center = CGPointMake(self.headBgView.frame.size.width / 2, self.headBgView.frame.size.height / 2 + 12);
        _shopChange.titleLabel.font = FONT_PingFang_Light(14);
        [_shopChange setTitle:@"切换门店" forState:UIControlStateNormal];
        [_shopChange setTitleColor:HexRGB(0x999999) forState:UIControlStateNormal];
        [_shopChange setImage:UIImageName(@"einvoice_merchant_change") forState:UIControlStateNormal];
        [_shopChange setTitleEdgeInsets:UIEdgeInsetsMake(14, 40, 14, 50)];
        [_shopChange setImageEdgeInsets:UIEdgeInsetsMake(14, 180, 14, 50)];
    }
    return _shopChange;
}

- (UIView *)scanBgView {
    if (!_scanBgView) {
        _scanBgView = [[UIView alloc] init];
        _scanBgView.frame = CGRectMake(0, SCREEN_HEIGHT - 76, SCREEN_WIDTH, 76);
        _scanButton.backgroundColor = clear_color;
    }
    return _scanBgView;
}

- (UIButton *)scanButton {
    if (!_scanButton) {
        _scanButton = [[UIButton alloc] init];
        _scanButton.frame = CGRectMake(16, 16, SCREEN_WIDTH - 32, 44);
        _scanButton.layer.cornerRadius = 4;
        _scanButton.layer.masksToBounds = YES;
        _scanButton.titleLabel.font = FONT_PingFang_Light(18);
        [_scanButton setTitle:@"扫码绑定" forState:UIControlStateNormal];
        [_scanButton setImage:UIImageName(@"einvoice_scan") forState:UIControlStateNormal];
        [_scanButton setTitleEdgeInsets:UIEdgeInsetsMake(14, 60, 14, 50)];
        [_scanButton createGradientButtonWithSize:CGSizeMake(SCREEN_WIDTH, 44) colorArray:@[HexRGB(0xFF7E4A), HexRGB(0xFF4A4A)] gradientType:GradientFromLeftToRight];
        [_scanButton whenTapped:^{
            
            WLModal *alertView = [[WLModal alloc] init];
            WLMInvoiceConfirmView *view = [[WLMInvoiceConfirmView alloc] init];
            view.invoiceConfirmBlock = ^(NSString *confirm) {
                NSLog(@"%@", confirm);
                [alertView close];
            };
            [alertView addContentView:view];
            [alertView show];
        }];
    }
    return _scanButton;
}

- (void)testAction {
    
    WLModal *alertView = [[WLModal alloc] init];
    WLMInvoiceConfirmView *view = [[WLMInvoiceConfirmView alloc] init];
    view.invoiceConfirmBlock = ^(NSString *confirm) {
        NSLog(@"%@", confirm);
    };
    [alertView addContentView:view];
    [alertView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

