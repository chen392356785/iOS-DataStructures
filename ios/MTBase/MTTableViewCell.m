//
//  MTTableViewCell.m
//  MiaoTuProject
//
//  Created by Mac on 16/3/10.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTTableViewCell.h"
#import "CustomView+CustomCategory2.h"

@implementation MTTableViewCell


@end

@implementation MapUserListTableViewCell

@synthesize model;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _headView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(WindowWith*0.02, 15, WindowWith*0.128, WindowWith*0.128)];
        [_headView setLayerMasksCornerRadius:_headView.width/2 BorderWidth:0   borderColor:[UIColor clearColor]];
       
        [self.contentView addSubview:_headView];
        
        
       UIImage *img=Image(@"reguser.png");
        UIImageView *idImageView=[[UIImageView alloc]initWithFrame:CGRectMake(_headView.left+_headView.width-img.size.width,_headView.top+_headView.height-img.size.height, img.size.width, img.size.height)];
        _idImageView=idImageView;
        idImageView.image=img;
        [self.contentView addSubview:idImageView];

        

        _lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(_headView.right+23, _headView.top-5, 60, 16) textColor: cBlackColor textFont:sysFont(17)];
      
        [self.contentView addSubview:_lbl];
        
        _lbl1=[[SMLabel alloc]initWithFrameWith:CGRectMake(_headView.right+23, _lbl.bottom+4, 177, 13) textColor:cBlackColor textFont:sysFont(12)];
       
        [self.contentView addSubview:_lbl1];
        
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 79.3, WindowWith, 0.7)];
        lineView.backgroundColor=cLineColor;
        [self.contentView addSubview:lineView];
        
        UIImage *toImg=Image(@"MT_to.png");
        UIImageView *toImageView=[[UIImageView alloc]initWithImage:toImg];
        toImageView.frame=CGRectMake(WindowWith*0.93, 30, toImg.size.width, toImg.size.height);
        [self.contentView addSubview:toImageView];
        
        
        UIImage *companyImg=Image(@"MT_company.png");
        
        CGSize companySize=[IHUtility GetSizeByText:@"苗木基地" sizeOfFont:12 width:100];
        //公司类型
        _companyBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        _companyBtn.frame=CGRectMake(_lbl1.left, _lbl1.bottom+10,  companyImg.size.width+companySize.width+5, 20);
       
        _companyBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
       
        [_companyBtn setTitleColor:RGB(109, 130, 138) forState:UIControlStateNormal];
        
        _companyBtn.titleLabel.font=sysFont(12);
        _companyBtn.enabled=NO;
        [self.contentView addSubview:_companyBtn];
        
        
       // UIImage *distanceImg=Image(@"MT_distance.png");
        
        
      
        //距离
        _distanceBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        
        _distanceBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
        //companyBtn.imageEdgeInsets=UIEdgeInsetsMake(0, 0, companyImg.size.width, companyImg.size.height);
        [_distanceBtn setTitleColor:RGB(109, 130, 138) forState:UIControlStateNormal];
        
        _distanceBtn.titleLabel.font=sysFont(12);
        _distanceBtn.enabled=NO;
        [self.contentView addSubview:_distanceBtn];

        
        
        
        
    
     
        //认证
        _certifyBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        _certifyBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
        //companyBtn.imageEdgeInsets=UIEdgeInsetsMake(0, 0, companyImg.size.width, companyImg.size.height);
        [_certifyBtn setTitleColor:RGB(109, 130, 138) forState:UIControlStateNormal];
        _certifyBtn.titleLabel.font=sysFont(12);
        _certifyBtn.enabled=NO;
        [self.contentView addSubview:_certifyBtn];
        
        
        
        self.backgroundColor=RGBA(255, 255, 255, 0.9);
        
    }
    return self;
}
-(void)setData:(NSIndexPath *)indexPath{
    
    model.indexPath = indexPath;
 
    
     UIImage *companyImg=Image(@"MT_company.png");
    UIImage *distanceImg=Image(@"MT_distance.png");
    UIImage *certifyImg=Image(@"MT_certify.png");
    
    
    [_headView setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@%@",ConfigManager.ImageUrl,model.heed_image_url,smallHeaderImage] placeholderImage:defalutHeadImage];
    
    
    UIImage *idImg;
//    if ([model.identity_key integerValue]==1) {
//        idImg=Image(@"");
//    }else if ([model.identity_key integerValue]==2){
//        idImg=Image(@"reguser.png");
//    }else if ([model.identity_key integerValue]==3){
//        idImg=Image(@"vipuser.png");
//    }else if ([model.identity_key integerValue]==4){
//        idImg=Image(@"mangeruser.png");
//    }else if ([model.identity_key integerValue]==5){
//        idImg=Image(@"hezuohuoban.png");
//    }else if ([model.identity_key integerValue]==6){
//        idImg=Image(@"gloduser.png");
//    }
    _idImageView.image=idImg;

    
        CGSize nickNameSize=[IHUtility GetSizeByText:model.nickname sizeOfFont:17 width:150];
    _lbl.size=CGSizeMake(nickNameSize.width, 20);
      _lbl.text=model.nickname;
    CGSize companySize=[IHUtility GetSizeByText:model.company_name sizeOfFont:12 width:200];
    _lbl1.frame=CGRectMake(_lbl.left, _lbl.bottom+4,  companySize.width, 15);
     _lbl1.text=model.company_name;
    
    
    
    NSDictionary *dic2=[IHUtility getUserDefalutDic:kUserDefalutInit];
    NSMutableArray *arr=[[NSMutableArray alloc]initWithArray:dic2[@"industryInfoList"]];
   
    if ([model.i_type_id isEqualToString:@"0"]) {
        _companyBtn.hidden=YES;
    }else
    {
        _companyBtn.hidden=NO;
        for (NSDictionary *dic in arr) {
            if ([[dic[@"i_type_id"] stringValue] isEqualToString: model.i_type_id]) {
                [_companyBtn setImage:[companyImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
                [_companyBtn setTitle:dic[@"i_name"] forState:UIControlStateNormal];
            }
        }

    }
    
    
     [_distanceBtn setImage:[distanceImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    
    
    NSString *distance;
    if ([model.addressInfo.distance doubleValue]>1) {
        distance=[NSString stringWithFormat:@"%.f千米",[model.addressInfo.distance doubleValue]];
    }else
    {
         distance=[NSString stringWithFormat:@"%.f米",[model.addressInfo.distance doubleValue]*1000];
    }
    
    
    
    
    CGSize distanceSize=[IHUtility GetSizeByText:distance sizeOfFont:12 width:100];
    _distanceBtn.frame=CGRectMake(_companyBtn.right+8, _companyBtn.top,  distanceImg.size.width+distanceSize.width+5, 20);
    if (_companyBtn.hidden) {
        _distanceBtn.frame=CGRectMake(_companyBtn.left, _companyBtn.top,  distanceImg.size.width+distanceSize.width+5, 20);
    }
    
    //距离
    
    [_distanceBtn setTitle:distance forState:UIControlStateNormal];
    
    _certifyBtn.hidden=YES;
    if ([model.user_authentication integerValue]==0) {
     //   CGSize certifySize=[IHUtility GetSizeByText:@"未认证" sizeOfFont:12 width:100];
        //认证
//        _certifyBtn.frame=CGRectMake(_distanceBtn.right+10, _distanceBtn.top,  certifyImg.size.width+certifySize.width+5, 20);
//        [_certifyBtn setImage:[Image(@"") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
//        [_certifyBtn setTitle:@"未认证" forState:UIControlStateNormal];

    }else if ([model.user_authentication integerValue]==1)
    {
//        CGSize certifySize=[IHUtility GetSizeByText:@"审核中" sizeOfFont:12 width:100];
        //认证
//        _certifyBtn.frame=CGRectMake(_distanceBtn.right+10, _distanceBtn.top,  certifyImg.size.width+certifySize.width+5, 20);
//        [_certifyBtn setImage:[Image(@"") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
//        [_certifyBtn setTitle:@"审核中" forState:UIControlStateNormal];

    }else if ([model.user_authentication integerValue]==2){
        
        CGSize certifySize=[IHUtility GetSizeByText:@"已认证" sizeOfFont:12 width:100];
        //认证
        _certifyBtn.frame=CGRectMake(_distanceBtn.right+10, _distanceBtn.top,  certifyImg.size.width+certifySize.width+5, 20);
        [_certifyBtn setImage:[certifyImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
        [_certifyBtn setTitle:@"已认证" forState:UIControlStateNormal];
        
        _certifyBtn.hidden=NO;
        
    }else if ([model.user_authentication integerValue]==3){
    //    CGSize certifySize=[IHUtility GetSizeByText:@"认证失败" sizeOfFont:12 width:100];
        //认证
//        _certifyBtn.frame=CGRectMake(_distanceBtn.right+10, _distanceBtn.top,  certifyImg.size.width+certifySize.width+5, 20);
//        [_certifyBtn setImage:[Image(@"") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
//        [_certifyBtn setTitle:@"已认证失败" forState:UIControlStateNormal];

    }
    
    
    
    
    
}


@end

 


@implementation GongQiuDetailsListTableViewCell
@synthesize model;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
     
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 0.5)];
        [self.contentView addSubview:lineView];
        lineView.backgroundColor=RGBA(232, 239, 239, 1);
        
        //UIImage *img=Image(@"Roger Klotz.png");
        HeadButton *imageView=[[HeadButton alloc]initWithFrame:CGRectMake(0.02*WindowWith, 0.3*self.height, 36 , 36)];
        [imageView.headBtn addTarget:self action:@selector(headTap:) forControlEvents:UIControlEventTouchUpInside];
        _headBtn=imageView;
        [self.contentView addSubview:imageView];
        
       
        
        
        SMLabel *nickNameLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(60, imageView.top+2, WindowWith,18) textColor:cBlackColor textFont:sysFont(14)];
        nickNameLbl.text=@"裴小欢";
        _nicknamelbl=nickNameLbl;
        [self.contentView addSubview:nickNameLbl];
        
    
        SMLabel *messLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(nickNameLbl.left, nickNameLbl.bottom+5, WindowWith-75, 21) textColor:RGBA(108, 123, 138, 1) textFont:sysFont(15)];
        messLbl.text=@"非常不错，有想法,希望有时间过去看看";
        messLbl.numberOfLines=0;
        _contentlbl=messLbl;
        [self.contentView addSubview:messLbl];
     
       
        SMLabel *timeLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, nickNameLbl.top+5, WindowWith-15, 15) textColor:RGBA(189, 202, 219, 1) textFont:sysFont(10)];
        timeLbl.text=@"昨天 11:25";
        _timelbl=timeLbl;
        timeLbl.textAlignment=NSTextAlignmentRight;
        [self.contentView addSubview:timeLbl];

    }
    return self;
}



