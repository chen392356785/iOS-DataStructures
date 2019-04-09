//
//  CustomView+CustomCategory3.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/7/28.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "CustomView+CustomCategory2.h"
#import "CustomView+CustomCategory3.h"

@implementation CustomView (CustomCategory3)

@end



@implementation MTSupplyAndBuyDetailsImageView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        _picContainerView = [SDWeiXinPhotoContainerView new];
        [self addSubview:_picContainerView];
//        for (NSInteger i=0; i<9; i++) {
//            UIAsyncImageView *imageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(0, _lastImg.bottom+10, self.width, 100)];
//            _lastImg=imageView;
//            imageView.tag=2000+i;
//            imageView.hidden=YES;
//            imageView.image=DefaultImage_logo;
//            [self addSubview:imageView];
//
//
//        }
    }
    
    return self;
}

-(void)setData:(NSArray *)arr{
  
    _picContainerView.picPathStringsArray = arr;
    CGFloat picContainerTopMargin = 0;
    if (arr.count) {
        picContainerTopMargin = 10;
    }
    _picContainerView.sd_layout
    .leftSpaceToView(self, 4)
    .topSpaceToView(self, 5);
/*
    CGFloat imgHeigh=0;
    for (int i=0; i<arr.count; i++) {
        
        if (i!=0) {
            imgHeigh=_lastImg.bottom;
        }
          MTPhotosModel *mod=arr[i];
        
         UIAsyncImageView *imageView=[self viewWithTag:2000+i];
         [imageView setImageAsyncWithURL:mod.imgUrl placeholderImage:DefaultImage_logo];
        [imageView canClickItWithDuration:0.5 ThumbUrl:mod.imgUrl];
         imageView.frame=CGRectMake(0, imgHeigh+10, self.width, self.width*(mod.imgHeigh/mod.imgWidth));
         _lastImg=imageView;
         imageView.hidden=NO;
     
     }
    
    int count=(int)arr.count;
    for (int i=2000+count; i<2009; i++) {
        UIAsyncImageView *imgView=(UIAsyncImageView *)[self viewWithTag:i];
        imgView.hidden=YES;
    }
//*/
}


-(CGFloat)returnImagesHightWithArr:(NSArray *)arr{
    CGFloat hight=0;
    for (int i=0; i<arr.count; i++) {
       MTPhotosModel *mod=arr[i];
        
        hight=hight+self.width*(mod.imgHeigh/mod.imgWidth)+10;
    }
    
    return _picContainerView.size.height;
    
//    return hight;
}




@end


@implementation EPCloudScrollView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        for (NSInteger i=0; i<6; i++) {
            if (i==0) {
                
                ConnectionsView *view=[[ConnectionsView alloc]initWithFrame:CGRectMake(0.08*WindowWith, 0, 0.84*WindowWith, 0.9*WindowWith)];
                [self addSubview:view];
                view.tag=2000+i;
              
                
                
            }else{
                
                ConnectionsView *view=[[ConnectionsView alloc]initWithFrame:CGRectMake(0.08*WindowWith+(0.84*WindowWith+0.04*WindowWith)*i, 0, 0.84*WindowWith, 0.9*WindowWith)];
                [self addSubview:view];
                  view.tag=2000+i;
               
            }
            

        }
        
        
    }
    return self;
}
-(void)setDataWithModel:(NSArray *)arr{
    
    for (NSInteger i=0; i<arr.count; i++) {
        NSDictionary *dic=arr[i];
        MTConnectionModel *model=[[MTConnectionModel alloc]initWithDictionary:dic error:nil];
        ConnectionsView *View=(ConnectionsView *)[self viewWithTag:2000+i];
        [View setDataWithModel:model j:i];
    }
}

@end




@implementation CrowdFundingTopView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor=[UIColor whiteColor];
        
        UITapGestureRecognizer *Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBord)];
        
        [self addGestureRecognizer:Tap];

        
        
        UIView *lblView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 0.53*WindowWith)];
        lblView.backgroundColor=cGreenColor;
        [self addSubview:lblView];
        
        
        UIButton *editBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _editBtn=editBtn;
        editBtn.frame=CGRectMake(0, 0.1*WindowWith, 0.16*WindowWith, 20);
        [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [editBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        editBtn.centerX=self.centerX;
        editBtn.titleLabel.font=sysFont(15);
        if (WindowWith==320) {
             editBtn.titleLabel.font=sysFont(13);
        }
        [editBtn addTarget:self action:@selector(baocun) forControlEvents:UIControlEventTouchUpInside];
       
        editBtn.enabled=NO;
        [lblView addSubview:editBtn];
        
        CAShapeLayer *border = [CAShapeLayer layer];
        
        border.strokeColor = [UIColor whiteColor].CGColor;
        
        border.fillColor = nil;
        
        border.path = [UIBezierPath bezierPathWithRect:editBtn.bounds].CGPath;
        
        border.frame = self.bounds;
        
        border.lineWidth = 1.f;
        
        border.lineCap = @"square";
        
        border.lineDashPattern = @[@4, @2];
        
        [editBtn.layer addSublayer:border];
        
       
      
        self.placeholderTextView=[[PlaceholderTextView alloc]initWithFrame:CGRectMake(WindowWith/2-0.37*WindowWith, editBtn.bottom, 0.74*WindowWith, 0.26*WindowWith)];
        _placeholderTextView.backgroundColor=cGreenColor;
        _placeholderTextView.delegate=self;
        _placeholderTextView.font=sysFont(18);
        _placeholderTextView.textColor=[UIColor whiteColor];
        border = [CAShapeLayer layer];
        
        border.strokeColor = [UIColor whiteColor].CGColor;
        
        border.fillColor = nil;
        
        border.path = [UIBezierPath bezierPathWithRect:_placeholderTextView.bounds].CGPath;
        
        border.frame = self.bounds;
        
        border.lineWidth = 1.f;
        
        border.lineCap = @"square";
        
        border.lineDashPattern = @[@4, @2];
        
        [_placeholderTextView.layer addSublayer:border];
  
        [lblView addSubview:_placeholderTextView];
        
        self.placeholderTextView.placeholder=@"来帮我付款呀～呀";
        [_placeholderTextView setPlaceholderColor:[UIColor whiteColor]];
        
    
        self.placeholderTextView.placeholderFont=sysFont(18);
        if (WindowWith==320) {
          self.placeholderTextView.placeholderFont=sysFont(15);
             _placeholderTextView.font=sysFont(17);
             _placeholderTextView.font=sysFont(16);
        }
        
        
        
        
        
        UIAsyncImageView *headImageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(0.04*WindowWith, lblView.bottom-0.192*WindowWith/2, 0.192*WindowWith, 0.192*WindowWith)];
        headImageView.image=defalutHeadImage;
        _headImageView=headImageView;
        
        headImageView.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headTap)];
       
        [headImageView addGestureRecognizer:tap];
        
        
        [  headImageView setLayerMasksCornerRadius:0.192*WindowWith/2 BorderWidth:0 borderColor:[UIColor clearColor]];
        [self addSubview:headImageView];
        
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(headImageView.right+5, headImageView.top+0.026*WindowWith, 80, 15) textColor:[UIColor whiteColor] textFont:sysFont(15)];
        _nickName=lbl;
        lbl.text=@"俊lee的众筹";
        [self addSubview:lbl];
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.right+5, lbl.top+2, 140, 12) textColor:[UIColor whiteColor] textFont:sysFont(12)];
        _timeLbl=lbl;
        lbl.text=@"（离结束还剩10天 ）";
        [self addSubview:lbl];

        
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(headImageView.right+5, lblView.bottom+10, 0.704*WindowWith, 7)];
        view.backgroundColor=RGB(216, 216, 216);
        [self addSubview:view];
        [view setLayerMasksCornerRadius:5 BorderWidth:0 borderColor:[UIColor clearColor]];
        
        UIView *progressView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 7)];
        [view addSubview:progressView];
        _progressView=progressView;
        [progressView setLayerMasksCornerRadius:5 BorderWidth:0 borderColor:[UIColor clearColor]];
        progressView.backgroundColor=RGB(232, 121, 117);
        
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(view.left, view.bottom+8, 60, 11) textColor:cBlackColor textFont:sysFont(11)];
        lbl.text=@"已完成40%";
        _progressLbl=lbl;
        [self addSubview:lbl];
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.right+10, view.bottom+8, view.width, 11) textColor:cBlackColor textFont:sysFont(11)];
        lbl.textAlignment=NSTextAlignmentRight;
        lbl.text=@"还差1200元";
        _chajiaLbl=lbl;
        [self addSubview:lbl];
        
        
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, headImageView.bottom+0.04*WindowWith, WindowWith, 1)];
        lineView.backgroundColor=cLineColor;
        [self addSubview:lineView];
        
        
        UIImage *img=Image(@"pay_finish.png");
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(WindowWith-0.12*WindowWith, 0, 0.12*WindowWith, 0.12*WindowWith)];
        _typeImageView=imageView;
        imageView.image=img;
        [self addSubview:imageView];
		
        
