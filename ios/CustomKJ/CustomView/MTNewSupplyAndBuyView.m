//
//  MTNewSupplyAndBuyView.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/7/20.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTNewSupplyAndBuyView.h"
#import "CustomView+CustomCategory2.h"

@implementation MTNewSupplyAndBuyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        
        
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith-10, 5)];
        lineView.backgroundColor=cLineColor;
        [self addSubview:lineView];
        
        
        UIAsyncImageView *headImageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(0.016*WindowWith, 0.032*WindowWith+5, 0.106*WindowWith, 0.106*WindowWith)];
        
        headImageView.image=defalutHeadImage;
        [self addSubview:headImageView];
        
        
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(headImageView.right+7.5/375*WindowWith, 17.5/375*WindowWith+5, 40, 13) textColor:cGrayLightColor textFont:sysFont(12.5)];
        lbl.text=@"刘乐东";
        _nickName=lbl;
        [self addSubview:lbl];
        
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.right+12/375*WindowWith, lbl.top, WindowWith-lbl.right-50, 13) textColor:cGrayLightColor textFont:sysFont(12.5) ];
        lbl.text=@"#苗途站长";
        [self addSubview:lbl];
        
       
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(_nickName.left, lbl.bottom+5.5, WindowWith-lbl.left-50, 13) textColor:cBlackColor textFont:sysFont(12.5)];
        lbl.text=@"深圳 | 正河苗圃 总经理";
        [self addSubview:lbl];
        
        
        UIImage *Img=Image(@"GongQiu_gongying.png");
        
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(WindowWith-Img.size.width-10, 20.9/375*WindowWith+5, Img.size.width, Img.size.height)];
        
        imageView.image=Img;
        [self addSubview:imageView];
        
        
        
        SDPhotosGroupView *imagesView=[[SDPhotosGroupView alloc]initWithFrame:CGRectMake(headImageView.left, headImageView.bottom+0.042*WindowWith, WindowWith-headImageView.left*2, 111) withTableViewCell:YES];
        [self addSubview:imagesView];
        
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(headImageView.left, imagesView.bottom+0.08*WindowWith, imagesView.width, 15) textColor:cBlackColor textFont:sysFont(15)];
        lbl.text=@"中国红樱花";
        [self addSubview:lbl];
        
       
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imagesView.right-80 , lbl.top, 60, 18) textColor:cGreenColor textFont:sysFont(18)];
        lbl.text=@"￥ 320";
       
        [self addSubview:lbl];
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(headImageView.left , lbl.bottom+7.5, WindowWith-headImageView.left-10, 13.5) textColor:cGrayLightColor textFont:sysFont(13.5)];
        lbl.text=@"#杆径30cm   #冠幅25-35cm  #高度30cm  #分枝点2...";
        lbl.numberOfLines=0;
        [self addSubview:lbl];
        
        
        
        lineView=[[UIView alloc]initWithFrame:CGRectMake(0, lbl.bottom+11, WindowWith-10, 1)];
        lineView.backgroundColor=cLineColor;
        [self addSubview:lineView];
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(headImageView.left , lineView.bottom+7, 60, 13) textColor:cGrayLightColor textFont:sysFont(12.5)];
        lbl.text=@"7月20日";
        
        [self addSubview:lbl];
        
        
        Img=Image(@"Btn_pinglun.png");
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        _btn=btn;
        btn.frame=CGRectMake(imagesView.right-Img.size.width-10, lbl.top, Img.size.width, Img.size.height);
        [btn setImage:[Img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnclike) forControlEvents:UIControlEventTouchUpInside];
        
        CommentAndLikeView *commentAndLikeView=[[CommentAndLikeView alloc]initWithFrame:CGRectMake(btn.left-5, btn.top+10, 180, 35)];
        _commentAndLikeView=commentAndLikeView;
        commentAndLikeView.selectBtnBlock=^(NSInteger index){
            
            if (index==agreeBlock) {
                NSLog(@"agree");
            }else if (index==commentBlock){
                NSLog(@"comment");
                
            }
            [UIView animateWithDuration:0.2 animations:^{
                self->_commentAndLikeView.width=0;
                 self->_commentAndLikeView.origin=CGPointMake(btn.left-5, btn.top);
            }];
        };
        commentAndLikeView.width=0;
        [self addSubview:commentAndLikeView];
        [self addSubview:btn];
        
        
        

    }

    return self;
}

-(void)btnclike{
    [UIView animateWithDuration:0.2 animations:^{
        self->_commentAndLikeView.width=180;
        self->_commentAndLikeView.origin=CGPointMake(self->_btn.left-185, self->_btn.top);
    }];
}


@end
