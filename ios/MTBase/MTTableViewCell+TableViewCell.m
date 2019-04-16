//
//  MTTableViewCell+TableViewCell.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/5/25.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "CustomView+CustomCategory2.h"
#import "MTTableViewCell+TableViewCell.h"

@implementation MTTableViewCell (TableViewCell)

@end


@implementation LogisticsFindCarTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 2)];
		[self.contentView addSubview:lineView];
		lineView.backgroundColor=RGBA(232, 239, 239, 1);
		
		LogisticsHeaderView *logisticsHeaderView=[[LogisticsHeaderView alloc]initWithFrame:CGRectMake(0, lineView.bottom, WindowWith, 65)];
		logisticsHeaderView.selectBtnBlock=^(NSInteger index){
			
			if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
				
				[self.delegate BCtableViewCell:self action:MTHeadViewActionTableViewCell indexPath:self.indexPath attribute:nil];
				
				
			}
			
		};
		[self.contentView addSubview:logisticsHeaderView];
		
		
		
		lineView=[[UIView alloc]initWithFrame:CGRectMake(15, logisticsHeaderView.bottom, WindowWith-30, 1)];
		lineView.backgroundColor=cLineColor;
		[self.contentView addSubview:lineView];
		
		
		UIImage *img=Image(@"logistics_start.png");
		UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(lineView.left+10, lineView.bottom+15, img.size.width, img.size.height)];
		imageView.image=img;
		[self.contentView addSubview:imageView];
		
		
		SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+10, imageView.top, 34, 17) textColor:cBlackColor textFont:sysFont(17)];
		lbl.text=@"长沙";
		[self.contentView addSubview:lbl];
		
		
		
		img=Image(@"go.png");
		imageView=[[UIImageView alloc]initWithFrame:CGRectMake(lbl.right+10, lineView.bottom+5, img.size.width, img.size.height)];
		imageView.image=img;
		[self.contentView addSubview:imageView];
		
		
		img=Image(@"logistics_end.png");
		imageView=[[UIImageView alloc]initWithFrame:CGRectMake(imageView.right+10, lineView.bottom+15, img.size.width, img.size.height)];
		imageView.image=img;
		[self.contentView addSubview:imageView];
		
		lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+10, imageView.top, 34, 17) textColor:cBlackColor textFont:sysFont(17)];
		lbl.text=@"北京";
		[self.contentView addSubview:lbl];
		
		lineView=[[UIView alloc]initWithFrame:CGRectMake(15, imageView.bottom+13, WindowWith-30, 1)];
		lineView.backgroundColor=cLineColor;
		[self.contentView addSubview:lineView];
		
		
		img=Image(@"carId.png");
		UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
		//btn.enabled=NO;
		[btn setBackgroundImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
		btn.frame=CGRectMake(WindowWith-img.size.width-15, lbl.top-8, img.size.width, img.size.height);
		[self.contentView addSubview:btn];
		[btn setTitle:@"湘A.BA612" forState:UIControlStateNormal];
		[btn setTitleColor:cBlackColor forState:UIControlStateNormal];
		btn.titleLabel.font=sysFont(15);
		
		
		lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lineView.left, lineView.bottom+13, 250, 16) textColor:cBlackColor textFont:sysFont(15)];
		lbl.text=@"车   型： 厢式   4.2米   8.0吨";
		if (WindowWith==320) {
			lbl.font=sysFont(13);
			lbl.width=240;
		}else if (WindowWith==414){
			lbl.font=sysFont(16);
			lbl.width=270;
		}
		
		
		
		
		
		[self.contentView addSubview:lbl];
		
		
		
		UIButton *phoneBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
		phoneBtn.backgroundColor=cGreenColor;
		phoneBtn.frame=CGRectMake(WindowWith-0.24*WindowWith-15, lbl.top, 0.24*WindowWith, 0.08*WindowWith);
		[phoneBtn setTitle:@"电 话" forState:UIControlStateNormal];
		[phoneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		phoneBtn.layer.cornerRadius=8;
		[phoneBtn addTarget:self action:@selector(phoneTap:) forControlEvents:UIControlEventTouchUpInside];
		[self.contentView addSubview:phoneBtn];
		
		
		
		
		UIButton *appointBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
		appointBtn.backgroundColor=[UIColor whiteColor];
		appointBtn.frame=CGRectMake(WindowWith-phoneBtn.width-15, phoneBtn.bottom+10, phoneBtn.width, phoneBtn.height);
		[appointBtn setTitle:@"预 约" forState:UIControlStateNormal];
		[appointBtn setTitleColor:cGreenColor forState:UIControlStateNormal];
		[appointBtn setLayerMasksCornerRadius:8 BorderWidth:1 borderColor:cGreenColor];
		[appointBtn addTarget:self action:@selector(apponitTap:) forControlEvents:UIControlEventTouchUpInside];
		[self.contentView addSubview:appointBtn];
		
		
		
		lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lineView.left, lbl.bottom+10, 0.56*WindowWith+20, 60) textColor:cBlackColor textFont:sysFont(15)];
		lbl.text=@"有车从湖南长沙出发，到上海，有货请联系。电话：13888111231";
		lbl.numberOfLines=0;
		if (WindowWith==320) {
			lbl.font=sysFont(13);
			
		}else if (WindowWith==414){
			lbl.font=sysFont(16);
			
		}
		
		NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:lbl.text];
		NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
		[paragraphStyle setLineSpacing:6];
		[attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [lbl.text length])];
		lbl.attributedText = attributedString;
		
		[lbl sizeToFit];
		
		
		[self.contentView addSubview:lbl];
		
		
		
		
		
		
		
		
		
		
		lineView=[[UIView alloc]initWithFrame:CGRectMake(lineView.left, lbl.bottom+12, WindowWith-lineView.left*2, 1)];
		lineView.backgroundColor=cLineColor;
		[self.contentView addSubview:lineView];
		
		
		
		UIImage *timeImg=Image(@"fav_time.png");
		UIImageView *timeImageView=[[UIImageView alloc]initWithFrame:CGRectMake(lineView.left, lineView.bottom+15, timeImg.size.width, timeImg.size.height)];
		timeImageView.image=timeImg;
		
		[self.contentView addSubview:timeImageView];
		
		SMLabel *timeLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(timeImageView.right+5, timeImageView.top, 150, 15) textColor:cGrayLightColor textFont:sysFont(15)];
		
		timeLbl.text=@"15小时前";
		[self.contentView addSubview:timeLbl];
		
		CGSize size=[IHUtility GetSizeByText:@"距我1.38公里" sizeOfFont:15 width:150];
		lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lineView.right-size.width, timeLbl.top, size.width, size.height) textColor:cGrayLightColor textFont:sysFont(15)];
		lbl.text=@"距我1.38公里";
		[self.contentView addSubview:lbl];
		
		
		
		
		
		
		lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 258, WindowWith, 2)];
		lineView.backgroundColor=cLineColor;
		[self.contentView addSubview:lineView];
	}
	return self;
}

-(void)headTap:(UIButton *)sender{
	
	
	
}


-(void)phoneTap:(UIButton *)sender{
	if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
		
		[self.delegate BCtableViewCell:self action:MTPhoneActionTableViewCell indexPath:self.indexPath attribute:nil];
		
		
	}
	
}

-(void)apponitTap:(UIButton *)sender{
	if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
		
		[self.delegate BCtableViewCell:self action:MTAppointActionTableViewCell indexPath:self.indexPath attribute:nil];
		
		
	}
	
}



@end


