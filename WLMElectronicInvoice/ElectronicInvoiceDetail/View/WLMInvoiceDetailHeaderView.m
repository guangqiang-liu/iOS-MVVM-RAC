//
//  WLMInvoiceDetailHeaderView.m
//  WLMElectronicInvoice
//
//  Created by 刘光强 on 2018/5/11.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import "WLMInvoiceDetailHeaderView.h"

@interface WLMInvoiceDetailHeaderView()

@property (nonatomic, copy) NSArray *dataArr;
@end

@implementation WLMInvoiceDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 6;
        self.backgroundColor = white_color;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOpacity = 0.3;
        self.layer.shadowOffset = CGSizeMake(0, 3);
        self.dataArr = @[@"", @"", @""];
        [self renderViews];
    }
    return self;
}

- (void)renderViews {
    [super renderViews];
    
    UIView *tempView;
    for (NSInteger i = 0; i < self.dataArr.count; i ++) {
        UIView *boxView = [[UIView alloc] init];
        boxView.frame = CGRectMake(15, 24 + i * (29 + 24), SCREEN_WIDTH - 60, 18);
        boxView.backgroundColor = white_color;
        tempView = boxView;
        [self addSubview:boxView];
        [self renderInfoViewsWithSuperView:boxView data:@{}];
        
        UIView *boxDot = [[UIView alloc] init];
        boxDot.frame = CGRectMake(17, MaxY(boxView) + 3, 6, 25);
        [self addSubview:boxDot];
        if (i < self.dataArr.count - 1) {
            [self renderDotsWithSuperView:boxDot];
        }
    }
    self.frame = CGRectMake(15, 15, SCREEN_WIDTH - 30, MaxY(tempView) + 24);
}

- (void)renderDotsWithSuperView:(UIView *)view {
    for (NSInteger i = 0; i < 3; i ++) {
        UIView *dot = [[UIView alloc] init];
        dot.frame = CGRectMake(0, i * (6 + 6), 6, 6);
        dot.backgroundColor = HexRGB(0xeeeeee);
        dot.layer.cornerRadius = 3;
        [view addSubview:dot];
    }
}

- (void)renderInfoViewsWithSuperView:(UIView *)view data:(NSDictionary *)data {
    
    UIImageView *redDot = [[UIImageView alloc] init];
    redDot.frame = CGRectMake(0, (18 - 10) / 2, 10, 10);
    redDot.backgroundColor = red_color;
    [view addSubview:redDot];
    
    UILabel *stateLable = [[UILabel alloc] init];
    stateLable.frame = CGRectMake(MaxX(redDot) + 16, 0, 60, 18);
    stateLable.text = @"发起成功";
    stateLable.textColor = textGrayColor;
    stateLable.font = H14;
    [view addSubview:stateLable];
    
    UIView *line = [[UIView alloc] init];
    line.frame = CGRectMake(0, 0, 112, 2);
    [view addSubview:line];
    line.center = CGPointMake(view.bounds.size.width / 2, view.bounds.size.height / 2);
    [self drawDashLineWithView:line];
    
    UILabel *timeLable = [[UILabel alloc] init];
    timeLable.frame = CGRectMake(WIDTH(view) - 94, 0, 94, 18);
    timeLable.text = @"2018.222.000";
    timeLable.textColor = textGrayColor;
    timeLable.font = H14;
    [view addSubview:timeLable];
    
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
