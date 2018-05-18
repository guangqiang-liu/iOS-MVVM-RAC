//
//  WLMRecordListCell.m
//  WLMElectronicInvoice
//
//  Created by Qianbao on 2018/5/10.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import "WLMRecordListCell.h"

static const CGFloat kRecordHeight = 140.f;

@interface WLMRecordListCell()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *invoicePrice;
@property (nonatomic, strong) UILabel *invoiceTitle;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *applyTime;
@property (nonatomic, strong) UILabel *invoiceStatus;
@property (nonatomic, strong) UIImageView *recordImg;

@end

@implementation WLMRecordListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = bgColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self renderViews];
    }
    return self;
}

- (void)renderViews {
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.invoicePrice];
    [self.bgView addSubview:self.invoiceTitle];
    [self.bgView addSubview:self.lineView];
    [self.bgView addSubview:self.applyTime];
    [self.bgView addSubview:self.invoiceStatus];
    [self.bgView addSubview:self.recordImg];
}

- (void)setMerchantModel:(WLBaseModel *)merchantModel {
    
}

+ (CGFloat)cellHeight; {
    return kRecordHeight;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.frame = CGRectMake(15, 4, SCREEN_WIDTH - 30, 132);
        _bgView.backgroundColor = white_color;
        _bgView.layer.cornerRadius = 5;
        
        _bgView.layer.shadowColor = [[UIColor lightGrayColor] CGColor];
        _bgView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f); //[水平偏移, 垂直偏移]
        _bgView.layer.shadowOpacity = 0.2f; // 0.0 ~ 1.0 的值
        _bgView.layer.shadowRadius = 4.0f; // 阴影发散的程度
        _bgView.clipsToBounds = NO;
    }
    return _bgView;
}

- (UILabel *)invoicePrice {
    if (!_invoicePrice) {
        _invoicePrice = [[UILabel alloc] init];
        _invoicePrice.frame = CGRectMake(16, 16, 160, 22);
        _invoicePrice.textColor = RGB(67, 67, 67);
        _invoicePrice.font = FONT_PingFang_Regular(18);
        _invoicePrice.textAlignment = NSTextAlignmentLeft;
        _invoicePrice.text = @"发票金额：32.50元";
    }
    return _invoicePrice;
}

- (UILabel *)invoiceTitle {
    if (!_invoiceTitle) {
        _invoiceTitle = [[UILabel alloc] init];
        _invoiceTitle.frame = CGRectMake(16, 46, 240, 18);
        _invoiceTitle.textColor = RGB(102, 102, 102);
        _invoiceTitle.font = FONT_PingFang_Light(14);
        _invoiceTitle.textAlignment = NSTextAlignmentLeft;
        _invoiceTitle.text = @"钱包生活(平潭)科技有限公司上分公司";
    }
    return _invoiceTitle;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = RGB(222, 222, 222);
        _lineView.frame = CGRectMake(16, 80, SCREEN_WIDTH - 62, 0.5);
//        [self drawRect:_lineView.frame];
    }
    return _lineView;
}

- (UILabel *)applyTime {
    if (!_applyTime) {
        _applyTime = [[UILabel alloc] init];
        _applyTime.frame = CGRectMake(16, 98, SCREEN_WIDTH / 3, 18);
        _applyTime.textColor = HexRGB(0x999999);
        _applyTime.font = FONT_PingFang_Light(14);
        _applyTime.textAlignment = NSTextAlignmentLeft;
        _applyTime.text = @"申请时间：2018.4.18";
    }
    return _applyTime;
}

- (UILabel *)invoiceStatus {
    if (!_invoiceStatus) {
        _invoiceStatus = [[UILabel alloc] init];
        _invoiceStatus.frame = CGRectMake(SCREEN_WIDTH - 98, 98, SCREEN_WIDTH / 3, 18);
        _invoiceStatus.textColor = HexRGB(0x999999);
        _invoiceStatus.font = FONT_PingFang_Light(14);
        _invoiceStatus.textAlignment = NSTextAlignmentLeft;
        _invoiceStatus.text = @"待开票";
    }
    return _invoiceStatus;
}

- (UIImageView *)recordImg {
    if (!_recordImg) {
        _recordImg = [[UIImageView alloc] init];
        _recordImg.frame = CGRectMake(SCREEN_WIDTH - 98, 0, 68, 68);
        _recordImg.image = UIImageName(@"einvoice_mange_sample");
    }
    return _recordImg;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    //设置虚线颜色
    CGContextSetStrokeColorWithColor(currentContext, RGB(240, 89, 78).CGColor);
    //设置虚线宽度
    CGContextSetLineWidth(currentContext, 1);
    //设置虚线绘制起点
    CGContextMoveToPoint(currentContext, 16, self.frame.size.height/2);
    //设置虚线绘制终点
    CGContextAddLineToPoint(currentContext, self.frame.origin.x + self.frame.size.width - 16, self.frame.size.height/2);
    //设置虚线排列的宽度间隔:下面的arr中的数字表示先绘制3个点再绘制1个点
    CGFloat arr[] = {3,2};
    //下面最后一个参数“2”代表排列的个数。
    CGContextSetLineDash(currentContext, 0, arr, 2);
    CGContextDrawPath(currentContext, kCGPathStroke);
}

/**
 ** lineView:       需要绘制成虚线的view
 ** lineLength:     虚线的宽度
 ** lineSpacing:    虚线的间距
 ** lineColor:      虚线的颜色
 **/
- (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
