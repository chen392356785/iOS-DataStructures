//
//  DFAlbumToolView.m
//  DF
//
//  Created by Tata on 2017/11/22.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFIconConstant.h"
#import "DFAlbumToolView.h"

@interface DFAlbumToolView ()

@property (nonatomic, strong) UIButton *reselectPhotoButton;
@property (nonatomic, strong) UIButton *confirmButton;

@end

@implementation DFAlbumToolView

- (void)addSubviews {
    [self creatViews];
    
    [self addSubview:self.reselectPhotoButton];
    [self addSubview:self.confirmButton];
    
}

- (void)defineLayout {
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@(self.confirmButton.cas_sizeWidth));
        make.height.equalTo(@(self.confirmButton.cas_sizeHeight));
    }];
    
    [self.reselectPhotoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(self.reselectPhotoButton.cas_marginLeft));
        make.centerY.equalTo(self.confirmButton.mas_centerY);
        make.width.equalTo(@(self.reselectPhotoButton.cas_sizeWidth));
        make.height.equalTo(@(self.reselectPhotoButton.cas_sizeHeight));
    }];
}

- (void)creatViews {
    self.reselectPhotoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.reselectPhotoButton setTitle:DFReselectString() forState:UIControlStateNormal];
    [self.reselectPhotoButton setTitleColor:THBaseColor forState:UIControlStateNormal];
    self.reselectPhotoButton.titleLabel.font = kRegularFont(17);
    [self.reselectPhotoButton addTarget:self action:@selector(reselectPhotoAction:) forControlEvents:UIControlEventTouchUpInside];
    self.reselectPhotoButton.cas_styleClass = @"album_reselectPhotoButton";
    
    self.confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.confirmButton setImage:kImage(ConfirmPhotoIcon) forState:UIControlStateNormal];
    [self.confirmButton setImage:kImage(ConfirmPhotoIcon) forState:UIControlStateHighlighted];
    [self.confirmButton addTarget:self action:@selector(confirmPhotoAction:) forControlEvents:UIControlEventTouchUpInside];
    self.confirmButton.cas_styleClass = @"album_confirmButton";
}

#pragma mark - 重选照片
- (void)reselectPhotoAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(reselectPhoto)]) {
        [self.delegate reselectPhoto];
    }
}

#pragma mark - 确认照片
- (void)confirmPhotoAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(confirmPhoto)]) {
        [self.delegate confirmPhoto];
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
