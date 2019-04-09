//
//  NSString+Extension.h
//  TH
//
//  Created by 苏浩楠 on 16/4/7.
//  Copyright © 2016年 羊圈科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
// 字符串中是否包含emoji表情
+ (BOOL)stringContainsEmoji:(NSString *)string;

- (BOOL)isIncludingEmoji;

// 判断输入是否为空格(判断输入为空或者输入参数只有空格)
+ (BOOL)stringIsEmpty:(NSString *)string;

// 判断是否包含空格(判断输入为空或者输入参数只有空格)
+ (BOOL)stringContainEmpty:(NSString *)string;

//验证手机号
- (BOOL)checkTelNumber;

-(BOOL)isChinese;

@end
