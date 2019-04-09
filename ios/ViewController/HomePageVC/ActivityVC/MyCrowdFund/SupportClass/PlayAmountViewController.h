//
//  PlayAmountViewController.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/7/4.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "SMBaseViewController.h"
#import "PayMentMangers.h"

@interface PlayAmountViewController : SMBaseViewController
@property (nonatomic,strong)CrowdOrderModel *model;
@property (nonatomic,copy)NSString *crowdID;//众筹id(我的活动跳转用到)
@property (nonatomic,copy)NSString *payType;        //付款方式
@property (nonatomic,strong) ActivitiesListModel *ActiModel;
@property(nonatomic,strong)NSIndexPath *indexPath;

@property (nonatomic, assign)NSString * blakPopVc;        //返回上上界面
@property (nonatomic, copy) NSString *isSupport;    // 1-给他支持
@end
