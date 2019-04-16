//
//  CustomView.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/3/15.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "CustomView.h"

@interface CustomView()

@end

@implementation CustomView

@end

//表头
#pragma 看过的人
@implementation MTTopView
- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		
		self.backgroundColor=[UIColor whiteColor];
		//        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 5)];
		//        [self addSubview:lineView];
		//        lineView.backgroundColor=RGBA(232, 239, 239, 1);
		
		UIImage *img=Image(@"look_me.png");
		UIImageView *imageView=[[UIImageView alloc]initWithImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
		imageView.frame=CGRectMake(10, frame.size.height/2-img.size.height/2, img.size.width, img.size.height);
		[self addSubview:imageView];
		
		
		SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+10, 0, 64, 20) textColor:RGBA(123, 126, 129, 1) textFont:sysFont(13)];
		_contentlbl=lbl;
		lbl.text=@"看过我的";
		lbl.centerY = self.height/2.0;
		//lbl.text=@"刚刚看过你的主页";
		[self addSubview:lbl];
		
		CornerView *view=[[CornerView alloc]initWithFrame:CGRectMake(_contentlbl.right, _contentlbl.top, 15, 10) count:1];//
		_cornerview=view;
		_cornerview.centerY = lbl.centerY;
		[self addSubview:view];
		
		LookMeView *lookView=[[LookMeView alloc]initWithFrame:CGRectMake(WindowWith-130, 16, 107, 40)];
		_lookView=lookView;
		[self addSubview:lookView];
		
		UIImage *toImg=Image(@"GQ_Left.png");
		UIImageView *toImageView=[[UIImageView alloc]initWithImage:toImg];
		toImageView.frame=CGRectMake(frame.size.width-17, frame.size.height/2-toImg.size.height/2, toImg.size.width, toImg.size.height);
		[self addSubview:toImageView];
		
		
		UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headTap:)];
		[self addGestureRecognizer:tap];
		
		UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(64, frame.size.height -0.5, WindowWith - 64, 0.5)];
		lineView.backgroundColor = RGB(221, 221, 223);
		[self addSubview:lineView];
		
	}
	
	return self;
}

-(void)headTap:(UITapGestureRecognizer *)tap{
	
	self.selectBlock(SelectTopViewBlock);
	
}

-(void) setData:(NSArray *)arr num:(int)num{
	if (num>0) {
		//        NSDictionary *dic=[arr objectAtIndex:0];
		//        _nicknamelbl.text=[NSString stringWithFormat:@"%d",num];
		[_lookView setData:arr num:num];
		
		_cornerview.hidden=NO;
		[_cornerview setNum:num];
		
		_lookView.hidden=NO;
	}else{
		_lookView.hidden=YES;
		//         _contentlbl.text=@"看过我的";
		//        _contentlbl.centerY = self.height/2.0;
		_cornerview.hidden=YES;
	}
	
}

@end

@implementation CommentMeView

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		
		self.backgroundColor=[UIColor whiteColor];
		
		UIImage *img=Image(@"comment_me.png");
		UIImageView *imageView=[[UIImageView alloc]initWithImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
		imageView.frame=CGRectMake(10, frame.size.height/2-img.size.height/2, img.size.width, img.size.height);
		[self addSubview:imageView];
		
		
		
		SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+10, 0, 150, frame.size.height) textColor:RGBA(123, 126, 129, 1) textFont:sysFont(13)];
		
		lbl.text=@"评论我的";
		//lbl.text=@"刚刚看过你的主页";
		[self addSubview:lbl];
		
		CornerView *view=[[CornerView alloc]initWithFrame:CGRectMake(135, frame.size.height/2-5-3, 15, 10) count:2];//
		_cornerview=view;
		
		[self addSubview:view];
		
		UIImage *toImg=Image(@"GQ_Left.png");
		UIImageView *toImageView=[[UIImageView alloc]initWithImage:toImg];
		toImageView.frame=CGRectMake(frame.size.width-17, frame.size.height/2-toImg.size.height/2, toImg.size.width, toImg.size.height);
		[self addSubview:toImageView];
		
		
		UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headTap:)];
		[self addGestureRecognizer:tap];
		
		UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(64, frame.size.height -0.5, WindowWith - 64, 0.5)];
		lineView.backgroundColor = RGB(221, 221, 223);
		[self addSubview:lineView];
	}
	
	return self;
}

-(void)setData:(int)num{
	[_cornerview setNum:num];
}

-(void)headTap:(UITapGestureRecognizer *)tap{
	
	self.selectBlock(SelectTopViewBlock);
	
}



@end

@implementation GroupView


- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		
		self.backgroundColor=[UIColor whiteColor];
		
		UIImage *img=Image(@"chat_Group.png");
		UIImageView *imageView=[[UIImageView alloc]initWithImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
		imageView.frame=CGRectMake(10, frame.size.height/2-img.size.height/2, img.size.width, img.size.height);
		[self addSubview:imageView];
		
		SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+10, 0, 150, frame.size.height) textColor:RGBA(123, 126, 129, 1) textFont:sysFont(13)];
		
		lbl.text=@"推荐圈子";
		//lbl.text=@"刚刚看过你的主页";
		[self addSubview:lbl];
		
		UIImage *toImg=Image(@"GQ_Left.png");
		UIImageView *toImageView=[[UIImageView alloc]initWithImage:toImg];
		toImageView.frame=CGRectMake(frame.size.width-17, frame.size.height/2-toImg.size.height/2, toImg.size.width, toImg.size.height);
		[self addSubview:toImageView];
		
		UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headTap:)];
		[self addGestureRecognizer:tap];
		
		UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(64, frame.size.height -0.5, WindowWith - 64, 0.5)];
		lineView.backgroundColor = RGB(221, 221, 223);
		[self addSubview:lineView];
		
	}
	
	return self;
}


-(void)headTap:(UITapGestureRecognizer *)tap{
	
	self.selectBlock(SelectTopViewBlock);
	
}


@end


@implementation LookMeView

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		
		for (int i=0; i<3; i++) {
			UIAsyncImageView *imageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(i*(40*0.55),0 , 40, 40)];
			[imageView setLayerMasksCornerRadius:20 BorderWidth:0.5 borderColor:[UIColor whiteColor]];
			imageView.tag=100+i;
			[self addSubview:imageView];
		}
		
	}
	
	return self;
}

