//
//  ACtivityTopView.h
//  MiaoTuProject
//
//  Created by Zmh on 5/5/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIAsyncImageView.h"
@interface ACtivityTopView : UIView
{
    UILabel *_titleLabel;
    UILabel *_addressLabel;
    UILabel *_timeLabel;
    UILabel *_priceLabel;

}
@property (nonatomic,strong) UIAsyncImageView *TopimgView;
//@property (nonatomic,strong) UIImageView *addressView;
@property (nonatomic,strong) UIImageView *rightImageView;
//@property (nonatomic,strong) UIImageView *TimeView;//
@property (nonatomic,strong) UILabel *signLabel;//报名人数
@property (nonatomic,strong) UIView *ActivnameView;

- (id)initWithFrame:(CGRect)frame;

- (void)setImageURl:(NSString *)imageUrl signNum:(NSString *)signNum title:(NSString *)title skimNum:(NSString *)skimNum uint_price:(NSString *)price;//skimNum为浏览次数 signNum为报名次数  uint_price为活动价格

@end
