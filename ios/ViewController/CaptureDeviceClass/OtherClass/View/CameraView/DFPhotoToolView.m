//
//  DFPhotoToolView.m
//  DF
//
//  Created by Tata on 2017/11/21.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFIconConstant.h"
#import "DFPhotoToolView.h"

@interface DFPhotoToolView ()

@property (nonatomic, strong) UIButton *albumButton;
@property (nonatomic, strong) UIButton *photoButton;
@property (nonatomic, strong) UIButton *changeButton;

@end

@implementation DFPhotoToolView

- (void)addSubviews {
    [self creatViews];
    
    [self addSubview:self.photoButton];
    [self addSubview:self.albumButton];
    [self addSubview:self.changeButton];
    
}

- (void)defineLayout {
    //拍照
    [self.photoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(@(self.photoButton.cas_sizeWidth));
        make.height.equalTo(@(self.photoButton.cas_sizeHeight));
    }];
    //相册选择
    [self.albumButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.photoButton.mas_centerY);
        make.left.equalTo(@(self.albumButton.cas_marginLeft));
        make.width.equalTo(@(self.albumButton.cas_sizeWidth));
        make.height.equalTo(@(self.albumButton.cas_sizeHeight));
    }];
    //切换镜头
    [self.changeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.photoButton.mas_centerY);
        make.right.equalTo(@(self.changeButton.cas_marginRight));
        make.width.equalTo(@(self.changeButton.cas_sizeWidth));
        make.height.equalTo(@(self.changeButton.cas_sizeHeight));
    }];
}

- (void)creatViews {
    self.photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.photoButton setImage:kImage(ConfirmCameraIcon) forState:UIControlStateNormal];
    [self.photoButton setImage:kImage(ConfirmCameraIcon) forState:UIControlStateHighlighted];
    [self.photoButton addTarget:self action:@selector(takePhotosAction:) forControlEvents:UIControlEventTouchUpInside];
    self.photoButton.cas_styleClass = @"photo_photoButton";
    
    self.albumButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.albumButton setImage:kImage(AlbumIcon) forState:UIControlStateNormal];
    [self.albumButton setImage:kImage(AlbumIcon) forState:UIControlStateHighlighted];
    [self.albumButton addTarget:self action:@selector(checkAlbumAction:) forControlEvents:UIControlEventTouchUpInside];
    self.albumButton.cas_styleClass = @"photo_albumButton";
    
    self.changeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.changeButton setImage:kImage(ChangeVideoIcon) forState:UIControlStateNormal];
    [self.changeButton setImage:kImage(ChangeVideoIcon) forState:UIControlStateHighlighted];
    [self.changeButton addTarget:self action:@selector(changeCameraAction:) forControlEvents:UIControlEventTouchUpInside];
    self.changeButton.cas_styleClass = @"photo_changeButton";
}

#pragma mark - 拍照识别
- (void)takePhotosAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(takePhotos)]) {
        [self.delegate takePhotos];
    }
}

#pragma mark - 查看相册
- (void)checkAlbumAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(checkAlbum)]) {
        [self.delegate checkAlbum];
    }
}

#pragma mark - 切换摄像头
- (void)changeCameraAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(changeCamera)]) {
        [self.delegate changeCamera];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
