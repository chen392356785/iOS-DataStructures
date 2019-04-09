//
//  CustomView+CustomCategory.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/3/23.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "CustomView+CustomCategory.h"

@implementation CustomView (CustomCategory)

@end

@implementation EditInformationView
- (instancetype)initWithFrame:(CGRect)frame name:(NSString *)name
{
	self=[super initWithFrame:frame];
	if (self) {
		self.backgroundColor=[UIColor whiteColor];
		CGSize size=[IHUtility GetSizeByText:name sizeOfFont:15 width:200];
		SMLabel *lbl =[[SMLabel alloc]initWithFrameWith:CGRectMake(10, 15, size.width, size.height) textColor:cBlackColor textFont:sysFont(15)];
		lbl.text=name;
		[self addSubview:lbl];
		UIImage *img=Image(@"GQ_Left.png");
		UIImageView *imageView=[[UIImageView alloc]initWithImage:img];
		imageView.frame=CGRectMake(self.width-img.size.width, lbl.top+5, img.size.width, img.size.height);
		[self addSubview:imageView];
		
		img = Image(@"EP_IdentAuth.png");
		UIImageView *imageView1=[[UIImageView alloc]initWithImage:img];
		imageView1.frame=CGRectMake(imageView.left-img.size.width - 5, lbl.top+5, img.size.width, img.size.height);
		imageView1.centerY = self.height/2.0;
		imageView1.hidden = YES;
		self.imageView = imageView1;
		[self addSubview:imageView1];
		
		self.lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.right, lbl.top, self.width-lbl.width-imageView.size.width-imageView1.size.width-25, lbl.height) textColor: RGBA(189,202,219,1) textFont:sysFont(14)];
		if ([name isEqualToString:@"地址"]) {
			self.lbl.frame=CGRectMake(lbl.right+30, lbl.top, self.width-lbl.width-imageView.size.width-imageView1.size.width-25-30, lbl.height);
		}
		
		self.lbl.textAlignment=NSTextAlignmentRight;
		[self addSubview:self.lbl];
		
		UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headTap:)];
		[self addGestureRecognizer:tap];
	}
	return  self;
}








-(void)headTap:(UITapGestureRecognizer *)tap{
	
	self.selectBlock(SelectNameBlock);
	
}

@end

@implementation LabelView
- (instancetype)initWithFrame:(CGRect)frame
{  self=[super initWithFrame:frame];
	if (self) {
		
		CGFloat lblWidth=(frame.size.width-12)/2;
		for (int i=0; i<4; i++) {
			CGFloat x=0;
			CGFloat y=0;
			if (i<2) {
				x=i*(lblWidth+6);
				y=0;
			}else{
				x=(i-2)*(lblWidth+6);
				y=32;
			}
			
			SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(x, y, lblWidth, 25) textColor:RGB(189, 202, 219) textFont:sysFont(13)];
			[lbl setLayerMasksCornerRadius:5 BorderWidth:0.5 borderColor:RGB(85, 201, 196)];
			lbl.tag=100+i;
			[self addSubview:lbl];
			
			SMLabel *titlelbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(5, 2, 45, 21) textColor:RGBA(85, 201, 196, 1) textFont:sysFont(13)];
			titlelbl.text=@"";
			titlelbl.tag = 50 + i;
			titlelbl.textAlignment = NSTextAlignmentCenter;
			[lbl addSubview:titlelbl];
			
			SMLabel *datalbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(titlelbl.right, 2, lblWidth - 55, 21) textColor:RGB(189, 202, 219) textFont:sysFont(13)];
			datalbl.text=@"";
			datalbl.textAlignment = NSTextAlignmentCenter;
			datalbl.tag = 1000 + i;
			[lbl addSubview:datalbl];
			
		}
		
	}
	return self;
}


-(void)setData:(NSMutableArray *)arr{
	for (int i=0; i<arr.count; i++) {
		SMLabel *lbl=[self viewWithTag:100+i];
		SMLabel *titlelbl = [lbl viewWithTag:50+i];
		SMLabel *datalbl = [lbl viewWithTag:1000+i];
		
		NSString *text = [arr objectAtIndex:i];
		NSArray *strs = [text componentsSeparatedByString:@":"];
		titlelbl.text= [NSString stringWithFormat:@"%@:",strs[0]];
		datalbl.text = [NSString stringWithFormat:@"%@",strs[1]];
		lbl.hidden=NO;
	}
	int count=(int)arr.count;
	for (int i=100+count; i<104; i++) {
		SMLabel *btn=(SMLabel *)[self viewWithTag:i];
		btn.hidden=YES;
	}
}


@end


@implementation MapAnnotationView
- (instancetype)initWithFrame:(CGRect)frame name:(NSString *)name ifMust:(BOOL)ifMust
{
	self=[super initWithFrame:frame];
	if (self) {
		self.backgroundColor=[UIColor whiteColor];
		
		
		UIImage *photoimg=Image(@"redstar.png");
		UIImageView *photoImgView=[[UIImageView alloc]initWithImage:photoimg];
		photoImgView.frame=CGRectMake(20, 18, photoimg.size.width, photoimg.size.height);
		[self addSubview:photoImgView];
		if (ifMust) {
			photoImgView.hidden=NO;
		}else
		{
			photoImgView.hidden=YES;
		}
		CGSize size=[IHUtility GetSizeByText:name sizeOfFont:15 width:200];
		SMLabel *lbl =[[SMLabel alloc]initWithFrameWith:CGRectMake(photoImgView.right+15, photoImgView.top-3, size.width, size.height) textColor:cBlackColor textFont:sysFont(15)];
		lbl.text=name;
		[self addSubview:lbl];
		UIImage *img=Image(@"GQ_Left.png");
		
		UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headTap:)];
		[self addGestureRecognizer:tap];
		
		UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(photoImgView.left, self.height-1, WindowWith-photoImgView.left*2, 1)];
		lineView.backgroundColor=cLineColor;
		[self addSubview:lineView];
		
		UIImageView *imageView=[[UIImageView alloc]initWithImage:img];
		imageView.frame=CGRectMake(lineView.right, lbl.top+5, img.size.width, img.size.height);
		[self addSubview:imageView];
		
		self.lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.right, lbl.top, imageView.left-lbl.right-20, lbl.height) textColor: RGBA(189,202,219,1) textFont:sysFont(14)];
		self.lbl.textAlignment=NSTextAlignmentRight;
		[self addSubview:self.lbl];
		
		
		
		
		
		
	}
	return self;
}
-(void)headTap:(UITapGestureRecognizer *)tap{
	
	self.selectBlock(SelectNameBlock);
	
}


@end

