//
//  Define.h
//  THDiscernFlower
//
//  Created by Tata on 2017/11/20.
//  Copyright © 2017年 Tata. All rights reserved.
//

#ifndef Define_h
#define Define_h


#endif /* Define_h */



#define kImage(a)       [UIImage imageNamed:a]

//高度设置
#define kHeightX 812

#define DFNavigationBar  (iPhoneHeight == 812 ? 88 : 64)
#define DFStatusHeight   (iPhoneHeight == 812 ? 44 : 20)
#define DFItemOffset     (iPhoneHeight == 812 ? 22 : 10)
#define DFTabBarHeight   (iPhoneHeight == 812 ? 83 : 49)
#define DFXHomeHeight    (iPhoneHeight == 812 ? 34 : 0)


//尺寸宏
#define KFont(f)        [UIFont fontWithName:@"STHeitiSC-Light" size:f]
#define KBoldFont(f)    [UIFont fontWithName:@"STHeitiSC-Light-Bold"  size:f]



//iPhone X适配
#define KStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define KNavBarHeight 44.0
#define KTabBarHeight  ([[UIApplication sharedApplication] statusBarFrame].size.height > 20?83:49)
#define KtopHeitht (KStatusBarHeight + KNavBarHeight)
#define KTabSpace  ([[UIApplication sharedApplication] statusBarFrame].size.height > 20?34:0)

//自适应大小
#define sWidth(width)                     iPhoneWidth  * width  / 375.
#define sHeight(height)                   iPhoneHeight * height / 667.





