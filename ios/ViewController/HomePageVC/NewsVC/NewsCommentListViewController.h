//
//  NewsCommentListViewController.h
//  MiaoTuProject
//
//  Created by Zmh on 28/6/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"

@interface NewsCommentListViewController : SMBaseViewController
@property (nonatomic,strong)NewsListModel *infoModel;
@property(nonatomic)BOOL isReply; //是否是回复
@end