//        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(view.left, view.bottom+8, 60, 11) textColor:cBlackColor textFont:sysFont(11)];
//        lbl.text=@"已完成40%";
//        [self addSubview:lbl];
 
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(headImageView.left, lineView.bottom+0.067*WindowWith, 209, 12) textColor:cBlackColor textFont:sysFont(12)];
        lbl.text=@"2016年第八届国际园林博览会众筹活动";
        _titleLbl=lbl;
        [self addSubview:lbl];
        
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.left, lbl.bottom+0.026*WindowWith, 50, 11) textColor:RGB(232, 121, 117) textFont:sysFont(11)];
        lbl.text=@"¥2000.00";
        _priceLbl=lbl;
        [self addSubview:lbl];

        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.left, lbl.bottom+0.026*WindowWith, 128, 11) textColor:cBlackColor textFont:sysFont(11)];
        lbl.text=@"截止时间：2016年8月1日";
        _jiezhiLbl=lbl;
        [self addSubview:lbl];
        
        
        
        UIAsyncImageView *ImageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(WindowWith-0.229*WindowWith-0.04*WindowWith, lineView.bottom+0.026*WindowWith, 0.229*WindowWith, 0.229*WindowWith)];
        _ImageView=ImageView;
        ImageView.image=DefaultImage_logo;
        [self addSubview:ImageView];
        
        
        lineView=[[UIView alloc]initWithFrame:CGRectMake(0, self.height-1, WindowWith, 1)];
        lineView.backgroundColor=cLineColor;
        [self addSubview:lineView];
        
        
        
//        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(headImageView.left, lineView.bottom+0.026*WindowWith, 209, 11) textColor:cGreenColor textFont:sysFont(11)];
//        lbl.text=@"快来帮我付款吧";
//        _bottomLbl=lbl;
//        [self addSubview:lbl];

        
        
        
        
    }
    return self;
}


-(void)baocun{
    self.selectBlock(SelectSaveBlock);
}


- (void)textViewDidChange:(UITextView *)textView{
    
    
    
    [_editBtn setTitle:@"保存" forState:UIControlStateNormal];
    _editBtn.enabled=YES;
    
    if (_placeholderTextView.text.length>38) {
        _placeholderTextView.text=[_placeholderTextView.text substringToIndex:38];
    }

    if (textView.contentSize.height >0.26*WindowWith)
    {
        //删除最后一行的第一个字符，以便减少一行。
        _placeholderTextView.text = [_placeholderTextView.text substringToIndex:[_placeholderTextView.text length]-1];
        
    }

}



-(void)headTap{
    self.selectBlock(SelectheadImageBlock);
    
}



-(void)hideKeyBord{
    [_placeholderTextView resignFirstResponder];
}



-(void)setDatawith:(CrowdOrderModel *)model{
   
    [_headImageView setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@%@",ConfigManager.ImageUrl,model.infoModel.heed_image_url,smallHeaderImage] placeholderImage:defalutHeadImage];
    NSString *str=[NSString stringWithFormat:@"%@的众筹",model.infoModel.nickname];
    CGSize size=[IHUtility GetSizeByText:str sizeOfFont:15 width:120];
    _nickName.text=str;
    _nickName.size=CGSizeMake(size.width, 17);
    
    str=[NSString stringWithFormat:@"(离结束还剩%@天)",model.diffDay];
    size=[IHUtility GetSizeByText:str sizeOfFont:12 width:200];
    
    NSString *time=[NSString stringWithFormat:@"%@",model.diffDay] ;
    
    NSMutableAttributedString * attributedText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"(离结束还剩%@天)",time] attributes:@{NSFontAttributeName:sysFont(12)}];
    
    [attributedText addAttribute:NSForegroundColorAttributeName value:RGB(232, 121, 117) range:NSMakeRange(6,time.length+1)];

    
    _timeLbl.attributedText=attributedText;
 //   _timeLbl.size=CGSizeMake(size.width, 13);
    
    _timeLbl.frame=CGRectMake(_nickName.right+5, _nickName.top+2, size.width, 13);
    
    CGFloat width=model.infoModel.obtain_money/model.infoModel.total_money*0.704*WindowWith;
    
    _progressView.size=CGSizeMake(width, 7);
    
    
    str=[NSString stringWithFormat:@"已完成%d%%",(int)(model.infoModel.obtain_money/(int)model.infoModel.total_money*100)];
    
    
    size=[IHUtility GetSizeByText:str sizeOfFont:11 width:200];

    NSString *progress=[NSString stringWithFormat:@"%d",(int)(model.infoModel.obtain_money/model.infoModel.total_money*100)];
    
    attributedText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"已完成%@%%",progress] attributes:@{NSFontAttributeName:sysFont(11)}];
    
    [attributedText addAttribute:NSForegroundColorAttributeName value:RGB(232, 121, 117) range:NSMakeRange(3,progress.length+1)];
    _progressLbl.attributedText=attributedText;
    _progressLbl.size=CGSizeMake(size.width, 11);
    
    
   
    
    
    str=[NSString stringWithFormat:@"还差%.2f元",model.infoModel.total_money-model.infoModel.obtain_money];
    size=[IHUtility GetSizeByText:str sizeOfFont:11 width:200];
    
    NSString *chajiaLbl=[NSString stringWithFormat:@"%.2f",model.infoModel.total_money-model.infoModel.obtain_money];
    
    attributedText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"还差%@元",chajiaLbl] attributes:@{NSFontAttributeName:sysFont(11)}];
    
    [attributedText addAttribute:NSForegroundColorAttributeName value:RGB(232, 121, 117) range:NSMakeRange(2,chajiaLbl.length+1)];
    _chajiaLbl.attributedText=attributedText;
    _chajiaLbl.size=CGSizeMake(0.704*WindowWith+_headImageView.right-_progressLbl.right-15, 11);
    
    
    //str=[NSString stringWithFormat:@"已完成%ld%%",model.infoModel.obtain_money/model.infoModel.total_money*100];
    size=[IHUtility GetSizeByText:model.infoModel.activities_titile sizeOfFont:12 width:_ImageView.left-_headImageView.left];
    _titleLbl.text=model.infoModel.activities_titile;
    _titleLbl.size=CGSizeMake(size.width, 12);
    
    
   
    size=[IHUtility GetSizeByText:[NSString stringWithFormat:@"%.2f",model.infoModel.total_money] sizeOfFont:11 width:_ImageView.left-_headImageView.left];
    _priceLbl.text=[NSString stringWithFormat:@"¥%.2f",model.infoModel.total_money];
    _priceLbl.size=CGSizeMake(size.width+10, 11);
    
    
    
    str=[NSString stringWithFormat:@"截止日期:%@",[IHUtility FormatDateByString:model.orderInfoModel.activities_endtime]];
    
     size=[IHUtility GetSizeByText:str sizeOfFont:11 width:_ImageView.left-_headImageView.left];
    
    _jiezhiLbl.text=str;
    _jiezhiLbl.size=CGSizeMake(size.width, 11);
    
    
    [_ImageView setImageAsyncWithURL:model.infoModel.activities_pic placeholderImage:DefaultImage_logo];
 
    
    UIImage *typeImage;
    if (model.infoModel.status==1) {
        typeImage=Image(@"pay_finish.png");
        
        str=[NSString stringWithFormat:@"(完成编号%@)",model.infoModel.random_num];
        size=[IHUtility GetSizeByText:str sizeOfFont:12 width:200];
        
        NSString *time=[NSString stringWithFormat:@"%@",model.infoModel.random_num];
        
        if (time.length>5) {
           time=[NSString stringWithFormat:@"***%@",[model.infoModel.random_num substringFromIndex:time.length-5]];
        }
        
        
        NSMutableAttributedString * attributedText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"(完成编号%@)",time] attributes:@{NSFontAttributeName:sysFont(12)}];
        
        [attributedText addAttribute:NSForegroundColorAttributeName value:RGB(232, 121, 117) range:NSMakeRange(5,time.length)];
        
        
        _timeLbl.attributedText=attributedText;
        //   _timeLbl.size=CGSizeMake(size.width, 13);
        
        _timeLbl.frame=CGRectMake(_nickName.right+5, _nickName.top+2, size.width, 13);

        
        
        
    }else if (model.infoModel.status==2){
        typeImage=Image(@"pay_fail.png");
    }else if (model.infoModel.status==3){
         typeImage=Image(@"pay_refund.png");
    }
    
    _typeImageView.image=typeImage;
    
    
    
    
}






