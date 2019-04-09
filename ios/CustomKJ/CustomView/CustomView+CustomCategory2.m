//
//  CustomView+CustomCategory2.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/5/30.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "CustomView+CustomCategory2.h"

@implementation CustomView (CustomCategory2)

@end


@implementation LogisticsHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        
        
       UIImage *img=Image(@"headimage");
        HeadButton *headImageView=[[HeadButton alloc]initWithFrame:CGRectMake(15, 12, img.size.width/2, img.size.height/2)];
        
        [headImageView.headBtn addTarget:self action:@selector(headTap:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:headImageView];
        
        
        SMLabel *nickNameLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(headImageView.right+8, headImageView.top+2, WindowWith, 22) textColor:RGBA(123, 126, 129, 1) textFont:sysFont(17)];
        nickNameLbl.text=@"裴小欢";
        
        [self addSubview:nickNameLbl];
        
        //判断性别
        UIImage *sexImg=Image(@"girl.png");
        UIImageView *sexImageView=[[UIImageView alloc]initWithFrame:CGRectMake(nickNameLbl.right+5, nickNameLbl.top+3, sexImg.size.width, sexImg.size.height)];
        
        sexImageView.image=sexImg;
        [self addSubview:sexImageView];
        
        
        CGSize adressSize=[IHUtility GetSizeByText:@"物流运输 | 浏阳大湘货运" sizeOfFont:12 width:200];
        SMLabel *adressLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(nickNameLbl.left, nickNameLbl.bottom+5, adressSize.width, adressSize.height) textColor:cGrayLightColor textFont:sysFont(12)];
        adressLbl.text=@"物流运输 | 浏阳大湘货运";
        
        [self addSubview:adressLbl];
        
        
        UIImage *toImg=Image(@"MT_to.png");
        UIImageView *toImageView=[[UIImageView alloc]initWithImage:toImg];
        toImageView.frame=CGRectMake(WindowWith*0.93, sexImageView.top+10, toImg.size.width, toImg.size.height);
        [self addSubview:toImageView];
        
        
        
        img=Image(@"recidt.png");
      UIImageView  *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(toImageView.left-img.size.width-20, sexImageView.top, img.size.width, img.size.height)];;
        imageView.image=img;
        [self addSubview:imageView];
        
       SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, imageView.bottom+5, 36, 10) textColor:RGB(181, 230, 228) textFont:sysFont(10)];
        lbl.text=@"已认证";
        lbl.textAlignment=NSTextAlignmentCenter;
        lbl.centerX=imageView.centerX;
        [self addSubview:lbl];
        
        
    }
    
    return self;
}
-(void)headTap:(UIButton *)sender
{
    self.selectBtnBlock(SelectheadImageBlock);
}

@end



@implementation LogisticsAdressView
- (instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        
        
        UIImage *img=Image(@"logistics_start.png");
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0.125*WindowWith, 10, img.size.width, img.size.height)];
        imageView.image=img;
        [self addSubview:imageView];
        
        
        
        CGSize size=[IHUtility GetSizeByText:@"湖南省" sizeOfFont:20 width:150];
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+5, imageView.top-3, size.width, size.height) textColor:RGB(126, 211, 33) textFont:sysFont(20)];
        lbl.text=@"湖南省";
        [self addSubview:lbl];
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.left, imageView.bottom+10, 90, 15) textColor:cBlackColor textFont:sysFont(15)];
        lbl.text=@"长沙天心区";
        [self addSubview:lbl];
        
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, 64)];
        lineView.backgroundColor=cLineColor;
        lineView.centerX=self.centerX;
        [self addSubview:lineView];
        
        img=Image(@"go.png");
        imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, img.size.width, img.size.height)];;
        imageView.image=img;
        imageView.centerX=self.centerX;
        imageView.centerY=lineView.centerY;
        [self addSubview:imageView];
        
        
        img=Image(@"logistics_end.png");
        imageView=[[UIImageView alloc]initWithFrame:CGRectMake(imageView.right+0.125*WindowWith, 10, img.size.width, img.size.height)];
        imageView.image=img;
        [self addSubview:imageView];
        
        
        
        size=[IHUtility GetSizeByText:@"北京" sizeOfFont:20 width:150];
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+5, imageView.top-3, size.width, size.height) textColor:RGB(245, 166, 35) textFont:sysFont(20)];
        lbl.text=@"北京";
        [self addSubview:lbl];
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.left, imageView.bottom+10, 90, 15) textColor:cBlackColor textFont:sysFont(15)];
        lbl.text=@"北京市朝阳区";
        [self addSubview:lbl];
        
        
        
        lineView=[[UIView alloc]initWithFrame:CGRectMake(0, lineView.bottom, WindowWith, 1)];
        lineView.backgroundColor=cLineColor;
        
        [self addSubview:lineView];
        
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(15, lineView.bottom+15, 64, 12) textColor:RGB(0, 159, 232) textFont:sysFont(12)];
        lbl.text=@"可装车时间";
        [self addSubview:lbl];
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.right+7, lbl.top-3, 100, 15) textColor:cBlackColor textFont:sysFont(15)];
        lbl.text=@"6月29日";
        [self addSubview:lbl];
        
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.left, lineView.bottom+15, 52, 12) textColor:RGB(0, 159, 232) textFont:sysFont(12)];
        lbl.text=@"结算方式";
        [self addSubview:lbl];
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.right+7, lbl.top-3, 100, 15) textColor:cBlackColor textFont:sysFont(15)];
        lbl.text=@"面议";
        [self addSubview:lbl];
        
        
        lineView=[[UIView alloc]initWithFrame:CGRectMake(0, lbl.bottom+10, WindowWith, 3)];
        lineView.backgroundColor=cLineColor;
        
        [self addSubview:lineView];
        
        
        
        
    }
    
    return self;
}


@end


@implementation MTBottomView
- (instancetype)initWithImgArr:(NSArray *)ImgArr TitleArr:(NSArray *)titleArr
{  self=[super initWithFrame:CGRectMake(0, WindowHeight-42, WindowWith, 42)];
    if (self) {
        for (NSInteger i=0; i<ImgArr.count; i++) {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(WindowWith/ImgArr.count*i, 0, WindowWith/ImgArr.count, 42);
            [btn setImage:[Image(ImgArr[i]) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
            [btn setTitle:titleArr[i] forState:UIControlStateNormal];
            [btn setTitleColor:cBlackColor forState:UIControlStateNormal];
            btn.backgroundColor=[UIColor whiteColor];
            btn.titleLabel.font=sysFont(15);
            if (i==2) {
                btn.backgroundColor=RGB(232, 121, 117);
                 [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
            btn.tag=1000+i;
            btn.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
            [self addSubview:btn];
            [btn addTarget:self action:@selector(btnTap:) forControlEvents:UIControlEventTouchUpInside];
            
            UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(btn.right, 8, 1, self.height-16)];
            lineView.backgroundColor=cLineColor;
            [self addSubview:lineView];
        }
        
        
        
    }
    return self;
}

-(void)btnTap:(UIButton *)sender
{
    
}


@end



@implementation BQView

-(id)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self!=nil) {
          NSArray *arr=@[@"zz.png",@"znhz.png",@"hy.png",@"jzz.png"];
        
        for (int i=0; i<arr.count; i++) {
         UIImage *img=Image(arr[i]);
            
           UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(lastImg.right+5, 0, img.size.width, img.size.height)];
            imageview.tag=2000+i;
            lastImg=imageview;
            imageview.image=img;
            imageview.hidden=YES;
            [self addSubview:imageview];
        }
        
    }
    return self;
}

-(void)setData:(NSArray *)arr{
    for (int i=0; i<arr.count; i++) {
        UIImageView *imageView=[self viewWithTag:2000+i];
        imageView.hidden=NO;
        imageView.image=Image(arr[i]);
              if (i==0) {
                  imageView.frame=CGRectMake(0, 0, Image(arr[i]).size.width, Image(arr[i]).size.height);
        }else{
            
              imageView.frame=CGRectMake(lastImg.right+5, 0, Image(arr[i]).size.width, Image(arr[i]).size.height);
        }
        
        lastImg=imageView;
    }
    
    int count=(int)arr.count;
    for (int i=2000+count; i<2004; i++) {
        UIImageView *imgView=(UIImageView *)[self viewWithTag:i];
        imgView.hidden=YES;
    }
}

@end

 
@implementation blankView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = cBgColor;
        
        UIImage *img = Image(@"kongbai.png");
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(70, 0, img.size.width, img.size.height)];
        imageView.centerY = self.centerY;
        imageView.image = img;
        
        [self addSubview:imageView];
        
        SMLabel *label = [[SMLabel alloc] initWithFrameWith:CGRectMake(imageView.right + 13, imageView.top, 158, img.size.height) textColor:cBlackColor textFont:sysFont(15)];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        self.label = label;
        [self addSubview:label];
        
    }
    
    return self;
}

- (void)setLableText:(NSString *)text{
    
    self.label.text = text;
}
@end




@implementation NavigiSliderView

- (id)initWithFrame:(CGRect)frame setTitleArr:(NSArray *)titleArray isPoint:(BOOL)isPoint
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
        selView.backgroundColor=[UIColor clearColor];
      //  [selView setLayerMasksCornerRadius:13 BorderWidth:1 borderColor:cBlackColor];
        [self addSubview:selView];
        
        for (int i=0; i<titleArray.count; i++) {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(width*i, 0, width, frame.size.height);
            btn.tag=1000+i;
            if (i==0) {
                btn.selected=YES;
                _selButton=btn;
            }
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:titleArray[i] forState:UIControlStateNormal];
            [btn setTitleColor:cBlackColor forState:UIControlStateSelected];
            [btn setTitleColor:cGrayLightColor forState:UIControlStateNormal];
            btn.titleLabel.font=sysFont(16);
            [self addSubview:btn];
            
                       
            
        }
        
    }
    return self;
}



-(void)btnClick:(UIButton *)sender{
    if (sender == _selButton) {
        return;
    }
    
    self.currIndex=sender.tag-1000;
    
    CGRect rect=sender.frame;
    
    CGFloat x=rect.origin.x+(rect.size.width)/2-44;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect1=self->_selView.frame;
        rect1.origin.x=x;
        self->_selView.frame=rect1;
    }];
    
    sender.selected=YES;
    _selButton.selected=NO;
    
    _selButton=sender;
    self.selectBlock(self.currIndex);
}

-(void)slideScroll:(CGFloat) x{
    
    
    CGFloat x2=self.navSlideWidth/self.Count;//self.Count;
    x2=x2/WindowWith;
    CGFloat x3=x2*x;
    UIButton *sender=[self viewWithTag:1000+self.currIndex];
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
    UIButton *btn=[self viewWithTag:index+1000];
    
    [self btnClick:btn];
}


@end

@implementation NewsBottomView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =  [UIColor whiteColor];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 0.5)];
        lineView.backgroundColor = cLineColor;
        [self addSubview:lineView];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(12, 5, self.width - 84, 30)];
        view.layer.cornerRadius = 15.0;
        view.backgroundColor = RGB(230, 233, 237);
        [self addSubview:view];
        
         IHTextField *textField = [[IHTextField alloc] initWithFrame:CGRectMake(12, 0, view.width - 24, 30)];
        textField.placeholder = @"评论一下";
        textField.font = sysFont(14);
        _textfield = textField;
        [view addSubview:textField];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(view.right + 8, view.top, 55, 30)];
        [button setTitle:@"发送" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.backgroundColor = RGB(6, 193, 174);
        button.titleLabel.font = sysFont(14);
        button.layer.cornerRadius = 15.0;
    
        _Btn = button;
        [self addSubview:button];
    }
    
    return self;
}

@end

