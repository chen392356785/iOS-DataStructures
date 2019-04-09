//
//  MessageChatViewController.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/2/25.
//  Copyright © 2019 听花科技. All rights reserved.
//

#import "SMBaseViewController.h"
#import "MyMessageModel.h"
#import "partenerModel.h"


@interface MessageChatViewController : SMBaseCustomViewController

@property (nonatomic, strong) MyMessageModel *model;

@property (nonatomic, strong) partnerList *PartModel;

@property (nonatomic, copy)DidSelectBlock reloadData;
@end


