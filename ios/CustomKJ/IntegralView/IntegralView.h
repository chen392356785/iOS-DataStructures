//
//  IntegralView.h
//  MiaoTuProject
//
//  Created by Zmh on 4/5/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntegralView : UIView

@property(nonatomic,copy)DidSelectBtnBlock selectBtnBlock;
@property (nonatomic,strong)UIButton *integBtn;
//success判断是否成功 integral为获取的积分
- (id)initWithFrame:(CGRect)frame days:(NSString *)day;
@end
