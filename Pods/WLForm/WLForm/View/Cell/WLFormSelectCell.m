//
//  WLFormSelectCell.m
//  WLForm
//
//  Created by 刘光强 on 2018/5/4.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import "WLFormSelectCell.h"

@interface WLFormSelectCell()

@property (nonatomic, strong) UIImageView *arrowImg;
@end

@implementation WLFormSelectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self renderViews];
    }
    return self;
}

- (void)renderViews {
    [self.contentView addSubview:self.leftLable];
    [self.contentView addSubview:self.rightLable];
    [self.contentView addSubview:self.arrowImg];
}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//    CGSize leftTitleSize = [self.leftLable sizeForTitle:self.leftLable.text withFont:H14];
//    self.leftLable.frame = CGRectMake(15, 0, WIDTH(self.contentView), HEIGHT(self.contentView));
//    CGFloat padding = 10;
//    self.rightLable.frame = CGRectMake(leftTitleSize.width + 30, padding, SCREEN_WIDTH - (leftTitleSize.width + 30 + 15 + 15), self.contentView.frame.size.height - 2 * padding);
//}

- (void)setRightTitle:(NSString *)rightTitle {
    _rightTitle = rightTitle;
    self.rightLable.text = rightTitle;
    CGSize leftTitleSize = [self.leftLable sizeWithText:rightTitle font:H14];
    self.leftLable.frame = CGRectMake(15, 0, WIDTH(self.contentView), HEIGHT(self.contentView));
    self.rightLable.frame = CGRectMake(leftTitleSize.width + 30, (48 - leftTitleSize.height) / 2, SCREEN_WIDTH - (leftTitleSize.width + 30 + 15 + 15), leftTitleSize.height);
}

- (void)setHasSelected:(BOOL)hasSelected {
    _hasSelected = hasSelected;
    self.rightLable.textColor = HexRGB(0x434343);
}

- (UILabel *)leftLable {
    if (!_leftLable) {
        _leftLable = [[UILabel alloc] init];
        _leftLable.textColor = HexRGB(0x999999);
        _leftLable.font = H14;
    }
    return _leftLable;
}

- (UIImageView *)arrowImg {
    if (!_arrowImg) {
        _arrowImg = [[UIImageView alloc] init];
        _arrowImg.frame = CGRectMake(SCREEN_WIDTH - (15 + 8), (48 - 15) / 2, 8, 15);
        _arrowImg.image = UIImageName(@"icon_arrow");
    }
    return _arrowImg;
}

- (UILabel *)rightLable {
    if (!_rightLable) {
        _rightLable = [[UILabel alloc] init];
        _rightLable.font = H14;
        _rightLable.textAlignment = NSTextAlignmentRight;
        _rightLable.textColor = HexRGB(0xC7C7CD);
    }
    return _rightLable;
}

@end
