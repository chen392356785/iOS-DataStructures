//
//  UIView+Extension.h
//  HZOA
//
//  Created by huizhi01 on 16/4/22.
//  Copyright © 2016年 hz_02. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;


CGFloat screenWidth();

/**
 *  返回屏幕的高
 *  @return 屏幕的高
 */
CGFloat screenHeight();
/**
 *  计算视图最大的 X
 *  @param view  当前视图
 *  @return 最大的 X
 */
CGFloat maxX(UIView *view);
/**
 *  计算视图最小的 X
 *  @param view  当前视图
 *  @return 最小的 X
 */
CGFloat minX(UIView *view);
/**
 *  计算视图最小的 Y
 *  @param view  当前视图
 *  @return 最小的 Y
 */
CGFloat minY(UIView *view);
/**
 *  计算视图最大的 Y
 *  @param view  当前视图
 *  @return 最大的 Y
 */
CGFloat maxY(UIView *view) ;

/**
 *  计算视图的宽
 *  @param view 当前视图
 *  @return 视图的宽
 */
CGFloat width(UIView *view);

/**
 *  计算视图的高
 *  @param view 当前视图
 *  @return 视图的高
 */
CGFloat height(UIView *view);
@end