-(void)setData:(NSArray *)arr num:(int)num{
	
	if (num>3) {
		num=3;
	}
	
	int count=num;
	if (arr.count<num) {
		count=(int)arr.count;
	}
	
	for (int i=0; i<count; i++) {
		NSDictionary *dic=[arr objectAtIndex:i];
		NSString *str=dic[@"heed_image_url"];
		UIAsyncImageView *imgView=[self viewWithTag:100+i];
		[imgView setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@%@",ConfigManager.ImageUrl,str,smallHeaderImage] placeholderImage:defalutHeadImage];
		imgView.hidden=NO;
	}
	
	for (int i=100+count; i<104; i++) {
		UIAsyncImageView *btn=(UIAsyncImageView *)[self viewWithTag:i];
		btn.hidden=YES;
	}
	
}

@end

#pragma 点赞的人
@implementation AgreeView
- (instancetype)initWithFrame:(CGRect)frame number:(NSString *)number {
	
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor=[UIColor whiteColor];
		UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 5)];
		[self addSubview:lineView];
		lineView.backgroundColor=RGBA(232, 239, 239, 1);
		
		UIScrollView *scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, lineView.bottom, WindowWith-62, 45)];
		_scroll=scroll;
		[self addSubview:scroll];
		
		SMLabel *lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(10, 0, self.width -20, 15) textColor:cGrayLightColor textFont:sysFont(15)];
		lbl.text = @"暂无点赞";
		lbl.hidden= YES;
		lbl.centerY = self.height/2.0;
		_lbl= lbl;
		[self addSubview:lbl];
		
		UIView *lineView2=[[UIView alloc]initWithFrame:CGRectMake(scroll.right ,scroll.top+10, 1,scroll.height-20)];
		lineView2.backgroundColor=RGBA(232, 239, 239, 1);
		//[self addSubview:lineView2];
		
		UIImage *agreeImg=Image(@"GongQiuDetails_zan.png");
		UIImage *selectImg=Image(@"GongQiuDetails_iszan.png");
		UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
		btn.frame=CGRectMake(lineView2.right, scroll.top, 62, 30);
		self.agreeBtn=btn;
		self.agreeBtn.centerY=scroll.centerY;
		[btn setImage:[agreeImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
		[btn setImage:[selectImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
		[btn setImage:[selectImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
		btn.imageEdgeInsets=UIEdgeInsetsMake(0, -10, 0,0);
		[btn setTitleColor:cGrayLightColor forState:UIControlStateNormal];
		[btn setTitle:number forState:UIControlStateNormal];
		[btn addTarget:self action:@selector(agree:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:btn];
		btn.backgroundColor=RGB(246, 247, 249);
		btn.layer.cornerRadius=15;
		btn.titleLabel.font=sysFont(12);
		
		lineView=[[UIView alloc]initWithFrame:CGRectMake(0, scroll.bottom, WindowWith, 5)];
		[self addSubview:lineView];
		lineView.backgroundColor=RGBA(232, 239, 239, 1);
	}
	
	return self;
}

-(void)setAddNum:(int)num{
	//agreeBtn.selected=YES;
	[self.agreeBtn setTitle:stringFormatInt(num) forState:UIControlStateNormal];
}

-(void)setData:(NSArray *)arr totalNum:(NSString *)totalNum hasClickLike:(BOOL)hasClickLike{
	
	
	
	[_scroll removeAllSubviews];
	
	if (arr.count <= 0) {
		_lbl.hidden= NO;
	}else{
		_lbl.hidden= YES;
	}
	
	for ( int i=0; i<arr.count; i++) {
		UserChildrenInfo *mod=[arr objectAtIndex:i];
		HeadButton *btn=[[HeadButton alloc]initWithFrame:CGRectMake(10+i*35, 8, 30, 30)];
		[btn setHeadImageUrl:[NSString stringWithFormat:@"%@",mod.heed_image_url] type:[mod.identity_key intValue]];
		btn.headBtn.tag=i+100;
		[btn.headBtn addTarget:self action:@selector(headClick:) forControlEvents:UIControlEventTouchUpInside];
		[_scroll addSubview:btn];
	}
	
	
	[self.agreeBtn setTitle:stringFormatString(totalNum) forState:UIControlStateNormal];
	
	
	self.agreeBtn.selected=hasClickLike;
	
	_scroll.contentSize=CGSizeMake(arr.count*35+20, _scroll.height);
	
	
}
-(void)agree:(UIButton *)sender
{
	
	UIImage *agreeImg=Image(@"GongQiuDetails_zan.png");
	UIImage *selectImg=Image(@"GongQiuDetails_iszan.png");
	
	self.agreeBtn.selected = !self.agreeBtn.selected;
	if (self.agreeBtn.selected) {
		self.selectBlock(agreeBlock);
		[sender setImage:[selectImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
		
		
	}else{
		self.selectBlock(cancelagreeBlock);
		[sender setImage:[agreeImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
	}
	
}

-(void)headClick:(UIButton *)btn{
	int index=(int)btn.tag-100;
	self.selectBlock(index);
	
}


@end


@implementation CustomAgreeView {
	BOOL IsClickAgree;
}

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = cBgColor;
		[self createSubView];
	}
	
	return self;
}
- (void) createSubView {
	UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, width(self) - 110, 20)];
	dateLabel.font = sysFont(16);
	[self addSubview:dateLabel];
	dateLabel.centerY =  height(self)/2.;
	dateLabel.text = @"7月15";
	dateLabel.textColor = kColor(@"#666666");
	_TimeLabel = dateLabel;
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
	button.frame = CGRectMake(width(self) - 44, 0, 20, 20);
	button.centerY =  height(self)/2 - 3.;
	[button addTarget:self action:@selector(AgerrAction) forControlEvents:UIControlEventTouchUpInside];
	_agreeBut = button;
	[self addSubview:button];
	
	UIButton *liuyanBut = [UIButton buttonWithType:UIButtonTypeSystem];
	liuyanBut.frame = CGRectMake(minX(button) - 44, 0, 20, 20);
	liuyanBut.centerY = height(self)/2.;
	[self addSubview:liuyanBut];
	[liuyanBut setImage:[Image(@"da_pinglun")imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
	[liuyanBut addTarget:self action:@selector(LiuyangAction) forControlEvents:UIControlEventTouchUpInside];
	
}
- (void)setSubViewData:(MTSupplyAndBuyListModel*)model{
	NSString *s = [IHUtility compareCurrentTimeString:model.uploadtime];
	_TimeLabel.text = [NSString stringWithFormat:@"发布时间：%@",s];
	IsClickAgree = model.hasClickLike;
	[self setButtonImage:IsClickAgree];
}
- (void)LiuyangAction {
	self.liuyanBlock();
}
- (void)AgerrAction {
	if (!USERMODEL.isLogin) {
		self.AgreeBlock(IsClickAgree);
		return ;
	}
	IsClickAgree = !IsClickAgree;
	self.AgreeBlock(IsClickAgree);
	[self setButtonImage:IsClickAgree];
}
- (void) setButtonImage:(BOOL) isClick {
	if (isClick == YES) {
		[_agreeBut setImage:[Image(@"zanSel") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
	}else {
		[_agreeBut setImage:[Image(@"zanGQ") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
	}
}
@end

#pragma mark  评论数
@implementation CommentNumberView

- (instancetype)initWithOrgin:(CGPoint)orgin  number:(NSString *)number{
	
	self = [super initWithFrame:CGRectMake(orgin.x, orgin.y, WindowWith, 40)];
	if (self) {
		
		[self creatViewWithNumber:number];
	}
	
	return self;
}

-(void)creatViewWithNumber:(NSString *)number
{
	UIView *view=[[UIView alloc]initWithFrame:self.bounds];
	view.backgroundColor=[UIColor whiteColor];
	[self addSubview:view];
	
	
}





@end


#pragma mark 评论cell
@implementation CommentCellView
- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self creatView];
		
	}
	
	return self;
}
-(void)creatView
{
	UIView *view=[[UIView alloc]initWithFrame:self.bounds];
	view.backgroundColor=[UIColor whiteColor];
	[self addSubview:view];
	UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 1)];
	[view addSubview:lineView];
	lineView.backgroundColor=RGBA(232, 239, 239, 1);
	
	UIImage *img=Image(@"Roger Klotz.png");
	UIAsyncImageView *imageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(0.02*WindowWith, 0.3*self.height, img.size.width, img.size.height)];
	imageView.image=img;
	imageView.userInteractionEnabled=YES;
	
	UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headTap:)];
	[imageView addGestureRecognizer:tap];
	
	[view addSubview:imageView];
	
	
	CGSize nameSize=[IHUtility GetSizeByText:@"裴小欢" sizeOfFont:14 width:200];
	SMLabel *nickNameLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+8, imageView.top+2, nameSize.width, nameSize.height) textColor:RGBA(108, 123, 138, 1) textFont:sysFont(14)];
	nickNameLbl.text=@"裴小欢";
	[view addSubview:nickNameLbl];
	
	
	CGSize messSize=[IHUtility GetSizeByText:@"非常不错，有想法,希望有时间过去看看" sizeOfFont:15 width:(WindowWith-(imageView.right+8)*2)];
	SMLabel *messLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(nickNameLbl.left, nickNameLbl.bottom+5, messSize.width, messSize.height) textColor:RGBA(108, 123, 138, 1) textFont:sysFont(15)];
	messLbl.text=@"非常不错，有想法,希望有时间过去看看";
	messLbl.numberOfLines=0;
	[view addSubview:messLbl];
	
	
	
	
	CGSize timeSize=[IHUtility GetSizeByText:@"昨天 11:25" sizeOfFont:10 width:200];
	SMLabel *timeLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(messLbl.right, nickNameLbl.top+5, timeSize.width, timeSize.height) textColor:RGBA(189, 202, 219, 1) textFont:sysFont(10)];
	timeLbl.text=@"昨天 11:25";
	[view addSubview:timeLbl];
	
}


-(void)headTap:(UITapGestureRecognizer *)tap{
	
	self.selectBlock(SelectheadImageBlock);
	
}



@end



