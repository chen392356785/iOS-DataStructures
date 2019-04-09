//
//  UIViewMBHeadView.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/12/17.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "MyMiaoBiModel.h"

@interface CircleItem : NSObject

@property (nonatomic,strong) UIColor *color;
@property (nonatomic,assign) float lineWidth;//线宽
@property (nonatomic,assign) double percentage;//百分比

@end


@interface PieView : UIView
@property (nonatomic,strong) NSArray *circleItemArray;

@end


@interface UIViewMBHeadView : UIView {
    UILabel  *_titleLabel;
    UIView   *_bgView;
    UILabel  *listLab;
    PieView *_circleView;
    UILabel *_timeLab;
}
- (void)setCurrentGetMiaotubiArr:(NSArray *)arr;
@end



@interface SectionHeadView : UIView {
    UIView *_bgView;
    UILabel*_monthLab;
    UILabel*_getSouLab;
    UILabel*_useLab;
}
- (void)updataMyMiaoBiModel:(MyMiaoBiModel *)model;
@end
@interface SectionFootView : UIView {
    UIView *_bgView;
}

@end
