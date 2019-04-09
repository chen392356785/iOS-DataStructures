//
//  ReleaseNewVarietyHeadView.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/7/31.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^PicSelectItemBlock) (NSMutableArray * ImagArr);

@protocol ReleaseNewVarietyDelegate <NSObject>

@optional
- (void) showActionSheetPicSelectBlock:(PicSelectItemBlock)block;
- (void) remoePicSelectUpDataUIFrame:(CGRect )frame andImageArr:(NSMutableArray *)imgarray;

@end

@interface ReleaseNewVarietyHeadView : UIView

@property (nonatomic, strong) UILabel *photoLabel;

@property (nonatomic,weak) id <ReleaseNewVarietyDelegate> delegage;

@end
