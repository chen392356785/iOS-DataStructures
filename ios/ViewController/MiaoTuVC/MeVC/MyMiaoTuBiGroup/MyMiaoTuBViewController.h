//
//  MyMiaoTuBViewController.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/12/15.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "SMBaseViewController.h"
#import "UserInfoDataModel.h"

@interface MyMiaoTuBViewController : SMBaseViewController

@property (nonatomic, strong) UserInfoDataModel *Umodel;      //用户信息

@property (nonatomic, copy) DidSelectBlock yaoqinghaoyouBlock;  //邀请好友获取苗币
@end

