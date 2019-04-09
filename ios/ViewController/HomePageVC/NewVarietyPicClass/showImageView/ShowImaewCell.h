//
//  ShowImaewCell.h
//  ImageFileScanning
//
//  Created by MacYin on 17/2/26.
//  Copyright © 2017年 huizhi01. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NewVarietyPicModel.h"

@interface ShowImaewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *showImageView;


// 单点block回调
@property (nonatomic, copy) void (^singleTapGestureBlock)();



// 长按回调
@property (nonatomic, copy) void (^longGestureBlock)();

@property (nonatomic, copy) NSString *imgSize;

- (void) setImageModel:(nurseryNewDetailListModel *)model;
@end
