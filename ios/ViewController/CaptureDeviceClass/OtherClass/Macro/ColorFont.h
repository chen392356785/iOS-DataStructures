//
//  ColorFont.h
//  DF
//
//  Created by Tata on 2017/12/19.
//  Copyright © 2017年 Tata. All rights reserved.
//

#ifndef ColorFont_h
#define ColorFont_h


#endif /* ColorFont_h */


/*
 常用色值
 */
//颜色16进制
#define THRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define THColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//统一背景色值 浅蓝
#define THGlobalBg             THColorFromRGB(0xf6f6f6)
//用于主标题标题 60%黑
#define THTextColor            [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.60]
//用于主题文字颜色
#define THMainTextColor        [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.80]
//系统薄荷绿色
#define THBaseColor            THColorFromRGB(0x5BA997)
//按钮文字 灰色
#define THBaseGray             THColorFromRGB(0x929292)
//用于线或边框的颜色
#define THBaseLightGray        THColorFromRGB(0xe2e3e7)
//系统金色
#define THBaseGolden           THColorFromRGB(0xb29873)
//置灰
#define THLightTextColor       THColorFromRGB(0xFFB4B1B1)
//评论,言论的文字颜色
#define THContentTextColor     THColorFromRGB(0x7a7a7a)
//未编辑时候的按钮背景
#define THBtnBackgroundColor   THColorFromRGB(0x9d9d9d)
//未编辑时候的按钮文字颜色
#define THBtnTitleColor        THColorFromRGB(0x999999)
//编辑后按钮颜色
#define THBtnSelectTitleColor  THColorFromRGB(0xffffff)
//关注按钮的颜色
#define THConcernBtnColor      THColorFromRGB(0xf0f2f4)
//查看全部关注按钮的颜色
#define THSeeAllBtnColor       THColorFromRGB(0xcdcdd3)
//非选中色
#define THUnselectedColor      THColorFromRGB(0x8c8c8c)
//分割线
#define THLineColor            THColorFromRGB(0xe5e5e5)

//字体颜色
#define THTitleColor1          THColorFromRGB(0x111111)
#define THTitleColor3          THColorFromRGB(0x333333)
#define THTitleColor5          THColorFromRGB(0x555555)
#define THTitleColor9          THColorFromRGB(0x999999)
//黄色
#define THYellowColor          THColorFromRGB(0xc5a45b)
//购物车按钮背景色
#define THCarBtnColor          THColorFromRGB(0xd5c091)

#define THShadowColor          THColorFromRGB(0x0e050a)


//苹方 - 常规体
#define kRegularFont(s) [UIFont fontWithName:@"PingFangSC-Regular" size:s]

//苹方 - semibold
#define kSemiboldFont(s) [UIFont fontWithName:@"PingFangSC-Semibold" size:s]

//苹方 - 中黑体
#define kMediumFont(s) [UIFont fontWithName:@"PingFangSC-Medium" size:s]

//苹方 - 细体
#define kLightFont(s) [UIFont fontWithName:@"PingFangSC-Light" size:s]

