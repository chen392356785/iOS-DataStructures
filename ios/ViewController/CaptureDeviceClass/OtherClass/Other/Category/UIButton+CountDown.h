//
//  UIButton+countDown.h
//  NetworkEgOc
//
//  Created by iosdev on 15/3/17.
//  Copyright (c) 2015年 iosdev. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIButton (CountDown)
/*危险类,界面小时前需要调用,stopTime方法释放*/
//-(void)startTime:(NSInteger )timeout title:(NSString *)tittle waitTittle:(NSString *)waitTittle;

-(void)startTime:(NSInteger )timeout title:(NSString *)tittle waitTittle:(NSString *)waitTittle complete:(void(^)(BOOL finished))complete;

/**
 *  按钮倒计时
 *
 *  @param timeout    设置倒计时时间
 *  @param tittle     按钮标题
 *  @param waitTittle 显示的时间文字
 *  @param time       设置回调时间
 *  @param timeAfter  多少秒后回调
 *  @param complete   完成的回调
 */
//-(void)startTime:(NSInteger )timeout title:(NSString *)tittle waitTittle:(NSString *)waitTittle waitTime:(NSInteger)time waitTimer:(void(^)(NSInteger time))timeAfter complete:(void(^)(BOOL finished))complete;

//-(void)stopTime;

@end