@end




//支付方式  底部弹出


typedef NS_ENUM(NSInteger , MTPayType) {
    AliPayType,     //支付宝支付
    WeiXPayType,    //微信支付
};
@interface ApliayView () {
    UIView *backView;
    UIView *topview;
    UIView *zfbBgView;
    UIView *wxBgView;
    UIButton *GoPay;
    UIButton *zfbBut;
    UIButton *wxBut;
    MTPayType payType;
    UIButton *payButton;
    UILabel *_payMoneyNum;
}
@end

@implementation ApliayView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBA(0, 0, 0, 0);
        self.userInteractionEnabled = YES;
        backView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - kWidth(254), kScreenWidth, kWidth(254))];
        backView.backgroundColor = cLineColor;
        [self addSubview:backView];
        
        topview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(50))];
        topview.backgroundColor = [UIColor whiteColor];
        [backView addSubview:topview];
        
        SMLabel *lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(0, 0, width(topview), 20) textColor:kColor(@"333333") textFont:sysFont(font(17))];
        lbl.text = @"支付方式";
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.center = topview.center;
        [topview addSubview:lbl];
        
        zfbBgView = [[UIView alloc] initWithFrame:CGRectMake(0, maxY(topview)+1, iPhoneWidth, kWidth(74))];
        zfbBgView.backgroundColor = [UIColor whiteColor];
        IHTapGesureRecornizer *tap1=[[IHTapGesureRecornizer alloc]initWithTarget:self action:@selector(selectedPayType:)];
        [zfbBgView addGestureRecognizer:tap1];
        tap1.objectTag = 101;
        [backView addSubview:zfbBgView];
        
        wxBgView = [[UIView alloc] initWithFrame:CGRectMake(0, maxY(zfbBgView)+1, iPhoneWidth, kWidth(74))];
        wxBgView.backgroundColor = [UIColor whiteColor];
        IHTapGesureRecornizer *tap2=[[IHTapGesureRecornizer alloc]initWithTarget:self action:@selector(selectedPayType:)];
        [wxBgView addGestureRecognizer:tap2];
        tap2.objectTag = 102;
        [backView addSubview:wxBgView];
        
        
        _payMoneyNum = [[UILabel alloc] init];
        _payMoneyNum.textColor = kColor(@"d92424");
        _payMoneyNum.backgroundColor = [UIColor whiteColor];
        _payMoneyNum.textAlignment = NSTextAlignmentCenter;
        _payMoneyNum.font = boldFont(font(17));
         [backView addSubview:_payMoneyNum];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(0, wxBgView.bottom + 1, kScreenWidth, kWidth(54));
        button.backgroundColor = [UIColor whiteColor];
        [button setTitle:@"立即支付" forState:UIControlStateNormal];
        button.backgroundColor = kColor(@"05c1b0");
        button.titleLabel.font = sysFont(font(17));
        payButton = button;
        [button addTarget:self action:@selector(alipayCrowd:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:kColor(@"#ffffff") forState:UIControlStateNormal];
        [backView addSubview:button];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeSelf:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired= 1;
        [self addGestureRecognizer:tap];
    }
    return self;
}
- (void)layoutSubviews {
    UIImageView *zfbImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth(12), kWidth(22), kWidth(30), kWidth(30))];
    zfbImageView.image = Image(@"icon_zfb.png");
    [zfbBgView addSubview:zfbImageView];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(maxX(zfbImageView) +kWidth(17), 0, kWidth(130), height(zfbBgView))];
    label1.textColor = kColor(@"#333333");
    label1.text = @"支付宝支付";
    label1.font = sysFont(font(15));
    [zfbBgView addSubview:label1];
    
    
    UIImageView *wxImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth(12), kWidth(22), kWidth(30), kWidth(30))];
    wxImageView.image = Image(@"icon_wx.png");
    [wxBgView addSubview:wxImageView];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(maxX(wxImageView) +kWidth(17),0, kWidth(130), height(wxBgView))];
    label2.textColor = kColor(@"#333333");
    label2.text = @"微信支付";
    label2.font = sysFont(font(15));
    [wxBgView addSubview:label2];
    
    zfbBut = [[UIButton alloc] init];
    zfbBut.frame = CGRectMake(iPhoneWidth - kWidth(23) - kWidth(12), 0, kWidth(23), kWidth(23));
    [zfbBut addTarget:self action:@selector(selectPayType:) forControlEvents:UIControlEventTouchUpInside];
    [zfbBut setImage:[UIImage imageNamed:@"alipay_right.png"] forState:UIControlStateNormal];
    [zfbBut setImage:[UIImage imageNamed:@"alipay_rightSelected.png"] forState:UIControlStateSelected];
    zfbBut.selected = YES;
    payType = AliPayType;
    zfbBut.tag = 10;
    zfbBut.centerY = zfbImageView.centerY;
    [zfbBgView addSubview:zfbBut];
    
    wxBut = [[UIButton alloc] init];
    wxBut.tag = 11;
    wxBut.frame = CGRectMake(iPhoneWidth - kWidth(23) - kWidth(12), 0, kWidth(23), kWidth(23));
    [wxBut addTarget:self action:@selector(selectPayType:) forControlEvents:UIControlEventTouchUpInside];
    [wxBut setImage:[UIImage imageNamed:@"alipay_right.png"] forState:UIControlStateNormal];
    [wxBut setImage:[UIImage imageNamed:@"alipay_rightSelected.png"] forState:UIControlStateSelected];
    wxBut.centerY = wxImageView.centerY;
    [wxBgView addSubview:wxBut];
    
}
- (void) setPlayMoneyNum:(NSString *)titleStr{
    _payMoneyNum.text = titleStr;
    _payMoneyNum.frame = CGRectMake(0, wxBgView.bottom + 1, kScreenWidth - kWidth(113), kWidth(54));
     payButton.frame = CGRectMake(kScreenWidth - kWidth(113), wxBgView.bottom + 1, kWidth(113), kWidth(54));
    payButton.backgroundColor = kColor(@"#29daa2");
}
- (void)selectPayType:(UIButton *)button {
    if(button.tag == 10) {      //支付宝支付
        zfbBut.selected = YES;
        payType = AliPayType;
        wxBut.selected = NO;
    }else {
        zfbBut.selected = NO;
        wxBut.selected = YES;
        payType = WeiXPayType;
    }
}
//选择支付方式
-(void)selectedPayType:(IHTapGesureRecornizer *)tap{
    
    if (tap.objectTag==101) {
        zfbBut.selected = YES;
        payType = AliPayType;
        wxBut.selected = NO;
    }else if (tap.objectTag==102){
        zfbBut.selected = NO;
        wxBut.selected = YES;
        payType = WeiXPayType;
    }
    
}


