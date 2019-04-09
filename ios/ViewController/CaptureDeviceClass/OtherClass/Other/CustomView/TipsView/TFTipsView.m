//
//  TFTipsView.m
//  TH
//
//  Created by Tata on 2017/11/15.
//  Copyright © 2017年 羊圈科技. All rights reserved.
//

#import "TFTipsView.h"

#define kTipsText @"文本提示..."
#define kBGViewDefaultW 150
#define kBGViewDefaultH 50
#define kTipsViewDefaultEdge 15

@interface TFTipsView ()

@property (nonatomic, strong) UIView *bGView;
@property (nonatomic, strong) UILabel *tipsLabel;

@property (nonatomic, assign) CGFloat bGViewTop;
@end

@implementation TFTipsView

- (instancetype)initWithType:(TFTipsType)type {
    self.tipsType = type;
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    CGRect rect = [UIScreen mainScreen].bounds;
    self = [super initWithFrame:rect];
    if (self) {
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.1];
    }
    return self;
}

- (void)setTips:(NSString *)tips {
    if (!tips) {
        _tips = kTipsText;
    }else {
        _tips = tips;
    }
}

- (void)setTipsType:(TFTipsType)tipsType {
    if ([self isContantTipsType:tipsType]) {
        _tipsType = tipsType;
    }else {
        _tipsType = tipsType;
    }
}

- (BOOL)isContantTipsType:(TFTipsType)tipsType {
    NSArray *array = @[@(kTFTipsTypeTop),
                       @(kTFTipsTypeCenter),
                       @(kTFTipsTypeBottom)];
    return [array containsObject:@(tipsType)];
}

- (void)show {
    if (!self.tips || [self.tips isEqualToString:@""]) {
        self.tips = kTipsText;
    }
    
    if ([self isContantTipsType:self.tipsType]) {
        [self verifyTipsType:self.tipsType];
        
    }else {
        [self verifyTipsType:kTFTipsTypeCenter];
    }
    
    self.bGView.hidden = NO;
}

- (void)dismiss {
    
    [self.bGView removeFromSuperview];
    
    [self removeFromSuperview];
}

- (void)verifyTipsType:(TFTipsType)tipsType {
    CGSize tipsSize = [self sizeWithTips:self.tips];
    switch (self.tipsType) {
        case kTFTipsTypeTop:
            self.bGViewTop = KtopHeitht + 10;
            [self setUpTipsView];
            break;
        case kTFTipsTypeCenter:
            self.bGViewTop = (iPhoneHeight - (tipsSize.height + kTipsViewDefaultEdge * 2)) / 2;
            [self setUpTipsView];
            break;
        case kTFTipsTypeBottom:
            self.bGViewTop = iPhoneHeight - (tipsSize.height + kTipsViewDefaultEdge * 2) - KTabBarHeight - 10;
            [self setUpTipsView];
            break;
        default:
            break;
    }
}

- (void)setUpTipsView {
    CGSize tipsSize = [self sizeWithTips:self.tips];
    UIView *bGView = [[UIView alloc]init];
    bGView.frame = CGRectMake((iPhoneWidth - tipsSize.width) / 2 - 10, self.bGViewTop, tipsSize.width + 20, tipsSize.height + 30);
    bGView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
    bGView.layer.cornerRadius = 5;
    bGView.layer.masksToBounds = YES;
    bGView.hidden = YES;
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = CGRectMake(0, 0, tipsSize.width + 20, tipsSize.height + 30);
    [bGView addSubview:effectView];
    self.bGView = bGView;
    
    UILabel *tipsLabel = [[UILabel alloc]init];
    tipsLabel.frame = CGRectMake(10, 15, tipsSize.width, tipsSize.height);
    tipsLabel.text = self.tips;
    tipsLabel.font = kLightFont(15);
    tipsLabel.textColor = [UIColor blackColor];
    tipsLabel.textAlignment = NSTextAlignmentLeft;
    tipsLabel.numberOfLines = 0;
    tipsLabel.lineBreakMode = NSLineBreakByCharWrapping;
    self.tipsLabel = tipsLabel;
    [bGView addSubview:tipsLabel];
    
    [self addSubview:bGView];
}

- (CGSize)sizeWithTips:(NSString *)tips {
    if (!tips || [tips isEqualToString:@""]) {
        return CGSizeMake(kBGViewDefaultW, kBGViewDefaultH);
    }
    UIFont *font = kLightFont(15);
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    CGSize size = [tips boundingRectWithSize:CGSizeMake(iPhoneWidth - 40, iPhoneHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return  size;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
