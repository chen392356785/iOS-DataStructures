//
//  TFShowEmptyView.h
//  TH
//
//  Created by 苏浩楠 on 16/5/20.
//  Copyright © 2016年 羊圈科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,TFShowEmptyStyle)
{
    TFShowEmptyStyleOrder,
    TFShowEmptyStyleCoupon,
    TFShowEmptyStyleCollection,
    TFShowEmptyStyleMyFlowerTalk,
    TFShowEmptyStyleActivityOrder,
    TFShowEmptyStyleFlowerCarRecord,
    TFShowEmptyStyleFocus,
    TFShowEmptyStyleLife,
    TFShowEmptyStyleLifeActivity,
    TFShowEmptyStyleFansRevenue,
    TFShowEmptyStyleFans,
    TFShowEmptyStyleWithdrawHistory,
    TFShowEmptyStyleFaileData,
    TFShowEmptyStyleNetTimeOut,
};

@protocol TFShowEmptyViewDelegate <NSObject>

@optional

- (void)showEmptyViewFinished;

@end


@interface TFShowEmptyView : UIView

+ (instancetype)showEmptyView;

/**类型*/
@property (nonatomic,assign) TFShowEmptyStyle emptyStyle;
/**代理*/
@property (nonatomic,assign) id<TFShowEmptyViewDelegate>delegate;
@end
