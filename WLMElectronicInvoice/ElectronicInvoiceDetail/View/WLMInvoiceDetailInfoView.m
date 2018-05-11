//
//  WLMInvoiceDetailInfoView.m
//  WLMElectronicInvoice
//
//  Created by 刘光强 on 2018/5/11.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import "WLMInvoiceDetailInfoView.h"

@interface WLMInvoiceDetailInfoView()

@property (nonatomic, copy) NSArray *dataArr;
@end

@implementation WLMInvoiceDetailInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = white_color;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOpacity = 0.3;
        self.layer.shadowOffset = CGSizeMake(0, 3);
        self.layer.cornerRadius = 6;
        self.dataArr = @[@"", @"", @"", @"", @""];
        [self renderViews];
    }
    return self;
}

- (void)renderViews {
    
    UIView *tempView;
    for (NSInteger i = 0; i < self.dataArr.count; i ++) {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(15, 24 + i *(18 + 16), SCREEN_WIDTH - 60, 18);
        [self addSubview:view];
        tempView = view;
        [self renderInfoWithSuperView:view];
    }
    
    UIView *line = [[UIView alloc] init];
    line.frame = CGRectMake(15, MaxY(tempView) + 24, WIDTH(tempView), 2);
    [self addSubview:line];
    [self drawDashLineWithView:line];
    
    for (NSInteger i = 0; i < 2; i ++) {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(15, MaxY(line) + i *(18 + 16) + 24, SCREEN_WIDTH - 60, 18);
        [self addSubview:view];
        [self renderInfoWithSuperView:view];
    }
    
    UIImageView *image = [[UIImageView alloc] init];
    image.frame = CGRectMake(0, 320 - 15, SCREEN_WIDTH - 30, 12);
    image.image = UIImageName(@"sawtooth");
    [self addSubview:image];
}

- (void)renderInfoWithSuperView:(UIView *)view {
    UILabel *leftLable = [[UILabel alloc] init];
    leftLable.text = @"发票抬头";
    leftLable.textColor = textGrayColor;
    leftLable.font = H14;
    [view addSubview:leftLable];
    
    [leftLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(15);
        make.centerY.equalTo(view);
    }];
    
    UILabel *rightLable = [[UILabel alloc] init];
    rightLable.text = @"钱包生活(平潭)科技有限公司";
    rightLable.textColor = textDarkGrayColor;
    rightLable.font = H14;
    [view addSubview:rightLable];
    
    [rightLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view).offset(-15);
        make.centerY.equalTo(view);
    }];
}

- (void)drawDashLineWithView:(UIView *)view {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:view.bounds];
    [shapeLayer setPosition:CGPointMake(view.frame.size.width / 2.0, view.frame.size.height)];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    // 设置虚线颜色
    [shapeLayer setStrokeColor:HexRGB(0xDEDEDE).CGColor];
    // 设置虚线宽度
    [shapeLayer setLineWidth: 2];
    [shapeLayer setLineJoin:kCALineJoinRound];
    // 设置虚线的线宽及间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:2], [NSNumber numberWithInt:5], nil]];
    // 创建虚线绘制路径
    CGMutablePathRef path = CGPathCreateMutable();
    // 设置虚线绘制路径起点
    CGPathMoveToPoint(path, NULL, 0, 0);
    // 设置虚线绘制路径终点
    CGPathAddLineToPoint(path, NULL, view.frame.size.width, 0);
    // 设置虚线绘制路径
    [shapeLayer setPath:path];
    CGPathRelease(path);
    // 添加虚线
    [view.layer addSublayer:shapeLayer];
}
@end
