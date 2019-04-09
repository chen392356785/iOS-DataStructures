//
//  orderStateView.m
//  MiaoTuProject
//
//  Created by Zmh on 11/5/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "orderStateView.h"

@implementation orderStateView

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
        
        UIAsyncImageView *titleImage = [[UIAsyncImageView alloc] initWithFrame:CGRectMake(12, 0, 87, 85)];
        titleImage.centerY = self.height/2.0;
        _titleImage = titleImage;
        [self addSubview:titleImage];
        
        SMLabel *titleLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(titleImage.right + 10, 20, self.width - titleImage.right - 15, 18) textColor:cBlackColor textFont:sysFont(15)];
        _titleLbl = titleLbl;
        [self addSubview:titleLbl];

        SMLabel *timeLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(titleLbl.left, titleLbl.bottom + 11, titleLbl.width, 15) textColor:cBlackColor textFont:sysFont(12)];
        _timeLbl = timeLbl;
        [self addSubview:timeLbl];
        
        SMLabel *adressLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(timeLbl.left, timeLbl.bottom + 5, 150, 15) textColor:cBlackColor textFont:sysFont(14)];
        _adressLbl = adressLbl;
        [self addSubview:adressLbl];
        
        SMLabel *priceLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(0, 0, 0, 22) textColor:RGB(252, 79, 76) textFont:sysFont(16)];
        priceLbl.bottom = self.height - 7.5;
        priceLbl.right =self.width - 10;
        _priceLbl = priceLbl;
        [self addSubview:priceLbl];
        
    }
    return self;
}

- (void)setActivtiesData:(ActivitiesListModel *)model
{
    [_titleImage setImageAsyncWithURL:model.activities_pic placeholderImage:[UIImage imageNamed:@"yaoqingimg.png"]];
    
    _titleLbl.text = [NSString stringWithFormat:@"%@",model.activities_titile];
    
    _timeLbl.text = [NSString stringWithFormat:@"%@",model.activities_starttime];
    
    _adressLbl.text = [NSString stringWithFormat:@"%@",model.activities_address];
    if (model.payment_amount == nil||[model.payment_amount isEqualToString:@""]||[model.payment_amount isEqualToString:@"0"]) {
        _priceLbl.text = [NSString stringWithFormat:@"免费"];
    }else {
        _priceLbl.text = [NSString stringWithFormat:@"￥%.2f",[model.payment_amount floatValue]/100];
    }
    [_priceLbl sizeToFit];
    _priceLbl.height = 22;
    _priceLbl.right =self.width - 10;
    _adressLbl.width = self.width - _priceLbl.width - _titleImage.right - 25;
    
}
@end