- (void)alipayCrowd:(UIButton *)button
{
    
    if(payType == WeiXPayType){  //@"微信支付"
        self.selectBlock(ENT_top);
    }
    if (payType == AliPayType){ //@"支付宝支付"
        self.selectBlock(ENT_midden);
    }
    [UIView animateWithDuration:.3 animations:^{
        self.backgroundColor = RGBA(0, 0, 0, 0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.3 animations:^{
            self.top = kScreenHeight;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }];
}
- (void)removeSelf:(UITapGestureRecognizer *)tap
{
    [UIView animateWithDuration:.3 animations:^{
        self.backgroundColor = RGBA(0, 0, 0, 0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.3 animations:^{
            self.top = kScreenHeight;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }];
}
@end


@implementation CrowdFundingShareView
- (id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=RGBA(60, 79, 94, 0.3);
        [self setLayerMasksCornerRadius:5 BorderWidth:0 borderColor:cGrayLightColor];
        self.hidden=YES;
        
        UIView *bkView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0.82*WindowWith, 0.6*WindowWith)];
        bkView.backgroundColor=[UIColor whiteColor];
        bkView.center=self.center;
        [self addSubview:bkView];
        _bkView=bkView;
        
        UITapGestureRecognizer *Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        
        [self addGestureRecognizer:Tap];

     
        
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0.05*WindowWith, 0.05*WindowWith, bkView.width-0.05*WindowWith, 24) textColor:cBlackColor textFont:sysFont(17)];
        lbl.text=@"小伙伴快来助我一臂之力!";
        
        if (WindowWith==320) {
            lbl.font=sysFont(15);
        }
        [bkView addSubview:lbl];
        
        UIAsyncImageView *imageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(lbl.left, 0.04*WindowWith+lbl.bottom, 0.146*WindowWith, 0.146*WindowWith)];
        
        imageView.image=DefaultImage_logo;
        [bkView addSubview:imageView];
        
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+0.026*WindowWith, imageView.top, bkView.width-imageView.right-20, imageView.height) textColor:cBlackColor textFont:sysFont(13)];
        lbl.text=@"2016年第八届国际园林博览会众筹活动";
        lbl.numberOfLines=0;
        if (WindowWith==320) {
            lbl.font=sysFont(12);
        }
        [bkView addSubview:lbl];
        
        
        
        
        _placeholderTextView =[[PlaceholderTextView alloc]initWithFrame:CGRectMake(imageView.left, lbl.bottom+5, bkView.width-imageView.left*2, 0.14*WindowWith)];
        _placeholderTextView.layer.borderColor= cLineColor.CGColor;
        _placeholderTextView.layer.borderWidth=1;
        [_placeholderTextView.layer setCornerRadius:5];
        _placeholderTextView.placeholder=@"给朋友留言...";
        _placeholderTextView.placeholderColor=cLineColor;
         _placeholderTextView.delegate=self;
        _placeholderTextView.placeholderFont=sysFont(13);
        [bkView addSubview:_placeholderTextView];

        
        for (NSInteger i=0; i<2; i++) {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(i*bkView.width/2, _placeholderTextView.bottom+5, bkView.width/2, bkView.height-_placeholderTextView.bottom-5);
            [bkView addSubview:btn];
            btn.titleLabel.font=sysFont(17);
            if (WindowWith==320) {
                 btn.titleLabel.font=sysFont(15);
            }
            if (i==0) {
                [btn setTitle:@"取消" forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
                [btn setTitleColor:RGB(132, 131, 136) forState:UIControlStateNormal];
            }else{
                [btn setTitle:@"发送" forState:UIControlStateNormal];
                [btn setTitleColor:cGreenColor forState:UIControlStateNormal];
            }
            
            
            
            
        }
        
        
        
        
        
        
        //监听键盘的升起和隐藏事件,需要用到通知中心  ****IQKeyboard
//        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];

        //监听升起:UIKeyboardWillShowNotification
        //name:  监听指定通知
        //observer: 当接收到指定通知后,由指定对象
        //selector: 执行对应的方法进行处理
//        [center addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//
//        //监听隐藏:UIKeyboardWillHideNotification
//        [center addObserver:self selector:@selector(keyBoardWillHide) name:UIKeyboardWillHideNotification object:nil];
        
        
        
        
        
    }
    
    
    return self;
    
}






//- (void)keyBoardWillShow:(NSNotification *)notification
//{
//
//
//    //获取键盘的相关属性(包括键盘位置,高度...)
//    NSDictionary *userInfo = notification.userInfo;
//
//    //获取键盘的位置和大小
//    CGRect rect = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue /*将对象转换为CGRect结构体*/];
//
//    //键盘升起的时候
//    [UIView animateWithDuration:0.25 animations:^{
//        self->_bkView.origin=CGPointMake(0, kScreenHeight-rect.size.height-0.6*WindowWith-20);
//        self->_bkView.centerX=self.centerX;
//    }];
//
//
//
//
//}

//- (void)keyBoardWillHide
//{
//
//
//    //键盘隐藏的时候
//    [UIView animateWithDuration:0.25 animations:^{
//
//        self->_bkView.center=self.center;
//        //
//    }];
//
//}
//
//
//






-(void)show{
    [UIView animateWithDuration:0.2 animations:^{
        self.hidden=NO;
        self.alpha=1;
        
    }];
    
    
}

-(void)hide{
    
    [_placeholderTextView resignFirstResponder];
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

@implementation JionCompanyCloud

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = RGBA(0, 0, 0, 0.3);
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(20, 0, WindowWith-40, 324)];
        backView.center = self.center;
        //        _backView= backView;
        backView.layer.cornerRadius = 2.5;
        backView.backgroundColor = [UIColor whiteColor];
        [self addSubview:backView];
        
        SMLabel *detailLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(0, 18, 60, 16) textColor:RGB(6, 193, 174) textFont:sysFont(15)];
        detailLbl.text = @"温馨提示";
        detailLbl.centerX = backView.width / 2.0;
        detailLbl.textAlignment = NSTextAlignmentCenter;
        [backView addSubview:detailLbl];
        
        UIImage *image = Image(@"Line Copy 4.png");
        UIImageView *leftlineImageview=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, image.size.width, 0.5)];
//        leftlineImageview.image=image;
        leftlineImageview.backgroundColor = RGB(229, 229, 232);
        leftlineImageview.right = detailLbl.left - 15;
        leftlineImageview.centerY = detailLbl.centerY;
        [backView addSubview:leftlineImageview];
        
        UIImage *rightImage = Image(@"Line4.png");
        UIImageView *lineRightImageview=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, rightImage.size.width, 0.5)];
//        lineRightImageview.image=rightImage;
        lineRightImageview.backgroundColor = RGB(229, 229, 232);
        lineRightImageview.left = detailLbl.right + 15;
        lineRightImageview.centerY = detailLbl.centerY;
        [backView addSubview:lineRightImageview];
        
        NSString *str = @"      我们尚未开通手机端的企业申请功能，请与我们的客服联系，并将营业执照或组织机构代码证照片、企业标志图片、企业形像图片等发送到客服邮箱，我们将第一时间为将您的企业录入园林云数据库。";
        SMLabel *label = [[SMLabel alloc] initWithFrameWith:CGRectMake(25, detailLbl.bottom + 24 , backView.width - 50, 100) textColor:cGrayLightColor textFont:sysFont(14)];
        label.text = str;
        label.numberOfLines = 0;
        [label sizeToFit];
        
        [backView addSubview:label];
        
        label = [[SMLabel alloc] initWithFrameWith:CGRectMake(34, label.bottom + 11 , backView.width - 59, 15) textColor:RGB(6, 193, 174) textFont:sysFont(14)];
        label.text = @"客服邮箱：2403098195@qq.com";
        [backView addSubview:label];
        
        label = [[SMLabel alloc] initWithFrameWith:CGRectMake(34, label.bottom + 10 , backView.width - 59, 15) textColor:RGB(6, 193, 174) textFont:sysFont(14)];
        label.text = [NSString stringWithFormat: @"客服热线：%@",KTelNum];
        label.userInteractionEnabled = YES;
        [backView addSubview:label];
        
        UITapGestureRecognizer *tapPhone = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(telPhone:)];
        tapPhone.numberOfTapsRequired = 1;
        tapPhone.numberOfTouchesRequired= 1;
        [label addGestureRecognizer:tapPhone];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, label.bottom + 18, 140, 37)];
        button.centerX = backView.width/2.0;
        button.backgroundColor = RGB(6, 193, 174);
        button.layer.cornerRadius = 18;
        [button setTitle:@"我知道了" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = sysFont(14);
        [button addTarget:self action:@selector(referBtn:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:button];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideView:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired= 1;
        [self addGestureRecognizer:tap];
        
        backView.height = button.bottom + 25;
        backView.center = self.center;
        
    }
    
    return self;
}

