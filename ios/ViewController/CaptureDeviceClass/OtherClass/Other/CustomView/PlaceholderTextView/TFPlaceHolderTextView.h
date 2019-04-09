//
//  TFPlaceHolderTextView.h
//  TH
//
//  Created by 苏浩楠 on 16/4/7.
//  Copyright © 2016年 羊圈科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFPlaceHolderTextView : UITextView
/** 占位文字 */
@property (nonatomic,copy) NSString *placeholder;
/** 占位文字的颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;
@end