#pragma mark 底部悬浮按钮View
@implementation BottomView
- (instancetype)initWithisSelf:(BOOL)isSelf type:(CollecgtionType)type
{
	//    CGFloat hhhh = kBottomNoSapce;
	//    CGFloat navi_h = kNavigationHeight;
	self = [super initWithFrame:CGRectMake(0,iPhoneHeight - KtopHeitht - 45, WindowWith, 45)];
	if (self) {
		CGRect rect = self.bounds;
		rect.origin.y = -5;
		self.backgroundColor=[UIColor whiteColor];
		self.layer.masksToBounds = NO;
		self.layer.shadowOffset = CGSizeMake(0, 3);
		self.layer.shadowOpacity = 0.2;
		self.layer.shadowPath = [UIBezierPath bezierPathWithRect:rect].CGPath;
		self.layer.shadowColor = RGBA(59, 74, 116, 1).CGColor;
		if (type==ENT_topic) {
			if (isSelf) {
				NSArray *imgArr=@[@"comment.png",@"agree.png"];
				NSArray *textArr=@[@"评论",@"点赞"];
				for (NSInteger i=0; i<textArr.count; i++) {
					UIImage *img=Image(imgArr[i]);
					UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
					btn.tag=1000+i;
					btn.enabled=YES;
					btn.frame=CGRectMake(i*WindowWith/textArr.count, 0, WindowWith/textArr.count, self.height);
					UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(btn.right, 8, 1, self.height-16)];
					lineView.backgroundColor=cLineColor;
					[self addSubview:lineView];
					[self addSubview:btn];
					
					
					[btn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
					[btn setTitle:textArr[i] forState:UIControlStateNormal];
					[btn setTitleColor:RGBA(108, 123, 138, 1) forState:UIControlStateNormal];
					btn.titleLabel.font=sysFont(14);
					btn.titleEdgeInsets=UIEdgeInsetsMake(0, 10, 0, 0);
					if (btn.tag==1000) {
						[btn addTarget:self action:@selector(comment:) forControlEvents:UIControlEventTouchUpInside];
					}else if (btn.tag==1001)
					{
						UIImage *agreeSelectedImg=Image(@"agree_select.png");
						[btn setImage:[agreeSelectedImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateSelected];
						[btn addTarget:self action:@selector(agree:) forControlEvents:UIControlEventTouchUpInside];
					}
					
					
					if (i==1) {
						UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(btn.left, 0, 1, self.height)];
						lineView.backgroundColor=cLineColor;
						[self addSubview:lineView];
					}
				}
				
			}
			else
			{
				NSArray *imgArr=@[@"comment.png",@"agree.png",@"hi.png"];
				NSArray *textArr=@[@"评论",@"点赞",@"打个招呼"];
				
				for (NSInteger i=0; i<3; i++) {
					UIImage *img=Image(imgArr[i]);
					UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
					btn.tag=1000+i;
					btn.enabled=YES;
					btn.frame=CGRectMake(i*WindowWith/3, 0, WindowWith/3, self.height);
					[self addSubview:btn];
					UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(btn.right, 8, 1, self.height-16)];
					lineView.backgroundColor=cLineColor;
					[self addSubview:lineView];
					[btn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
					[btn setTitle:textArr[i] forState:UIControlStateNormal];
					[btn setTitleColor:RGBA(108, 123, 138, 1) forState:UIControlStateNormal];
					btn.titleLabel.font=sysFont(14);
					btn.titleEdgeInsets=UIEdgeInsetsMake(0, 10, 0, 0);
					if (btn.tag==1000) {
						[btn addTarget:self action:@selector(comment:) forControlEvents:UIControlEventTouchUpInside];
					}else if (btn.tag==1001)
					{   _agreeBtn=btn;
						UIImage *agreeSelectedImg=Image(@"agree_select.png");
						[btn setImage:[agreeSelectedImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateSelected];
						[btn addTarget:self action:@selector(agree:) forControlEvents:UIControlEventTouchUpInside];
					}else if (btn.tag==1002)
					{
						btn.backgroundColor=RGBA(232, 121, 117, 1);
						[btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
						[btn addTarget:self action:@selector(chat:) forControlEvents:UIControlEventTouchUpInside];
					}
					if (i==1) {
						UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(btn.left, 0, 1, self.height)];
						lineView.backgroundColor=cLineColor;
						[self addSubview:lineView];
					}
					
				}
				
			}
			
			
			
			
		}else if (type==ENT_activity)
		{   NSArray *imgArr=@[@"comment.png",@"agree.png",@"hi.png"];
			NSArray *textArr=@[@"评论",@"点赞",@"我要报名"];
			for (NSInteger i=0; i<3; i++) {
				UIImage *img=Image(imgArr[i]);
				UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
				btn.tag=1000+i;
				btn.enabled=YES;
				btn.frame=CGRectMake(i*WindowWith/3, 0, WindowWith/3, self.height);
				[self addSubview:btn];
				UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(btn.right, 8, 1, self.height-16)];
				lineView.backgroundColor=cLineColor;
				[self addSubview:lineView];
				[btn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
				[btn setTitle:textArr[i] forState:UIControlStateNormal];
				[btn setTitleColor:RGBA(108, 123, 138, 1) forState:UIControlStateNormal];
				btn.titleLabel.font=sysFont(14);
				btn.titleEdgeInsets=UIEdgeInsetsMake(0, 10, 0, 0);
				if (btn.tag==1000) {
					[btn addTarget:self action:@selector(comment:) forControlEvents:UIControlEventTouchUpInside];
				}else if (btn.tag==1001)
				{   _agreeBtn=btn;
					UIImage *agreeSelectedImg=Image(@"agree_select.png");
					[btn setImage:[agreeSelectedImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateSelected];
					[btn addTarget:self action:@selector(agree:) forControlEvents:UIControlEventTouchUpInside];
				}else if (btn.tag==1002)
				{
					btn.backgroundColor=RGBA(232, 121, 117, 1);
					[btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
					_signBtn = btn;
					[btn addTarget:self action:@selector(baoming:) forControlEvents:UIControlEventTouchUpInside];
				}
				if (i==1) {
					UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(btn.left, 0, 1, self.height)];
					lineView.backgroundColor=cLineColor;
					[self addSubview:lineView];
				}
				
			}
			
		}
		
		
		else if (type==ENT_qiugou||type==ENT_gongying)
		{
			if (isSelf) {
				NSArray *imgArr = @[@"information.png",@"edit.png",@"delete1.png"];
				NSArray *textArr=@[@"进苗圃",@"编 辑",@"删 除"];
				for (NSInteger i=0; i<3; i++) {
					UIImage *img=Image(imgArr[i]);
					UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
					btn.tag=1000+i;
					btn.enabled=YES;
					[self addSubview:btn];
					btn.frame=CGRectMake(i*WindowWith/3, 0, WindowWith/3, self.height);
					
					[btn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
					[btn setTitle:textArr[i] forState:UIControlStateNormal];
					[btn setTitleColor:RGBA(108, 123, 138, 1) forState:UIControlStateNormal];
					btn.titleLabel.font=sysFont(14);
					btn.titleEdgeInsets=UIEdgeInsetsMake(0, 10, 0, 0);
					if (btn.tag==1000) {
						btn.frame=CGRectMake(0.04*WindowWith, 3, WindowWith*0.24, self.height-6);
						
						[btn addTarget:self action:@selector(store:) forControlEvents:UIControlEventTouchUpInside];
						[btn setTitleColor:RGB(120, 142, 126) forState:UIControlStateNormal];
						btn.backgroundColor=RGB(221, 223, 223);
					}else if (btn.tag==1001)
					{
						btn.frame=CGRectMake(0.328*WindowWith, 3, WindowWith*0.341, self.height-6);
						
						btn.backgroundColor=cGreenColor;
						[btn setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
						[btn addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
					}else if (btn.tag==1002)
					{
						
						btn.frame=CGRectMake(0.73*WindowWith, 3, WindowWith*0.24, self.height-6);
						btn.backgroundColor=RGB(221, 223, 223);
						[btn setTitleColor:RGB(120, 142, 126) forState:UIControlStateNormal];
						
						[btn addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
					}
					
					btn.layer.cornerRadius=18;
					
					
					
					
					
					
				}
			}else
			{
				//                NSArray *imgArr=@[@"telphone.png",@"hi.png",@"GongQiu_message.png"];
				//                NSArray *textArr=@[@"电话",@"打招呼",@"留言"];
				NSArray *imgArr=@[@"#29daa2",@"#05c1b0"];
				NSArray *textArr=@[@"电话",@"打招呼"];
				for (NSInteger i=0; i<2; i++) {
					//                    UIImage *img=Image(imgArr[i]);
					UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
					btn.tag=1000+i;
					btn.enabled=YES;
					[self addSubview:btn];
					btn.frame=CGRectMake(i*WindowWith/2, 0, WindowWith/2, self.height);
					NSString *coloStr = imgArr[i];
					[btn setBackgroundColor:kColor(coloStr)];
					//                    [btn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
					[btn setTitle:textArr[i] forState:UIControlStateNormal];
					[btn setTitleColor:RGBA(108, 123, 138, 1) forState:UIControlStateNormal];
					btn.titleLabel.font=sysFont(14);
					btn.titleEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 0);
					btn.titleLabel.font = boldFont(font(17));
					if (btn.tag==1000) {
						btn.frame=CGRectMake(0.05*WindowWith, 3, WindowWith*0.4, self.height-6);
						
						[btn addTarget:self action:@selector(telphone:) forControlEvents:UIControlEventTouchUpInside];
						[btn setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
						//                        [btn setTitleColor:RGB(120, 142, 126) forState:UIControlStateNormal];
						//                        btn.backgroundColor=RGB(221, 223, 223);
					}else if (btn.tag==1001)
					{
						btn.frame=CGRectMake(0.55*WindowWith, 3, WindowWith*0.4, self.height-6);
						
						btn.backgroundColor=cGreenColor;
						[btn setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
						[btn addTarget:self action:@selector(chat:) forControlEvents:UIControlEventTouchUpInside];
					}else if (btn.tag==1002)
					{
						
						btn.frame=CGRectMake(0.73*WindowWith, 3, WindowWith*0.24, self.height-6);
						//                        btn.backgroundColor=RGB(221, 223, 223);
						[btn setTitleColor:RGB(120, 142, 126) forState:UIControlStateNormal];
						
						[btn addTarget:self action:@selector(comment:) forControlEvents:UIControlEventTouchUpInside];
					}
					
					btn.layer.cornerRadius=18;
					
					
				}
				
			}
		}
		
		
		
		
	}
	
	return self;
	
}

-(void)setDataWithModel:(MTTopicListModel *)model{
	if (model.hasClickLike) {
		_agreeBtn.selected=YES;
	}else
	{
		_agreeBtn.selected=NO;
	}
}

-(void)setDataWithActivModel:(ActivitiesListModel *)model{
	if ([[NSString stringWithFormat:@"%@",model.hasClickLike] isEqualToString:@"1"]) {
		_agreeBtn.selected=YES;
	}else
	{
		_agreeBtn.selected=NO;
	}
	
	if ([IHUtility overtime:model.curtime inputDate:model.activities_expiretime]){
		[_signBtn setTitle:@"已结束" forState:UIControlStateNormal];
	}else {
		if ([model.model isEqualToString:@"8"]) {
			[_signBtn setTitle:@"我要众筹" forState:UIControlStateNormal];
		}
	}
}
-(void)agree:(UIButton *)sender
{
	UIButton *btn=(UIButton *)sender;
	
	self.selectBlock(SelectAgreeBlock);
	btn.selected=YES;
}

-(void)comment:(UIButton *)sender
{
	
	self.selectBlock(SelectCommentBlock);
}

-(void)telphone:(UIButton *)sender
{
	
	
	self.selectBlock(SelectTelphoneBlock);
	
}
-(void)chat:(UIButton *)sender
{
	
	self.selectBlock(SelectHiBlock);
}


-(void)store:(UIButton *)sender
{
	self.selectBlock(SelectStoreBlock);
}

-(void)delete:(UIButton *)sender
{
	
	self.selectBlock(SelectDeleteBlock);
}
-(void)edit:(UIButton *)sender
{   self.selectBlock(SelectEditBlock);
	
}
-(void)baoming:(UIButton *)sender
{
	self.selectBlock(SelectBaomingBlock);
}




@end


#pragma mark 发布
@implementation ReleaseView



//
//- (instancetype)initWithisBuy:(BOOL)isBuy Frame:(CGRect)frame
//{
//
//	self = [super initWithFrame:frame];
//	if (self) {
//
//		[self creatViewisBuy:isBuy];
//	}
//
//	return self;
//}


-(void)creatViewisBuy:(BOOL)isBuy
{
	UIView *view=[[UIView alloc]initWithFrame:self.bounds];
	view.backgroundColor=[UIColor whiteColor];
	[self addSubview:view];
	
	UIImage *img=Image(@"redstar.png");
	UIImage *toImg=Image(@"MT_to.png");
	
	UIView *photoView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 8)];
	photoView.backgroundColor=cLineColor;
	[view addSubview:photoView];
	
	//杆径
	UIImageView *ganJingImgView=[[UIImageView alloc]initWithImage:img];
	ganJingImgView.frame=CGRectMake(0.045*WindowHeight, WindowHeight*0.045+8, img.size.width, img.size.height);
	[view addSubview:ganJingImgView];
	
	SMLabel *ganJingLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(ganJingImgView.right+7, ganJingImgView.top-5, 30, 20) textColor:cBlackColor textFont:sysFont(15)];
	ganJingLbl.text=@"杆径";
	[view addSubview:ganJingLbl];
	_ganJingTextField=[[IHTextField alloc]initWithFrame:CGRectMake(ganJingLbl.right+20, ganJingLbl.top-5, 100, 30)];
	_ganJingTextField.borderStyle=UITextBorderStyleNone;
	_ganJingTextField.placeholder=@"0cm";
	[view addSubview:_ganJingTextField];
	
	
	UIView *ganJingView=[[UIView alloc]initWithFrame:CGRectMake(ganJingImgView.left, ganJingLbl.bottom+12, WindowWith-ganJingImgView.left*2, 1)];
	ganJingView.backgroundColor=cLineColor;
	[view addSubview:ganJingView];
	
	UIImageView *ganJingToImageView=[[UIImageView alloc]initWithImage:toImg];
	ganJingToImageView.frame=CGRectMake(ganJingView.right, ganJingLbl.top, toImg.size.width, toImg.size.height);
	[view addSubview:ganJingToImageView];
	
	
	//冠幅
	UIImageView *guanFuImgView=[[UIImageView alloc]initWithImage:img];
	guanFuImgView.frame=CGRectMake(0.045*WindowHeight, ganJingView.bottom+20, img.size.width, img.size.height);
	[view addSubview:guanFuImgView];
	
	SMLabel *guanFuLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(guanFuImgView.right+7, guanFuImgView.top-5, 30, 20) textColor:cBlackColor textFont:sysFont(15)];
	guanFuLbl.text=@"冠幅";
	[view addSubview:guanFuLbl];
	_guanFuTextField=[[IHTextField alloc]initWithFrame:CGRectMake(guanFuLbl.right+20, guanFuLbl.top-5, 100, 30)];
	_guanFuTextField.borderStyle=UITextBorderStyleNone;
	_guanFuTextField.placeholder=@"0cm-0cm";
	[view addSubview:_guanFuTextField];
	
	
	UIView *guanFuView=[[UIView alloc]initWithFrame:CGRectMake(guanFuImgView.left, guanFuLbl.bottom+12, WindowWith-guanFuImgView.left*2, 1)];
	guanFuView.backgroundColor=cLineColor;
	[view addSubview:guanFuView];
	
	UIImageView *guanFuToImageView=[[UIImageView alloc]initWithImage:toImg];
	guanFuToImageView.frame=CGRectMake(guanFuView.right, guanFuLbl.top, toImg.size.width, toImg.size.height);
	[view addSubview:guanFuToImageView];
	
	//高度
	
	UIImageView *gaoDuImgView=[[UIImageView alloc]initWithImage:img];
	gaoDuImgView.frame=CGRectMake(0.045*WindowHeight, guanFuView.bottom+20, img.size.width, img.size.height);
	[view addSubview:gaoDuImgView];
	
	SMLabel *gaoDuLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(gaoDuImgView.right+7, gaoDuImgView.top-5, 30, 20) textColor:cBlackColor textFont:sysFont(15)];
	gaoDuLbl.text=@"高度";
	[view addSubview:gaoDuLbl];
	_guanFuTextField=[[IHTextField alloc]initWithFrame:CGRectMake(gaoDuLbl.right+20, gaoDuLbl.top-5, 100, 30)];
	_guanFuTextField.borderStyle=UITextBorderStyleNone;
	_guanFuTextField.placeholder=@"0cm-0cm";
	[view addSubview:_guanFuTextField];
	
	
	UIView *gaoDuView=[[UIView alloc]initWithFrame:CGRectMake(gaoDuImgView.left, gaoDuLbl.bottom+12, WindowWith-gaoDuImgView.left*2, 1)];
	gaoDuView.backgroundColor=cLineColor;
	[view addSubview:gaoDuView];
	
	UIImageView *gaoDuToImageView=[[UIImageView alloc]initWithImage:toImg];
	gaoDuToImageView.frame=CGRectMake(gaoDuView.right, gaoDuLbl.top, toImg.size.width, toImg.size.height);
	[view addSubview:gaoDuToImageView];
	
	//产品卖点或要求
	UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, gaoDuView.bottom, WindowWith, 7)];
	lineView.backgroundColor=cLineColor;
	[view addSubview:lineView];
	
	_textView=[[UITextView alloc]initWithFrame:CGRectMake(0, lineView.bottom, WindowWith, 102)];
	_textView.delegate=self;
	[view addSubview:_textView];
	
	_placeholderLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, _textView.width, 30)];
	_placeholderLabel.text = @" 描述一下产品卖点";
	_placeholderLabel.font=sysFont(13);
	_placeholderLabel.textColor = cBlackColor;
	[_textView addSubview:_placeholderLabel];
	
	if (isBuy) {
		_placeholderLabel.text = @" 描述一下你的其他要求";
	}
	
}

