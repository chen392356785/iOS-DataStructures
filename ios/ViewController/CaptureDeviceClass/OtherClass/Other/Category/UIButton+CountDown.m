//
//  UIButton+countDown.m
//  NetworkEgOc
//
//  Created by iosdev on 15/3/17.
//  Copyright (c) 2015年 iosdev. All rights reserved.
//

#import "UIButton+countDown.h"

static char TAG_UIBUTTON_TITLE;

@interface UIButton (countDown)
@property(nonatomic,retain)NSString  * myTitle;
@end

@implementation UIButton (countDown)

dispatch_source_t _timer;

- (NSString *)myTitle
{
    return (NSString *)objc_getAssociatedObject(self, &TAG_UIBUTTON_TITLE);
}

- (void)setMyTitle:(NSString *)myTitle
{
    objc_setAssociatedObject(self, &TAG_UIBUTTON_TITLE, myTitle, OBJC_ASSOCIATION_RETAIN);
}

//-(void)startTime:(NSInteger )timeout title:(NSString *)tittle waitTittle:(NSString *)waitTittle
//{
////    [self startTime:timeout title:tittle waitTittle:waitTittle complete:^{}];
//    [self startTime:timeout title:tittle waitTittle:waitTittle complete:^(BOOL finished) {
//
//    }];
//}

-(void)startTime:(NSInteger )timeout title:(NSString *)tittle waitTittle:(NSString *)waitTittle complete:(void(^)(BOOL finished))complete
{
    self.userInteractionEnabled = NO;
    self.myTitle=tittle;
    __block NSInteger timeOut = timeout; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^
                                      {
                                          if(timeOut<=0)
                                          {
                                              //倒计时结束，关闭
                                              dispatch_source_cancel(_timer);
                                              dispatch_async(dispatch_get_main_queue(), ^
                                                  {
                                                      //设置界面的按钮显示 根据自己需求设置
                                                      [self setTitle:tittle forState:UIControlStateNormal];
                                                      self.userInteractionEnabled = YES;
                                                      complete(YES);
                                                  });
                                          }
                                          else
                                          {
                                              NSString *strTime = [NSString stringWithFormat:@"%ld", (long)timeOut];
                                              dispatch_async(dispatch_get_main_queue(), ^
                                              {
                                                     //设置界面的按钮显示 根据自己需求设置
                                                     //NSLog(@"倒计时 %@ 秒",strTime);
                                                     [self setTitle:[NSString stringWithFormat:@"%@%@",strTime,waitTittle] forState:UIControlStateNormal];
                                                     self.userInteractionEnabled = NO;
                                              });
                                              timeOut--;
                                          }
                                      });
    dispatch_resume(_timer);
}

//-(void)startTime:(NSInteger )timeout title:(NSString *)tittle waitTittle:(NSString *)waitTittle waitTime:(NSInteger)time waitTimer:(void(^)(NSInteger time))timeAfter complete:(void(^)(BOOL finished))complete
//{
//    NSInteger timeCount = timeout;
//    self.userInteractionEnabled = NO;
//    self.myTitle=tittle;
//    __block NSInteger timeOut = timeout; //倒计时时间
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
//    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
//    dispatch_source_set_event_handler(_timer, ^
//                                      {
//                                          if(timeOut<=0)
//                                          {
//                                              //倒计时结束，关闭
//                                              dispatch_source_cancel(_timer);
//                                              dispatch_async(dispatch_get_main_queue(), ^
//                                                             {
//                                                                 //设置界面的按钮显示 根据自己需求设置
//                                                                 [self setTitle:tittle forState:UIControlStateNormal];
//                                                                 self.userInteractionEnabled = YES;
//                                                                 complete(YES);
//                                                             });
//                                          }
//                                          else
//                                          {
//                                              NSString *strTime = [NSString stringWithFormat:@"%ld", timeOut];
//                                              dispatch_async(dispatch_get_main_queue(), ^
//                                              {
//                                                  if (timeOut == timeCount-time)
//                                                  {
//                                                      timeAfter(timeOut);
//                                                  }
//                                                 //设置界面的按钮显示 根据自己需求设置
//                                                 //NSLog(@"倒计时 %@ 秒",strTime);
//                                                 [self setTitle:[NSString stringWithFormat:@"%@%@",strTime,waitTittle] forState:UIControlStateNormal];
//                                                 self.userInteractionEnabled = NO;
//                                              });
//                                              timeOut--;
//                                          }
//                                      });
//    dispatch_resume(_timer);
//
//}

//-(void)stopTime
//{
//    if (_timer)
//    {
//        //倒计时结束，关闭
//        dispatch_source_cancel(_timer);
//        _timer=nil;
//       //设置界面的按钮显示 根据自己需求设置
//       [self setTitle:self.myTitle forState:UIControlStateNormal];
//       self.userInteractionEnabled = YES;
//    }
//}

@end
