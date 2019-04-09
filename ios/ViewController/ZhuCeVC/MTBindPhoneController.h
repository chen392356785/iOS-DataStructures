//
//  MTBindPhoneController.h
//  MiaoTuProjectTests
//
//  Created by Tomorrow on 2018/6/12.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "SMBaseViewController.h"

typedef void(^DidSelectHeadResultsBlock) (BOOL result,NSDictionary *dict);   //老用户回调
typedef void(^NewSelectHeadResultsBlock) (BOOL result, NSString *HXName,NSString *HxPassW,NSDictionary *dict);     //新用户回调

@interface MTBindPhoneController : SMBaseViewController

@property(nonatomic,copy) DidSelectHeadResultsBlock SelectSurnBlock;
@property(nonatomic,copy) NewSelectHeadResultsBlock NewSelectSurnBlock;

@property(nonatomic,strong) UIButton *loginBtn;
@property(nonatomic, copy)  NSString *UserID;
@property(nonatomic, assign)NSInteger errorLogNO;       //用户绑定信息提示1401用户不存在及新用户
@property(nonatomic, copy)  NSString *WXName;           //微信昵称
@property(nonatomic, copy)  NSString *headIconUrl;      //微信头像

@end