#pragma mark -- textview delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text

{    if (![text isEqualToString:@""])
	
{
	_placeholderLabel.hidden = YES;
}
	
	if ([text isEqualToString:@""] && range.location == 0 && range.length == 1)
	{
		_placeholderLabel.hidden = NO;
	}
	return YES;
}





@end

#pragma mark  个人信息头部
@implementation PersonInformationView

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	
	if (self) {
		
		[self creatViewWithDic];
	}
	
	return self;
}

-(void)creatViewWithDic
{
	
	UIImage *bkImg=[ConfigManager createImageWithColor:[UIColor whiteColor]];
	self.image=bkImg;
	self.userInteractionEnabled=YES;
	self.contentMode = UIViewContentModeScaleAspectFill;
	self.clipsToBounds = YES;
	
	//    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
	//    UIImage *backImg=Image(@"iconfont-fanhui.png");
	//    [backBtn setTintColor:[UIColor whiteColor]];
	//
	//    [backBtn setImage:[backImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
	//    [backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
	//    backBtn.frame=CGRectMake(0, 13, backImg.size.width+40, backImg.size.height+40);
	//    [self addSubview:backBtn];
	//
	//
	//    UIButton *shareBtn=[UIButton buttonWithType:UIButtonTypeCustom];
	//    UIImage *shareImg=Image(@"shareGreen.png");
	//    [shareBtn setImage:[shareImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
	//    shareBtn.frame=CGRectMake(WindowWith-shareImg.size.width-38, backBtn.top, shareImg.size.width+40, shareImg.size.height+40);
	//    [self addSubview:shareBtn];
	//     [shareBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
	
	
	
	UIImage *headerImg=Image(@"Oval 172 Copy 5.png");
	UIAsyncImageView *headerImageView=[[UIAsyncImageView alloc]initWithImage:headerImg];
	_headerImageView=headerImageView;
	headerImageView.frame=CGRectMake(10,15,65, 65);
	headerImageView.image=headerImg;
	// [headerImageView setLayerMasksCornerRadius:headerImageView.width/2 BorderWidth:2 borderColor:[UIColor whiteColor]];
	headerImageView.userInteractionEnabled=YES;
	UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headTap:)];
	[headerImageView addGestureRecognizer:tap];
	[self addSubview:headerImageView];
	
	UIAsyncImageView *vipImageView=[[UIAsyncImageView alloc]initWithImage:headerImg];
	_VipImageView = vipImageView;
	vipImageView.frame=CGRectMake(headerImageView.right - kWidth(14),headerImageView.bottom - kWidth(14),kWidth(16), kWidth(16));
	vipImageView.hidden = YES;
	vipImageView.image = kImage(@"gongqiu_vip");
	[self addSubview:vipImageView];
	
	
	//    SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, headerImageView.bottom+11.5, 48, 15) textColor:cBlackColor textFont:sysFont(15)];
	//    _nickNameLbl=lbl;
	//    [self addSubview:lbl];
	//
	//
	//    UIImage *img=Image(@"boy.png");
	//    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(lbl.right+5, lbl.top+2, img.size.width, img.size.height)];
	//    _sexImageView=imageView;
	//    imageView.image=img;
	//    [self addSubview:imageView];
	
	
	SMLabel  *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, 0, 30, 32) textColor:cGrayLightColor textFont:sysFont(12)];
	lbl.textAlignment=NSTextAlignmentRight;
	lbl.text=@"关注";
	
	SMLabel *numberLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.left-20, lbl.bottom+10, lbl.width+20, 14) textColor:cBlackColor textFont:sysFont(14)];
	numberLbl.textAlignment=NSTextAlignmentRight;
	numberLbl.text=@"10314";
	_guanzhuLbl=numberLbl;
	
	UIView *view=[[UIView alloc]initWithFrame:CGRectMake(headerImageView.right+23, headerImageView.top+15, lbl.width+20, 63)];
	view.centerY=headerImageView.centerY;
	[self addSubview:view];
	[view addSubview:lbl];
	[view addSubview:numberLbl];
	
	
	UITapGestureRecognizer *tap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(guanzhu)];
	[view addGestureRecognizer:tap1];
	
	
	lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, 0, 30, 32) textColor:cGrayLightColor textFont:sysFont(12)];
	lbl.textAlignment=NSTextAlignmentRight;
	lbl.text=@"粉丝";
	
	
	numberLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.left-20, lbl.bottom+10, lbl.width+20, 14) textColor:cBlackColor textFont:sysFont(14)];
	numberLbl.textAlignment=NSTextAlignmentRight;
	numberLbl.text=@"6";
	_fansLbl=numberLbl;
	
	
	view=[[UIView alloc]initWithFrame:CGRectMake(view.right+0.06*WindowWith, view.top, lbl.width+20, 63)];
	[self addSubview:view];
	[view addSubview:lbl];
	[view addSubview:numberLbl];
	
	
	
	
	
	UITapGestureRecognizer *tap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fensi)];
	[view addGestureRecognizer:tap2];
	//[numberLbl addGestureRecognizer:tap2];
	
	
	
	//    PersonLabelView *personLabelView=[[PersonLabelView alloc]initWithFrame:CGRectMake(headerImageView.left, headerImageView.bottom+9, WindowWith-headerImageView.left*2, 13)];
	//    _personLabelView=personLabelView;
	//
	//    [self addSubview:personLabelView];
	lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(headerImageView.left, headerImageView.bottom+15, WindowWith-headerImageView.left*2, 30) textColor:cGrayLightColor textFont:sysFont(13)];
	lbl.numberOfLines=0;
	_bgLbl=lbl;
	[self addSubview:lbl];
	
	
	UIView *companyView=[[UIView alloc]initWithFrame:CGRectMake(0, lbl.bottom+15, WindowWith, 42)];
	companyView.backgroundColor=[UIColor whiteColor];
	[self addSubview:companyView];
	_companyView=companyView;
	
	UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 1)];
	lineView.backgroundColor=cLineColor;
	[companyView addSubview:lineView];
	
	UIButton *companyBtn=[UIButton buttonWithType:UIButtonTypeCustom];
	companyBtn.frame=CGRectMake(headerImageView.left, 10, WindowWith-headerImageView.left*2, 15);
	[companyBtn setImage:Image(@"Job_companyHome.png") forState:UIControlStateNormal];
	[companyBtn setTitle:@"" forState:UIControlStateNormal];
	[companyBtn setTitleColor:cGreenColor forState:UIControlStateNormal];
	companyBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 10, 0, 0);
	companyBtn.titleLabel.font=sysFont(14);
	_companyBtn=companyBtn;
	[companyView addSubview:companyBtn];
	[companyBtn addTarget:self action:@selector(pushToCompany) forControlEvents:UIControlEventTouchUpInside];
	UITapGestureRecognizer *tap3=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushToCompany)];
	[companyView addGestureRecognizer:tap3];
	
	
	
	
	
	UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
	_btn=btn;
	btn.backgroundColor=RGB(239, 239, 242);
	//    [btn setTitle:@"+  关注" forState:UIControlStateNormal];
	btn.titleLabel.font=sysFont(14);
	[btn setTitleColor:RGB(120, 142, 126) forState:UIControlStateNormal];
	
	//    [_btn setImage:Image(@"EP_yes") forState:UIControlStateHighlighted];
	//    [_btn setTitle:@"已关注" forState:UIControlStateHighlighted];
	_btn.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
	btn.frame=CGRectMake(WindowWith-0.265*WindowWith-0.04*WindowWith, headerImageView.centerY-0.026*WindowWith, 0.265*WindowWith, 0.088*WindowWith);
	[self addSubview:btn];
	[btn addTarget:self action:@selector(guanzhu:) forControlEvents:UIControlEventTouchUpInside];
	
}