- (void)referBtn:(UIButton *)button
{
    [UIView animateWithDuration:1 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)hideView:(UITapGestureRecognizer *)tap
{
    
    [UIView animateWithDuration:1 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}
- (void)telPhone:(UITapGestureRecognizer *)tap
{
    self.selectBlock(SelectBtnBlock);
}
@end

@implementation BombBoxView

-(id)initWithFrame:(CGRect)frame context:(NSString *)context title:(NSString *)title buttonArr:(NSArray *)buttonArr
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = RGBA(0, 0, 0, 0.3);
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(20, 0, WindowWith-40, 240)];
        backView.center = self.center;
        //        _backView= backView;
        backView.layer.cornerRadius =2.5;
        backView.backgroundColor = [UIColor whiteColor];
        [self addSubview:backView];
        
        SMLabel *detailLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(0, 18, 60, 16) textColor:RGB(6, 193, 174) textFont:sysFont(15)];
        detailLbl.text = title;
        detailLbl.centerX = backView.width / 2.0;
        detailLbl.textAlignment = NSTextAlignmentCenter;
        [backView addSubview:detailLbl];
        
        UIImage *image = Image(@"Line Copy 4.png");
        UIImageView *leftlineImageview=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, image.size.width, 0.5)];
        //        leftlineImageview.image=image;
        leftlineImageview.backgroundColor = RGB(229, 229, 232);
        leftlineImageview.right = detailLbl.left - 15;
        leftlineImageview.centerY = detailLbl.centerY;
        [backView addSubview:leftlineImageview];
        
        UIImage *rightImage = Image(@"Line4.png");
        UIImageView *lineRightImageview=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, rightImage.size.width, 0.5)];
        //        lineRightImageview.image=rightImage;
        lineRightImageview.backgroundColor = RGB(229, 229, 232);
        lineRightImageview.left = detailLbl.right + 15;
        lineRightImageview.centerY = detailLbl.centerY;
        [backView addSubview:lineRightImageview];
        
        NSString *str = context;
        SMLabel *label = [[SMLabel alloc] initWithFrameWith:CGRectMake(30, detailLbl.bottom + 30 , backView.width - 60, 100) textColor:cGrayLightColor textFont:sysFont(14)];
        label.text = str;
        label.numberOfLines = 0;
        [label sizeToFit];
        
        [backView addSubview:label];
        
        for (int i=0; i<buttonArr.count; i++) {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(((backView.width -72)/2.0 +24)*i + 24, label.bottom + 30, (backView.width -72)/2.0, 37)];
                button.layer.cornerRadius = 18;
            button.tag = 20+i;
            if (buttonArr.count==1) {
                button.centerX = backView.width/2.0;
                button.backgroundColor = RGB(6, 193, 174);
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }else {
                if (i==0) {
                    [button setTitleColor:cGrayLightColor forState:UIControlStateNormal];
                    button.layer.borderColor = cGrayLightColor.CGColor;
                    button.layer.borderWidth = 1.0;
                }else {
                    button.backgroundColor = RGB(6, 193, 174);
                    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                }
            }
            [button setTitle:buttonArr[i] forState:UIControlStateNormal];
            button.titleLabel.font = sysFont(14);
            [button addTarget:self action:@selector(referBtn:) forControlEvents:UIControlEventTouchUpInside];
            [backView addSubview:button];

        }
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideView:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired= 1;
        [self addGestureRecognizer:tap];


        backView.height = label.bottom + 93;
        backView.center = self.center;
        
    }
    
    return self;
}

//没有按钮弹框
-(id)initWithFrame:(CGRect)frame context:(NSString *)context title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = RGBA(0, 0, 0, 0.1);
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(37.5, 0, WindowWith-75, 100)];
        backView.center = self.center;
        //        _backView= backView;
        backView.layer.cornerRadius = 5;
        backView.backgroundColor = RGBA(255, 255, 255, 0.9);
        [self addSubview:backView];
        
        SMLabel *detailLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(0, 20, backView.width - 40, 19) textColor:cBlackColor textFont:boldFont(18)];
        detailLbl.text = title;
        detailLbl.centerX = backView.width / 2.0;
        detailLbl.textAlignment = NSTextAlignmentCenter;
        [backView addSubview:detailLbl];
        
        NSString *str = context;
        SMLabel *label = [[SMLabel alloc] initWithFrameWith:CGRectMake(30, detailLbl.bottom + 12.5 , backView.width - 60, 100) textColor:cBlackColor textFont:sysFont(16)];
        label.text = str;
        label.numberOfLines = 0;
        [label sizeToFit];
        [backView addSubview:label];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideView:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired= 1;
        [self addGestureRecognizer:tap];
        
        backView.height = label.bottom + 28;
        backView.center = self.center;
        
    }
    
    return self;
}
- (void)referBtn:(UIButton *)button
{
    if (button.tag == 20) {
        [UIView animateWithDuration:.5 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }else {
        self.selectBlock(SelectBtnBlock);
        
        [UIView animateWithDuration:.5 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }

}

- (void)hideView:(UITapGestureRecognizer *)tap
{
    
    [UIView animateWithDuration:.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}
@end

@implementation EmptyPromptView

- (id)initWithFrame:(CGRect)frame context:(NSString *)context
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImage *img=Image(@"kuku.png");
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0.26*WindowWith, img.size.width, img.size.height)];
        imageView.image = img;
        imageView.centerX=self.centerX;
        _imageView = imageView;
        [self addSubview:imageView];
        
        
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, imageView.bottom+20, WindowWith, 17) textColor:cGrayLightColor textFont:sysFont(17)];
        lbl.centerX=imageView.centerX;
        lbl.textAlignment=NSTextAlignmentCenter;
        lbl.text=context;
        [self addSubview:lbl];
    }
    
    return self;
    
}
- (void)setImagNameStr:(NSString *)imagNameStr {
    _imageView.image = [UIImage imageNamed:imagNameStr];
}
@end



@implementation CertificationNoticeView

