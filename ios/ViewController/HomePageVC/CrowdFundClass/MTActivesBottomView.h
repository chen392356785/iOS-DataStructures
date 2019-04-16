//
//  MTActivesBottomView.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/6/25.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef NS_ENUM(NSInteger , BootomType) {
//    SignUpNotStart  = 0,
//    CrowdFundNotStart,
//    ActiviesPay,        //活动立即支付
//    MyCrowdFund,        //我要众筹
//    CrowdFundDidEnd,    //众筹结束
//    ActiviesDidEnd,     //活动结束
//};

typedef void(^ActivityPlayBlock)();       //活动立即支付
typedef void(^myCrowdFundBlock)();        //我要众筹
typedef void(^myCrowdFundPlayBlock)();    //我要支付

@interface MTActivesBottomView : UIView

@property (nonatomic, copy) NSString *BottomType;       //0-活动报名未开始  1-众筹未开始  2-活动立即支付 3-我要众筹 4-众筹已结束 5-活动已结束
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, copy) ActivityPlayBlock    ActivityPlay;     //活动立即支付
@property (nonatomic, copy) myCrowdFundBlock     goCrowdFund;      //我要众筹
@property (nonatomic, copy) myCrowdFundPlayBlock CrowdFundPlay;    //我要支付

//是否已经众筹过
@property (nonatomic, assign) BOOL isDidCrowdFund;

- (void)layoutupSubviews;

@end
