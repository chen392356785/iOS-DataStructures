//
//  UILabel+YVAdd.h
//  YVBaseMain
//
//  Created by Bryant on 2017/11/8.
//  Copyright © 2017年 大兵布莱恩特. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YBAttributeTapActionDelegate <NSObject>
@optional
/**
 *  YBAttributeTapActionDelegate
 *
 *  @param string  点击的字符串
 *  @param range   点击的字符串range
 *  @param index 点击的字符在数组中的index
 */
- (void)yb_attributeTapReturnString:(NSString *_Nullable)string
							  range:(NSRange)range
							  index:(NSInteger)index;
@end

@class YBAttributeModel;

@interface UILabel (YVAdd)

NS_ASSUME_NONNULL_BEGIN

#pragma mark - YBAttributeTextTapAction


/**
 *  是否打开点击效果，默认是打开
 */
@property (nonatomic, assign) BOOL enabledTapEffect;

/**
 *  给文本添加点击事件Block回调
 *
 *  @param strings  需要添加的字符串数组
 *  @param tapClick 点击事件回调
 */
- (void)yb_addAttributeTapActionWithStrings:(NSArray <NSString *> *)strings
								 tapClicked:(void (^) (NSString *string , NSRange range , NSInteger index))tapClick;

/**
 *  给文本添加点击事件delegate回调
 *
 *  @param strings  需要添加的字符串数组
 *  @param delegate delegate
 */
- (void)yb_addAttributeTapActionWithStrings:(NSArray <NSString *> *)strings
								   delegate:(id <YBAttributeTapActionDelegate> )delegate;


NS_ASSUME_NONNULL_END

@end


@interface YBAttributeModel : NSObject

@property (nonatomic, copy , nullable) NSString *str;

@property (nonatomic, assign) NSRange range;

@end