@implementation NewsImgCommentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIImage *img = Image(@"comment_select.png");
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(8, 0, img.size.width + 38, self.height);
        btn.centerY = self.height/2.0;
        btn.backgroundColor = [UIColor clearColor];
        [btn setImage:img forState:UIControlStateNormal];
        [btn setTitle:@"163" forState:UIControlStateNormal];
        btn.titleLabel.font = sysFont(13);
        btn.titleEdgeInsets=UIEdgeInsetsMake(0, 8, 0, 0);
        [btn setTintColor:RGBA(6, 193, 174, 1)];
        [self addSubview:btn];
        
        self.commList = btn;
        
        IHTextField *textfiled = [[IHTextField alloc] initWithFrame:CGRectMake(btn.right + 12, 0, self.width - btn.right - 24, 30)];
        textfiled.font = sysFont(14);
        textfiled.textColor = RGBA(183, 186, 185, 1);
        textfiled.text = @"评论一下";
        textfiled.centerY = btn.centerY;
        textfiled.enabled = NO;
        textfiled.userInteractionEnabled = YES;
        [self addSubview:textfiled];
        
        self.commentLbl = textfiled;
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(textfiled.left, textfiled.bottom, textfiled.width, 0.5)];
        lineView.backgroundColor = RGBA(44, 44, 46, 1);
        [self addSubview:lineView];
    }
    return self;
}

- (void)setDataNum:(int)number
{
    [self.commList setTitle:stringFormatInt(number) forState:UIControlStateNormal];
}
@end

@implementation EPCloudListBottonView

- (id)initWithFrame:(CGRect)frame btnTitle:(NSArray *)titles images:(NSArray *)images
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor= [UIColor whiteColor];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 0.5)];
        lineView.backgroundColor= cLineColor;
        [self addSubview:lineView];
        
        if (titles.count == 1) {
        
            UIImage *img= Image(images[0]);
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
            btn.frame = CGRectMake(0, 0, 128, 37);
            btn.backgroundColor = RGBA(85, 201, 196, 1);
            [btn setTitle:[NSString stringWithFormat:@"%@",titles[0]] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            btn.centerX = self.width /2.0;
            btn.centerY = self.height /2.0;
            btn.layer.cornerRadius = 19.0;
            btn.titleLabel.font = sysFont(13);
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];

        }else {
        
            for (int i =0 ; i<titles.count; i++) {
                
                UIImage *img= Image(images[i]);
                UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
                if (i==0) {
                    btn.frame = CGRectMake(16, 0, 90*WindowWith/375.0, 37);
                    btn.backgroundColor = RGBA(235, 239, 242, 1);
                    [btn setTitleColor:RGBA(120, 142, 126, 1) forState:UIControlStateNormal];
                }else if (i==1){
                    btn.frame = CGRectMake(0, 0, self.width - 64 - 180*WindowWith/375.0 , 37);
                    btn.centerX = self.width /2.0;
                    btn.backgroundColor = RGBA(85, 201, 196, 1);
                    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                }else if (i==2){
                    btn.frame = CGRectMake(0, 0, 90*WindowWith/375.0, 37);
                    btn.right = self.width - 16;
                    btn.backgroundColor = RGBA(235, 239, 242, 1);
                    [btn setTitleColor:RGBA(120, 142, 126, 1) forState:UIControlStateNormal];
                }
                
                [btn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
                [btn setTitle:[NSString stringWithFormat:@"%@",titles[i]] forState:UIControlStateNormal];
                btn.titleEdgeInsets=UIEdgeInsetsMake(0, 8, 0, 0);
                btn.centerY = self.height /2.0;
                btn.tag = i + 200;
                btn.layer.cornerRadius = 19.0;
                btn.titleLabel.font = sysFont(13);
                [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:btn];
            }
        }
        
    }
    return self;
}
- (void)btnAction:(UIButton *)button
{
    self.selectBlock(button.tag);
}
@end

@implementation BtnView
- (id)initWithFrame:(CGRect)frame cornerRadius:(CGFloat)cornerRadius text:(NSString *)text image:(UIImage *)image
{
    self = [super initWithFrame:frame];
    if (self) {
        if (image) {
            self.backgroundColor=cGreenColor;
            self.layer.cornerRadius=cornerRadius;
            [self setTintColor:[UIColor whiteColor]];
            [self setTitle:text forState:UIControlStateNormal];
            [self setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
            self.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
        }else
        {
            self.backgroundColor=cGreenColor;
            self.layer.cornerRadius=cornerRadius;
            [self setTintColor:[UIColor whiteColor]];
            [self setTitle:text forState:UIControlStateNormal];
        }
        
        self.titleLabel.font=sysFont(14);
        
    
    }


    return self;
}
@end

@implementation EPCloudDetailTopView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
//        self.clipsToBounds = YES;


        UIAsyncImageView *companyImg = [[UIAsyncImageView alloc] initWithFrame:CGRectMake(0, -40, 80, 80)];
        companyImg.centerX = self.width/2.0;
        companyImg.image = EPDefaultImage_logo;
        _companyImg = companyImg;
        companyImg.layer.cornerRadius = 40;
        [self addSubview:companyImg];
        
        
        UIImage *img=Image(@"motouch.png");
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:companyImg.frame];
        imageView.image=img;
        [self addSubview:imageView];

        
        UIView *backView  = [[UIView alloc] initWithFrame:CGRectMake(0,companyImg.bottom + 18 , WindowWith, 200)];
        _backView = backView;
        backView.clipsToBounds= YES;
        [self addSubview:backView];
        
        SMLabel *companyLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(12, 0, WindowWith - 24, 17) textColor:RGBA(44, 44, 46, 1) textFont:sysFont(17)];
        _companyLbl = companyLbl;
        companyLbl.textAlignment = NSTextAlignmentCenter;
        companyLbl.text = @"深圳文科园林股份有限公司";
        [backView addSubview:companyLbl];
        
        EDStarRating *ratingImage  = [[EDStarRating alloc] initWithFrame:CGRectMake(0, companyLbl.bottom + 12, 120, 20)];
        ratingImage.centerX = self.width/2.0;
        _ratingImage = ratingImage;
        _ratingImage.starImage = [UIImage imageNamed:@"starbigwhite.png"];
        _ratingImage.starHighlightedImage = [UIImage imageNamed:@"starbiggreen.png"];
        _ratingImage.maxRating = 5.0;
        _ratingImage.rating = 3.5;
        _ratingImage.editable = NO;
        _ratingImage.horizontalMargin = 0;
        _ratingImage.displayMode = EDStarRatingDisplayHalf;
        _ratingImage.delegate = self;
        [backView addSubview:ratingImage];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCommentList)];
        tap.numberOfTapsRequired= 1;
        tap.numberOfTouchesRequired = 1;
        [ratingImage addGestureRecognizer:tap];
        
        CGSize size = [IHUtility GetSizeByText:@"408条评论" sizeOfFont:14 width:backView.width - _ratingImage.width];
        _ratingImage.left = _ratingImage.left - (size.width + 8)/2.0;
        
        SMLabel *commentNumLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(_ratingImage.right + 8, 0, size.width, 13) textColor:RGBA(135, 134, 140, 1) textFont:sysFont(14)];
        _commentNumLbl = commentNumLbl;
        commentNumLbl.centerY = _ratingImage.centerY;
        commentNumLbl.text = @"408条评论";
        commentNumLbl.userInteractionEnabled = YES;
        [backView addSubview:commentNumLbl];
        
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCommentList)];
        tap1.numberOfTapsRequired= 1;
        tap1.numberOfTouchesRequired = 1;
        [commentNumLbl addGestureRecognizer:tap1];
        
        SMLabel *companyInfo = [[SMLabel alloc] initWithFrameWith:CGRectMake(companyLbl.left, ratingImage.bottom +18, companyLbl.width, 13.5) textColor:RGBA(135, 134, 140, 1) textFont:sysFont(13)];
        companyInfo.textAlignment = NSTextAlignmentCenter;
        _companyInfo = companyInfo;
        companyInfo.text = @"景观设计 | 合资股份 | 500-999人";
        [backView addSubview:companyInfo];
        
        SMLabel *companyType = [[SMLabel alloc] initWithFrameWith:CGRectMake(companyLbl.left, companyInfo.bottom + 8, companyLbl.width, 13) textColor:RGBA(135, 134, 140, 1) textFont:sysFont(13)];
        _companyType = companyType;
        companyType.text = @"设计甲 | 城市园林绿化一级资质 | 国家城市规划园林企业";
        companyType.textAlignment= NSTextAlignmentCenter;
        [backView addSubview:companyType];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(12, companyType.bottom + 18, self.width- 24, 1)];
        lineView.backgroundColor = cLineColor;
        _lineView = lineView;
        [backView addSubview:lineView];
        
        SMLabel *companyDetail = [[SMLabel alloc] initWithFrameWith:CGRectMake(15, lineView.bottom + 12, self.width - 30, 0) textColor:RGBA(44, 44, 46, 1) textFont:sysFont(13)];
        _companyDetail = companyDetail;
        companyDetail.numberOfLines= 0;
        companyDetail.text = @"企业简介:浏阳正河苗圃基地位于浏阳市苗木产业园内，是浏阳苗木产业园最重要的组成部分之一，曾获园林行业奥斯卡之称的金钟奖，曾多次承接省级森林公园的设计工程，多次获得业内好评。";
        
        NSMutableAttributedString *str = [IHUtility changePartTextColor:companyDetail.text range:NSMakeRange(0, 5) value:RGBA(104, 124, 99, 1)];
        companyDetail.attributedText = str;
        [backView addSubview:companyDetail];
        
        SMLabel *companyBusiness = [[SMLabel alloc] initWithFrameWith:CGRectMake(15, companyDetail.bottom + 15, self.width - 30, 40) textColor:RGBA(44, 44, 46, 1) textFont:sysFont(13)];
        _companyBusiness = companyBusiness;
        companyBusiness.text = @"主营: 樱花  三角梅  金石梅  红叶石楠  大叶乔   金桢子  美国红枫";
        companyBusiness.numberOfLines= 0;
        str = [IHUtility changePartTextColor:companyBusiness.text range:NSMakeRange(0, 3) value:RGBA(104, 124, 99, 1)];
        companyBusiness.attributedText = str;
        [backView addSubview:companyBusiness];
        
        SMLabel *lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(15, companyBusiness.bottom + 15, self.width - 30, 25) textColor:RGBA(44, 44, 46, 1) textFont:sysFont(13)];
        lbl.text = @"地址: 广东省深圳阳柏加镇柏南黑路138号";
        _adressLbl = lbl;
        str = [IHUtility changePartTextColor:lbl.text range:NSMakeRange(0, 3) value:RGBA(104, 124, 99, 1)];
        lbl.attributedText = str;
        [backView addSubview:lbl];
        
        lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(15, lbl.bottom, self.width - 30, 25) textColor:cGreenLightColor textFont:sysFont(13)];
        lbl.text = @"网址: www.wenkegrad.com";
        _urlLbl= lbl;
        _urlLbl.userInteractionEnabled = YES;
        str = [IHUtility changePartTextColor:lbl.text range:NSMakeRange(0, 3) value:RGBA(104, 124, 99, 1)];
        lbl.attributedText = str;
        [backView addSubview:lbl];
        
        UITapGestureRecognizer *tapLbl = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLable:)];
        tapLbl.numberOfTapsRequired = 1.0;
        tapLbl.numberOfTouchesRequired= 1.0;
        [_urlLbl addGestureRecognizer:tapLbl];
        
        lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(15, lbl.bottom, self.width - 30, 25) textColor:RGBA(44, 44, 46, 1) textFont:sysFont(13)];
        lbl.text = @"邮箱: 1123654253@qq.com";
        _emailLbl= lbl;
        str = [IHUtility changePartTextColor:lbl.text range:NSMakeRange(0, 3) value:RGBA(104, 124, 99, 1)];
        lbl.attributedText = str;
        [backView addSubview:lbl];
        
        lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(15, lbl.bottom, self.width - 30, 25) textColor:cGreenLightColor textFont:sysFont(13)];
        lbl.text = @"电话: 0741-82312314";
        _phoneLbl = lbl;
        _phoneLbl.userInteractionEnabled = YES;
        str = [IHUtility changePartTextColor:lbl.text range:NSMakeRange(0, 3) value:RGBA(104, 124, 99, 1)];
        lbl.attributedText = str;
        [backView addSubview:lbl];
        
        UITapGestureRecognizer *tapPhone = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPhone:)];
        tapPhone.numberOfTapsRequired = 1.0;
        tapPhone.numberOfTouchesRequired= 1.0;
        [_phoneLbl addGestureRecognizer:tapPhone];
        
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.height - 20, self.width, 20)];
        [btn setImage:Image(@"downarrow.png") forState:UIControlStateNormal];
        _btn = btn;
        [btn setImage:Image(@"uparrow.png") forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnAct:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        companyDetail.height = 60;
        backView.height=lineView.bottom + 60;
        self.height = backView.bottom + 20;
        btn.top = self.height- 20;
        
    }
    
    return self;
}
- (void)setDetail:(EPCloudListModel *)model
{
    

    [_companyImg setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,model.logo] placeholderImage:EPDefaultImage_logo];
    
    _ratingImage.rating = model.level;
    _commentNumLbl.text = [NSString stringWithFormat:@"%d条评论",(int)model.comment_num];
    _companyLbl.text = model.company_name;
    NSString *str;
    if (![model.i_name isEqualToString:@""]) {
        str = model.i_name;
    }
    
    if (![model.nature_name isEqualToString:@""]) {
        if (str!=nil) {
            str = [NSString stringWithFormat:@"%@ | %@",str,model.nature_name];
        }else {
            str = model.nature_name;
        }
    }
    
    if (![model.staff_size isEqualToString:@""]) {
        if (str!=nil) {
            str = [NSString stringWithFormat:@"%@ | %@",str,model.staff_size];
        }else {
            str = model.staff_size;
        }
    }
    _companyInfo.text = str;
    
    NSString *str2;
    if (![model.design_lv isEqualToString:@""]) {
        str2 = [NSString stringWithFormat:@"园林景观设计%@",model.design_lv];
    }

    if (![model.project_lv isEqualToString:@""]) {
        if (str2 != nil) {
            str2 = [NSString stringWithFormat:@"%@ | 园林绿化工程%@",str2,model.project_lv];
        }else{
            str2 = [NSString stringWithFormat:@"园林绿化工程%@",model.project_lv];
        }
        
    }
    
    
    if ([model.company_label isEqualToString:@""]) {
        _companyType.text = str2;
    }else
    {
        if (str2 != nil) {
            _companyType.text = [NSString stringWithFormat:@"%@ | %@",str2,model.company_label];
        }else{
            _companyType.text = [NSString stringWithFormat:@"%@",model.company_label];
        }
        
    }
        

    CGSize size = [IHUtility GetSizeByText:[NSString stringWithFormat:@"公司简介:%@",model.company_desc] sizeOfFont:13 width:self.width - 30];
    _companyDetail.height = size.height;
    _companyDetail.text = [NSString stringWithFormat:@"公司简介:%@",model.company_desc];
    NSMutableAttributedString * Str = [IHUtility changePartTextColor:_companyDetail.text range:NSMakeRange(0, 5) value:RGBA(104, 124, 99, 1)];
    _companyDetail.attributedText = Str;
    if ([model.company_desc isEqualToString:@""]) {
        _companyDetail.hidden = YES;
    }
    
    if (_companyDetail.hidden) {
        _companyBusiness.top = _companyDetail.top ;
    }else {
        _companyBusiness.top = _companyDetail.bottom + 15;
    }
    size = [IHUtility GetSizeByText:[NSString stringWithFormat:@"主营:%@",model.main_business] sizeOfFont:13 width:self.width - 30];
    _companyBusiness.height =  size.height;
    _companyBusiness.text = [NSString stringWithFormat:@"主营:%@",model.main_business];
    Str = [IHUtility changePartTextColor:_companyBusiness.text range:NSMakeRange(0, 3) value:RGBA(104, 124, 99, 1)];
    _companyBusiness.attributedText = Str;
    if ([model.main_business isEqualToString:@""]) {
        _companyBusiness.hidden = YES;
    }

    if (_companyBusiness.hidden) {
        _adressLbl.top = _companyBusiness.top ;
    }else {
        _adressLbl.top = _companyBusiness.bottom + 15;
    }
    _adressLbl.text = [NSString stringWithFormat:@"地址:%@",model.address];
    Str = [IHUtility changePartTextColor:_adressLbl.text range:NSMakeRange(0, 3) value:RGBA(104, 124, 99, 1)];
    _adressLbl.attributedText = Str;
    
    if ([model.address isEqualToString:@""]) {
        _adressLbl.hidden = YES;
    }
    
    if (_adressLbl.hidden) {
        _urlLbl.top = _adressLbl.top ;
    }else {
        _urlLbl.top = _adressLbl.bottom;
    }
    _urlLbl.text = [NSString stringWithFormat:@"网址:%@",model.website];
    Str = [IHUtility changePartTextColor:_urlLbl.text range:NSMakeRange(0, 3) value:RGBA(104, 124, 99, 1)];
    _urlLbl.attributedText = Str;
    
    if ([model.website isEqualToString:@""]) {
        _urlLbl.hidden = YES;
    }
    
    if (_urlLbl.hidden) {
        _emailLbl.top = _urlLbl.top ;
    }else {
        _emailLbl.top = _urlLbl.bottom;
    }
    _emailLbl.text = [NSString stringWithFormat:@"邮箱:%@",model.email];
    Str = [IHUtility changePartTextColor:_emailLbl.text range:NSMakeRange(0, 3) value:RGBA(104, 124, 99, 1)];
    _emailLbl.attributedText = Str;
    
    if ([model.email isEqualToString:@""]) {
        _emailLbl.hidden = YES;
    }
    
    if (_emailLbl.hidden) {
        _phoneLbl.top = _emailLbl.top ;
    }else {
        _phoneLbl.top = _emailLbl.bottom;
    }
    _phoneLbl.text = [NSString stringWithFormat:@"电话:%@",model.mobile];
    Str = [IHUtility changePartTextColor:_phoneLbl.text range:NSMakeRange(0, 3) value:RGBA(104, 124, 99, 1)];
    _phoneLbl.attributedText = Str;
    
    if ([model.mobile isEqualToString:@""]) {
        _phoneLbl.hidden = YES;
    }
    
}
- (void)btnAct:(UIButton *)button
{
    button.selected = !button.selected;
    
    if (button.selected) {
        if (_lineView.bottom + 60 > _phoneLbl.bottom + 18) {
            _backView.height=_lineView.bottom + 60;
        }else {
            _backView.height=_phoneLbl.bottom + 18;
        }
        
        self.height = _backView.bottom + 20;
        _btn.top = self.height- 20;
        
    }else {
        _backView.height=_lineView.bottom + 60;
        self.height = _backView.bottom + 20;
        _btn.top = self.height- 20;
    }
    
        self.selectBlock(button.tag);
}

