//
//  TTFunctions.h
//  TTUtility
//
//  Created by shine_tata on 16/9/18.
//  Copyright © 2016年 shine_tata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef void (^TTDispatchBlock)();

#pragma mark - 基本数据类型的判断
/**
 判断对象是否为NSString,不是NSString返回nil

 @param object 待判断对象

 @return 结果
 */
NSString * TTValidateString(id object);

/**
 判断对象是否响应integerValue,不是数字返回0
 
 @param object 待判断对象
 
 @return 结果
 */
NSInteger TTValidateInteger(id object);

/**
 判断对象是否为NSDictionary,不是NSDictionary返回nil
 
 @param object 待判断对象
 
 @return 结果
 */
NSDictionary * TTValidateDictionary(id object);

/**
 判断对象是否为NSArray,不是NSArray返回nil
 
 @param object 待判断对象
 
 @return 结果
 */
NSArray * TTValidateArray(id object);

/**
 判断对象是否响应floatValue,不是数字返回0
 
 @param object 待判断对象
 
 @return 结果
 */
CGFloat TTValidateFloat(id object);

/**
 判断对象是否响应boolValue,不是布尔值返回NO
 
 @param object 待判断对象
 
 @return 结果
 */
BOOL TTValidateBOOL(id object);

#pragma mark - 对多线程的处理

/**
 同步dispatch，主线程

 @param block 处理block
 */
void TTDispatchMainSync(TTDispatchBlock block);

/**
 异步dispatch，主线程
 
 @param block 处理block
 */
void TTDispatchMainAsync(TTDispatchBlock block);

/**
 同步dispatch，子线程
 
 @param block 处理block
 */
void TTDispatchSync(TTDispatchBlock block);

/**
 异步dispatch，子线程
 
 @param block 处理block
 */
void TTDispatchAsync(TTDispatchBlock block);


/**
 延时处理任务，主线程

 @param seconds 延时时间
 @param block   处理block
 */
void TTDispatchDelay(CGFloat seconds, TTDispatchBlock block);

#pragma mark - 屏幕适配

/**
 获取当前手机屏幕相对于iPhone5的缩放系数

 @return 缩放系数
 */
CGFloat TTUIScale();

/**
 获取当前手机屏幕宽高比例与iPhone5宽高比例的差值

 @return 比例差值
 */
CGFloat TTUIRatio();

#pragma mark - 可读时间

/**
 *  可读性时间描述，刚刚
 *
 *  @return 结果字串
 */
NSString * TTDateRecentlyString();

/**
 *  可读性时间描述，几秒前
 *
 *  @param second 秒数
 *
 *  @return 结果字串
 */
NSString * TTDateSecondBeforeString(NSInteger second);

/**
 *  可读性时间描述, 几分钟前
 *
 *  @param minute 分钟数
 *
 *  @return 结果字串
 */
NSString * TTDateMinuteBeforeString(NSInteger minute);

/**
 *  可读性时间描述, 半小时前
 *
 *  @return 结果字串
 */
NSString * TTDateHalfHourBeforeString();

/**
 *  可读性时间描述, 今天
 *
 *  @return 结果字串
 */
NSString * TTDateTodayString();

/**
 *  可读性时间描述, 昨天
 *
 *  @return 结果字串
 */
NSString * TTDateYestodayString();


/**
 *  可读性时间描述，前天
 *
 *  @return 结果字串
 */
NSString * TTDateDayBeforeYestodayString();

#pragma mark - APP版本号

/**
 *  获取App当前版本号
 *
 *  @return App当前版本号
 */
NSString * TTAppVersion();

/**
 *  获取App详细版本，包含build版本号
 *
 *  @return 结果字串
 */
NSString * TTAppDetailedVersion();


#pragma mark - 判断分享类型


/**
 分享类型判断

 @param index 按钮下标
 @return 分享类型
 */
NSString * TTSelectShareType(NSInteger index);


#pragma mark - Color Convertion

/**
 字串转换到颜色对象
 
 @param string 颜色字串，支持UIColor/NSColor类的convenience method，支持6位及8位(带alpha)16进制字串
 
 @return 颜色对象
 */
UIColor * TTColorWithString(NSString *string);

/**
 颜色对象转换到字串
 
 @param color 颜色对象
 
 @return 结果字串，8位16进制字串
 */
NSString * TTStringWithColor(UIColor *color);




