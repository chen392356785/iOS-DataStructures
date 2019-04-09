//
//  TFRemindView.m
//  TH
//
//  Created by 苏浩楠 on 16/4/29.
//  Copyright © 2016年 羊圈科技. All rights reserved.
//

#import "TFRemindView.h"
#import "AppDelegate.h"

#define remindTag 93

@interface TFRemindView ()
{
    UIImageView *_remindBgImgView;
    
    TFRemindStyle _remindStyle;
}

@end


@implementation TFRemindView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.tag = remindTag;
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
    }
    return self;
}

#pragma mark --设置样式--
- (void)setRemndStyle:(TFRemindStyle)remndStyle {

    _remndStyle = remndStyle;
    
    if (_remindStyle == TFRemindStyleNote)
    {
        _noteBgView = [[UIView alloc] init];
        _noteBgView.userInteractionEnabled = YES;
        _noteBgView.frame = CGRectMake(0, 0,self.width, self.height);
        _noteBgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        [self addSubview:_noteBgView];
    }
    else if (_remindStyle == TFRemindStyleAlter)
    {
        _remindBgImgView = [[UIImageView alloc] init];
        _remindBgImgView.userInteractionEnabled = YES;
        UIImage *image = [UIImage imageNamed:@"remindBg"];
        image = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
        _remindBgImgView.image = image;
        _remindBgImgView.frame = CGRectMake((iPhoneWidth - 216) / 2, iPhoneHeight / 2, 216, 65);
        //            [_remindBgImgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(remindBgViewTap:)]];
        [self addSubview:_remindBgImgView];
    }
    else
    {
        _remindBgImgView = [[UIImageView alloc] init];
        _remindBgImgView.userInteractionEnabled = YES;
        UIImage *image = [UIImage imageNamed:@"remindBg"];
        image = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
        _remindBgImgView.image = image;
        _remindBgImgView.frame = CGRectMake((iPhoneWidth - 216) / 2, iPhoneHeight / 2, 216, 85);
        //            [_remindBgImgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(remindBgViewTap:)]];
        [self addSubview:_remindBgImgView];
    }
}
#pragma mark --设置提示内容--
- (void)setMessage:(NSString *)message {
    
    _message = message;
    
    if (_remindStyle == TFRemindStyleNote) {
        
        
        UIImageView *noWifiImgView = [[UIImageView alloc] init];
        noWifiImgView.image = kImage(@"icon_noNet");
        noWifiImgView.frame = CGRectMake(10, 0, 13,13);
        noWifiImgView.centerY = _noteBgView.centerY;
        [_noteBgView addSubview:noWifiImgView];
        
        UILabel *remindLabel = [[UILabel alloc]init];
        remindLabel.font = kLightFont(14);
        remindLabel.textColor = [UIColor whiteColor];
//        remindLabel.textAlignment = NSTextAlignmentCenter;
        remindLabel.text = message;
        remindLabel.frame = CGRectMake(CGRectGetMaxX(noWifiImgView.frame) + 5, 0, _noteBgView.width,_noteBgView.height) ;
        remindLabel.numberOfLines = 0;
        remindLabel.backgroundColor = [UIColor clearColor];
        [_noteBgView addSubview:remindLabel];
        
        UIImageView *noWifiArrowImgView = [[UIImageView alloc] init];
        noWifiArrowImgView.image = kImage(@"icon_noWifi_arrow");
        noWifiArrowImgView.frame = CGRectMake(iPhoneWidth - 14 - 20, 0, 7,12);
        noWifiArrowImgView.centerY = _noteBgView.centerY;
        [_noteBgView addSubview:noWifiArrowImgView];
        
//        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(remindBgViewTap:) userInfo:nil repeats:NO];
    }
    else if (_remindStyle == TFRemindStyleAlter) {
        
        UILabel *remindLabel = [[UILabel alloc]init];
        remindLabel.font = kLightFont(14);
        remindLabel.textColor = [UIColor whiteColor];
        remindLabel.textAlignment = NSTextAlignmentCenter;
        remindLabel.numberOfLines = 0;
        remindLabel.text = message;
        CGSize maxSize = CGSizeMake(CGRectGetWidth(_remindBgImgView.frame), MAXFLOAT);
        NSDictionary *messageDic = [NSDictionary dictionaryWithObjectsAndKeys:kLightFont(14),NSFontAttributeName, nil];
        CGSize messageSize = [message boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:messageDic context:nil].size;
        
        if (messageSize.height < 65) {
            _remindBgImgView.bounds  = CGRectMake(0, 0, CGRectGetWidth(_remindBgImgView.frame)+10, 65);
            remindLabel.frame = CGRectMake(5, 0, 216 - 10, 65);
        }else{
            _remindBgImgView.bounds  = CGRectMake(0, 0, CGRectGetWidth(_remindBgImgView.frame)+10, messageSize.height + 10);
            remindLabel.frame = CGRectMake(5, 5, 216 - 10, messageSize.height);
        }
        
        remindLabel.backgroundColor = [UIColor clearColor];
        [_remindBgImgView addSubview:remindLabel];
        
        [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(remindBgViewTap:) userInfo:nil repeats:NO];
    }
    else {
    
        //主标题
        UILabel *remindLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, _remindBgImgView.width, 20)];
        remindLabel.font = kLightFont(16);
        remindLabel.textColor = [UIColor whiteColor];
        remindLabel.textAlignment = NSTextAlignmentCenter;
        remindLabel.numberOfLines = 1;
        remindLabel.text = message;
        remindLabel.backgroundColor = [UIColor clearColor];
        remindLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [_remindBgImgView addSubview:remindLabel];
        
        CGSize maxSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
        NSDictionary *messageDic = [NSDictionary dictionaryWithObjectsAndKeys:kLightFont(16),NSFontAttributeName, nil];
        CGSize messageSize = [message boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:messageDic context:nil].size;

        CGRect frame = _remindBgImgView.frame;
        frame.size.width = messageSize.width+40;
        _remindBgImgView.frame  = frame;
        
