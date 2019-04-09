//
//  DFCameraView.h
//  DF
//
//  Created by Tata on 2017/11/27.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFBaseView.h"
@class DFPhotoToolView, DFAlbumToolView;

@interface DFCameraView : DFBaseView

@property (nonatomic, readonly) UIButton *infoButton;
@property (nonatomic, readonly) UIButton *focusButton;
@property (nonatomic, readonly) UIView *backgroundView;
@property (nonatomic, readonly) UIImageView *photoImageView;
@property (nonatomic, readonly) UIScrollView *pinchScrollView;
@property (nonatomic, readonly) UIImageView *flowerImageView;
@property (nonatomic, readonly) UIImageView *focusImageView;
@property (nonatomic, readonly) UILabel *tipsLabel;

/**滑杆*/
@property (nonatomic,readonly) UISlider *trackSlider;

@property (nonatomic, readonly) DFPhotoToolView *photoToolView;
@property (nonatomic, readonly) DFAlbumToolView *albumToolView;

@end
