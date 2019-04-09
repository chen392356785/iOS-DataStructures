//
//  ClassSourceTableViewCell.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/10/29.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassroomModel.h"

@interface ClassSourceTableViewCell : UITableViewCell

- (void)setDataWith:(MyClassSourceListModel *)Model isHistort:(BOOL) isHistory;

@end
