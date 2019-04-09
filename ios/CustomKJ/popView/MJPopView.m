//
//  MJPopView.m
//  MoJieProject
//
//  Created by Zmh on 4/4/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MJPopView.h"

@implementation MJPopView

-(id)initWithOrgin:(CGFloat)y x:(CGFloat)x arr:(NSArray *)arr i:(int)i img:(UIImage *)img{
    
    self = [super init];
    if (self!= nil) {
        
        UIWindow * window = [UIApplication sharedApplication].keyWindow;
        
        UIButton* bgView = [UIButton buttonWithType:UIButtonTypeCustom];
        bgView.tag=22;
        [bgView addTarget:self action:@selector(hiddenView) forControlEvents:UIControlEventTouchUpInside];
        bgView.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        bgView.backgroundColor = [UIColor clearColor];
        
       
        img=[img stretchableImageWithLeftCapWidth:img.size.width/2 topCapHeight:img.size.height/2];
        UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(x, y+6, 100, 44*i+6)];
        imgView.image=img;
        imgView.tintColor=cGreenColor;
        imgView.userInteractionEnabled=YES;
        if (i==0) {
            imgView.hidden=YES;
        }
        [bgView addSubview:imgView];
        
      
        
        for (int i=0; i<arr.count; i++) {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            btn.frame=CGRectMake(0, 5+i*44, imgView.width, 44);
            [btn setTitle:[arr objectAtIndex:i] forState:UIControlStateNormal];
            btn.titleLabel.font=sysFont(15);
            btn.tag=i;
            
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [imgView addSubview:btn];
         
            
            UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(3, btn.bottom, imgView.width-6, 0.5)];
            lineView.backgroundColor=RGBA(255, 255, 255, 0.7);
            [imgView addSubview:lineView];
            
        }
        
        
       
        
        
        
        
        [window addSubview:bgView];
        bgView.alpha=0;
        [UIView animateWithDuration:0.2 animations:^{
            bgView.alpha=1;
        }];
        
        
        
    }
    return self;
}

-(void)btnClick:(UIButton *)sender{
   
    
    [self hiddenView];
    self.selectBlock(sender.tag);
    
}

-(void)hiddenView{
     UIWindow * window = [UIApplication sharedApplication].keyWindow;
    
    UIView *v=[window viewWithTag:22];
    v.alpha=1;
    [UIView animateWithDuration:0.2 animations:^{
        v.alpha=0;
    } completion:^(BOOL finished) {
        [v removeFromSuperview];
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/




@end
