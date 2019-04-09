//
//  PersonUserInfromationViewController.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/4/18.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"

@interface PersonUserInfromationViewController : SMBaseCustomViewController
@property(nonatomic,strong)NSString *userid;
@property(nonatomic,strong)NSDictionary *dic;
@property(nonatomic,strong)MTNearUserModel *model;
//@property(nonatomic,strong)UserChildrenInfo *UserModel;
@property(nonatomic,strong)NSArray *arr;
@end
