//
//  NewsDetailViewController.h
//  MiaoTuProject
//
//  Created by Zmh on 24/6/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"
#import "NewsDataSourceDelegate.h"

@interface NewsDetailViewController : SMBaseViewController<NewsDataSourceDelegate>
@property(nonatomic)BOOL isReply; //是否是回复
@property(nonatomic)BOOL isBeginComment; //是否开始评论
@property (nonatomic,strong)NewsListModel *infoModel;
//@property (nonatomic,strong)NewDetailModel *model;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property (nonatomic,strong)id<NewsDataSourceDelegate>delegate;
@end
