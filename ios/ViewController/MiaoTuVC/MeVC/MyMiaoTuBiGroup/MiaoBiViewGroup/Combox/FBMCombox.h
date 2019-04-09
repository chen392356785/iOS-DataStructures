//
//  FBMCombox.h
//  ptcommon
//
//  Created by 李超 on 16/7/8.
//  Copyright © 2016年 PTGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewWithBlock.h"

@class FBMCombox;

/**
 *  @author fangbmian, 16-07-08 10:07:01
 *
 *  协议
 */
@protocol FBMComboxDelegate <NSObject>

@optional

- (void)dropMenuWillShow:(FBMCombox*)combox;
- (void)dropMenuWillHide:(FBMCombox*)combox;

- (void)dropMenuDidShow:(FBMCombox*)combox;
- (void)dropMenuDidHide:(FBMCombox*)combox;

- (void)combox:(FBMCombox*)combox didSelectItem:(NSString*)item;

@end

@interface FBMCombox : UIView

@property (nonatomic, assign) id<FBMComboxDelegate> delegate;

/**
 *  @author fangbmian, 16-07-08 10:07:30
 *
 *  初始化
 *
 *  @param items item
 *  @param rect  frame
 *
 *  @return self
 */
- (id)initWithItems:(NSArray*)items withFrame:(CGRect)rect;

@property (nonatomic,assign) CGFloat textFont;
/**
 *  @author fangbmian, 16-07-08 10:07:56
 *
 *  隐藏方法
 */
//- (void)hideDropMenu;

@end
