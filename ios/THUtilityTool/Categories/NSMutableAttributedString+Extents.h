//
//  NSMutableAttributedString+Extents.h
//  MiaoTuProject
//
//  Created by Neely on 2018/4/28.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableAttributedString (Extents)
    
+ (instancetype)attributeStringWithString:(NSString *)text
                                 spaceNum:(NSInteger)spaceNumPx
                                    color:(UIColor *)textColor
                                     font:(UIFont *)font
                                 fontSize:(CGFloat)size;
    
    
+ (instancetype)attributeStringHtmlString:(NSString *)text;

@end
