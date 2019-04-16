//
//  DeviceConfiguation.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/5/28.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#ifndef DeviceConfiguation_h
#define DeviceConfiguation_h

#define KTelNum @"13396578980"

//iPhone X适配
#define KStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define KNavBarHeight 44.0
#define KTabBarHeight  ([[UIApplication sharedApplication] statusBarFrame].size.height > 20?83:49)
#define KtopHeitht (KStatusBarHeight + KNavBarHeight)
#define KTabSpace  ([[UIApplication sharedApplication] statusBarFrame].size.height > 20?34:0)

// 当前设备大小
#define iPhoneWidth [UIScreen mainScreen].bounds.size.width
#define iPhoneHeight [UIScreen mainScreen].bounds.size.height
//自适应大小
#define kWidth(width)      iPhoneWidth  * width  / 375.f
#define kHeight(height)    iPhoneHeight * height / 667.f

#define kLevelSpace(space)  iPhoneWidth  * space  / 375.f    //水平方向距离间距
#define kVertiSpace(space)  iPhoneHeight * space / 667.f     //垂直方向距离间距


#endif /* DeviceConfiguation_h */

/*
 se/5s  {320, 568}
 6s     {375, 667}
 iphonX {375, 812}
 */



