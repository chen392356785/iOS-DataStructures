//
//  XHFriendlyLoadingView.m
//  XHFriendlyLoadingView
//
//  Created by 曾 宪华 on 13-12-31.
//  Copyright (c) 2013年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507. All rights reserved.
//

#import "XHFriendlyLoadingView.h"

@interface XHFriendlyLoadingView () {
    UIImageView *_animationImageView ;
}


@property (nonatomic, strong) UILabel *loadingLabel;

@property (nonatomic, strong) UIButton *reloadButton;

@end

@implementation XHFriendlyLoadingView

- (void)reloadButtonClicked:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    if (self.reloadButtonClickedCompleted) {
        self.reloadButtonClickedCompleted(weakSelf.reloadButton);
    }
}

- (void)_setup {
    self.backgroundColor = [UIColor colorWithRed:(233 / 255.f) green:(239 / 255.f) blue:(239 / 255.f) alpha:1.f];
    
    NSMutableArray *imgageArray=[[NSMutableArray alloc]init];
    for ( int i=1; i<20; i++) {
        NSString *str=[NSString stringWithFormat:@"图层 %d",i];
        UIImage *img=Image(str);
        [imgageArray addObject:img];
    }
    NSString *str = [NSString stringWithFormat:@"图层 %d.png",1];
    UIImage *img = Image(str);
    
    UIImageView *animationImageView = [[UIImageView alloc]initWithFrame:CGRectMake(WindowWith/2-img.size.width/2, WindowHeight/2-img.size.height/2-90, img.size.width, img.size.height)];
    _animationImageView=animationImageView;
    animationImageView.animationImages = imgageArray;//将序列帧数组赋给UIImageView的animationImages属性
    animationImageView.animationDuration = 2;//设置动画时间
    animationImageView.animationRepeatCount = 0;//设置动画次数 0 表示无限
    [animationImageView startAnimating];//开始播放动画
    
    
    
    _loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, animationImageView.bottom, CGRectGetWidth(self.frame), 44)];
    self.loadingLabel.alpha = 0.;
    self.loadingLabel.font=sysFont(15);
    self.loadingLabel.textAlignment=NSTextAlignmentCenter;
    self.loadingLabel.textColor = cGreenColor;
    
    _reloadButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.reloadButton.alpha = 0.;
    [self.reloadButton setBackgroundImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
    [self.reloadButton addTarget:self action:@selector(reloadButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self addSubview: animationImageView];
    [self addSubview:self.loadingLabel];
    [self addSubview:self.reloadButton];
}

+ (instancetype)shareFriendlyLoadingView {
    static XHFriendlyLoadingView *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGRect rect=CGRectMake(0, 0, WindowWith, WindowHeight);
        
        instance = [[XHFriendlyLoadingView alloc] initWithFrame:rect];
    });
    return instance;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self _setup];
    }
    return self;
}

- (void)dealloc {
    self.reloadButtonClickedCompleted = nil;
 
    self.loadingLabel = nil;
    self.reloadButton = nil;
}
//
//- (CGRect)_setpLoadingLabelForWidth:(CGFloat)width {
//    CGRect loadingLabelFrame = self.loadingLabel.frame;
//    loadingLabelFrame.size.width = width;
//    loadingLabelFrame.origin.x = 0;
//    loadingLabelFrame.origin.y = CGRectGetHeight(self.frame) / 2.0 - CGRectGetHeight(loadingLabelFrame) / 2.0;
//    return loadingLabelFrame;
//}
//
//

- (void)_setupAllUIWithAlpha {
    self.loadingLabel.alpha = 0.;
    self.reloadButton.alpha = 0.;
 
}

- (void)showFriendlyLoadingViewWithText:(NSString *)text loadingAnimated:(BOOL)animated {
    [self _setupAllUIWithAlpha];
    if (animated) {
        [self showLoadingAnimationWithText:text];
    } else {
        [self showPromptViewWithText:text];
    }
}

/**
 * 纯文字提示
 * @param promptString 要显示的提示字符串
 */
- (void)showPromptViewWithText:(NSString *)promptString {
 
    
    // 只是显示一行文本
   // self.loadingLabel.frame = [self _setpLoadingLabelForWidth:CGRectGetWidth(self.frame)];
    self.loadingLabel.textAlignment = NSTextAlignmentCenter;
    self.loadingLabel.text = promptString;
    
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.reloadButton.alpha = 0.;
        self.loadingLabel.alpha = 1.;
    } completion:^(BOOL finished) {
        
    }];
}

/**
 * 页面加载动画及信息提示
 * @param loadingString 要显示的提示字符串
 */
- (void)showLoadingAnimationWithText:(NSString *)loadingString {
 
 
  //  self.loadingLabel.textAlignment = NSTextAlignmentLeft;
    
    self.loadingLabel.text = loadingString;

    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.reloadButton.alpha = 0.;
        self.loadingLabel.alpha = 1.;
		self->_animationImageView.alpha=1;
    } completion:^(BOOL finished) {
        
    }];
}

/**
 * 隐藏页面加载动画及信息提示
 */
//- (void)hideLoadingView {
//    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        self.alpha = 0.;
//    } completion:^(BOOL finished) {
//        [self removeFromSuperview];
//    }];
//}

/**
 * 重新加载提示
 * @param reloadString 要显示的提示字符串
 */
- (void)showReloadViewWithText:(NSString *)reloadString {
    [self _setupAllUIWithAlpha];
  
//    CGRect loadingLabelFrame = [self _setpLoadingLabelForWidth:CGRectGetWidth(self.bounds)];
    self.loadingLabel.textAlignment = NSTextAlignmentCenter;
  //  self.loadingLabel.frame = loadingLabelFrame;
    self.loadingLabel.text = reloadString;
    
    // 按钮和提示
    CGPoint reloadButtonCenter = CGPointMake(CGRectGetWidth(self.bounds) / 2.0, self.loadingLabel.center.y - (CGRectGetHeight(self.loadingLabel.frame) / 2.0 + CGRectGetHeight(self.reloadButton.frame) / 2.0));
    self.reloadButton.center = reloadButtonCenter;
    
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.reloadButton.alpha = 1.;
        self.loadingLabel.alpha = 1.;
		self->_animationImageView.alpha=  0;
    } completion:^(BOOL finished) {
        
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
