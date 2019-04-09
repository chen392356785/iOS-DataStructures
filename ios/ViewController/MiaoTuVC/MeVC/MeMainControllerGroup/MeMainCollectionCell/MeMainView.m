//
//  MeMainView.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/12/15.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "MeMainView.h"


@implementation MeMainView

@end


@implementation MeMainKefuView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = kWidth(7);
        [self addlayoutSubView];
        [self configuration];
    }
    return self;
}
- (void) addlayoutSubView {
    UIButton *cancelBut = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelBut.frame = CGRectMake(self.width - kWidth(28), 0, kWidth(28), kWidth(26));
    [cancelBut setBackgroundImage:kImage(@"guanbi") forState:UIControlStateNormal];
    [cancelBut addTarget:self action:@selector(CancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBut];
    
    titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, kWidth(15), self.width, kWidth(16))];
    [self addSubview:titleLab];
    
    _dashedView = [[UIView alloc] initWithFrame:CGRectMake(kWidth(26), kWidth(79), kWidth(210), kWidth(108))];
    [self addSubview:_dashedView];
   
    infoLab = [[UILabel alloc] initWithFrame:CGRectMake(0, _dashedView.top - kWidth(27)/2, kWidth(194), kWidth(27))];
    [self addSubview:infoLab];
    
    numLab = [[UILabel alloc] initWithFrame:CGRectMake(0, infoLab.bottom + kWidth(41), _dashedView.width, kWidth(13))];
    [self addSubview:numLab];
    
    
    copyBut = [UIButton buttonWithType:UIButtonTypeSystem];
    copyBut.frame = CGRectMake(0, _dashedView.bottom + kWidth(77), kWidth(206), kWidth(30));
    [self addSubview:copyBut];
}
- (void) configuration {
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = darkFont(font(16));
    titleLab.text = @"联系客服";
    titleLab.textColor = kColor(@"#333333");
    
    _dashedView.centerX = self.centerX;
    _dashedView.backgroundColor = [UIColor whiteColor];
    [_dashedView.layer addSublayer:self.shapeLayer];
    
    infoLab.backgroundColor = kColor(@"#9573E0");
    infoLab.textColor = kColor(@"#FFFEFE");
    infoLab.font = boldFont(font(13));
    infoLab.centerX = _dashedView.centerX;
    infoLab.text = @"复制框内微信号联系客服";
    infoLab.textAlignment = NSTextAlignmentCenter;
    
    numLab.text = @"17189907867";
    numLab.textAlignment = NSTextAlignmentCenter;
    numLab.font = sysFont(font(16));
    numLab.textColor = kColor(@"#333333");
    numLab.centerX = _dashedView.centerX;
    numLab.centerY = _dashedView.centerY;
    
    copyBut.backgroundColor = kColor(@"#9573E0");
    [copyBut addTarget:self action:@selector(copyAction) forControlEvents:UIControlEventTouchUpInside];
    [copyBut setTitle:@"一键复制" forState:UIControlStateNormal];
    [copyBut setTitleColor:kColor(@"#FEFEFE") forState:UIControlStateNormal];
    copyBut.titleLabel.font = darkFont(font(16));
	copyBut.layer.cornerRadius = copyBut.height/2.0f;
    copyBut.centerX = numLab.centerX;
    
}

-(CAShapeLayer *)shapeLayer{
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.strokeColor = kColor(@"#9573E0").CGColor;       //绘线颜色
        _shapeLayer.fillColor = [UIColor whiteColor].CGColor;       //layer底色
        _shapeLayer.path = [UIBezierPath bezierPathWithRect:_dashedView.bounds].CGPath;
        _shapeLayer.frame = _dashedView.bounds;
        _shapeLayer.lineWidth = 1.f;
        _shapeLayer.lineCap = @"square";
        _shapeLayer.lineDashPattern = @[@(kWidth(6)), @(kWidth(4))];
    }
    return _shapeLayer;
}

- (void)setkefuNum:(NSString *)kefuStr {
    numLab.text = kefuStr;
}
- (void) copyAction {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = numLab.text;
    [IHUtility addSucessView:@"复制成功" type:0.5];
    if (self.CancelBlock) {
        self.CancelBlock();
    }
    [self performSelector:@selector(OpenWX) withObject:nil afterDelay:1];
}
- (void) OpenWX {
    NSURL *url = [NSURL URLWithString:@"weixin://"];
    //先判断是否能打开该url
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        //打开url
        [[UIApplication sharedApplication] openURL:url];
    }else {
        //给个提示或者做点别的事情
        NSLog(@"U四不四洒，没安装WXApp，怎么打开啊！");
    }
}
- (void) CancelAction {
    if (self.CancelBlock) {
        self.CancelBlock();
    }
}
///**
// ** lineView:       需要绘制成虚线的view
// ** lineLength:     虚线的宽度
// ** lineSpacing:    虚线的间距
// ** lineColor:      虚线的颜色
// **/
//- (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor {
//    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//    [shapeLayer setBounds:lineView.bounds];
//    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
//    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
//    
//    //  设置虚线颜色为
//    [shapeLayer setStrokeColor:lineColor.CGColor];
//    
//    //  设置虚线宽度
//    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
//    [shapeLayer setLineJoin:kCALineJoinRound];
//    
//    //  设置线宽，线间距
//    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
//    
//    //  设置路径
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathMoveToPoint(path, NULL, 0, 0);
//    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(lineView.frame), 0);
//    
//    [shapeLayer setPath:path];
//    CGPathRelease(path);
//    
//    //  把绘制好的虚线添加上来
//    [lineView.layer addSublayer:shapeLayer];
//}



@end