@implementation LogisticsFindGoodsTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 4)];
		[self.contentView addSubview:lineView];
		lineView.backgroundColor=RGBA(232, 239, 239, 1);
		
		LogisticsHeaderView *logisticsHeaderView=[[LogisticsHeaderView alloc]initWithFrame:CGRectMake(0, lineView.bottom, WindowWith, 65)];
		logisticsHeaderView.selectBtnBlock=^(NSInteger index){
			
			if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
				
				[self.delegate BCtableViewCell:self action:MTHeadViewActionTableViewCell indexPath:self.indexPath attribute:nil];
				
				
			}
			
		};
		[self.contentView addSubview:logisticsHeaderView];
		
		
		lineView=[[UIView alloc]initWithFrame:CGRectMake(15, logisticsHeaderView.bottom, WindowWith-30, 1)];
		lineView.backgroundColor=cLineColor;
		[self.contentView addSubview:lineView];
		
		
		UIImage *img=Image(@"logistics_start.png");
		UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(lineView.left+10, lineView.bottom+15, img.size.width, img.size.height)];
		imageView.image=img;
		[self.contentView addSubview:imageView];
		
		
		SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+10, imageView.top, 34, 17) textColor:cBlackColor textFont:sysFont(17)];
		lbl.text=@"长沙";
		[self.contentView addSubview:lbl];
		
		
		lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.right, lbl.top+2, 60, 15) textColor:cBlackColor textFont:sysFont(15)];
		lbl.text=@"-天心区";
		[self.contentView addSubview:lbl];
		
		
		
		
		img=Image(@"go.png");
		imageView=[[UIImageView alloc]initWithFrame:CGRectMake(WindowWith/2-img.size.width/2, lineView.bottom+5, img.size.width, img.size.height)];
		imageView.image=img;
		
		[self.contentView addSubview:imageView];
		
		
		img=Image(@"logistics_end.png");
		imageView=[[UIImageView alloc]initWithFrame:CGRectMake(imageView.right+20, lineView.bottom+15, img.size.width, img.size.height)];
		imageView.image=img;
		[self.contentView addSubview:imageView];
		
		lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+10, imageView.top, 34, 17) textColor:cBlackColor textFont:sysFont(17)];
		lbl.text=@"北京";
		[self.contentView addSubview:lbl];
		
		
		lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.right, lbl.top+2, 60, 15) textColor:cBlackColor textFont:sysFont(15)];
		lbl.text=@"-朝阳区";
		[self.contentView addSubview:lbl];
		
		
		
		lineView=[[UIView alloc]initWithFrame:CGRectMake(15, imageView.bottom+13, WindowWith-30, 1)];
		lineView.backgroundColor=cLineColor;
		[self.contentView addSubview:lineView];
		
		
		lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lineView.left, lineView.bottom+15, 200, 15) textColor:cBlackColor textFont:sysFont(15)];
		lbl.text=@"需用车：厢式   4.2米   8.0吨";
		[self.contentView addSubview:lbl];
		
		
		UIButton *phoneBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
		phoneBtn.backgroundColor=cGreenColor;
		phoneBtn.frame=CGRectMake(WindowWith-0.24*WindowWith-15, lbl.top, 0.24*WindowWith, 0.08*WindowWith);
		[phoneBtn setTitle:@"抢 单" forState:UIControlStateNormal];
		[phoneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		phoneBtn.layer.cornerRadius=8;
		[phoneBtn addTarget:self action:@selector(phoneTap:) forControlEvents:UIControlEventTouchUpInside];
		[self.contentView addSubview:phoneBtn];
		
		
		
		
		UIButton *appointBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
		appointBtn.backgroundColor=[UIColor whiteColor];
		appointBtn.frame=CGRectMake(WindowWith-phoneBtn.width-15, phoneBtn.bottom+10, phoneBtn.width, phoneBtn.height);
		[appointBtn setTitle:@"分 享" forState:UIControlStateNormal];
		[appointBtn setTitleColor:cGreenColor forState:UIControlStateNormal];
		[appointBtn setLayerMasksCornerRadius:8 BorderWidth:1 borderColor:cGreenColor];
		[appointBtn addTarget:self action:@selector(apponitTap:) forControlEvents:UIControlEventTouchUpInside];
		[self.contentView addSubview:appointBtn];
		
		
		
		
		lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.left, lbl.bottom+15, 200, 15) textColor:cBlackColor textFont:sysFont(15)];
		lbl.text=@"货   品：樟树 50";
		[self.contentView addSubview:lbl];
		
		lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.left, lbl.bottom+15, 200, 15) textColor:cBlackColor textFont:sysFont(15)];
		lbl.text=@"车   程：900公里";
		[self.contentView addSubview:lbl];
		
		
		lineView=[[UIView alloc]initWithFrame:CGRectMake(lineView.left, lbl.bottom+12, WindowWith-lineView.left*2, 1)];
		lineView.backgroundColor=cLineColor;
		[self.contentView addSubview:lineView];
		
		
		
		UIImage *timeImg=Image(@"fav_time.png");
		UIImageView *timeImageView=[[UIImageView alloc]initWithFrame:CGRectMake(lineView.left, lineView.bottom+10, timeImg.size.width, timeImg.size.height)];
		timeImageView.image=timeImg;
		
		[self.contentView addSubview:timeImageView];
		
		SMLabel *timeLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(timeImageView.right+5, timeImageView.top, 150, 15) textColor:cGrayLightColor textFont:sysFont(15)];
		
		timeLbl.text=@"15小时前";
		[self.contentView addSubview:timeLbl];
		
		CGSize size=[IHUtility GetSizeByText:@"距我1.38公里" sizeOfFont:15 width:150];
		lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lineView.right-size.width, timeLbl.top, size.width, size.height) textColor:cGrayLightColor textFont:sysFont(15)];
		lbl.text=@"距我1.38公里";
		[self.contentView addSubview:lbl];
		
		lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 258, WindowWith, 2)];
		lineView.backgroundColor=cLineColor;
		[self.contentView addSubview:lineView];
		
		
	}
	
	return self;
}


-(void)phoneTap:(UIButton *)sender{
	if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
		
		[self.delegate BCtableViewCell:self action:MTQiangDanActionTableViewCell indexPath:self.indexPath attribute:nil];
		
		
	}
	
}

-(void)apponitTap:(UIButton *)sender{
	if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
		
		[self.delegate BCtableViewCell:self action:MTShareActionTableViewCell indexPath:self.indexPath attribute:nil];
		
		
	}
	
}




@end




@implementation MTNewTopicListTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		UIImage *img=Image(@"jhgsjImg.png");
		UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 0.48*WindowWith)];
		imageView.image=img;
		_imageView=imageView;
		[self.contentView addSubview:imageView];
		
		UIView *bkView=[[UIView alloc]initWithFrame:imageView.frame];
		bkView.backgroundColor=RGBA(51, 51, 51, 0.45);
		[self.contentView addSubview:bkView];
		
		self.nameLabel = [[SMLabel alloc] initWithFrame:CGRectMake(20, 0.48*WindowWith/2 - 15, WindowWith - 40, 22)];
		self.nameLabel.numberOfLines = 0;
		self.nameLabel.font = [UIFont boldSystemFontOfSize:20];
		self.nameLabel.textAlignment = NSTextAlignmentCenter;
		self.nameLabel.textColor = [UIColor whiteColor];
		self.nameLabel.center=imageView.center;
		self.nameLabel.text = @"＃景观设计＃";
		[self.contentView addSubview:self.nameLabel];
		
		
		self.detailLabel=[[SMLabel alloc]initWithFrameWith:CGRectMake(15, imageView.bottom+15, 220, 15) textColor:cBlackColor textFont:sysFont(15)];
		self.detailLabel.text=@"风景园林规划设计";
		[self.contentView addSubview:self.detailLabel];
		
		
		
		img=Image(@"topics.png");
		imageView=[[UIImageView alloc]initWithFrame:CGRectMake(WindowWith-img.size.width-15, bkView.bottom-img.size.height/2+5, img.size.width, img.size.height)];
		imageView.image=img;
		[self.contentView addSubview:imageView];
		
		
		img=Image(@"jian.png");
		imageView=[[UIImageView alloc]initWithFrame:CGRectMake(WindowWith-img.size.width-15, 0.48*WindowWith+65, img.size.width, img.size.height)];
		imageView.image=img;
		[self.contentView addSubview:imageView];
		
		
		
		img=Image(@"see.png");
		imageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, 0.48*WindowWith+55, img.size.width, img.size.height)];
		imageView.image=img;
		[self.contentView addSubview:imageView];
		
		SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+5, imageView.top, 50, 14) textColor:cBlackColor textFont:sysFont(14)];
		lbl.text=@"1356";
		_seeLbl=lbl;
		[self.contentView addSubview:lbl];
		
		
		
		
		img=Image(@"plnumber.png");
		imageView=[[UIImageView alloc]initWithFrame:CGRectMake(lbl.right+25, 0.48*WindowWith+55, img.size.width, img.size.height)];
		imageView.image=img;
		[self.contentView addSubview:imageView];
		
		lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+5, imageView.top, 50, 14) textColor:cBlackColor textFont:sysFont(14)];
		lbl.text=@"656";
		_plLbl=lbl;
		[self.contentView addSubview:lbl];
		
		
		
		
		
		
		
	}
	return self;
}


