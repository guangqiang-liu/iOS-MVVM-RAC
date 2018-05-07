//
//  WLMOpenInvoiceVC.m
//  WLMElectronicInvoice
//
//  Created by 刘光强 on 2018/5/7.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import "WLMOpenInvoiceVC.h"

@interface WLMOpenInvoiceVC ()

@property (nonatomic, strong) UIButton *bottomButton;
@end

@implementation WLMOpenInvoiceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"开票";
    [self setupViews];
}

- (void)setupViews {
    [self configFormInfo];
    [self renderBottomButton];
}

- (void)configFormInfo {
    [self.form addSection:[self invoiceDetail]];
    [self.form addSection:[self receiveMode]];
}

- (void)renderBottomButton {
    [self.view addSubview:self.bottomButton];
}

- (WLFormSectionViewModel *)invoiceDetail {
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
    section.headerTitle = @"发票详情";
    
    dic = @{kLeftKey:@"发票金额（请确认金额）"};
    row = [self textFieldCellWithInfo:dic];
    row.hasTopSep = YES;
    [section addItem:row];
    
    dic = @{kLeftKey:@"发票内容"};
    row = [self textFieldCellWithInfo:dic];
    [section addItem:row];
    
    dic = @{kLeftKey:@"发票抬头"};
    row = [self textFieldCellWithInfo:dic];
    [section addItem:row];
    
    dic = @{kLeftKey:@"税号"};
    row = [self textFieldCellWithInfo:dic];
    [section addItem:row];
    return section;
}

- (WLFormSectionViewModel *)receiveMode {
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
    section.headerTitle = @"接受方式";
    
    dic = @{kLeftKey:@"手机号码"};
    row = [self textFieldCellWithInfo:dic];
    row.hasTopSep = YES;
    [section addItem:row];
    
    dic = @{kLeftKey:@"电子邮箱"};
    row = [self textFieldCellWithInfo:dic];
    [section addItem:row];
    return section;
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

- (UIButton *)bottomButton {
    if (!_bottomButton) {
        _bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _bottomButton.frame = CGRectMake(0, SCREEN_HEIGHT - 48, SCREEN_WIDTH, 48);
        [_bottomButton setTitleColor:white_color forState:UIControlStateNormal];
        [_bottomButton setTitle:@"确认开票" forState:UIControlStateNormal];
        _bottomButton.titleLabel.font = H18;
        [_bottomButton createGradientButtonWithSize:CGSizeMake(SCREEN_WIDTH, 44) colorArray:@[HexRGB(0xFF7E4A), HexRGB(0xFF4A4A)] percentageArray:@[@(0.1), @(1)] gradientType:GradientFromLeftToRight];
        [_bottomButton whenTapped:^{
           
        }];
    }
    return _bottomButton;
}

@end
