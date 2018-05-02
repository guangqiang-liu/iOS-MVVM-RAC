//
//  WLBaseView.m
//  WLBaseView_Example
//
//  Created by 刘光强 on 2018/3/15.
//  Copyright © 2018年 guangqiang-liu. All rights reserved.
//

#import "WLBaseView.h"

@implementation WLBaseView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor =  [UIColor whiteColor];
        [self renderViews];
    }
    return self;
}

- (void)setCellModel:(id)cellModel {
    _cellModel = cellModel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self renderViews];
}

- (void)renderViews{}

+ (instancetype)loadXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]lastObject];
}

- (void)setFrame:(CGRect)frame {
    CGRect rc = CGRectMake(frame.origin.x + self.viewEdgeInsets.left, frame.origin.y + self.viewEdgeInsets.top, frame.size.width - self.viewEdgeInsets.left - self.viewEdgeInsets.right, frame.size.height - self.viewEdgeInsets.top - self.viewEdgeInsets.bottom);
    [super setFrame:rc];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
