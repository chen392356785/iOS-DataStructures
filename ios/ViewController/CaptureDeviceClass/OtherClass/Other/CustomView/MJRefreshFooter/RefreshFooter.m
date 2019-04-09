//
//  RefreshFooter.m
//  TH
//
//  Created by 羊圈科技 on 16/5/23.
//  Copyright © 2016年 羊圈科技. All rights reserved.
//

#import "RefreshFooter.h"

@implementation RefreshFooter
- (void)prepare
{
    [super prepare];
	self.stateLabel.textColor = THBaseGray;
	self.stateLabel.font      = kLightFont(12);
}
@end
