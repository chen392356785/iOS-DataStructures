//
//  BuyVoteViewController.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/1/15.
//  Copyright © 2019年 听花科技. All rights reserved.
//

#import "SMBaseViewController.h"
#import "PayMentMangers.h"


@interface BuyVoteViewController : SMBaseViewController
@property (nonatomic,strong)VoteListModel *model;
@property (nonatomic,strong)ActivitiesListModel *ActiviModel;
@property (nonatomic,copy)NSString *votoTitle;

@property (nonatomic,copy)NSString *payType;        //付款方式
@end





//选票购买成功
@interface BuySuccesVoteViewController : SMBaseViewController

@end
