//
//  NavSlideView.m
//  MiaoTuProject
//
//  Created by Mac on 16/3/22.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "NavSlideView.h"

#define btnTag  100



@implementation NavSlideView

- (id)initWithFrame:(CGRect)frame setTitleArr:(NSArray *)titleArray isPoint:(BOOL)isPoint integer:(NSInteger)integer
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.navSlideWidth=frame.size.width;
        self.Count=titleArray.count;
        CGFloat width=frame.size.width/titleArray.count;
        
        CGFloat x=width/2-44;
        UIView *selView=[[UIView alloc]initWithFrame:CGRectMake(x, frame.size.height/2-25/2, 88, 25)];
        _selView=selView;
       // selView.backgroundColor=[UIColor clearColor];
        //[selView setLayerMasksCornerRadius:13 BorderWidth:1 borderColor:cBlackColor];
        [self addSubview:selView];
        _arr=titleArray;
        for (int i=0; i<titleArray.count; i++) {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(width*i, 0, width, frame.size.height);
            btn.tag=btnTag+i;
            CGSize size=[IHUtility GetSizeByText:titleArray[i] sizeOfFont:16 width:200];
            UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height-1, size.width, 1)];
            lineView.backgroundColor=cGreenColor;
            lineView.tag=1000+i;
            lineView.hidden=YES;
           // [btn addSubview:lineView];
            if (i==0) {
                btn.selected=YES;
                _selButton=btn;
                lineView.hidden=NO;
                
            }
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:titleArray[i] forState:UIControlStateNormal];
            [btn setTitleColor:cGreenColor forState:UIControlStateSelected];
            [btn setTitleColor:cGrayLightColor forState:UIControlStateNormal];
            btn.titleLabel.font=sysFont(16);
            [self addSubview:btn];
            
            if (isPoint) {
                if (i==integer) {
                    UIImage *img=Image(@"redpoint.png");
                    UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(btn.right-28, btn.top+9, img.size.width, img.size.height)];
                    imgView.image=img;
                   
                    _redImageView=imgView;
                     _redImageView.hidden=YES;
                    [self addSubview:imgView];
                }
                
            }
            
            
        }
 
        
        
    }
    return self;
}


-(void)setPointNum:(int)num{
    if (num>0) {
        _redImageView.hidden=NO;
    }else{
        _redImageView.hidden=YES;
    }
}

-(void)btnClick:(UIButton *)sender{
    [self selectButton:sender];
    self.selectBlock(self.currIndex);
}

- (void)selectButton:(UIButton *)button{
    
    if (button == _selButton) {
        return;
    }
    self.currIndex=button.tag-btnTag;
    
    CGRect rect=button.frame;
    
    CGFloat x=rect.origin.x+(rect.size.width)/2-44;
    
    for (NSInteger i=0; i<_arr.count; i++) {
        UIView *lineView=[self viewWithTag:1000+i];
        lineView.hidden=YES;
        
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect1=self->_selView.frame;
        rect1.origin.x=x;
        self->_selView.frame=rect1;
        UIView *lineView=[self viewWithTag:1000+btnTag-100];
        lineView.hidden=NO;
        
    }];
    
    button.selected=YES;
    _selButton.selected=NO;
    _selButton=button;
}

-(void)slideScroll:(CGFloat) x{
    
    
    CGFloat x2=self.navSlideWidth/self.Count;//self.Count;
    x2=x2/WindowWith;
    CGFloat x3=x2*x;
    UIButton *sender=[self viewWithTag:btnTag+self.currIndex];
    CGRect rect=sender.frame;
    CGFloat x1=rect.origin.x+x3;
    
    NSLog(@"x3==%f",x1);
    
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect=self->_selView.frame;
        rect.origin.x=x1;
        self->_selView.frame=rect;
    }];
    
}

-(void)slideSelectedIndex:(NSInteger)index{
    self.currIndex=index;
    UIButton *btn=[self viewWithTag:index+btnTag];
    [self selectButton:btn];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