- (void)tapCommentList
{
    self.selectBlock(commentBlock);
}
- (void)tapLable:(UITapGestureRecognizer *)tap
{
    self.selectBlock(SelectCompanyWebBlock);
}
- (void)tapPhone:(UITapGestureRecognizer *)tap
{
    self.selectBlock(SelectTelphoneBlock);
}
@end


@implementation EPCloudCumlativeListView
-(id)initWithFrame:(CGRect)frame text:(NSString *)text ifImage:(BOOL)ifImage
{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(12, 26, 60, 15) textColor:cBlackColor textFont:sysFont(14)];
        
        lbl.text=text;
        [self addSubview:lbl];
        
          UIImage *img=Image(@"GQ_Left.png");
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(WindowWith-12-img.size.width, lbl.top, img.size.width, img.size.height)];
        imageView.image=img;
        [self addSubview:imageView];
      
        if (ifImage) {
            self.headImageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(imageView.left-12-40, 13.5, 40, 40)];
            self.headImageView.layer.cornerRadius=20;
            self.headImageView.image=Image(@"EP_defaultlogo.png");
            self.headImageView.clipsToBounds=YES;
            self.headImageView.userInteractionEnabled=YES;
            [self addSubview:self.headImageView];
            
        }else
        {
            self.lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.right+12, imageView.top, WindowWith-imageView.width-12-lbl.right-12-12, 14) textColor:cGrayLightColor textFont:sysFont(14)]
            ;
            self.lbl.textAlignment=NSTextAlignmentRight;
            [self addSubview:self.lbl];
            
            
            
        }
        
        
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 1)];
        lineView.backgroundColor=cLineColor;
        [self addSubview:lineView];
        
        
    }
    
    return self;
    
}

@end


@implementation EPCloudCommentListTopView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if ( self) {
        self.backgroundColor = [UIColor whiteColor];
        UIAsyncImageView *companyImg = [[UIAsyncImageView alloc]initWithFrame:CGRectMake(12,12, 52, 52)];
        companyImg.image = EPDefaultImage_logo;
        _companyImg = companyImg;
        companyImg.layer.cornerRadius = 26;
        [self addSubview:companyImg];
        
        SMLabel *companyLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(companyImg.right + 12, companyImg.top + 8, self.width -companyImg.right - 20 , 15) textColor:RGBA(44, 44, 46, 1) textFont:sysFont(17)];
        _companyLbl = companyLbl;
        companyLbl.text = @"深圳文科园林股份有限公司";
        [self addSubview:companyLbl];
        
        SMLabel *companyInfo = [[SMLabel alloc] initWithFrameWith:CGRectMake(companyLbl.left, companyLbl.bottom + 8, companyLbl.width, 13) textColor:RGBA(135, 134, 140, 1) textFont:sysFont(13)];
        _companyInfo = companyInfo;
        companyInfo.text = @"景观设计 | 合资股份 | 500-999人";
        [self addSubview:companyInfo];
        
        
        EDStarRating *ratingImage  = [[EDStarRating alloc] initWithFrame:CGRectMake(companyInfo.left, companyInfo.bottom + 6, 110, 20)];
        _ratingImage = ratingImage;
        _ratingImage.starImage = [UIImage imageNamed:@"starbigwhite.png"];
        _ratingImage.starHighlightedImage = [UIImage imageNamed:@"starbiggreen.png"];
        _ratingImage.maxRating = 5.0;
        _ratingImage.rating = 3.5;
        _ratingImage.editable = NO;
        _ratingImage.horizontalMargin = 0;
        _ratingImage.displayMode = EDStarRatingDisplayHalf;
        _ratingImage.delegate = self;
        [self addSubview:ratingImage];
        
        SMLabel *commentNumLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(_ratingImage.right + 8, 0, 200, 13) textColor:RGBA(135, 134, 140, 1) textFont:sysFont(14)];
        _commentNumLbl = commentNumLbl;
        commentNumLbl.centerY = _ratingImage.centerY;
        commentNumLbl.text = @"408条评论";
        [self addSubview:commentNumLbl];
        
    }
    
    return  self;
}

- (void)setData:(EPCloudListModel *)model{
    
    [_companyImg setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,model.logo] placeholderImage:EPDefaultImage_logo];
    _companyLbl.text = model.company_name;
    
    NSString *str;
    if (![model.i_name isEqualToString:@""]) {
        str = model.i_name;
    }
    
    if (![model.nature_name isEqualToString:@""]) {
        if (str!=nil) {
            str = [NSString stringWithFormat:@"%@ | %@",str,model.nature_name];
        }else {
            str = model.nature_name;
        }
    }
    
    if (![model.staff_size isEqualToString:@""]) {
        if (str!=nil) {
            str = [NSString stringWithFormat:@"%@ | %@",str,model.staff_size];
        }else {
            str = model.staff_size;
        }
    }
    _companyInfo.text = str;
    _ratingImage.rating = model.level;
    
    CGSize size=[IHUtility GetSizeByText:[NSString stringWithFormat:@"%ld条评论",(long)model.comment_num] sizeOfFont:15 width:100];
    _commentNumLbl.text = [NSString stringWithFormat:@"%ld条评论",(long)model.comment_num];
    _commentNumLbl.width = size.width;

}

@end


@implementation PersonLabelView
- (id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
         CGFloat x=0;
        for (NSUInteger i=0; i<10; i++) {
           
            NSString *str=@"     ";
            CGSize size=[IHUtility GetSizeByText:str sizeOfFont:12.5 width:200];
            SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(x, 0, size.width, size.height) textColor:RGB(73, 72, 80) textFont:sysFont(12.5)];
            x=lbl.right+5;
            lbl.text=[NSString stringWithFormat:@"#%@",str];
            lbl.hidden=YES;
            lbl.tag=1000+i;
            [self addSubview:lbl];
            
            
            
        }
        
        
        
        
        
        
    }
    
    
    return self;
}

