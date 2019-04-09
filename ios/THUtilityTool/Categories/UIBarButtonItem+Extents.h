//
//  UIBarButtonItem+Extents.h
//  MiaoTuProject
//
//  Created by Neely on 2018/4/28.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extents)

+ (NSArray *)defaultRightTitleItemTarget:(id)target
                                      action:(SEL)action
                                        text:(NSString *)text;
//    
//+ (UIBarButtonItem *)leftAttriTitleItemTarget:(id)target
//                                       action:(SEL)action
//                                         text:(NSString *)text
//                                    withSpace:(NSInteger)space
//                                        color:(UIColor *)color
//                                         font:(UIFont *)font
//                                     fontSize:(CGFloat)fontSize;
    
+ (UIBarButtonItem *)rightAttriTitleItemTarget:(id)target
                                        action:(SEL)action
                                          text:(NSString *)text
                                     withSpace:(NSInteger)space
                                         color:(UIColor *)color
                                          font:(UIFont *)font
                                      fontSize:(CGFloat)fontSize;
    
    
+ (UIBarButtonItem*) placeholderItem:(CGFloat) width;
    
    /**
     带有图片和标题的barButton
     
     @param image 图片
     @param title 标题
     @return ButtonItem
     */
//+ (UIBarButtonItem *)barButtonItem:(NSString *)image
//                    withTitle:(NSString *)title
//                   withTarget:(id)target
//                   withAction:(SEL)action;
//
    
    /**
     带有图片的barButton
     
     @param image 图片
     @return ButtonItem
     */
+ (UIBarButtonItem *)barButtonItem:(NSString *)image
                           withTarget:(id)target
                           withAction:(SEL)action;


@end
