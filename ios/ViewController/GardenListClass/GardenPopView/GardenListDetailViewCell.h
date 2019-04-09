//
//  GardenListDetailViewCell.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/1/3.
//  Copyright © 2019年 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GardenModel.h"

@interface GardenListDetailViewCell : UITableViewCell

@end




@interface GardenListDetailInfoCell : UITableViewCell
@property (nonatomic, strong) yuanbangModel *model;
@end


@interface GardenListDetailSkrCell : UITableViewCell
@property (nonatomic, copy) DidSelectBlock skrBlock;
@property (nonatomic, strong) yuanbangModel *model;
@end


@interface GardenListcompanydescribeCell : UITableViewCell
@property (nonatomic, strong) yuanbangModel *model;
@end



