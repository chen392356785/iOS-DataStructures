//
//  RefreshHeader.m
//  TH
//
//  Created by 羊圈科技 on 16/5/20.
//  Copyright © 2016年 羊圈科技. All rights reserved.
//

#import "RefreshHeader.h"

@implementation RefreshHeader

- (void)prepare
{
    [super prepare];
    
    self.stateLabel.textColor           = THBaseGray;
    self.lastUpdatedTimeLabel.textColor = THBaseGray;
    self.stateLabel.font                = kLightFont(12);
    self.lastUpdatedTimeLabel.font      = kLightFont(14);
    self.lastUpdatedTimeLabel.hidden    = YES;

    // 设置普通状态的动画图片
    NSMutableArray * idleImages = [NSMutableArray array];
    for (NSUInteger i = 0; i<=7; i++)
    {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"RefreshHeader%zd", i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray * refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 0; i<=7; i++)
    {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"RefreshHeader%zd", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}

@end