-(void)setData:(ThemeListModel *)model{
	self.nameLabel.text=[NSString stringWithFormat:@"＃%@＃",model.theme_header];
	self.detailLabel.text=model.theme_content;
	[_imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.content_url]] placeholderImage:nil];
	
	_seeLbl.text=model.onlookers_user_num;
	_plLbl.text=model.commentTotal_num;
	
}




@end



@implementation HomePageTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		
		UIImage *img=Image(@"Bitmap.png");
		UIAsyncImageView *imageView=[[UIAsyncImageView alloc]initWithImage:img];
		_imageView=imageView;
		imageView.frame=CGRectMake(10, 10, img.size.width, img.size.height);
		[self.contentView addSubview:imageView];
		
		
		img=Image(@"play2.png");
		UIImageView * ImageView=[[UIImageView alloc]initWithFrame:CGRectMake(imageView.width/2-img.size.width/2, imageView.height/2-img.size.height/2, img.size.width, img.size.height)];
		
		ImageView.image=img;
		_ImageView=ImageView;
		_ImageView.hidden=YES;
		[imageView addSubview:ImageView];
		
		
		
		
		
		SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+10, imageView.top, WindowWith-imageView.width-20, 15) textColor:cBlackColor textFont:boldFont(15)];
		_titleLbl=lbl;
		lbl.text=@"磁悬浮深度评测";
		[self.contentView addSubview:lbl];
		
		
		lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+10, lbl.bottom+10, WindowWith-imageView.width-40, 40) textColor:cBlackColor textFont:sysFont(12)];
		_messLbl=lbl;
		lbl.text=@"高科技加绿色植物，我按捺不住的来个拆解，一探究竟。";
		lbl.numberOfLines=0;
		[self.contentView addSubview:lbl];
		
		
		
		lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+10, lbl.bottom+5, WindowWith-imageView.width-20, 12) textColor:cGrayLightColor textFont:sysFont(12)];
		_userLbl=lbl;
		
		lbl.text=@"陈明亮  发表于1分钟前";
		[self.contentView addSubview:lbl];
		
		
		UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 1)];
		lineView.backgroundColor=cLineColor;
		[self.contentView addSubview:lineView];
		
		
		
		
	}
	
	
	return self;
}



//-(void)setDataWithTopicModel:(HomePageTopicModel *)model
//{
//	[_imageView setImageAsyncWithURL:[NSString stringWithFormat:@"%@",model.show_image] placeholderImage:DefaultImage_logo];
//	CGSize size=[IHUtility GetSizeByText:model.recommend_title sizeOfFont:15 width:WindowWith-_imageView.right-20];
//	_titleLbl.size=CGSizeMake(size.width, size.height);
//	_titleLbl.font=boldFont(15);
//	_titleLbl.text=model.recommend_title;
//	// _titleLbl.numberOfLines=0;
//
//
//	size=[IHUtility GetSizeByText:model.recommend_desc sizeOfFont:12 width:WindowWith-_imageView.width-20];
//	_messLbl.frame=CGRectMake(_titleLbl.left, _titleLbl.bottom+5, size.width, size.height);
//
//	_messLbl.text=model.recommend_desc;
//
//
//
//	_userLbl.text=[NSString stringWithFormat:@"%@ 发表于%@",model.nickname,[IHUtility compareCurrentTimeString:model.create_time]];
//}

-(void)setDataWithNewsModel:(NewsListModel *)model
{
	NSArray *arr=[network getJsonForString:model.info_url];
	if (model.img_type==4) {
		_ImageView.hidden=NO;
	}
	
	[_imageView setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,arr.firstObject[@"t_url"]] placeholderImage:DefaultImage_logo];
	CGSize size=[IHUtility GetSizeByText:model.info_title sizeOfFont:15 width:WindowWith-_imageView.right-20-12];
	_titleLbl.size=CGSizeMake(WindowWith-_imageView.right-20-12, 15);
	
	//  _titleLbl.lineBreakMode = NSLineBreakByTruncatingTail;
	
	_titleLbl.text=model.info_title;
	size=[IHUtility GetSizeByText:model.infomation_desc sizeOfFont:12 width:WindowWith-_imageView.width-40];
	
	CGRect rect=_messLbl.frame;
	
	
	if (WindowWith==414) {
		if(size.height>40){
			rect.size.height=38;
		}else{
			rect.size.height=size.height;
		}
	}else{
		if (size.height>34) {
			rect.size.height=34;
		}else{
			rect.size.height=size.height;
		}
		
	}
	
	
	
	
	_messLbl.frame=rect;
	
	// _messLbl.frame=CGRectMake(_titleLbl.left, _titleLbl.bottom+5, size.width, size.height);
	_messLbl.numberOfLines=0;
	_messLbl.text=model.infomation_desc;
	
	_userLbl.text=[NSString stringWithFormat:@"%@ 发表于%@",model.info_from,[IHUtility compareCurrentTimeString:model.uploadtime]];
	
	
}

@end

@implementation HomePageHotTopicTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		
		self.contentView.backgroundColor=[UIColor whiteColor];
		UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 1)];
		lineView.backgroundColor=cLineColor;
		[self.contentView addSubview:lineView];
		
		
		UIAsyncImageView *imageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(0.143*0.224*WindowWith, 0.143*0.224*WindowWith, WindowWith-0.143*0.224*WindowWith*2, 0.435*(WindowWith-0.143*0.224*WindowWith*2))];
		_imageView=imageView;
		[self.contentView addSubview:imageView];
		
		
		SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(5, imageView.height-20, 50, 15) textColor:cGreenColor textFont:sysFont(15)];
		_messLbl=lbl;
		[imageView addSubview:lbl];
		
		
		lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.left, imageView.bottom+0.143*0.224*WindowWith, imageView.width, 15) textColor:RGB(44, 44, 46) textFont:sysFont(15)];
		_titleLbl=lbl;
		[self.contentView addSubview:lbl];
		
		
		
		lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.left, 240.5+0.143*0.224*WindowWith-25, imageView.width, 13) textColor:cGrayLightColor textFont:sysFont(13)];
		// lbl.textAlignment=NSTextAlignmentRight;
		_userLbl=lbl;
		lbl.text=@"陈明亮  发表于1分钟前";
		[self.contentView addSubview:lbl];
		
		
		
		
	}
	
	
	return self;
}


