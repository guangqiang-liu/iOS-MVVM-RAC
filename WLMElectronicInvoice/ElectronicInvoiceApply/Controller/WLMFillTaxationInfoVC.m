//
//  WLMFillTaxationInfoVC.m
//  WLMElectronicInvoice
//
//  Created by 刘光强 on 2018/5/5.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import "WLMFillTaxationInfoVC.h"
#import "WLMMoreTaxationInfoVC.h"

@interface WLMFillTaxationInfoVC ()

@property (nonatomic, strong) UIButton *bottomButton;
@end

@implementation WLMFillTaxationInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"填写税务信息";
    [self setupViews];
}

- (void)setupViews {
    [self configFormInfo];
    [self renderBottomButton];
}

- (void)renderBottomButton {
    [self.view addSubview:self.bottomButton];
}

- (void)configFormInfo {
    [self.form addSection:[self taxationInfoSection]];
}

- (WLFormSectionViewModel *)taxationInfoSection {
    
    WLFormSectionViewModel *section = nil;
    WLFormItemViewModel *row = nil;
    NSDictionary *dic = @{};
    
    section = [[WLFormSectionViewModel alloc] init];
    section.headerHeight = 58;
    section.sectionHeaderBgColor = white_color;
    section.headerTitleMarginLeft = 15;
    section.headerTopSepLineHeight = 10;
    section.headerTopSepLineColor = sepLineColor;
    section.headerTitleColor = HexRGB(0x434343);
    section.headerTitleFont = H16;
    section.headerTitle = @"税务信息";
    
    dic = @{@"leftTitle":@"税控盘类型", @"leftButtonTitle":@"航信金税盘", @"rightButtonTitle":@"百望税控盘"};
    row = [self radioCellWithInfo:dic];
    row.hasTopSep = YES;
    [section addItem:row];
    
    dic = @{kLeftKey:@"税控盘号", kPlaceholder:@"请输入税控盘号"};
    row = [self textFieldCellWithInfo:dic];
    [section addItem:row];
    
    dic = @{@"leftTitle":@"是否已至税务局开通电子发票业务", @"leftButtonTitle":@"未开通", @"rightButtonTitle":@"已开通"};
    row = [self radioCellWithInfo:dic];
    row.hasBottomSep = NO;
    [section addItem:row];
    
    dic = @{kLeftKey:@"无税盘或者未开通电票业务？点击这里了解"};
    row = [self bottomTipCellWithInfo:dic];
    row.hasBottomSep = NO;
    [section addItem:row];
    return section;
}

- (WLFormItemViewModel *)radioCellWithInfo:(NSDictionary *)info {
    WLFormItemViewModel *row = nil;
    row = [[WLFormItemViewModel alloc] initFormItemWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WLFormRadioCell"];
    row.cellClass = [WLFormRadioCell class];
    row.itemHeight = 48.f;
    row.itemConfigBlock = ^(WLFormRadioCell *cell, id value, NSIndexPath *indexPath) {
        cell.radioInfo = info;
    };
    return row;
}

- (WLFormItemViewModel *)textFieldCellWithInfo:(NSDictionary *)userInfo {
    WLFormItemViewModel *row = nil;
    row = [[WLFormItemViewModel alloc] initFormItemWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WLFormTextInputCell"];
    row.itemHeight = 48;
    row.cellClass = [WLFormTextInputCell class];
    row.value = userInfo.mutableCopy;
    row.itemConfigBlock = ^(WLFormTextInputCell *cell, id value, NSIndexPath *indexPath) {
        cell.leftlabel.text = value[kLeftKey];
        cell.rightField.text = value[kRightKey];
        cell.rightField.enabled = ![value[kDisableKey] boolValue];
        cell.rightField.placeholder = value[kPlaceholder];
        cell.textChangeBlock = ^(NSString *text) {
            value[kRightKey] = text;
        };
    };
    row.requestParamsConfigBlock = ^(id value) {
        NSMutableDictionary *ret = [NSMutableDictionary dictionaryWithCapacity:1];
        ret[value[kLeftKey]] = value[kRightKey];
        return ret;
    };
    return row;
}

- (WLFormItemViewModel *)bottomTipCellWithInfo:(NSDictionary *)info {
    WLFormItemViewModel *row = nil;
    row = [[WLFormItemViewModel alloc] initFormItemWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WLFormBottomTipCell"];
    row.cellClass = [WLFormBottomTipCell class];
    row.itemHeight = 44.f;
    row.itemConfigBlock = ^(WLFormBottomTipCell *cell, id value, NSIndexPath *indexPath) {
        cell.tipStr = info[kLeftKey];
        cell.tipBlock = ^{
            NSLog(@"点击了提示文字");
        };
    };
    return row;
}

- (UIButton *)bottomButton {
    if (!_bottomButton) {
        _bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _bottomButton.frame = CGRectMake(0, SCREEN_HEIGHT - 48, SCREEN_WIDTH, 48);
        [_bottomButton setTitleColor:white_color forState:UIControlStateNormal];
        [_bottomButton setTitle:@"下一步" forState:UIControlStateNormal];
        _bottomButton.titleLabel.font = H18;
        [_bottomButton createGradientButtonWithSize:CGSizeMake(SCREEN_WIDTH, 44) colorArray:@[HexRGB(0xFF7E4A), HexRGB(0xFF4A4A)] percentageArray:@[@(0.1), @(1)] gradientType:GradientFromLeftToRight];
        [_bottomButton whenTapped:^{
            WLMMoreTaxationInfoVC *VC = [[WLMMoreTaxationInfoVC alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }];
    }
    return _bottomButton;
}

@end
