//
//  MTTopicListViewController.h
//  MiaoTuProject
//
//  Created by Mac on 16/3/22.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"
#import "MTTopicDetailsViewController.h"
@interface MTTopicListViewController : SMBaseViewController<MTTopicAgreeDelegate>
@property(nonatomic)CollecgtionType type;

@property(nonatomic,strong)ThemeListModel *themeMod;
-(void)addTopic:(MTTopicListModel *)mod;
@property(nonatomic,assign)int isHot;
@end