@implementation CancelView
- (instancetype)initWithFrame:(CGRect)frame
{
	self=[super initWithFrame:frame];
	if (self) {
		UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 1)];
		lineView.backgroundColor=cLineColor;
		[self addSubview:lineView];
		self.backgroundColor=[UIColor whiteColor];
		
		
		UIImage *img=Image(@"fav_time.png");
		
		UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0.05*WindowWith, frame.size.height/2-img.size.height/2, img.size.width, img.size.height)];
		
		imageView.image=img;
		[self addSubview:imageView];
		
		
		SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+5,0, WindowWith, frame.size.height) textColor:RGBA(189,202,218,1) textFont:sysFont(13)];
		_timelbl=lbl;
		lbl.text=@"昨天 12：30";
		[self addSubview:lbl];
		
		UIImage *cancelImg=Image(@"cancel.png");
		self.cancelBtn =[UIButton buttonWithType:UIButtonTypeCustom];
		self.cancelBtn.frame=CGRectMake(0.80*WindowWith, 0, cancelImg.size.width+40, frame.size.height);
		[self.cancelBtn setImage:[cancelImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
		
		[self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
		[self.cancelBtn setTitleColor:cBlackColor forState:UIControlStateNormal];
		self.cancelBtn.titleLabel.font=sysFont(12);
		self.cancelBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 10, 0, 0);
		
		[self addSubview:self.cancelBtn];
		
		lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 39, WindowWith, 1)];
		lineView.backgroundColor=cLineColor;
		[self addSubview:lineView];
		
	}
	
	
	return self;
}
-(void)setData:(NSString *)time{
	NSDate *date=[IHUtility ConvertToDateFromString:time];
	_timelbl.text=[date formattedTime];
}

@end

@implementation HeaderView
-(instancetype)initWithFrame:(CGRect)frame
{   self=[super initWithFrame:frame];
	
	if (self) {
		self.backgroundColor=[UIColor whiteColor];
		UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 2)];
		[self addSubview:lineView];
		lineView.backgroundColor=RGBA(232, 239, 239, 1);
		
		UIImage *img=Image(@"headimage");
		HeadButton *headImageView=[[HeadButton alloc]initWithFrame:CGRectMake(0.05*WindowWith, frame.size.height/2-img.size.height/4, img.size.width/2, img.size.height/2)];
		_headView=headImageView;
		[headImageView.headBtn addTarget:self action:@selector(headTap:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:headImageView];
		
		
		
		
		
		SMLabel *nickNameLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(headImageView.right+8, headImageView.top+2, WindowWith, 18) textColor:cBlackColor textFont:sysFont(15)];
		nickNameLbl.text=@"裴小欢";
		_nicknamelbl=nickNameLbl;
		[self addSubview:nickNameLbl];
		
		nickNameLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(nickNameLbl.right+8, headImageView.top+2, WindowWith, 18) textColor:cGrayLightColor textFont:sysFont(13)];
		nickNameLbl.text=@"裴小欢";
		_jobLbl=nickNameLbl;
		[self addSubview:nickNameLbl];
		//判断性别
		UIImage *sexImg=Image(@"boy.png");
		UIImageView *sexImageView=[[UIImageView alloc]initWithFrame:CGRectMake(nickNameLbl.right+5, nickNameLbl.top+3, sexImg.size.width, sexImg.size.height)];
		_sexImgeView=sexImageView;
		sexImageView.image=sexImg;
		//        [self addSubview:sexImageView];
		
		UIImage *qiugongimg=Image(@"gongying.png");
		UIImageView *qiugongimageView=[[UIImageView alloc]initWithImage:qiugongimg];
		qiugongimageView.frame=CGRectMake(0.87*WindowWith, lineView.bottom, qiugongimg.size.width, qiugongimg.size.height);
		_typeImageView=qiugongimageView;
		//        [self addSubview:qiugongimageView];
		
		CGSize adressSize=[IHUtility GetSizeByText:@"浏阳正河园林有限公司" sizeOfFont:12 width:200];
		SMLabel *adressLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(nickNameLbl.left, nickNameLbl.bottom+5, adressSize.width, adressSize.height) textColor:cGrayLightColor textFont:sysFont(12)];
		adressLbl.text=@"浏阳正河园林有限公司";
		_addresslbl=adressLbl;
		[self addSubview:adressLbl];
		UIImage *adressImg=Image(@"m.png");
		
		UIImageView *adressImageView=[[UIImageView alloc]initWithFrame:CGRectMake(adressLbl.right+5, adressLbl.top, adressImg.size.width, adressImg.size.height)];
		_idtypeImageView=adressImageView;
		adressImageView.image=adressImg;
		//        [self addSubview:adressImageView];
		
		UIView *lineView2=[[UIView alloc]initWithFrame:CGRectMake(15, 59, WindowWith-30, 1)];
		[self addSubview:lineView2];
		lineView2.backgroundColor=RGBA(232, 239, 239, 1);
	}
	
	
	return self;
}

