//
//  THNotificationCenter.h
//  Owner
//
//  Created by Neely on 2018/4/27.
//  Copyright © 2018年 xubin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CCAppDelegate <NSObject>

@optional
- (void)onNetworkError;
- (void)onSignout;
- (void)onKickout;
- (void)onUserBlocked;
- (void)onDeviceBlocked;
- (void)onLoginSuccess;
- (void)onNetworkFailed;
- (void)onNetworkSuccess;

@end

@interface THNotificationCenter : NSObject

+ (THNotificationCenter *)singleton;

- (void)addDeletegate:(id<CCAppDelegate>)d;
- (void)removeDeletegate:(id<CCAppDelegate>)d;
- (void)notifySignout;
- (void)notifyKickout;
- (void)notifyUserBlocked;
- (void)notifyDeviceBlocked;
- (void)notifyLoginSuccess;

- (void)notifyNetWorkFailed;
- (void)notifyNetWorkSuccess;


- (void)notifySelector:(SEL)selector;
- (void)notifySelector:(SEL)selector withObject:(id)obj;


@end
