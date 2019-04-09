//
//  ACtivityTopView.m
//  MiaoTuProject
//
//  Created by Zmh on 5/5/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "ACtivityTopView.h"
//#import "UIAsyncImageView.h"

@implementation ACtivityTopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        UIAsyncImageView *topImage = [[UIAsyncImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.53*kScreenWidth)];
        self.TopimgView = topImage;
//        self.TopimgView.contentMode=UIViewContentModeScaleToFill;
        [self addSubview:topImage];
        
        UIView *view = [[UIView alloc] initWithFrame:topImage.bounds];
        view.backgroundColor = RGBA(0, 0, 0, 0.1);
//        [self addSubview:view];
        
//        UILabel *signlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 29.2)];
//        signlabel.backgroundColor = RGB(108, 123, 138);
//        signlabel.textColor =[UIColor whiteColor];
//        signlabel.font = [UIFont systemFontOfSize:15.0];
//        signlabel.layer.cornerRadius = 8.0;
//        signlabel.textAlignment = NSTextAlignmentCenter;
//        signlabel.layer.masksToBounds = YES;
//        self.signLabel = signlabel;
//        [topImage addSubview:signlabel];
        
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, topImage.bottom, kScreenWidth, 70)];
        self.ActivnameView = topView;
        [self addSubview:topView];
        
        UILabel *TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 14, kScreenWidth - 30, 0)];
        TitleLabel.font = sysFont(18.0);
        TitleLabel.textColor = RGB(68, 68, 69);
        TitleLabel.numberOfLines = 0;
        _titleLabel = TitleLabel;
        [topView addSubview:TitleLabel];
        
        UILabel *priceLbl = [[UILabel alloc] initWithFrame:CGRectMake(TitleLabel.right + 15, 0, 60, 23)];
        priceLbl.centerY = TitleLabel.centerY;
        priceLbl.textColor = RGB(6, 193, 174);
        priceLbl.font = sysFont(18);
        _priceLabel = priceLbl;
        [topView addSubview:priceLbl];
        
        
        UILabel *adressLabel = [[UILabel alloc] initWithFrame:CGRectMake(TitleLabel.left, TitleLabel.bottom + 11, 0, 17)];
        adressLabel.font = sysFont(12);
        adressLabel.textColor = RGB(108, 123, 138);
        _addressLabel = adressLabel;
        [topView addSubview:adressLabel];
        
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(adressLabel.right + 20, TitleLabel.bottom + 11, 72, 17)];
        _timeLabel = timeLabel;
        timeLabel.font = sysFont(12);
        timeLabel.textColor = RGB(108, 123, 138);
        [topView addSubview:timeLabel];
       
        
    }
    return self;
}

- (void)setImageURl:(NSString *)imageUrl signNum:(NSString *)signNum title:(NSString *)title skimNum:(NSString *)skimNum uint_price:(NSString *)price
{
    
    [self.TopimgView setImageAsyncWithURL:imageUrl placeholderImage:DefaultImage_logo];
    
    if (price == nil||[price isEqualToString:@""]||[price isEqualToString:@"0"]) {
        _priceLabel.text = [NSString stringWithFormat:@"免费"];
    }else {
        _priceLabel.text = [NSString stringWithFormat:@"￥%@",price];
    }
    [_priceLabel sizeToFit];
    _priceLabel.right = WindowWith - 15;
    
    _titleLabel.width = _priceLabel.left - 30;
    _titleLabel.text = title;
    [_titleLabel sizeToFit];

    _priceLabel.centerY = _titleLabel.centerY;
    
    _addressLabel.text = [NSString stringWithFormat:@"浏览 %@次",skimNum];;
    [_addressLabel sizeToFit];
    

    _timeLabel.text = [NSString stringWithFormat:@"报名 %@次",signNum];
    [_timeLabel sizeToFit];
    _timeLabel.left = _addressLabel.right + 20;
    _timeLabel.width = self.width-_addressLabel.right-25;
    
    _addressLabel.top = _titleLabel.bottom + 11;
    _timeLabel.top = _titleLabel.bottom + 11;
    
    self.ActivnameView.height = _timeLabel.bottom + 8;
    
    self.height = self.ActivnameView.height + self.TopimgView.height + 10;
    
}
@end
