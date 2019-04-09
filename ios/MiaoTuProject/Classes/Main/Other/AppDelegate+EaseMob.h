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

#import "AppDelegate.h"
 #import <UserNotifications/UserNotifications.h>
@interface AppDelegate (EaseMob)<EMCallManagerDelegate,IChatManagerBase,UNUserNotificationCenterDelegate>
{
 
}
- (void)easemobApplication:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

/**
 配置控件
 */
- (void)configOwnViews;
@end
