//
//  NewsViewController.h
//  MiaoTuProject
//
//  Created by XBL on 16/5/4.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"

@interface NewsTableListViewController : SMBaseViewController
@property(nonatomic,assign)int program_id;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)int i;
@property(nonatomic,strong)NSString *titl;
@property (nonatomic,copy)NSString *orderId;

@property (nonatomic,copy)NSString *type; // 1 为活动列表 2 为我的活动列表

-(void)beginRefresh;
@end
