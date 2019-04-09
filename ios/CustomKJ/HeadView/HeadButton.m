//
//  HeadButton.m
//  MiaoTuProject
//
//  Created by Mac on 16/3/30.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "HeadButton.h"

@implementation HeadButton
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.headBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.headBtn.frame=CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self.headBtn setBackgroundImage:defalutHeadImage forState:UIControlStateNormal];
        [self.headBtn setLayerMasksCornerRadius:frame.size.width/2 BorderWidth:0 borderColor:[UIColor clearColor]];
        [self addSubview:self.headBtn];
        
        UIImage *img=Image(@"mangeruser.png");
        UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width-img.size.width, frame.size.height-img.size.height, img.size.width, img.size.height)];
        _imgView=imgView;
        imgView.image=img;
        //[self addSubview:imgView];
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headTap:)];
        [imgView addGestureRecognizer:tap];
        
    }
    return self;
}

-(void)setHeadImageUrl:(NSString *)url type:(int)type{
    
    UIImage *idImg;
    if (type==1) {
        idImg=Image(@"");
    }else if (type==2){
        idImg=Image(@"reguser.png");
    }else if (type==3){
        idImg=Image(@"vipuser.png");
    }else if (type==4){
        idImg=Image(@"mangeruser.png");
    }else if (type==5){
        idImg=Image(@"hezuohuoban.png");
    }else if (type==6){
        idImg=Image(@"gloduser.png");
    }
    _imgView.image=idImg;
    [self.headBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,smallHeaderImage]] forState:UIControlStateNormal placeholderImage:defalutHeadImage];
}

-(void)headTap:(UITapGestureRecognizer *)tap
{
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
