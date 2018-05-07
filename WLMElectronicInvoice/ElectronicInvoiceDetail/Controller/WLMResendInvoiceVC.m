//
//  WLMResendInvoiceVC.m
//  WLMElectronicInvoice
//
//  Created by 刘光强 on 2018/5/7.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import "WLMResendInvoiceVC.h"

@interface WLMResendInvoiceVC ()

@end

@implementation WLMResendInvoiceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"重发电子发票";
    [self setupViews];
}

- (void)setupViews {
    [self configFormInfo];
}

- (void)configFormInfo {
    [self.form addSection:[self resendInvoice]];
}

- (WLFormSectionViewModel *)resendInvoice {
    WLFormSectionViewModel *section = nil;
    WLFormItemViewModel *row = nil;
    NSDictionary *dic = @{};
    
    section = [[WLFormSectionViewModel alloc] init];
    dic = @{kLeftKey:@"电子邮箱", kPlaceholder:@"请输入电子邮箱"};
    row = [self textFieldCellWithInfo:dic];
    row.hasTopSep = YES;
    [section addItem:row];
    
    dic = @{kLeftKey:@"手机号码", kPlaceholder:@"请输入手机号码"};
    row = [self textFieldCellWithInfo:dic];
    [section addItem:row];
    
    dic = @{kLeftKey:@"说明：请重新确认信息后点击提交开票"};
    row = [self bottomTipCellWithInfo:dic];
    row.bottomSepLineMarginLeft = 0;
    [section addItem:row];
    
    dic = @{kLeftKey:@"提交"};
    row = [self bottomButtonCellWithInfo:dic];
    row.bottomSepLineMarginLeft = 0;
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

- (WLFormItemViewModel *)bottomTipCellWithInfo:(NSDictionary *)info {
    WLFormItemViewModel *row = nil;
    row = [[WLFormItemViewModel alloc] initFormItemWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WLFormBottomTipCell"];
    row.cellClass = [WLFormBottomTipCell class];
    row.itemHeight = 54.f;
    row.itemConfigBlock = ^(WLFormBottomTipCell *cell, id value, NSIndexPath *indexPath) {
        cell.tipStr = info[kLeftKey];
    };
    return row;
}

- (WLFormItemViewModel *)bottomButtonCellWithInfo:(NSDictionary *)info {
    WLFormItemViewModel *row = nil;
    row = [[WLFormItemViewModel alloc] initFormItemWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WLFormBottomButtonCell"];
    row.cellClass = [WLFormBottomButtonCell class];
    row.itemHeight = 44.f;
    row.itemConfigBlock = ^(WLFormBottomButtonCell *cell, id value, NSIndexPath *indexPath) {
        cell.title = info[kLeftKey];
        cell.bottomButtonBlock = ^{
            NSLog(@"点击了提交按钮");
        };
    };
    return row;
}

@end
