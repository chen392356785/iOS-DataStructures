//
//  UIColor+HexRGB.h
//
//
//  Created by jacobChiang on 13-8-14.
//  Copyright (c) 2013年 Michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexRGB)
    
//+ (UIColor *)colorFromHexRGB:(NSString *)inColorString;
//+ (UIColor *)colorWithHex:(NSInteger)hexValue;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
//+ (UIColor *)colorFromInt:(NSInteger)intValue;

//- (BOOL)isEqualToColor:(UIColor *)color;

@end