-(void)pushToCompany{
	self.selectBtnBlock(companyId);
}


-(void)share{
	self.selectBtnBlock(shareBlock);
}


-(void)guanzhu:(UIButton *)sender{
	
	sender.selected=!sender.selected;
	if (sender.selected) {
		self.selectBtnBlock(SelectFollowBlock);
		//        [sender setImage:Image(@"EP_yes") forState:UIControlStateNormal];
		//        [sender setTitle:@"已关注" forState:UIControlStateNormal];
		//        sender.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
		_fansLbl.text=[NSString stringWithFormat:@"%ld",[_fansLbl.text integerValue]+1];
	}else
	{
		//        [sender setImage:nil forState:UIControlStateNormal];
		//        [sender setTitle:@"+  关注" forState:UIControlStateNormal];
		self.selectBtnBlock(SelectUpFollowBlock);
		_fansLbl.text=[NSString stringWithFormat:@"%ld",[_fansLbl.text integerValue]-1];
	}
	
}

- (void)setbuttonValuettention{
	[_btn setImage:Image(@"EP_yes") forState:UIControlStateNormal];
	[_btn setTitle:@"已关注" forState:UIControlStateNormal];
	_btn.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
}

- (void)setbuttonValueCancel{
	[_btn setImage:nil forState:UIControlStateNormal];
	[_btn setTitle:@"+  关注" forState:UIControlStateNormal];
}

-(void)quxiaofollow{
	
	_guanzhuLbl.text=[NSString stringWithFormat:@"%ld",[_guanzhuLbl.text integerValue]-1];
}

-(void)follow{
	_guanzhuLbl.text=[NSString stringWithFormat:@"%ld",[_guanzhuLbl.text integerValue]+1];
}




-(void)guanzhu{
	NSLog(@"guanzhu");
	self.selectBtnBlock(SelectguanzhuBlock);
}


-(void)fensi{
	NSLog(@"fensi");
	self.selectBtnBlock(SelectFansBlock);
}

//-(void)pushToIdent:(UITapGestureRecognizer *)tap{
//	self.selectBtnBlock(SelectBtnBlock);
//}

