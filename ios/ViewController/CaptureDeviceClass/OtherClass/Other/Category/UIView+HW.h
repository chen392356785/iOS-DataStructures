//
//  UIView+HW.h
//  HW_微博
//
//  Created by 胡伟 on 16/1/16.
//  Copyright © 2016年 胡伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HW)


@property(nonatomic) CGFloat left;
@property(nonatomic) CGFloat top;
@property(nonatomic) CGFloat right;
@property(nonatomic) CGFloat bottom;

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;

//+ (UIView *)setupNavbarTitleView:(NSString *)title;
//
//- (void)addScaleAnimation;
//- (void)addLeftOutAnimation;
//- (UIViewController*)getViewControllerFromView:(UIView *)view;
@end
