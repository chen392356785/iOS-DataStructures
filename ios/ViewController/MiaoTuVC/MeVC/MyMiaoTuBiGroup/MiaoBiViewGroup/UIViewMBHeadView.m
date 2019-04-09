//
//  UIViewMBHeadView.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/12/17.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "UIViewMBHeadView.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@implementation CircleItem
-(instancetype)init {
    if (self = [super init]) {
        _lineWidth = kWidth(29);
        _percentage = 1.0;
    }
    return self;
}
@end

@interface PieView() {
    double _startAngle;
    double _endAngle;
}
@property (nonatomic) CGFloat total;
@property (nonatomic) CAShapeLayer *bgCircleLayer;

@end


@implementation PieView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _startAngle = 0;
        _endAngle = 0;
    }
    return self;
}
- (void)drawRect:(CGRect)rect {
    self.layer.backgroundColor = [UIColor redColor].CGColor;
    if (_circleItemArray == nil) {
        return;
    }
    for (int i=0; i<_circleItemArray.count; i++) {
        CircleItem *item = _circleItemArray[i];
        [self drawCircleLineRect:rect circleItem:item];
    }
}
- (void)drawCircleLineRect:(CGRect)rect circleItem:(CircleItem *)circleItem  {
    _endAngle = _startAngle + circleItem.percentage*360.0;
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //绘制路径: 圆形(中心坐标200、200、半径100、起点弧度0、终点弧度2PI、画的方向0逆1正) 第五个参数 是startAngle开始的角度
    CGContextAddArc(ctx,  rect.size.width/2, rect.size.height/2, rect.size.width/2 - circleItem.lineWidth/2, DEGREES_TO_RADIANS(_startAngle), DEGREES_TO_RADIANS(_endAngle), 0);
    //    CGContextSetRGBStrokeColor(ctx, circleItem.r, circleItem.g, circleItem.b, 1.0);
    CGContextSetStrokeColorWithColor(ctx, circleItem.color.CGColor);
    CGContextSetLineWidth(ctx, circleItem.lineWidth);//线条宽度
    CGContextStrokePath(ctx);
    
    _startAngle =_endAngle;
}
- (void)dealloc
{
    [self.layer removeAllAnimations];
}
@end



@interface UIViewMBHeadView () {
    NSArray *colorArr;
    NSMutableArray *circleArr;
}

@end

@implementation UIViewMBHeadView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kColor(@"#F8F5F5");
        [self createSubViews];
    }
    return self;
}
- (void) createSubViews {
    
    colorArr = @[kColor(@"#FFBA55"),kColor(@"#11D0AA"),kColor(@"#7CADFA"),kColor(@"#FD6E8A"),kColor(@"#F0F0F0")];
    circleArr = [[NSMutableArray alloc] init];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kWidth(12), kWidth(15), iPhoneWidth - kWidth(30), kWidth(14))];
    _titleLabel.textColor = kColor(@"#333333");
    _titleLabel.font = boldFont(font(14));
    _titleLabel.text = @"已获取（本月）";
    [self addSubview:_titleLabel];
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(kWidth(12), kWidth(44), iPhoneWidth - kWidth(24), kWidth(196))];
    _bgView.backgroundColor = [UIColor whiteColor];
    _bgView.layer.cornerRadius = kWidth(8);
    [self addSubview:_bgView];
    
    listLab = [[UILabel alloc] initWithFrame:CGRectMake(_titleLabel.left, self.height - kWidth(15) - kWidth(14), kWidth(65), kWidth(14) + kWidth(9))];
    listLab.textColor = kColor(@"#333333");
    listLab.font = boldFont(font(14));
    listLab.text = @"苗币记录";
    [self addSubview:listLab];
    
    PieView * circleView = [[PieView alloc] initWithFrame:CGRectMake(kWidth(25), kWidth(45), kWidth(115), kWidth(115))];
    _circleView = circleView;
    circleView.layer.borderWidth = kWidth(5);
    circleView.layer.cornerRadius = circleView.height/2.;
    circleView.layer.borderColor = kColor(@"#F0F0F0").CGColor;
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kWidth(56), kWidth(20))];
    _timeLab = label;
    label.text = dateString;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = kColor(@"#B5B5B5");
    label.font = [UIFont systemFontOfSize:font(14)];
    label.center = circleView.center;
    
}
- (void)setCurrentGetMiaotubiArr:(NSArray *)arr {
    [_bgView removeAllSubviews];
    for (int i = 0; i < arr.count; i ++) {
        headModel *model = arr[i];
        UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(_circleView.right + kWidth(34), _circleView.top, kWidth(9), kWidth(9))];
        colorView.layer.cornerRadius = colorView.height/2;
        colorView.clipsToBounds = YES;
        [_bgView addSubview:colorView];
        
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(colorView.right + kWidth(10), kWidth(36) + (kWidth(13)+kWidth(15)) * i, kWidth(100), kWidth(13))];
        titleLab.text = model.rule_name;
        titleLab.font = sysFont(font(13));
        [_bgView addSubview:titleLab];
        
        UILabel *scoreLab = [[UILabel alloc] initWithFrame:CGRectMake(_bgView.width - kWidth(28) - kWidth(55), 0, kWidth(55), kWidth(13))];
        scoreLab.text = model.score;
        scoreLab.font = sysFont(font(15));
        [_bgView addSubview:scoreLab];
        scoreLab.textAlignment = NSTextAlignmentRight;
        scoreLab.text = model.score;
        
        scoreLab.centerY = titleLab.centerY;
        colorView.centerY = titleLab.centerY;
        if (i < colorArr.count) {
            if (![model.rule_code isEqualToString:@"9999"]) {
                CircleItem *item = [[CircleItem alloc] init];
                item.color = colorArr[i];
                item.percentage = [model.baifenbi doubleValue];
                [circleArr addObject:item];
                colorView.backgroundColor = colorArr[i];
            }else {
               colorView.backgroundColor = kColor(@"#F0F0F0");
            }
        }
    }
    [_bgView addSubview:_circleView];
    _circleView.circleItemArray = circleArr;
    [_circleView setNeedsLayout];
    [_bgView addSubview:_timeLab];
}