-(void)setDataWithIndepath:(NSIndexPath *)indexpath TopicModel:(HomePageTopicModel *)model{
	
	[_imageView setImageAsyncWithURL:[NSString stringWithFormat:@"%@",model.show_image] placeholderImage:DefaultImage_logo];
	
	// _titleLbl.font=sysFont(15);
	
	_titleLbl.numberOfLines=0;
	_titleLbl.lineBreakMode = NSLineBreakByTruncatingTail;
	NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",model.recommend_title]];
	
	[attrString addAttribute:NSFontAttributeName value: boldFont(15) range:NSMakeRange(0,attrString.length)];
	
	
	NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
	[paragraphStyle setLineSpacing:6];//调整行间距
	[attrString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attrString length])];
	[attrString addAttribute:NSForegroundColorAttributeName value:RGB(44, 44, 46) range:NSMakeRange(0,attrString.length)];
	_titleLbl.attributedText=attrString;
	
	CGSize size=[_titleLbl sizeThatFits:CGSizeMake(_imageView.width, CGFLOAT_MAX)];
	_titleLbl.size=CGSizeMake(size.width, size.height);
	
	
	
	if (size.width<_imageView.width) {
		_titleLbl.size=CGSizeMake(size.width, 15);
	}
	
	
	_messLbl.text=[NSString stringWithFormat:@"TOP %ld",(long)indexpath.row+1];
	_messLbl.hidden=YES;
	
	
	_userLbl.text=[NSString stringWithFormat:@"%@ 发表于%@",model.nickname,[IHUtility compareCurrentTimeString:model.create_time]];
	_userLbl.origin=CGPointMake(_imageView.left, _titleLbl.bottom+12);
	
	
	UIView  *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, _userLbl.bottom+0.143*0.224*WindowWith, WindowWith, 1)];
	lineView.backgroundColor=cLineColor;
	//    [self.contentView addSubview:lineView];
	
	
	
}


@end

@implementation EPCloudTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		self.backgroundColor = cLineColor;
		
		UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(12, 10, WindowWith-24, 67 + 163*(WindowWith/375.0))];
		backView.backgroundColor= [UIColor whiteColor];
		backView.layer.cornerRadius = 5;
		backView.clipsToBounds = YES;
		[self.contentView addSubview:backView];
		
		UIAsyncImageView *heardImg = [[UIAsyncImageView alloc] initWithFrame:CGRectMake(0, 0, backView.width, 163*(WindowWith/375.0))];
		heardImg.image = DefaultImage_logo;
		_heardImg = heardImg;
		[backView addSubview:heardImg];
		
		UIAsyncImageView *companyImg = [[UIAsyncImageView alloc]initWithFrame:CGRectMake(18, heardImg.bottom + 6.5, 52, 52)];
		companyImg.image = EPDefaultImage_logo;
		_companyImg = companyImg;
		companyImg.layer.cornerRadius = 26;
		[backView addSubview:companyImg];
		
		UIImage *img=Image(@"motouch_mini.png");
		UIImageView *imageView=[[UIImageView alloc]initWithFrame:companyImg.frame];
		imageView.image=img;
		[backView addSubview:imageView];
		
		EDStarRating *ratingImage  = [[EDStarRating alloc] initWithFrame:CGRectMake(companyImg.left , companyImg.bottom + 6, companyImg.width, 12)];
		_ratingImage = ratingImage;
		_ratingImage.starImage = [UIImage imageNamed:@"starminiwhite.png"];
		_ratingImage.starHighlightedImage = [UIImage imageNamed:@"starminigreen.png"];
		_ratingImage.maxRating = 5.0;
		_ratingImage.rating = 3.5;
		_ratingImage.editable = NO;
		_ratingImage.horizontalMargin = 0;
		_ratingImage.displayMode = EDStarRatingDisplayHalf;
		_ratingImage.delegate = self;
		//        [backView addSubview:ratingImage];
		
		SMLabel *companyLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(companyImg.right + 12, companyImg.top + 8, backView.width -companyImg.right - 20 , 18) textColor:RGBA(44, 44, 46, 1) textFont:sysFont(18)];
		_companyLbl = companyLbl;
		companyLbl.text = @"深圳文科园林股份有限公司";
		[backView addSubview:companyLbl];
		
		SMLabel *companyInfo = [[SMLabel alloc] initWithFrameWith:CGRectMake(companyLbl.left, companyLbl.bottom + 8, companyLbl.width, 13) textColor:RGBA(135, 134, 140, 1) textFont:sysFont(13)];
		_companyInfo = companyInfo;
		companyInfo.text = @"景观设计 | 合资股份 | 500-999人";
		[backView addSubview:companyInfo];
		
		SMLabel *companyType = [[SMLabel alloc] initWithFrameWith:CGRectMake(companyLbl.left, companyInfo.bottom + 8, companyLbl.width, 13) textColor:RGBA(135, 134, 140, 1) textFont:sysFont(13)];
		_companyType = companyType;
		companyType.text = @"设计甲 | 城市园林绿化一级资质 | 国家城市规划园林企业";
		//        [backView addSubview:companyType];
		
		
	}
	return self;
}
- (void)setlistModel:(EPCloudListModel *)model
{
	if (model.imageArr.count > 0) {
		MTPhotosModel *mod  = model.imageArr[0];
		[_heardImg setImageAsyncWithURL:mod.imgUrl placeholderImage:DefaultImage_logo];
	}else {
		_heardImg.image = DefaultImage_logo;
	}
	
	
	[_companyImg setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,model.logo] placeholderImage:EPDefaultImage_logo];
	
	_ratingImage.rating = model.level;
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
	
	if (model.qualify_list.count == 0) {
		_companyType.text = [NSString stringWithFormat:@"%@",model.company_label];
	}else {
		NSString *str;
		for (NSDictionary *dic in model.qualify_list) {
			if (str == nil) {
				str = [NSString stringWithFormat:@"%@",dic[@"quali_name"]];
			}else {
				str = [NSString stringWithFormat:@"%@ | %@",str,dic[@"quali_name"]];
			}
			
		}
		
		if ([model.company_label isEqualToString:@""]) {
			_companyType.text = [NSString stringWithFormat:@"%@",str];
		}else
		{
			_companyType.text = [NSString stringWithFormat:@"%@ | %@",str,model.company_label];
		}
		
	}
	
	
	
}
@end

@implementation EPCloudCumlativeTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		
		UIImage *img=Image(@"EP_zizhi.png");
		UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(12, 72.5/2-img.size.height/2, img.size.width, img.size.height)];
		_imageView=imageView;
		[self.contentView addSubview:imageView];
		
		
		SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+12, 0, 200, 14.5) textColor:cBlackColor textFont:sysFont(14.5)];
		lbl.centerY=imageView.centerY;
		_lbl=lbl;
		[self.contentView addSubview:lbl];
		
		
		img=Image(@"GQ_Left.png");
		imageView=[[UIImageView alloc]initWithFrame:CGRectMake(WindowWith-img.size.width-12, 72.5/2-img.size.height/2, img.size.width, img.size.height)];
		imageView.image=img;
		
		[self.contentView addSubview:imageView];
		
		
		
		
		img=Image(@"EP_right.png");
		imageView=[[UIImageView alloc]initWithFrame:CGRectMake(imageView.left-img.size.width-12, 72.5/2-img.size.height/2, img.size.width, img.size.height)];
		imageView.image=img;
//		_RightimageView=imageView;
		imageView.hidden=YES;
		[self.contentView addSubview:imageView];
		
		
		
		
		UIView  *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 71.5, WindowWith, 1)];
		lineView.backgroundColor=cLineColor;
		[self.contentView addSubview:lineView];
		
		
		
	}
	return self;
}
-(void)setDataWithArr:(NSDictionary *)dic{
	_imageView.image=Image(dic[@"image"]);
	_lbl.text=dic[@"title"];
	
	
}

@end

