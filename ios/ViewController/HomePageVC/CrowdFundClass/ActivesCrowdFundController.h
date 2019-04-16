//
//  ActivesCrowdFundController.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/6/21.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "SMBaseViewController.h"


@interface ActivesCrowdFundController : SMBaseViewController {
    
//    NSMutableArray *dataArray;
    NSMutableArray *agreeArr;
}


@property (nonatomic,strong) ActivitiesListModel *model;
@property(nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic,copy) NSString *type;// 1 为活动列表 2 为我的活动列表


@end
