//
//  CreateBuyOrSupplyViewController.h
//  MiaoTuProject
//
//  Created by Mac on 16/3/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"


@interface CreateBuyOrSupplyViewController : SMBaseCustomViewController

@property(nonatomic)buyType type;
@property(nonatomic)BOOL ifEdit;
@property(nonatomic)BOOL isEdit;
@property(nonatomic)BOOL ifQG;
@property(nonatomic,strong) MTSupplyAndBuyListModel *model;

@property(nonatomic,strong) DidSelectEditBlock selectEditBlock;
@end
