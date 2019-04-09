//
//  YQAlertView.h
//  YQAlertView
//
//  Created by on 16/5/4.
//  Copyright © 2016年 cmbfae Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TFOrderModel,TFFreshFlowerOrderDetailModel;
#define HEX_RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]


@class YQAlertView;

@protocol YQAlertViewDelegate <NSObject>
@optional
- (void)alertView:(YQAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
@end

@interface YQAlertView : UIView
@property (weak, nonatomic) UILabel *titleLabel;
@property (weak, nonatomic) UILabel *messageLabel;
@property (weak, nonatomic) UIView  *contentView;
@property(nonatomic, strong)UIImage *icon;
@property(nonatomic, copy)NSString  *title;
@property(nonatomic, copy)NSString  *message;
@property(nonatomic, copy)NSMutableAttributedString * attrMessage;

@property (nonatomic,strong) TFOrderModel * orderModel;
@property (nonatomic,strong) TFFreshFlowerOrderDetailModel * orderDetailModel;
//携带属性
@property (nonatomic,strong) id object1;
@property (nonatomic,strong) id object2;
/**位置*/
@property (nonatomic,strong) NSIndexPath *indexPath;
/**记录选择的按钮*/
@property (nonatomic,strong) UIButton * selectetButton;


@property (weak, nonatomic) id<YQAlertViewDelegate> delegate;

/**
 *  init with a NSAttributedString type message
 */
- (instancetype)initWithTitle:(NSString *)title attributeMessage:(NSMutableAttributedString *)attrMessage delegate:(id<YQAlertViewDelegate>)delegate buttonTitles:(NSString *)buttonTitles, ... NS_REQUIRES_NIL_TERMINATION;
/**
 *  init with an nomal NSString type message
 */
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id<YQAlertViewDelegate>)delegate buttonTitles:(NSString *)buttonTitles, ... NS_REQUIRES_NIL_TERMINATION;


- (void)Show;
@end
