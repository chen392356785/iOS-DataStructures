//
//  PositionListViewController.h
//  MiaoTuProject
//
//  Created by Zmh on 21/9/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"

@interface PositionListViewController : SMBaseViewController
@property(nonatomic,assign)JobType type;
@property(nonatomic,assign)MyJobType Mytype;
@property(nonatomic,strong) PositionListModel *model;
@end