- (id)initWithFrame:(CGRect)frame title:(NSString *)title imageName:(NSString *)imageName content:(NSString *)content
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = RGBA(0, 0, 0, 0.3);
        
        UIView *backV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 285, 372)];
        backV.backgroundColor = [UIColor whiteColor];
        backV.layer.cornerRadius = 5.0;
        [self addSubview:backV];
        
        SMLabel *lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(10, 30, backV.width - 20, 20) textColor:cGreenLightColor textFont:sysFont(17)];
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.text = title;
        [backV addSubview:lbl];
        
        UIImage *img = Image(imageName);
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, lbl.bottom + 15, img.size.width, img.size.height)];
        imageV.image = img;
        imageV.layer.cornerRadius = 5.0;
        imageV.layer.borderColor = cGrayLightColor.CGColor;
        imageV.layer.borderWidth = 1.0;
        imageV.centerX = backV.width/2.0;
        [backV addSubview:imageV];
        
        lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(25, imageV.bottom + 20, backV.width - 50, 20) textColor:RGB(81, 80, 84) textFont:sysFont(13)];
        lbl.numberOfLines = 0;
        lbl.text = content;
        [lbl sizeToFit];
        [backV addSubview:lbl];
        
        backV.height = lbl.bottom + 35;
        backV.center = self.center;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideView:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired= 1;
        [self addGestureRecognizer:tap];
    }
    
    return self;
}
- (void)hideView:(UITapGestureRecognizer *)tap
{
    
    [UIView animateWithDuration:1 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

@end

@implementation PositionRequirementView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor= [UIColor whiteColor];
        self.layer.cornerRadius = 3.0;
        
        SMLabel *lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(10, 10, self.width-20, 20) textColor:cGreenColor textFont:sysFont(15)];
        lbl.text = @"园林总经理";
        _positionLbl = lbl;
        [self addSubview:lbl];
        
        CGSize size= [IHUtility GetSizeByText:@"￥5k－6k" sizeOfFont:13 width:100];
        lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(10, lbl.bottom + 5, size.width, 15) textColor:RGB(230, 129, 129) textFont:sysFont(13)];
        lbl.text = @"￥5k－6k";
        _salayLbl = lbl;
        [self addSubview:lbl];
        
        UIImage *img = Image(@"Job_adress.png");
        UIImageView *adressImageV = [[UIImageView alloc] initWithFrame:CGRectMake(lbl.right + 10, lbl.top, img.size.width, img.size.height)];
        adressImageV.image = img;
        adressImageV.centerY = lbl.centerY;
        _adressImageV = adressImageV;
        [self addSubview:adressImageV];
        
        size= [IHUtility GetSizeByText:@"长沙" sizeOfFont:13 width:100];
        lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(adressImageV.right+2, lbl.top, size.width, 15) textColor:cGrayLightColor textFont:sysFont(13)];
        lbl.text = @"长沙";
        _adressLbl = lbl;
        [self addSubview:lbl];
        
        img = Image(@"Job_experience.png");
        UIImageView *JYImageV = [[UIImageView alloc] initWithFrame:CGRectMake(lbl.right + 10, lbl.top, img.size.width, img.size.height)];
        JYImageV.image = img;
        JYImageV.centerY = lbl.centerY;
        _JYImageV = JYImageV;
        [self addSubview:JYImageV];
        
        size= [IHUtility GetSizeByText:@"经验不限" sizeOfFont:13 width:100];
        lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(JYImageV.right+2, lbl.top, size.width, 15) textColor:cGrayLightColor textFont:sysFont(13)];
        lbl.text = @"经验不限";
        _expLbl = lbl;
        [self addSubview:lbl];
        
        img = Image(@"Job_academic.png");
        UIImageView *XLImageV = [[UIImageView alloc] initWithFrame:CGRectMake(lbl.right + 10, lbl.top, img.size.width, img.size.height)];
        XLImageV.image = img;
        XLImageV.centerY = lbl.centerY;
        _XLImageV = XLImageV;
        [self addSubview:XLImageV];
        
        size= [IHUtility GetSizeByText:@"本科" sizeOfFont:13 width:100];
        lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(XLImageV.right+2, lbl.top, size.width, 15) textColor:cGrayLightColor textFont:sysFont(13)];
        lbl.text = @"本科";
        _studyLbl = lbl;
        [self addSubview:lbl];
        
        UIAsyncImageView *hreardImg = [[UIAsyncImageView alloc] initWithFrame:CGRectMake(10, lbl.bottom + 22, 72, 72)];
        hreardImg.image= defalutHeadImage;
        hreardImg.layer.cornerRadius = 36;
        _heardImg = hreardImg;
        [self addSubview:hreardImg];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, hreardImg.top, 80, 22)];
        btn.right= self.width - 12;
        [btn setTitle:@"共11个职位" forState:UIControlStateNormal];
        [btn setTitleColor:RGB(242, 167, 58) forState:UIControlStateNormal];
        self.button = btn;
        btn.titleLabel.font = sysFont(13);
        btn.layer.borderWidth = 1.0;
        btn.layer.borderColor = RGB(242, 167, 58).CGColor;
        btn.layer.cornerRadius = 3.0;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(hreardImg.right+8, hreardImg.top + 17, btn.left - hreardImg.right -16, 18.5) textColor:cGrayLightColor textFont:sysFont(14)];
        lbl.text = @"李开心";
        _companyLbl = lbl;
        [self addSubview:lbl];
        
        lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(hreardImg.right+8, lbl.bottom + 5, self.width - hreardImg.right -16, 16.5) textColor:cGrayLightColor textFont:sysFont(14)];
        lbl.text = @"总经理  |  开心农场  |  苗木种植";
        _infoLbl = lbl;
        [self addSubview:lbl];
        
        UIView *linV = [[UIView alloc] initWithFrame:CGRectMake(0, hreardImg.bottom+7, self.width, 0.6)];
        linV.backgroundColor= cLineColor;
        [self addSubview:linV];
        
        UIView *companyView = [[UIView alloc] initWithFrame:CGRectMake(0, linV.bottom, self.width, 44)];
        companyView.userInteractionEnabled = YES;
        [self addSubview:companyView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCompanyHome:)];
        tap.numberOfTapsRequired= 1.0;
        tap.numberOfTouchesRequired= 1;
        [companyView addGestureRecognizer:tap];
        
        img = Image(@"Job_companyHome.png");
        UIImageView *companyImageV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, img.size.width, img.size.height)];
        companyImageV.image = img;
        companyImageV.centerY = companyView.height/2.0;
        [companyView addSubview:companyImageV];
        
        lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(companyImageV.right+ 7, 0, 60, 15) textColor:cGrayLightColor textFont:sysFont(13)];
        lbl.text = @"公司主页";
        lbl.centerY = companyView.height/2.0;
        [companyView addSubview:lbl];

        img = Image(@"iconfont-fanhui.png");
        UIImageView *rightImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
        rightImageV.image = img;
        rightImageV.centerY = companyView.height/2.0;
        rightImageV.right = companyView.width - 12;
        rightImageV.transform= CGAffineTransformMakeRotation(M_PI);
        [companyView addSubview:rightImageV];
        
        self.height= companyView.bottom;
    }
    
    return self;
}

- (void)btnAction:(UIButton *)button
{
    self.selectBlock(SelectBtnBlock);
}

- (void)tapCompanyHome:(UITapGestureRecognizer *)tao
{
    self.selectBlock(SelectMoreBlock);
}
- (void)setCellDate:(PositionListModel *)model
{
    _positionLbl.text = model.job_name;
    _salayLbl.text = [NSString stringWithFormat:@"￥%@",model.salary];
    if ([model.salary isEqualToString:@""]) {
        _salayLbl.text = @"面议";
    }
    
    CGSize size= [IHUtility GetSizeByText:_salayLbl.text sizeOfFont:13 width:100];
    _salayLbl.width = size.width;
    
    _adressImageV.left = _salayLbl.right + 10;
    _adressLbl.left = _adressImageV.right + 2;

    _adressLbl.text = model.work_city;
    if ([model.work_city isEqualToString:@""]) {
        _adressLbl.text = @"不限";
    }
    
    size= [IHUtility GetSizeByText:_adressLbl.text sizeOfFont:13 width:100];
    _adressLbl.width = size.width;
    
    _JYImageV.left = _adressLbl.right + 10;
    _expLbl.left = _JYImageV.right + 2;

    _expLbl.text = model.experience;
    if ([model.experience isEqualToString:@""]) {
        _expLbl.text = @"不限";
    }
    size= [IHUtility GetSizeByText:_expLbl.text sizeOfFont:13 width:100];
    _expLbl.width = size.width;
    
    _XLImageV.left = _expLbl.right + 10;
    _studyLbl.left = _XLImageV.right + 2;

    _studyLbl.text = model.edu_require;
    if ([model.edu_require isEqualToString:@""]) {
        _studyLbl.text = @"不限";
    }
    size= [IHUtility GetSizeByText:_studyLbl.text sizeOfFont:13 width:100];
    _studyLbl.width = size.width;

    
    [_heardImg setImageAsyncWithURL:model.heed_image_url placeholderImage:defalutHeadImage];
    
    NSArray *array = @[model.position,model.company_name,model.i_name];
    NSString *infoStr;
    for (NSString *str in array) {
        if (str.length >0) {
            if (infoStr.length>0) {
                infoStr = [NSString stringWithFormat:@"%@  |  %@",infoStr,str];
            }else {
                infoStr = str;
            }
        }
    }
    _infoLbl.text = infoStr;
    
    _companyLbl.text = model.nickname;
    
    NSString *str = [NSString stringWithFormat:@"共%@个职位",model.jobNum];
    [self.button setTitle:str forState:UIControlStateNormal];
    
}
@end

@implementation ContentView

- (id)initWithFrame:(CGRect)frame title:(NSString *)title content:(NSString *)content btnHidden:(BOOL)btnHidden
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 3.0;
        self.clipsToBounds = YES;
        
        SMLabel *lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(10, 10, self.width-20, 20) textColor:cGreenColor textFont:sysFont(15)];
        lbl.text = title;
        [self addSubview:lbl];
        
        CGSize size= [IHUtility GetSizeByText:content sizeOfFont:13 width:self.width-20];
        _size = size;
        lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(10, lbl.bottom+5, self.width-20, 120) textColor:cGrayLightColor textFont:sysFont(13)];
        lbl.text = content;
        lbl.numberOfLines = 0;
        _lbl = lbl;
        
        if (btnHidden) {
            lbl.height= size.height;
        }
        [self addSubview:lbl];
        
        UIView *linV = [[UIView alloc] initWithFrame:CGRectMake(0, lbl.bottom+8, self.width, 1)];
        linV.backgroundColor= cLineColor;
        _lineView =linV;
        [self addSubview:linV];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, linV.bottom, self.width, 44)];
        btn.right= self.width - 12;
        _btn = btn;
        [btn setTitle:@"显示全部" forState:UIControlStateNormal];
        [btn setTitle:@"收起" forState:UIControlStateSelected];
        [btn setTitleColor:cGreenColor forState:UIControlStateNormal];
        btn.titleLabel.font = sysFont(15);
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];

        if (btnHidden) {
            self.height= linV.top;
        }
    }
    
    return self;
}
- (void)btnAction:(UIButton *)button
{
    button.selected = !button.selected;
    
    if (button.selected) {
        _lbl.height = _size.height;
    }else{
        _lbl.height = 120;
    }
    _lineView.top = _lbl.bottom + 8;
    _btn.top = _lineView.bottom;
    self.height=_btn.bottom;
    
    self.selectBlock(SelectBtnBlock);
}

