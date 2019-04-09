//
//  MyCrowdFundListController.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/7/5.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "SMBaseViewController.h"

typedef NS_ENUM(NSInteger , Type){
    OnGoingType,
    SuccessfulType,
    FailureType,
};

@interface MyCrowdFundListController : SMBaseViewController
@property (nonatomic, assign)Type Type;

@end
