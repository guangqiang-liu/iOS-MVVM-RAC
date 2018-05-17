//
//  WLMInvoiceRecprdFooterView.m
//  WLMElectronicInvoice
//
//  Created by Qianbao on 2018/5/11.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import "WLMInvoiceRecprdFooterView.h"

@interface WLMInvoiceRecprdFooterView ()

@property (nonatomic, strong) UIView *footView;
@property (nonatomic, strong) UIButton *recordFilterBtn;

@end

@implementation WLMInvoiceRecprdFooterView

-(instancetype)initWithFootView {
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    if (self) {
        [self addSubview:self.footView];
    }
    return self;
}

#pragma mark - set get

-(UIView *)footView {
    if (!_footView) {
        _footView = [[UIView alloc] init];
        _footView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
        _footView.backgroundColor = clear_color;
        
        self.recordFilterBtn = [[UIButton alloc] init];
        self.recordFilterBtn.frame = CGRectMake(SCREEN_WIDTH / 2 - 50, 16, 100, 18);
//        self.recordFilterBtn.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
        [self.recordFilterBtn setTitle:@"查看更多 >" forState:UIControlStateNormal];
        [self.recordFilterBtn setTitleColor:RGB(222, 222, 222) forState:UIControlStateNormal];
        self.recordFilterBtn.titleLabel.font = FONT_PingFang_Light(14);
        [self.recordFilterBtn addTarget:self action:@selector(recordFilterClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_footView addSubview:self.recordFilterBtn];
    }
    return _footView;
}

- (void)recordFilterClicked:(UIButton *)button {
    [self.delegate didRecordFilterButton:button];
}

@end
