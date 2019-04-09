//
//  MiaoTuVipViewController.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/12/18.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "SMBaseViewController.h"
#import "UserInfoDataModel.h"

@interface MiaoTuVipViewController : SMBaseViewController


@property (nonatomic, strong) userInfoModel <Optional> * userInfo;     //个人信息
@property (nonatomic, strong) allUrlModel   <Optional> * allUrl;       //链接URL

@property (nonatomic, copy) NSString *titleName;
@end
