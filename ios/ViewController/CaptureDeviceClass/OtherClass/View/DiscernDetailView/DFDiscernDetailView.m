//
//  DFDiscernDetailView.m
//  DF
//
//  Created by Tata on 2017/12/1.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFIconConstant.h"
#import "DFDiscernDetailView.h"

@interface DFDiscernDetailView ()

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) UIView *toolView;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UIButton *shareButton;

@end

@implementation DFDiscernDetailView

- (void)addSubviews {
    [super addSubviews];
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.webView];
    [self addSubview:self.toolView];
    [self.toolView addSubview:self.confirmButton];
    [self.toolView addSubview:self.shareButton];
}

- (void)defineLayout {
    [super defineLayout];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationView.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.toolView.mas_top);
    }];
    
    [self.toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).with.offset(self.toolView.cas_marginBottom / TTUIScale());
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@(self.toolView.cas_sizeHeight));
    }];
    
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.toolView.mas_top);
        make.left.equalTo(self.toolView.mas_left);
        make.width.equalTo(@(self.confirmButton.cas_sizeWidth));
        make.bottom.equalTo(self.toolView.mas_bottom);
    }];
    
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.toolView.mas_top);
        make.left.equalTo(self.confirmButton.mas_right);
        make.right.equalTo(self.toolView.mas_right);
        make.bottom.equalTo(self.toolView.mas_bottom);
    }];
}

- (void)creatViews {
    [super creatViews];
    
    self.navigationView.backButton.cas_styleClass = @"navigation_back";
    [self.navigationView.backButton setImage:kImage(BackArrowGreen) forState:UIControlStateNormal];
    self.navigationView.titleLabel.cas_styleClass = @"navigation_title";
    self.navigationView.forwardButton.cas_styleClass = @"navigation_forward";
    [self.navigationView.forwardButton setImage:kImage(CameraWhiteIcon) forState:UIControlStateNormal];
    self.navigationView.lineView.cas_styleClass = @"navigation_line";
    
    self.webView = [[UIWebView alloc]init];
    self.webView.cas_styleClass = @"discernDetail_webView";
    
    self.toolView = [[UIView alloc]init];
    self.toolView.cas_styleClass = (iPhoneHeight == kHeightX) ? @"discernDetail_toolView_X" : @"discernDetail_toolView";
    
    self.confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.confirmButton.cas_styleClass = @"discernDetail_confirmButton";
    [self.confirmButton setTitle:@"是此花" forState:UIControlStateNormal];
    [self.confirmButton setTitleColor:THBaseColor forState:UIControlStateNormal];
    
    self.shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shareButton.cas_styleClass = @"discernDetail_shareButton";
    [self.shareButton setTitle:@"分享识花结果" forState:UIControlStateNormal];
    [self.shareButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