-(void)setData{
    
    [_headBtn setHeadImageUrl:[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,model.userChildrenInfo.heed_image_url] type:[model.userChildrenInfo.identity_key intValue]];
    NSLog(@"%@",ConfigManager.ImageUrl);
 
     CGSize timeSize=[IHUtility GetSizeByText:[IHUtility compareCurrentTimeString:model.comment_time] sizeOfFont:10 width:200];
    _timelbl.text=[IHUtility compareCurrentTimeString:model.comment_time];
    
    CGRect rect=_contentlbl.frame;
    CGSize size=[IHUtility GetSizeByText:model.comment_cotent sizeOfFont:15 width:WindowWith-75];
    rect.size.height=size.height;
    _contentlbl.frame=rect;
    
    if (model.comment_type ==1) {
        NSString *name=model.userChildrenInfo.nickname;
        NSString *leven=model.reply_nickname;
       
        NSMutableAttributedString * attributedText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ 回复 %@",name,leven] attributes:@{NSFontAttributeName:sysFont(13)}];
        
        size=[IHUtility GetSizeByText:[attributedText string] sizeOfFont:13 width:1000];
        if (size.width>WindowWith-timeSize.width-15-_headBtn.right-20) {
            if (name.length >5) {
                name = [NSString stringWithFormat:@"%@...",[name substringToIndex:5]];
            }
            
            if (leven.length > 5) {
                leven = [NSString stringWithFormat:@"%@...",[leven substringToIndex:5]];
            }
        }
        
        attributedText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ 回复 %@",name,leven] attributes:@{NSFontAttributeName:sysFont(13)}];
       
        [attributedText addAttribute:NSForegroundColorAttributeName value:cGreenColor range:NSMakeRange(0,name.length)];
      
        [attributedText addAttribute:NSForegroundColorAttributeName value: cGreenColor range:NSMakeRange(name.length+3,leven.length+1)];
        
        _nicknamelbl.attributedText=attributedText;
    }else{
         _nicknamelbl.text=model.userChildrenInfo.nickname;
        _nicknamelbl.textColor=cGreenColor;

        
    }
    
     _contentlbl.text=model.comment_cotent;
    
   
}

-(void)headTap:(UITapGestureRecognizer *)tap{
    if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
        [self.delegate BCtableViewCell:self action:MTHeadViewActionTableViewCell indexPath:self.indexPath attribute:model.userChildrenInfo];
    }
}

@end



@implementation MTContactTableViewCell
@synthesize model;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(ContactType)type{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 10)];
        lineView.backgroundColor=RGB(240, 240, 240);
        [self.contentView addSubview:lineView];
        UIImage *img=Image(@"renmaiBK.png");
        UIImageView *bkimageView=[[UIImageView alloc]initWithFrame:CGRectMake(0.026*WindowWith, 10, WindowWith-0.026*WindowWith*2, 0.3*WindowWith)];
        bkimageView.image=img;
//        _bkImageView=bkimageView;
        [self.contentView addSubview:bkimageView];
     
    
        img=Image(@"Slice 2.png");
       UIImageView *ImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0.045*bkimageView.width, -0.09*bkimageView.height, 0.197*bkimageView.width, 0.197*bkimageView.width)];
        ImageView.image=img;
        
        [bkimageView addSubview:ImageView];
        
        UIAsyncImageView *headImageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(ImageView.width*0.07, ImageView.height*0.07,ImageView.width*0.85, ImageView.height*0.85)];
        
        headImageView.image=Image(@"defaulthead.png");
        [ImageView addSubview:headImageView];
        _headImgView=headImageView;
        
        img=Image(@"renmaiRZ.png");
       UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, ImageView.bottom-img.size.height/2, img.size.width, img.size.height)];
        imageView.centerX=ImageView.centerX;
        _logoImageView=imageView;
        imageView.image=img;
        [bkimageView addSubview:imageView];
        
        
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, headImageView.bottom+5, 54, 15) textColor:cBlackColor textFont:sysFont(15)];
        lbl.text=@"刘湖南";
        lbl.centerX=ImageView.centerX;
        _nickNameLbl=lbl;
        [bkimageView addSubview:lbl];
        
        
        UIImage *sexImg=Image(@"boy.png");
        UIImageView *sexImageView=[[UIImageView alloc]initWithFrame:CGRectMake(lbl.right+5, lbl.top+3, sexImg.size.width, sexImg.size.height)];
        _sexImageView=sexImageView;
        sexImageView.image=sexImg;
        [bkimageView addSubview:sexImageView];
        
        
        
        BQView *bqView=[[BQView alloc]initWithFrame:CGRectMake(0.354*bkimageView.width, 0.15*bkimageView.height, 200, 20)];
        _bqView=bqView;
        [bkimageView addSubview:bqView];

       //  UIImageView *imgView=[bkimageView viewWithTag:1000];
        img=Image(@"iconfont-gongsi.png");
        imageView=[[UIImageView alloc]initWithFrame:CGRectMake(bqView.left, bqView.bottom+10, img.size.width, img.size.height)];
        if(WindowWith==320){
            imageView.frame=CGRectMake(bqView.left, bqView.bottom+3, img.size.width, img.size.height);
            
        }

        imageView.image=img;
        [bkimageView addSubview:imageView];


        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+5, imageView.top+2, bkimageView.width-imageView.right, 15) textColor:cBlackColor textFont:sysFont(15)];
        lbl.text=@"浏阳正河苗圃(集团)有限公司";
        _companyLbl=lbl;
        [bkimageView addSubview:lbl];

        
        
        
        img=Image(@"Group 44.png");
        imageView=[[UIImageView alloc]initWithFrame:CGRectMake(bqView.left, imageView.bottom+10, img.size.width, img.size.height)];
        if(WindowWith==320){
            imageView.frame=CGRectMake(bqView.left, lbl.bottom+3, img.size.width, img.size.height);
            
        }

        imageView.image=img;
        [bkimageView addSubview:imageView];
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+5, imageView.top+5, 40, 12) textColor:cBlackColor textFont:sysFont(12)];
        lbl.text=@"总经理";
        _positionLbl=lbl;
        [bkimageView addSubview:lbl];

        
       
        img=Image(@"RM_m.png");
        imageView=[[UIImageView alloc]initWithFrame:CGRectMake(lbl.right+10, imageView.top+3, img.size.width, img.size.height)];
        imageView.image=img;
        _imageView=imageView;
        [bkimageView addSubview:imageView];
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+3, imageView.top+2, 48, 12) textColor:cBlackColor textFont:sysFont(12)];
        lbl.text=@"苗木基地";
        _typeLbl=lbl;
        [bkimageView addSubview:lbl];
        
        
        
        
        UIImage *typeImg;
        UIImageView *typeImageView=[[UIImageView alloc]initWithImage:typeImg];
