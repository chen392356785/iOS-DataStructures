//
//  PlayPopView.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/8/24.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GoPlayBlock)();
//typedef void(^CancelyBlock)();

@interface PlayPopView : UIView

@property (nonatomic, copy) GoPlayBlock goPlayOrder;
@property (nonatomic, copy) CancelBlock cancelPopView;

- (void) setPopViewZouclistModel:(ActivitiesListModel *)model;
@end
