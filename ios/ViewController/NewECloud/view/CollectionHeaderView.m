//
//  CollectionHeaderView.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/11/15.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "CollectionHeaderView.h"

@implementation CollectionHeaderView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(22, 18, 19, 19)];
        imageView.image=Image(@"EP_partner.png");
        _imageView=imageView;
        [self addSubview:imageView];
        
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+10, 0, 100, self.height) textColor:cBlackColor textFont:sysFont(14)];
        lbl.text=@"战略合作企业";
        _lbl=lbl;
        [self addSubview:lbl];
        
        _imageView.centerY=lbl.centerY;
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(self.width-19-54, 5, 54, self.height);
        [btn setTitle:@"查看更多" forState:UIControlStateNormal];
        [btn setTitleColor:cGreenColor forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(dianji) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font=sysFont(12);
        btn.centerY=lbl.centerY;
        [self addSubview:btn];
        
    }
    return self;
}

-(void)dianji{
    self.selectBtnBlock(SelectBtnBlock);
}

-(void)setDataWith:(NSString *)img title:(NSString *)title{
    
    _imageView.image=Image(img);
    _lbl.text=title;
    
}

@end
