//
//  TopicListView.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/3/30.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "TopicListView.h"

@implementation TopicListView
- (instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        
//        UIView *linview=[[UIView alloc]initWithFrame:CGRectMake(15, 0, WindowWith-30, 1)];
//        linview.backgroundColor=cLineColor;
//        [self addSubview:linview];

   
        SMLabel *label=[[SMLabel alloc]initWithFrameWith:CGRectMake(15, 1+5, WindowWith-30, 38) textColor:cBlackColor textFont:sysFont(14)];
        label.numberOfLines=0;
        _contentlbl=label;
        label.text=@"     美丽的台湾红樱花，美丽的心情，你怎么看樱花？是你在看花还是花在看你。";
       [self addSubview:label];
  
        SDPhotosGroupView *imagesView=[[SDPhotosGroupView alloc]initWithFrame:CGRectMake(15, label.bottom+5, WindowWith-30, 345) withTableViewCell:YES];
        _imagesView=imagesView;
        [self addSubview:imagesView];
 

        UIImage *timeImg=Image(@"fav_time.png");
        UIImageView *timeImageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, imagesView.bottom+10, timeImg.size.width, timeImg.size.height)];
        timeImageView.image=timeImg;
        _timeImageView=timeImageView;
        [self addSubview:timeImageView];
        CGSize timeSize=[IHUtility GetSizeByText:@"2015年11月" sizeOfFont:12 width:200];
        SMLabel *timeLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(timeImageView.right+5, timeImageView.top, WindowWith, timeSize.height) textColor:cGrayLightColor textFont:sysFont(12)];
        timeLbl.text=@"2015年11月";
        _timelbl=timeLbl;
        [self addSubview:timeLbl];
   
        UIImage *adressImg=Image(@"MT_adress.png");
        CGSize adressSize=[IHUtility GetSizeByText:@"湖南  长沙" sizeOfFont:12 width:200];
        UIImageView *adressImageView=[[UIImageView alloc]initWithFrame:CGRectMake(WindowWith-15-adressSize.width-adressImg.size.width-5, timeImageView.top, adressImg.size.width, adressImg.size.height)];
        adressImageView.image=adressImg;
        _addressImge=adressImageView;
        [self addSubview:adressImageView];
        
        SMLabel *adressLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, adressImageView.top, WindowWith-15, adressSize.height) textColor:cGrayLightColor textFont:sysFont(12)];
        adressLbl.text=@"湖南  长沙";
        _addresslbl=adressLbl;
        adressLbl.textAlignment=NSTextAlignmentRight;
        [self addSubview:adressLbl];
   
    }
    return self;
}

-(void)setData:(MTTopicListModel *)model{
    _contentlbl.text=model.topic_content;
    CGSize size=[IHUtility GetSizeByText:model.topic_content sizeOfFont:14 width:WindowWith-30];
    CGRect rect=_contentlbl.frame;
    rect.size.height=size.height;
    _contentlbl.frame=rect;
    
    _imagesView.imagesCellArray=model.imgArray;
    
    rect=_imagesView.frame;
    rect.origin.y=_contentlbl.bottom+7;
    rect.size.height=[IHUtility getNewImagesViewHeigh:model.imgArray imageWidth:WindowWith-30];
    _imagesView.frame=rect;
    
    
    rect=_timeImageView.frame;
    rect.origin.y=_imagesView.bottom+5;
    _timeImageView.frame=rect;
    
    rect=_timelbl.frame;
    rect.origin.y=_timeImageView.top;
    _timelbl.frame=rect;
    
    rect=_addressImge.frame;
    rect.origin.y=_timeImageView.top;
    _addressImge.frame=rect;
    
    rect=_addresslbl.frame;
    rect.origin.y=_timeImageView.top;
    _addresslbl.frame=rect;
    
    _timelbl.text=[IHUtility compareCurrentTimeString:model.uploadtime];
    
    CGSize adressSize=[IHUtility GetSizeByText:model.address sizeOfFont:12 width:200];
    
    rect=_addressImge.frame;
    
    UIImage *adressImg=Image(@"MT_adress.png");
    rect.origin.x=WindowWith-15-adressSize.width-5-adressImg.size.width;
    _addressImge.frame=rect;
    
    rect=_addresslbl.frame;
    rect.origin.x=_addressImge.right+5;
    rect.origin.y=_addressImge.top;
    rect.size.width=adressSize.width;
    
    _addresslbl.text=model.address;
    if ([_addresslbl.text isEqualToString:@""]||[_addresslbl.text isEqualToString:@"(null)(null)"]||[_addresslbl.text isEqualToString:@" "]) {
        _addressImge.hidden=YES;
        _addresslbl.hidden=YES;
    }else{
        _addresslbl.hidden=NO;
        _addressImge.hidden=NO;
    }
   
}

@end
