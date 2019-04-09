//
//  PaymentViewController.h
//  MiaoTuProject
//
//  Created by Zmh on 5/5/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"
#import "BCBaseResp.h"

typedef void (^PayWithBlock)(NSString *price, NSString *orderNo, NSString *type, NSString*subject, SMBaseViewController *vc);


@interface ActivPaymentViewController : SMBaseCustomViewController
@property (nonatomic,strong)ActivitiesListModel *model;
@property (nonatomic,copy)NSString *type;//1是重新生成的订单  2订单已存在
@property (strong, nonatomic) BCBaseResp *orderList;
@property (nonatomic,copy)NSString *orderType;//1指活动大厅跳转过来 2指我的任务跳转过来
@property(nonatomic,strong)NSIndexPath *indexPath;
@property (nonatomic, copy) PayWithBlock payBlock;

@property (nonatomic,copy)NSString *payType;
    
@end


