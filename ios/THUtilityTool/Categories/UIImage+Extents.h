//
//  UIImage+Extents.h
//  Owner
//
//  Created by 杭州庭好数字科技有限公司 on 2018/3/21.
//  Copyright © 2018年 万匿理. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extents)

//+ (UIImage *)imageWithColor:(UIColor *)color;
    
+ (UIImage *)pureImageFromColor:(UIColor *)color withSize:(CGSize)size;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
@end
