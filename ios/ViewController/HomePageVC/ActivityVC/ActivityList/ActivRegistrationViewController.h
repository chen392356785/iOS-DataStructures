//
//  ActivRegistrationViewController.h
//  MiaoTuProject
//
//  Created by Zmh on 5/5/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"

@interface ActivRegistrationViewController : SMBaseCustomViewController
@property (nonatomic,strong)ActivitiesListModel *model;
@property (nonatomic,copy)NSString *type;
@property(nonatomic,strong)NSIndexPath *indexPath;
@end
