//
//  ShareSheetView.h
//  TaSayProject
//
//  Created by Mac on 15/8/5.
//  Copyright (c) 2015年 xubin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareSheetView : UIView

typedef NS_ENUM(NSInteger , shareViewType) {
    ShareSmalProgramType,        //分享小程序
    SharePostersType,                 //生成海报分享
};
- (instancetype)initWithFrame:(CGRect)frame styleType:(shareViewType )type;
-(instancetype)initWithShare;
- (void) showCentY;
- (void)show;
@property(nonatomic,copy)void (^selectShareMenu)(NSInteger type);
@property(nonatomic,copy)NSString *codImage;
@end