@implementation companyTrackCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		self.backgroundColor = cLineColor;
		
		UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(6, 6, WindowWith-12, 90)];
		backView.backgroundColor= [UIColor whiteColor];
		[self.contentView addSubview:backView];
		
		UIAsyncImageView *heardImg = [[UIAsyncImageView alloc] initWithFrame:CGRectMake(6, 6, 26, 26)];
		heardImg.image = defalutHeadImage;
		_heardImg = heardImg;
		//        _heardImg = heardImg;
		[backView addSubview:heardImg];
		
		SMLabel *userLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(heardImg.right + 11, 0, backView.width - 100 - heardImg.right, 13) textColor:cGrayLightColor textFont:sysFont(13)];
		userLbl.centerY = heardImg.centerY;
		_userLbl = userLbl;
		userLbl.text=@"张爱丽 发表的供应";
		
		NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:userLbl.text];
		[str addAttribute:NSForegroundColorAttributeName value:RGBA(6, 193, 174, 1)range:NSMakeRange(userLbl.text.length - 2, 2)];
		userLbl.attributedText = str;
		[backView addSubview:userLbl];
		
		//        CGSize size=[IHUtility GetSizeByText:@"2016.02.12" sizeOfFont:13 width:100];
		//        SMLabel *timeLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(0, 0, size.width, 13) textColor:cGrayLightColor textFont:sysFont(13)];
		//        timeLbl.centerY = heardImg.centerY;
		//        timeLbl.right = backView.width - 6;
		//        timeLbl.text=@"2016.02.12";
		//        timeLbl.textAlignment = NSTextAlignmentRight;
		//        [backView addSubview:timeLbl];
		
		SMLabel *contentLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(6, heardImg.bottom + 11, 220, 13) textColor:RGBA(44, 44, 46, 1) textFont:sysFont(14)];
		contentLbl.text=@"浦城桂花（600株）";
		_contentLbl = contentLbl;
		[backView addSubview:contentLbl];
		
		CGSize size2=[IHUtility GetSizeByText:@"320" sizeOfFont:18 width:100];
		SMLabel *priceLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(6, 30, size2.width, size2.height) textColor:RGBA(6, 193, 174, 1) textFont:sysFont(18)];
		priceLbl.centerY = contentLbl.centerY;
		priceLbl.right = backView.width - 6;
		priceLbl.text=@"320";
		_priceLbl = priceLbl;
		[backView addSubview:priceLbl];
		
		SMLabel *Lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(6, 30, 15, 15) textColor:RGBA(6, 193, 174, 1) textFont:sysFont(14)];
		Lbl.centerY = priceLbl.centerY;
		Lbl.right = priceLbl.left - 2;
		Lbl.text=@"￥";
		[backView addSubview:Lbl];
		
		Lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(6, contentLbl.bottom + 8, backView.width - 12, 15) textColor:RGBA(132, 131, 136, 1) textFont:sysFont(13)];
		Lbl.text=@"#杆径30cm   #冠幅25-35cm  #高度30cm  #分枝点30cm";
		_needLbl = Lbl;
		[backView addSubview:Lbl];
		
		
	}
	return self;
}

- (void)setTrackData:(CompanyTrackModel *)model
{
	[_heardImg setImageAsyncWithURL:model.heed_image_url placeholderImage:defalutHeadImage];
	
	_userLbl.text = [NSString stringWithFormat:@"%@ 发表的%@",model.nickname,model.type];
	UIColor *color;
	if ([model.type isEqualToString:@"供应"]) {
		color = RGBA(6, 193, 174, 1);
	}else {
		color = [UIColor redColor];
	}
	NSMutableAttributedString *str = [IHUtility changePartTextColor:_userLbl.text range:NSMakeRange(_userLbl.text.length - 2, 2) value:color];
	_userLbl.attributedText = str;
	
	_contentLbl.text = [NSString stringWithFormat:@"%@(%ld株)",model.varieties,(long)model.number];
	
	if ([model.unit_price isEqualToString:@""]) {
		_priceLbl.text = [NSString stringWithFormat:@"0.0"];
		
	}else {
		_priceLbl.text = [NSString stringWithFormat:@"%@",model.unit_price];
	}
	
	NSString *rod_diameter;
	if (model.rod_diameter == 0) {
		rod_diameter = @"";
	}else {
		rod_diameter = [NSString stringWithFormat:@"#杆径%ldcm",model.rod_diameter];
	}
	
	NSString *crown_width;
	if (model.crown_width_s == model.crown_width_e) {
		if (model.crown_width_s == 0) {
			crown_width = [NSString stringWithFormat:@""];
		}else {
			crown_width = [NSString stringWithFormat:@"#冠幅%ldcm",model.crown_width_e];
		}
	}else {
		crown_width = [NSString stringWithFormat:@"#冠幅%ld-%ldcm",model.crown_width_s,model.crown_width_e];
	}
	
	NSString *height;
	if (model.height_s == model.height_e) {
		if (model.height_s == 0) {
			height = [NSString stringWithFormat:@""];
		}else {
			height = [NSString stringWithFormat:@"#高度%ldcm",model.height_e];
		}
	}else {
		height = [NSString stringWithFormat:@"#高度%ld-%ldcm",model.height_s,model.height_e];
	}
	
	NSString *branch_point;
	if (model.branch_point == 0) {
		branch_point = @"";
	}else {
		branch_point = [NSString stringWithFormat:@"#分枝点%ldcm",model.branch_point];
	}
	
	_needLbl.text = [NSString stringWithFormat:@"%@%@%@%@",rod_diameter,crown_width,height,branch_point];
	
}

@end


@implementation EPCloudCommentListCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		
		UIAsyncImageView *companyImg = [[UIAsyncImageView alloc]initWithFrame:CGRectMake(12, 8, 41, 41)];
		companyImg.image = EPDefaultImage_logo;
		_companyImg = companyImg;
		[_companyImg setLayerMasksCornerRadius:20.5 BorderWidth:0 borderColor:[UIColor clearColor]];
		[self.contentView addSubview:companyImg];
		
		EDStarRating *ratingImage  = [[EDStarRating alloc] initWithFrame:CGRectMake(companyImg.right + 12, companyImg.top, 85, 16)];
		_ratingImage = ratingImage;
		_ratingImage.starImage = [UIImage imageNamed:@"starmediumwhite.png"];
		_ratingImage.starHighlightedImage = [UIImage imageNamed:@"starmediumgreen.png"];
		_ratingImage.maxRating = 5.0;
		_ratingImage.rating = 3.5;
		_ratingImage.editable = NO;
		_ratingImage.horizontalMargin = 0;
		_ratingImage.displayMode = EDStarRatingDisplayHalf;
		_ratingImage.delegate = self;
		[self.contentView addSubview:ratingImage];
		
		
		SMLabel *userlabel  = [[SMLabel alloc] initWithFrameWith:CGRectMake(0, 0, 100, 13) textColor:cGrayLightColor textFont:sysFont(13)];
		userlabel.textAlignment =  NSTextAlignmentRight;
		userlabel.text = @"爽***发";
		_userlabel = userlabel;
		userlabel.right = WindowWith-10;
		userlabel.centerY = _ratingImage.centerY;
		[self.contentView addSubview:userlabel];
		
		CGSize size = [IHUtility GetSizeByText:@"诚信的柯总，价格实惠，好评诚信的柯总，价格实惠，好评诚信的柯总，价格实惠，好评诚信的柯总，价格实惠，好评" sizeOfFont:14 width:WindowWith-_ratingImage.left-12];
		SMLabel *contentlbl  = [[SMLabel alloc] initWithFrameWith:CGRectMake(_ratingImage.left, _ratingImage.bottom + 10, WindowWith-_ratingImage.left-12, size.height) textColor:RGBA(44, 44, 46, 1) textFont:sysFont(14)];
		contentlbl.numberOfLines= 0;
		_contentlbl = contentlbl;
		contentlbl.text = @"诚信的柯总，价格实惠，好评诚信的柯总，价格实惠，好评诚信的柯总，价格实惠，好评诚信的柯总，价格实惠，好评";
		
		[self.contentView addSubview:contentlbl];
		
		SMLabel *timeLbl  = [[SMLabel alloc] initWithFrameWith:CGRectMake(_ratingImage.left, contentlbl.bottom + 13, 100, 13) textColor:cGrayLightColor textFont:sysFont(13)];
		timeLbl.text = @"2016.06.20";
		_timeLbl = timeLbl;
		[self.contentView addSubview:timeLbl];
		
		UIView *lineView2=[[UIView alloc]initWithFrame:CGRectMake(12, self.height - 0.5, WindowWith - 24, 0.5)];
		lineView2.backgroundColor=cLineColor;
		_lineView = lineView2;
		[self.contentView addSubview:lineView2];
		
	}
	return self;
}

