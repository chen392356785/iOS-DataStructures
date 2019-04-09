//
//  MyActivityOrderCell.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/7/10.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^cancelOrderBlock)();
typedef void(^PlayOrderBlock)();

@interface MyActivityOrderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *statuLabel;
@property (weak, nonatomic) IBOutlet UILabel *line1;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet SMLabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *picLabel;
@property (weak, nonatomic) IBOutlet UILabel *Line2;
@property (weak, nonatomic) IBOutlet UILabel *shouldPic;
@property (weak, nonatomic) IBOutlet UIButton *cancelBut;
@property (weak, nonatomic) IBOutlet UIButton *PlayBut;

@property (nonatomic, copy)cancelOrderBlock cancelOrder;
@property (nonatomic, copy)PlayOrderBlock   playOrder;
- (void) setActivitiesListModel:(ActivitiesListModel *)model;
@end
