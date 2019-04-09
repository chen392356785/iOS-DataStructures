//
//  DFUserCenterView.h
//  DF
//
//  Created by Tata on 2017/11/30.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "ClassyLiveLayout.h"

@protocol DFUserCenterViewDelegate <NSObject>

/***好评*/
- (void)goToPraise;

- (void)addBadComment;

- (void)allUsersDiscern;
/**关于我们*/
- (void)goToAboutUS;

- (void)checkUserInfo;

- (void)loginOut;

@end

@interface DFUserCenterView : SHPAbstractView

@property (nonatomic, weak) id <DFUserCenterViewDelegate> delegate;

@property (nonatomic, readonly) UIImageView *backgroundImageView;
@property (nonatomic, readonly) UIVisualEffectView *effectView;
@property (nonatomic, readonly) UIImageView *userHeaderIcon;
@property (nonatomic, readonly) UILabel *userNameLabel;
@property (nonatomic, readonly) UILabel *userDescribeLabel;
@property (nonatomic, readonly) UIButton *loginOutButton;

@end
