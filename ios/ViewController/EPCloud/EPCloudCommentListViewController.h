//
//  EPCloudCommentListViewController.h
//  MiaoTuProject
//
//  Created by Zmh on 6/7/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"
@protocol EPCloudCommentNumDelegate <NSObject>

- (void)disPalyCommentNum:(EPCloudListModel *)model;

@end
@interface EPCloudCommentListViewController : SMBaseViewController

@property (nonatomic,strong) EPCloudListModel *model;
@property (nonatomic,strong) id<EPCloudCommentNumDelegate>delegate;
@end
