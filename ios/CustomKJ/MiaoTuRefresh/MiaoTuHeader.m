//
//  MiaoTuHeader.m
//  MiaoTuProject
//
//  Created by Mac on 16/4/7.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MiaoTuHeader.h"

@implementation MiaoTuHeader
#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
    self.stateLabel.font=sysFont(13);
    self.stateLabel.textColor=cGreenColor;
    // 设置正在刷新状态的动画图片
    self.lastUpdatedTimeLabel.hidden=YES;
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=8; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"f_%zd", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    /*
    [super prepare];
    self.lastUpdatedTimeLabel.hidden=YES;
    self.stateLabel.hidden=YES;
 
   // [self setBackgroundColor:cLineColor];
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=6; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"h_%zd", i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=6; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"h_%zd", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
     */
}

@end
