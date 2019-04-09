//
//  CustomView+category5.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 17/1/10.
//  Copyright © 2017年 xubin. All rights reserved.
//

#import "CustomView+category5.h"

@implementation CustomView (category5)

@end


@implementation HuoWuTypeView
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        NSArray *arr=@[@"高大乔木",@"小乔木/灌木/竹类",@"球体/色块",@"草皮/草花/水生植物",@"造型植物/古桩/盆景",@"种子/种球/种苗",@"其他",@"高大乔木",@"小乔木/灌木/竹类",@"球体/色块",@"草皮/草花/水生植物",@"造型植物/古桩/盆景",@"种子/种球/种苗",@"其他"];
        
         CGFloat lastBtnRight=22;
        CGFloat lastBtnTop=15;
        for (NSInteger i=0; i<arr.count; i++) {
         
             CGSize size=[IHUtility GetSizeByText:arr[i] sizeOfFont:13 width:200];
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            UIImage *img=Image(@"logistics_gou.png");
            btn.frame=CGRectMake(lastBtnRight+size.width+4+img.size.width, lastBtnTop, size.width+4+img.size.width, img.size.height);
            if (btn.right>self.width-22) {
                
            btn.frame=CGRectMake(22, lastBtnTop, size.width+4+img.size.width, img.size.height);
                
                
            }
            
            lastBtnTop=btn.top;
            lastBtnRight=btn.right;
            [btn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
            [btn setTitle:arr[i] forState:UIControlStateNormal];
            [btn setTitleColor:cBlackColor forState:UIControlStateNormal];
            btn.titleEdgeInsets=UIEdgeInsetsMake(0, 4, 0, 0);
            btn.titleLabel.font=sysFont(13);
            [self addSubview:btn];
            btn.tag=1000+i;
            btn.hidden=YES;
            
        }
        
        
    }
    
    
    return self;
}


-(CGFloat)setDataWith:(NSArray *)arr{
    
    _arr=arr;
    CGFloat lastBtnRight=22;
    CGFloat lastBtnTop=15;
    for (NSInteger i=0; i<arr.count; i++) {
        
        CGSize size=[IHUtility GetSizeByText:arr[i] sizeOfFont:13 width:200];
        UIButton *btn=[self viewWithTag:1000+i];
        UIImage *img=Image(@"logistics_gou.png");
        btn.frame=CGRectMake(lastBtnRight, lastBtnTop, size.width+4+img.size.width, img.size.height);
        if (btn.right>self.width-12) {
            
            btn.frame=CGRectMake(22, lastBtnTop+img.size.height+20, size.width+4+img.size.width, img.size.height);
            
            
        }
        [btn addTarget:self action:@selector(Cliker:) forControlEvents:UIControlEventTouchUpInside];
        lastBtnTop=btn.top;
        lastBtnRight=btn.right+30;
        [btn setTitle:arr[i] forState:UIControlStateNormal];
         btn.hidden=NO;
        
    }

    for (NSInteger i=arr.count; i<14; i++) {
          UIButton *btn=[self viewWithTag:1000+i];
        btn.hidden=YES;
    }
    
     UIButton *btn=[self viewWithTag:1000+arr.count-1];
    
    return btn.bottom+19;
    
    
}
-(void)Cliker:(UIButton *)sender{
    UIImage *img=Image(@"logistics_gou.png");
    UIImage * selectImg=Image(@"logistics_gouSelect.png");
     for (NSInteger i=0; i<_arr.count; i++) {
         
         UIButton *btn=[self viewWithTag:1000+i];
          [btn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
     }
     [sender setImage:[selectImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    //[self removeFromSuperview];
    self.selectBtn(sender.titleLabel.text);
    
}

@end
