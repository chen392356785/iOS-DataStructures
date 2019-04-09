//
//  THNotificationCenter+C.m
//  Owner
//
//  Created by Neely on 2018/4/27.
//  Copyright © 2018年 xubin. All rights reserved.
//

#import "THNotificationCenter+C.h"

@implementation THNotificationCenter (C)

- (void)notifiyCrowdSuccess:(NSIndexPath *)indexPath{
    [self notifySelector:@selector(onCrowdSuccess:) withObject:indexPath];
}
@end
