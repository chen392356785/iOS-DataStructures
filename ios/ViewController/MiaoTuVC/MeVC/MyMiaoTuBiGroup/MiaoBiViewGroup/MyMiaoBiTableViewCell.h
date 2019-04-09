//
//  MyMiaoBiTableViewCell.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/12/18.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMiaoBiModel.h"

@interface MyMiaoBiTableViewCell : UITableViewCell {
    UIView *_bgView;
    UILabel *_monthLab;
    UILabel *_infoLab;
    UILabel *_addOrRLab;   //获取or使用
}
- (void)updatapointsRecordsModel:(pointsRecordsModel *)model;
@end