-(void)setData:(UserChildrenInfo *)model type:(buyType)type{
	[_headView setHeadImageUrl:model.heed_image_url type:[model.identity_key intValue]];
	
	
	CGSize size=[IHUtility GetSizeByText:model.nickname sizeOfFont:15 width:WindowWith-90];
	//    CGRect rect=_nicknamelbl.frame;
	//    rect.size.width=size.width;
	//    _nicknamelbl.frame=rect;
	
	_nicknamelbl.text=model.nickname;
	_nicknamelbl.width = size.width;
	
	if (model.title.length > 0&&![model.title isEqualToString:@"(null)"]) {
		
		_jobLbl.text = [NSString stringWithFormat:@"#%@",model.title];
	}else{
		_jobLbl.text = @" ";
	}
	CGSize jobsize=[IHUtility GetSizeByText:_jobLbl.text sizeOfFont:13 width:WindowWith-90];
	_jobLbl.width = jobsize.width;
	_jobLbl.left = _nicknamelbl.right + 8;
	
	if ([model.sexy integerValue]==2) {
		UIImage *sexImg=Image(@"girl.png");
		_sexImgeView.image=sexImg;
	}else {
		UIImage *sexImg=Image(@"boy.png");
		_sexImgeView.image=sexImg;
	}
	
	UIImage *img;
	if (type==ENT_Buy) {
		img=Image(@"buy_tag.png");
	}else if (type==ENT_Supply){
		img=Image(@"gongying.png");
	}else if (type==ENT_Topic){
		img=Image(@"huati_tag.png");
	}
	_typeImageView.image=img;
	
	_addresslbl.text=[NSString stringWithFormat:@"%@|%@ %@",model.company_province,model.company_name,model.position];
	if (model.company_province.length <= 0) {
		_addresslbl.text = [_addresslbl.text stringByReplacingOccurrencesOfString:@"|" withString:@""];
	}
	_addresslbl.text = [_addresslbl.text stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
	CGSize size1=[IHUtility GetSizeByText:_addresslbl.text sizeOfFont:12 width:WindowWith];
	_addresslbl.left = _nicknamelbl.left;
	_addresslbl.width = size1.width;
	
	UIImage *img1;
	int idType=[model.i_type_id intValue];
	if (idType==1) {
		img1=Image(@"m.png");
	}else if (idType==2){
		img1=Image(@"j.png");
	}else if (idType==3){
		img1=Image(@"g.png");
	}else if (idType==4){
		img1=Image(@"c.png");
	}
	_idtypeImageView.image=img1;
	
	if ([model.company_name isEqualToString:@""]) {
		_idtypeImageView.origin=CGPointMake(_addresslbl.left, _addresslbl.top);
	}
	
	
}



-(void)headTap:(UITapGestureRecognizer *)tap{
	
	self.selectBlock(SelectheadImageBlock);
	
}


@end

@implementation TopicBottomView
-(instancetype)initWithFrame:(CGRect)frame
{
	self=[super initWithFrame:frame];
	if (self) {
		self.backgroundColor=[UIColor whiteColor];
		
		//点赞
		UIImage *agreeImg=Image(@"agree.png");
		UIImage *agreeSelectedImg=Image(@"agree_select.png");
		CGSize agreeSize=[IHUtility GetSizeByText:@"45" sizeOfFont:14 width:100];
		UIButton *agreeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
		[agreeBtn setImage:[agreeImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
		[agreeBtn setImage:[agreeSelectedImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateSelected];
		[agreeBtn setTitle:@"45" forState:UIControlStateNormal];
		[agreeBtn setTitleColor:cBlackColor forState:UIControlStateNormal];
		agreeBtn.titleLabel.font=sysFont(14);
		_agreeBtn=agreeBtn;
		agreeBtn.frame=CGRectMake(WindowWith-0.05*WindowWith-agreeImg.size.width-agreeSize.width-5, frame.size.height/2-agreeImg.size.height/2, agreeImg.size.width+agreeSize.width+5, agreeImg.size.height);
		agreeBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
		
		[agreeBtn addTarget:self action:@selector(agree:) forControlEvents:UIControlEventTouchUpInside];
		
		[self addSubview:agreeBtn];
		//评论
		UIImage *commentImg=Image(@"comment.png");
		CGSize commentSize=[IHUtility GetSizeByText:@"45" sizeOfFont:14 width:100];
		UIButton *commentBtn=[UIButton buttonWithType:UIButtonTypeCustom];
		[commentBtn setImage:[commentImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
		[commentBtn setTitle:@"45" forState:UIControlStateNormal];
		[commentBtn setTitleColor:cBlackColor forState:UIControlStateNormal];
		commentBtn.titleLabel.font=sysFont(14);
		_commentBtn=commentBtn;
		commentBtn.frame=CGRectMake(agreeBtn.left-0.05*WindowWith-commentImg.size.width-commentSize.width-5, frame.size.height/2-commentImg.size.height/2, commentImg.size.width+commentSize.width+5, commentImg.size.height);
		commentBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
		[commentBtn addTarget:self action:@selector(commentTopic:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:commentBtn];
		
	}
	
	
	
	return self;
}
-(void)setData :(MTTopicListModel *)model{
	
	if (model.hasClickLike) {
		_agreeBtn.selected=YES;
	}else{
		_agreeBtn.selected=NO;
	}
	
	[_commentBtn setTitle:stringFormatInt(model.commentTotal) forState:UIControlStateNormal];
	[_agreeBtn setTitle:stringFormatInt(model.clickLikeTotal) forState:UIControlStateNormal];
	
}

-(void)agree:(UIButton *)sender
{
	
	if (sender.selected) {
		self.selectBlock(MTcancelAgreeActionTableViewCell);
	}else{
		self.selectBlock(MTAgreeActionTableViewCell);
	}
	
	//    UIButton *btn=(UIButton *)sender;
	//    btn.selected=YES;
	
}
- (void)commentTopic:(UIButton *)button
{
	self.selectBlock(MTCommentActionTableViewCell);
}

@end

@implementation CatapultView
-(instancetype)initWithFrame:(CGRect)frame withView:(UIView *)centerView
{
	self=[super initWithFrame:frame];
	if (self) {
		self.backgroundColor=RGBA(60, 79, 94, 0.7);
		
		
		_view =[[UIView alloc]init];
		
		_view.frame=CGRectMake(0, 0, kScreenWidth, kScreenHeight);
		CAKeyframeAnimation * animation;
		animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
		animation.duration = 0.4;
		animation.removedOnCompletion = NO;
		
		animation.fillMode = kCAFillModeForwards;
		
		NSMutableArray *values = [NSMutableArray array];
		[values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
		[values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
		[values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
		[values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
		
		animation.values = values;
		animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
		
		[_view.layer addAnimation:animation forKey:nil];
		[self addSubview:_view];
		
		UIImage *image=Image(@"catchword.png");
		self.imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, kScreenHeight*0.21, image.size.width, image.size.height)];
		self.imageView.tag=1008;
		self.imageView.centerX=_view.centerX;
		self.imageView.image=image;
		[_view addSubview:self.imageView];
		
		
		//centerView.frame=CGRectMake(15, CGRectGetMaxY(self.imageView.frame)+(kScreenHeight)*0.049, WindowWith-30, (WindowWith -30)*0.62);
		
		centerView.tag=1006;
		centerView.backgroundColor=[UIColor whiteColor];
		centerView.layer.cornerRadius=15;
		centerView.clipsToBounds=YES;
		[_view addSubview:centerView];
		
		
		UIButton *closeBtn=[UIButton buttonWithType:UIButtonTypeSystem];
		UIImage *img=Image(@"close_green.png");
		[closeBtn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
		closeBtn.frame=CGRectMake(CGRectGetWidth(centerView.frame)*0.9, 10, img.size.width, img.size.height);
		[centerView addSubview:closeBtn];
		[closeBtn addTarget:self action:@selector(hideView) forControlEvents:UIControlEventTouchUpInside];
		
		
		
		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
		
		[tap addTarget:self action:@selector(hideKeyboard)];
		[_view addGestureRecognizer:tap];
		
		
	}
	return self;
}


-(void)hideKeyboard
{
	UIView *centerView=[self viewWithTag:1006];
	[centerView endEditing:YES];
	
}

-(void)hideView
{
	//
	
	[UIView animateWithDuration:0.5
						  delay:0.0
						options:UIViewAnimationOptionCurveEaseInOut
					 animations:^{
						 self.alpha=0;
						 
					 }
					 completion:^(BOOL finished) {
						 [self removeFromSuperview];
						 self.selectBtnBlock(SelectBtnBlock);
					 }];
	
	
}



@end


@implementation ShareView
-(instancetype)initWithFrame:(CGRect)frame
{
	self=[super initWithFrame:frame];
	if (self) {
		UIView *centerView=[[UIView alloc]init];
		UIImage *image=Image(@"catchword.png");
		centerView.tag=1006;
		centerView.frame=CGRectMake(15, kScreenHeight*0.21+image.size.height+(kScreenHeight)*0.049, WindowWith-30, (WindowWith -30)*0.62);
		SMLabel *label=[[SMLabel alloc]initWithFrameWith:CGRectMake(CGRectGetWidth(centerView.frame)/2-10, 10, 50, 30) textColor:RGB(8, 206, 199) textFont:sysFont(17)];
		label.text=@"分  享";
		label.textAlignment=NSTextAlignmentLeft;
		label.centerX=centerView.width/2.0;
		[centerView addSubview:label];
		
		
		UIImage *img=Image(@"weixinshare.png");
		UIControl *WXControl=[[UIControl alloc]init];
		UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
		imageView.image=img;
		[WXControl addSubview:imageView];
		SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, imageView.bottom+20, 60, 16) textColor:cGrayLightColor textFont:sysFont(15)];
		lbl.text=@"微信好友";
		lbl.textAlignment=NSTextAlignmentCenter;
		[WXControl addSubview:lbl];
		WXControl.frame=CGRectMake((centerView.width/2.0 - img.size.width)/2.0, centerView.height*0.4, img.size.width, img.size.height+36);
		[WXControl addTarget:self action:@selector(weixinhaoyou) forControlEvents:UIControlEventTouchUpInside];
		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
		
		[tap addTarget:self action:@selector(weixinhaoyou)];
		[WXControl addGestureRecognizer:tap];
		
		[centerView addSubview:WXControl];
		
		img=Image(@"pengyouquan.png");
		UIControl *PYControl=[[UIControl alloc]init];
		imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
		imageView.image=img;
		[PYControl addSubview:imageView];
		lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, imageView.bottom+15, 75, 16) textColor:cGrayLightColor textFont:sysFont(15)];
		lbl.text=@"微信朋友圈";
		lbl.centerX=imageView.centerX;
		lbl.textAlignment=NSTextAlignmentCenter;
		[PYControl addSubview:lbl];
		PYControl.frame=CGRectMake((centerView.width/2.0 - WXControl.width-15)/2.0 + centerView.width/2.0, WXControl.top-5, WXControl.width+15, WXControl.height);
		[PYControl addTarget:self action:@selector(weixinpengyouquan) forControlEvents:UIControlEventTouchUpInside];
		[centerView addSubview:PYControl];
		tap = [[UITapGestureRecognizer alloc] init];
		
		[tap addTarget:self action:@selector(weixinpengyouquan)];
		[PYControl addGestureRecognizer:tap];
		CatapultView *catapultView=[[CatapultView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, kScreenHeight) withView:centerView];
		catapultView.tag=1001;
		catapultView.selectBtnBlock=^(NSInteger index)
		{
			[self removeFromSuperview];
		};
		[self addSubview:catapultView];
		
		
		
	}
	
	return self;
}


-(instancetype)initWithIsFriendFrame:(CGRect)frame
{
	self=[super initWithFrame:frame];
	if (self) {
		UIView *centerView=[[UIView alloc]init];
		centerView.tag=1006;
		centerView.frame=CGRectMake(0,0,self.width,self.height);
		centerView.centerX=self.centerX;
		self.centerView = centerView;
		
		UIImage *img=Image(@"yaoqingimg.png");
		UIAsyncImageView *imageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(0, 0, centerView.width, centerView.height*0.6)];
		imageView.image=img;
		[centerView addSubview:imageView];
		
		
		SMLabel *label=[[SMLabel alloc]initWithFrameWith:CGRectMake(20, imageView.bottom+0.04*centerView.height, self.width-40, 15) textColor:cBlackColor textFont:sysFont(15)];
		label.text=@"";
		label.numberOfLines = 0;
		_label = label;
		[centerView addSubview:label];
		
		UIButton *WXBtn=[UIButton buttonWithType:UIButtonTypeCustom];
		img=Image(@"Me_weixin.png");
		[WXBtn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
		[WXBtn setTitle:@"微信好友" forState:UIControlStateNormal];
		[WXBtn setTitleColor:cGrayLightColor forState:UIControlStateNormal];
		WXBtn.titleLabel.font=sysFont(15);
		WXBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 10, 0, 0);
		[WXBtn setLayerMasksCornerRadius:5 BorderWidth:1 borderColor:cGrayLightColor];
		WXBtn.frame=CGRectMake(20, label.bottom+25, (self.width - 70)/2.0, 40);
		[WXBtn addTarget:self action:@selector(weixinhaoyou) forControlEvents:UIControlEventTouchUpInside];
		[centerView addSubview:WXBtn];
		
		_WXBtn =WXBtn;
		
		
		UIButton *PYQBtn=[UIButton buttonWithType:UIButtonTypeCustom];
		img=Image(@"Me_pengyouquan.png");
		[PYQBtn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
		[PYQBtn setTitle:@"微信朋友圈" forState:UIControlStateNormal];
		[PYQBtn setTitleColor:cGrayLightColor forState:UIControlStateNormal];
		PYQBtn.titleLabel.font=sysFont(15);
		PYQBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 10, 0, 0);
		[PYQBtn setLayerMasksCornerRadius:5 BorderWidth:1 borderColor:cGrayLightColor];
		PYQBtn.frame=CGRectMake(WXBtn.right+30, WXBtn.top, (self.width - 70)/2.0, 40);
		[PYQBtn addTarget:self action:@selector(weixinpengyouquan) forControlEvents:UIControlEventTouchUpInside];
		[centerView addSubview:PYQBtn];
		_PYQBtn =PYQBtn;
		
		centerView.height = WXBtn.bottom + 20;
		
		[self addSubview:centerView];
		
		self.height = centerView.bottom;
	}
	
	return self;
}
- (void)setdata:(NSString *)content
{
	NSString *str = [NSString stringWithFormat:@"      %@",content];
	CGSize size = [IHUtility GetSizeByText:str sizeOfFont:15 width:WindowWith-40];
	_label.height = size.height;
	_label.text = str;
	
	_WXBtn.top = _label.bottom + 25;
	_PYQBtn.top = _WXBtn.top;
	
	self.centerView.height = _WXBtn.bottom + 20;
	self.height = self.centerView.bottom;
	
}

-(void)weixinhaoyou
{
	
	self.selectBtnBlock(SelectWXhaoyouBtnBlock);
}
-(void)weixinpengyouquan
{
	
	self.selectBtnBlock(SelectWXpengyouBtnBlock);
}

-(void)hideView
{
	
	[UIView animateWithDuration:1
						  delay:0.0
						options:UIViewAnimationOptionCurveEaseInOut
					 animations:^{
						 self.alpha=0;
						 
					 }
					 completion:^(BOOL finished) {
						 [self removeFromSuperview];
					 }];
	
	//    [UIView animateWithDuration:1 animations:^{
	//        self.alpha=0;
	//    } completion:^(BOOL finished) {
	//        [self removeFromSuperview];
	//    }];
	//
}


@end


@implementation CornerView


- (id)initWithFrame:(CGRect)frame count:(int)count {
	self = [super initWithFrame:frame];
	if (self) {
		UIImage *img=Image(@"msgpoint.png");
		img=[img stretchableImageWithLeftCapWidth:img.size.width/2 topCapHeight:img.size.height];
		int with=15;
		
		if (count>9) {
			with=20;
		}
		UIImageView *countImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, with,img.size.height)];
		_countImage=countImage;
		countImage.image=img;
		[self addSubview:countImage];
		if (count==0) {
			countImage.hidden=YES;
		}
		SMLabel *lbl=[[SMLabel alloc]initWithFrame:CGRectMake(0, 0, countImage.width, countImage.height)];
		lbl.textColor=[UIColor whiteColor];
		lbl.font=[UIFont systemFontOfSize:12];
		_numlbl=lbl;
		lbl.textAlignment=NSTextAlignmentCenter;
		lbl.text=[NSString stringWithFormat:@"%d",count];
		[countImage addSubview:lbl];
	}
	return self;
}

-(void)setNum:(int)num{
	
	int with=13;
	if (num>9) {
		with=15;
		
		if (num>99) {
			num=99;
		}
	}
	if (num>0) {
		_countImage.hidden=NO;
	}else{
		_countImage.hidden=YES;
	}
	UIImage *img=Image(@"msgpoint.png");
	_countImage.frame=CGRectMake(0, 0, with, img.size.height);
	_numlbl.frame=CGRectMake(0, 0, with, _numlbl.height);
	_numlbl.center=_countImage.center;
	_numlbl.text=[NSString stringWithFormat:@"%d",num];
	
}

@end



@implementation ActivityMidView
- (instancetype)initWithFrame:(CGRect)frame
{
	self=[super initWithFrame:frame];
	if (self) {
		UIImage *img=Image(@"Fill 1 Copy 2.png");
		UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, 10, img.size.width, img.size.height)];
		imageView.image=img;
		[self addSubview:imageView];
		
		SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+20, imageView.top, WindowWith - imageView.right -30 , 15) textColor:cBlackColor textFont:sysFont(15)];
		lbl.text=@"5月28日  13：00-18：30";
		_timelabel = lbl;
		[self addSubview:lbl];
		
		
		UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(imageView.left, imageView.bottom+15, WindowWith-30, 0.5)];
		lineView.backgroundColor=cLineColor;
		[self addSubview:lineView];
		
		img=Image(@"mappoint.png");
		imageView=[[UIImageView alloc]initWithFrame:CGRectMake(imageView.left, 15, img.size.width, img.size.height)];
		imageView.image=img;
		
		UIView *addressView = [[UIView alloc] initWithFrame:CGRectMake(0, lineView.bottom, self.width, img.size.height + 30)];
		[addressView addSubview:imageView];
		
		lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+20,0, self.width - imageView.right - 45, imageView.height + 30) textColor:cBlackColor textFont:sysFont(15)];
		lbl.text=@"西藏玛里亚索旗西西里艺术中心";
		_addressLabel = lbl;
		lbl.numberOfLines = 0;
		lbl.backgroundColor = [UIColor clearColor];
		addressView.userInteractionEnabled = YES;
		[addressView addSubview:lbl];
		
		img=Image(@"GQ_Left.png");
		UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(lineView.right-img.size.width,(addressView.height - img.size.height)/2.0, img.size.width, img.size.height)];
		imageview.image=img;
		imageView.centerY = _addressLabel.centerY;
		[addressView addSubview:imageview];
		[self addSubview:addressView];
		self.addressView = addressView;
		
		
		
		
	}
	
	return self;
}

