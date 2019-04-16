//
//  NSAttributedString+YVText.h
//  YVPin
//
//  Created by Bryant on 2017/11/7.
//  Copyright © 2017年 大兵布莱恩特. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSAttributedString (YVText)

#pragma mark - 富文本操作

/**
 *  单纯改变一句话中的某些字的颜色（一种颜色）
 *
 *  @param color    需要改变成的颜色
 *  @param totalStr 总的字符串
 *  @param subArray 需要改变颜色的文字数组(要是有相同的 只取第一个)
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)ls_changeCorlorWithColor:(UIColor *)color
											TotalString:(NSString *)totalStr
										 SubStringArray:(NSArray <NSString *> *)subArray;

/**
 单纯的改变一句话中 多个子字符串颜色

 @param colors 颜色数组
 @param totalStr 总的字符串
 @param subArray  需要改变颜色的文字数组(要是有相同的 只取第一个)
 @return 生成的富文本
 */
+ (NSMutableAttributedString *)ls_changeCorlorsWithArray:(NSArray <UIColor *> *)colors
											 TotalString:(NSString *)totalStr
										  SubStringArray:(NSArray <NSString *> *)subArray;


/**
 单纯的改变一句话中 多个子字符串颜色和字体

 @param colors 颜色数组
 @param fonts 字体数组
 @param totalStr 总的字符串
 */
+ (NSMutableAttributedString *)ls_changeCorlorsWithArray:(NSArray <UIColor *> *)colors
												   fonts:(NSArray <UIFont *>*)fonts
											 TotalString:(NSString *)totalStr
										  SubStringArray:(NSArray <NSString *> *)subArray;

/**
 *  单纯改变句子的字间距（需要 <CoreText/CoreText.h>）
 *
 *  @param totalString 需要更改的字符串
 *  @param space       字间距
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)ls_changeSpaceWithTotalString:(NSString *)totalString
													   Space:(CGFloat)space;

/**
 *  单纯改变段落的行间距
 *
 *  @param totalString 需要更改的字符串
 *  @param lineSpace   行间距
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)ls_changeLineSpaceWithTotalString:(NSString *)totalString
													   LineSpace:(CGFloat)lineSpace;

/**
 *  同时更改行间距和字间距
 *
 *  @param totalString 需要改变的字符串
 *  @param lineSpace   行间距
 *  @param textSpace   字间距
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)ls_changeLineAndTextSpaceWithTotalString:(NSString *)totalString
															  LineSpace:(CGFloat)lineSpace
															  textSpace:(CGFloat)textSpace;
/**
 *  改变某些文字的颜色 并单独设置其字体
 *
 *  @param font        设置的字体
 *  @param color       颜色
 *  @param totalString 总的字符串
 *  @param subArray    想要变色的字符数组
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)ls_changeFontAndColor:(UIFont *)font
											   Color:(UIColor *)color
										 TotalString:(NSString *)totalString
									  SubStringArray:(NSArray <NSString *> *)subArray;

/**
 *  为某些文字改为链接形式
 *
 *  @param totalString 总的字符串
 *  @param subArray    需要改变颜色的文字数组(要是有相同的 只取第一个)
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)ls_addLinkWithTotalString:(NSString *)totalString
										  SubStringArray:(NSArray <NSString *> *)subArray;

/**
 拼接图片到富文本=
 */
+ (NSAttributedString *) yv_addImage:(UIImage *)image
							  bounds:(CGRect)bounds;

/**
 根据一个字符串生成一个 NSAttributedString
 */
+ (__kindof NSAttributedString *) attributedWithString:(NSString *)string;


@end


@interface NSMutableAttributedString (YVAdd)

/**
 设置行间距
 */
- (void) setLinSpacing:(CGFloat)lineSpacing;

/**
 设置文本对齐方式
 
 @param alignment 对齐方式
 @param totalString 字符串
 */
- (void) ls_changeTextAliment:(NSTextAlignment)alignment
                  TotalString:(NSString *)totalString
               SubStringArray:(NSArray *)subArray;

@end