-(void)setDataWithArrar:(NSArray *)arr
{
    CGFloat x=0;
    
    for (NSUInteger i=0; i<arr.count; i++) {
        NSString *str=[NSString stringWithFormat:@"#%@",arr[i]];
        CGSize size=[IHUtility GetSizeByText:str sizeOfFont:12.5 width:200];
        
        SMLabel *lbl=[self viewWithTag:1000+i];
        lbl.text=str;
        lbl.frame=CGRectMake(x, 0, size.width+10, 12.5);
        x=lbl.right+5;
        lbl.hidden=NO;
        if (x+15>=WindowWith) {
            lbl.size=CGSizeMake(30, 12.5);
        }
        
        
        
    }
}



@end

@implementation EPCloudCommentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBA(0, 0, 0, 0.45);
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(20, 0, WindowWith-40, 277)];
        backView.center = self.center;
        _backView= backView;
        backView.backgroundColor = [UIColor whiteColor];
        [self addSubview:backView];
        
        SMLabel *detailLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(0, 18, 100, 16) textColor:RGB(6, 193, 174) textFont:sysFont(15)];
        detailLbl.text = @"对企业的评价";
        detailLbl.centerX = backView.width / 2.0;
        detailLbl.textAlignment = NSTextAlignmentCenter;
        [backView addSubview:detailLbl];
        
        UIImage *image = Image(@"Line Copy 4.png");
        UIImageView *leftlineImageview=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, image.size.width, image.size.height)];
        leftlineImageview.image=image;
        leftlineImageview.right = detailLbl.left - 15;
        leftlineImageview.centerY = detailLbl.centerY;
        [backView addSubview:leftlineImageview];
        
        UIImage *rightImage = Image(@"Line4.png");
        UIImageView *lineRightImageview=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, rightImage.size.width, rightImage.size.height)];
        lineRightImageview.image=rightImage;
        lineRightImageview.left = detailLbl.right + 15;
        lineRightImageview.centerY = detailLbl.centerY;
        [backView addSubview:lineRightImageview];
        
        EDStarRating *ratingImage  = [[EDStarRating alloc] initWithFrame:CGRectMake(0, detailLbl.bottom + 12, 200, 28)];
        _ratingImage = ratingImage;
        ratingImage.centerX = backView.width / 2.0;
        _ratingImage.starImage = [UIImage imageNamed:@"starbigwhite9.png"];
        _ratingImage.starHighlightedImage = [UIImage imageNamed:@"starbiggreen9.png"];
        _ratingImage.maxRating = 5.0;
        _ratingImage.rating = 3.0;
        _ratingImage.editable = YES;
        _ratingImage.horizontalMargin = 0;
        _ratingImage.displayMode = EDStarRatingDisplayFull;
        _ratingImage.delegate = self;
        [backView addSubview:ratingImage];
        
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(20, ratingImage.bottom + 14, backView.width - 40, 130)];
        _textView = textView;
        textView.text = @"写下对它的印象吧，对他人帮助很大哦...";
        textView.font = sysFont(14);
        textView.delegate = self;
        textView.textColor = cGrayLightColor;
        textView.layer.borderColor = cLineColor.CGColor;
        textView.layer.borderWidth = 1;
        [backView addSubview:textView];
        
        UIButton *commentBtn  = [[UIButton alloc] initWithFrame:CGRectMake(0, textView.bottom + 11, 125, 38)];
        commentBtn.centerX = backView.width/2.0;
        commentBtn.backgroundColor = RGBA(85, 201, 196, 1);
        [commentBtn setTitle:@"提交评价" forState:UIControlStateNormal];
        [commentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        commentBtn.layer.cornerRadius = 19.0;
        commentBtn.titleLabel.font = sysFont(13);
        [commentBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:commentBtn];
        
        UIImage *img = Image(@"anonymous.png");
        UIImage *selectImg = Image(@"anonymous_selected.png");
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(textView.left , 0, img.size.width + 40, 25);
        btn.centerY = commentBtn.centerY;
        [btn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
        [btn setImage:[selectImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateSelected];
        [btn setTitle:@"匿名" forState:UIControlStateNormal];
        btn.titleLabel.font = sysFont(13);
        btn.titleEdgeInsets=UIEdgeInsetsMake(0, 7, 0, 0);
        btn.selected = YES;
        self.btn = btn;
        if (self.btn.selected) {
            [self.btn setTintColor:[UIColor clearColor]];
            [self.btn setTitleColor:RGBA(135, 134, 140, 1) forState:UIControlStateSelected];
        }
        [btn setTitleColor:RGBA(135, 134, 140, 1) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(anonymousAction:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:btn];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideView:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired= 1;
        [self addGestureRecognizer:tap];
        
            //****IQKeyboard
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWasShown:)
                                                     name:UIKeyboardWillShowNotification object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillBeHidden:)
                                                     name:UIKeyboardWillHideNotification object:nil];
        


        
    }
    
    return self;
}
- (void)btnAction:(UIButton *)button
{
    
    self.selectBlock(score,_textView.text);
    [self.textView resignFirstResponder];
    
}
- (void)anonymousAction:(UIButton *)button
{
    self.btn.selected = !self.btn.selected;
    if (self.btn.selected) {
        [self.btn setTintColor:[UIColor clearColor]];
        [self.btn setTitleColor:RGBA(135, 134, 140, 1) forState:UIControlStateSelected];
    }
    
}
-(void)starsSelectionChanged:(EDStarRating*)control rating:(float)rating
{
    [self.textView resignFirstResponder];
    score = stringFormatInt((int)rating);
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    textView.text = @"";
    textView.textColor = RGBA(44, 44, 46, 1);
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    
    textView.text = @"写下对它的印象吧，对他人帮助很大哦...";
    textView.textColor = cGrayLightColor;
    
}