- (void)setDataWith:(NSString *)time address:(NSString *)address unit_price:(NSString *)price endTime:(NSString *)endtime
{
	
	_timelabel.text = [NSString stringWithFormat:@"%@ 至 %@",[IHUtility FormatDateByString4:time],[IHUtility FormatDateByString4:endtime]];
	_addressLabel.text = address;
	
}

@end



@implementation ActivityDetailView
- (instancetype)initWithFrame:(CGRect)frame
{
	self=[super initWithFrame:frame];
	if (self) {
		
		SMLabel *detailLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(0, 20, 68, 16) textColor:cBlackColor textFont:sysFont(17)];
		detailLbl.text = @"活动详情";
		detailLbl.centerX = self.centerX;
		_lbl= detailLbl;
		detailLbl.textAlignment = NSTextAlignmentCenter;
		[self addSubview:detailLbl];
		
		UIImage *image = Image(@"Oval 299 Copy.png");
		UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, image.size.width, image.size.height)];
		imageview.image=image;
		imageview.right = detailLbl.left - 8;
		imageview.centerY = detailLbl.centerY;
		_imageview1 = imageview;
		[self addSubview:imageview];
		
		image = Image(@"Line Copy 4.png");
		UIImageView *leftlineImageview=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, image.size.width, image.size.height)];
		leftlineImageview.image=image;
		_imageview2 = leftlineImageview;
		leftlineImageview.right = imageview.left - 5.5;
		leftlineImageview.centerY = detailLbl.centerY;
		[self addSubview:leftlineImageview];
		
		UIImage *rightImage = Image(@"Oval 299 Copy.png");
		UIImageView *rightImageview=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, rightImage.size.width, rightImage.size.height)];
		rightImageview.image=rightImage;
		_imageview3 = rightImageview;
		rightImageview.left = detailLbl.right + 8;
		rightImageview.centerY = detailLbl.centerY;
		[self addSubview:rightImageview];
		
		rightImage = Image(@"Line4.png");
		UIImageView *lineRightImageview=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, rightImage.size.width, rightImage.size.height)];
		lineRightImageview.image=rightImage;
		lineRightImageview.left = rightImageview.right + 5.5;
		lineRightImageview.centerY = detailLbl.centerY;
		_imageview4 = lineRightImageview;
		[self addSubview:lineRightImageview];
		
		
		
		UIWebView * contentLbl = [[UIWebView alloc]initWithFrame:CGRectMake(20, detailLbl.bottom + 15,WindowWith-40, 1)];
		_contentLabel = contentLbl;
		contentLbl.delegate=self;
		[contentLbl.scrollView setScrollEnabled:NO];
		contentLbl.backgroundColor=[UIColor clearColor];
		[self addSubview:contentLbl];
		
		
	}
	
	return self;
}