@end

@implementation SelectedView

- (id)initWithFrame:(CGRect)frame array:(NSArray *)array imageArr:(NSArray *)imageArr rectY:(CGFloat)y rectX:(CGFloat)x width:(CGFloat)width;
{
    self= [super initWithFrame:frame];
    if (self) {
         UIWindow * window = [UIApplication sharedApplication].keyWindow;
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        self.tag = 222;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenView)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:tap];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, 44*array.count+10)];
        imageView.image = Image(@"Job_selectTitle.png");
        imageView.userInteractionEnabled = YES;
        self.imageView= imageView;
        [self addSubview:imageView];
        
        for (int i= 0; i<array.count; i++) {
            UIButton *btn = [[UIButton  alloc] initWithFrame:CGRectMake(0, 44*i+10, width, 44)];

            [btn setTitle:array[i] forState:UIControlStateNormal];

            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
            UIImage *img = Image(imageArr[i]);
            [btn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
            btn.titleEdgeInsets=UIEdgeInsetsMake(0, 8, 0, 0);

            [btn addTarget:self action:@selector(selectedBtn:) forControlEvents:UIControlEventTouchUpInside];
            btn.titleLabel.font = sysFont(15);
            btn.tag = 10 +i;
            [imageView addSubview:btn];
            
            UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(3, btn.bottom, imageView.width-6, 0.5)];
            lineView.backgroundColor=RGBA(255, 255, 255, 0.7);
            [imageView addSubview:lineView];
            
        }
        
        [window addSubview:self];
        self.alpha=0;
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha=1;
        }];
        
    }
    
    return self;
    
}
- (void)selectedBtn:(UIButton *)button
{
    [self hiddenView];
    self.selectBlock(button.tag);

}

-(void)hiddenView{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    
    UIView *v=[window viewWithTag:222];
    v.alpha=1;
    [UIView animateWithDuration:0.2 animations:^{
        v.alpha=0;
    } completion:^(BOOL finished) {
        [v removeFromSuperview];
    }];
}
@end





@implementation CurriculumVitaeView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        
        self.backgroundColor=[UIColor whiteColor];
        
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(11, 6.5, 108, 17) textColor:cGreenColor textFont:sysFont(15)];
        lbl.text=@"苗圃主管";
        _nickLbl=lbl;
        [self addSubview:lbl];
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.left, lbl.bottom+10, 40, 15) textColor:cGreenColor textFont:sysFont(12)];
        lbl.text=@"柯蓝";
        _positionLbl=lbl;
        [self addSubview:lbl];
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.right+20, lbl.top+3, 120, 12) textColor:cGrayLightColor textFont:sysFont(12)];
        lbl.text=@"待业－正在找工作";
        _statusLbl=lbl;
        [self addSubview:lbl];
        
        UIButton *adressBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *img=Image(@"Job_adress.png");
        [adressBtn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
        _adressBtn=adressBtn;
        [adressBtn setTitle:@"长沙" forState:UIControlStateNormal];
        [adressBtn setTitleColor:cGrayLightColor forState:UIControlStateNormal];
        adressBtn.titleLabel.font=sysFont(13);
        adressBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
        adressBtn.frame=CGRectMake(11, lbl.bottom+10, 41, img.size.height);
        [self addSubview:adressBtn];
        
        
        UIButton *experienceBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        img=Image(@"Job_experience.png");
        [experienceBtn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
        _experienceBtn=experienceBtn;
        [experienceBtn setTitle:@"5年" forState:UIControlStateNormal];
        [experienceBtn setTitleColor:cGrayLightColor forState:UIControlStateNormal];
        experienceBtn.titleLabel.font=sysFont(13);
        experienceBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
        experienceBtn.frame=CGRectMake(11+adressBtn.right, adressBtn.top, 41, img.size.height);
        [self addSubview:experienceBtn];
        
        
        
        UIButton *academicBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        img=Image(@"Job_academic.png");
        [academicBtn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
        [academicBtn setTitle:@"本科" forState:UIControlStateNormal];
        [academicBtn setTitleColor:cGrayLightColor forState:UIControlStateNormal];
        academicBtn.titleLabel.font=sysFont(13);
        _academicBtn=academicBtn;
        academicBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
        academicBtn.frame=CGRectMake(11+experienceBtn.right, adressBtn.top, 50, 13);
        [self addSubview:academicBtn];
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(11, adressBtn.bottom+10, 115, 12) textColor:cGrayLightColor textFont:sysFont(12)];
        lbl.text=@"期望薪资  ￥8k－10k";
        _salaryLbl=lbl;
        [self addSubview:lbl];
        
        UIAsyncImageView *headImageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(self.width-10-72, 10, 72, 72)];
        [headImageView setLayerMasksCornerRadius:36 BorderWidth:0 borderColor:cGreenColor];
        _headImageView=headImageView;
        headImageView.image=defalutHeadImage;
        [self addSubview:headImageView];

        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(adressBtn.left, lbl.bottom+13, WindowWith-10-adressBtn.left*2, 1)];
        lineView.backgroundColor=cBgColor;
        [self addSubview:lineView];
        
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lineView.left, lineView.bottom+7, lineView.width, 12) textColor:cBlackColor textFont:sysFont(12)];
        lbl.text=@"我没问题的！";
        _youshiLbl=lbl;
        [self addSubview:lbl];
        
        
        
        
    
    }
    
    
    return self;
}

