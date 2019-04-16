//
//  ViewController.h
//  SkillExchange
//
//  Created by lfl on 15-3-3.
//  Copyright (c) 2015年 xubin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CallViewController.h"
#import "ChatViewController.h"
static const CGFloat kDefaultPlaySoundInterval = 3.0;
static NSString *kMessageType = @"MessageType";
static NSString *kConversationChatter = @"ConversationChatter";
//static NSString *kGroupName = @"GroupName";
@interface MainViewController : SMBaseViewController

@property (strong, nonatomic) NSDate *lastPlaySoundDate;

- (void)setUpTabbar;

@end

