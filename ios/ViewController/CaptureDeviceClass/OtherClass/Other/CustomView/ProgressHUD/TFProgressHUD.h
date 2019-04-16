//
//  TFProgressHUD.h
//  TH
//
//  Created by Tata on 2017/11/13.
//  Copyright © 2017年 羊圈科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TFProgressHUDType) {
    //只有转圈图
    kTFProgressHUDTypeCycle,
    //只有文字提示
    kTFProgressHUDTypeTips,
    //有转圈图也有文字提示 (默认样式)
    kTFProgressHUDTypeCycleAndTips,
};

@interface TFProgressHUD : UIView

@property (nonatomic, strong) NSString *message;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, assign) TFProgressHUDType progressHUDType;

- (instancetype)initWithType:(TFProgressHUDType)type;

- (void)show;

- (void)dismiss;

@end
