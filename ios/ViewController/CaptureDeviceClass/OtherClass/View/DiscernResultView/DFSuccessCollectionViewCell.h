//
//  DFSuccessCollectionViewCell.h
//  DF
//
//  Created by Tata on 2017/11/28.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "ClassyLiveLayout.h"

@protocol DFSuccessCollectionViewDelegate <NSObject>

- (void)checkDetail;

@end

@interface DFSuccessCollectionViewCell : SHPAbstractCollectionViewCell

@property (nonatomic, readonly) UIImageView *flowerIcon;
@property (nonatomic, readonly) UIImageView *roundIcon;
@property (nonatomic, readonly) UIButton *checkButton;

@property (nonatomic, weak) id <DFSuccessCollectionViewDelegate> delegate;

@end