//        _typeImageView=typeImageView;
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(bkimageView.width-60, bkimageView.height-28, 50, 14) textColor:RGB(232, 121, 117) textFont:sysFont(14)];
        _lbl=lbl;
        

        if (type==ENT_hot) {
            typeImg=Image(@"renmai_hot.png");
            lbl.text=@"1675";
        }else if(type==ENT_neighbourhood)
        {
            typeImg=Image(@"juli.png");
            lbl.text=@"1.3km";
        }
        if(WindowWith==320){
            lbl.font=sysFont(12);
            lbl.frame=CGRectMake(bkimageView.width-50, bkimageView.height-20, 50, 12);
            
        }

        typeImageView.frame=CGRectMake(lbl.left-typeImg.size.width-2, lbl.top-2, typeImg.size.width, typeImg.size.height);
        
               typeImageView.image=typeImg;
        [bkimageView addSubview:typeImageView];
        [bkimageView addSubview:lbl];
        
        
    }
    return self;
}
-(void)setDataWithType:(ContactType)type
{
    [_headImgView setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@%@",ConfigManager.ImageUrl,model.heed_image_url,smallHeaderImage] placeholderImage:Image(@"defaulthead.png")];
    _headImgView.layer.cornerRadius=_headImgView.width/2;
    if (![model.user_authentication isEqualToString:@"2"]) {
        _logoImageView.hidden=YES;
    }
    CGSize size=[IHUtility GetSizeByText:model.nickname sizeOfFont:15 width:75];
        _nickNameLbl.text=model.nickname;
   
    
    if (WindowWith==414) {
        size=[IHUtility GetSizeByText:model.nickname sizeOfFont:16 width:80];
        _nickNameLbl.font=sysFont(16);
    }else if(WindowWith==320){
         size=[IHUtility GetSizeByText:model.nickname sizeOfFont:13 width:70];
        _nickNameLbl.font=sysFont(13);
    }
     _nickNameLbl.frame=CGRectMake(_headImgView.width/2-size.width/2+10, _headImgView.bottom+5, size.width, 20);
    _sexImageView.origin=CGPointMake(_nickNameLbl.right+5, _nickNameLbl.top+2);
    
    
    UIImage *img;
    if ([model.sexy integerValue]==2) {
        img=Image(@"girl.png");
    }else{
        img=Image(@"boy.png");
    }
    _sexImageView.image=img;
    
    size=[IHUtility GetSizeByText:model.company_name sizeOfFont:15 width:200];
    if(WindowWith==320){
        _companyLbl.font=sysFont(13);
        size=[IHUtility GetSizeByText:model.company_name sizeOfFont:13 width:180];
    }
    _companyLbl.size=CGSizeMake(size.width, 15);
    _companyLbl.text=model.company_name;
   

    
    size=[IHUtility GetSizeByText:model.position sizeOfFont:12 width:100];
   
    _positionLbl.size=CGSizeMake(size.width, 12);
    _positionLbl.text=model.position;
   
    _imageView.origin=CGPointMake(_positionLbl.right+10, _positionLbl.top-2);
    _typeLbl.origin=CGPointMake(_imageView.right+3, _imageView.top+2);
    if ([model.i_type_id integerValue]==1) {
        _imageView.image=Image(@"RM_m.png");
        _typeLbl.text=@"苗木基地";
        
    }else if ([model.i_type_id integerValue]==2)
    {
        _imageView.image=Image(@"RM_j.png");
         _typeLbl.text=@"景观设计";
    }else if ([model.i_type_id integerValue]==3)
    {    _typeLbl.text=@"施工企业";
        _imageView.image=Image(@"RM_g.png");
        
    }else if ([model.i_type_id integerValue]==4){
        _imageView.image=Image(@"RM_c.png");
         _typeLbl.text=@"园林资材";
    }else if ([model.i_type_id integerValue]==5){
        _imageView.image=Image(@"RM_s.png");
        _typeLbl.text=@"花木市场";
    }

    if (type==ENT_hot) {
       
        _lbl.text=model.experience_info.behavior_value;
    }else if(type==ENT_neighbourhood)
    {
        
        _lbl.text=[NSString stringWithFormat:@"%.2fkm",[model.addressInfo.distance doubleValue]];
    
    }

    
    NSMutableArray *Arr=[[NSMutableArray alloc]init];
    for (NSDictionary *obj in model.userIdentityKeyList) {
        [Arr addObject:obj[@"identity_key"]];
    }
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    for (NSNumber *obj in Arr) {
        if ([[obj stringValue]isEqualToString:@"4"]) {
            [arr addObject:@"zz.png"];
        }
        
        if ([[obj stringValue] isEqualToString:@"5"]) {
            [arr addObject:@"znhz.png"];
        }
        if ([[obj stringValue] isEqualToString:@"7"]) {
            [arr addObject:@"hy.png"];
        }
        if ([[obj stringValue] isEqualToString:@"6"]) {
            [arr addObject:@"jzz.png"];
        }
        if ([[obj stringValue] isEqualToString:@"1"] ||[[obj stringValue] isEqualToString:@"2"]) {
             [arr addObject:@"ptg.png"];
        }
    }
   
    [_bqView setData:arr];
    
    
    
    
    
}


@end


@implementation CommentForMeListTableViewCell
@synthesize model;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        
        HeadButton *headView=[[HeadButton alloc]initWithFrame:CGRectMake(16, 15, 40, 40)];
        _headView=headView;
        [self.contentView addSubview:headView];
      
        NSString *str=@"王国强";
        CGSize size=[IHUtility GetSizeByText:str sizeOfFont:17 width:WindowWith];
        
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(64, 25, size.width, 17) textColor:cBlackColor textFont:sysFont(17)];
        lbl.text=str;
        _namelbl=lbl;
        [self.contentView addSubview:lbl];
        
        
        SMLabel *lbl2=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.right+3, lbl.top, WindowWith - lbl.right, 12) textColor:cGrayLightColor textFont:sysFont(12)];
        lbl2.text=@"昨天 11：25";
        _timelbl=lbl2;
        _timelbl.centerY = lbl.centerY;
        [self.contentView addSubview:lbl2];
        

        
       UIImage* img=Image(@"boy.png");
        UIImageView *sexImage=[[UIImageView alloc]initWithFrame:CGRectMake(lbl.right+3, lbl.top, img.size.width, img.size.height)];
        sexImage.image=img;
        _sexImage=sexImage;
//        [self.contentView addSubview:sexImage];
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.left, 65, WindowWith-65-17, 17) textColor:cBlackColor textFont:sysFont(15)];
        lbl.text=@"我也是去年看到的，从此忘不了";
        _contentlbl=lbl;
        [self.contentView addSubview:lbl];
        
        UIView *contenView=[[UIView alloc]initWithFrame:CGRectMake(lbl.left, lbl.bottom+10, WindowWith-lbl.left-15, 64)];
        _contenView=contenView;
        contenView.backgroundColor=RGB(233, 239, 239);
        contenView.userInteractionEnabled=YES;
        [self.contentView addSubview:contenView];
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(contentClick:)];
        [contenView addGestureRecognizer:tap];
        
        
        UIAsyncImageView *imgView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(6, 6, 54, 54)];
        _imgView=imgView;
 
        [contenView addSubview:imgView];
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imgView.right+6, 0, contenView.width-imgView.right-51, contenView.height) textColor:cBlackColor textFont:sysFont(12)];
        _titlelbl=lbl;
        lbl.numberOfLines=2;
        lbl.text=@"榴莲在红玉白之前，美丽的樱花，与春天的叶子";
        [contenView addSubview:lbl];
        
        img=Image(@"huati_tag.png");
        UIImageView *bqImage=[[UIImageView alloc]initWithFrame:CGRectMake(contenView.width-36, 0, img.size.width, img.size.height)];
        bqImage.image=img;
        _typeImage=bqImage;
        [contenView addSubview:bqImage];
        
        UIView *downView=[[UIView alloc]initWithFrame:CGRectMake(contenView.left, contenView.bottom+2, contenView.width, 45)];
        downView.backgroundColor=RGB(233, 239, 239);
        _downView=downView;
        [self.contentView addSubview:downView];
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(7, 3, downView.width-14, downView.height-6) textColor:cBlackColor textFont:sysFont(15)];
        lbl.numberOfLines=0;
        _mecomentlbl=lbl;
        [downView addSubview:lbl];
        
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, downView.bottom+13, WindowWith, 5)];
        _lineView=lineView;
        lineView.backgroundColor=cBgColor;
        [self.contentView addSubview:lineView];
        
    }
    
    return self;
}

