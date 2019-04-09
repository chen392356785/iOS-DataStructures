//
//  TFRemindView.h
//  TH
//
//  Created by 苏浩楠 on 16/4/29.
//  Copyright © 2016年 羊圈科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,TFRemindStyle){
    
    TFRemindStyleNote,
    TFRemindStyleAlter,
    TFRemindStyleSubTitle

};

//@protocol TFRemindViewDelegate <NSObject>
//
//- (void)remindViewTapFinish;
//
//@end

@interface TFRemindView : UIView
/**提示文字*/
@property (nonatomic,copy) NSString *message;
@property (nonatomic,copy) NSString *subTitle;//子标题
@property (nonatomic,assign) CGFloat duration;
@property (nonatomic,assign) CGFloat cornerRadius;
@property (nonatomic,strong) UIColor *backgroudColor;
/**背景View*/
@property (nonatomic,strong) UIView *noteBgView;
/**设置样式*/
@property (nonatomic,assign) TFRemindStyle remndStyle;




- (void)show;
- (void)hide;

@end
