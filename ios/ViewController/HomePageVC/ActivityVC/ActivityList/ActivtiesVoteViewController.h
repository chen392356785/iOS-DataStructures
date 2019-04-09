//
//  ActivtiesVoteViewController.h
//  MiaoTuProject
//
//  Created by Zmh on 21/7/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"

@interface ActivtiesVoteViewController : SMBaseViewController
@property (nonatomic,strong)ActivitiesListModel *model;
@property(nonatomic,strong)NSIndexPath *indexPath;

@property (nonatomic, strong) CNPPopupController *popupViewController;//弹出试图

@end
