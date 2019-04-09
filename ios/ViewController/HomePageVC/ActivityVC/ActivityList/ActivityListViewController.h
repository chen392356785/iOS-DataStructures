//
//  ActivityViewController.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/5/4.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"
#import "ActivityPaySuccessfulViewController.h"

@interface ActivityListViewController : SMBaseViewController

@property (nonatomic,copy)NSString *type; // 1 为活动列表 2 为我的活动列表
@property (nonatomic,copy)NSString *orderId;
@property (nonatomic,copy)NSString *typeId; // 分类ID

@end