-(void)back:(UIButton *)sender{
	//   [network cancelHttpConnect];
	//  [self.viewController.navigationController popViewControllerAnimated:YES];
	if ([self.delegate respondsToSelector:@selector(personDelegate:)]) {
		[self.delegate personDelegate:SelectBackVC];
	}
}
-(void)headTap:(UITapGestureRecognizer *)tap{
	
	if ([self.delegate respondsToSelector:@selector(personDelegate:)]) {
		[self.delegate personDelegate:SelectheadImageBlock];
	}
	
	//  self.selectBlock(SelectheadImageBlock);
	
}
-(void)setDataWithdic:(NSDictionary *)dic
{
	companyId=[dic[@"company_id"] integerValue];
	
	[_headerImageView setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@%@",ConfigManager.ImageUrl,dic[@"heed_image_url"],smallHeaderImage] placeholderImage:defalutHeadImage];
	[_headerImageView canClickItWithDuration:0.3 ThumbUrl:[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,dic[@"heed_image_url"]]];
	
	
	_fansLbl.text=[dic[@"fansNum"] stringValue];
	_guanzhuLbl.text=[dic[@"followNum"] stringValue];
	
	
	
	
	
	if ([[dic[@"followStatus"] stringValue] isEqualToString:@"0"]) {
		[_btn setImage:nil forState:UIControlStateNormal];
		[_btn setTitle:@"+  关注" forState:UIControlStateNormal];
		_btn.selected=NO;
	}else{
		[_btn setImage:Image(@"EP_yes") forState:UIControlStateNormal];
		[_btn setTitle:@"已关注" forState:UIControlStateNormal];
		_btn.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
		_btn.selected=YES;
		
	}
	
	
	//    CGSize size=[IHUtility GetSizeByText:dic[@"nickname"] sizeOfFont:15 width:200];
	//
	//    _nickNameLbl.frame=CGRectMake(_headerImageView.left+3, _headerImageView.bottom+11.5, size.width, 15);
	//    _nickNameLbl.text=dic[@"nickname"];
	//
	//
	//
	//
	//
	//    if ([dic[@"sexy"] intValue]==2) {
	//        UIImage *img=Image(@"girl.png");
	//        _sexImageView.image=img;
	//    }else{
	//        _sexImageView.image=Image(@"boy.png");
	//    }
	//
	//    _sexImageView.origin=CGPointMake(_nickNameLbl.right+5, _nickNameLbl.top+2);
	//
	
	
	_headerImageView.layer.cornerRadius=_headerImageView.width/2;
	_headerImageView.clipsToBounds=YES;
	
	
	
	NSMutableArray *labelArr=[[NSMutableArray alloc]init];
	
	if (![dic[@"provice"] isEqualToString:@""] || ![dic[@"city"] isEqualToString:@""]) {
		
		[labelArr addObject:[NSString stringWithFormat:@"%@ %@",dic[@"provice"],dic[@"city"]]];
	}
	
	if (![dic[@"short_name"] isEqualToString:@""] || ![dic[@"position"] isEqualToString:@""]) {
		NSString *s=[NSString stringWithFormat:@"%@ %@",dic[@"short_name"],dic[@"position"]];
		if ([dic[@"position"] isEqualToString:@"(null)"]) {
			s=[NSString stringWithFormat:@"%@",dic[@"short_name"]];
		}
		
		[labelArr addObject:s];
	}
	
	NSArray *arr=dic[@"identiList"];
	
	
	for (NSNumber *obj in arr) {
		if ([[obj stringValue]isEqualToString:@"4"]) {
			[labelArr addObject:[NSString stringWithFormat:@" %@站长 ",KAppName]];
		}
		
		if ([[obj stringValue] isEqualToString:@"5"]) {
			[labelArr addObject:@"战略合作伙伴"];
		}
		if ([[obj stringValue] isEqualToString:@"7"]) {
			[labelArr addObject:[NSString stringWithFormat:@" %@会员 ",KAppName]];
		}
		if ([[obj stringValue] isEqualToString:@"6"]) {
			[labelArr addObject:@"金种子"];
		}
		if ([[obj stringValue] isEqualToString:@"1"] ||[[obj stringValue] isEqualToString:@"2"]) {
			[labelArr addObject:@"普通用户"];
		}
	}
	
	NSMutableString *str=[[NSMutableString alloc]init];
	if (labelArr.count!=0) {
		for (NSString *s in labelArr) {
			if (![s isEqualToString:@""]) {
				[str appendFormat:@"%@", [NSString stringWithFormat:@"#%@  ",s]];
			}
			
		}
		
		
	}
	CGSize size=[IHUtility GetSizeByText:str sizeOfFont:13 width:WindowWith-_headerImageView.left*2];
	_bgLbl.text=str;
	_bgLbl.size=CGSizeMake(size.width, size.height);
	
	
	if ([dic[@"company_id"] intValue]==0) {
		_companyView.hidden=YES;
	}else{
		size=[IHUtility GetSizeByText:dic[@"company_name"] sizeOfFont:14 width:WindowWith-_headerImageView.left*2];
		UIImage *img=Image(@"Job_companyHome.png");
		_companyBtn.size=CGSizeMake(size.width+img.size.width+10, img.size.height);
		[_companyBtn setTitle:dic[@"company_name"] forState:UIControlStateNormal];
	}
	
	
	
	
	if ([[dic[@"follow_id"] stringValue] isEqualToString:USERMODEL.userID]) {
		_btn.hidden=YES;
		
		NSDictionary *Dic=[IHUtility getUserDefalutDic:KFansDefalutInfo];
		NSMutableDictionary *fansDic=[[NSMutableDictionary alloc]initWithDictionary:Dic];
		[fansDic setValue:dic[@"followNum"] forKey:@"followNum"];
		[fansDic setValue:dic[@"fansNum"] forKey:@"fansNum"];
		
		[IHUtility setUserDefaultDic:fansDic key:KFansDefalutInfo];
		
	}
	
	
}
- (void)setUserChildrenInfo:(UserChildrenInfo *)userMod{
	if ([userMod.isVip isEqualToString:@"1"]) {
		_VipImageView.hidden = NO;
	}else {
		_VipImageView.hidden = YES;
	}
}


//@synthesize imageView;

@end

#pragma mark 个人信息底部按钮
@implementation PersonInformationBottomView

- (instancetype)initWithisSelf:(BOOL)isSelf
{
	self = [super initWithFrame:CGRectMake(0, WindowHeight-42 - TFXHomeHeight, WindowWith, 42)];
	if (self) {
		self.backgroundColor=RGB(235, 239, 242);
		[self creatViewisSelf:isSelf];
	}
	
	return self;
	
}

-(void)creatViewisSelf:(BOOL)isSelf
{
	
	if (isSelf) {
		
		
		
	}else
	{
		NSArray *imgArr=@[@"information.png",@"hi.png",@"telphone.png"];
		NSArray *textArr=@[@"名片",@"打个招呼",@"电话"];
		for (NSInteger i=0; i<3; i++) {
			UIImage *img=Image(imgArr[i]);
			UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
			btn.tag=1000+i;
			btn.enabled=YES;
			[self addSubview:btn];
			btn.frame=CGRectMake(i*WindowWith/3, 0, WindowWith/3, self.height);
			
			
			[btn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
			[btn setTitle:textArr[i] forState:UIControlStateNormal];
			[btn setTitleColor:RGBA(108, 123, 138, 1) forState:UIControlStateNormal];
			btn.titleLabel.font=sysFont(14);
			btn.titleEdgeInsets=UIEdgeInsetsMake(0, 10, 0, 0);
			if (btn.tag==1000) {
				btn.frame=CGRectMake(0.04*WindowWith, 3, WindowWith*0.24, self.height-6);
				
				[btn addTarget:self action:@selector(comment:) forControlEvents:UIControlEventTouchUpInside];
				[btn setTitleColor:RGB(120, 142, 126) forState:UIControlStateNormal];
				btn.backgroundColor=RGB(221, 223, 223);
			}else if (btn.tag==1001)
			{
				btn.frame=CGRectMake(0.328*WindowWith, 3, WindowWith*0.341, self.height-6);
				
				btn.backgroundColor=cGreenColor;
				[btn setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
				[btn addTarget:self action:@selector(chat:) forControlEvents:UIControlEventTouchUpInside];
			}else if (btn.tag==1002)
			{
				
				btn.frame=CGRectMake(0.73*WindowWith, 3, WindowWith*0.24, self.height-6);
				btn.backgroundColor=RGB(221, 223, 223);
				[btn setTitleColor:RGB(120, 142, 126) forState:UIControlStateNormal];
				
				[btn addTarget:self action:@selector(telphone:) forControlEvents:UIControlEventTouchUpInside];
			}
			
			btn.layer.cornerRadius=18;
		}
		
	}
	
	
}

-(void)comment:(UIButton *)sender
{
	NSLog(@"名片");
	if ([self.delegate respondsToSelector:@selector(personDelegate:)]) {
		[self.delegate personDelegate:SelectPersonInfo];
	}
}

-(void)telphone:(UIButton *)sender
{
	NSLog(@"打电话");
	if ([self.delegate respondsToSelector:@selector(personDelegate:)]) {
		[self.delegate personDelegate:SelectTelphoneBlock];
	}
}
-(void)chat:(UIButton *)sender
{
	if ([self.delegate respondsToSelector:@selector(personDelegate:)]) {
		[self.delegate personDelegate:SelectHiBlock];
	}
	
	NSLog(@"打个招呼");
}


@end
#pragma mark 自定义键盘
@implementation KeybordView
- (instancetype)initWith
{
	self = [super initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight)];
	if (self) {
		self.hidden=NO;
		
	}
	
	return  self;
}
-(void)creatViewWiyhType:(ReleaseType)type
{
	
	UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0.56*WindowHeight, WindowWith, 0.44*WindowHeight)];
	backView.backgroundColor=[UIColor whiteColor];
	
	UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 0.56*WindowHeight)];
	view.backgroundColor=RGBA(60, 79, 94, 0.7);
	[self addSubview:view];
	
	
	UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyBord)];
	[view addGestureRecognizer:tap];
	
	//backView.userInteractionEnabled=YES;
	[self addSubview:backView];
	
	for (NSInteger i=0; i<4; i++) {
		for (NSInteger j=0; j<3; j++) {
			UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
			btn.frame=CGRectMake(j*0.24*WindowWith, i*0.204*backView.height+0.17*backView.height, 0.24*WindowWith, 0.204*backView.height);
			btn.tintColor=cBlackColor;
			// 按钮边框宽度
			btn.layer.borderWidth = 3;
			// 设置圆角
			btn.layer.cornerRadius = 4.5;
			// 设置颜色空间为rgb，用于生成ColorRef
			
			CGColorSpaceRef backcolorSpace = CGColorSpaceCreateDeviceRGB();
			// 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
			CGColorRef backborderColorRef = CGColorCreate(backcolorSpace,(CGFloat[]){ 247/255.0, 247/255.0, 247/255.0, 1 });
			// 设置边框颜色
			btn.layer.borderColor = backborderColorRef;
			
			[btn addTarget:self action:@selector(numbleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
			[backView addSubview:btn];
			btn.tag=i*4+j;
			if (btn.tag<3) {
				[btn setTitle:[NSString stringWithFormat:@"%ld",(long)btn.tag+1] forState:UIControlStateNormal];
				btn.titleLabel.font=sysFont(20);
			}
			if (btn.tag>3&&btn.tag<=6) {
				[btn setTitle:[NSString stringWithFormat:@"%ld",(long)btn.tag] forState:UIControlStateNormal];
				btn.titleLabel.font=sysFont(20);
			}
			if (btn.tag>6&&btn.tag<=10) {
				[btn setTitle:[NSString stringWithFormat:@"%ld",(long)btn.tag-1] forState:UIControlStateNormal];
				btn.titleLabel.font=sysFont(20);
			}
			if (btn.tag==12) {
				[btn setTitle:@"." forState:UIControlStateNormal];
				btn.titleLabel.font=sysFont(20);
				
			}
			if (btn.tag==13) {
				[btn setTitle:@"0" forState:UIControlStateNormal];
				btn.titleLabel.font=sysFont(20);
			}
			if (btn.tag==14) {
				UIImage *img=Image(@"keyboard.png");
				[btn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
			}
			
		}
		
		
	}
	UIImage *deleteImg=Image(@"backspace.png");
	UIButton *deleteBtn=[UIButton buttonWithType:UIButtonTypeSystem];
	[deleteBtn setImage:[deleteImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
	deleteBtn.frame=CGRectMake(0.72*WindowWith, 0.17*backView.height, 0.28*WindowWith, 0.408*backView.height);
	deleteBtn.tag=1001;
	[backView addSubview:deleteBtn];
	// 按钮边框宽度
	deleteBtn.layer.borderWidth = 3;
	// 设置圆角
	deleteBtn.layer.cornerRadius = 4.5;
	// 设置颜色空间为rgb，用于生成ColorRef
	
	CGColorSpaceRef backcolorSpace = CGColorSpaceCreateDeviceRGB();
	// 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
	CGColorRef backborderColorRef = CGColorCreate(backcolorSpace,(CGFloat[]){ 247/255.0, 247/255.0, 247/255.0, 1 });
	// 设置边框颜色
	deleteBtn.layer.borderColor = backborderColorRef;
	[deleteBtn addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
	
	//确定按钮
	UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
	btn.backgroundColor=RGBA(0, 121, 255, 1);
	btn.tag=1002;
	btn.frame=CGRectMake(deleteBtn.left, deleteBtn.bottom+4, deleteBtn.width, deleteBtn.height);
	[btn setTitle:@"确定" forState:UIControlStateNormal];
	[btn setTintColor:[UIColor whiteColor]];
	btn.titleLabel.font=sysFont(17);
	[btn addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
	[backView addSubview:btn];
	
	
	if (type==ENT_number) {
		SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(20, 0.052*backView.height, 35, 20) textColor:cBlackColor textFont:sysFont(15)];
		lbl.text=@"数量";
		
		
		_textFieldFrom=[[UITextField alloc]initWithFrame:CGRectMake(lbl.right+20, lbl.top, 100, lbl.height)];
		_textFieldFrom.borderStyle=UITextBorderStyleNone;
		_textFieldFrom.delegate=self;
		[_textFieldFrom becomeFirstResponder];
		_textFieldFrom.placeholder=@"0";
		_textFieldFrom.inputView = [[UIView alloc] initWithFrame:CGRectZero];
		SMLabel *label=[[SMLabel alloc]initWithFrameWith:CGRectMake(0.9*WindowWith, lbl.top, lbl.width, lbl.height) textColor:cLineColor textFont:sysFont(14)];
		label.text=@"株";
		[backView addSubview:label];
		[backView addSubview:_textFieldFrom];
		[backView addSubview:lbl];
		
	}else if(type==ENT_price)
	{
		SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(20, 0.052*backView.height, 35, 20) textColor:cBlackColor textFont:sysFont(13)];
		lbl.text=@"单价";
		_textFieldFrom=[[UITextField alloc]initWithFrame:CGRectMake(lbl.right+20, lbl.top, 100, lbl.height)];
		_textFieldFrom.borderStyle=UITextBorderStyleNone;
		[_textFieldFrom becomeFirstResponder];
		_textFieldFrom.placeholder=@"0";
		_textFieldFrom.delegate=self;
		
		_textFieldFrom.inputView = [[UIView alloc] initWithFrame:CGRectZero];
		SMLabel *label=[[SMLabel alloc]initWithFrameWith:CGRectMake(0.9*WindowWith, lbl.top, lbl.width, lbl.height) textColor:cLineColor textFont:sysFont(14)];
		label.text=@"元";
		[backView addSubview:label];
		[backView addSubview:_textFieldFrom];
		
		[backView addSubview:lbl];
		
	}else if (type==ENT_ganJing)
	{
		SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(20, 0.052*backView.height, 35, 20) textColor:cBlackColor textFont:sysFont(13)];
		lbl.text=@"杆径";
		_textFieldFrom=[[UITextField alloc]initWithFrame:CGRectMake(lbl.right+20, lbl.top, 100, lbl.height)];
		_textFieldFrom.borderStyle=UITextBorderStyleNone;
		[_textFieldFrom becomeFirstResponder];
		_textFieldFrom.placeholder=@"0";
		_textFieldFrom.delegate=self;
		
		_textFieldFrom.inputView = [[UIView alloc] initWithFrame:CGRectZero];
		SMLabel *label=[[SMLabel alloc]initWithFrameWith:CGRectMake(0.9*WindowWith, lbl.top, lbl.width, lbl.height) textColor:cLineColor textFont:sysFont(14)];
		label.text=@"cm";
		[backView addSubview:label];
		[backView addSubview:_textFieldFrom];
		
		[backView addSubview:lbl];
		
		
		
	}else if (type==ENT_guanFu)
	{
		SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(20, 0.052*backView.height, 35, 20) textColor:cBlackColor textFont:sysFont(13)];
		lbl.text=@"冠幅";
		_textFieldFrom=[[UITextField alloc]initWithFrame:CGRectMake(lbl.right+20, lbl.top, 100, lbl.height)];
		_textFieldFrom.borderStyle=UITextBorderStyleNone;
		[_textFieldFrom becomeFirstResponder];
		_textFieldFrom.placeholder=@"0";
		_textFieldFrom.inputView = [[UIView alloc] initWithFrame:CGRectZero];
		SMLabel *label=[[SMLabel alloc]initWithFrameWith:CGRectMake(0.4*WindowWith, lbl.top, lbl.width, lbl.height) textColor:cLineColor textFont:sysFont(14)];
		label.text=@"cm";
		[backView addSubview:label];
		[backView addSubview:_textFieldFrom];
		
		[backView addSubview:lbl];
		
		
		
		
		SMLabel *lbl2=[[SMLabel alloc]initWithFrameWith:CGRectMake(20+WindowWith/2, 0.052*backView.height, 30, 20) textColor:cBlackColor textFont:sysFont(13)];
		lbl2.text=@"到";
		_textFieldTo=[[UITextField alloc]initWithFrame:CGRectMake(lbl2.right+20, lbl2.top, 100, lbl2.height)];
		_textFieldTo.borderStyle=UITextBorderStyleNone;
		// _textFieldTo.delegate=self;
		_textFieldTo.placeholder=@"0";
		_textFieldTo.inputView = [[UIView alloc] initWithFrame:CGRectZero];
		SMLabel *label2=[[SMLabel alloc]initWithFrameWith:CGRectMake(0.9*WindowWith, lbl2.top, lbl2.width, lbl.height) textColor:cLineColor textFont:sysFont(14)];
		label2.text=@"cm";
		[backView addSubview:label2];
		[backView addSubview:_textFieldTo];
		
		[backView addSubview:lbl2];
		
		_textFieldFrom.delegate=self;
		_textFieldTo.delegate=self;
		
		
		
	}else if (type==ENT_gaoDu)
	{
		
		SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(20, 0.052*backView.height, 35, 20) textColor:cBlackColor textFont:sysFont(13)];
		lbl.text=@"高度";
		_textFieldFrom=[[UITextField alloc]initWithFrame:CGRectMake(lbl.right+20, lbl.top, 100, lbl.height)];
		_textFieldFrom.borderStyle=UITextBorderStyleNone;
		[_textFieldFrom becomeFirstResponder];
		_textFieldFrom.placeholder=@"0";
		_textFieldFrom.inputView = [[UIView alloc] initWithFrame:CGRectZero];
		SMLabel *label=[[SMLabel alloc]initWithFrameWith:CGRectMake(0.4*WindowWith, lbl.top, lbl.width, lbl.height) textColor:cLineColor textFont:sysFont(14)];
		label.text=@"cm";
		[backView addSubview:label];
		[backView addSubview:_textFieldFrom];
		
		[backView addSubview:lbl];
		
		SMLabel *lbl2=[[SMLabel alloc]initWithFrameWith:CGRectMake(20+WindowWith/2, 0.052*backView.height, 30, 20) textColor:cBlackColor textFont:sysFont(13)];
		lbl2.text=@"到";
		_textFieldTo=[[UITextField alloc]initWithFrame:CGRectMake(lbl2.right+20, lbl2.top, 100, lbl2.height)];
		_textFieldTo.borderStyle=UITextBorderStyleNone;
		// _textFieldTo.delegate=self;
		_textFieldTo.placeholder=@"0";
		_textFieldTo.inputView = [[UIView alloc] initWithFrame:CGRectZero];
		SMLabel *label2=[[SMLabel alloc]initWithFrameWith:CGRectMake(0.9*WindowWith, lbl2.top, lbl2.width, lbl.height) textColor:cLineColor textFont:sysFont(14)];
		label2.text=@"cm";
		[backView addSubview:label2];
		[backView addSubview:_textFieldTo];
		
		[backView addSubview:lbl2];
		_textFieldFrom.delegate=self;
		_textFieldTo.delegate=self;
		
	}else if (ENT_adress==type)
	{
		
		SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(20, 0.052*backView.height, 50, 20) textColor:cBlackColor textFont:sysFont(13)];
		lbl.text=@"分枝点";
		_textFieldFrom=[[UITextField alloc]initWithFrame:CGRectMake(lbl.right+20, lbl.top, 100, lbl.height)];
		_textFieldFrom.borderStyle=UITextBorderStyleNone;
		[_textFieldFrom becomeFirstResponder];
		_textFieldFrom.placeholder=@"0";
		_textFieldFrom.delegate=self;
		
		_textFieldFrom.inputView = [[UIView alloc] initWithFrame:CGRectZero];
		SMLabel *label=[[SMLabel alloc]initWithFrameWith:CGRectMake(0.9*WindowWith, lbl.top, lbl.width, lbl.height) textColor:cLineColor textFont:sysFont(14)];
		label.text=@"cm";
		[backView addSubview:label];
		[backView addSubview:_textFieldFrom];
		
		[backView addSubview:lbl];
		
	}
	
	UIView *keyBordView=[self findKeyboard];
	NSLog(@"keyBordView=%f",keyBordView.top);
	keyBordView.origin=CGPointMake(0, kScreenHeight+56);
	
	
}





