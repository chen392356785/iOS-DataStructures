//
//  TFTipsView.h
//  TH
//
//  Created by Tata on 2017/11/15.
//  Copyright © 2017年 羊圈科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TFTipsType) {
    //居上
    kTFTipsTypeTop,
    //居中
    kTFTipsTypeCenter,
    //居底
    kTFTipsTypeBottom,
};

@interface TFTipsView : UIView

@property (nonatomic, strong) NSString *tips;

@property (nonatomic, assign) TFTipsType tipsType;

- (instancetype)initWithType:(TFTipsType)type;

- (void)show;

- (void)dismiss;

@end