-(void)setcontentText:(CGFloat)Height
{
	_contentLabel.height = Height;
	if (_contentLabel.height == 0) {
		self.height = _contentLabel.height;
		_lineView.top = 0;
		_lbl.hidden = YES;
		_imageview1.hidden = YES;
		_imageview2.hidden = YES;
		_imageview3.hidden = YES;
		_imageview4.hidden = YES;
		
	}
	
}

@end




@implementation MTOppcenteView
- (instancetype)initWithOrgane:(CGPoint)organe BtnType:(BtnType)BtnType
{      UIImage *img=Image(@"Group 4.png");
	img=[img stretchableImageWithLeftCapWidth:img.size.width/2 topCapHeight:img.size.height/2];
	self=[super initWithFrame:CGRectMake(organe.x, organe.y, 188 , 100)];
	if (self) {
		self.backgroundColor=[UIColor clearColor];
		
		
		
		UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 188, 100)];
		if (BtnType==ENT_RenMai){
			img=Image(@"Group 34.png");
			imageView.frame=CGRectMake(0, 0, img.size.width, img.size.height);
		}else if (BtnType==ENT_DianZan){
			img=Image(@"Group 4.png");
			imageView.frame=CGRectMake(0, 0, img.size.width, img.size.height);
		}else if (BtnType==ENT_FaBu){
			img=[Image(@"Group 1.png") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
			imageView.frame=CGRectMake(0, 0, img.size.width, img.size.height);
		}else if (BtnType==ENT_BiaoZhu){
			img=Image(@"Group 23.png");
			imageView.frame=CGRectMake(0, 0, img.size.width, img.size.height);
		}
		imageView.image=img;
		[self addSubview:imageView];
		
		
		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
		
		[tap addTarget:self action:@selector(hideSelfView)];
		imageView.userInteractionEnabled=YES;
		[self addGestureRecognizer:tap];
		
		
	}
	
	return self;
}


-(void)hideSelfView
{
	
	[UIView animateWithDuration:1 animations:^{
		
		[self removeFromSuperview];
	}];
	
	
	
}

@end