-(void)contentClick:(UITapGestureRecognizer *)tap{
    
    if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
        [self.delegate BCtableViewCell:self action:MTDetailActionTalbeViewCell indexPath:self.indexPath attribute:model];
    }
  
}

-(void)setData{
    
    [_headView setHeadImageUrl:model.userInfo.heed_image_url type:[model.userInfo.identity_key intValue]];
   

    NSString *time=[IHUtility compareCurrentTimeString:model.comment_time];
    _timelbl.text=time;
    
    _namelbl.text=model.userInfo.nickname;
    
    CGRect rect=_namelbl.frame;
   CGSize size=[IHUtility GetSizeByText:model.userInfo.nickname sizeOfFont:17 width:WindowWith];
    rect.size.width=size.width;
    _namelbl.frame=rect;
    _timelbl.left = _namelbl.right + 5;
    
    UIImage *img;
    if ([model.userInfo.sexy integerValue]==2) {
        img=Image(@"girl.png");
    }else{
        img=Image(@"boy.png");
    }
    _sexImage.image=img;
    rect=_sexImage.frame;
    rect.origin.x=_namelbl.right+3;
    _sexImage.frame=rect;
    
    _contentlbl.text=model.comment_c;
    size=[IHUtility GetSizeByText:model.comment_c sizeOfFont:15 width:_contentlbl.width];
    rect=_contentlbl.frame;
    rect.size.height=size.height;
    _contentlbl.frame=rect;
    
    rect=_contenView.frame;
    rect.origin.y=_contentlbl.bottom+10;
    
    
    if (model.comment_type==1) {
        _typeImage.image=Image(@"gongying.png");
    }else if (model.comment_type==2){
       _typeImage.image=Image(@"huati_tag.png");
    }else if (model.comment_type==3){
        _typeImage.image=Image(@"buy_tag.png");
    }
    
    if (model.imgArray.count==0) {
        _imgView.hidden=YES;
        rect=_titlelbl.frame;
        rect.origin.x=7;
        rect.size.width=_contenView.width-7-51;
        _titlelbl.frame=rect;
       
    }else{
        _imgView.hidden=NO;
        MTPhotosModel *photomod=[model.imgArray objectAtIndex:0];
        [_imgView setImageAsyncWithURL:photomod.thumbUrl placeholderImage:Image(@"defaultlogoF.png")];
        
        rect=_titlelbl.frame;
        rect.origin.x=_imgView.right+6;
        rect.size.width=_contenView.width-_imgView.right-51;
        _titlelbl.frame=rect;
    }
    _titlelbl.text=model.varieties;
    
    CGFloat h=0;
    if (model.childrenComments.user_id ==0) {
        _downView.hidden=YES;
        h= _contenView.bottom+15;
    }else {
      
        NSString *name=[NSString stringWithFormat:@"%@:",model.childrenComments.nickname];
        
        CGSize size2=[IHUtility GetSizeByText:name sizeOfFont:15 width:_mecomentlbl.width];
        rect=_mecomentlbl.frame;
        rect.origin.y=5;
        rect.size.height=size2.height;
        _mecomentlbl.frame=rect;
        
        rect=_downView.frame;
        rect.origin.y=_contenView.bottom+2;
        rect.size.height=size2.height+10;
        _downView.frame=rect;
        
        NSString *leven=model.childrenComments.comment;
        NSMutableAttributedString * attributedText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@",name,leven] attributes:@{NSFontAttributeName:sysFont(15)}];
        [attributedText addAttribute:NSForegroundColorAttributeName value:cGreenColor range:NSMakeRange(0,name.length)];
        [attributedText addAttribute:NSForegroundColorAttributeName value:cBlackColor range:NSMakeRange(name.length+1,leven.length)];
        _mecomentlbl.attributedText=attributedText;
        
        
        _downView.hidden=NO;
        h=_downView.bottom+15;
    }
    
    rect=_lineView.frame;
    rect.origin.y=h;
    _lineView.frame=rect;
    
}

@end


@implementation MapSearchListTableViewCell
//@synthesize model;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        _adressImg=Image(@"");
//        
//        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 39, WindowWith, 1)];
//        lineView.backgroundColor=cLineColor;
//        [self.contentView addSubview:lineView];
//        _adressImageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, self.contentView.height/2-_adressImg.size.width/2, _adressImg.size.width, _adressImg.size.height)];
//        _adressImageView.image=_adressImg;
//        [self.contentView addSubview:_adressImageView];
//      
//        CGSize size=[IHUtility GetSizeByText:@"浏阳伯家花木大市场" sizeOfFont:14 width:300];
//        
//       _lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(_adressImageView.right+15, _adressImageView.top, size.width, size.height) textColor:cBlackColor textFont:sysFont(14)];
//    
//        [self.contentView addSubview:_lbl];
        
        
        _headView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(WindowWith*0.02, 15, WindowWith*0.128, WindowWith*0.128)];
        [_headView setLayerMasksCornerRadius:_headView.width/2 BorderWidth:0   borderColor:[UIColor clearColor]];
        
        [self.contentView addSubview:_headView];
        
        
        UIImage *img=Image(@"reguser.png");
        UIImageView *idImageView=[[UIImageView alloc]initWithFrame:CGRectMake(_headView.left+_headView.width-img.size.width,_headView.top+_headView.height-img.size.height, img.size.width, img.size.height)];
        _idImageView=idImageView;
        idImageView.image=img;
        [self.contentView addSubview:idImageView];
        
        
        
        _lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(_headView.right+23, _headView.top-5, 60, 16) textColor: cBlackColor textFont:sysFont(17)];
        
        [self.contentView addSubview:_lbl];
        
        _lbl1=[[SMLabel alloc]initWithFrameWith:CGRectMake(_headView.right+23, _lbl.bottom+4, 177, 13) textColor:cBlackColor textFont:sysFont(12)];
        
        [self.contentView addSubview:_lbl1];
        
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 79.3, WindowWith, 0.7)];
        lineView.backgroundColor=cLineColor;
        [self.contentView addSubview:lineView];
        
        UIImage *toImg=Image(@"MT_to.png");
        UIImageView *toImageView=[[UIImageView alloc]initWithImage:toImg];
        toImageView.frame=CGRectMake(WindowWith*0.93, 30, toImg.size.width, toImg.size.height);
        [self.contentView addSubview:toImageView];
        
        
        UIImage *companyImg=Image(@"MT_company.png");
        
        CGSize companySize=[IHUtility GetSizeByText:@"苗木基地" sizeOfFont:12 width:100];
        //公司类型
        _companyBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        _companyBtn.frame=CGRectMake(_lbl1.left, _lbl1.bottom+10,  companyImg.size.width+companySize.width+5, 20);
        
        _companyBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
        
        [_companyBtn setTitleColor:RGB(109, 130, 138) forState:UIControlStateNormal];
        
        _companyBtn.titleLabel.font=sysFont(12);
        _companyBtn.enabled=NO;
        [self.contentView addSubview:_companyBtn];
        
        
        // UIImage *distanceImg=Image(@"MT_distance.png");
        
        
        
        //距离
        _distanceBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        
        _distanceBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
        //companyBtn.imageEdgeInsets=UIEdgeInsetsMake(0, 0, companyImg.size.width, companyImg.size.height);
        [_distanceBtn setTitleColor:RGB(109, 130, 138) forState:UIControlStateNormal];
        
        _distanceBtn.titleLabel.font=sysFont(12);
        _distanceBtn.enabled=NO;
        [self.contentView addSubview:_distanceBtn];
        
        
        
        
        
        
        
        //认证
        _certifyBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        _certifyBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
        //companyBtn.imageEdgeInsets=UIEdgeInsetsMake(0, 0, companyImg.size.width, companyImg.size.height);
        [_certifyBtn setTitleColor:RGB(109, 130, 138) forState:UIControlStateNormal];
        _certifyBtn.titleLabel.font=sysFont(12);
        _certifyBtn.enabled=NO;
        [self.contentView addSubview:_certifyBtn];
        
        
        
        self.backgroundColor=RGBA(255, 255, 255, 0.9);

        
       
        
        
    }
    return self;
    
    
    
}

