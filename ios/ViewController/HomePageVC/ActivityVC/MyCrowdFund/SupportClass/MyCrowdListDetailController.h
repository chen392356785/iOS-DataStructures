//
//  MyCrowdListDetailController.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/7/11.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "SMBaseViewController.h"

typedef NS_ENUM(NSInteger , CrowdFundType) {
    CrowdFundOn,
    CrowdFundSucces ,
    CrowdFundFail,
};
@interface MyCrowdListDetailController : SMBaseViewController

@property (nonatomic, assign) CrowdFundType crowType;
@property (nonatomic, strong)ActivitiesListModel *model;
@end
