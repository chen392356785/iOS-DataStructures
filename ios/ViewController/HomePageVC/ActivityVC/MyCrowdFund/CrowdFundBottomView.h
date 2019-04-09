//
//  CrowdFundBottomView.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/7/2.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , BootomType) {
    MyCrowdFundSignUp = 0,      //我的众筹
    OtherPeoPleCrowdFund,       //其他人的众筹界面
};
typedef NS_ENUM(NSInteger , SucceOrfailureType) {
    SuccesType,      //我的众筹
    FailureType,       //其他人的众筹界面
    EndCrowdFund,
};

typedef void(^selfSupportBlock)();            //自己支持
typedef void(^OtherPeopleZCBlock)();          //找人帮我众筹
typedef void(^myCrowdFundBlock)();            //我的众筹
typedef void(^giveTasupportlock)();           //给他支持
typedef void(^IPlayToolock)();                //我也要玩


@interface CrowdFundBottomView : UIView
@property (nonatomic, assign) BootomType BootomType;
@property (nonatomic, copy)   selfSupportBlock    selfSupport;              //自己支持
@property (nonatomic, copy)   OtherPeopleZCBlock  OtherPeoPleZCBlock;       //找人帮我众筹
@property (nonatomic, copy)   myCrowdFundBlock    myCrowdFundBlock;         //我的众筹
@property (nonatomic, copy)   giveTasupportlock    giveTasupportlock;        //给他支持
@property (nonatomic, copy)   IPlayToolock        IPlayToolock;             //我也要玩
@property (nonatomic, assign)   SucceOrfailureType   SuceeOrFail;

//- (void)setActivies:(ActivitiesListModel *)ActiModel;

@end
