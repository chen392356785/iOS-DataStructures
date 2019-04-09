//
//  SubmitOrderController.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/6/26.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SMBaseViewController.h"
#import "PayMentMangers.h"

typedef void (^PayWithBlock)(NSString *price, NSString *orderNo, NSString *type, NSString*subject, SMBaseViewController *vc);

typedef NS_ENUM(NSInteger , ActionCrowdFundType) {
    MTSubmitCrowdFundOrder,          //提交众筹订单
    MTSubmitCrowdFundOrderOrPlay,    //提交众筹订单并支付
    MTSubmitActiviesPlay,            //活动立即支付
};

@interface SubmitOrderController : SMBaseViewController
@property (nonatomic,strong)ActivitiesListModel *model;
@property (nonatomic,strong)NSIndexPath *indexPath;
@property (nonatomic,assign) ActionCrowdFundType type;

@property (nonatomic,copy)NSString *payType;        //付款方式
@property (nonatomic, copy) PayWithBlock payBlock;

@property (nonatomic, strong) CNPPopupController *popupViewController;//弹出试图
#pragma mark - 界面弹出框
- (void)showPopupWithStyle:(CNPPopupStyle)popupStyle popupView:(UIView *)popupView;
#pragma mark - 关闭弹出试图
- (void)dismissPopupController;

@end
