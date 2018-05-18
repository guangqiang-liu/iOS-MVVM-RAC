//
//  WLMMoreTaxationInfoVC.m
//  WLMElectronicInvoice
//
//  Created by 刘光强 on 2018/5/5.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import "WLMMoreTaxationInfoVC.h"
#import "WLMOpenInvoiceVC.h"
#import "WLMMoreTaxationInfoVM.h"
#import "WLMPackageSelectVC.h"

@interface WLMMoreTaxationInfoVC ()

@property (nonatomic, strong) UIButton *bottomButton;
@property (nonatomic, strong) WLMMoreTaxationInfoVM *moreInfoViewModel;
@property (nonatomic, assign) BOOL buttonEnabled;
@end

@implementation WLMMoreTaxationInfoVC

- (instancetype)initWithViewModel:(WLMMoreTaxationInfoVM *)viewModel {
    self = [super initWithViewModel:viewModel];
    if (self) {
        _moreInfoViewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"填写税务信息";
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 48);
}

-(void)renderViews {
    [super renderViews];
    [self configFormInfo];
    [self renderBottomButton];
}

- (void)bindViewModel {
    [super bindViewModel];
    RAC(self.bottomButton, enabled) = RACObserve(self, buttonEnabled);
}

- (void)configFormInfo {
    [self.form addSection:[self merchantInfo]];
    [self.form addSection:[self invoiceInfo]];
    [self.form addSection:[self moreInfo]];
}

- (WLFormSectionViewModel *)merchantInfo {
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
    section.headerTitle = @"商户信息（必填）";
    
    dic = @{kLeftKey:@"名称", kPlaceholder:@"请输入商户名称"};
    row = [self textFieldCellWithInfo:dic];
    row.hasTopSep = YES;
    [section addItem:row];
    
    dic = @{kLeftKey:@"税号", kPlaceholder:@"请输入税号"};
    row = [self textFieldCellWithInfo:dic];
    [section addItem:row];
    
    dic = @{kLeftKey:@"地址", kPlaceholder:@"请输入地址"};
    row = [self textFieldCellWithInfo:dic];
    [section addItem:row];
    
    dic = @{kLeftKey:@"联系电话", kPlaceholder:@"请输入联系电话"};
    row = [self textFieldCellWithInfo:dic];
    [section addItem:row];
    
    dic = @{kLeftKey:@"银行账号", kPlaceholder:@"请输入银行账号"};
    row = [self textFieldCellWithInfo:dic];
    [section addItem:row];
    
    dic = @{kLeftKey:@"开户行", kPlaceholder:@"请输入开户行"};
    row = [self textFieldCellWithInfo:dic];
    row.hasBottomSep = NO;
    [section addItem:row];
    
    return section;
}

- (WLFormSectionViewModel *)invoiceInfo {
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
    section.headerTitle = @"开票信息（必填）";
    
    dic = @{kLeftKey:@"征税方式", kPlaceholder:@"请选择征税方式"};
    row = [self selectCellWithInfo:dic];
    row.hasTopSep = YES;
    [section addItem:row];
    
    dic = @{kLeftKey:@"开票项目", kPlaceholder:@"请输入开票项目"};
    row = [self textFieldCellWithInfo:dic];
    [section addItem:row];
    
    dic = @{kLeftKey:@"商品编号", kPlaceholder:@"请输入商户编号"};
    row = [self textFieldCellWithInfo:dic];
    [section addItem:row];
    
    dic = @{kLeftKey:@"税率", kPlaceholder:@"请选择税率"};
    row = [self selectCellWithInfo:dic];
    [section addItem:row];
    
    dic = @{kLeftKey:@"开票人", kPlaceholder:@"请输入开票人"};
    row = [self textFieldCellWithInfo:dic];
    row.hasBottomSep = NO;
    [section addItem:row];
    
    dic = @{kLeftKey:@"更多信息（选填）"};
    row = [self moreInfoCellWithInfo:dic];
    row.bottomSepLineMarginLeft = 0;
    [section addItem:row];
    
    return section;
}