@end









@implementation SectionHeadView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kColor(@"#F8F5F5");
        [self createSubViews];
    }
    return self;
}
- (void) createSubViews {
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(kWidth(12), 0, iPhoneWidth - kWidth(24), kWidth(54))];
    [self addSubview:_bgView];
    _bgView.backgroundColor = [UIColor whiteColor];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_bgView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(kWidth(8), kWidth(8))];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _bgView.bounds;
    maskLayer.path = maskPath.CGPath;
    _bgView.layer.mask = maskLayer;
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(kWidth(20), 0, kWidth(4), kWidth(14))];
    leftView.backgroundColor = kColor(@"#05C1B0");
    leftView.centerY = _bgView.height/2. + kWidth(2);
    [_bgView addSubview:leftView];
    
    _monthLab = [[UILabel alloc] initWithFrame:CGRectMake(leftView.right + kWidth(6), 0, kWidth(78), kWidth(14))];
    _monthLab.centerY = leftView.centerY;
    _monthLab.text = @"本月";
    _monthLab.font = darkFont(font(14));
    _monthLab.textColor = kColor(@"#333333");
    [_bgView addSubview:_monthLab];
    
    _getSouLab = [[UILabel alloc] initWithFrame:CGRectMake(_bgView.width - kWidth(125) - kWidth(23), 0, kWidth(60), kWidth(14))];
    _getSouLab.centerY = leftView.centerY;
    _getSouLab.text = @"获取  14";
    _getSouLab.font = sysFont(font(14));
    _getSouLab.textColor = kColor(@"#333333");
    [_bgView addSubview:_getSouLab];
    
    _useLab = [[UILabel alloc] initWithFrame:CGRectMake(_getSouLab.right , 0, kWidth(60), kWidth(14))];
    _useLab.centerY = leftView.centerY;
    _useLab.text = @"获取  14";
    _useLab.textColor = kColor(@"#333333");
    _useLab.textAlignment = NSTextAlignmentRight;
    _useLab.font = sysFont(font(14));
    [_bgView addSubview:_useLab];
}

- (void)updataMyMiaoBiModel:(MyMiaoBiModel *)model {
    _monthLab.text = model.month;
    NSString *getStr = [NSString stringWithFormat:@"获取  %@",model.getScore];
    NSString *useStr = [NSString stringWithFormat:@"使用  %@",model.useScore];
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:getStr];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:kColor(@"#FFB400") range:NSMakeRange(4, model.getScore.length)];
    [attributedStr addAttribute:NSFontAttributeName value:sysFont(font(15))  range:NSMakeRange(4, model.getScore.length)];
    _getSouLab.attributedText = attributedStr;
    [_getSouLab sizeToFit];
    
    NSMutableAttributedString *attributedStr2 = [[NSMutableAttributedString alloc]initWithString:useStr];
    [attributedStr2 addAttribute:NSForegroundColorAttributeName value:kColor(@"#FF3C0A") range:NSMakeRange(4, model.useScore.length)];
    [attributedStr2 addAttribute:NSFontAttributeName value:sysFont(font(15))  range:NSMakeRange(4, model.useScore.length)];
    _useLab.attributedText = attributedStr2;
    [_useLab sizeToFit];
    _useLab.origin = CGPointMake(_getSouLab.right + kWidth(5), _getSouLab.top);
}


@end








@implementation SectionFootView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kColor(@"#F8F5F5");
        [self createSubViews];
    }
    return self;
}
- (void) createSubViews {
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(kWidth(12), 0, iPhoneWidth - kWidth(24), kWidth(8))];
    [self addSubview:_bgView];
    _bgView.backgroundColor = [UIColor whiteColor];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_bgView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(kWidth(8), kWidth(8))];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _bgView.bounds;
    maskLayer.path = maskPath.CGPath;
    _bgView.layer.mask = maskLayer;
}
@end

