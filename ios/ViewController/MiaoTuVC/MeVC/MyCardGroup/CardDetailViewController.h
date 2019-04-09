//
//  CardDetailViewController.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/12/20.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "SMBaseViewController.h"
#import "UserInfoDataModel.h"
@interface CardDetailViewController : SMBaseViewController

@property (nonatomic, strong) CardListModel *model;
@property (nonatomic, copy) DidSelectBlock reloadBlock;  //刷新
@end
