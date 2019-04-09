//
//  MJRefreshBackFooter.m
//  TH
//
//  Created by 羊圈科技 on 16/6/3.
//  Copyright © 2016年 羊圈科技. All rights reserved.
//

#import "MJRefreshAutoBackFooter.h"

@implementation MJRefreshAutoBackFooter
- (void)prepare
{
    [super prepare];
//    self.arrowView.hidden = YES;
    self.stateLabel.textColor = THBaseGray;
    self.stateLabel.font      = kLightFont(12);
}
@end
