//
//  TFWaterflowLayout.h
//  TH
//
//  Created by 苏浩楠 on 2017/7/18.
//  Copyright © 2017年 羊圈科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TFWaterflowLayout;

@protocol TFWaterflowLayoutDelegate <NSObject>

@required
- (CGFloat)waterflowLayout:(TFWaterflowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;

@optional
- (CGFloat)columnCountInWaterflowLayout:(TFWaterflowLayout *)waterflowLayout;
- (CGFloat)columnMarginInWaterflowLayout:(TFWaterflowLayout *)waterflowLayout;
- (CGFloat)rowMarginInWaterflowLayout:(TFWaterflowLayout *)waterflowLayout;
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(TFWaterflowLayout *)waterflowLayout;

@end

@interface TFWaterflowLayout : UICollectionViewLayout

/** 代理 */
@property (nonatomic, weak) id<TFWaterflowLayoutDelegate> delegate;

@end