- (void)hideView:(UITapGestureRecognizer *)tap
{
    [self.textView resignFirstResponder];
    
    CGPoint point = [tap locationInView:self];
    if (!CGRectContainsPoint(_backView.frame, point)) {
        [UIView animateWithDuration:1 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
    
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    //kbSize即為鍵盤尺寸 (有width, height)
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    _backView.bottom = self.height - kbSize.height ;
}
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    _backView.center = self.center;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}


@end


@implementation AreaView

- (id)initWithFrame:(CGRect)frame dataDic:(NSDictionary *)dataDic grade:(int)grade
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBA(0, 0, 0, 0.4);
        
        UIScrollView *backScroll = [[UIScrollView alloc] initWithFrame:self.bounds];
        backScroll.height = 250;
        backScroll.backgroundColor = [UIColor whiteColor];
        _backScroll = backScroll;
        [self addSubview:backScroll];
        
        self.btn  =[[UIButton alloc] initWithFrame:CGRectMake(30, 10, (self.width - 60)/3.0, 30)];
        [self.btn setTitle:@"全部" forState:UIControlStateNormal];
        [self.btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.btn.titleLabel.font = sysFont(14);
        self.btn.layer.borderColor = cLineColor.CGColor;
        self.btn.layer.borderWidth = 1.0;
        _btn = self.btn;
        [self.btn addTarget:self action:@selector(allcondition:) forControlEvents:UIControlEventTouchUpInside];
        [backScroll addSubview:self.btn];
        
        top = self.btn.bottom;
        _dataDic = dataDic;
        NSArray *areaArr = [dataDic allKeys];
        
        for (int i= 0; i<areaArr.count; i++) {
            NSArray *proviceArr;
            if (grade == 1) {
                proviceArr = dataDic[areaArr[i]];
            }else {
                NSDictionary *proviceDic = dataDic[areaArr[i]];
                proviceArr = [proviceDic allKeys];
            }


            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, top, self.width, ((proviceArr.count -1) /3 + 1)*40)];
            view.backgroundColor=[UIColor whiteColor];
            
            UILabel *label  = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 10, view.height-20)];
            label.numberOfLines = 0;
            label.font = sysFont(10);
            label.text = areaArr[i];
            [label sizeToFit];
            [view addSubview:label];
            
            for (int m=0; m<proviceArr.count; m++) {
                UIButton *button  =[[UIButton alloc] initWithFrame:CGRectMake(30 + ((self.width - 60)/3.0 + 10) * (m % 3) , m/3 *40 + 10, (self.width - 60)/3.0, 30)];
                [button setTitle:proviceArr[m] forState:UIControlStateNormal];
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                button.titleLabel.font = sysFont(14);
                button.layer.borderColor = cLineColor.CGColor;
                button.layer.borderWidth = 1.0;
                button.tag = i + 5;
                if (grade == 1) {
                     [button addTarget:self action:@selector(selectCityCondition:) forControlEvents:UIControlEventTouchUpInside];
                }else {
                    [button addTarget:self action:@selector(selectCondition:) forControlEvents:UIControlEventTouchUpInside];
                }
                [view addSubview:button];
            }
            
            [backScroll addSubview:view];
            top = top + view.height;
            
        }
        
        backScroll.contentSize = CGSizeMake(self.width, top);
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeSuperView:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired= 1;
        [self addGestureRecognizer:tap];
        
    }
    return self;
}
- (void)removeSuperView:(UITapGestureRecognizer *)tap
{
    self.selectBlock(nil,nil);
    
    CGPoint point = [tap locationInView:self];
    if (!CGRectContainsPoint(_backScroll.frame, point)) {
        [UIView animateWithDuration:.2 animations:^{
             self.backgroundColor = RGBA(0, 0, 0, 0);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:.3 animations:^{
                self.top = -self.height;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        }];

    }
    
}
- (void)allcondition:(UIButton *)button
{
    if (type == 2) {
        self.selectBlock(_proviceText,@"");
    }else {
       self.selectBlock(@"",@"");
    }

    [UIView animateWithDuration:.2 animations:^{
        self.backgroundColor = RGBA(0, 0, 0, 0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.3 animations:^{
            self.top = -self.height;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }];
   
    
}

- (void)selectCondition:(UIButton *)button
{
    type = 2;
    NSArray *areaArr = [_dataDic allKeys];
    NSDictionary *proviceDic = _dataDic[areaArr[button.tag-5]];
    NSArray *cityArr = [proviceDic objectForKey:button.titleLabel.text];
    
    UIButton *btn  =[[UIButton alloc] initWithFrame:CGRectMake(_btn.right + 10, 10, (self.width - 60)/3.0, 30)];
    [btn setTitle:@"返回上一级" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = sysFont(14);
    btn.layer.borderColor = cLineColor.CGColor;
    btn.layer.borderWidth = 1.0;
    [btn addTarget:self action:@selector(backLast:) forControlEvents:UIControlEventTouchUpInside];
    _backBtn = btn;
    [_backScroll addSubview:btn];

    CGFloat height;
    if (((cityArr.count -1) /3 + 1)*40 <= _backScroll.height) {
        height = _backScroll.height;
    }else{
        height = ((cityArr.count -1) /3 + 1)*40;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, _btn.bottom, self.width, height)];
    cityView = view;
    view.backgroundColor= [UIColor whiteColor];
    
    UILabel *label  = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 10, view.height-20)];
    label.numberOfLines = 0;
    label.font = sysFont(10);
    label.text = button.titleLabel.text;
    _proviceText = label.text;
    [label sizeToFit];
    label.width = 10;
    [view addSubview:label];
    
    for (int m=0; m<cityArr.count; m++) {
        UIButton *button  =[[UIButton alloc] initWithFrame:CGRectMake(30 + ((self.width - 60)/3.0 + 10) * (m % 3) , m/3 *40 + 10, (self.width - 60)/3.0, 30)];
        [button setTitle:cityArr[m] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = sysFont(14);
        button.layer.borderColor = cLineColor.CGColor;
        button.layer.borderWidth = 1.0;
        [button addTarget:self action:@selector(selectCityCondition:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
    }

    [_backScroll addSubview:view];
    _backScroll.contentSize = CGSizeMake(self.width, _backScroll.height);
    
}


- (void)backLast:(UIButton *)button
{
    [cityView removeFromSuperview];
    [_backBtn removeFromSuperview];
    type = 1;
    _backScroll.contentSize = CGSizeMake(self.width, top);
}

- (void)selectCityCondition:(UIButton *)button
{
    
    if ([self.btn.titleLabel.text isEqualToString:@"不限"]) {
        if (button.tag==5) {
            self.selectBlock(@"设计",button.titleLabel.text);
        }else if (button.tag==6) {
            self.selectBlock(@"工程",button.titleLabel.text);
        }
    }else{
       self.selectBlock(_proviceText,button.titleLabel.text); 
    }
    
    [UIView animateWithDuration:.2 animations:^{
        self.backgroundColor = RGBA(0, 0, 0, 0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.3 animations:^{
            self.top = -self.height;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }];
    
     self.selectBtnBlock(SelectBackVC);
    
}

@end



@implementation VisitingCardView
- (id)initWith
{
    self=[super initWithFrame:CGRectMake(0, 0, WindowWith, kScreenHeight)];
    if (self) {
        self.backgroundColor=RGBA(50, 50, 50,0.5);
       
        UIImageView *view=[[UIImageView alloc]initWithFrame:CGRectMake(12, 0.2*WindowWith, WindowWith-24, 1.31*WindowWith)];
        view.backgroundColor=[UIColor whiteColor];
        view.image=Image(@"visitingCard.png");
        view.layer.cornerRadius=14;
        _view=view;
        [self addSubview:view];
        
        self.hidden=YES;
        
        
        UIView *v=[[UIView alloc]initWithFrame:CGRectMake(view.width/2-0.14*WindowWith, 0.13*WindowWith, 0.28*WindowWith, 0.28*WindowWith)];
        v.backgroundColor=[UIColor whiteColor];
      //  v.centerX=view.centerX;
        v.layer.cornerRadius=0.14*WindowWith;
        v.layer.shadowColor=cGrayLightColor.CGColor;
        v.layer.shadowOffset=CGSizeMake(2, 2);
        v.layer.shadowOpacity=1;
        v.layer.shadowRadius=3;
        _v=v;
        [view addSubview:v];
        
        
        UIAsyncImageView *headImageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(0.01*WindowWith, 0.01*WindowWith, 0.26*WindowWith, 0.26*WindowWith)];
        headImageView.image=defalutHeadImage;
        _headImageView=headImageView;
        headImageView.layer.cornerRadius=0.13*WindowWith;
       // headImageView.center=view.center;
        [v addSubview:headImageView];
        
        
        
        
        
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, v.bottom+0.086*WindowWith, view.width, 22.5) textColor:cBlackColor textFont:sysFont(22.5)];
        lbl.text=@"苗人凤";
      
        _nickName=lbl;
        lbl.centerX=view.centerX;
        [view addSubview:lbl];
        
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, lbl.bottom+12, view.width, 13) textColor:cGrayLightColor textFont:sysFont(12.5)];
        lbl.text=@"已认证   4 供求   261粉丝   苗途站长";
        _gongqiuLbl=lbl;
          lbl.centerX=view.centerX;
        lbl.textAlignment=NSTextAlignmentCenter;
        [view addSubview:lbl];
        
        
       
        UIImage *img=Image(@"iconfont-gongsi.png");
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
        [btn setTitle:@"深圳中美园艺有限公司" forState:UIControlStateNormal];
        btn.titleEdgeInsets=UIEdgeInsetsMake(2, 8, 0, 0);
        [btn setTitleColor:cBlackColor forState:UIControlStateNormal];
        btn.frame=CGRectMake(0.053*WindowWith, lbl.bottom+0.096*WindowWith, 155, 13);
        btn.titleLabel.font=sysFont(13);
        btn.enabled=NO;
        _company=btn;
        [view addSubview:btn];
        
        
        img=Image(@"Group 44.png");
         UIButton  *positionBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [positionBtn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
        [positionBtn setTitle:@"总经理" forState:UIControlStateNormal];
        positionBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 8, 0, 0);
        [positionBtn setTitleColor:cBlackColor forState:UIControlStateNormal];
        positionBtn.frame=CGRectMake(btn.left, btn.bottom+12, 72, 13);
        positionBtn.titleLabel.font=sysFont(13);
        positionBtn.enabled=NO;
        _position=positionBtn;
        [view addSubview:positionBtn];
        
        
        
        img=Image(@"user_industry.png");
        UIButton  *intrustBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [intrustBtn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
        [intrustBtn setTitle:@"苗木基地" forState:UIControlStateNormal];
        intrustBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 8, 0, 0);
        [intrustBtn setTitleColor:cBlackColor forState:UIControlStateNormal];
        intrustBtn.frame=CGRectMake(positionBtn.right+12, btn.bottom+12, 85, 13);
        intrustBtn.titleLabel.font=sysFont(13);
        intrustBtn.enabled=NO;
        _instrust=intrustBtn;
        [view addSubview:intrustBtn];
        
        
        
        img=Image(@"homeadd.png");
        UIButton  *adressBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [adressBtn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
        [adressBtn setTitle:@"广东深圳市柏加镇柏南黑石头村5组" forState:UIControlStateNormal];
        adressBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 8, 0, 0);
        [adressBtn setTitleColor:cBlackColor forState:UIControlStateNormal];
        adressBtn.frame=CGRectMake(positionBtn.left, positionBtn.bottom+12, 233, 13);
        adressBtn.titleLabel.font=sysFont(13);
        adressBtn.enabled=NO;
        _adress=adressBtn;
        [view addSubview:adressBtn];
        
        
        
        img=Image(@"iconfont-lianxidianhua.png");
        UIButton  *telephoneBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [telephoneBtn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
        [telephoneBtn setTitle:@"15845623581" forState:UIControlStateNormal];
        telephoneBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 8, 0, 0);
        [telephoneBtn setTitleColor:cBlackColor forState:UIControlStateNormal];
        telephoneBtn.frame=CGRectMake(adressBtn.left, adressBtn.bottom+12, 110, 13);
        telephoneBtn.titleLabel.font=sysFont(13);
        telephoneBtn.enabled=NO;
        _telephone=telephoneBtn;
        [view addSubview:telephoneBtn];
        

        img=Image(@"messageG.png");
        UIButton  *emailBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [emailBtn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
        [emailBtn setTitle:@"1123654253@qq.com" forState:UIControlStateNormal];
        emailBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 8, 0, 0);
        [emailBtn setTitleColor:cBlackColor forState:UIControlStateNormal];
        emailBtn.frame=CGRectMake(telephoneBtn.left, telephoneBtn.bottom+12, 160, 13);
        emailBtn.titleLabel.font=sysFont(13);
        emailBtn.enabled=NO;
        _email=emailBtn;
        [view addSubview:emailBtn];

        
        
        
        
        
        
        img=Image(@"phoneG.png");
        UIButton  *phoneBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [phoneBtn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
        [phoneBtn setTitle:@"4000779991" forState:UIControlStateNormal];
        phoneBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 8, 0, 0);
        [phoneBtn setTitleColor:cBlackColor forState:UIControlStateNormal];
        phoneBtn.frame=CGRectMake(emailBtn.left, emailBtn.bottom+12, 100, 13);
        phoneBtn.titleLabel.font=sysFont(13);
        phoneBtn.enabled=NO;
        _phone=phoneBtn;
        [view addSubview:phoneBtn];
        
        
        
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(btn.left, phoneBtn.bottom+0.04*WindowWith, view.width-btn.left*2, 1)];
        
        lineView.backgroundColor=cLineColor;
        _lineView=lineView;
        [view addSubview:lineView];
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lineView.left, lineView.bottom+7, 40,14) textColor:cGreenColor textFont:sysFont(14)];
        lbl.text=@"主 营";
        lbl.textAlignment=NSTextAlignmentCenter;
        _lbl=lbl;
        [view addSubview:lbl];
        
       
        CGSize size=[IHUtility GetSizeByText:@"         樱花  三角梅  金石梅  红叶石楠  大叶乔   金桢子  美国红枫" sizeOfFont:14 width:WindowWith-btn.left*2];
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lineView.left, lineView.bottom+7, size.width,size.height) textColor:cGrayLightColor textFont:sysFont(14)];
        lbl.text=@"         樱花  三角梅  金石梅  红叶石楠  大叶乔   金桢子  美国红枫";
        lbl.numberOfLines=0;
        _zhuyingLbl=lbl;
        [view addSubview:lbl];
        
        
        
        
    }
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headTap:)];
    [self addGestureRecognizer:tap];
    
    
    return self;
}

-(void)show
{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha=1;
    } completion:^(BOOL finished) {
        self.hidden=NO;
    }];

    
}
-(void)headTap:(UITapGestureRecognizer *)tap
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha=0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


