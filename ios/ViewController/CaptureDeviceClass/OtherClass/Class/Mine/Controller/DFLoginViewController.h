//
//  DFLoginViewController.h
//  DF
//
//  Created by Tata on 2017/12/4.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DHBaseViewController.h"

@protocol DFLoginDelegate <NSObject>
@optional
//登录成功
-(void)loginSuccess;
//登录失败
-(void)loginFailure;
//取消登录
//-(void)loginCancel;
@end

@interface DFLoginViewController : DHBaseViewController

@property(nonatomic, weak) id <DFLoginDelegate> delegate;

@end