-(void)setData:(UserChildrenInfo *)model
{
//    if ([model.i_type_id integerValue]==1) {
//         _adressImg=Image(@"m.png");
//        
//    }else if ([model.i_type_id integerValue]==2)
//    {
//         _adressImg=Image(@"g.png");
//        
//    }else if ([model.i_type_id integerValue]==3)
//    {
//         _adressImg=Image(@"j.png");
//        
//    }else if ([model.i_type_id integerValue]==4){
//           _adressImg=Image(@"c.png");
//    }
//    
//    _adressImageView.image=_adressImg;
//   
//    _adressImageView.frame=CGRectMake(15, self.contentView.height/2-_adressImg.size.width/2, _adressImg.size.width, _adressImg.size.height);
//    CGSize size=[IHUtility GetSizeByText:model.company_name sizeOfFont:14 width:300];
//    _lbl.text=model.company_name;
//    _lbl.frame=CGRectMake(_adressImageView.right+15, _adressImageView.top, size.width, size.height);
  
    
    
    
    UIImage *companyImg=Image(@"MT_company.png");
    UIImage *distanceImg=Image(@"MT_distance.png");
    UIImage *certifyImg=Image(@"MT_certify.png");
    
    
    [_headView setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@%@",ConfigManager.ImageUrl,model.heed_image_url,smallHeaderImage] placeholderImage:defalutHeadImage];
    
    
    UIImage *idImg;
    if ([model.identity_key integerValue]==1) {
        idImg=Image(@"");
    }else if ([model.identity_key integerValue]==2){
        idImg=Image(@"reguser.png");
    }else if ([model.identity_key integerValue]==3){
        idImg=Image(@"vipuser.png");
    }else if ([model.identity_key integerValue]==4){
        idImg=Image(@"mangeruser.png");
    }else if ([model.identity_key integerValue]==5){
        idImg=Image(@"hezuohuoban.png");
    }else if ([model.identity_key integerValue]==6){
        idImg=Image(@"gloduser.png");
    }
    _idImageView.image=idImg;
    
    
    CGSize nickNameSize=[IHUtility GetSizeByText:model.nickname sizeOfFont:17 width:150];
    _lbl.size=CGSizeMake(nickNameSize.width, 20);
    _lbl.text=model.nickname;
    CGSize companySize=[IHUtility GetSizeByText:model.company_name sizeOfFont:12 width:200];
    _lbl1.frame=CGRectMake(_lbl.left, _lbl.bottom+4,  companySize.width, 15);
    _lbl1.text=model.company_name;
    
    
    
    NSDictionary *dic2=[IHUtility getUserDefalutDic:kUserDefalutInit];
    NSMutableArray *arr=[[NSMutableArray alloc]initWithArray:dic2[@"industryInfoList"]];
    
    if ([model.i_type_id integerValue]==0) {
        _companyBtn.hidden=YES;
    }else
    {
        _companyBtn.hidden=NO;
        for (NSDictionary *dic in arr) {
            if ([[dic[@"i_type_id"] stringValue] isEqualToString: [NSString stringWithFormat:@"%@",model.i_type_id]]) {
                [_companyBtn setImage:[companyImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
                [_companyBtn setTitle:dic[@"i_name"] forState:UIControlStateNormal];
            }
        }
        
    }
    
    
    [_distanceBtn setImage:[distanceImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    
    
    NSString *distance;
    if ([model.distance doubleValue]>1) {
        distance=[NSString stringWithFormat:@"%.f千米",[model.distance doubleValue]];
    }else
    {
        distance=[NSString stringWithFormat:@"%.f米",[model.distance doubleValue]*1000];
    }
    
    
    
    
    CGSize distanceSize=[IHUtility GetSizeByText:distance sizeOfFont:12 width:100];
    _distanceBtn.frame=CGRectMake(_companyBtn.right+8, _companyBtn.top,  distanceImg.size.width+distanceSize.width+5, 20);
    if (_companyBtn.hidden) {
        _distanceBtn.frame=CGRectMake(_companyBtn.left, _companyBtn.top,  distanceImg.size.width+distanceSize.width+5, 20);
    }
    
    //距离
    
    [_distanceBtn setTitle:distance forState:UIControlStateNormal];
    
    _certifyBtn.hidden=YES;
    if ([model.user_authentication integerValue]==0) {
     //   CGSize certifySize=[IHUtility GetSizeByText:@"未认证" sizeOfFont:12 width:100];
        //认证
        //        _certifyBtn.frame=CGRectMake(_distanceBtn.right+10, _distanceBtn.top,  certifyImg.size.width+certifySize.width+5, 20);
        //        [_certifyBtn setImage:[Image(@"") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
        //        [_certifyBtn setTitle:@"未认证" forState:UIControlStateNormal];
        
    }else if ([model.user_authentication integerValue]==1)
    {
       // CGSize certifySize=[IHUtility GetSizeByText:@"审核中" sizeOfFont:12 width:100];
        //认证
        //        _certifyBtn.frame=CGRectMake(_distanceBtn.right+10, _distanceBtn.top,  certifyImg.size.width+certifySize.width+5, 20);
        //        [_certifyBtn setImage:[Image(@"") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
        //        [_certifyBtn setTitle:@"审核中" forState:UIControlStateNormal];
        
    }else if ([model.user_authentication integerValue]==2){
        
        CGSize certifySize=[IHUtility GetSizeByText:@"已认证" sizeOfFont:12 width:100];
        //认证
        _certifyBtn.frame=CGRectMake(_distanceBtn.right+10, _distanceBtn.top,  certifyImg.size.width+certifySize.width+5, 20);
        [_certifyBtn setImage:[certifyImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
        [_certifyBtn setTitle:@"已认证" forState:UIControlStateNormal];
        
        _certifyBtn.hidden=NO;
        
    }else if ([model.user_authentication integerValue]==3){
   //     CGSize certifySize=[IHUtility GetSizeByText:@"认证失败" sizeOfFont:12 width:100];
        //认证
        //        _certifyBtn.frame=CGRectMake(_distanceBtn.right+10, _distanceBtn.top,  certifyImg.size.width+certifySize.width+5, 20);
        //        [_certifyBtn setImage:[Image(@"") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
        //        [_certifyBtn setTitle:@"已认证失败" forState:UIControlStateNormal];
        
    }

    
}





@end


@implementation FindOutListTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        HeadButton *headView=[[HeadButton alloc]initWithFrame:CGRectMake(15, 15, 50, 50)];
        _headView=headView;
        [self.contentView addSubview:headView];
        
//        UIImage *img=Image(@"reguser.png");
//        UIImageView *idImageView=[[UIImageView alloc]initWithFrame:CGRectMake(_headView.width-img.size.width, _headView.height-img.size.height, img.size.width, img.size.height)];
//        _idImageView=idImageView;
//        idImageView.image=img;
//        [headView addSubview:idImageView];
        
        
        CGSize nameSize=[IHUtility GetSizeByText:@"裴小欢" sizeOfFont:16 width:0.4*WindowWith];
        SMLabel *nickNameLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(headView.right+8, headView.top+2, nameSize.width, nameSize.height) textColor:cBlackColor textFont:sysFont(16)];
        _nickNameLbl=nickNameLbl;
        nickNameLbl.text=@"裴小欢";
        [self.contentView addSubview:nickNameLbl];
        
        //判断性别
        UIImage *sexImg=Image(@"boy.png");
        UIImageView *sexImageView=[[UIImageView alloc]initWithFrame:CGRectMake(nickNameLbl.right+5, nickNameLbl.top+3, sexImg.size.width, sexImg.size.height)];
//        _sexImageView=sexImageView;
        sexImageView.image=sexImg;
       // [self.contentView addSubview:sexImageView];

        
        CGSize adressSize=[IHUtility GetSizeByText:@"浏阳正河园林有限公司" sizeOfFont:12 width:0.4*WindowWith];
        SMLabel *adressLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(nickNameLbl.left, nickNameLbl.bottom+5, adressSize.width, adressSize.height) textColor:cGrayLightColor textFont:sysFont(12)];
        _adressLbl=adressLbl;
        adressLbl.text=@"浏阳正河园林有限公司";
        [self addSubview:adressLbl];
        UIImage *adressImg=Image(@"m.png");
        
        UIImageView *adressImageView=[[UIImageView alloc]initWithFrame:CGRectMake(adressLbl.right+5, adressLbl.top, adressImg.size.width, adressImg.size.height)];
//        _adressImageView=adressImageView;
        adressImageView.image=adressImg;
        
        //[self.contentView addSubview:adressImageView];

        
       UIImage *img=Image(@"GQ_Left.png");
        
      
        
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 79, WindowWith, 1)];
        lineView.backgroundColor=cLineColor;
        [self.contentView addSubview:lineView];
        
        UIImageView *imageView=[[UIImageView alloc]initWithImage:img];
        imageView.frame=CGRectMake(lineView.right-20, 40, img.size.width, img.size.height);
        _imageView=imageView;
        [self.contentView addSubview:imageView];

        
        SMLabel *timeLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.left, imageView.top, 100, 12) textColor:cGrayLightColor textFont:sysFont(12)];
        _timeLbl=timeLbl;
        [self.contentView addSubview:timeLbl];
        
        
    }
    return self;
    
    
    
}

