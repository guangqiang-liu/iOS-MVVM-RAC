//
//  WLFormRadioCell.m
//  WLForm
//
//  Created by 刘光强 on 2018/5/4.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import "WLFormRadioCell.h"

@interface WLFormRadioCell()

@property (nonatomic, strong) UILabel *leftTitle;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@end

@implementation WLFormRadioCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = white_color;
        [self renderViews];
    }
    return self;
}

- (void)renderViews {
    [self.contentView addSubview:self.leftTitle];
    [self.contentView addSubview:self.leftButton];
    [self.contentView addSubview:self.rightButton];
}

- (void)setRadioInfo:(NSDictionary *)radioInfo {
    _radioInfo = radioInfo;
    self.leftTitle.text = radioInfo[@"leftTitle"];
//    CGSize leftTitleSize = [self.leftTitle sizeWithText:radioInfo[@"leftTitle"] font:H14];
    self.leftTitle.frame = CGRectMake(15, 0, 135, 48);
    
    NSString *rightButtonTitle = radioInfo[@"rightButtonTitle"];
    CGSize rightButtonSize = [self.rightButton sizeWithText:rightButtonTitle font:H14];
    [self.rightButton setTitle:rightButtonTitle forState:UIControlStateNormal];
    self.rightButton.frame = CGRectMake(SCREEN_WIDTH - 15 - rightButtonSize.width - 24, (48 - 16) / 2 , rightButtonSize.width + 30, 16);
    
    NSString *leftButtonTitle = radioInfo[@"leftButtonTitle"];
    CGSize leftButtonSize = [self.leftButton sizeWithText:leftButtonTitle font:H14];
    [self.leftButton setTitle:leftButtonTitle forState:UIControlStateNormal];
    self.leftButton.frame = CGRectMake(MinX(self.rightButton) - (leftButtonSize.width + 24 + 15), (48 - 16) / 2, leftButtonSize.width + 30, 16);
}

- (void)leftButtonClick:(UIButton *)button {
    [self.leftButton setImage:UIImageName(@"icon_selected") forState:UIControlStateNormal];
    [self.rightButton setImage:UIImageName(@"icon_unSelected") forState:UIControlStateNormal];
}

- (void)rightButtonClick:(UIButton *)button {
    [self.leftButton setImage:UIImageName(@"icon_unSelected") forState:UIControlStateNormal];
    [self.rightButton setImage:UIImageName(@"icon_selected") forState:UIControlStateNormal];
}

- (UILabel *)leftTitle {
    if (!_leftTitle) {
        _leftTitle = [[UILabel alloc] init];
        _leftTitle.textColor = HexRGB(0x999999);
        _leftTitle.font = H14;
        _leftTitle.numberOfLines = 2;
    }
    return _leftTitle;
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftButton setTitleColor:HexRGB(0x666666) forState:UIControlStateNormal];
        _leftButton.titleLabel.font = H14;
        [_leftButton setImage:UIImageName(@"icon_selected") forState:UIControlStateNormal];
        [_leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_leftButton layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyleLeft) imageTitleSpace:8];
    }
    return _leftButton;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setTitleColor:HexRGB(0x666666) forState:UIControlStateNormal];
        _rightButton.titleLabel.font = H14;
        [_rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_rightButton setImage:UIImageName(@"icon_unSelected") forState:UIControlStateNormal];
        [_rightButton layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyleLeft) imageTitleSpace:8];
    }
    return _rightButton;
}

@end
