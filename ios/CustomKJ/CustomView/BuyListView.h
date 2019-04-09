//
//  BuyListView.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/3/30.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDPhotosGroupView.h"
#import "CustomView+CustomCategory.h"

@interface BuyListView : UIView{
    SMLabel *_titlelbl;
    SMLabel *_numlbl;
    SMLabel *_pricelbl;
    SDPhotosGroupView *_imagesView;
    UIImageView *_lineView;
    SMLabel *_yqkeylbl;
    UITextView *_yqvaluelbl;
    SMLabel *_quyukeylbl;
    SMLabel *_quyuvaluelbl;
    SMLabel *_ganjingLbl;
    SMLabel *_ymkeylbl;
    SMLabel *_ymvaluelbl;
//    LabelView *_lableView;
    
    UIImageView *_paymentImageView;
    UIImageView *_urgencyImageView;
}

-(void)setData:(MTSupplyAndBuyListModel*)model type:(CollecgtionType)type;

@property (nonatomic,copy) DidSelectheadImageBlock selectBlock;
- (instancetype)initWithFrame:(CGRect)frame  type:(CollecgtionType)type;

@end
