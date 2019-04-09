//
//  DFDiscernSuccessView.h
//  DF
//
//  Created by Tata on 2017/11/24.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "ClassyLiveLayout.h"

@protocol DFDiscernSuccessDelegate <NSObject>

#pragma mark - 生成美图
- (void)creatPhoto;

#pragma mark - 分享识花结果
- (void)shareResult;

#pragma mark - 请高手鉴别
- (void)masterDiscern;


@end

@interface DFDiscernSuccessView : SHPAbstractView

@property (nonatomic, readonly) UILabel *flowerNameLabel;
@property (nonatomic, readonly) UILabel *flowerDiscribeLabel;
@property (nonatomic, readonly) UICollectionView *collectionView;
@property (nonatomic, readonly) UIButton *creatPhotoButton;         //生成美图
@property (nonatomic, readonly) UIButton *shareResultButton;        //分享识花结果
@property (nonatomic, readonly) UIButton *masterDiscernButton;      //请高手鉴别

@property (nonatomic, weak) id <DFDiscernSuccessDelegate> delegate;

@end