-(void)setdataWithModel:(UserChildrenInfo *)model arr:(NSArray *)arr dic:(NSDictionary *)dic
{
    [_headImageView setImageAsyncWithURL:model.heed_image_url placeholderImage:defalutHeadImage];
    CGSize size=[IHUtility GetSizeByText:model.nickname sizeOfFont:23 width:_view.width];
    //  _headImageView.centerX=_view.centerX;
    _nickName.text=model.nickname;
    _nickName.frame=CGRectMake(_view.width/2-size.width/2+0.01*WindowWith, _v.bottom+0.086*WindowWith, size.width, 22.5);
    // _nickName.centerX=self.centerX;
    NSMutableString *str=[[NSMutableString alloc]init];
    if ([model.user_authentication integerValue]==2){
        [str appendString:@" 已认证 "];
    }
    
    NSInteger i=[dic[@"supplyNum"] integerValue]+ [dic[@"wantByNum"] integerValue];
    
    [str appendString:[NSString stringWithFormat:@" %ld 供求 ",(long)i ]];
    [str appendString:[NSString stringWithFormat:@" %@ 粉丝 ",[dic[@"fansNum"] stringValue]]];
    
    for (NSNumber *obj in arr) {
        if ([[obj stringValue]isEqualToString:@"4"]) {
            [str appendString:[NSString stringWithFormat:@" %@站长 ",KAppName]];
        }
        
        if ([[obj stringValue] isEqualToString:@"5"]) {
            
            [str appendString:@" 战略合作伙伴 "];
        }
        if ([[obj stringValue] isEqualToString:@"7"]) {
            
            [str appendString:[NSString stringWithFormat:@" %@会员 ",KAppName]];
        }
        if ([[obj stringValue] isEqualToString:@"6"]) {
            
            [str appendString:@" 金种子 "];
        }
        if ([[obj stringValue] isEqualToString:@"1"] ||[[obj stringValue] isEqualToString:@"2"]) {
            
            [str appendString:@" 普通用户 "];
        }
    }
    
    _gongqiuLbl.text=str;
    _gongqiuLbl.centerX=_nickName.centerX;
    
    UIImage *img=Image(@"iconfont-gongsi.png");
    if (![model.company_name isEqualToString:@""]) {
        size=[IHUtility GetSizeByText:model.company_name sizeOfFont:13 width:200];
        _company.size=CGSizeMake(size.width+8+img.size.width, img.size.height);
        [_company setTitle:model.company_name forState:UIControlStateNormal];
    }else
    {
        _company.hidden=YES;
    }
    
    img=Image(@"Group 44.png");
    
    if (![dic[@"position"] isEqualToString:@""]) {
        size=[IHUtility GetSizeByText:dic[@"position"] sizeOfFont:13 width:200];
        _position.size=CGSizeMake(size.width+8+img.size.width, img.size.height);
        [_position setTitle:dic[@"position"] forState:UIControlStateNormal];
        
    }else
    {
        _position.hidden=YES;
    }
    
    
    if (_company.hidden) {
        _position.origin=CGPointMake(_company.left, _company.top);
    }
    
    
    if ([model.i_type_id integerValue]==1) {
        
        [_instrust setTitle:@"苗木基地" forState:UIControlStateNormal];
        
    }else if ([model.i_type_id integerValue]==2)
    {
        
        [_instrust setTitle:@"景观设计" forState:UIControlStateNormal];
        
    }else if ([model.i_type_id integerValue]==3)
    {
        
        [_instrust setTitle:@"施工企业" forState:UIControlStateNormal];
        
    }else if ([model.i_type_id integerValue]==4){
        
        [_instrust setTitle:@"园林资材" forState:UIControlStateNormal];
        
        
    }else if ([model.i_type_id integerValue]==5){
        
        [_instrust setTitle:@"花木市场" forState:UIControlStateNormal];
        
    }else{
        _instrust.hidden = YES;
    }
    if (_position.hidden) {
        _instrust.origin=CGPointMake(_position.left, _position.top);
    }else
    {
        _instrust.origin=CGPointMake(_position.right+12, _position.top+2);
    }
    
    img=Image(@"homeadd.png");
    if ([model.company_province isEqualToString:@""]&&[model.company_city isEqualToString:@""]&&[model.company_area isEqualToString:@""]&&[model.company_street isEqualToString:@""]) {
        _adress.hidden=YES;
    }else
    {
        size=[IHUtility GetSizeByText:[NSString stringWithFormat:@"%@%@%@%@",model.company_province,model.company_city,model.company_area,model.company_street] sizeOfFont:13 width:_view.width-24-20];
        [_adress setTitle:[NSString stringWithFormat:@"%@%@%@%@",model.company_province,model.company_city,model.company_area,model.company_street] forState:UIControlStateNormal];
        _adress.size=CGSizeMake(size.width+8+img.size.width, img.size.height);
        
        
        
        
    }
    _adress.origin=CGPointMake(_position.left, _position.bottom+12);
    
    if (_position.hidden &&_instrust.hidden) {
        _adress.origin=CGPointMake(_position.left, _position.top);
    }
    
    
    img=Image(@"iconfont-lianxidianhua.png");
    if (![model.mobile isEqualToString:@""]&& model.mobile) {
        size=[IHUtility GetSizeByText:model.mobile sizeOfFont:13 width:200];
        [_telephone setTitle:model.mobile forState:UIControlStateNormal];
        _telephone.size=CGSizeMake(size.width+8+img.size.width,img.size.height);
    }else
    {
        _telephone.hidden=YES;
    }
    
    
    
    
    
    if (_adress.hidden) {
        _telephone.origin=CGPointMake(_adress.left, _adress.top);
    }else
    {
        _telephone.origin=CGPointMake(_adress.left, _adress.bottom+12);
    }
    
    
    img=Image(@"messageG.png");
    if (![model.email isEqualToString:@""] && model.email) {
        size=[IHUtility GetSizeByText:model.email sizeOfFont:13 width:200];
        [_email setTitle:model.email forState:UIControlStateNormal];
        _email.size=CGSizeMake(size.width+8+img.size.width, img.size.height);
        
        
    }else
    {
        _email.hidden=YES;
    }
    
    
    _email.origin=CGPointMake(_telephone.left, _telephone.bottom+12);
    
    if (_telephone.hidden) {
        _email.origin=CGPointMake(_telephone.left, _telephone.top);
    }
    
    
    img=Image(@"phoneG.png");
    if (![dic[@"landline"] isEqualToString:@""] && model.landline) {
        size=[IHUtility GetSizeByText:dic[@"landline"]  sizeOfFont:13 width:200];
        [_phone setTitle:dic[@"landline"]  forState:UIControlStateNormal];
        _phone.size=CGSizeMake(size.width+8+img.size.width, img.size.height);
        
        
    }else
    {
        _phone.hidden=YES;
    }
    
    
    _phone.origin=CGPointMake(_email.left, _email.bottom+12);
    
    if (_email.hidden) {
        _phone.origin=CGPointMake(_email.left, _email.top);
    }
    
    
    _lineView.origin=CGPointMake(_phone.left, _phone.bottom+0.04*WindowWith);
    
    if (_phone.hidden) {
        
        _lineView.origin=CGPointMake(_email.left, _email.bottom+0.04*WindowWith);
        
    }
    
    
    if (![dic[@"main_business"] isEqualToString:@""]) {
        size=[IHUtility GetSizeByText:[NSString stringWithFormat:@"          %@",dic[@"main_business"]] sizeOfFont:14 width:_view.width-_lineView.left*2];
        _lbl.origin=CGPointMake(_lineView.left, _lineView.bottom+7);
        _zhuyingLbl.text=[NSString stringWithFormat:@"          %@",dic[@"main_business"]];
        _zhuyingLbl.frame=CGRectMake(_lineView.left, _lineView.bottom+7, size.width, size.height);
        
    }else
    {
        _lbl.hidden=YES;
        _zhuyingLbl.hidden=YES;
        _lineView.hidden=YES;
    }
    
    
    
//    _view.size=CGSizeMake(WindowWith-24, _zhuyingLbl.bottom+20);
//    
//    if (_lbl.hidden) {
//        _view.size=CGSizeMake(WindowWith-24, _phone.bottom+20);
//    }
    
}



@end



@implementation ConnectionsView
- (id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        
        
      
      
        
        
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 1)];
        lineView.backgroundColor=cLineColor;
        [self addSubview:lineView];
        UIAsyncImageView *headImageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(0.068*WindowWith, 0.04*WindowWith, 0.12*WindowWith, 0.12*WindowWith)];
        headImageView.layer.cornerRadius=0.12*WindowWith/2;
        headImageView.image=defalutHeadImage;
        _headImageView=headImageView;
        [self addSubview:headImageView];
        
        
        
        
        
        
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(headImageView.right+0.12*WindowWith, headImageView.top+0.026*WindowWith, self.width-(headImageView.right+0.12*WindowWith), 16) textColor:cBlackColor textFont:sysFont(16)];
       
        lbl.text=@"陈山明";
        _nickName=lbl;
        [self addSubview:lbl];
        
        
        
        self.btn=[UIButton buttonWithType:UIButtonTypeCustom];
        _btn=self.btn;
        self.btn.backgroundColor=RGB(239, 239, 242);
        [self.btn setTitle:@"+  关注" forState:UIControlStateNormal];
        self.btn.titleLabel.font=sysFont(14);
        [self.btn setTitleColor:RGB(120, 142, 126) forState:UIControlStateNormal];
        [self.btn setImage:Image(@"EP_yes") forState:UIControlStateHighlighted];
        [self.btn setTitle:@"已关注" forState:UIControlStateHighlighted];
        self.btn.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
        self.btn.frame=CGRectMake(0, headImageView.bottom+0.026*WindowWith, 0.235*WindowWith, 0.075*WindowWith);
        [self addSubview:self.btn];
        self.btn.centerX=headImageView.centerX;
        [self.btn addTarget:self action:@selector(guanzhu:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.left, lbl.bottom+0.04*WindowWith, self.width-lbl.left - 10, 13) textColor:cGreenColor textFont:sysFont(13)];
        lbl.text=@"#苗途站长 #金种子";
       
        _bqLbl=lbl;
       
        [self addSubview:lbl];
 
        
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.left, lbl.bottom+0.04*WindowWith, self.width-lbl.left - 10, 13) textColor:cBlackColor textFont:sysFont(13)];
        lbl.text=@"深圳 | 4 供求 | 261粉丝 | 苗途站长";
        _tilte=lbl;
      
        [self addSubview:lbl];

        
        
        
        
        lineView=[[UIView alloc]initWithFrame:CGRectMake(0, _btn.bottom+0.04*WindowWith, self.width, 1)];
        lineView.backgroundColor=cLineColor;
        [self addSubview:lineView];
       
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, lineView.bottom+0.026*WindowWith, self.width/3, 14) textColor:cGrayLightColor textFont:sysFont(14)];
        lbl.text=@"供求 47";
        lbl.textAlignment=NSTextAlignmentCenter;
        _supply=lbl;
        [self addSubview:lbl];
      
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.right, lineView.bottom+0.026*WindowWith, self.width/3, 14) textColor:cGrayLightColor textFont:sysFont(14)];
        lbl.text=@"活跃度 16";
        lbl.textAlignment=NSTextAlignmentCenter;
        _wantBuy=lbl;
        [self addSubview:lbl];
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.right, lineView.bottom+0.026*WindowWith, self.width/3, 14) textColor:cGrayLightColor textFont:sysFont(14)];
        lbl.text=@"粉丝 1231";
        lbl.textAlignment=NSTextAlignmentCenter;
        _fans=lbl;
        [self addSubview:lbl];
        
        
        EPImageView *EPImageview=[[EPImageView alloc]initWithFrame:CGRectMake(0, self.btn.bottom + 12, self.width, (self.width-32)/3)];
        _EPImageview=EPImageview;
       // [self addSubview:EPImageview];
        
        
        
        
        
        UIImage *img=Image(@"zuo.png");
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(12, headImageView.centerY, img.size.width, img.size.height)];
        imageView.image=img;
        _zuo=imageView;
        [self addSubview:imageView];
        
        
        img=Image(@"you.png");
       imageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.width-img.size.width-12, headImageView.centerY, img.size.width, img.size.height)];
        imageView.image=img;
        _you=imageView;
        [self addSubview:imageView];
        
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0.8*self.width, headImageView.centerY, 30, 13) textColor:cGrayLightColor textFont:sysFont(13)];
        lbl.text=@"3/6";
        _number=lbl;
        
        lbl.textAlignment=NSTextAlignmentCenter;
        [self addSubview:lbl];

        
        lineView=[[UIView alloc]initWithFrame:CGRectMake(0, self.height-1, self.width, 1)];
        lineView.backgroundColor=cLineColor;
        [self addSubview:lineView];
        
        
        
        lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, self.height)];
        lineView.backgroundColor=cLineColor;
        [self addSubview:lineView];
        
        lineView=[[UIView alloc]initWithFrame:CGRectMake(self.width-1, 0, 1, self.height)];
        lineView.backgroundColor=cLineColor;
        [self addSubview:lineView];
        
        
        
        
    }
    
    
    return self;
}



