//
//  VotoChartsListViewController.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/7/21.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"

@interface VotoChartsListViewController : SMBaseViewController
@property (nonatomic,strong)ActivitiesListModel *model;

@property(nonatomic,copy) DidSelectBlock updataViewBlock;       //排行榜返回刷新
@end
