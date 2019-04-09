//
//  ActiviOrderCell.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/7/10.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActiviOrderCell : UITableViewCell

@end

@interface ActivityInfoCell : UITableViewCell
- (void) setActivitiesListModel:(NSString *)str;

@end


@interface OrderDetailCell : UITableViewCell

- (void) setActivitiesListModel:(ActivitiesListModel *)model;

@end


typedef void(^copyOrderNoBlock)();
@interface OrderInfCell : UITableViewCell
@property (nonatomic, copy)copyOrderNoBlock copyBlock;

- (void) setActivitiesListModel:(ActivitiesListModel *)model;

@end

;