-(CGFloat)setDataWithModel:(jianliModel *)model{
    
    CGSize size=[IHUtility GetSizeByText:model.job_name sizeOfFont:15 width:self.width-_headImageView.width-30];
    
    _positionLbl.text=model.job_name;
    _positionLbl.size=CGSizeMake(size.width, 15);
    
    size=[IHUtility GetSizeByText:model.nickname sizeOfFont:15 width:100];
    _nickLbl.text=model.nickname;
    _nickLbl.size=CGSizeMake(size.width, 16);
    
    if ([model.workoff_status isEqualToString:@"1"]) {
        _statusLbl.text=@"待业－正在找工作";
    }else{
        _statusLbl.text=@"在职－考虑换工作";
    }
    
    _statusLbl.origin=CGPointMake(_positionLbl.right+0.05*WindowWith, _positionLbl.top+3);
    if ([model.job_name isEqualToString:@""]) {
         _statusLbl.origin=CGPointMake(_positionLbl.left, _positionLbl.top+3);
    }
    
    [_headImageView setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@%@",ConfigManager.ImageUrl,model.heed_image_url,smallHeaderImage] placeholderImage:defalutHeadImage];
    
     UIImage *img=Image(@"Job_adress.png");
    size=[IHUtility GetSizeByText:model.work_city sizeOfFont:13 width:100];
    [_adressBtn setTitle:model.work_city forState:UIControlStateNormal];
    _adressBtn.size=CGSizeMake(size.width+5+img.size.width, img.size.height);
    
    
    img=Image(@"Job_experience.png");
    size=[IHUtility GetSizeByText:model.year_of_work sizeOfFont:13 width:100];
    [_experienceBtn setTitle:model.year_of_work forState:UIControlStateNormal];
    _experienceBtn.frame=CGRectMake(_adressBtn.right+11, _adressBtn.top, size.width+5+img.size.width, img.size.height);
    
   
    img=Image(@"Job_academic.png");
    size=[IHUtility GetSizeByText:model.highest_edu sizeOfFont:13 width:100];
    [_academicBtn setTitle:model.highest_edu forState:UIControlStateNormal];
    _academicBtn.frame=CGRectMake(_experienceBtn.right+11, _adressBtn.top, size.width+5+img.size.width, img.size.height);

     size=[IHUtility GetSizeByText:[NSString stringWithFormat:@"期望薪资  %@",model.salary] sizeOfFont:12 width:200];
    
    _salaryLbl.text=[NSString stringWithFormat:@"期望薪资  %@",model.salary];
    _salaryLbl.size=CGSizeMake(size.width, 12);
    
    
    size=[IHUtility GetSizeByText:model.advantage sizeOfFont:12 width:WindowWith-10-_adressBtn.left*2];
    
    _youshiLbl.text=model.advantage;
    _youshiLbl.size=CGSizeMake(size.width, size.height);
    
    CGFloat hight=_youshiLbl.bottom+10;
    return hight;
}



@end

@implementation ButtonTypesetView

- (id)initWithFrame:(CGRect)frame dataArr:(NSArray *)dataArr title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        SMLabel *lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(12, 0, 62, 20) textColor:cBlackColor textFont:boldFont(14)];
        lbl.text =title;
        self.titleLabel = lbl;
        [self addSubview:lbl];
        
        //根据数组循环创建热门搜索的按钮

        CGFloat w = 0;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
        CGFloat h = lbl.bottom + 8;//用来控制button距离父视图的高
        for (int i = 0; i < dataArr.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.tag = 100 + i;
            [button addTarget:self action:@selector(handleClick:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitleColor:cBlackColor forState:UIControlStateNormal];
            button.titleLabel.font = sysFont(12);
            button.layer.cornerRadius = 3;
            button.layer.borderWidth = 0.5;
            button.layer.borderColor = cGrayLightColor.CGColor;
            //根据计算文字的大小
            
            NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
            CGFloat length = [dataArr[i] boundingRectWithSize:CGSizeMake(WindowWith, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
            //为button赋值
            [button setTitle:dataArr[i] forState:UIControlStateNormal];
            //设置button的frame
            button.frame = CGRectMake(15 + w, h, length + 24 , 25);
            //当button的位置超出屏幕边缘时换行 320 只是button所在父视图的宽度
            if(15 + w + length + 24 > self.width){
                w = 0; //换行时将w置为0
                h = h + button.frame.size.height + 15;//距离父视图也变化
                button.frame = CGRectMake(15 + w, h, length + 24, 25);//重设button的frame
            }
            w = button.frame.size.width + button.frame.origin.x;
            [self addSubview:button];
        }

        self.height = h + 25 + 15;//试图高度为按钮最后一排的top 加上最后一排按钮的高度以及最后空余高度
    }
    
    return self;
}
//热门搜索点击事件
- (void)handleClick:(UIButton *)btn{
    NSLog(@"%ld",btn.tag);
    self.selectBlock(btn.tag - 100);
}
@end




@implementation NurseryLabelView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *arr=@[@"装车价：￥40",@"数量：10000株",@"高度：100cm",@"冠幅：100cm",@"胸径：10cm",@"分枝点：10cm"];
        int y=0;
        for (NSInteger i=0; i<arr.count; i++) {
            if (i%2==0) {
                  SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, y, self.width/2-20, 12) textColor:cGrayLightColor textFont:sysFont(12)];
               
                lbl.text=arr[i];
                [self addSubview:lbl];
                if (i==0) {
                    lbl.textColor=RGB(227, 124, 113);
                }
                lbl.tag=1000+i;
                lbl.hidden=YES;
                
            }else{
                  SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(self.width/2+20, y, self.width/2-20, 12) textColor:cGrayLightColor textFont:sysFont(12)];
                 lbl.text=arr[i];
                 y=lbl.top+12+20;
                 [self addSubview:lbl];
                if (i==1) {
                    lbl.textColor=cGreenColor;
                }
                 lbl.tag=1000+i;
                lbl.hidden=YES;
            }
          
            
            
            
            
            
        }
        
        
        
        
        
    }
    
    
    return self;
}


-(CGFloat)setDataWithArr:(NSArray *)arr{
    
    NSInteger count=6;
    if (arr.count<6) {
        count=arr.count;
    }
    CGFloat hight=0;
    for (NSInteger i=0; i<count; i++) {
        SMLabel *lbl=[self viewWithTag:1000+i];
        lbl.text=arr[i];
        lbl.hidden=NO;
        if (i==count-1) {
            
            
            hight=lbl.bottom;
            
        }
        
        
        
       
    }
    
    if (count<6) {
        
        for (NSInteger i=count; i<6; i++) {
             SMLabel *lbl=[self viewWithTag:1000+i];
            lbl.hidden=YES;
        }

    }
    
    
    
    return hight;
    
    
}




@end

@implementation WeatherCellView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        SMLabel *lbl = [SMLabel new];
        lbl.textColor = [UIColor whiteColor];
        lbl.text = @"今天";
        lbl.font = sysFont(13);
        _lbl = lbl;
        [self addSubview:lbl];
        lbl.sd_layout.centerXIs(self.width/2.0).topSpaceToView(self,0).heightIs(18.5);
        [lbl setSingleLineAutoResizeWithMaxWidth:60];
        
        SMLabel *timelbl = [SMLabel new];
        timelbl.textColor = [UIColor whiteColor];
        timelbl.text = @"11/10";
        timelbl.font = sysFont(12);
        _timelbl = timelbl;
        [self addSubview:timelbl];
        timelbl.sd_layout.centerXIs(self.width/2.0).topSpaceToView(lbl,0).heightIs(18.5);
        [timelbl setSingleLineAutoResizeWithMaxWidth:60];
        
        UIAsyncImageView *weatherImg = [UIAsyncImageView new];
        _weatherImg = weatherImg;
        [self addSubview:weatherImg];
        weatherImg.sd_layout.centerXIs(self.width/2.0).topSpaceToView(timelbl,0).heightIs(22).widthIs(22);
        
        SMLabel *weatherlbl = [SMLabel new];
        weatherlbl.textColor = [UIColor whiteColor];
        weatherlbl.text = @"多云";
        _weatherlbl = weatherlbl;
        weatherlbl.font = sysFont(12);
        [self addSubview:weatherlbl];
        weatherlbl.sd_layout.centerXIs(self.width/2.0).topSpaceToView(weatherImg,0).heightIs(18.5);
        [weatherlbl setSingleLineAutoResizeWithMaxWidth:60];
        
        SMLabel *templbl = [SMLabel new];
        templbl.textColor = [UIColor whiteColor];
        templbl.text = @"7°- 14°";
        templbl.font = sysFont(12);
        _templbl = templbl;
        [self addSubview:templbl];
        templbl.sd_layout.centerXEqualToView(weatherlbl).topSpaceToView(weatherlbl,0).heightIs(18.5);
        [templbl setSingleLineAutoResizeWithMaxWidth:60];
    }
    return self;
}
- (void)setData:(NSDictionary *)dic
{
    NSString *timeStr = [IHUtility getTimeStringFromString:dic[@"date"]];

    NSDateFormatter *dateFormat=[[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *date=[dateFormat dateFromString:timeStr];
    
    NSString *dayStr = [date compareIfTodayWithDate];
    _lbl.text = dayStr;
    
    _timelbl.text = [IHUtility FormatMonthAndDayByString3:timeStr];
    
    NSDictionary *dayDic;
    if ([IHUtility isWhetherDayOrNightWithNow]) {
        dayDic= dic[@"day"];
    }else{
        dayDic= dic[@"night"];
    }
    
    //获取天气图片
    NSDictionary *weatherImgDic = [ConfigManager getWeatherImage];
    
    UIImage *image;
    for (NSString *key in [weatherImgDic allKeys]) {
        if ([dayDic[@"wthr"] rangeOfString:key].location != NSNotFound) {
            NSDictionary *imgDic = [weatherImgDic objectForKey:key];
            if ([IHUtility isWhetherDayOrNightWithNow]) {
                image = Image([imgDic objectForKey:@"smallday"]);
            }else{
                image = Image([imgDic objectForKey:@"smallnight"]);
            }
            _weatherImg.image = image;

        }
    }
    

    _weatherlbl.text = dayDic[@"wthr"];
    
    _templbl.text = [NSString stringWithFormat:@"%@°-%@°",dic[@"low"],dic[@"high"]];
    
    /*判断时间是否为昨天 如果为昨天显示就变灰   */
    
    NSDate * todaydate = [NSDate date];
    //设置时间间隔（秒）（这个我是计算出来的，不知道有没有简便的方法 )
    NSTimeInterval time = 24 * 60 * 60;//一天的秒数
    NSDate * lastYear = [todaydate dateByAddingTimeInterval:-time];
    //转化为字符串
    NSString * startDate = [dateFormat stringFromDate:lastYear];
    
    if ([_timelbl.text isEqualToString:[IHUtility FormatMonthAndDayByString3:startDate]]) {
        _lbl.text = @"昨天";
        _lbl.alpha = 0.7;
        _timelbl.alpha = 0.6;
        _weatherImg.alpha = 0.6;
        _weatherlbl.alpha = 0.7;
        _templbl.alpha = 0.6;
    }
}

@end



