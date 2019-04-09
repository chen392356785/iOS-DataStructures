//
//  MyCrowdFundController.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/7/2.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "SMBaseViewController.h"

typedef NS_ENUM(NSInteger , CrowdFundType) {
    MyCrowdFundType = 0,      //我的众筹
    OtherPeoPleCrowdFundType,       //其他人的众筹界面
};

@interface MyCrowdFundController : SMBaseViewController

@property (nonatomic,strong)CrowdOrderModel *model;
@property (nonatomic,strong) ActivitiesListModel *ActiModel;
@property (nonatomic,copy)NSString *crowdID;//众筹id(我的活动跳转用到)
@property (nonatomic,copy)NSString *Type;       //已经众筹过
@property(nonatomic,strong)NSIndexPath *indexPath;
@property (nonatomic, assign)CrowdFundType CFType;

@property (nonatomic, assign)NSString * isPopVc;        //返回上上界面 1-上上级界面        2 - 完成支付回到首页

@property (nonatomic, assign)NSString *cruUserID;
@end
