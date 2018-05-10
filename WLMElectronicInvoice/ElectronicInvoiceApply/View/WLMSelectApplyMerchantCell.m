//
//  WLMSelectApplyMerchantCell.m
//  WLMElectronicInvoice
//
//  Created by 刘光强 on 2018/5/10.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import "WLMSelectApplyMerchantCell.h"

@interface WLMSelectApplyMerchantCell()

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *subTitle;
@property (nonatomic, strong) UILabel *stateLable;
@property (nonatomic, strong) UIImageView *arrowImage;

@end

@implementation WLMSelectApplyMerchantCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self renderViews];
    }
    return self;
}

- (void)renderViews {
    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.subTitle];
    [self.contentView addSubview:self.stateLable];
    [self.contentView addSubview:self.arrowImage];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_offset(15);
    }];
    
    [self.subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.title);
        make.top.equalTo(self.title.mas_bottom).offset(5);
    }];
    
    [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self).offset(-15);
        make.width.mas_offset(6);
        make.height.mas_offset(12);
    }];
    
    [self.stateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.arrowImage.mas_left).offset(-8);
    }];
}

- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.text = @"上海小南国 (南京店)";
        _title.textColor = textBlackColor;
        _title.font = H14;
    }
    return _title;
}

- (UILabel *)subTitle {
    if (!_subTitle) {
        _subTitle = [[UILabel alloc] init];
        _subTitle.text = @"上海市-上海市-黄浦区";
        _subTitle.textColor = textGrayColor;
        _subTitle.font = H12;
    }
    return _subTitle;
}

- (UILabel *)stateLable {
    if (!_stateLable) {
        _stateLable = [[UILabel alloc] init];
        _stateLable.text = @"未开通";
        _stateLable.textColor = textDarkGrayColor;
        _stateLable.font = H14;
    }
    return _stateLable;
}

- (UIImageView *)arrowImage {
    if (!_arrowImage) {
        _arrowImage = [[UIImageView alloc] init];
        _arrowImage.backgroundColor = red_color;
    }
    return _arrowImage;
}


@end
