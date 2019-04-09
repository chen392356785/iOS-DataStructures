//
//  MyJobChildrenViewController.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/9/19.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"
#import "JobDelegate.h"
@interface MyJobChildrenViewController : SMBaseViewController<JobDelegate>
@property(nonatomic,assign)JobType type;
@property(nonatomic,assign)MyJobType Mytype;
@end
