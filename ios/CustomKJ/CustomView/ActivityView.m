//
//  ActivityView.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/5/4.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "ActivityView.h"

@implementation ActivityView

- (instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
       // UIImage *img=Image(@"yaoqingimg.png");
        UIAsyncImageView *imageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(15, 20, WindowWith-30, 160)];
        _topImageView = imageView;
        [self addSubview:imageView];
        
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.left, imageView.bottom+10, 250, 15) textColor:cBlackColor textFont:sysFont(15)];
        lbl.text=@"2016年中苗会西藏游学之旅拉萨站";
        _titileLabel = lbl;
        [self addSubview:lbl];
        
        
        UIImage *adressImg=Image(@"MT_adress.png");
        
        CGSize adressSize=[IHUtility GetSizeByText:@"西藏拉萨" sizeOfFont:12 width:200];
        
        UIImageView *adressImageView=[[UIImageView alloc]initWithFrame:CGRectMake(lbl.left, lbl.bottom+10, adressImg.size.width, adressImg.size.height)];
        adressImageView.image=adressImg;
        
        [self addSubview:adressImageView];
        SMLabel *adressLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(adressImageView.right+5, adressImageView.top, adressSize.width, adressSize.height) textColor:cGrayLightColor textFont:sysFont(12)];
        adressLbl.text=@"西藏拉萨";
        _addressLabel = adressLbl;
        [self addSubview:adressLbl];
        
        
        
        
        UIImage *timeImg=Image(@"fav_time.png");
        UIImageView *timeImageView=[[UIImageView alloc]initWithFrame:CGRectMake(adressLbl.right+15, adressImageView.top, timeImg.size.width, timeImg.size.height)];
        timeImageView.image=timeImg;
       
        [self addSubview:timeImageView];
        
        SMLabel *timeLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(timeImageView.right+5, timeImageView.top, 200, 15) textColor:cGrayLightColor textFont:sysFont(12)];
        timeLbl.text=@"16年2月10日";
        _timeLabel = timeLbl;
        [self addSubview:timeLbl];
        
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, lbl.top, WindowWith-15, 15) textColor:RGB(230, 122, 119) textFont:sysFont(15)];
        lbl.text=@"￥120";
        _priceLabel = lbl;
        lbl.textAlignment=NSTextAlignmentRight;
        [self addSubview:lbl];
        
        
        
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(15, adressImageView.bottom+5, WindowWith-30, 1)];;
        lineView.backgroundColor=cLineColor;
        [self addSubview:lineView];
       
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
        
        [btn setTitle:@"立即报名" forState:UIControlStateNormal];
        
        btn.frame=CGRectMake(WindowWith-15-90, lineView.bottom+10, 90, 30);
        [btn setLayerMasksCornerRadius:7 BorderWidth:1 borderColor:cGreenColor];
        [btn setTitleColor:cGreenColor forState:UIControlStateNormal];
        self.signBtu = btn;
        [self addSubview:btn];
        
        
        lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 294, WindowWith, 6)];
        lineView.backgroundColor=cLineColor;
        [self addSubview:lineView];
        
        
    }
    
    return self;
}

//- (void)setActivitiesData:(ActivitiesListModel *)model
//{
//    [_topImageView setImageAsyncWithURL:model.activities_pic placeholderImage:Image(@"defaulLogo.png")];
//    _topImageView.frame = CGRectMake(15, 20, WindowWith-30, 160);
//    
//    _titileLabel.text = model.activities_titile;
//    
//    CGSize adressSize=[IHUtility GetSizeByText:model.activities_address sizeOfFont:12 width:200];
//    
//    _addressLabel.width = adressSize.width;
//    _addressLabel.height = adressSize.height;
//    _addressLabel.text = model.activities_address;
//    
//    _timeLabel.text = model.activities_starttime;
//    
//    _priceLabel.text = [NSString stringWithFormat:@"￥%@",model.payment_amount];
//
//}

@end