-(void)setData:(UserChildrenInfo *)model 
{
    [_headView setHeadImageUrl:[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,model.heed_image_url] type:[model.identity_key intValue]];
 
    
    
    
     CGSize nameSize=[IHUtility GetSizeByText:model.nickname sizeOfFont:16 width:0.4*WindowWith];
    _nickNameLbl.text=model.nickname;
    _nickNameLbl.frame=CGRectMake(_headView.right+8, _headView.top+2, nameSize.width, 20);
    UIImage *img;
 
    if ([model.sexy integerValue]==2) {
        img=Image(@"girl.png");
    }else{
        img=Image(@"boy.png");
    }
  
    
    _adressLbl.text=model.company_name;
    CGSize adressSize=[IHUtility GetSizeByText:model.company_name sizeOfFont:12 width:200];
    _adressLbl.size=CGSizeMake(adressSize.width, 12);
    
    
    CGSize timeSize=[IHUtility GetSizeByText:[IHUtility compareCurrentTimeString:model.viewTime] sizeOfFont:12 width:100];
    _timeLbl.frame=CGRectMake(_imageView.left-7-timeSize.width, _imageView.top, timeSize.width, 12);
    
    _timeLbl.text=[IHUtility compareCurrentTimeString:model.viewTime];
    
}

@end
@implementation ProvinceListTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       // self.lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(20, 10, 200, 20) textColor:cBlackColor textFont:sysFont(16)];
       // [self.contentView addSubview:self.lbl];
        
        self.textLabel.font=sysFont(16);
        self.textLabel.textColor=cBlackColor;
        
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(20, 44, WindowWith-40, 1)];
        lineView.backgroundColor=cLineColor;
        [self.contentView addSubview:lineView];
    }
    return self;
}

-(void)fillCellWithModel:(ProvinceModel *)model
{
    self.textLabel.text=model.province;
}





@end



@implementation CityListTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.textLabel.font=sysFont(16);
        self.textLabel.textColor=cBlackColor;
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(20, 44, WindowWith-40, 1)];
        lineView.backgroundColor=cLineColor;
        [self.contentView addSubview:lineView];
    }
    return self;

}

-(void)fillCellWithModel:(SectionModel *)model :(NSIndexPath *)indexPath
{
   
    self.textLabel.text=model.rows[indexPath.row];
}


@end


@implementation MTMeListTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImage *img=Image(@"GQ_Left.png");
        UIImageView *imageView=[[UIImageView alloc]initWithImage:img];
        
        imageView.frame=CGRectMake(WindowWith-img.size.width-20, (65-img.size.height)/2, img.size.width, img.size.height);
        [self.contentView addSubview:imageView];
        

        
        
        UIImage *typeImg=Image(@"Me_localhost.png");
        
        self.typeImageView=[[UIImageView alloc]initWithImage:typeImg];
        _typeImageView=self.typeImageView;
        self.typeImageView.frame=CGRectMake(15, (65-typeImg.size.height)/2, typeImg.size.width, typeImg.size.height);
        [self.contentView addSubview: self.typeImageView];
        
        
        
        //地图标注高亮显示
        
        
        SMLabel * finishL=[[SMLabel alloc]initWithFrameWith:CGRectMake(WindowWith-img.size.width-70-10,  self.typeImageView.top+2, 50, 15) textColor:cGreenColor textFont:sysFont(15)];
        finishL.text=@"已标注";
        finishL.tag=101;
        _valuelbl=finishL;
        _valuelbl.centerY= self.typeImageView.centerY;
        finishL.hidden=YES;
        [self.contentView addSubview:finishL];
        
        
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake( self.typeImageView.right+20,  self.typeImageView.top+5, 150, 15) textColor:cBlackColor textFont:sysFont(15)];
        _lbl=lbl;
        _lbl.centerY= self.typeImageView.centerY;
        lbl.text=@"";
        [self.contentView addSubview:lbl];
        
        
        UIView *linView=[[UIView alloc]initWithFrame:CGRectMake(15,64, WindowWith-30, 1)];
        linView.backgroundColor=cLineColor;
        [self.contentView addSubview:linView];
        
        self.numView=[[CornerView alloc]initWithFrame:CGRectMake(WindowWith-60, 65/2-10, 25, 20) count:0];
        [self addSubview:self.numView];

    }
    return self;
    
}


-(void)setDataWithDic:(NSDictionary *)dic
{
    UIImage *typeImg=Image(dic[@"image"]);
    _typeImageView.image=typeImg;
    _typeImageView.frame=CGRectMake(15, (65-typeImg.size.height)/2, typeImg.size.width, typeImg.size.height);
    self.tag=[dic[@"tag"] intValue];
    
    
    _valuelbl.hidden=YES;
    
    if (self.tag == 1005) {
        if ( [[NSUserDefaults standardUserDefaults] integerForKey:kJobIdentKey]==1002){
           _lbl.text = @"我的招聘";
        }else if ([[NSUserDefaults standardUserDefaults] integerForKey:kJobIdentKey]==1001){
            _lbl.text = @"我的求职";
        }else{
           _lbl.text=dic[@"title"];
        }
    }else{
        
        _lbl.text=dic[@"title"];
        if ([dic[@"title"] isEqualToString:@"切换身份"]) {
            _valuelbl.hidden=NO;
            if ( [[NSUserDefaults standardUserDefaults] integerForKey:kJobIdentKey]==1002){
                _valuelbl.text = @"招聘方";
            }else if ([[NSUserDefaults standardUserDefaults] integerForKey:kJobIdentKey]==1001){
                _valuelbl.text = @"求职者";
            }else{
                _valuelbl.text=@"";
            }
        }else{
            _valuelbl.hidden=YES;
        }
    }
    
    
}


@end


@interface ActivityTableViewCell (){
    
}
@end
@implementation ActivityTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
   
        self.contentView.backgroundColor = [UIColor whiteColor];
       
        UIAsyncImageView *imageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(kWidth(10), kWidth(13), kWidth(155), kWidth(104))];
        _topImageView = imageView;
        _topImageView.contentMode = UIViewContentModeScaleAspectFill;
        _topImageView.image=DefaultImage_logo;
        _topImageView.layer.cornerRadius = kWidth(5);
        [self.contentView addSubview:imageView];
        
        _zhuangtaiView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth(94), kWidth(28))];
        [_topImageView addSubview:_zhuangtaiView];
        _zhuangtaiView.layer.cornerRadius = kWidth(5);
//        _zhuangtaiView.clipsToBounds = YES;
        
        _zhuangtaiLabel= [[SMLabel alloc] initWithFrame:CGRectMake(0, 0, width(_zhuangtaiView), height(_zhuangtaiView))];
        _zhuangtaiLabel.textAlignment = NSTextAlignmentCenter;
        _zhuangtaiLabel.layer.cornerRadius = kWidth(5);
        _zhuangtaiLabel.text = @"已截止报名";
        
        _zhuangtaiLabel.clipsToBounds = YES;
        _zhuangtaiLabel.font = boldFont(16);
        _zhuangtaiView.backgroundColor = [UIColor clearColor];
        _zhuangtaiLabel.textColor = [UIColor whiteColor];
        _zhuangtaiLabel.alpha = 1.;
        [_zhuangtaiView addSubview:_zhuangtaiLabel];
           
        
        
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(maxX(_topImageView) + kWidth(10) , minY(_topImageView), iPhoneWidth - maxX(_topImageView) - kWidth(20), 45) textColor:cBlackColor textFont:sysFont(16)];
        lbl.textAlignment = NSTextAlignmentLeft;
        lbl.text=@"2016年中苗会西藏游学之旅拉萨站";
        _titileLabel = lbl;
        _titileLabel.verticalAlignment = VerticalAlignmentTop;
        _titileLabel.numberOfLines = 0;
        [self.contentView addSubview:lbl];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(minX(_titileLabel), _titileLabel.bottom + kWidth(8) , width(_titileLabel),kWidth(15))];
        label1.textColor = RGB(153, 153, 153);
        label1.font = sysFont(14);
        label1.textAlignment = NSTextAlignmentLeft;
        _timeLabel = label1;
        [self.contentView addSubview:_timeLabel];
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(minX(_titileLabel) , _timeLabel.bottom + kWidth(6),  width(_titileLabel), kWidth(25)) textColor:RGB(255, 0, 0) textFont:sysFont(16)];
        lbl.text=@"￥120";
        _priceLabel = lbl;
        [self.contentView addSubview:lbl];
        
        UILabel *linelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , iPhoneWidth , 1)];
        linelabel.backgroundColor = cLineColor;
        _lineLabel = linelabel;
        [self.contentView addSubview:_lineLabel];
    }

    return self;
}