@implementation MTLogisticsChooseView
- (instancetype)initWithOrgane:(CGPoint)organe array:(NSArray *)arr
{
	self=[super initWithFrame:CGRectMake(organe.x, organe.y, WindowWith, 43)];
	if (self) {
		_arr = arr;
		for (NSInteger i=0; i<arr.count; i++) {
			_btn=[UIButton buttonWithType:UIButtonTypeCustom];
			_btn.frame=CGRectMake(((WindowWith- (arr.count -1))/arr.count + 1)*i, 0, (WindowWith- (arr.count -1))/arr.count, 43);
			[_btn setTitle:arr[i] forState:UIControlStateNormal];
			[_btn setTitleColor:cGrayLightColor forState:UIControlStateNormal];
			[_btn setTitleColor:cGreenColor forState:UIControlStateSelected];
			[_btn setTitleColor:cGreenColor forState:UIControlStateHighlighted];
			UIImage *img=Image(@"Triangle 1.png");
			UIImage *Img=Image(@"Triangle 2.png");
			
			if ([arr[i] isEqualToString:@"活跃度"]) {
				img = Image(@"vitality_low.png");
				Img = Image(@"vitality_high.png");
			}
			[_btn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
			[_btn setImage:[Img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateSelected];
			[_btn addTarget:self action:@selector(btnTap:) forControlEvents:UIControlEventTouchUpInside];
			_btn.titleLabel.font=sysFont(13);
			[self addSubview:_btn];
			
			_btn.tag=1000+i;
			
			CGSize size=[IHUtility GetSizeByText:arr[i] sizeOfFont:13 width:(WindowWith-36)/4.0];
			_btn.imageEdgeInsets=UIEdgeInsetsMake(0, size.width+3, 0, -size.width);
			_btn.titleEdgeInsets=UIEdgeInsetsMake(0, -img.size.width, 0, img.size.width+3);
			
			UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(_btn.right, 5, 1, 15)];
			lineView.centerY = self.height/2.0;
			lineView.backgroundColor=cLineColor;
			[self addSubview:lineView];
			
			
			lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 42, WindowWith, 1)];
			lineView.backgroundColor=cLineColor;
			[self addSubview:lineView];
			
			
			lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 3)];
			lineView.backgroundColor=cLineColor;
			//            [self addSubview:lineView];
			
			
			
		}
		
	}
	return self;
}

-(void)btnTap:(UIButton *)sender{
	for (NSInteger i=0; i<_arr.count; i++) {
		_btn=[self viewWithTag:i+1000];
		if (sender.tag != i+1000) {
			if (![_btn.titleLabel.text isEqualToString:@"活跃度"]) {
				_btn.selected=NO;
			}
			
		}
		
	}
	sender.selected=!sender.selected;
	if (sender.tag==1000) {
		self.selectBtnBlock(SelectStartBlock,sender);
	}else if (sender.tag==1001){
		self.selectBtnBlock(SelectEntBlock,sender);
	}else if (sender.tag==1002){
		self.selectBtnBlock(SelectTimeBlock,sender);
	}else if (sender.tag==1003){
		self.selectBtnBlock(SelectMoreBlock,sender);
	}
}


@end


@implementation SourceAdressView

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [UIColor whiteColor];
		
		NSArray *arr = @[@"出发地",@"到达地",@"货品名称",@"货品数量"];
		
		for (int i=0; i<arr.count; i++) {
			
			UIView *addressView = [[UIView alloc] initWithFrame:CGRectMake(0, 46 * i, kScreenWidth, 45)];
			addressView.backgroundColor =[UIColor whiteColor];
			
			SMLabel *label = [[SMLabel alloc] initWithFrameWith:CGRectMake(15, 0, 10, 10) textColor:RGB(232, 121, 117) textFont:sysFont(15)];
			label.centerY = addressView.height / 2.0;
			label.text = @"*";
			[addressView addSubview:label];
			
			SMLabel *label1 = [[SMLabel alloc] initWithFrameWith:CGRectMake(label.right + 7, 0, 60,15) textColor:RGB(108, 123, 138) textFont:sysFont(15)];
			label1.text = arr[i];
			label1.centerY = addressView.height / 2.0;
			[addressView addSubview:label1];
			
			UIImage *img=Image(@"GQ_Left.png");
			UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 6.5, 12)];
			imgView.image = img;
			imgView.centerY = addressView.height / 2.0;
			imgView.right = addressView.width - 20;
			[addressView addSubview:imgView];
			
			
			IHTextField *textFiled = [[IHTextField alloc] initWithFrame:CGRectMake(label1.right + 5, 0, imgView.left - label1.right - 10, 30)];
			textFiled.tag = 20+i;
			textFiled.font = sysFont(15);
			textFiled.textColor = RGB(189, 202, 219);
			textFiled.placeholder = @"未填写";
			textFiled.textAlignment = NSTextAlignmentRight;
			textFiled.centerY = addressView.height / 2.0;
			[addressView addSubview:textFiled];
			if (i==0) {
				_startAdressText = textFiled;
			}else if (i==1){
				_endAdressText = textFiled;
			}else if (i==2){
				textFiled.keyboardType = UIKeyboardTypeNamePhonePad;
				_goodNameText = textFiled;
			}else if (i==3){
				textFiled.keyboardType = UIKeyboardTypeNumberPad;
				_goodsNumText = textFiled;
			}
			
			[self addSubview:addressView];
			
			UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(18, addressView.bottom, self.width- 36, 1)];
			lineView.backgroundColor = RGB(233, 239, 239);
			[self addSubview:lineView];
			
			
		}
		
	}
	
	return self;
}

@end

@implementation CarTypeView

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		
		self.backgroundColor = [UIColor whiteColor];
		NSArray *arr = @[@"车辆类型 ",@"承运重量",@"承运体积",@"车辆数量"];
		
		for (int i=0; i<arr.count; i++) {
			
			UIView *addressView = [[UIView alloc] initWithFrame:CGRectMake(0, 46 * i, kScreenWidth, 45)];
			addressView.backgroundColor =[UIColor whiteColor];
			SMLabel *label = [[SMLabel alloc] initWithFrameWith:CGRectMake(15, 0, 10, 10) textColor:RGB(232, 121, 117) textFont:sysFont(15)];
			label.centerY = addressView.centerY;
			label.text = @"*";
			if (i>0) {
				label.hidden = YES;
			}
			[addressView addSubview:label];
			
			SMLabel *label1 = [[SMLabel alloc] initWithFrameWith:CGRectMake(label.right + 7, 0, 60,15) textColor:RGB(108, 123, 138) textFont:sysFont(15)];
			label1.text = arr[i];
			label1.centerY = addressView.height / 2.0;
			[addressView addSubview:label1];
			
			UIImage *img=Image(@"GQ_Left.png");
			UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 6.5, 12)];
			imgView.image = img;
			imgView.centerY = addressView.height / 2.0;
			imgView.right = addressView.width - 20;
			[addressView addSubview:imgView];
			
			IHTextField *textFiled = [[IHTextField alloc] initWithFrame:CGRectMake(label1.right + 5, 0, imgView.left - label1.right - 10, 30)];
			textFiled.tag = 30+i;
			textFiled.font = sysFont(15);
			textFiled.textColor = RGB(189, 202, 219);
			textFiled.textAlignment = NSTextAlignmentRight;
			textFiled.placeholder = @"未填写";
			textFiled.centerY = addressView.height / 2.0;
			[addressView addSubview:textFiled];
			if (i==0) {
				_carTypeText = textFiled;
			}else if (i==1){
				textFiled.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
				_bearWeightText = textFiled;
			}else if (i==2){
				textFiled.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
				_bearVolumeText = textFiled;
			}else if (i==3){
				textFiled.keyboardType = UIKeyboardTypeNumberPad;
				_carNumText = textFiled;
			}
			
			[self addSubview:addressView];
			
			UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(18, addressView.bottom, self.width- 36, 1)];
			lineView.backgroundColor = RGB(233, 239, 239);
			[self addSubview:lineView];
			
		}
		
	}
	
	return self;
}

