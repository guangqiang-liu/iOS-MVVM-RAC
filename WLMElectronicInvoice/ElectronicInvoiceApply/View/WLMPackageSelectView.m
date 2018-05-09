//
//  WLMPackageSelectView.m
//  WLMElectronicInvoice
//
//  Created by 刘光强 on 2018/5/9.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import "WLMPackageSelectView.h"

@interface WLMPackageSelectView()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *packageCell;
@property (nonatomic, strong) UIButton *protocolButton;
@property (nonatomic, strong) UIButton *applyButton;
@property (nonatomic, copy) NSArray *infoArray;
@end

@implementation WLMPackageSelectView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = bgColor;
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.infoArray = @[@{
                               @"packageType":@"套餐A",
                               @"invoiceCount":@"10000",
                               @"merchantType":@"普通类型",
                               @"price":@"666",
                               @"marketPrice":@"888",
                               @"imageName":@"normal"
                               },
                           @{
                               @"packageType":@"套餐B",
                               @"invoiceCount":@"10000",
                               @"merchantType":@"普通类型",
                               @"price":@"666",
                               @"marketPrice":@"888",
                               @"imageName":@"middle"
                               },
                           @{
                               @"packageType":@"套餐A",
                               @"invoiceCount":@"10000",
                               @"merchantType":@"普通类型",
                               @"price":@"666",
                               @"marketPrice":@"888",
                               @"imageName":@"big"
                               }];
        [self renderViews];
    }
    return self;
}

- (void)renderViews {
    [self addSubview:self.scrollView];
    [self renderPackageCell];
    [self.scrollView addSubview:self.protocolButton];
    [self.scrollView addSubview:self.applyButton];
}

- (UIButton *)applyButton {
    if (!_applyButton) {
        _applyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _applyButton.frame = CGRectMake(15, MaxY(self.protocolButton) + 32, SCREEN_WIDTH - 30, 44);
        [_applyButton setTitle:@"确认申请" forState:UIControlStateNormal];
        _applyButton.backgroundColor = green_color;
        _applyButton.layer.cornerRadius = 4;
        _applyButton.layer.masksToBounds = YES;
        [_applyButton createGradientButtonWithSize:CGSizeMake(MaxY(self.protocolButton) + 32, 44) colorArray:@[HexRGB(0xFF7E4A), HexRGB(0xFF4A4A)] percentageArray:@[@(0.1), @(1)] gradientType:GradientFromLeftToRight];
    }
    return _applyButton;
}

- (UIButton *)protocolButton {
    if (!_protocolButton) {
        _protocolButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _protocolButton.frame = CGRectMake(0, 420, SCREEN_WIDTH, 20);
        [_protocolButton setTitle:@"我已阅读《电子发票合作协议》" forState:UIControlStateNormal];
        _protocolButton.titleLabel.font = H12;
        [_protocolButton setTitleColor:textGrayColor forState:UIControlStateNormal];
    }
    return _protocolButton;
}

- (void)renderPackageCell {
    for (NSInteger i = 0; i < self.infoArray.count; i ++) {
        NSDictionary *cellInfo = self.infoArray[i];
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(15, i * 130, SCREEN_WIDTH - 30, 130);
        view.layer.shadowColor = [UIColor blackColor].CGColor;
        view.layer.shadowOpacity = 0.3;
        view.layer.shadowOffset = CGSizeMake(0, 5);
        [view whenTapped:^{
            !_packageSelectBlock ?: _packageSelectBlock();
        }];
        [self.scrollView addSubview:view];
        
        [self renderInfoWithView:view info:cellInfo];
    }
}

- (void)renderInfoWithView:(UIView *)view info:(NSDictionary *)cellInfo {
    
    UIImageView *bgImage = [[UIImageView alloc] init];
    bgImage.image = [UIImage imageNamed:cellInfo[@"imageName"]];
    bgImage.userInteractionEnabled = YES;
    [view addSubview:bgImage];
    
    [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(view);
        make.top.equalTo(view).offset(16);
    }];
    
    UIImageView *stateImg = [[UIImageView alloc] init];
    stateImg.backgroundColor = red_color;
    [bgImage addSubview:stateImg];
    
    [stateImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(16);
        make.centerY.equalTo(bgImage.mas_centerY);
        make.width.height.mas_equalTo(16);
    }];
    
    UILabel *packageType = [[UILabel alloc] init];
    packageType.text = cellInfo[@"packageType"];
    packageType.textColor = white_color;
    packageType.font = HB18;
    [bgImage addSubview:packageType];
    
    [packageType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(stateImg.mas_right).offset(16);
        make.centerY.equalTo(stateImg.mas_centerY);
    }];
    
    UILabel *invoiceCount = [[UILabel alloc] init];
    invoiceCount.text = [NSString stringWithFormat:@"含发票 %@张",cellInfo[@"invoiceCount"]];
    invoiceCount.textColor = white_color;
    invoiceCount.font = H16;
    [bgImage addSubview:invoiceCount];
    
    [invoiceCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgImage).offset(48);
        make.top.equalTo(packageType.mas_bottom).offset(8);
    }];
    
    UIView *merchantView = [[UIView alloc] init];
    merchantView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2];
    merchantView.layer.cornerRadius = 3;
    [bgImage addSubview:merchantView];
    
    UILabel *merchantLable = [[UILabel alloc] init];
    merchantLable.text = cellInfo[@"merchantType"];
    merchantLable.textColor = white_color;
    merchantLable.font = H12;
    merchantLable.textAlignment = NSTextAlignmentCenter;
    [merchantView addSubview:merchantLable];
    
    [merchantView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgImage).offset(-16);
        make.width.mas_equalTo(64);
        make.height.mas_equalTo(25);
        make.top.equalTo(view).offset(16);
    }];
    
    [merchantLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(merchantView);
    }];
    
    UILabel *priceUnit = [[UILabel alloc] init];
    priceUnit.text = @"元/年";
    priceUnit.textColor = white_color;
    priceUnit.font = H16;
    [bgImage addSubview:priceUnit];
    
    [priceUnit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgImage);
        make.right.equalTo(bgImage).offset(-16);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *price = [[UILabel alloc] init];
    price.text = cellInfo[@"price"];
    price.textColor = white_color;
    price.font =  [UIFont boldSystemFontOfSize:34];
    [bgImage addSubview:price];
    
    [price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(priceUnit.mas_left).offset(-5);
        make.bottom.equalTo(priceUnit.mas_bottom).offset(7);
    }];
    
    UILabel *marketPrice = [[UILabel alloc] init];
    marketPrice.text = [NSString stringWithFormat:@"市场价：%@ 元/年",cellInfo[@"marketPrice"]];
    marketPrice.textColor = white_color;
    marketPrice.font = H12;
    [bgImage addSubview:marketPrice];
    
    [marketPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgImage).offset(-16);
        make.bottom.equalTo(bgImage).offset(-16);
    }];
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
        _scrollView.backgroundColor = bgColor;
    }
    return _scrollView;
}
@end
