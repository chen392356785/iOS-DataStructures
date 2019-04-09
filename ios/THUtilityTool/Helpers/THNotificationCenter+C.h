//
//  THNotificationCenter+C.h
//  Owner
//
//  Created by Neely on 2018/4/27.
//  Copyright © 2018年 xubin. All rights reserved.
//

#import "THNotificationCenter.h"


@protocol CCAppDelegate_C<CCAppDelegate>

@optional

//众筹成功通知
- (void)onCrowdSuccess:(NSIndexPath *)indexPath;

@end

@interface THNotificationCenter (C)

-(void)notifiyCrowdSuccess:(NSIndexPath *)indexPath;

@end