- (void)setDate:(companyListModel *)model
{
	[_companyImg setImageAsyncWithURL:model.heed_image_url placeholderImage:EPDefaultImage_logo];
	
	NSString *str = [model.nickname substringToIndex:1];
	_userlabel.text = [NSString stringWithFormat:@"%@*****",str];
	if (model.anonymous == 0) {
		_userlabel.text = @"匿名用户";
	}
	
	_ratingImage.rating = model.level;
	CGSize size = [IHUtility GetSizeByText:model.comment_content sizeOfFont:14 width:WindowWith-_ratingImage.left-12];
	_contentlbl.height = size.height;
	_contentlbl.text = model.comment_content;
	
	_timeLbl.top = _contentlbl.bottom + 13;
	
	_timeLbl.text=[IHUtility compareCurrentTimeString:model.create_time];
	
	_lineView.top = [model.cellHeigh floatValue]- 0.5;
	
}

@end

@implementation FriendCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		self.height = 60;
		
		UIImage *img=EPDefaultImage_logo;
		
		UIAsyncImageView *imageView = [[UIAsyncImageView alloc] initWithFrame:CGRectMake(10, 0, img.size.width, img.size.height)];
		imageView.image = img;
		_imageView = imageView;
		imageView.layer.cornerRadius = img.size.width/2.0;
		imageView.centerY = self.height/2.0;
		[self.contentView addSubview:imageView];
		
		for (int i=0; i<4; i++) {
			SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right + 6 +(WindowWith - imageView.right - 6)/5.0*i, 0, (WindowWith-imageView.right - 6)/5.0, 20) textColor:RGBA(135, 134, 140, 1) textFont:sysFont(14)];
			lbl.textAlignment = NSTextAlignmentCenter;
			lbl.text = @"测试";
			lbl.centerY = self.height/2.0;
			[self.contentView addSubview:lbl];
			if (i == 0) {
				lbl.width = (WindowWith-imageView.right - 6)/5.0*2;
				lbl.top = imageView.top;
				lbl.textAlignment = NSTextAlignmentLeft;
				_namelbl =lbl;
			}else if (i==1){
				lbl.left = imageView.right + 6 +(WindowWith - imageView.right - 6)/5.0*(i+1);
				_timelbl = lbl;
			}else if (i == 2){
				lbl.left = imageView.right + 6 +(WindowWith - imageView.right - 6)/5.0*(i+1);
				_statelbl =lbl;
			}else {
				lbl.left = imageView.right + 6 +(WindowWith - imageView.right - 6)/5.0*(i+1);
				_moneylbl =lbl;
			}
		}
		
		SMLabel *phonlbl = [[SMLabel alloc]initWithFrameWith:CGRectMake(_namelbl.left, _namelbl.bottom, _namelbl.width, 20) textColor:RGBA(135, 134, 140, 1) textFont:sysFont(14)];
		_phonelbl = phonlbl;
		phonlbl.textColor = cGreenColor;
		phonlbl.userInteractionEnabled = YES;
		[self.contentView addSubview:phonlbl];
		
		UITapGestureRecognizer *phonrTap  = [[UITapGestureRecognizer alloc]
											 initWithTarget:self action:@selector(takePhone:)];
		phonrTap.numberOfTapsRequired= 1;
		phonrTap.numberOfTouchesRequired= 1;
		[phonlbl addGestureRecognizer:phonrTap];
		
		UIView *lineView2=[[UIView alloc]initWithFrame:CGRectMake(12, self.height - 0.5, WindowWith - 24, 0.5)];
		lineView2.backgroundColor=cLineColor;
		[self.contentView addSubview:lineView2];
		
	}
	return self;
}
- (void)takePhone:(UITapGestureRecognizer *)tap
{
	if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
		
		[self.delegate BCtableViewCell:self action:MTPhoneActionTableViewCell indexPath:self.indexPath attribute:nil];
		
		
	}
}


- (void)setData:(InvatedFriendslistModel *)model
{
	[_imageView setImageAsyncWithURL:model.heed_image_url placeholderImage:defalutHeadImage];
	_namelbl.text = model.nickname;
	_timelbl.text = model.create_time;
	_statelbl.text = model.status;
	_phonelbl.text = model.user_name;
	_moneylbl.text = [NSString stringWithFormat:@"+%ld元",(long)model.money];
	_moneylbl.textColor = RGB(245, 166, 35);
}

@end

@implementation BindCompanyListCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		self.backgroundColor = cLineColor;
		
		UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(6, 7, WindowWith-12, 91)];
		backView.backgroundColor= [UIColor whiteColor];
		[self.contentView addSubview:backView];
		
		UIAsyncImageView *companyImg = [[UIAsyncImageView alloc]initWithFrame:CGRectMake(12, 12, 52, 52)];
		companyImg.image = EPDefaultImage_logo;
		_companyImg = companyImg;
		[backView addSubview:companyImg];
		
		EDStarRating *ratingImage  = [[EDStarRating alloc] initWithFrame:CGRectMake(companyImg.left , companyImg.bottom + 6, companyImg.width, 12)];
		_ratingImage = ratingImage;
		_ratingImage.starImage = [UIImage imageNamed:@"starminiwhite.png"];
		_ratingImage.starHighlightedImage = [UIImage imageNamed:@"starminigreen.png"];
		_ratingImage.maxRating = 5.0;
		_ratingImage.rating = 3.5;
		_ratingImage.editable = NO;
		_ratingImage.horizontalMargin = 0;
		_ratingImage.displayMode = EDStarRatingDisplayHalf;
		_ratingImage.delegate = self;
		[backView addSubview:ratingImage];
		
		SMLabel *companyLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(companyImg.right + 12, companyImg.top + 8, backView.width -companyImg.right - 20 , 15) textColor:RGBA(44, 44, 46, 1) textFont:sysFont(17)];
		_companyLbl = companyLbl;
		companyLbl.text = @"深圳文科园林股份有限公司";
		[backView addSubview:companyLbl];
		
		SMLabel *companyInfo = [[SMLabel alloc] initWithFrameWith:CGRectMake(companyLbl.left, companyLbl.bottom + 8, companyLbl.width - 30, 13) textColor:RGBA(135, 134, 140, 1) textFont:sysFont(13)];
		_companyInfo = companyInfo;
		companyInfo.text = @"景观设计 | 合资股份 | 500-999人";
		[backView addSubview:companyInfo];
		
		SMLabel *companyType = [[SMLabel alloc] initWithFrameWith:CGRectMake(companyLbl.left, companyInfo.bottom + 8, companyLbl.width, 13) textColor:RGBA(135, 134, 140, 1) textFont:sysFont(13)];
		_companyType = companyType;
		companyType.text = @"设计甲 | 城市园林绿化一级资质 | 国家城市规划园林企业";
		[backView addSubview:companyType];
		
		
	}
	return self;
}
- (void)setlistModel:(BindCompanyModel *)model
{
	
	[_companyImg setImageAsyncWithURL:model.logo placeholderImage:EPDefaultImage_logo];
	
	_ratingImage.rating = model.level;
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
	
	if (model.qualify_list.count == 0) {
		_companyType.text = [NSString stringWithFormat:@"%@",model.company_label];
	}else {
		NSString *str;
		for (NSDictionary *dic in model.qualify_list) {
			if (str == nil) {
				str = [NSString stringWithFormat:@"%@",dic[@"quali_name"]];
			}else {
				str = [NSString stringWithFormat:@"%@ | %@",str,dic[@"quali_name"]];
			}
			
		}
		
		if ([model.company_label isEqualToString:@""]) {
			_companyType.text = [NSString stringWithFormat:@"%@",str];
		}else
		{
			_companyType.text = [NSString stringWithFormat:@"%@ | %@",str,model.company_label];
		}
		
	}
	
	
	
}
@end

