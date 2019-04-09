//
//  DHBaseViewController.h
//  DF
//
//  Created by Tata on 2017/11/20.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFShowEmptyView.h"

@interface DHBaseViewController : UIViewController

- (void)setupNetCheck;
#pragma mark --删除无网络指引--
- (void)hideRemindView;
#pragma mark --添加无网络指引--
//- (void)createNetWorkChanged;

/**无网络默认加载图*/
@property (nonatomic,strong) TFShowEmptyView * __nonnull emptyDataView;
/**网络不好默认加载图*/
@property (nonatomic,strong) TFShowEmptyView * __nonnull emptyTimeOutDataView;

@end