- (WLFormSectionViewModel *)moreInfo {
    WLFormSectionViewModel *section = nil;
    WLFormItemViewModel *row = nil;
    NSDictionary *dic = @{};
    section = [[WLFormSectionViewModel alloc] init];
    
    dic = @{kLeftKey:@"收款人", kPlaceholder:@"请输入收款人"};
    row = [self textFieldCellWithInfo:dic];
    [section addItem:row];
    
    dic = @{kLeftKey:@"复核人", kPlaceholder:@"请输入复核人"};
    row = [self textFieldCellWithInfo:dic];
    [section addItem:row];
    
    dic = @{kLeftKey:@"财务联系电话", kPlaceholder:@"请输入财务联系电话"};
    row = [self textFieldCellWithInfo:dic];
    [section addItem:row];
    
    dic = @{kLeftKey:@"特殊票种标识", kPlaceholder:@"请选择特殊票种标识"};
    row = [self selectCellWithInfo:dic];
    [section addItem:row];
    
    dic = @{kLeftKey:@"发票行性质", kPlaceholder:@"请选择发票行性质"};
    row = [self selectCellWithInfo:dic];
    [section addItem:row];
    
    dic = @{kLeftKey:@"优惠政策标识", kPlaceholder:@"请选择优惠政策标识"};
    row = [self selectCellWithInfo:dic];
    [section addItem:row];
    
    dic = @{kLeftKey:@"零税率标识", kPlaceholder:@"请选择零税率标识"};
    row = [self selectCellWithInfo:dic];
    [section addItem:row];
    
    dic = @{kLeftKey:@"增值税特殊管理", kRightKey:@"无", kDisableKey:@YES};
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
        cell.rightField.textColor = [value[kDisableKey] boolValue] ? HexRGB(0xcfcfcf) : textBlackColor;
        cell.rightField.placeholder = value[kPlaceholder];
        cell.textChangeBlock = ^(NSString *text) {
            value[kRightKey] = text;
            [self changeSubmitButtonState];
        };
    };
    row.requestParamsConfigBlock = ^(id value) {
        NSMutableDictionary *ret = [NSMutableDictionary dictionaryWithCapacity:1];
        ret[value[kLeftKey]] = value[kRightKey];
        return ret;
    };
    row.valueValidateBlock = ^NSDictionary *(id value) {
        if ([value[kRightKey] length]) return itemValid();
        return itemInvalid(value[kPlaceholder]);
    };
    return row;
}

- (WLFormItemViewModel *)moreInfoCellWithInfo:(NSDictionary *)info {
    WLFormItemViewModel *row = nil;
    row = [[WLFormItemViewModel alloc] initFormItemWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WLFormMoreInfoCell"];
    row.cellClass = [WLFormMoreInfoCell class];
    row.itemHeight = 54.f;
    row.value = info.mutableCopy;
    row.itemConfigBlock = ^(WLFormMoreInfoCell *cell, id value, NSIndexPath *indexPath) {
        cell.leftTitle.text = value[kLeftKey];
        cell.moreInfoBlock = ^{
            WLFormSectionViewModel *section = self.form.sectionArray[2];
            section.hidden = !section.hidden;
            [self.tableView reloadData];
        };
    };
    return row;
}

- (WLFormItemViewModel *)selectCellWithInfo:(NSDictionary *)info {
    WLFormItemViewModel *row = nil;
    row = [[WLFormItemViewModel alloc] initFormItemWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WLFormSelectCell"];
    row.itemHeight = 48;
    row.cellClass = [WLFormSelectCell class];
    row.value = info.mutableCopy;
    row.itemConfigBlock = ^(WLFormSelectCell *cell, id value, NSIndexPath *indexPath) {
        cell.leftLable.text = value[kLeftKey];
        cell.rightTitle = value[kRightKey];
    };
    row.didSelectCellBlock = ^(NSIndexPath *indexPath, id value, WLFormSelectCell *cell) {
        [self selectItemWithDataSource:@[@"1", @"2", @"3", @"4"] title:value[kLeftKey] callback:^(NSString *item) {
            value[kRightKey] = item;
            cell.rightTitle = item;
            cell.hasSelected = YES;
            [self changeSubmitButtonState];
        }];
    };
    row.valueValidateBlock = ^NSDictionary *(id value) {
        if ([value[kRightKey] length]) return itemValid();
        return itemInvalid(value[kPlaceholder]);
    };
    return row;
}

- (void)renderBottomButton {
    [self.view addSubview:self.bottomButton];
}

- (UIButton *)bottomButton {
    if (!_bottomButton) {
        _bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _bottomButton.frame = CGRectMake(0, SCREEN_HEIGHT - 48, SCREEN_WIDTH, 48);
        [_bottomButton setTitleColor:white_color forState:UIControlStateNormal];
        [_bottomButton setTitle:@"下一步" forState:UIControlStateNormal];
        _bottomButton.titleLabel.font = H18;
        [_bottomButton createGradientButtonWithSize:CGSizeMake(SCREEN_WIDTH, 44) colorArray:@[HexRGB(0xFF7E4A), HexRGB(0xFF4A4A)] gradientType:GradientFromLeftToRight];
        [_bottomButton whenTapped:^{
            WLMPackageSelectVC *VC = [[WLMPackageSelectVC alloc] initWithViewModel:self.moreInfoViewModel.packageSelectViewModel];
            [self.navigationController pushViewController:VC animated:YES];
        }];
    }
    return _bottomButton;
}

- (void)changeSubmitButtonState {
    NSDictionary *validateParams = [self.form validateItems];
    if ([validateParams[kValidateRetKey] boolValue]) {
        self.buttonEnabled = YES;
    } else {
        self.buttonEnabled = NO;
    }
//    [validateParams[kValidateRetKey] boolValue] ? (self.buttonEnabled = YES) : (self.buttonEnabled = NO);
}

- (void)selectItemWithDataSource:(NSArray *)data title:(NSString *)title callback:(void(^)(NSString *item))callback {
    [[WLPickerViewManager shareManger] showPickerViewWithCustomDataArray:data keyMapper:@"name" tag:1 title:title cancelTitle:@"取消" commitTitle:@"确定" commitBlock:^(id selectedItem) {
        !callback ?: callback(selectedItem);
    } cancelBlock:^{
    }];
}

@end