-(void)btnClick:(UIButton*)sender{
    
    if ([IHUtility overtime:self.mod.curtime inputDate:self.mod.activities_expiretime]) {
        [IHUtility addSucessView:@"该活动已过期" type:2];
        return;
    }
    if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
        
        if ([self.signBtu.titleLabel.text isEqualToString:@"立即支付"] ||[self.signBtu.titleLabel.text isEqualToString:@"付款失败"]) {
            [self.delegate BCtableViewCell:self action:MTActivityBMZFTableViewCell indexPath:self.indexPath attribute:self.mod];
        }else if ([self.signBtu.titleLabel.text isEqualToString:@"付款成功"]) {
            [self.delegate BCtableViewCell:self action:MTActivityBMYZFTableViewCell indexPath:self.indexPath attribute:self.mod];
        }else if ([self.signBtu.titleLabel.text isEqualToString:@"立即报名"]){
         [self.delegate BCtableViewCell:self action:MTActivityBMTableViewCell indexPath:self.indexPath attribute:self.mod];
        }
    }
    
}

- (void)shareActivt:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
        [self.delegate BCtableViewCell:self action:MTActivityShareActivTableViewCell indexPath:self.indexPath attribute:self.mod];
    }
}
- (void)cancleBtnClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
        [self.delegate BCtableViewCell:self action:MTActivityQXBMTableViewCell indexPath:self.indexPath attribute:self.mod];
    }

}

- (void)collectActivt:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
        [self.delegate BCtableViewCell:self action:MTActivityCollectBMTableViewCell indexPath:self.indexPath attribute:self.mod];
    }
}
- (void)setDataWithModel:(ActivitiesListModel *)mod
{
    [_topImageView setImageAsyncWithURL:mod.activities_pic placeholderImage:DefaultImage_logo];
    if ([mod.huodongzhuangtai isEqualToString:@"1"]) {
        _zhuangtaiLabel.text = @"已截止报名";
        _zhuangtaiView.alpha = 0.8;
        _zhuangtaiView.hidden = NO;
        _zhuangtaiView.backgroundColor = kColor(@"#bdbdbd");
//        _zhuangtaiLabel.alpha = 0.5;
    }else if ([mod.huodongzhuangtai isEqualToString:@"3"]) {
        if ([mod.model isEqualToString:@"7"]) {
            _zhuangtaiLabel.text = @"投票进行中";
        }else {
            _zhuangtaiLabel.text = @"活动进行中";
        }
        
        
        _zhuangtaiView.hidden = NO;
        _zhuangtaiView.backgroundColor = kColor(@"#d24d4d");
        _zhuangtaiView.alpha = 0.5;
    }else if ([mod.huodongzhuangtai isEqualToString:@"2"]) {
        if ([mod.model isEqualToString:@"7"]) {
            _zhuangtaiLabel.text = @"投票未开始";
        }else {
           _zhuangtaiLabel.text = @"活动未开始";
        }
        
        _zhuangtaiView.hidden = NO;
        _zhuangtaiView.backgroundColor = kColor(@"#bdbdbd");
        _zhuangtaiView.alpha = 0.8;
    }else{
        _zhuangtaiView.hidden = YES;
    }
    
  
    
    if (mod.payment_amount == nil||[mod.payment_amount isEqualToString:@""]||[mod.payment_amount isEqualToString:@"0"]) {
        _priceLabel.text = [NSString stringWithFormat:@"免费"];
    }else {
        if ([self.ActvType isEqualToString:@"1"]) {
            _priceLabel.text = [NSString stringWithFormat:@"￥%@",mod.payment_amount];
        }else {
            _priceLabel.text = [NSString stringWithFormat:@"￥%.2f",[mod.payment_amount floatValue]/100];
        }

    }
   
//    if ([mod.model isEqualToString:@"7"]) {
//        _titileLabel.text = [NSString stringWithFormat:@"【投票】%@",mod.activities_titile];
//    }else if ([mod.model isEqualToString:@"8"]) {
//        _titileLabel.text = [NSString stringWithFormat:@"【众筹】%@",mod.activities_titile];
//    }else {
//        _titileLabel.text = [NSString stringWithFormat:@"【活动】%@",mod.activities_titile];
//    }
     _titileLabel.text = [NSString stringWithFormat:@"%@",mod.activities_titile];
    

    _signBtu.top = _collectBtu.top;
    _cancleBtu.top = _signBtu.top;

    
    _endTime.top = _obtainMoney.top;
    _endTime.text = [NSString stringWithFormat:@"截止日期：%@",[IHUtility FormatDateByString:mod.activities_expiretime]];
    if (![self.ActvType isEqualToString:@"1"]) {
        if ([mod.model isEqualToString:@"8"]) {
            if ([mod.crowd_status isEqualToString:@"1"]) {
                _endTime.textColor = cGrayLightColor;

            }else{
                    _endTime.attributedText = [IHUtility changePartTextColor:_endTime.text range:NSMakeRange(5, _endTime.text.length-5) value:RGB(232, 121, 117)];
            }
        }else{
            _endTime.textColor = cGrayLightColor;
        }
    }else{
        _endTime.textColor = cGrayLightColor;
    }
    
    if ([self.ActvType isEqualToString:@"1"])  {
        if ([mod.model isEqualToString:@"7"]) {
            _timeLabel.text = [NSString stringWithFormat:@"%@ ~ %@",[IHUtility FormatDateByStringStyle:mod.activities_starttime],
                               [IHUtility FormatDateByStringStyle:mod.activities_endtime]];
            _priceLabel.hidden = YES;
            
        }else {
            _priceLabel.hidden = NO;
            _timeLabel.text = [NSString stringWithFormat:@"%@ ~ %@",[IHUtility FormatDateByStringStyle:mod.activities_ExpireStarttime],
                               [IHUtility FormatDateByStringStyle:mod.activities_endtime]];
        }
        
    }else {
        _timeLabel.hidden = YES;
        _collectBtu.hidden = YES;
        _lookBtu.hidden = YES;
        _addressLabel.hidden =YES;
        _adressImageView.hidden = YES;
        
        _signBtu.hidden = NO;
        _cancleBtu.hidden = NO;
       
        if ([[NSString stringWithFormat:@"%@",mod.order_status] isEqualToString:@"0"]) {
            [self.signBtu setTitle:@"立即支付" forState:UIControlStateNormal];
            [self.signBtu setLayerMasksCornerRadius:7 BorderWidth:1 borderColor:[UIColor redColor]];
            [self.signBtu setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            _cancleBtu.hidden = NO;
            [self.signBtu setEnabled:YES];
        }else if ([[NSString stringWithFormat:@"%@",mod.order_status] isEqualToString:@"1"]) {
            [self.signBtu setTitle:@"付款成功" forState:UIControlStateNormal];
            [self.signBtu setLayerMasksCornerRadius:7 BorderWidth:1 borderColor:cGreenColor];
            [self.signBtu setTitleColor:cGreenColor forState:UIControlStateNormal];
            _cancleBtu.hidden = YES;
            [self.signBtu setEnabled:YES];
            
        }else if ([[NSString stringWithFormat:@"%@",mod.order_status] isEqualToString:@"2"]) {
            [self.signBtu setTitle:@"付款失败" forState:UIControlStateNormal];
            [self.signBtu setLayerMasksCornerRadius:7 BorderWidth:1 borderColor:[UIColor redColor]];
            [self.signBtu setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            _cancleBtu.hidden = YES;
            [self.signBtu setEnabled:YES];
        }else if ([[NSString stringWithFormat:@"%@",mod.order_status] isEqualToString:@"3"]) {
            [self.signBtu setTitle:@"已取消" forState:UIControlStateNormal];
            _cancleBtu.hidden = YES;
            [self.signBtu setEnabled:NO];
            [self.signBtu setLayerMasksCornerRadius:7 BorderWidth:1 borderColor:cGrayLightColor];
            [self.signBtu setTitleColor:cGrayLightColor forState:UIControlStateNormal];
        }
        
        
        if ([mod.model isEqualToString:@"8"]) {
            _totalMoney.hidden = NO;
            _obtainMoney.hidden = NO;
            _endTime.hidden = NO;
            _endTime.width = _backV.width - _obtainMoney.width - 24;
            _signBtu.hidden = YES;
            _cancleBtu.hidden = YES;
        }else {
            _endTime.hidden = YES;
            _signBtu.hidden = NO;
            _cancleBtu.hidden = NO;
            _totalMoney.hidden = YES;
            _obtainMoney.hidden = YES;
        }
    
            _endTime.right = _backV.width - 12;
    }

//    _backV.height = _collectBtu.bottom + 5;
}
@end




@implementation MTIdentTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImage *img=Image(@"jzztx.png");
        UIAsyncImageView *imageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(15, 20, img.size.width, img.size.height)];
        imageView.image=img;
        _headerImgView=imageView;
        [self.contentView addSubview:imageView];
        
        img=Image(@"jzztb.png");
        imageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(imageView.right+30, imageView.top, img.size.width, img.size.height)];
        
        imageView.image=img;
        _ImgView=imageView;
        [self.contentView addSubview:imageView];
        
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+5, imageView.top, 200, 21) textColor:RGB(245, 166, 35) textFont:sysFont(15)];
        _nickNameLbl=lbl;
        [self.contentView addSubview:lbl];
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.left, lbl.bottom+20, WindowWith-imageView.left-15, 66) textColor:cBlackColor textFont:sysFont(15)];
        lbl.numberOfLines=0;
        _titleLbl=lbl;
        [self.contentView addSubview:lbl];
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.left, lbl.bottom+20, 250, 15) textColor:RGB(245, 166, 35) textFont:sysFont(15)];
        _advantageLbl=lbl;
        [self.contentView addSubview:lbl];
        
        
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 299, WindowWith, 1)];
        lineView.backgroundColor=cLineColor;
        [self.contentView addSubview:lineView];
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame=CGRectMake(WindowWith-100, lineView.top-40, 80, 30);
        [btn setTitle:@"我要申请" forState:UIControlStateNormal];
        btn.backgroundColor=cGreenColor;
        _btn=btn;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(shenqing) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius=5;
        [self.contentView addSubview:btn];
    }
 
    
  return self;
}

