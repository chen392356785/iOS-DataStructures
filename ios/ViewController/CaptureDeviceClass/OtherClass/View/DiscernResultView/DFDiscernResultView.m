//
//  DFDiscernResultView.m
//  DF
//
//  Created by Tata on 2017/11/27.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFIconConstant.h"
#import "DFDiscernResultView.h"
#import "DFDiscernWaitingView.h"
#import "DFDiscernSuccessView.h"
#import "DFDiscernFailureView.h"

@interface DFDiscernResultView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIImageView *moveLineIcon;

@property (nonatomic, strong) DFDiscernWaitingView *waitingView;
@property (nonatomic, strong) DFDiscernSuccessView *successView;
@property (nonatomic, strong) DFDiscernFailureView *failureView;

@end

@implementation DFDiscernResultView

- (void)addSubviews {
    
    [super addSubviews];
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self insertSubview:self.imageView atIndex:0];
    [self.imageView addSubview:self.maskView];
    [self.maskView addSubview:self.moveLineIcon];
    
    [self addSubview:self.waitingView];
    [self addSubview:self.successView];
    [self addSubview:self.failureView];
}

- (void)defineLayout {
    
    [super defineLayout];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(self.imageView.cas_marginTop));
        make.left.equalTo(@(self.imageView.cas_marginLeft));
        make.right.equalTo(@(self.imageView.cas_marginRight));
//        make.height.equalTo(@(self.imageView.cas_sizeHeight));
         make.height.mas_offset(kWidth(249));
    }];
    
    [self.waitingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom);
        make.left.equalTo(@(self.waitingView.cas_marginLeft));
        make.right.equalTo(@(self.waitingView.cas_marginRight));
        make.bottom.equalTo(self.mas_bottom).with.offset(self.waitingView.cas_marginBottom / TTUIScale());
    }];
    [self.successView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom);
        make.left.equalTo(@(self.successView.cas_marginLeft));
        make.right.equalTo(@(self.successView.cas_marginRight));
        make.bottom.equalTo(self.mas_bottom).with.offset(self.successView.cas_marginBottom / TTUIScale());
    }];
    
    [self.failureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom);
        make.left.equalTo(@(self.failureView.cas_marginLeft));
        make.right.equalTo(@(self.failureView.cas_marginRight));
        make.bottom.equalTo(self.mas_bottom).with.offset(self.failureView.cas_marginBottom / TTUIScale());
    }];
}

- (void)creatViews {
    
    [super creatViews];
    
    self.navigationView.backButton.cas_styleClass = @"navigation_back";
    self.navigationView.lineView.cas_styleClass = @"navigation_line_clear";
    [self.navigationView.backButton setImage:kImage(BackArrowWhite) forState:UIControlStateNormal];
    [self.navigationView.backButton setImage:kImage(BackArrowWhite) forState:UIControlStateHighlighted];
    self.navigationView.forwardButton.cas_styleClass = @"navigation_forward";
    [self.navigationView.forwardButton setImage:kImage(CameraBlackIcon) forState:UIControlStateNormal];
    [self.navigationView.forwardButton setImage:kImage(CameraBlackIcon) forState:UIControlStateHighlighted];
    
    self.imageView = [[UIImageView alloc]init];
    self.imageView.cas_styleClass = @"discernResult_imageView";
    
//    self.maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, iPhoneWidth, 235 * TTUIScale())];
    self.maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, iPhoneWidth, kWidth(249))];
    self.maskView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
    
    self.moveLineIcon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 3 * TTUIScale(), kWidth(249))];
    self.moveLineIcon.image = kImage(MoveLineIcon);
    
    self.waitingView = [[DFDiscernWaitingView alloc]init];
    self.waitingView.cas_styleClass = (iPhoneHeight == kHeightX) ? @"discernResult_waitingView_X" : @"discernResult_waitingView";
    
    self.successView = [[DFDiscernSuccessView alloc]init];
    self.successView.cas_styleClass = (iPhoneHeight == kHeightX) ? @"discernResult_successView_X" : @"discernResult_successView";
    
    self.failureView = [[DFDiscernFailureView alloc]init];
    self.failureView.cas_styleClass = (iPhoneHeight == kHeightX) ? @"discernResult_failureView_X" : @"discernResult_failureView";
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
