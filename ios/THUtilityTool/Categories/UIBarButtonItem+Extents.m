//
//  UIBarButtonItem+Extents.m
//  MiaoTuProject
//
//  Created by Neely on 2018/4/28.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "UIBarButtonItem+Extents.h"
#import "NSMutableAttributedString+Extents.h"
//#import "UIImage+Extents.h"

@implementation UIBarButtonItem (Extents)

+ (NSArray *)defaultRightTitleItemTarget:(id)target
                                      action:(SEL)action
                                        text:(NSString *)text
{
        
        UIBarButtonItem *space = [self placeholderItem:5];
        UIBarButtonItem *right = [self rightTitleItemTarget:target
                                                     action:action
                                                       text:text];
        
        return @[space, right];
}
    
+ (UIBarButtonItem *)rightTitleItemTarget:(id)target
                                   action:(SEL)action
                                     text:(NSString *)text
    {
        return [self rightAttriTitleItemTarget:target
                                        action:action
                                          text:text
                                     withSpace:0
                                         color:COLOR_TITLEBAR_GRAY_TITLE
                                          font:Font_16 fontSize:16];
    }
    
+ (UIBarButtonItem*) placeholderItem:(CGFloat) width
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 1)];
        
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:view];
        return item;
    }
    
//+ (UIBarButtonItem *)leftAttriTitleItemTarget:(id)target
//                                       action:(SEL)action
//                                         text:(NSString *)text
//                                    withSpace:(NSInteger)space
//                                        color:(UIColor *)color
//                                         font:(UIFont *)font
//                                     fontSize:(CGFloat)fontSize
//    {
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//
//        NSMutableAttributedString *buttonString =
//        [NSMutableAttributedString attributeStringWithString:text
//                                                    spaceNum:space
//                                                       color:color
//                                                        font:font
//                                                    fontSize:fontSize];
//
//        [button setAttributedTitle:buttonString forState:UIControlStateNormal];
//        [button setAttributedTitle:buttonString forState:UIControlStateHighlighted];
//        [button setAttributedTitle:buttonString forState:UIControlStateDisabled];
//
//        button.mj_x = 10.0f;
//        button.titleLabel.shadowOffset = CGSizeMake(0, 1);
//        button.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
//        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
//        button.frame = CGRectMake(0, 0, 100, 50);
//
//        UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
//        return barButton;
//    }
//

    
+ (UIBarButtonItem *)rightAttriTitleItemTarget:(id)target
                                        action:(SEL)action
                                          text:(NSString *)text
                                     withSpace:(NSInteger)space
                                         color:(UIColor *)color
                                          font:(UIFont *)font
                                      fontSize:(CGFloat)fontSize
    {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        NSMutableAttributedString *buttonString =
        [NSMutableAttributedString attributeStringWithString:text
                                                    spaceNum:space
                                                       color:color
                                                        font:font
                                                    fontSize:fontSize];
        
        [button setAttributedTitle:buttonString forState:UIControlStateNormal];
        [button setAttributedTitle:buttonString forState:UIControlStateHighlighted];
        [button setAttributedTitle:buttonString forState:UIControlStateDisabled];
        
        button.titleLabel.shadowOffset = CGSizeMake(0, 1);
        
        button.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        
        [button sizeToFit];
        UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        return barButton;
    }
    
//+ (UIBarButtonItem *)barButtonItem:(NSString *)image
//                    withTitle:(NSString *)title
//                   withTarget:(id)target
//                   withAction:(SEL)action;
//    
//    
//    
//{
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
//    [button setTitle:title forState:UIControlStateNormal];
//    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
//    button.size = CGSizeMake(60, 18);
//    [button sizeToFit];
//    return [[self alloc]initWithCustomView:button];
//
//}
+ (UIBarButtonItem *)barButtonItem:(NSString *)image
                        withTarget:(id)target
                        withAction:(SEL)action;
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.size = CGSizeMake(30, 20);
    button.contentMode = UIViewContentModeCenter;
    return [[self alloc]initWithCustomView:button];

}
    
    
    
    
    

@end