//        [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(remindBgViewTap:) userInfo:nil repeats:NO];
    }
}
#pragma mark --设置副标题--
- (void)setSubTitle:(NSString *)subTitle {
    _subTitle = subTitle;
    //副标题
    UILabel *subTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, _remindBgImgView.width, 15)];
    subTitleLab.font = kLightFont(12);
    subTitleLab.textColor = THTextColor;
    subTitleLab.textAlignment = NSTextAlignmentCenter;
    subTitleLab.numberOfLines = 0;
    subTitleLab.text = _subTitle;
    subTitleLab.backgroundColor = [UIColor clearColor];
    [_remindBgImgView addSubview:subTitleLab];
    

    CGSize maxSize = CGSizeMake(CGRectGetWidth(_remindBgImgView.frame)-40, MAXFLOAT);
     NSDictionary *subTitleDic = [NSDictionary dictionaryWithObjectsAndKeys:kLightFont(12),NSFontAttributeName, nil];
    CGSize subTitleSize = [_subTitle boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:subTitleDic context:nil].size;

    if (subTitleSize.height > 15)
    {
        CGRect frame = subTitleLab.frame;
        frame.size.height = subTitleSize.height;
        subTitleLab.frame  = frame;
        
        frame = _remindBgImgView.frame;
        frame.size.height = subTitleSize.height+70;
        _remindBgImgView.frame  = frame;
        
    }
    
    _remindBgImgView.center = CGPointMake(iPhoneWidth/2, iPhoneHeight/2);

}

-(void)remindBgViewTap:(UITapGestureRecognizer *)tap
{
    [self removeFromSuperview];
}
- (void)show
{
    if ([[[UIApplication sharedApplication].keyWindow viewWithTag:remindTag] isKindOfClass:[self class]] ) {
        [[[UIApplication sharedApplication].keyWindow viewWithTag:remindTag] removeFromSuperview];
    }
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)hide
{
    [[[UIApplication sharedApplication].keyWindow viewWithTag:remindTag] removeFromSuperview];
}
@end
