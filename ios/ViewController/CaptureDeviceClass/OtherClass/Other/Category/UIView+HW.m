//
//  UIView+HW.m
//  HW_微博
//
//  Created by 胡伟 on 16/1/16.
//  Copyright © 2016年 胡伟. All rights reserved.
//

#import "UIView+HW.h"

@implementation UIView (HW)

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    //    self.width = size.width;
    //    self.height = size.height;
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}
- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    
    center.x = centerX;
    self.center = center;
    
    
}
- (CGFloat)centerX
{
    return self.center.x;
    
}
- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    
    center.y = centerY;
    self.center = center;
    
    
}
- (CGFloat)centerY
{
    return self.center.y;
    
}
//+ (UIView *)setupNavbarTitleView:(NSString *)title{
//    
//    UILabel *titleLabel = [[UILabel alloc] init];
//    titleLabel.text = title;
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.bounds = CGRectMake(0, 0, 100, 25);
//    titleLabel.textColor = [UIColor whiteColor];
//    titleLabel.font = kLightFont(17);
//    return titleLabel;
//    
//}

//+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
//{
//    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//    [shapeLayer setBounds:lineView.bounds];
//    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
//    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
//    //  设置虚线颜色为blackColor
//    [shapeLayer setStrokeColor:lineColor.CGColor];
//    //  设置虚线宽度
//    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
//    [shapeLayer setLineJoin:kCALineJoinRound];
//    //  设置线宽，线间距
//    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
//    //  设置路径
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathMoveToPoint(path, NULL, 0, 0);
//    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(lineView.frame), 0);
//    [shapeLayer setPath:path];
//    CGPathRelease(path);
//    //  把绘制好的虚线添加上来
//    [lineView.layer addSublayer:shapeLayer];
//}

//- (void)addScaleAnimation
//{
//    CAKeyframeAnimation *k = [CAKeyframeAnimation  animationWithKeyPath:@"transform.scale"];
//    k.values = @[@(0.2),@(1.0),@(1.3)];
//    k.keyTimes = @[@(0.0),@(0.5),@(0.8),@(0.8)];
//    k.calculationMode = kCAAnimationLinear;
//    [self.layer addAnimation:k forKey:@"SHOW"];
//}

//- (void)addLeftOutAnimation{
//
////    UIWindow *shareWidnow=[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
////    shareWidnow.windowLevel = UIWindowLevelAlert;
////    [shareWidnow becomeKeyWindow];
////    [shareWidnow makeKeyAndVisible];
////    [shareWidnow addSubview:self];
////
//
//
//
//}
//
//- (UIViewController*)getViewControllerFromView:(UIView *)view {
//    for (UIView* next = [view superview]; next; next = next.superview) {
//        UIResponder* nextResponder = [next nextResponder];
//        if ([nextResponder isKindOfClass:[UINavigationController class]]) {
//            return (UIViewController*)nextResponder;
//        }
//    }
//    return nil;
//}


@end
