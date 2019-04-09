//
//  OnGoingTableCell.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/7/5.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selfSupportBlock)();            //自己支持
typedef void(^OtherPeopleZCBlock)();          //找人帮我众筹

@interface OnGoingTableCell : UITableViewCell

@property(nonatomic, copy)selfSupportBlock  supportBlock;
@property(nonatomic, copy)OtherPeopleZCBlock otherPeopleblock;


- (void)setActivitiesListModel:(ActivitiesListModel* )model;
@end
