//
//  MTActivesGridViewCell.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/6/24.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "MTActivesGridViewCell.h"

@interface MTActivesGridViewCell () {
    UIAsyncImageView *IconImageView;
}

@end

@implementation MTActivesGridViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _minTrackColor = [UIColor whiteColor];
        _maxTrackColors = @[(__bridge id)[UIColor redColor].CGColor,(__bridge id)[UIColor redColor].CGColor];
        IconImageView = [[UIAsyncImageView alloc] init];
        [self addSubview:IconImageView];
    }
    return self;
}
- (void)layoutSubviews {
    [self initSubLayer];
    [IconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self).mas_offset(3);
        make.width.mas_equalTo(self).mas_offset(-6);
        make.height.mas_equalTo(self).mas_offset(-6);
    }];
    IconImageView.layer.cornerRadius = (self.frame.size.width - 6.0f)/2.0;
}
#pragma mark - 创建Layer层
- (void)initSubLayer {
    float viW = CGRectGetWidth(self.frame);
    float viH = CGRectGetHeight(self.frame);
    
    /* 设置默认值 */
    
    if (_lineW == 0) {
        _lineW = 3;
    }
    if (!_minTrackColor) {
        _minTrackColor = [UIColor whiteColor];
    }
    if (!_maxTrackColors) {
        _maxTrackColors = @[(__bridge id)[UIColor redColor].CGColor,(__bridge id)[UIColor greenColor].CGColor,(__bridge id)[UIColor blueColor].CGColor,(__bridge id)[UIColor cyanColor].CGColor,(__bridge id)[UIColor purpleColor].CGColor,(__bridge id)[UIColor brownColor].CGColor,(__bridge id)[UIColor orangeColor].CGColor,(__bridge id)[UIColor yellowColor].CGColor];
    }
    /*----------*/
    float ovalW = viW - _lineW;
    float ovalH = viH - _lineW;
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(_lineW/2, _lineW/2, ovalW, ovalH)];
    //    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(viW/2, viH/2) radius:ovalW/2 startAngle:-M_PI_2 endAngle:3.0/2*M_PI clockwise:YES];
    
    if (!_progressLayer) {
        _borderLayer = [CAShapeLayer layer];
        _borderLayer.fillColor = [UIColor clearColor].CGColor;
        _borderLayer.strokeColor = _minTrackColor.CGColor;
        _borderLayer.lineWidth = _lineW;
        [self.layer addSublayer:_borderLayer];
        
        NSArray *locations = [self getLocations];
        
        _colorLayer = [CAGradientLayer layer];
        _colorLayer.colors = _maxTrackColors;
        _colorLayer.locations = locations;
        _colorLayer.startPoint = CGPointMake(0, 0.5);
        _colorLayer.endPoint = CGPointMake(1, 0.5);
        [self.layer addSublayer:_colorLayer];
        
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.fillColor = [UIColor clearColor].CGColor;
        _progressLayer.strokeColor = [UIColor whiteColor].CGColor;
        _progressLayer.lineWidth = _lineW;
        _colorLayer.mask = _progressLayer;
        
        _progressLayer.strokeStart = 0;
        [self setProgress:_progress];
    }
    if (viW != viH) {
        //        如果是椭圆，则不旋转进度条
        _borderLayer.position = CGPointMake(0, 0);
        _borderLayer.transform = CATransform3DMakeRotation(0, 0, 0, 1);
        
        _progressLayer.position = CGPointMake(0, 0);
        _progressLayer.transform = CATransform3DMakeRotation(0, 0, 0, 1);
    }else{
        _borderLayer.position = CGPointMake(0, viH);
        _borderLayer.transform = CATransform3DMakeRotation(-90*M_PI/180, 0, 0, 1);
        
        _progressLayer.position = CGPointMake(0, viH);
        _progressLayer.transform = CATransform3DMakeRotation(-90*M_PI/180, 0, 0, 1);
    }
    _borderLayer.path = path.CGPath;
    
    _colorLayer.frame = CGRectMake(0, 0, viW, viH);
    
    _progressLayer.path = path.CGPath;
}
#pragma mark - 重构
- (NSArray *)getLocations {
    if (!_maxTrackColors) {
        return nil;
    }
    NSMutableArray *locations = [NSMutableArray new];
    float tempLocation = 1.0/_maxTrackColors.count;
    float tempAdd = 0.0;
    for (int i = 0; i < _maxTrackColors.count; i ++) {
        tempAdd += tempLocation;
        [locations addObject:[NSNumber numberWithFloat:tempAdd]];
    }
    return locations;
}

#pragma mark - 重写set方法
- (void)setLineW:(float)lineW {
    _lineW = lineW;
    if (_borderLayer) {
        _borderLayer.lineWidth = lineW;
    }
    if (_progressLayer) {
        _progressLayer.lineWidth = lineW;
    }
    [self initSubLayer];
}

- (void)setMinTrackColor:(UIColor *)minTrackColor {
    _minTrackColor = minTrackColor;
    if (_borderLayer) {
        _borderLayer.strokeColor = minTrackColor.CGColor;
    }
}

- (void)setMaxTrackColors:(NSArray *)maxTrackColors {
    _maxTrackColors = maxTrackColors;
    if (_colorLayer) {
        _colorLayer.colors = maxTrackColors;
        _colorLayer.locations = [self getLocations];
    }
}

- (void)setProgress:(float)progress {
    progress = MIN(progress, 100);
    progress = MAX(progress, 0);
    _progress = progress;
    /* 取消动画，使用CALayer自带隐性动画 */
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.8f];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    CAShapeLayer *extractedExpr = _progressLayer;
    extractedExpr.strokeEnd = progress/100.0;
    [CATransaction commit];

}
- (void)setIconImagUrl:(NSString *)imgUrlStr andProgress:(NSString *)progressStr {
    NSString *imageUrlStr = [NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,imgUrlStr];
    [IconImageView setImageAsyncWithURL:imageUrlStr placeholderImage:Image(@"tx.png")];
    [self setProgress:[progressStr floatValue]];
}

@end
