//
//  PositionDetailViewController.h
//  MiaoTuProject
//
//  Created by Zmh on 12/9/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "JobDelegate.h"
#import "SMBaseViewController.h"
@interface PositionDetailViewController : SMBaseCustomViewController

@property(nonatomic,assign)NSInteger i;
@property (nonatomic,assign)int job_id;
@property(nonatomic,weak)id<JobDelegate>delegate;
@property(nonatomic,strong)DidSelectBtnBlock selectBtnBlock;

@end
