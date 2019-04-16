//
//  CommentView.m
//  MiaoTuProject
//
//  Created by Mac on 16/4/15.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "CommentView.h"

#pragma mark 评论

@implementation CommentView

-(void)setViewHere{
    
    UIImage *timeImg=Image(@"fav_time.png");
    UIImageView *timeImageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, (self.height - timeImg.size.height)/2.0, timeImg.size.width, timeImg.size.height)];
    timeImageView.image=timeImg;
//    _timeImage=timeImageView;
    [self addSubview:timeImageView];
    
    SMLabel *timeLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(timeImageView.right+5, timeImageView.top, WindowWith/4 * 2 - timeImageView.right-5, 15) textColor:cGrayLightColor textFont:sysFont(12)];
    
    _timelbl=timeLbl;
    [self addSubview:timeLbl];
    
    NSArray *imgArr=@[@"comment.png",
                      @"agree.png"];
    
    NSArray * selArr=@[@"comment.png",
                       @"agree_select.png"];
    
    NSArray * textArr=@[@"评论",@"45"];
    
    for (NSInteger i=3; i>1; i--) {
        UIImage *img=Image(imgArr[i-2]);
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag=1000+i;
        btn.enabled=YES;
        btn.frame=CGRectMake(i*WindowWith/4, 1, WindowWith/4, self.height-1-5);
        [self addSubview:btn];
        
        UIImage *selImg=Image(selArr[i-2]);
        
        [btn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
        [btn setImage:[selImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateSelected];
        [btn setTitle:textArr[i-2] forState:UIControlStateNormal];
        [btn setTitleColor:RGBA(108, 123, 138, 1) forState:UIControlStateNormal];
        btn.titleLabel.font=sysFont(14);
        btn.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
        
        UIView *lineV =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 18)];
        lineV.backgroundColor = RGBA(108, 123, 138, 0.5);
        [self addSubview:lineV];
        if (btn.tag==1000) {
            [btn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
        }else if (btn.tag==1001)
        {
            _likeBtn=btn;
            [btn addTarget:self action:@selector(Favorite:) forControlEvents:UIControlEventTouchUpInside];
        }else if (btn.tag==1002)
        {
            _commentBtn=btn;
            [btn addTarget:self action:@selector(comment:) forControlEvents:UIControlEventTouchUpInside];
        }else if(btn.tag==1003){
            _zanBtn=btn;
            [btn addTarget:self action:@selector(agree:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        
        if (i==3) {
            UIView *lineview=[[UIView alloc]initWithFrame:CGRectMake(WindowWith/4*i, 1+8, 0.5, 32-16)];
            lineview.backgroundColor=cLineColor;
            
            [self addSubview:lineview];
        }
        
        
        
        
    }
    
}


-(void)setViewMe{
    
    NSArray *imgArr=@[@"share.png",
                       @"comment.png",
                      @"edit2.png",
                      @"delete1.png"];
    NSArray * selArr=@[@"share_select.png",
                        @"comment.png",
                       @"edit2.png",
                       @"delete1.png"];
    
    NSArray * textArr=@[@"分享",@"评论",@"编辑",@"删除"];
    
    
    
    for (NSInteger i=0; i<4; i++) {
        UIImage *img=Image(imgArr[i]);
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag=1000+i;
        btn.enabled=YES;
        btn.frame=CGRectMake(i*WindowWith/4, 1, WindowWith/4, self.height-1-5);
        [self addSubview:btn];
        
        UIImage *selImg=Image(selArr[i]);
        
        [btn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
        [btn setImage:[selImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateSelected];
        [btn setTitle:textArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:RGBA(108, 123, 138, 1) forState:UIControlStateNormal];
        btn.titleLabel.font=sysFont(14);
        btn.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
        
        [btn addTarget:self action:@selector(MeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        if (i>0) {
            UIView *lineview=[[UIView alloc]initWithFrame:CGRectMake(WindowWith/4*i, 1+8, 0.5, 32-16)];
            lineview.backgroundColor=cLineColor;
            
            [self addSubview:lineview];
        }
        
    }
}

- (instancetype)initWithTopicBottomFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 1)];
        [self addSubview:lineView];
        lineView.backgroundColor=cBgColor;
        ;
        
        NSArray *imgArr=@[@"share.png",
                          @"comment.png",
                          
                          @"delete1.png"];
        NSArray * selArr=@[@"share_select.png",
                           @"comment.png",
                           
                           @"delete1.png"];
        
        NSArray * textArr=@[@"分享",@"评论",@"删除"];
        
        
        
        for (NSInteger i=0; i<3; i++) {
            UIImage *img=Image(imgArr[i]);
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag=2000+i;
            btn.enabled=YES;
            btn.frame=CGRectMake(i*WindowWith/3, 1, WindowWith/3, self.height-1-5);
            [self addSubview:btn];
            
            UIImage *selImg=Image(selArr[i]);
            
            [btn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
            [btn setImage:[selImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateSelected];
            [btn setTitle:textArr[i] forState:UIControlStateNormal];
            [btn setTitleColor:RGBA(108, 123, 138, 1) forState:UIControlStateNormal];
            btn.titleLabel.font=sysFont(14);
            btn.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
            
            [btn addTarget:self action:@selector(MeClick:) forControlEvents:UIControlEventTouchUpInside];
            
            
            if (i>0) {
                UIView *lineview=[[UIView alloc]initWithFrame:CGRectMake(WindowWith/3*i, 1+8, 0.5, 32-16)];
                lineview.backgroundColor=cLineColor;
                
                [self addSubview:lineview];
            }
            
        }

        
        
        
        
        
        UIView *lineView2=[[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height-4, WindowWith, 4)];
        lineView2.backgroundColor=cBgColor;
        [self addSubview:lineView2];
        
        
    }

    
    
    return self;
}




- (instancetype)initWithFrame:(CGRect)frame isMe:(BOOL)isMe{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 1)];
        [self addSubview:lineView];
        lineView.backgroundColor=cBgColor;
        ;
        if (!isMe) {
            [self setViewHere];
        }else{
            [self setViewMe];
        }
        
        
        UIView *lineView2=[[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height-4, WindowWith, 4)];
        lineView2.backgroundColor=cBgColor;
        [self addSubview:lineView2];
        
        
    }
    
    return self;
}










-(void)setData:(MTSupplyAndBuyListModel *)mod{
    if (mod.hasClickLike) {
        _zanBtn.selected=YES;
    }else{
        _zanBtn.selected=NO;
    }
    
    if (mod.hasCollection) {
        _likeBtn.selected=YES;
    }else{
        _likeBtn.selected=NO;
    }
    [_commentBtn setTitle:stringFormatInt(mod.commentTotal) forState:UIControlStateNormal];
    [_likeBtn setTitle:stringFormatInt(mod.collectionTotal) forState:UIControlStateNormal];
    [_zanBtn setTitle:stringFormatInt(mod.clickLikeTotal) forState:UIControlStateNormal];
    
    _timelbl.text= [IHUtility compareCurrentTimeString:mod.uploadtime] ;
}

-(void)share:(UIButton *)sender
{
    
    self.selectBlock(MTShareActionTableViewCell);
}

-(void)comment:(UIButton *)sender
{
    self.selectBlock(MTCommentActionTableViewCell);
    
}
-(void)agree:(UIButton *)sender
{
    if (sender.selected) {
        self.selectBlock(MTcancelAgreeActionTableViewCell);
        
    }else{
        self.selectBlock(MTAgreeActionTableViewCell);
    }
    
    
}
-(void)Favorite:(UIButton *)sender
{
    self.selectBlock(MTFavriteActionTableViewCell);
    
    
}


-(void)MeClick:(UIButton *)sender{
    if (sender.tag==1000) {  //分享
         self.selectBlock(MTShareActionTableViewCell);
    }else if (sender.tag==1001){ //评论
        self.selectBlock(MTCommentActionTableViewCell);
    }else if (sender.tag==1002){ //编辑
        self.selectBlock(MTEditActionTableViewCell);
    }else if (sender.tag==1003){//删除
        self.selectBlock(MTDeleteActionTableViewCell);
    }
    
    
    if (sender.tag==2000) {  //分享
        self.selectBlock(MTShareActionTableViewCell);
    }else if (sender.tag==2001){ //评论
        self.selectBlock(MTCommentActionTableViewCell);
    }else if (sender.tag==2002){//删除
        self.selectBlock(MTDeleteActionTableViewCell);
    }

    
    
}

@end

