//
//  MiaoBiInfoViewController.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/1/22.
//  Copyright © 2019年 听花科技. All rights reserved.
//

#import "SMBaseViewController.h"
#import "UserInfoDataModel.h"

@interface MiaoBiInfoViewController : SMBaseViewController
{
    BOOL isFinish;
}

@property(nonatomic)BOOL isLeft;
@property(nonatomic)int type;  //1 网页解析
@property(strong,nonatomic)NSURL * mUrl;
@property(nonatomic,strong)NSString *NameTitle;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *navBg;

@property(nonatomic,strong)UIColor *navBgColor;
@property(nonatomic,assign)BOOL navBarTranslucent;  //导航栏是否透明
@property (nonatomic, strong) userInfoModel <Optional> * userInfo;     //个人信息

@property (nonatomic, copy) DidSelectBlock yaoqinghaoyouBlock;  //邀请好友获取苗币
@property (nonatomic, copy) DidSelectBlock lianxiKefuBlock;     //联系客服

@property (nonatomic, copy) DidSelectBlock paySuccesBlack;      //支付成功
@property (nonatomic, copy) DidSelectBlock paySuccesrefreshBlack;      //支付成功刷新

@end
