//
//  NSString+Extents.h
//  CiCi
//
//  Created by jacobChiang on 13-10-9.
//  Copyright (c) 2013年 Paitao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extents)

- (NSString *)convertStringToMD5String;

- (NSString *)convertStringToMD5String:(int)length;

//- (NSString *)stringByTruncatingToWidth:(CGFloat)width withFont:(UIFont *)font;
//
//- (NSString *)stringByTruncatingToWidth:(CGFloat)width
//                               withFont:(UIFont *)font
//                             withSuffix:(NSString *)suffix;

- (NSString *)urlencode;

- (NSString *)URLDecode;

- (BOOL)evaluateCCPhoneNum;

- (BOOL)evaluateEmail;

- (BOOL)evaluateChinaPhoneNum;

- (BOOL)evaluateValidate;

- (BOOL)evaluatePassword;

- (BOOL)evaluateAccount;

- (BOOL)evaluateNum;

- (BOOL)evaluateBankName;

- (BOOL)evaluateNickName;

- (BOOL)evaluateSpacing;

- (BOOL)evaluateCCPasswd;

- (BOOL)evaNumber;

- (BOOL)evaluateNumber;

- (BOOL)evaluateCommand;

- (BOOL)evaluateBankCodeValidate;

- (CGFloat)lineBreakSizeOfStringwithFont:(UIFont *)font maxwidth:(CGFloat)width;

- (CGFloat)lineBreakSizeOfStringwithFont:(UIFont *)font
                                maxwidth:(CGFloat)width
                           lineBreakMode:(NSLineBreakMode)lineBreakMode;

- (CGFloat)lineBreakSizeOfStringwithFont:(UIFont *)font
                                maxwidth:(CGFloat)width
                           lineBreakMode:(NSLineBreakMode)lineBreakMode
                               lineSpace:(CGFloat)space;

- (CGSize)stringSizeWithFont:(UIFont *)font
                    maxwidth:(CGFloat)width
               lineBreakMode:(NSLineBreakMode)lineBreakMode
                   lineSpace:(CGFloat)space;

-(NSString*)check_line;

-(NSString*)stringwithoutBlankSpace;

//----------split
+ (NSMutableArray *)splitString:(NSString *)originalString
                       maxWidth:(CGFloat)maxWidth
                           font:(UIFont *)font;

+ (CGSize)singalSizeInFont:(UIFont *)font;

+ (CGFloat)singalWidthInFont:(UIFont *)font;

+ (CGFloat)singalHeightInFont:(UIFont *)font;

+ (CGSize)size:(NSString *)text inFont:(UIFont *)font;

+ (CGFloat)width:(NSString *)text inFont:(UIFont *)font;

+ (CGFloat)height:(NSString *)text inFont:(UIFont *)font;

+ (NSString *)contentFromDate:(NSDate *)date;

+ (NSString *)stringByDateString:(NSString *)dateString;

+ (NSString *)chineseStringFromDigitString:(NSString *)nsString;

//去掉前后空格
- (NSString *)trimmedBeginAndEndSpaceString;

//是否只有中文
- (BOOL)isOnlyChinese;

//是否包含中文
- (BOOL)includeChinese;

- (NSString *)formatJSON;

- (NSDictionary *)toDictionary;

- (NSArray *)toArray;

/**
 *  @author yangyixian, 16-08-24 10:08:27
 *
 *  判断 number 是否属于 charactersMacro  属于返回YES
 *
 *  @since 1.7.0
 */
+ (BOOL)validateNumber:(NSString *)number belongSpecialCharacters:(NSString *)charactersMacro;

- (NSString *)check_line_adressArea;

- (NSString *)check_lineDetaliAddress;

/**
 计算文本长度
 */
- (NSInteger)stringByteLength;

@end

@interface NSString (Format)

//转为电话格式
+ (NSString *)stringMobileFormat:(NSString *)mobile;

//数组中文格式（几万）可自行添加
+ (NSString *)stringChineseFormat:(double)value;

@end

/**
 * 判断字符串是否没有内容. 注意: 这次的string会先被执行trim操作.
 */
extern BOOL isStringEmptyAfterTrim(NSString *string);

/**
 * 如果字符串==nil 返回 @"" 否则返回 str
 */
extern NSString *strOrEmpty(NSString *str);

