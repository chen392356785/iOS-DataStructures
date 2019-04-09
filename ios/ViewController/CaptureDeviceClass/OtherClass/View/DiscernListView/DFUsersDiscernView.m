//
//  DFUsersDiscernView.m
//  DF
//
//  Created by Tata on 2017/11/30.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFIconConstant.h"
#import "DFUsersDiscernView.h"
#import "TFWaterflowLayout.h"

@interface DFUsersDiscernView ()

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIButton *selectDiscernType;

@end

@implementation DFUsersDiscernView

- (void)addSubviews {
    [super addSubviews];
    self.backgroundColor = [UIColor whiteColor];
    
    [self.navigationView addSubview:self.selectDiscernType];

    [self addSubview:self.collectionView];
    
}

- (void)defineLayout {
    [super defineLayout];
    
    [self.selectDiscernType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.navigationView.backgroundView.mas_centerY);
        make.right.equalTo(self.navigationView.backgroundView.mas_right).with.offset(self.selectDiscernType.cas_marginRight);
        make.width.equalTo(@(self.selectDiscernType.cas_sizeWidth));
        make.height.equalTo(@(self.selectDiscernType.cas_sizeHeight));
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationView.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(@(self.collectionView.cas_marginBottom / TTUIScale()));
    }];
}

- (void)creatViews {
    [super creatViews];
    
    self.navigationView.titleLabel.cas_styleClass = @"userDiscern_navigation_title";
    [self.navigationView.backButton setImage:kImage(BackArrowGreen) forState:UIControlStateNormal];
    self.navigationView.backButton.cas_styleClass = @"navigation_back";
    self.navigationView.lineView.cas_styleClass = @"navigation_line";
    
    self.selectDiscernType = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectDiscernType.cas_styleClass = @"usersDiscern_selectDiscernType";
    [self.selectDiscernType setTitle:@"全部" forState:UIControlStateNormal];
    [self.selectDiscernType setTitleColor:THBaseColor forState:UIControlStateNormal];
    self.selectDiscernType.titleLabel.font = kRegularFont(13);
    self.selectDiscernType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    
    TFWaterflowLayout *layout = [[TFWaterflowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.cas_styleClass = (iPhoneHeight == kHeightX) ? @"usersDiscern_collectionView_X" : @"usersDiscern_collectionView";
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