-(void)btnhide
{
    _btn.enabled=NO;
    _btn.backgroundColor=RGB(239, 239, 239);
    
   
}

-(void)shenqing
{
    if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
        
        [self.delegate BCtableViewCell:self action:MTActivityBMTableViewCell indexPath:self.indexPath attribute:nil];
        
        
    }
}

-(void)setDataWithDic:(NSDictionary *)dic
{
    _headerImgView.image=Image(dic[@"headerImg"]);
    _ImgView.image=Image(dic[@"image"]);
    _nickNameLbl.text=dic[@"nickname"];
    
    CGSize size=[IHUtility GetSizeByText:dic[@"title"] sizeOfFont:15 width:WindowWith-_ImgView.left-15];
    _titleLbl.text=dic[@"title"];
    _titleLbl.size=CGSizeMake(size.width, size.height);
    
    NSArray *arr=dic[@"advantage"];
    for (NSInteger i=0; i<arr.count; i++) {
        _advantageLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(_titleLbl.left, _titleLbl.bottom+20+i*20, 250, 15) textColor:cBlackColor textFont:sysFont(15)];
        _advantageLbl.text=arr[i];
        [self.contentView addSubview:_advantageLbl];
    }
    
    
    
}



@end


@implementation MyTaskTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      
        SMLabel * tittle=[[SMLabel alloc]initWithFrameWith:CGRectMake(23, 14, 150, 21) textColor:RGB(108, 128, 138) textFont:sysFont(15)];
        tittle.text=@"请完善个人信息";
        _tittle=tittle;
        [self.contentView addSubview:tittle];
        
        UIButton * gradeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        gradeBtn.frame=CGRectMake(153, 14, 60, 21);
        [gradeBtn setImage:Image(@"gold1.png") forState:UIControlStateNormal];
        [gradeBtn setTitle:@"+100" forState:UIControlStateNormal];
        gradeBtn.titleLabel.font = sysFont(12);
        [gradeBtn setTitleColor:RGB(245, 166, 35) forState:UIControlStateNormal];
        _gradeBtn=gradeBtn;
        [self.contentView addSubview:gradeBtn];
        
        
        UIButton * finishBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [finishBtn setTitle:@"去完成" forState:UIControlStateNormal];
        finishBtn.backgroundColor=RGB(232, 121, 117);
      
        finishBtn.titleLabel.font=sysFont(15);
        
        [finishBtn addTarget:self action:@selector(goTask:) forControlEvents:UIControlEventTouchUpInside];
        finishBtn.layer.masksToBounds=YES;
        finishBtn.layer.cornerRadius=8.0;
        
        finishBtn.frame=CGRectMake(WindowWith-88, 10, 65, 30);
        _finishBtn=finishBtn;
        
        [self.contentView addSubview:finishBtn];
        
        
        
        
        
        
    }
    return self;
}
- (void)setDataWithDic:(NSDictionary *)dic withInfoDic:(NSDictionary *)dic2
{
    _tittle.text=dic[@"tittle"];
    
    CGSize size=[IHUtility GetSizeByText:dic[@"tittle"] sizeOfFont:15 width:150];
    _tittle.frame=CGRectMake(23, 14, size.width, 21);
    
    _gradeBtn.frame=CGRectMake(33+size.width, 14, 70, 21);
    
    
    [_gradeBtn setTitle:dic[@"grade"] forState:UIControlStateNormal];
    
    NSString * tag=dic[@"tag"];
    
    
    
    if ([dic2[tag] intValue]>0) {
            [_finishBtn setTitle:@"已完成" forState:UIControlStateNormal];
            [_finishBtn setTitleColor:RGB(6, 193, 174) forState:UIControlStateNormal];
            _finishBtn.backgroundColor=nil;
            _finishBtn.userInteractionEnabled=NO;
        }
  
   if ([dic[@"tittle"]isEqualToString:@"每日登陆"])
   {
       [_finishBtn setTitle:@"已完成" forState:UIControlStateNormal];
       [_finishBtn setTitleColor:RGB(6, 193, 174) forState:UIControlStateNormal];
       _finishBtn.backgroundColor=nil;
       _finishBtn.userInteractionEnabled=NO;
       
   }
    
    
}

- (void)goTask:(id)sender
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(goTask:)]) {
        [self.delegate goTask:sender];
    }
}
@end

@implementation ActivitiesClikeCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 0.5)];
        [self.contentView addSubview:lineView];
        lineView.backgroundColor=RGBA(232, 239, 239, 1);
        
        UIImage *img=Image(@"Roger Klotz.png");
        HeadButton *imageView=[[HeadButton alloc]initWithFrame:CGRectMake(0.02*WindowWith, 0.3*self.height, img.size.width, img.size.height)];
        [imageView.headBtn addTarget:self action:@selector(headTap:) forControlEvents:UIControlEventTouchUpInside];
        _heardView=imageView;
        [self.contentView addSubview:imageView];
        
        
        SMLabel *nickNameLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right + 8, 0, WindowWith,18) textColor:RGBA(108, 123, 138, 1) textFont:sysFont(14)];
        nickNameLbl.text=@"裴小欢";
        nickNameLbl.centerY = _heardView.centerY;
        _nicknamelbl=nickNameLbl;
        [self.contentView addSubview:nickNameLbl];
    }
    return self;
    
}

- (void)setUserInfo:(UserChildrenInfo *)model
{
    _model = model;
    [_heardView setHeadImageUrl:[NSString stringWithFormat:@"%@",model.heed_image_url] type:[model.identity_key intValue]];
    
    _nicknamelbl.text = model.nickname;

}
-(void)headTap:(UITapGestureRecognizer *)tap{
    if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
        [self.delegate BCtableViewCell:self action:MTHeadViewActionTableViewCell indexPath:self.indexPath attribute:_model];
    }
}
@end


