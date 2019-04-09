//
//  JobIntentionViewController.h
//  MiaoTuProject
//
//  Created by Zmh on 14/9/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"

@protocol JobIntentionBackDelegate <NSObject>

- (void)disPalyJobIntention:(NSString *)positionType Pro_id:(NSString *)Pro_id ProStr:(NSString *)proStr city_id:(NSString *)city_id cityStr:(NSString *)cityStr;

@end

@interface JobIntentionViewController : SMBaseCustomViewController
@property (nonatomic,strong) id<JobIntentionBackDelegate>delegate;
@property (nonatomic,strong) NSDictionary *purposeDic;//信息

@end
