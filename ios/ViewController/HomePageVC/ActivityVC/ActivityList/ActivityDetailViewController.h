//
//  ActivityDetailViewController.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/5/5.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"
#import "GongQiuAgreeDelegate.h"

@interface ActivityDetailViewController : SMBaseViewController<GongQiuAgreeDelegate>
{
    AgreeView *_agreeView;
     NSMutableArray *agreeArr;
    NSIndexPath *_selIndexPath;
    
}
@property(nonatomic)BOOL isReply; //是否是回复
@property(nonatomic)BOOL isBeginComment; //是否开始评论
@property (nonatomic,strong)ActivitiesListModel *model;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property (nonatomic,copy)NSString *type;// 1 为活动列表 2 为我的活动列表
@property(nonatomic,weak)id<GongQiuAgreeDelegate>delegate;
    
@end
