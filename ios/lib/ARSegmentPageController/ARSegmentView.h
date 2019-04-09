//
//  ARSegmentView.h
//  ARSegmentPager
//
//  Created by August on 15/3/28.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>
//代理协议
@protocol ARSegmentViewMenusDelegate <NSObject>

@optional //可选实现
-(void)didSegmentViewClickedButtonAtIndex:(NSInteger)aIndex;
@end
@interface ARSegmentView : UIView
{
    UIButton *_currBtn;
}
@property (nonatomic,assign) id <ARSegmentViewMenusDelegate> delegate;
@property (nonatomic, strong,readonly) UISegmentedControl *segmentControl;
-(instancetype)initWithTitleArray:(NSMutableArray *)titleArray;
-(void)setTitle:(NSMutableArray *)titleArray;
@end
