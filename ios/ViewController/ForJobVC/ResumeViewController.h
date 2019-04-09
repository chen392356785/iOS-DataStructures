//
//  ResumeViewController.h
//  MiaoTuProject
//
//  Created by Zmh on 13/9/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"
@protocol sendResumeSuccessDelegate <NSObject>

- (void)disPalySendResumeSuccess;

@end
@interface ResumeViewController : SMBaseCustomViewController
@property(nonatomic,assign)JobType type;
@property(nonatomic,assign)MyJobType Mytype;
@property(nonatomic,strong) PositionListModel *model;
@property (nonatomic,strong)id<sendResumeSuccessDelegate>Delegate;
@end
