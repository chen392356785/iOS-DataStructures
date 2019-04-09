//
//  TFProgressHUD.m
//  TH
//
//  Created by Tata on 2017/11/13.
//  Copyright © 2017年 羊圈科技. All rights reserved.
//

#import "TFProgressHUD.h"

#define kCycleWH 60
#define kBGViewW 120
#define kBGViewH 100

@interface TFProgressHUD ()

@property (nonatomic, assign) TFProgressHUDType type;
@property (nonatomic, strong) UIView *bGView;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@property (nonatomic, assign) CGFloat titleTop;
@property (nonatomic, assign) CGFloat cycleOffset;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger tipsIndex;
@property (nonatomic, strong) NSArray *tipsArray;

@end

@implementation TFProgressHUD

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpBGView];
    }
    return self;
}

- (id)initWithType:(TFProgressHUDType)type {
    CGRect frame = CGRectMake(0, KtopHeitht, iPhoneWidth, iPhoneHeight - KtopHeitht);
    self.type = type;
    return [self initWithFrame:frame];
}

- (void)setUpBGView {
    UIView *bGView = [[UIView alloc]init];
    bGView.frame = CGRectMake((iPhoneWidth - kBGViewW)/2, (iPhoneHeight - kBGViewH)/ 2 - KtopHeitht, kBGViewW, kBGViewH);
    bGView.backgroundColor = [UIColor lightGrayColor];
    bGView.layer.cornerRadius = 3;
    bGView.layer.masksToBounds = YES;
    bGView.hidden = YES;
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = CGRectMake(0, 0, kBGViewW, kBGViewH);
    [bGView addSubview:effectView];
    self.bGView = bGView;
    [self addSubview:bGView];
}

- (void)setCycleType {
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((kBGViewW - kCycleWH) / 2, (kBGViewH - kCycleWH) / 2 - self.cycleOffset, kCycleWH, kCycleWH)];
    [indicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.indicatorView = indicatorView;
    [self.bGView addSubview:indicatorView];
}

- (void)setTipsType {
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.font = kLightFont(15);
    titleLabel.text = self.message;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.frame = CGRectMake(10, self.titleTop, kBGViewW - 20, 20);
    self.titleLabel = titleLabel;
    [self.bGView addSubview:titleLabel];
}

- (void)setCycleAndTipsType {
    [self setCycleType];
    [self setTipsType];
}

- (void)setMessage:(NSString *)message {
    if (message) {
        _message = message;
    }else {
        _message = @"数据加载中";
    }
}

- (void)setProgressHUDType:(TFProgressHUDType)progressHUDType {
    if ([self isContantType:progressHUDType]) {
        self.type = progressHUDType;
    }else {
        self.type = kTFProgressHUDTypeCycleAndTips;
    }
}

- (BOOL)isContantType:(TFProgressHUDType)type {
    NSArray *array = @[@(kTFProgressHUDTypeCycle),
                       @(kTFProgressHUDTypeTips),
                       @(kTFProgressHUDTypeCycleAndTips)];
    return [array containsObject:@(type)];
}

- (void)show {
    if (!self.message || [self.message isEqualToString:@""]) {
        self.message = @"数据加载中";
    }
    
    if ([self isContantType:self.type]) {
        [self verifyType:self.type];
        if (self.type == kTFProgressHUDTypeTips) {
            self.titleLabel.text = self.tipsArray[self.tipsIndex];
            self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(changeLoadingTip) userInfo:nil repeats:YES];
        }
    }else {
        [self verifyType:kTFProgressHUDTypeCycleAndTips];
    }
    
    self.bGView.hidden = NO;
    [self.indicatorView startAnimating];
}

- (void)dismiss {
    switch (self.type) {
        case kTFProgressHUDTypeCycle:
            [self.indicatorView stopAnimating];
            break;
        case kTFProgressHUDTypeTips:
            [self.timer invalidate];
            self.timer = nil;
            break;
        case kTFProgressHUDTypeCycleAndTips:
            [self.indicatorView stopAnimating];
            break;
        default:
            break;
    }
    [self.bGView removeFromSuperview];
}

- (void)verifyType:(TFProgressHUDType)type {
    switch (type) {
        case kTFProgressHUDTypeCycle:
            self.cycleOffset = 0;
            [self setCycleType];
            break;
        case kTFProgressHUDTypeTips:
            self.titleTop = (kBGViewH - 20) / 2;
            self.bGView.width = [self widthWithTips:[self.tipsArray lastObject]];
            [self setTipsType];
            break;
        case kTFProgressHUDTypeCycleAndTips:
            self.titleTop = 70;
            self.cycleOffset = 10;
            [self setCycleAndTipsType];
            break;
        default:
            break;
    }
}

- (NSArray *)tipsArray {
    if (_tipsArray == nil) {
        NSString *tip1 = self.message;
        NSString *tip2 = [NSString stringWithFormat:@"%@.",self.message];
        NSString *tip3 = [NSString stringWithFormat:@"%@..",self.message];
        NSString *tip4 = [NSString stringWithFormat:@"%@...",self.message];
        _tipsArray = @[tip1,tip2,tip3,tip4];
        self.tipsIndex = 0;
    }
    return  _tipsArray;
}

- (CGFloat)widthWithTips:(NSString *)tips {
    if (!tips || [tips isEqualToString:@""]) {
        return kBGViewW;
    }
    UIFont *font = self.titleLabel.font;
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    CGFloat width = [tips boundingRectWithSize:CGSizeMake(iPhoneWidth, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
    return  width + 20 < kBGViewW ? kBGViewW : width + 20;
}

- (void)changeLoadingTip {
    self.tipsIndex = (self.tipsIndex + 1) % self.tipsArray.count;
    self.titleLabel.text = self.tipsArray[self.tipsIndex];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