-(void)guanzhu:(UIButton *)sender{
    if (sender.tag==[USERMODEL.userID integerValue]) {
         [IHUtility addSucessView:@"不用关注自己哦" type:2];
        return;
    }else{
        
        sender.selected=!sender.selected;
        
        if (sender.selected) {
            self.selectBtnBlock(SelectFollowBlock);
            [sender setImage:Image(@"EP_yes") forState:UIControlStateNormal];
            [sender setTitle:@"已关注" forState:UIControlStateNormal];
            sender.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
        }else
        {
            self.selectBtnBlock(SelectUpFollowBlock);
            [sender setImage:nil forState:UIControlStateNormal];
            [sender setTitle:@"+  关注" forState:UIControlStateNormal];
        }

    }
   
    
}
-(void)setDataWithModel:(MTConnectionModel *)model  j:(NSInteger)j{
    
    self.layer.shadowColor=RGB(235, 235, 235).CGColor;
    self.layer.shadowOffset=CGSizeMake(0, 2);
    self.layer.shadowOpacity=1;
    self.layer.shadowRadius=5;
    
    
    [_headImageView setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@%@",ConfigManager.ImageUrl,model.heed_image_url,smallHeaderImage] placeholderImage:defalutHeadImage];
    CGSize size=[IHUtility GetSizeByText:model.nickname sizeOfFont:16 width:0.84*WindowWith];
    _headImageView.frame=CGRectMake(self.width/2-37.5, 19, 75, 75);
    _nickName.text=model.nickname;
    _nickName.size=CGSizeMake(size.width, 16);
   
     _nickName.centerX=_headImageView.centerX;
    
    int i=0;
    NSMutableString *str=[[NSMutableString alloc]init];
    if (![model.company_province isEqualToString:@""]) {
        i=1;
        [ str appendFormat:@"%@ ",model.company_province];
    }
    
    
    if (i==1) {
        [str appendFormat:@"| %@ 供求 ",model.totalSupplyWantBy];
    }else{
        [str appendFormat:@" %@ 供求 ",model.totalSupplyWantBy];
    }
    [str appendFormat:@"| %@ 粉丝 ",model.fansNum];
    if (![model.job_name isEqualToString:@""]) {
        [str appendFormat:@"| %@",model.job_name];
    }
    
    _btn.tag=[model.user_id integerValue];
    size=[IHUtility GetSizeByText:str sizeOfFont:13 width:0.84*WindowWith];
    _tilte.text=str;
    _tilte.size=CGSizeMake(size.width, 12.5);
    _tilte.centerX=_headImageView.centerX;
    
    if ([model.followStatus  isEqualToString:@"0"]) {
        [_btn setImage:nil forState:UIControlStateNormal];
        [_btn setTitle:@"+  关注" forState:UIControlStateNormal];
        _btn.selected=NO;
    }else{
        [_btn setImage:Image(@"EP_yes") forState:UIControlStateNormal];
        [_btn setTitle:@"已关注" forState:UIControlStateNormal];
        _btn.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
        _btn.selected=YES;
    }
    _btn.centerX=_headImageView.centerX;
    if (j==0) {
        _zuo.hidden=YES;
    }
    if (j==5) {
        _you.hidden=YES;
    }
    
    
    if (model.imgList.count>0) {
        NSArray *arr=[network getJsonForString:model.imgList[0]];
        _EPImageview.hidden=NO;
        [_EPImageview setDataWith:arr];
    }else{
        _EPImageview.hidden=YES;
    }
    
    
    _number.text=[NSString stringWithFormat:@"%ld/6",j+1];
    

}



//园林首页collectionView
-(void)setDataWithModel:(MTConnectionModel *)model zuo:(BOOL)zuo you:(BOOL)you indexPath:(NSIndexPath *)indexPath{
    
    self.layer.shadowColor=RGB(212, 212, 212).CGColor;
    self.layer.shadowOffset=CGSizeMake(1, 5);
    self.layer.shadowOpacity=3;
    self.layer.shadowRadius=3;
    
    
    [_headImageView setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@%@",ConfigManager.ImageUrl,model.heed_image_url,smallHeaderImage] placeholderImage:defalutHeadImage];
    CGSize size=[IHUtility GetSizeByText:model.nickname sizeOfFont:16 width:0.84*WindowWith];
    _nickName.text=model.nickname;
    _nickName.size=CGSizeMake(size.width, 16);
    _nickName.centerX=self.centerX;
    
    int i=0;
    NSMutableString *str=[[NSMutableString alloc]init];
    if (![model.company_province isEqualToString:@""]) {
        i=1;
        [ str appendFormat:@"%@ ",model.company_province];
    }
    
   
    if (i==1) {
        [str appendFormat:@"| %@ 供求 ",model.totalSupplyWantBy];
    }else{
         [str appendFormat:@" %@ 供求 ",model.totalSupplyWantBy];
    }
     [str appendFormat:@"| %@ 粉丝 ",model.fansNum];
    if (![model.job_name isEqualToString:@""]) {
        [str appendFormat:@" | %@",model.job_name];
    }
    
    _btn.tag=[model.user_id integerValue];
    size=[IHUtility GetSizeByText:str sizeOfFont:13 width:0.84*WindowWith];
    _tilte.text=str;
    _tilte.size=CGSizeMake(size.width, 12.5);
    _tilte.centerX=self.centerX;
   
    if ([model.followStatus  isEqualToString:@"0"]) {
        [_btn setImage:nil forState:UIControlStateNormal];
        [_btn setTitle:@"+  关注" forState:UIControlStateNormal];
        _btn.selected=NO;
    }else{
        [_btn setImage:Image(@"EP_yes") forState:UIControlStateNormal];
        [_btn setTitle:@"已关注" forState:UIControlStateNormal];
        _btn.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
        _btn.selected=YES;

    }

    if (zuo) {
        _zuo.hidden=YES;
    }
    if (you) {
        _you.hidden=YES;
    }
   
    
    if (model.imgList.count>0) {
        NSArray *arr=[network getJsonForString:model.imgList[0]];
        _EPImageview.hidden=NO;
        [_EPImageview setDataWith:arr];
    }else{
        _EPImageview.hidden=YES;
    }
    
    
    _number.text=[NSString stringWithFormat:@"%ld/6",indexPath.row+1];
    
}


//人脉云tableview
-(void)setDataWithModel:(MTConnectionModel *)model{
 
    
    [_headImageView setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@%@",ConfigManager.ImageUrl,model.heed_image_url,smallHeaderImage] placeholderImage:defalutHeadImage];
    
    
    
  
    _nickName.text=model.nickname;
    
    
    
    NSMutableString *str=[[NSMutableString alloc]init];
    NSInteger i=0;
    if (![model.company_province isEqualToString:@""]) {
        [ str appendFormat:@" %@ ",model.company_province];
        i=1;
    }
   
    
     [str appendFormat:@"| %@ ",model.short_name];
   
    if (![model.job_name isEqualToString:@""]) {
        [str appendFormat:@"| %@",model.job_name];
    }
    
  
    _tilte.text=str;
    _supply.text=[NSString stringWithFormat:@"供应 %@",model.totalSupply];
     _wantBuy.text=[NSString stringWithFormat:@"求购 %@",model.totalWantBy];
    _bqLbl.text=model.identity_value;
    if ([model.identity_value isEqualToString:@"#普通用户"]) {
        _bqLbl.textColor=cGrayLightColor;
    }else{
        _bqLbl.textColor=cGreenColor;
    }
    
    _fans.text=[NSString stringWithFormat:@"粉丝 %@",model.fansNum];
    
    _btn.tag=[model.user_id integerValue];
    _btn.bottom = _tilte.bottom;
    
    if ([model.followStatus  isEqualToString:@"0"]) {
        [_btn setImage:nil forState:UIControlStateNormal];
        [_btn setTitle:@"+  关注" forState:UIControlStateNormal];
        _btn.selected=NO;
    }else{
        [_btn setImage:Image(@"EP_yes") forState:UIControlStateNormal];
        [_btn setTitle:@"已关注" forState:UIControlStateNormal];
        _btn.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
        _btn.selected=YES;

    }
    
    
    
        _zuo.hidden=YES;
    
  
        _you.hidden=YES;
    
  
    
//    if (model.imgList.count>0) {
//        NSArray *arr=[network getJsonForString:model.imgList[0]];
//        _EPImageview.hidden=NO;
//        [_EPImageview setDataWith:arr];
//    }else{
//        _EPImageview.hidden=YES;
//    }
    _number.hidden=YES;
    
}
//
//-(void)selfBtnClike{
//
//}


@end




@implementation CompanyView

- (id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
         self.backgroundColor=[UIColor whiteColor];
        
        self.layer.shadowColor=RGB(235, 235, 235).CGColor;
        self.layer.shadowOffset=CGSizeMake(0, 2);
        self.layer.shadowOpacity=1;
        self.layer.shadowRadius=5;
        
        
        
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 1)];
        lineView.backgroundColor=cLineColor;
        [self addSubview:lineView];
        
        
        UIAsyncImageView *bkImageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, 0.43*self.width)];
        bkImageView.image=DefaultImage_logo;
        _bkImageView=bkImageView;
        [self addSubview:bkImageView];
        
        
        UIAsyncImageView *logoImageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(0.04*WindowWith, bkImageView.bottom+0.04*WindowWith, 0.153*self.width, 0.153*self.width)];
        //logoImageView.center=bkImageView.center;
        [self addSubview:logoImageView];
        logoImageView.image=defalutHeadImage;
        _logoImageView=logoImageView;
        [ logoImageView setLayerMasksCornerRadius:0.153*self.width/2 BorderWidth:0 borderColor:[UIColor clearColor]];
        
        
        
        
        SMLabel *companyLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(logoImageView.right+12, logoImageView.top+5, self.width - 24, 17) textColor:RGBA(44, 44, 46, 1) textFont:sysFont(17)];
       
        companyLbl.textAlignment = NSTextAlignmentLeft;
        companyLbl.text = @"深圳文科园林股份有限公司";
        _companyName=companyLbl;
        [self addSubview:companyLbl];
        
        EDStarRating *ratingImage  = [[EDStarRating alloc] initWithFrame:CGRectMake(logoImageView.left, logoImageView.bottom + 6, logoImageView.width, 0.024*WindowWith)];
       // ratingImage.centerX = self.width/2.0;
        _ratingImage = ratingImage;
        _ratingImage.starImage = [UIImage imageNamed:@"starminiwhite.png"];
        _ratingImage.starHighlightedImage = [UIImage imageNamed:@"starminigreen.png"];
        _ratingImage.maxRating = 5.0;
        _ratingImage.rating = 3.5;
        _ratingImage.editable = NO;
        _ratingImage.horizontalMargin = 0;
        _ratingImage.displayMode = EDStarRatingDisplayHalf;
        _ratingImage.delegate = self;
        [self addSubview:ratingImage];
        
     
        
        SMLabel *companyInfo = [[SMLabel alloc] initWithFrameWith:CGRectMake(companyLbl.left, companyLbl.bottom +10, companyLbl.width, 13.5) textColor:RGBA(135, 134, 140, 1) textFont:sysFont(13)];
        companyInfo.textAlignment = NSTextAlignmentLeft;
        _intrudetion=companyInfo;
        companyInfo.text = @"景观设计 | 合资股份 | 500-999人";
        [self addSubview:companyInfo];

        
        
        lineView=[[UIView alloc]initWithFrame:CGRectMake(12, _ratingImage.bottom+0.045*WindowWith, self.width-24, 1)];
        lineView.backgroundColor=cLineColor;
         _lineView=lineView;
        [self addSubview:lineView];
        
        
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lineView.left, lineView.bottom+0.01*WindowWith, lineView.width, 40) textColor:cGrayLightColor textFont:sysFont(13.5) ];
        lbl.numberOfLines=2;
        lbl.text=@"正河苗圃基地位于浏阳市苗木产业园内，是浏阳苗木产业园最重要的组成部分，也获得了行业…";
        _title=lbl;
        [self addSubview:lbl];
        
        
        lineView=[[UIView alloc]initWithFrame:CGRectMake(0, self.height-1, self.width, 1)];
        lineView.backgroundColor=cLineColor;
       [self addSubview:lineView];

        
        
        lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, self.height)];
        lineView.backgroundColor=cLineColor;
        [self addSubview:lineView];
        
        lineView=[[UIView alloc]initWithFrame:CGRectMake(self.width-1, 0, 1, self.height)];
        lineView.backgroundColor=cLineColor;
        [self addSubview:lineView];

        
        
    }
    
    return self;
}


-(void)setDataWithModel:(MTCompanyModel *)model{
    
   
    
    if (![model.company_image isEqualToString:@""]) {
        NSArray *arr=[network getJsonForString:model.company_image];
       
        
            MTPhotosModel *mod=[[MTPhotosModel alloc]initWithUrlDic:arr[0]];
            [_bkImageView setImageAsyncWithURL:mod.imgUrl placeholderImage:DefaultImage_logo];
            
        

    }
  
        [_logoImageView setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,model.logo] placeholderImage:EPDefaultImage_logo];
        
   
    
    
         CGSize size=[IHUtility GetSizeByText:model.company_name sizeOfFont:17 width:self.width];
    _companyName.size=CGSizeMake(size.width, 17);
    _companyName.text=model.company_name;
   
   
    
    _ratingImage.rating=[model.level doubleValue];
    //_ratingImage.centerX=_companyName.centerX;
    NSMutableString *str=[[NSMutableString alloc]init];
    NSInteger i=0;
    if (![model.i_name isEqualToString:@""]) {
        i=1;
        [str appendFormat:@" %@",model.i_name];
        
    }
    
    if (![model.company_label isEqualToString:@""]) {
        if (i==1) {
          [str appendFormat:@" | %@",model.company_label];
        }else{
            [str appendFormat:@" %@",model.company_label];
        }
        
    }
    
    if (![model.staff_size isEqualToString:@""]) {
        [str appendFormat:@" | %@",model.staff_size];
    }
    
    size=[IHUtility GetSizeByText:str sizeOfFont:14 width:self.width];
    _intrudetion.text=str;
    _intrudetion.size=CGSizeMake(size.width, 14);
   // _intrudetion.centerX=_companyName.centerX;
    
    
   // _lineView.origin=CGPointMake(12, _intrudetion.bottom+0.045*WindowWith);
    
    size=[IHUtility GetSizeByText:model.company_desc sizeOfFont:14 width:self.width-24];
    _title.text=model.company_desc;
    _title.numberOfLines=2;
   
    _title.frame=CGRectMake(_lineView.left, _lineView.bottom+0.01*WindowWith, size.width, size.height);
    if (size.height>self.height-_lineView.bottom) {
         _title.frame=CGRectMake(_lineView.left, _lineView.bottom+0.01*WindowWith, size.width, self.height-_lineView.bottom);
    }
    if ([model.company_desc isEqualToString:@""]) {
        _lineView.hidden=YES;
    }
    
    
}










