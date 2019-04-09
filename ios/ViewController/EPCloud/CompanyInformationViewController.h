//
//  CompanyInformationViewController.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/8/29.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"

@interface CompanyInformationViewController : SMBaseCustomViewController

@property (nonatomic,strong) JionEPCloudInfoModel *model;
@property(nonatomic,strong) DidSelectYZMBlock selectBlock;

@end