//确定按钮事件
-(void)finish
{
	if (![_textFieldFrom.text isEqualToString:@""]) {
		NSString *vaule = _textFieldFrom.text;
		self.block(vaule);
		
		
		if (_textFieldTo) {
			NSString *vaule2=_textFieldTo.text;
			self.block2(vaule2);
			
			
			
		}
		
	}
	
	[self hideView];
}

//删除
-(void)delete
{
	NSLog(@"delete");
	// 删除
	if(_textFieldFrom.text.length > 0)
	{
		[_textFieldFrom deleteBackward];
	}
	if (_textFieldTo.text.length>0) {
		[_textFieldTo deleteBackward];
	}
	
	
	
}

-(void)hideView
{
	self.hidden=YES;
}
-(void)hideKeyBord
{
	[self hideView];
}



- (void)numbleButtonClicked:(UIButton *)sender
{ UIButton* btn = (UIButton*)sender;
	BOOL IsEdit = [_textFieldFrom isEditing];
	NSInteger number = btn.tag;
	switch (number) {
		case 14:
		{
			[self hideView];
		}   break;
		default:{
			if (IsEdit == YES) {
				if([_textFieldFrom.text containsString:@"."]){
					NSRange ran = [_textFieldFrom.text rangeOfString:@"."];
					if (_textFieldFrom.text.length - ran.location <= 2) {
						NSString *text = [NSString stringWithFormat:@"%@",btn.titleLabel.text];
						[_textFieldFrom insertText:text];
					}
				}else{
					NSString *text = [NSString stringWithFormat:@"%@",btn.titleLabel.text];
					[_textFieldFrom insertText:text];
				}
			}else {
				if([_textFieldTo.text containsString:@"."]){
					NSRange ran = [_textFieldTo.text rangeOfString:@"."];
					if (_textFieldTo.text.length - ran.location <= 2) {
						NSString *text = [NSString stringWithFormat:@"%@",btn.titleLabel.text];
						[_textFieldTo insertText:text];
					}
				}else{
					NSString *text = [NSString stringWithFormat:@"%@",btn.titleLabel.text];
					[_textFieldTo insertText:text];
				}
			}
			
		}
			break;
	}
	
	
	
	
}
- (UIView *)findKeyboard
{
	UIView *keyboardView = nil;
	NSArray *windows = [[UIApplication sharedApplication] windows];
	for (UIWindow *window in [windows reverseObjectEnumerator])//逆序效率更高，因为键盘总在上方
	{
		keyboardView = [self findKeyboardInView:window];
		if (keyboardView)
		{
			return keyboardView;
		}
	}
	return nil;
}
- (UIView *)findKeyboardInView:(UIView *)view
{
	for (UIView *subView in [view subviews])
	{
		if (strstr(object_getClassName(subView), "UIKeyboard"))
		{
			return subView;
		}
		else
		{
			UIView *tempView = [self findKeyboardInView:subView];
			if (tempView)
			{
				return tempView;
			}
		}
	}
	return nil;
}