@end


@implementation EPImageView

- (id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
     
        
        for (NSInteger i=0; i<3; i++) {
            UIAsyncImageView *photoImageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(6+((self.width-6)/3)*i, 0, (self.width-6)/3-6, (self.width)/3-6)];
            photoImageView.tag=1000+i;
            photoImageView.image=DefaultImage_logo;
            photoImageView.hidden=NO;
            [self addSubview:photoImageView];
            
        }

    }


    return self;

}


-(void)setDataWith:(NSArray *)arr{
    
    for (NSInteger i=0; i<arr.count; i++) {
     
        
        UIAsyncImageView *imageView=[self viewWithTag:1000+i];
        imageView.layer.cornerRadius = _cornerRedius;
        imageView.hidden=NO;
        NSDictionary *obj=arr[i];
        MTPhotosModel *mod=[[MTPhotosModel alloc]initWithUrlDic:obj];
        NSString *str=[NSString stringWithFormat:@"%@",mod.imgUrl];
        [imageView setImageAsyncWithURL: str  placeholderImage:DefaultSquareImage];
        
    }
    
    
    int count=(int)arr.count;
    for (int i=1000+count; i<1003; i++) {
        UIImageView *imgView=(UIImageView *)[self viewWithTag:i];
        imgView.hidden=YES;
    }

    
}








@end



@implementation CommentAndLikeView
- (id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        
        
        self.layer.cornerRadius=5;
        
        self.backgroundColor=RGB(69, 74, 79);
        
        UIButton *btn=[self creatButtonWithTitle:@"赞" image:Image(@"GongQiu_zan.png") selImage:nil target:self selector:@selector(zan)];
        btn.frame=CGRectMake(0, 0, self.width/2, self.height);
        [self addSubview:btn];
        
        
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(self.width/2, 2, 1, self.height-4)];
        lineView.backgroundColor=[UIColor whiteColor];
        [self addSubview:lineView];
        
        UIButton *Btn=[self creatButtonWithTitle:@"评论" image:Image(@"GongQiu_comment.png") selImage:nil target:self selector:@selector(comment)];
        Btn.frame=CGRectMake(btn.right-1, 0, self.width/2-1, self.height);
        [self addSubview:Btn];

        
        
        
    }
    
    
    return self;
    
}


- (UIButton *)creatButtonWithTitle:(NSString *)title image:(UIImage *)image selImage:(UIImage *)selImage target:(id)target selector:(SEL)sel
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    [btn setImage:[selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateSelected];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
    return btn;
}

-(void)zan{
    
    self.selectBtnBlock(agreeBlock);
    
}

-(void)comment{
    
    self.selectBtnBlock(commentBlock);
}


-(void)show{
    

}

-(void)hide{
    [UIView animateWithDuration:0.2 animations:^{
        self.width=0;
        
        
    }];
    
}



@end



@implementation VotoView
- (id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
         self.backgroundColor=RGBA(60, 79, 94, 0.3);
        
        self.hidden=YES;
        
        UIView *bkView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0.872*WindowWith, 0.757*WindowWith)];
        bkView.backgroundColor=[UIColor whiteColor];
        bkView.center=self.center;
        [self addSubview:bkView];
        
          UITapGestureRecognizer *Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        
        [self addGestureRecognizer:Tap];
        
        
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, 0.048*WindowWith, 75, 15) textColor:cGreenColor textFont:sysFont(15)];
        lbl.text=@"你将投票给";
        lbl.centerX=bkView.width/2;
        [bkView addSubview:lbl];
        
        
        UIAsyncImageView *imageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(0, lbl.bottom+0.08*WindowWith, 0.266*WindowWith, 0.266*WindowWith)];
        imageView.image=defalutHeadImage;
        [bkView addSubview:imageView];
        _imageView = imageView;
        imageView.centerX=bkView.width/2;
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(12, 0.02*WindowWith+imageView.bottom, bkView.width - 24, 14) textColor:cBlackColor textFont:sysFont(14)];
        lbl.text=@"002号  张学强";
        lbl.centerX=bkView.width/2;
        _namelbl = lbl;
        [bkView addSubview:lbl];
        
        
       
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(12, 0.0226*WindowWith+lbl.bottom, bkView.width - 24, 14) textColor:RGB(135, 134, 140) textFont:sysFont(11)];
        lbl.text=@"剩余选票4/5票";
        lbl.centerX=bkView.width/2;
        lbl.textAlignment = NSTextAlignmentCenter;
        _voteNumlbl = lbl;
        [bkView addSubview:lbl];
        
        
        BtnView *btnView=[[BtnView alloc]initWithFrame:CGRectMake(0, lbl.bottom+0.0266*WindowWith, 128, 37) cornerRadius:20 text:@"确 定" image:nil];
        btnView.centerX=bkView.width/2;
        [bkView addSubview:btnView];
        [btnView addTarget:self action:@selector(certian) forControlEvents:UIControlEventTouchUpInside];
        
         
    }
    return self;
}

- (void)setContent:(VoteListModel*)model lmitNum:(NSString *)limitNum surplus:(NSString *)surplus
{
    [_imageView setImageAsyncWithURL:model.head_image placeholderImage:defalutHeadImage];
    
    _namelbl.text = [NSString stringWithFormat:@"%@号 %@",model.project_code,model.name];
    _namelbl.textAlignment = NSTextAlignmentCenter;
    
    if ([surplus integerValue] <= 0) {
        surplus = @"0";
    }
    _voteNumlbl.text = [NSString stringWithFormat:@"剩余选票%@/%@张",surplus,limitNum];
    _voteNumlbl.attributedText = [IHUtility changePartTextColor:_voteNumlbl.text range:NSMakeRange(4, _voteNumlbl.text.length-5) value:RGB(6, 193, 174)];
}

-(void)certian{
    
    self.selectBtnBlock(SelectBtnBlock);
//    [self hide];
    
}




-(void)show{
    [UIView animateWithDuration:0.2 animations:^{
        self.hidden=NO;
        self.alpha=1;
        
    }];

    
}

-(void)hide{
    
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.alpha=0;
                         
                     }
                     completion:^(BOOL finished) {
                         self.hidden=YES;
                        
                     }];
}



@end


@implementation BuyVotoNumView
- (id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UIView *bkView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth(305), kWidth(357))];
        bkView.backgroundColor = [UIColor whiteColor];
        bkView.centerX = self.width/2.;
        bkView.centerY = self.height/2.;
        [self addSubview:bkView];
        bkView.layer.cornerRadius = kWidth(5);
        
        UITapGestureRecognizer *Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:Tap];
        
        
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, kWidth(20), kWidth(88), 15) textColor:kColor(@"#333333") textFont:RegularFont(font(16))];
        lbl.text=@"你将投票给";
        lbl.centerX=bkView.width/2;
        [bkView addSubview:lbl];
        
        UIView *leftLine = [[UIView alloc] initWithFrame:CGRectMake(kWidth(20), 0, kWidth(68), 1)];
        leftLine.backgroundColor = kColor(@"#999999");
        leftLine.centerY = lbl.centerY;
        [bkView addSubview:leftLine];
        
        UIView *rightLine = [[UIView alloc] initWithFrame:CGRectMake(bkView.width - kWidth(20) - leftLine.width, 0, leftLine.width, 1)];
        rightLine.backgroundColor = kColor(@"#999999");
        rightLine.centerY = lbl.centerY;
        [bkView addSubview:rightLine];
        
        
        UIAsyncImageView *imageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(0, lbl.bottom+kWidth(25), kWidth(90), kWidth(90))];
        imageView.image=defalutHeadImage;
        [bkView addSubview:imageView];
        _imageView = imageView;
        imageView.centerX=bkView.width/2;
        imageView.layer.cornerRadius = imageView.height/2;
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, imageView.bottom, bkView.width, kWidth(35)) textColor:kColor(@"#333333") textFont:darkFont(font(18))];
        lbl.text=@"002号  张学强";
        _namelbl = lbl;
        _namelbl.textAlignment = NSTextAlignmentCenter;
        [bkView addSubview:lbl];
        
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, _namelbl.bottom + kWidth(11), bkView.width, kWidth(33)) textColor:kColor(@"#333333") textFont:RegularFont(font(18))];
        lbl.text=@"剩余选票4/5票";
        lbl.textAlignment = NSTextAlignmentCenter;
        _voteNumlbl = lbl;
        [bkView addSubview:lbl];
        
        UITextField *textfd = [[UITextField alloc] initWithFrame:CGRectMake(0, kWidth(5) + _voteNumlbl.bottom, kWidth(87), kWidth(30))];
        textfd.centerX = bkView.width/2.;
        _textfd = textfd;
        [bkView addSubview:textfd];
        textfd.textAlignment = NSTextAlignmentCenter;
        textfd.keyboardType = UIKeyboardTypeNumberPad;
        textfd.layer.borderColor = kColor(@"#999999").CGColor;
        textfd.layer.borderWidth = 1;
        textfd.layer.cornerRadius = kWidth(3);
        textfd.font = sysFont(font(19));
        
        UILabel *leftLab = [[UILabel alloc] initWithFrame:CGRectMake(textfd.left - kWidth(20) - kWidth(3), textfd.top, kWidth(20), textfd.height)];
        leftLab.text = @"投";
        leftLab.font = RegularFont(font(18));
        leftLab.textColor = kColor(@"#333333");
        leftLab.textAlignment = NSTextAlignmentRight;
        textfd.text = @"1";
        [bkView addSubview:leftLab];
        
        UILabel *rightLab = [[UILabel alloc] initWithFrame:CGRectMake(textfd.right + kWidth(3), textfd.top, kWidth(20), textfd.height)];
        rightLab.text = @"票";
        rightLab.font = RegularFont(font(18));
        rightLab.textColor = kColor(@"#333333");
        rightLab.textAlignment = NSTextAlignmentLeft;
        [bkView addSubview:rightLab];
        
        
        BtnView *btnView=[[BtnView alloc]initWithFrame:CGRectMake(kWidth(38), textfd.bottom+kWidth(30), kWidth(96), kWidth(35)) cornerRadius:kWidth(35)/2. text:@"给TA投票" image:nil];
        [bkView addSubview:btnView];
        btnView.titleLabel.font = RegularFont(font(16));
        [btnView addTarget:self action:@selector(certian) forControlEvents:UIControlEventTouchUpInside];
        
        
        btnView=[[BtnView alloc]initWithFrame:CGRectMake(bkView.width - kWidth(38) - btnView.width, btnView.top, kWidth(96), kWidth(35)) cornerRadius:kWidth(35)/2. text:@"购买选票" image:nil];
        [bkView addSubview:btnView];
        btnView.titleLabel.font = RegularFont(font(16));
        [btnView addTarget:self action:@selector(BuyVotoAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (void)setContent:(VoteListModel*)model lmitNum:(NSString *)limitNum surplus:(NSString *)surplus
{
    [_imageView setImageAsyncWithURL:model.head_image placeholderImage:defalutHeadImage];
    
    _namelbl.text = [NSString stringWithFormat:@"%@",model.name];
    
    
    if ([surplus integerValue] <= 0) {
        surplus = @"0";
    }
    _voteNumlbl.text = [NSString stringWithFormat:@"剩余选票%@/%@张",surplus,limitNum];
    _yupiaoStr = surplus;
    _voteNumlbl.attributedText = [IHUtility changePartTextColor:_voteNumlbl.text range:NSMakeRange(4, _voteNumlbl.text.length-5) value:RGB(6, 193, 174)];
}

-(void)certian{
    if (_textfd.text.length > 0) {
        if ([_textfd.text intValue] > 0) {
            if ([_yupiaoStr integerValue] < [_textfd.text intValue]) {
                [IHUtility addSucessView:@"余票不足" type:2];
                return;
            }
            self.selectBtnBlock(_textfd.text);
            [self hide];
        }
    }
//    [self hide];
}
- (void) BuyVotoAction {
    [self hide];
    if (self.buyVotoBtnBlock) {
        self.buyVotoBtnBlock();
    }
}
-(void)hide{
    if (self.hideBtnBlock) {
        self.hideBtnBlock();
    }
}



@end





