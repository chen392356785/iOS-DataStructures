//
//  MTOtherInfomationMainViewController.h
//  MiaoTuProject
//
//  Created by Mac on 16/3/17.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "Follwer.h"
#import "SMBaseViewController.h"
#import "ARSegmentPageController.h"

@interface MTOtherInfomationMainViewController : ARSegmentPageController

-(instancetype)initWithUserID:(NSString *)userID :(BOOL)isMe dic:(NSDictionary *)dic;
@property(nonatomic,strong)NSString *userid;
@property(nonatomic,strong)MTSupplyAndBuyListModel *SupplyOrBuyModel;
@property(nonatomic,strong)MTTopicListModel *TopicModel;
@property(nonatomic,strong)UserChildrenInfo *userMod;
@property(nonatomic,strong)NSArray *arr;
@property(nonatomic,strong)NSDictionary *dic;
@property(nonatomic)BOOL isMe;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,weak)id<Follwer>delegate;

@end