@end

@implementation ActivityVoteTopView

- (id)initWithFrame:(CGRect)frame
{
	self= [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = cLineColor;
		
		//        UIAsyncImageView *topImage = [[UIAsyncImageView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, WindowWith/375.0 * 234)];
		UIAsyncImageView *topImage = [[UIAsyncImageView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, WindowWith*0.453)];
		topImage.image = DefaultImage_logo;
		_topImage = topImage;
		[self addSubview:topImage];
		
		CGSize size = [IHUtility GetSizeByText:@"2016苗途金牌站长评选" sizeOfFont:21 width:WindowWith-24];
		SMLabel *lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(0, 83*WindowWith/375.0, size.width, 21) textColor:RGB(163, 194, 187) textFont:sysFont(21)];
		lbl.text = @"2016苗途金牌站长评选";
		lbl.centerX = self.width/2.0;
		_titleLbl = lbl;
		//        [self addSubview:lbl];
		
		UIView *linview = [[UIView alloc] initWithFrame:CGRectMake(lbl.left, lbl.bottom + 6, lbl.width, 2)];
		linview.backgroundColor = RGB(222, 232, 230);
		//        [self addSubview:linview];
		
		lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(0, linview.bottom +10, 75, 15) textColor:RGB(193, 208, 205) textFont:sysFont(15)];
		lbl.text = @"投票倒计时";
		lbl.centerX = self.width/2.0;
		//        [self addSubview:lbl];
		
		UIImage *img = Image(@"ActivVote_time.png");
		UIAsyncImageView *imageView = [[UIAsyncImageView alloc] initWithFrame:CGRectMake(0, lbl.bottom + 4, img.size.width, img.size.height)];
		imageView.centerX = self.width/2.0;
		//        imageView.image = img;
		[self addSubview:imageView];
		
		lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(0, 10, iPhoneWidth, 30) textColor:RGB(255, 255, 255) textFont:sysFont(18.0)];
		lbl.text = @"";
		lbl.backgroundColor = kColor(@"#000000");
		lbl.textAlignment = NSTextAlignmentCenter;
		lbl.centerX = self.width/2.0;
		lbl.layer.borderColor = RGB(246, 201, 204).CGColor;
		//        lbl.layer.borderWidth = 1;
		lbl.alpha = 0.4f;
		_timerLbl = lbl;
		[self addSubview:lbl];
		
		
		UIView *heardView = [[UIView alloc] initWithFrame:CGRectMake(0, topImage.bottom + 10, WindowWith, 49)];
		heardView.backgroundColor = [UIColor whiteColor];
		
		//        lbl = [[SMLabel  alloc] initWithFrameWith:CGRectMake(12, 0, WindowWith-100, 18) textColor:RGB(135, 134, 140) textFont:sysFont(15)];
		lbl = [[SMLabel  alloc] initWithFrameWith:CGRectMake(12, 0, WindowWith-100, 18) textColor:kColor(@"#333333") textFont:sysFont(font(15))];
		lbl.text = @"已有12345人参与";
		lbl.centerY = heardView.height/2.0;
		_numberLbl = lbl;
		[heardView addSubview:lbl];
		
		UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kWidth(80), 18)];
		[btn setTitle:@"活动详情》" forState:UIControlStateNormal];
		//        [btn setTitleColor:RGB(6, 193, 174) forState:UIControlStateNormal];
		[btn setTitleColor:kColor(@"#333333") forState:UIControlStateNormal];
		btn.titleLabel.font = sysFont(15);
		btn.centerY = heardView.height/2.0;
		btn.right = WindowWith - 12;
		[heardView addSubview:btn];
		self.btn = btn;
		
		UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(12, 48, WindowWith- 24, 1)];
		lineView.backgroundColor = cLineColor;
		[heardView addSubview:lineView];
		
		[self addSubview:heardView];
		
	}
	
	return self;
}

- (void)timeReduce
{
	if (second <= 0) {
		[timer invalidate];
		timer = nil;
		second = 0;
		return;
	}
	second = second - 1;
	_timerLbl.text = [NSString stringWithFormat:@"投票倒计时 %d天%d时%d分%d秒",(second/3600)/24,(second/3600)%24,(second/60)%60,second%60];
	
}

- (void)setTopData:(NSString *)title time:(NSString *)time totlNum:(NSString *)totleNum imgUrl:(NSString *)url
{
	if (timer) {
		[timer invalidate];
		timer = nil;
		second = 0;
	}
	
	[_topImage setImageAsyncWithURL:url placeholderImage:DefaultImage_logo];
	
	CGSize size = [IHUtility GetSizeByText:title sizeOfFont:21 width:WindowWith-24];
	_titleLbl.width = size.width;
	_titleLbl.centerX = self.width/2.0;
	_titleLbl.text = title;
	_numberLbl.text = [NSString stringWithFormat:@"已有%@人参与",totleNum];
	
	if ([time isEqualToString:@"已过期"]) {
		_timerLbl.text = [NSString stringWithFormat:@"已过期"];
		return;
	}
	NSArray *arr = [time componentsSeparatedByString:@"天"];
	NSArray *arr1 = [arr[1] componentsSeparatedByString:@"时"];
	NSArray *arr2 = [arr1[1] componentsSeparatedByString:@"分"];
	NSArray *arr3 = [arr2[1] componentsSeparatedByString:@"秒"];
	
	int hour = [arr[0] intValue]*24 + [arr1[0] intValue];
	int mintue = [arr2[0] intValue];
	int sec = [arr3[0] intValue];
	
	second = hour*3600 + mintue*60 + sec;
	
	_timerLbl.text = [NSString stringWithFormat:@"投票倒计时 %@",time];
	
	//    size = [IHUtility GetSizeByText:_timerLbl.text sizeOfFont:14 width:WindowWith-24];
	//    _timerLbl.width = size.width+50;
	//    _timerLbl.centerX = self.width/2.0;
	
	timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeReduce) userInfo:nil repeats:YES];
}

@end












