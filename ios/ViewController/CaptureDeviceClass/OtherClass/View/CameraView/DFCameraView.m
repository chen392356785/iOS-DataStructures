//
//  DFCameraView.m
//  DF
//
//  Created by Tata on 2017/11/27.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFCameraView.h"
#import "DFIconConstant.h"
#import "DFPhotoToolView.h"
#import "DFAlbumToolView.h"


@interface DFCameraView ()

@property (nonatomic, strong) UIButton *infoButton;
@property (nonatomic, strong) UIButton *focusButton;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIScrollView *pinchScrollView;

@property (nonatomic, strong) UIImageView *photoImageView;
@property (nonatomic, strong) UIImageView *flowerImageView;
@property (nonatomic, strong) UIImageView *focusImageView;
@property (nonatomic, strong) UILabel *tipsLabel;
/**滑杆*/
@property (nonatomic,strong) UISlider *trackSlider;

@property (nonatomic, strong) DFPhotoToolView *photoToolView;
@property (nonatomic, strong) DFAlbumToolView *albumToolView;

@end

@implementation DFCameraView

- (void)addSubviews {
    
    [super addSubviews];
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.backgroundView];
    [self.backgroundView addSubview:self.flowerImageView];
    [self.backgroundView addSubview:self.focusImageView];
    [self.backgroundView addSubview:self.tipsLabel];
    [self.backgroundView addSubview:self.photoImageView];
    [self.backgroundView addSubview:self.pinchScrollView];
    [self.backgroundView addSubview:self.trackSlider];
    
    [self.backgroundView addSubview:self.infoButton];
    [self.backgroundView addSubview:self.focusButton];
    
    [self addSubview:self.photoToolView];
    [self addSubview:self.albumToolView];
    
}

- (void)defineLayout {
    
    [super defineLayout];
    
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.photoToolView.mas_top);
    }];
    [self.photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backgroundView.mas_centerX);
        make.centerY.equalTo(self.backgroundView.mas_centerY);
        make.width.equalTo(self.backgroundView.mas_width);
        make.height.equalTo(self.backgroundView.mas_height);
    }];
    
    [self.pinchScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backgroundView.mas_centerX);
        make.centerY.equalTo(self.backgroundView.mas_centerY);
        make.width.equalTo(self.backgroundView.mas_width);
        make.height.equalTo(self.backgroundView.mas_height);
    }];
    //拍摄虚线参考视图
    [self.flowerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backgroundView.mas_centerX);
        make.centerY.equalTo(self.backgroundView.mas_centerY);
        make.width.equalTo(@(self.flowerImageView.cas_sizeWidth));
        make.height.equalTo(@(self.flowerImageView.cas_sizeHeight));
    }];
    self.flowerImageView.hidden = YES;
    //缩放视图滑杆
    [self.trackSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(self.trackSlider.cas_marginRight));
        make.bottom.equalTo(@(self.trackSlider.cas_marginBottom));
        make.width.equalTo(@(self.trackSlider.cas_sizeWidth));
        make.height.equalTo(@(self.trackSlider.cas_sizeHeight));
        
    }];
    //页面提示
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backgroundView.mas_bottom).with.offset(self.tipsLabel.cas_marginBottom);
        make.left.equalTo(@(self.tipsLabel.cas_marginLeft));
        make.right.equalTo(@(self.tipsLabel.cas_marginRight));
        make.height.equalTo(@(self.tipsLabel.cas_sizeHeight));
    }];
    self.tipsLabel.hidden = YES;
    //左侧返回
    [self.infoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(self.infoButton.cas_marginTop));
        make.left.equalTo(@(self.infoButton.cas_marginLeft));
        make.width.equalTo(@(self.infoButton.cas_sizeWidth));
        make.height.equalTo(@(self.infoButton.cas_sizeHeight));
    }];
    //右侧闪光灯
    [self.focusButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.infoButton.mas_top);
        make.right.equalTo(@(self.focusButton.cas_marginRight));
        make.width.equalTo(@(self.focusButton.cas_sizeWidth));
        make.height.equalTo(@(self.focusButton.cas_sizeHeight));
    }];
    //底部拍照部分视图
    [self.photoToolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@(self.photoToolView.cas_sizeHeight));
    }];
    self.photoToolView.backgroundColor = kColor(@"#000000");
    self.photoToolView.alpha = 0.5;
    
    [self.albumToolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@(self.albumToolView.cas_sizeHeight));
    }];
}

- (void)creatViews {
    [super creatViews];
    
    self.navigationView.hidden = YES;
    
    self.backgroundView = [[UIView alloc]init];
    self.backgroundView.cas_styleClass = @"camera_backgroundView";
    
    self.photoImageView = [[UIImageView alloc]init];
    self.photoImageView.cas_styleClass = @"camera_photoImageView";
    self.photoImageView.hidden = YES;
    
    self.pinchScrollView = [[UIScrollView alloc]init];
    self.pinchScrollView.cas_styleClass = @"camera_pinchScrollView";
    self.pinchScrollView.contentSize = CGSizeMake(iPhoneWidth, iPhoneHeight - 190 * TTUIScale());
    
    self.trackSlider = [[UISlider alloc] init];
    self.trackSlider.cas_styleClass = @"camera_flashSlider";
    self.trackSlider.transform =  CGAffineTransformMakeRotation(- M_PI * 0.5 );
    [self.trackSlider setMaximumValue:3];
    [self.trackSlider setMinimumValue:1];
    [self.trackSlider setValue:1.0];
    [self.trackSlider setThumbImage:kImage(SliderIcon) forState:UIControlStateHighlighted];
    [self.trackSlider setThumbImage:kImage(SliderIcon) forState:UIControlStateNormal];
    [self.trackSlider setMinimumTrackTintColor:[UIColor whiteColor]];
    [self.trackSlider setMaximumTrackTintColor:[UIColor whiteColor]];
    
    self.flowerImageView = [[UIImageView alloc]init];
    self.flowerImageView.image = kImage(FlowerIcon);
    self.flowerImageView.cas_styleClass = @"camera_flowerImageView";
    
    self.focusImageView = [[UIImageView alloc]initWithFrame:CGRectMake((iPhoneWidth - 113 * TTUIScale()) / 2,(iPhoneHeight - 303 * TTUIScale()) / 2, 113 * TTUIScale(), 113 * TTUIScale())];
    self.focusImageView.image = kImage(FocusIcon);
    self.focusImageView.cas_styleClass = @"camera_focusImageView";
    
    self.tipsLabel = [[UILabel alloc]init];
    self.tipsLabel.cas_styleClass = @"camera_tipsLabel";
    
    self.infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.infoButton setImage:Image(@"iconfont-fanhui") forState:UIControlStateNormal];
    [self.infoButton setImage:Image(@"iconfont-fanhui") forState:UIControlStateHighlighted];
    self.infoButton.cas_styleClass = (iPhoneHeight == kHeightX) ? @"camera_infoButton_X" : @"camera_infoButton";
    
    self.focusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.focusButton.cas_styleClass = @"camera_focusButton";
    [self.focusButton setImage:kImage(FlashIconOn) forState:UIControlStateNormal];
    [self.focusButton setImage:kImage(FlashIconOff) forState:UIControlStateSelected];
    self.focusButton.selected = YES;
    
    self.photoToolView = [[DFPhotoToolView alloc]init];
    self.photoToolView.cas_styleClass = @"camera_photoToolView";

    
    self.albumToolView = [[DFAlbumToolView alloc]init];
    self.albumToolView.cas_styleClass = @"camera_albumToolView";
//    self.photoToolView.backgroundColor = [UIColor clearColor];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
