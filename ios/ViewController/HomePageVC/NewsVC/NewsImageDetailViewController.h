//
//  NewsImageDetailViewController.h
//  MiaoTuProject
//
//  Created by Zmh on 24/6/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"
#import "NewsDataSourceDelegate.h"
@interface NewsImageDetailViewController : SMBaseCustomViewController

@property (nonatomic,strong)NewsListModel *infoModel;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property (nonatomic,strong)id<NewsDataSourceDelegate>delegate;

@end
