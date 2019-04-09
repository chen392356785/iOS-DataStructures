//
//  NSMutableAttributedString+Extents.m
//  MiaoTuProject
//
//  Created by Neely on 2018/4/28.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "NSMutableAttributedString+Extents.h"
#import <CoreText/CoreText.h>

@implementation NSMutableAttributedString (Extents)

    
+ (instancetype)attributeStringWithString:(NSString *)text
                                 spaceNum:(NSInteger)spaceNumPx
                                    color:(UIColor *)textColor
                                     font:(UIFont *)font
                                 fontSize:(CGFloat)fontSize {
    if (!text || [text isEqualToString:@""]) {
        return nil;
    }
    
    NSMutableAttributedString *attString =
    [[NSMutableAttributedString alloc] initWithString:text];
    NSUInteger length = [attString length];
    
    //字间距
    if (spaceNumPx > 0) {
        NSNumber *space = @(spaceNumPx);
        [attString addAttribute:(id)kCTKernAttributeName
                          value:space
                          range:NSMakeRange(0, length)];
    }
    
    //字体颜色
    if (textColor) {
        [attString addAttribute:(id)NSForegroundColorAttributeName
                          value:(id)textColor
                          range:NSMakeRange(0, length)];
    }
    
    //字体 & 大小
    if (font && fontSize) {
        UIFont *usefont = nil;
        //    if (!TWOS_IOS7) {
        //      usefont = font;
        //    } else {
        usefont = CFBridgingRelease(
                                    CTFontCreateWithName((CFStringRef)font.fontName, fontSize, NULL));
        //    }
        
        [attString addAttribute:(id)kCTFontAttributeName
                          value:usefont
                          range:NSMakeRange(0, length)];
    }
    
    return attString;
}
    
+ (instancetype)attributeStringHtmlString:(NSString *)htmlString
{
        NSError *error = nil;
        
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:&error];
        
        //如果初始化失败就报错
        if (error) {
            attrStr = nil;
        }
        
        return attrStr;
}
    
@end