@end

@implementation CarStartTimeView

- (instancetype)initWithFrame:(CGRect)frame array:(NSArray *)arr
{
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [UIColor whiteColor];
		
		for (int i=0; i<arr.count; i++) {
			
			UIView *addressView = [[UIView alloc] initWithFrame:CGRectMake(0, 46 * i, kScreenWidth, 45)];
			addressView.backgroundColor =[UIColor whiteColor];
			SMLabel *label = [[SMLabel alloc] initWithFrameWith:CGRectMake(15, 0, 10, 10) textColor:RGB(232, 121, 117) textFont:sysFont(15)];
			label.centerY = addressView.height / 2.0;
			if ([arr[i] isEqualToString:@"发车时间"]||[arr[i] isEqualToString:@"发货时间"]) {
				label.hidden = NO;
			}else {
				label.hidden = YES;
			}
			label.text = @"*";
			[addressView addSubview:label];
			
			SMLabel *label1 = [[SMLabel alloc] initWithFrameWith:CGRectMake(label.right + 7, 0, 60,15) textColor:RGB(108, 123, 138) textFont:sysFont(15)];
			label1.text = arr[i];
			self.titlelabel = label1;
			label1.centerY = addressView.height / 2.0;
			[addressView addSubview:label1];
			
			UIImage *img=Image(@"GQ_Left.png");
			UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 6.5, 12)];
			imgView.image = img;
			imgView.centerY = addressView.height / 2.0;
			imgView.right = addressView.width - 20;
			[addressView addSubview:imgView];
			
			
			IHTextField *textFiled = [[IHTextField alloc] initWithFrame:CGRectMake(label1.right + 5, 0, imgView.left - label1.right - 10, 30)];
			textFiled.tag = 40+i;
			textFiled.font = sysFont(15);
			textFiled.textColor = RGB(189, 202, 219);
			textFiled.placeholder = @"未填写";
			textFiled.textAlignment = NSTextAlignmentRight;
			textFiled.centerY = addressView.height / 2.0;
			_textfiled = textFiled;
			[addressView addSubview:textFiled];
			
			[self addSubview:addressView];
			
			UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(18, addressView.bottom, self.width- 36, 1)];
			lineView.backgroundColor = RGB(233, 239, 239);
			[self addSubview:lineView];
		}
		
	}
	
	return self;
}

@end

@implementation ActivtiesOrderView

- (id)initWithFrame:(CGRect)frame activImage:(NSString *)imageUrl price:(NSString *)price dic:(NSDictionary *)infoDic
{
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = RGBA(0, 0, 0, 0.3);
		
		UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 310)];
		bottomView.bottom = self.height;
		_bottomView = bottomView;
		bottomView.backgroundColor = [UIColor whiteColor];
		
		UIAsyncImageView *activImage =[[UIAsyncImageView alloc] initWithFrame:CGRectMake(13, -15, 87, 85)];
		[activImage setImageAsyncWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"yaoqingimg.png"]];
		[bottomView addSubview:activImage];
		
		SMLabel *moneyLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(activImage.right + 15 , 0, 0, 20) textColor:RGB(231, 121, 117) textFont:sysFont(18)];
		if (price == nil||[price isEqualToString:@""]||[price isEqualToString:@"0"]) {
			moneyLbl.text = [NSString stringWithFormat:@"免费"];
		}else {
			moneyLbl.text = [NSString stringWithFormat:@"￥%@",price];
		}
		[moneyLbl sizeToFit];
		moneyLbl.centerY = activImage.centerY;
		[bottomView addSubview:moneyLbl];
		
		UIImage *image = Image(@"cancleActivOrder.png");
		UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, image.size.width, image.size.height)];
		cancelBtn.right = self.width - 10;
		[cancelBtn setImage:image forState:UIControlStateNormal];
		[cancelBtn addTarget:self action:@selector(cancleOrder) forControlEvents:UIControlEventTouchUpInside];
		[bottomView addSubview:cancelBtn];
		
		//
		NSArray *infokey = [infoDic allKeys];
		NSMutableArray *arr = [NSMutableArray array];
		for (int j = 0; j<infokey.count; j++) {
			NSString *value = [NSString stringWithFormat:@"%@",[infoDic objectForKey:infokey[j]]];
			if ([value isEqualToString:@"1"]) {
				if ([infokey[j] isEqualToString:@"company"]) {
					[arr addObject:@"公司名称"];
				}else if ([infokey[j] isEqualToString:@"job"]){
					[arr addObject:@"职位"];
				}else if ([infokey[j] isEqualToString:@"name"]){
					[arr addObject:@"姓名"];
				}else if ([infokey[j] isEqualToString:@"mobile"]){
					[arr addObject:@"联系电话"];
				}
			}
		}
		
		bottomView.height =320 - 40*(4 - arr.count);
		bottomView.bottom = self.height;
		
		NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
		NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
		NSDictionary *Dic = [dictionary objectForKey:@"ActivtiesOrder"];
		
		for (int i =0; i<arr.count; i++) {
			
			UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, activImage.bottom + 40*i, self.width, 40)];
			[bottomView addSubview:backView];
			NSString *imageName  = [Dic objectForKey:arr[i]];
			UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]];
			
			UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(13, 0, img.size.width, img.size.height)];
			imageView.centerY = backView.height / 2.0;
			imageView.image = img;
			[backView addSubview:imageView];
			
			CGSize size = [IHUtility GetSizeByText:arr[i] sizeOfFont:16 width:150];
			SMLabel *label = [[SMLabel alloc] initWithFrameWith:CGRectMake(imageView.right + 6, 0, size.width, 22) textColor:RGB(108, 123, 138) textFont:sysFont(16)];
			label.centerY = imageView.centerY;
			label.text = arr[i];
			[backView addSubview:label];
			
			IHTextField *textFiled = [[IHTextField alloc] initWithFrame:CGRectMake(label.right + 8, label.top, self.width - label.right - 18, 22)];
			textFiled.textColor = RGB(51, 51, 51);
			textFiled.font = sysFont(16);
			if ([arr[i] isEqualToString:@"公司名称"]) {
				self.companyText = textFiled;
			}else if ([arr[i] isEqualToString:@"职位"]){
				self.jobText = textFiled;
			}else if ([arr[i] isEqualToString:@"姓名"]){
				self.nameText = textFiled;
			}else if ([arr[i] isEqualToString:@"联系电话"]){
				self.phoneText = textFiled;
				self.phoneText.delegate = self;
			}
			[backView addSubview:textFiled];
			
			UIView *linview = [[UIView alloc] initWithFrame:CGRectMake(textFiled.left, textFiled.bottom, textFiled.width, 0.5)];
			linview.backgroundColor = cLineColor;
			[backView addSubview:linview];
			
		}
		
		CGFloat bottom_space = kBottomNoSapce;
		UIButton *referBtn  = [[UIButton alloc] initWithFrame:CGRectMake(0, bottomView.height - 45-bottom_space, self.width, 45)];
		referBtn.backgroundColor = RGB(232, 121, 117);
		[referBtn setTitle:@"确定" forState:UIControlStateNormal];
		[referBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[bottomView addSubview:referBtn];
		self.referBtu = referBtn;
		[self addSubview:bottomView];
		
		
		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideView:)];
		tap.numberOfTapsRequired = 1;
		tap.numberOfTouchesRequired= 1;
		[self addGestureRecognizer:tap];
		//****IQKeyboard
		//        [[NSNotificationCenter defaultCenter] addObserver:self
		//                                                 selector:@selector(keyboardWasShown:)
		//                                                     name:UIKeyboardWillShowNotification object:nil];
		//
		//        [[NSNotificationCenter defaultCenter] addObserver:self
		//                                                 selector:@selector(keyboardWillBeHidden:)
		//                                                     name:UIKeyboardWillHideNotification object:nil];
		
	}
	
	return self;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	if (textField == _phoneText && range.location>=11) {
		return NO;
	}
	return YES;
}
- (void)cancleOrder
{
	[UIView animateWithDuration:.3 animations:^{
		self.backgroundColor = RGBA(0, 0, 0, 0);
	} completion:^(BOOL finished) {
		self.top = WindowHeight;
		[self endEditing:YES];
	}];
}
- (void)hideView:(UITapGestureRecognizer *)tap
{
	
	CGPoint point = [tap locationInView:self];
	if (!CGRectContainsPoint(_bottomView.frame, point)) {
		[self cancleOrder];
	}
	
}


