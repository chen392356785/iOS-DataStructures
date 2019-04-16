//
//  AppDelegate.h
//  SkillExchange
//
//  Created by lfl on 15-3-3.
//  Copyright (c) 2015年 xubin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EaseMob.h"
#import "LaunchPageView.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    LaunchPageView *_launchView;
}

- (CGFloat)autoScaleW:(CGFloat)w;
- (CGFloat)autoScaleH:(CGFloat)h;

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, assign) CGFloat autoSizeScaleW;
//当前屏幕与设计尺寸(iPhone6)高度比例
@property (nonatomic, assign) CGFloat autoSizeScaleH;

@end

