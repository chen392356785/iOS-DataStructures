//
//  GardenCommentCell.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/1/3.
//  Copyright © 2019年 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GardenModel.h"

@interface GardenCommentCell : UITableViewCell
///处理评论的文字（包括xx回复yy）
//- (void)configCellWithModel:(gardenReplyCommentModel *)model;
@property (nonatomic, strong) gardenReplyCommentModel *model;

@end