@implementation EPCloudConnectionTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		self.backgroundColor= cLineColor;
		UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 6)];
		lineView.backgroundColor=cLineColor;
		[self.contentView addSubview:lineView];
		self.view=[[ConnectionsView alloc]initWithFrame:CGRectMake(6, 6, WindowWith-12, 0.421*WindowWith-6)];
		__weak typeof(self)weakself = self;
		self.view.selectBtnBlock=^(NSInteger index){
			__strong typeof(weakself)strongself = weakself;
			if (index==SelectFollowBlock) {
				
				if ([strongself.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
					[strongself.delegate BCtableViewCell:strongself action:MTActivityFollowBMTableViewCell indexPath:strongself.indexPath attribute:nil];
				}
				
				
			}else if (index==SelectUpFollowBlock){
				if ([strongself.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
					
					[strongself.delegate BCtableViewCell:strongself action:MTActivityUpFollowBMTableViewCell indexPath:strongself.indexPath attribute:nil];
					
					
				}
				
			}
		};
		
		[self.contentView addSubview:self.view];
		
		_view=self.view;
	}
	return self;
}

-(void)setDataWithModel:(MTConnectionModel *)model{
	
	[_view setDataWithModel:model];
	
}



@end



@implementation EPCloudFansTableViewCell
@synthesize model;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		
		
		UIAsyncImageView *imageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(0.037*WindowWith, 0.037*WindowWith, 0.1*WindowWith, 0.1*WindowWith)];
		_imageView=imageView;
		[imageView setLayerMasksCornerRadius:0.05*WindowWith BorderWidth:0 borderColor:[UIColor clearColor]];
		imageView.image=defalutHeadImage;
		[self.contentView addSubview:imageView];
		
		_VipimageView =[[UIAsyncImageView alloc]initWithFrame:CGRectMake(_imageView.right - kWidth(12), _imageView.bottom - kWidth(14), kWidth(16), kWidth(16))];
		_VipimageView.image = kImage(@"gongqiu_vip");
		[self.contentView addSubview:_VipimageView];
		_VipimageView.hidden = YES;
		
		SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+12, imageView.top+2, 0.773*WindowWith -imageView.right-20, 14) textColor:cBlackColor textFont:sysFont(14)];
		lbl.text=@"张爱丽";
		_nickname=lbl;
		[self.contentView addSubview:lbl];
		
		
		
		UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
		
		btn.backgroundColor=RGB(239, 239, 242);
		[btn setTitle:@"+  关注" forState:UIControlStateNormal];
		btn.titleLabel.font=sysFont(10);
		[btn setTitleColor:RGB(120, 142, 126) forState:UIControlStateNormal];
		_btn=btn;
		[_btn setImage:Image(@"EP_yes") forState:UIControlStateHighlighted];
		[_btn setTitle:@"已关注" forState:UIControlStateHighlighted];
		_btn.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
		btn.frame=CGRectMake(0.773*WindowWith, 20, 0.194*WindowWith, 0.066*WindowWith);
		[self.contentView addSubview:btn];
		
		[btn addTarget:self action:@selector(guanzhu:) forControlEvents:UIControlEventTouchUpInside];
		
		
		
		lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.left, lbl.bottom+8, btn.left-12-lbl.left, 13) textColor:cGrayLightColor textFont:sysFont(13)];
		lbl.text=@"深圳 | 苗途站长";
		_title=lbl;
		[self.contentView addSubview:lbl];
		
		UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(lbl.left, 63, WindowWith-lbl.left, 1)];
		lineView.backgroundColor=cLineColor;
		[self.contentView addSubview:lineView];
		
		
		
	}
	return self;
}






-(void)guanzhu:(UIButton *)sender{
	
	sender.selected=!sender.selected;
	
	if (sender.selected) {
		
		if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
			[self.delegate BCtableViewCell:self action:MTActivityFollowBMTableViewCell indexPath:self.indexPath attribute:model];
		}
		[sender setImage:Image(@"EP_yes") forState:UIControlStateNormal];
		[sender setTitle:@"已关注" forState:UIControlStateNormal];
		sender.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
	}else
	{
		
		if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
			[self.delegate BCtableViewCell:self action:MTActivityUpFollowBMTableViewCell indexPath:self.indexPath attribute:model];
		}
		
		
		[sender setImage:nil forState:UIControlStateNormal];
		[sender setTitle:@"+  关注" forState:UIControlStateNormal];
	}
	
}



-(void)setDataWith{
	
	[_imageView setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@%@",ConfigManager.ImageUrl,model.heed_image_url,smallHeaderImage] placeholderImage:defalutHeadImage];
	CGSize size=[IHUtility GetSizeByText:model.nickname sizeOfFont:14 width:250];
	_nickname.text=model.nickname;
	//    _nickname.size=CGSizeMake(size.width, 14);
	
	
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
	
	size=[IHUtility GetSizeByText:model.title sizeOfFont:13 width:_btn.left-12-_nickname.left];
	_title.text=model.title;
	if ([model.title isEqualToString:@"(null)"]) {
		_title.text=@"";
	}
	_title.size=CGSizeMake(size.width, 13);
	
	if ([model.follow_id isEqualToString:USERMODEL.userID]) {
		_btn.hidden=YES;
	}
	
	if ([model.isVip isEqualToString:@"1"]) {
		_VipimageView.hidden = NO;
		_nickname.textColor = kColor(@"#F25900");
	}else {
		_VipimageView.hidden = YES;
		_nickname.textColor = cBlackColor;
	}
	
	
}
@end


@implementation MTChartsTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		
		self.backgroundColor=RGB(247, 248, 249);
		UIImage *img=Image(@"Vote_Charts_bg.png");
		img=[img stretchableImageWithLeftCapWidth:img.size.width/2 topCapHeight:img.size.height/6];
		UIImageView *bkImageView=[[UIImageView alloc]initWithFrame:CGRectMake(kWidth(13), kWidth(9), iPhoneWidth - kWidth(26), kWidth(110))];
		//        bkImageView.image=img;
		bkImageView.backgroundColor = [UIColor whiteColor];
		[self.contentView addSubview:bkImageView];
		
		
		//        UIAsyncImageView *headImageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(kWidth(11), kWidth(9), kWidth(134), kWidth(90))];
		UIAsyncImageView *headImageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(kWidth(11), kWidth(9), kWidth(90), kWidth(90))];
		headImageView.image=defalutHeadImage;
		_headImageView = headImageView;
		[bkImageView addSubview:headImageView];
		
		
		//        img=Image(@"Vote_Charts_colorblack.png");
		UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(bkImageView.left+kWidth(11), bkImageView.top - kWidth(5), kWidth(47), kWidth(27))];
		//        imageView.image=img;
		_imageView=imageView;
		[self.contentView addSubview:imageView];
		
		
		SMLabel *number=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, kWidth(4), _imageView.width, 15) textColor:[UIColor whiteColor] textFont:darkFont(13)];
		_number=number;
		[imageView addSubview:number];
		
		SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(headImageView.right+kWidth(10), headImageView.top, bkImageView.width - headImageView.right - kWidth(20), headImageView.height/2 - kWidth(5)) textColor:cBlackColor textFont:sysFont(font(14))];
		lbl.text=@"张丽江";
		_namelbl = lbl;
		_namelbl.numberOfLines = 2;
		[bkImageView addSubview:lbl];
		
		lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(_namelbl.left, _namelbl.bottom , _namelbl.width, kWidth(34)) textColor:cGrayLightColor textFont:sysFont(font(13))];
		lbl.text=@"#001号 #长沙  #丰庆园林";
		_inforlbl = lbl;
		_inforlbl.numberOfLines = 2;
		[bkImageView addSubview:lbl];
		
		lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(_namelbl.left, _inforlbl.bottom + kWidth(3), _namelbl.width/2, kWidth(14)) textColor:kColor(@"#FE0000") textFont:sysFont(font(14))];
		lbl.text=@"312票";
		_voteNumlbl =lbl;
		[bkImageView addSubview:lbl];
		
		lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(_voteNumlbl.right , _voteNumlbl.top, _voteNumlbl.width, _voteNumlbl.height) textColor:kColor(@"#00B7AA") textFont:sysFont(font(14))];
		lbl.text=@"占比";
		_ratiolbl=lbl;
		[bkImageView addSubview:lbl];
		
		
		
	}
	return self;
}

