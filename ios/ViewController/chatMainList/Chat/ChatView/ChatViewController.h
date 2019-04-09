/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import <UIKit/UIKit.h>
#import "EMChatManagerDefs.h"
//#import "YLWebViewController.h"
//

@protocol ChatViewControllerDelegate <NSObject>

@optional
- (NSString *)avatarWithChatter:(NSString *)chatter;
- (NSString *)nickNameWithChatter:(NSString *)chatter;

@end

@interface ChatViewController : SMBaseViewController
@property (strong, nonatomic, readonly) NSString *chatter;
@property (nonatomic) BOOL isInvisible;
@property(nonatomic,strong)NSString *toUserID;
@property(nonatomic,strong)NSString *nickName;
@property (nonatomic, assign) id <ChatViewControllerDelegate> delelgate;
@property(nonatomic)BOOL isActive;  //是否主动发起聊天
@property(nonatomic,strong)NSString *HeadimgUrl;
- (instancetype)initWithChatter:(NSString *)chatter isGroup:(BOOL)isGroup;
- (instancetype)initWithChatter:(NSString *)chatter conversationType:(EMConversationType)type;

- (void)reloadData;

- (void)hideImagePicker;

@end
