//
//  MTActivesGridViewCell.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/6/24.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTActivesGridViewCell : UICollectionViewCell {
    CAShapeLayer *_progressLayer;
    CAShapeLayer *_borderLayer;
    CAGradientLayer *_colorLayer;
}
/*
 显示进度0-100，默认为0；
 */
@property (nonatomic, assign) float progress;
/*
 进度条的宽度，默认为3；
 */
@property (nonatomic, assign) float lineW;
/*
 未覆盖进度条的颜色，默认为白色；
 */
@property (nonatomic, strong) UIColor *minTrackColor;
/*
 已覆盖进度条的颜色CGColor，可以有多个颜色，产生渐变效果；
 */
@property (nonatomic, strong) NSArray *maxTrackColors;

- (void) setIconImagUrl:(NSString *)imgUrlStr andProgress:(NSString *) progressStr;
@end