//- (void)keyboardWasShown:(NSNotification*)aNotification
//{
//    NSDictionary* info = [aNotification userInfo];
//    //kbSize即為鍵盤尺寸 (有width, height)
//    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
//
//    _bottomView.bottom = self.height - kbSize.height + 50;
//
//
//}
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
	_bottomView.bottom = self.height;
	
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}
@end


@implementation SearchView

- (id)initWithFrame:(CGRect)frame
{
	
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor=RGB(247, 248, 280);
		UIView *view = [[UIView alloc] initWithFrame:CGRectMake(7, 0, self.width - 61 , 30)];
		view.backgroundColor =[UIColor whiteColor];
		view.centerY = self.height/2.0;
		view.layer.cornerRadius = 4.0;
		[self addSubview:view];
		
		UIImage *img = Image(@"EP_search.png");
		UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake(6, 0, img.size.width, img.size.height)];
		imageView.image = img;
		imageView.centerY = view.height/2.0;
		[view addSubview:imageView];
		
		UITextField *textfiled = [[UITextField alloc] initWithFrame:CGRectMake(imageView.right + 8, 0, view.width - imageView.right -15, 30)];
		textfiled.font = sysFont(14);
		self.textfiled = textfiled;
		textfiled.backgroundColor=[UIColor whiteColor];
		textfiled.placeholder = @" 请输入搜索关键词";
		
		textfiled.clearButtonMode = UITextFieldViewModeWhileEditing;
		textfiled.delegate = self;
		textfiled.returnKeyType = UIReturnKeySearch;
		[view addSubview:textfiled];
		
		UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
		button.frame = CGRectMake(view.right + 7, 0, 40, 30);
		button.centerY = self.height/2.0;
		[button setTitle:@"取消" forState:UIControlStateNormal];
		[button setTitleColor:cGrayLightColor forState:UIControlStateNormal];
		button.titleLabel.font = sysFont(14);
		self.button = button;
		button.backgroundColor=RGB(247, 248, 250);
		self.button.hidden=YES;
		[button addTarget:self action:@selector(cancle:) forControlEvents:UIControlEventTouchUpInside];
		
		[self addSubview:button];
	}
	
	return self;
}

- (void)cancle:(UIButton *)button
{   self.button.hidden=YES;
	self.selectBtnBlock(SelectBackVC);
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{   self.button.hidden=NO;
	self.selectBtnBlock(openBlock);
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
	self.selectBtnBlock(SelectBtnBlock);
	[textField resignFirstResponder];
	return YES;
}
@end

@implementation bindGoodView

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		
		self.backgroundColor = RGBA(0, 0, 0, 0.3);
		UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(20, 0, WindowWith-40, 277)];
		backView.center = self.center;
		//        _backView= backView;
		backView.backgroundColor = [UIColor whiteColor];
		[self addSubview:backView];
		
		SMLabel *detailLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(0, 18, 100, 16) textColor:RGB(6, 193, 174) textFont:sysFont(15)];
		detailLbl.text = @"绑定企业";
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
		
		NSString *str = @"一.其它用户可以在地图上找到你和你的企业位置。\n\n二. 在企业主页上会同步显示你及你的同事所发布的动态（包括供应与求购信息）。\n\n三.你的个人名片上会同步显示你的企业信息，有利于企业宣传。";
		SMLabel *label = [[SMLabel alloc] initWithFrameWith:CGRectMake(25, detailLbl.bottom + 24 , backView.width - 50, 100) textColor:cGrayLightColor textFont:sysFont(14)];
		label.text = str;
		label.numberOfLines = 0;
		[label sizeToFit];
		
		[backView addSubview:label];
		
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
	[self hiden];
}

- (void)hiden{
	
	[UIView animateWithDuration:1 animations:^{
		self.alpha = 0;
	} completion:^(BOOL finished) {
		[self removeFromSuperview];
	}];
	
}

@end

@implementation WeatherOtherInfoView

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		
		UIAsyncImageView *imageView = [[UIAsyncImageView alloc] initWithFrame:CGRectMake(15, 0, 30.5, 30.5)];
		_imageView =imageView;
		imageView.image= defalutHeadImage;
		imageView.centerY = self.height/2.0;
		[self addSubview:imageView];
		
		SMLabel *nameLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(0, 0,self.width - imageView.right - 20, 20) textColor:[UIColor whiteColor] textFont:sysFont(15)];
		_nameLbl = nameLbl;
		nameLbl.textAlignment = NSTextAlignmentRight;
		nameLbl.right = self.width - 12;
		nameLbl.bottom = self.height/2.0;
		[self addSubview:nameLbl];
		
		UIImageView *downImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 8, 8)];
		downImg.image = Image(@"weather_jiantou.png");
		downImg.right = self.width - 12;
		[self addSubview:downImg];
		
		SMLabel *contentLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(0, 0, self.width - imageView.right - 20, 20) textColor:RGB(203, 203, 203) textFont:sysFont(13)];
		contentLbl.text= @"不宜";
		contentLbl.textAlignment = NSTextAlignmentRight;
		contentLbl.right = downImg.left - 3;
		contentLbl.top = self.height/2.0;
		_contentLbl = contentLbl;
		[self addSubview:contentLbl];
		
		downImg.centerY = contentLbl.centerY;
		
		
	}
	
	return self;
}

- (void)setWeatherData:(NSString *)name content:(NSString *)content image:(UIImage *)image
{
	
	_imageView.image = image;
	
	_nameLbl.text = name;
	
	_contentLbl.text = content;
	
}
@end











