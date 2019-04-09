//
//  DFDiscernSuccessView.m
//  DF
//
//  Created by Tata on 2017/11/24.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFDiscernSuccessView.h"
#import "MRLineLayout.h"

@interface DFDiscernSuccessView ()

@property (nonatomic, strong) UILabel *flowerNameLabel;
@property (nonatomic, strong) UILabel *flowerDiscribeLabel;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIButton *creatPhotoButton;
@property (nonatomic, strong) UIButton *shareResultButton;
@property (nonatomic, strong) UIButton *masterDiscernButton;

@end

@implementation DFDiscernSuccessView

- (void)addSubviews {
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.flowerNameLabel];
    [self addSubview:self.flowerDiscribeLabel];
    [self addSubview:self.collectionView];
    [self addSubview:self.creatPhotoButton];
    [self addSubview:self.shareResultButton];
    [self addSubview:self.masterDiscernButton];
    
}

- (void)defineLayout {
    [self.flowerNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(self.flowerNameLabel.cas_marginTop));
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@(self.flowerNameLabel.cas_sizeWidth));
        make.height.equalTo(@(self.flowerNameLabel.cas_sizeHeight));
    }];
    
    
    [self.flowerDiscribeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.flowerNameLabel.mas_bottom);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@(self.flowerNameLabel.cas_sizeWidth));
        make.height.equalTo(@(self.flowerNameLabel.cas_sizeHeight));
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.mas_centerX);
        make.left.equalTo(self);
        make.centerY.equalTo(self.mas_centerY);
//        make.width.equalTo(@(self.collectionView.cas_sizeWidth));
        make.right.equalTo(self);
        make.height.equalTo(@(self.collectionView.cas_sizeHeight));
    }];
    
    CGFloat spaceWidth = sWidth(120);
    [self.creatPhotoButton mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(self).mas_offset(spaceWidth/3);
        make.bottom.equalTo(self.mas_bottom).with.offset(self.creatPhotoButton.cas_marginBottom);
        make.width.mas_offset((iPhoneWidth - spaceWidth)/2);
        make.height.equalTo(@(self.creatPhotoButton.cas_sizeHeight));
    }];
    self.creatPhotoButton.layer.cornerRadius = self.creatPhotoButton.cas_sizeHeight/2;
    [self.shareResultButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.creatPhotoButton.mas_right).mas_offset(spaceWidth/3);
        make.bottom.equalTo(self.mas_bottom).with.offset(self.shareResultButton.cas_marginBottom);
        make.width.mas_equalTo(self->_creatPhotoButton);
        make.height.equalTo(@(self.shareResultButton.cas_sizeHeight));
    }];
    self.shareResultButton.layer.cornerRadius = self.creatPhotoButton.cas_sizeHeight/2;
    
    [self.masterDiscernButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom).with.offset(self.masterDiscernButton.cas_marginBottom);
        make.width.equalTo(@(self.masterDiscernButton.cas_sizeWidth));
        make.height.equalTo(@(self.masterDiscernButton.cas_sizeHeight));
    }];
     self.masterDiscernButton.layer.cornerRadius = self.creatPhotoButton.cas_sizeHeight/2;
}

- (UILabel *)flowerNameLabel {
    if (_flowerNameLabel == nil) {
        _flowerNameLabel = [[UILabel alloc]init];
        _flowerNameLabel.cas_styleClass = @"discernSuccess_flowerNameLabel";
    }
    return _flowerNameLabel;
}

- (UILabel *)flowerDiscribeLabel {
    if (_flowerDiscribeLabel == nil) {
        _flowerDiscribeLabel = [[UILabel alloc]init];
        _flowerDiscribeLabel.cas_styleClass = @"discernSuccess_flowerDiscribeLabel";
     }
    return _flowerDiscribeLabel;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        MRLineLayout *layout = [[MRLineLayout alloc]init];
//        layout.itemSize = CGSizeMake(250 * TTUIScale(), 250 * TTUIScale());
        layout.itemSize = CGSizeMake(kWidth(249), kWidth(249));
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 5;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.cas_styleClass = @"discernSuccess_collectionView";
    }
    return _collectionView;
}

- (UIButton *)creatPhotoButton {
    if (_creatPhotoButton == nil) {
        _creatPhotoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_creatPhotoButton setTitle:@"生成美图" forState:UIControlStateNormal];
        _creatPhotoButton.layer.masksToBounds = YES;
        [_creatPhotoButton addTarget:self action:@selector(creatPhotoAction:) forControlEvents:UIControlEventTouchUpInside];
        _creatPhotoButton.cas_styleClass = (iPhoneHeight == kHeightX) ? @"discernSuccess_creatPhotoButton_X" : @"discernSuccess_creatPhotoButton";
    }
    return _creatPhotoButton;
}


- (UIButton *)shareResultButton {
    if (_shareResultButton == nil) {
        _shareResultButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareResultButton setTitle:@"分享结果" forState:UIControlStateNormal];
        _shareResultButton.layer.masksToBounds = YES;
        [_shareResultButton addTarget:self action:@selector(shareResultAction:) forControlEvents:UIControlEventTouchUpInside];
        _shareResultButton.cas_styleClass = (iPhoneHeight == kHeightX) ? @"discernSuccess_shareResultButton_X" : @"discernSuccess_shareResultButton";
    }
    return _shareResultButton;
}

- (UIButton *)masterDiscernButton {
    if (_masterDiscernButton == nil) {
        _masterDiscernButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_masterDiscernButton setTitle:@"请高手鉴别" forState:UIControlStateNormal];
        _masterDiscernButton.layer.masksToBounds = YES;
        _masterDiscernButton.hidden = YES;
        [_masterDiscernButton addTarget:self action:@selector(masterDiscernAction:) forControlEvents:UIControlEventTouchUpInside];
        _masterDiscernButton.cas_styleClass = (iPhoneHeight == kHeightX) ? @"discernSuccess_masterDiscernButton_X" : @"discernSuccess_masterDiscernButton";
    }
    return _masterDiscernButton;
}


#pragma mark - 生成美图
- (void)creatPhotoAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(creatPhoto)]) {
        [self.delegate creatPhoto];
    }
}


#pragma mark - 分享识花结果
- (void)shareResultAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(shareResult)]) {
        [self.delegate shareResult];
    }
}

#pragma mark - 请高手鉴别
- (void)masterDiscernAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(masterDiscern)]) {
        [self.delegate masterDiscern];
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