-(void)setDataWith:(NSIndexPath *)indexPath model:(VoteListModel *)model{
	
	UIImage *img=Image(@"icon_topsx");
	_number.hidden = NO;
	if (indexPath.row==0) {
		img=Image(@"icon_topyi");
		_number.hidden = YES;
	}else if (indexPath.row==1){
		img=Image(@"icon_tope");
		_number.hidden = YES;
	}else if (indexPath.row==2){
		img=Image(@"icon_topsan");
		_number.hidden = YES;
	}
	_imageView.image=img;
	
	_number.text=[NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
	_number.textAlignment = NSTextAlignmentCenter;
	
	[_headImageView setImageAsyncWithURL:model.head_image placeholderImage:defalutHeadImage];
	_namelbl.text = model.name;
	CGSize size = [IHUtility GetSizeByText:_namelbl.text sizeOfFont:font(14) width:_namelbl.width];
	_namelbl.height = size.height;
	
	_inforlbl.text = [NSString stringWithFormat:@"#%@号 #%@  #%@",model.project_code,model.city,model.company_info];
	_inforlbl.origin = CGPointMake(_namelbl.left, _namelbl.bottom+kWidth(10));
	size = [IHUtility GetSizeByText:_inforlbl.text sizeOfFont:font(13) width:_inforlbl.width];
	_inforlbl.height = size.height;
	
	_voteNumlbl.text = [NSString stringWithFormat:@"%ld票",(long)model.vote_num];
	//    size = [IHUtility GetSizeByText:_voteNumlbl.text sizeOfFont:16 width:_lbl.left - _headImageView.right-0.06*WindowWith];
	//    _voteNumlbl.width = size.width;
	
	//    if (_namelbl.width > _lbl.left - _headImageView.right-0.06*WindowWith - _voteNumlbl.width) {
	//        _namelbl.width =  _lbl.left - _headImageView.right-0.06*WindowWith - _voteNumlbl.width;
	//    }
	//    _voteNumlbl.left = _namelbl.right + 0.04*WindowWith;
	
	_ratiolbl.text = [NSString stringWithFormat:@"占比%d%%",100*(int)model.vote_num/[model.totalNum intValue]];
}


@end


@implementation CrowdFundingTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		
		self.backgroundColor=RGB(247, 248, 250);
		
		UIAsyncImageView *headImageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(0.0666*WindowWith, 0.04*WindowWith, 0.08*WindowWith, 0.08*WindowWith)];
		headImageView.image=defalutHeadImage;
		_headImageView=headImageView;
		headImageView.userInteractionEnabled=YES;
		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headTap)];
		
		[headImageView addGestureRecognizer:tap];
		
		[  _headImageView setLayerMasksCornerRadius:0.04*WindowWith BorderWidth:0 borderColor:[UIColor clearColor]];
		[self.contentView addSubview:headImageView];
		
		
		UIImage *img=Image(@"pay_bg.png");
		UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0.026*WindowWith+headImageView.right, headImageView.top, 0.728*WindowWith, 0.226*WindowWith)];
		imageView.image=img;
		_imageView=imageView;
		[self.contentView addSubview:imageView];
		
		SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0.04*WindowWith, 5, 60, 12) textColor:cBlackColor textFont:sysFont(12)];
		lbl.text=@"叮当喵叽:";
		_namelbl=lbl;
		[imageView addSubview:lbl];
		
		
		lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.width-70, 5, 60, 12) textColor:cBlackColor textFont:sysFont(12)];
		_priceLbl=lbl;
		[imageView addSubview:lbl];
		
		
		
		lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0.04*WindowWith, lbl.bottom+0.0266*WindowWith, imageView.width-0.08*WindowWith, 35) textColor:cBlackColor textFont:sysFont(12)];
		lbl.text=@"嘛钱不钱的，伤感情。这么着吧，这次哇帮你，下次你帮我！";
		lbl.numberOfLines=0;
		_messageLbl=lbl;
		[imageView addSubview:lbl];
		
		
		lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0.04*WindowWith, lbl.bottom+0.0266*WindowWith, 36, 10) textColor:cBlackColor textFont:sysFont(10)];
		lbl.text=@"1分钟前";
		_timeLbl=lbl;
		[imageView addSubview:lbl];
		
		
		
	}
	return self;
}
-(void)headTap{
	
	if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
		[self.delegate BCtableViewCell:self action:MTHeadViewActionTableViewCell indexPath:self.indexPath attribute:nil];
	}
	
}

-(void)setDataWith:(CrowdListModel *)model
{
	[_headImageView setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@%@",ConfigManager.ImageUrl,model.head_image,smallHeaderImage] placeholderImage:defalutHeadImage];
	CGSize size=[IHUtility GetSizeByText:model.nickname sizeOfFont:12 width:(_imageView.width-10)/2];
	_namelbl.text=model.nickname;
	_namelbl.size=CGSizeMake(size.width, 12);
	
	NSString *str=[NSString stringWithFormat:@"付款%.1f元",model.pay_amount];
	size=[IHUtility GetSizeByText:str sizeOfFont:12 width:(_imageView.width-10)/2-10];
	
	
	NSString *time=[NSString stringWithFormat:@"%.1f",model.pay_amount] ;
	
	NSMutableAttributedString * attributedText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"付款%@元",time] attributes:@{NSFontAttributeName:sysFont(12)}];
	
	[attributedText addAttribute:NSForegroundColorAttributeName value:RGB(232, 121, 117) range:NSMakeRange(2,time.length+1)];
	
	
	
	_priceLbl.attributedText=attributedText;
	_priceLbl.frame=CGRectMake(_namelbl.right+10, _namelbl.top, _imageView.width-(_namelbl.right+15), 12);
	_priceLbl.textAlignment=NSTextAlignmentRight;
	
	size=[IHUtility GetSizeByText:model.message sizeOfFont:12 width:_imageView.width-0.08*WindowWith-10];
	
	_messageLbl.text=model.message;
	
	_messageLbl.size=CGSizeMake(size.width, size.height);
	
	
	size=[IHUtility GetSizeByText:[IHUtility compareCurrentTimeString:model.create_time] sizeOfFont:10 width:_imageView.width];
	
	_timeLbl.text=[IHUtility compareCurrentTimeString:model.create_time];
	
	_timeLbl.frame=CGRectMake(0.04*WindowWith, _messageLbl.bottom+0.0266*WindowWith, size.width, 10);
	
	
	_imageView.size=CGSizeMake( 0.728*WindowWith, _timeLbl.bottom+10);
	
	
}

@end




