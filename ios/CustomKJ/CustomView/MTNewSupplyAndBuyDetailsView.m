//
//  MTNewSupplyAndBuyDetailsView.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/7/20.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTNewSupplyAndBuyDetailsView.h"

@implementation MTNewSupplyAndBuyDetailsView


- (instancetype)initWithFrame:(CGRect)frame
{
	
	self=[super initWithFrame:frame];
	if (self) {
		
		self.backgroundColor = [UIColor whiteColor];
		UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith-10,1)];
		lineView1.backgroundColor = cLineColor;
		[self addSubview:lineView1];
		
		
		UIAsyncImageView *headImageView = [[UIAsyncImageView alloc]initWithFrame:CGRectMake(15, 0.032*WindowWith+1, 0.106*WindowWith, 0.106*WindowWith)];
		_headImageView = headImageView;
		[ headImageView setLayerMasksCornerRadius:0.106*WindowWith/2 BorderWidth:0 borderColor:[UIColor whiteColor]];
		headImageView.image=defalutHeadImage;
		[self addSubview:headImageView];
		headImageView.userInteractionEnabled=YES;
		
		UITapGestureRecognizer *mapTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getaddressTomap:)];
		[headImageView addGestureRecognizer:mapTap];
		
		_VipImageView = [[UIAsyncImageView alloc]initWithFrame:CGRectMake(_headImageView.right - kWidth(13), _headImageView.bottom - kWidth(13), kWidth(16), kWidth(16))];
		_VipImageView.image = kImage(@"gongqiu_vip");
		_VipImageView.hidden = YES;
		[self addSubview:_VipImageView];
		
		//		UIAsyncImageView *gongqiuImgView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(iPhoneWidth - kWidth(50), kWidth(13), kWidth(40), kWidth(23))];
		//		_gongqiuTypeImgView = gongqiuImgView;
		//		[self addSubview:gongqiuImgView];
		//
		
		SMLabel *lbl = [[SMLabel alloc]initWithFrameWith:CGRectMake(headImageView.right+7.5/375*WindowWith, 17.5/375*WindowWith+1, 40, 13) textColor:cBlackColor textFont:sysFont(12.5)];
		//		lbl.text = @"刘乐东";
		_nickName = lbl;
		[self addSubview:lbl];
		
		//身份 label
		lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.right+12/375*WindowWith, lbl.top, WindowWith-lbl.right-50, 13) textColor:cBlackColor textFont:sysFont(12.5) ];
		//		lbl.text=@"#苗途站长";
		_identLbl=lbl;
		[self addSubview:lbl];
		
		//
		lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(_nickName.left, lbl.bottom+5.5, WindowWith-lbl.left-50, 13) textColor:cGrayLightColor textFont:sysFont(12.5)];
		//		lbl.text=@"深圳 | 正河苗圃 总经理";
		_bqLbl=lbl;
		[self addSubview:lbl];
		
		//供应图片视图
		MTSupplyAndBuyDetailsImageView *imagesView=[[MTSupplyAndBuyDetailsImageView alloc]initWithFrame:CGRectMake(headImageView.left, _headImageView.bottom+13, WindowWith-headImageView.left*2, 400)];
		_imagesView = imagesView;
		[self addSubview:imagesView];
		
		//品种名称
		lbl = [[SMLabel alloc]initWithFrameWith:CGRectMake(headImageView.left, imagesView.bottom+0.08*WindowWith,  WindowWith-headImageView.left*2, 15) textColor:RGB(51.0f,51.0f, 51.0f) textFont:sysFont(15)];
		//		lbl.text = @"【供应】中国红樱花";
		_tilteLbl = lbl;
		[self addSubview:lbl];
		
		//单价
		lbl = [[SMLabel alloc]initWithFrameWith:CGRectMake(WindowWith-headImageView.left-80 , lbl.bottom, 60, 18) textColor:UIColor.redColor textFont:sysFont(18)];
//		lbl.text = @"￥ 320";
		_pricelbl=lbl;
		[self addSubview:lbl];
		
		//描述
		lbl = [[SMLabel alloc]initWithFrameWith:CGRectMake(headImageView.left , lbl.bottom+7.5, WindowWith-headImageView.left-10, 40) textColor:cGrayLightColor textFont:sysFont(13.5)];
		_ganjingLbl = lbl;
		lbl.text=@"#杆径30-35cm   #冠幅25-35cm  #高度120-150cm  #分枝点230cm";
		lbl.numberOfLines=0;
		[self addSubview:lbl];
		
		
		UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(0, lbl.bottom+11,WindowWith,0)];
		
		_lineView1 = lineView3;
		lineView3.backgroundColor = cLineColor;
		[self addSubview:lineView3];
		
		UIImage *Img = Image(@"GongQiu_yaoqiu.png");
		UIImageView  *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(lbl.left, lineView3.bottom+5, Img.size.width, Img.size.height)];
		imageView.image = Img;
		[self addSubview:imageView];
		
		_tedianImageView = imageView;
		imageView.hidden = YES;
		
		
		lbl = [[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+5 , imageView.top, WindowWith-imageView.right-20, 40) textColor:cBlackColor textFont:sysFont(13.5)];
		_tedianLbl = lbl;
//		lbl.text = @"";
		lbl.numberOfLines = 0;
		[self addSubview:lbl];
		
		
		
		
		Img=Image(@"GongQiu_adress.png");
		imageView=[[UIImageView alloc]initWithFrame:CGRectMake(imageView.left, lbl.bottom+9.5, Img.size.width, Img.size.height)];
		imageView.image=Img;
		_adressImageView=imageView;
		imageView.hidden=YES;
		[self addSubview:imageView];
		lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+5 , imageView.top, WindowWith-imageView.right-20, 14) textColor:cBlackColor textFont:sysFont(13.5)];
		lbl.text=@"";
		_adressLbl=lbl;
		[self addSubview:lbl];
		
		
		Img=Image(@"GongQiu_miaoAdress.png");
		imageView=[[UIImageView alloc]initWithFrame:CGRectMake(imageView.left, lbl.bottom+9.5, Img.size.width, Img.size.height)];
		imageView.image=Img;
		_logisticsImageView=imageView;
		[self addSubview:imageView];
		imageView.hidden=YES;
		lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+5 , imageView.top, WindowWith-imageView.right-20, 14) textColor:cBlackColor textFont:sysFont(13.5)];
		lbl.text=@"";
		_logisticsLbl=lbl;
		[self addSubview:lbl];
		
		
		UIView *lineView4 =[[UIView alloc]initWithFrame:CGRectMake(0, lbl.bottom+11, WindowWith, 1)];
		lineView4.backgroundColor=cLineColor;
		_lineView2 = lineView4;
		[self addSubview:lineView4];
		
		
		lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(headImageView.left,lineView4.bottom+7, 60, 13) textColor:cGrayLightColor textFont:sysFont(12.5)];
		lbl.text=@"7月20日";
		_timeLbl=lbl;
		[self addSubview:lbl];
		
	}
	
	return self;
}


-(void)getaddressTomap:(UITapGestureRecognizer *)tap{
	
	self.selectBtnBlock(SelectheadImageBlock);
}


-(CGFloat)setDataWithmodel:(MTSupplyAndBuyListModel *)model{
	
	NSRange range3 = [model.userChildrenInfo.heed_image_url rangeOfString:ConfigManager.ImageUrl];
	
	if (range3.location==NSNotFound) {
		[_headImageView setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@%@",ConfigManager.ImageUrl,model.userChildrenInfo.heed_image_url,smallHeaderImage] placeholderImage:defalutHeadImage];
		
	}else
	{
		[_headImageView setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@",model.userChildrenInfo.heed_image_url,smallHeaderImage] placeholderImage:defalutHeadImage];
		
	}
	
	
	CGSize size=[IHUtility GetSizeByText:model.userChildrenInfo.nickname sizeOfFont:13 width:150];
	_nickName.text=model.userChildrenInfo.nickname;
	_nickName.size=CGSizeMake(size.width, 15);
	
	if ([model.userChildrenInfo.isVip isEqualToString:@"1"]) {
		_nickName.textColor = kColor(@"#F25900");
		_VipImageView.hidden = NO;
	}else {
		_VipImageView.hidden = YES;
		_nickName.textColor = cBlackColor;
	}
	
	size=[IHUtility GetSizeByText:model.userChildrenInfo.title sizeOfFont:13 width:150];
	_identLbl.text=model.userChildrenInfo.title;
	_identLbl.frame=CGRectMake(_nickName.right+12/375*WindowWith, _nickName.top, size.width, 13);
	
	NSMutableString *str=[[NSMutableString alloc]init];
	BOOL province=NO;
	if (![model.userChildrenInfo.province isEqualToString:@""]) {
		[str appendString:model.userChildrenInfo.province];
		province=YES;
	}
	if (![model.userChildrenInfo.position isEqualToString:@""] || ![model.userChildrenInfo.company_name isEqualToString:@""]) {
		if (province) {
			if ([model.userChildrenInfo.position isEqualToString:@"(null)"]) {
				[str appendString:[NSString stringWithFormat:@" | %@",model.userChildrenInfo.company_name]];
			}else{
				[str appendString:[NSString stringWithFormat:@" | %@ %@",model.userChildrenInfo.company_name,model.userChildrenInfo.position]];
			}
			
		}else{
			
			if ([model.userChildrenInfo.position isEqualToString:@"(null)"]){
				[str appendString:[NSString stringWithFormat:@" %@",model.userChildrenInfo.company_name]];
			}else{
				[str appendString:[NSString stringWithFormat:@"%@ %@",model.userChildrenInfo.company_name,model.userChildrenInfo.position]];
			}
			
			
		}
		
		
	}
	
	size=[IHUtility GetSizeByText:str sizeOfFont:13 width:WindowWith-_headImageView.right-20];
	_bqLbl.size=CGSizeMake(size.width, 13);
	_bqLbl.text=str;
	
	
	// CGFloat hight=0;
	if (model.supply_id){
		
		NSArray *arr=[network getJsonForString:model.supply_url];
		
		CGFloat imageHight=_bqLbl.bottom+15;
		//        if (_adressImageView.hidden) {
		//            imageHight=_adressImageView.top;
		//        }
		NSMutableArray *imgArr=[[NSMutableArray alloc]init];
		
		//        CGFloat imagesHight=0;
		for (NSDictionary *dic2 in arr) {
			MTPhotosModel *mod=[[MTPhotosModel alloc]initWithDic:dic2];
			[imgArr addObject:mod];
			//
			//            UIAsyncImageView *imageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(_headImageView.left, imageHight+10, WindowWith-_headImageView.left*2, (WindowWith-_headImageView.left*2)*(mod.imgHeigh/mod.imgWidth))];
			//            imageHight=imageView.bottom;
			//            imagesHight=imageHight+10+imagesHight;
			//            [imageView setImageAsyncWithURL:mod.imgUrl placeholderImage:DefaultImage_logo];
			//            [self addSubview:imageView];
			//
		}
		//        hight=imageHight;
		
		[_imagesView setData:imgArr];
		_imagesView.frame=CGRectMake(_headImageView.left, imageHight, WindowWith-_headImageView.left*2, [_imagesView returnImagesHightWithArr:imgArr]);
		
		_lineView1.origin=CGPointMake(0, _imagesView.bottom+11);
		if (arr.count == 0) {
			_lineView1.hidden = YES;
		}
		
	}else if (model.want_buy_id){
		
		NSArray *arr=[network getJsonForString:model.want_buy_url];
		//  NSMutableArray *imgArr=[[NSMutableArray alloc]initWithCapacity:arr.count];
		CGFloat imageHight=_bqLbl.bottom+15;
		//        if (_logisticsImageView.hidden) {
		//            imageHight=_logisticsLbl.top;
		//        }
		NSMutableArray *imgArr=[[NSMutableArray alloc]init];
		
		//        CGFloat imagesHight=0;
		for (NSDictionary *dic2 in arr) {
			MTPhotosModel *mod=[[MTPhotosModel alloc]initWithDic:dic2];
			[imgArr addObject:mod];
			//
			//            UIAsyncImageView *imageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(_headImageView.left, imageHight+10, WindowWith-_headImageView.left*2, (WindowWith-_headImageView.left*2)*(mod.imgHeigh/mod.imgWidth))];
			//            imageHight=imageView.bottom;
			//            imagesHight=imageHight+10+imagesHight;
			//            [imageView setImageAsyncWithURL:mod.imgUrl placeholderImage:DefaultImage_logo];
			//            [self addSubview:imageView];
			//
		}
		//        hight=imageHight;
		
		[_imagesView setData:imgArr];
		_imagesView.frame=CGRectMake(_headImageView.left, imageHight, WindowWith-_headImageView.left*2, [_imagesView returnImagesHightWithArr:imgArr]);
		
		_lineView1.origin=CGPointMake(0, _imagesView.bottom+11);
		if (arr.count == 0) {
			_lineView1.hidden = YES;
		}
		
	}
	
	
	if (model.supply_id) {
		NSString *s = [NSString stringWithFormat:@"  %@",model.varieties];
		size = [IHUtility GetSizeByText:s sizeOfFont:15 width:WindowWith/2-_headImageView.left];
		_tilteLbl.text = s;
		_tilteLbl.size = CGSizeMake(size.width, 15);
		//		_gongqiuTypeImgView.image = Image(@"GongQiu_gongying");
	} else if (model.want_buy_id) {
		NSString *s = [NSString stringWithFormat:@"  %@",model.varieties];
		size = [IHUtility GetSizeByText:s sizeOfFont:15 width:WindowWith/2-_headImageView.left];
		_tilteLbl.text = s;
		_tilteLbl.size = CGSizeMake(size.width, 15);
		//		_gongqiuTypeImgView.image = Image(@"GongQiu_qiugou");
		_pricelbl.hidden=YES;
	}
	
	if (_imagesView.size.height <= 0) {
		_tilteLbl.frame = CGRectMake(_headImageView.left - 5, _lineView1.bottom, WindowWith-_headImageView.left, 18);
	}else {
		_tilteLbl.frame = CGRectMake(_headImageView.left - 5, _lineView1.bottom+5, WindowWith-_headImageView.left, 18);
	}
	
	
	NSString *s = [NSString stringWithFormat:@"￥%@",model.unit_price];
	size = [IHUtility GetSizeByText:s sizeOfFont:18 width:WindowWith/2-_headImageView.left];
	_pricelbl.text = s;
	_pricelbl.frame = CGRectMake(_headImageView.left, _tilteLbl.bottom + 3, WindowWith-_headImageView.left, 18);
	_pricelbl.textAlignment = NSTextAlignmentLeft;
	
	NSMutableArray *bqArray = [self getLabelViewList:model.rod_diameter
									   crown_width_s:model.crown_width_s
									   crown_width_e:model.crown_width_e
											height_s:model.height_s
											height_e:model.height_e
										branch_point:model.branch_point
											  number:[model.number integerValue] ];
	str=[[NSMutableString alloc]init];
	for (NSString *obj in bqArray) {
		[str appendString:[NSString stringWithFormat:@"%@   ",obj]];
	}
	_ganjingLbl.text=str;
	_ganjingLbl.numberOfLines=0;
	
	size=[IHUtility GetSizeByText:str sizeOfFont:14 width:WindowWith-_headImageView.left*2];
	//    _ganjingLbl.size=CGSizeMake(size.width, size.height);
	
	if (model.unit_price == nil) {
		_ganjingLbl.frame=CGRectMake(_pricelbl.left + 5, _pricelbl.top+5, size.width, size.height);
	}else {
		_ganjingLbl.frame=CGRectMake(_pricelbl.left + 5, _pricelbl.bottom+5, size.width, size.height);
	}
	
	
	_lineView2.origin=CGPointMake(0, _ganjingLbl.bottom+11);
	
	
	if (![model.selling_point isEqualToString:@""]) {
		_tedianImageView.hidden=NO;
		_tedianImageView.origin=CGPointMake(_headImageView.left, _lineView2.bottom+5);
		NSString *str = model.selling_point;
		NSString *temStr = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
		size=[IHUtility GetSizeByText:temStr sizeOfFont:14 width:_tedianLbl.size.width];
		_tedianLbl.numberOfLines=0;
		_tedianLbl.font = sysFont(13.7);
		
		NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:temStr];
		_tedianLbl.attributedText = attString;
		
		_tedianLbl.frame=CGRectMake(_tedianImageView.right+5, _lineView2.bottom+3, size.width, size.height);
		_tedianLbl.verticalAlignment = VerticalAlignmentMiddle;
		_tedianImageView.centerY = _tedianLbl.centerY;
		
	}else{
		_tedianImageView.origin=CGPointMake(_headImageView.left,  _lineView2.bottom+3);
		_tedianLbl.frame=CGRectMake(_tedianImageView.right+5, _lineView2.bottom, size.width, 0);
	}
	
	if (model.mining_area && ![model.mining_area isEqualToString:@""]) {
		
		_adressImageView.hidden=NO;
		_adressImageView.origin=CGPointMake(_headImageView.left, _tedianLbl.bottom+3);
		//        if (_tedianImageView.hidden) {
		//           _adressImageView.origin=CGPointMake(_headImageView.left, _lineView2.bottom+5);
		//        }
		
		size=[IHUtility GetSizeByText:model.mining_area sizeOfFont:14 width:WindowWith-_headImageView.left-_adressImageView.right-5];
		_adressLbl.numberOfLines=0;
		_adressLbl.text=model.mining_area;
		
		_adressLbl.frame=CGRectMake(_adressImageView.right+5, _tedianLbl.bottom+3, size.width, size.height);
		
	}else{
		if (_tedianImageView.hidden) {
			_adressImageView.origin=CGPointMake(_headImageView.left, _tedianLbl.top+5);
			_adressLbl.frame=CGRectMake(_adressImageView.right+5, _tedianLbl.top+5, size.width, 0);
		}else{
			_adressImageView.origin=CGPointMake(_headImageView.left, _tedianLbl.bottom+3);
		}
	}
	
	
	if (model.seedling_source_address && ![model.seedling_source_address isEqualToString:@""]) {
		_adressImageView.hidden=NO;
		_adressImageView.origin=CGPointMake(_headImageView.left, _tedianLbl.bottom+3);
		//        if (_tedianImageView.hidden) {
		//            _adressImageView.origin=CGPointMake(_headImageView.left, _tedianImageView.top);
		//        }else {
		size=[IHUtility GetSizeByText:model.seedling_source_address sizeOfFont:14 width:WindowWith-_headImageView.left-_adressImageView.right-5];
		_adressLbl.numberOfLines=0;
		_adressLbl.text=model.seedling_source_address;
		_adressLbl.frame=CGRectMake(_adressImageView.right+5, _tedianLbl.bottom + 3, size.width, size.height);
		//        }
	}else{
		if (_tedianImageView.hidden) {
			_adressImageView.origin=CGPointMake(_headImageView.left, _tedianLbl.top);
			_adressLbl.frame=CGRectMake(_adressImageView.right+5, _tedianLbl.top, size.width, size.height);
		}else {
			_adressImageView.origin=CGPointMake(_headImageView.left, _tedianLbl.bottom+3);
		}
	}
	
	
	if (model.use_mining_area && ![model.use_mining_area isEqualToString:@""]) {
		_logisticsImageView.hidden = NO;
		_logisticsImageView.origin = CGPointMake(_headImageView.left, _adressLbl.bottom+8);
		if (_adressImageView.hidden) {
			_logisticsImageView.origin = CGPointMake(_headImageView.left, _adressImageView.top);
		}else {
			size = [IHUtility GetSizeByText:model.use_mining_area sizeOfFont:14 width:WindowWith-_headImageView.left-_logisticsImageView.right-5];
			_logisticsLbl.numberOfLines=0;
			_logisticsLbl.text=model.use_mining_area;
			
			_logisticsLbl.frame=CGRectMake(_logisticsImageView.right+5, _adressLbl.bottom+8, size.width, size.height);
		}
		
	}else{
		if (_adressImageView.hidden) {
			_logisticsImageView.origin=CGPointMake(_headImageView.left, _adressImageView.top);
			_logisticsLbl.frame=CGRectMake(_logisticsImageView.right+5,_adressImageView.top, size.width, 0);
		}else {
			_logisticsLbl.frame=CGRectMake(_logisticsImageView.right+5,_adressImageView.bottom, size.width, 0);
		}
		
	}
	
	//    if (_tedianImageView.hidden && _adressImageView.hidden && _logisticsImageView.hidden) {
	//        _lineView2.hidden=YES;
	//    }
	_tedianImageView.top = _tedianLbl.top +2;
	_adressImageView.top = _adressLbl.top +2;
	_logisticsImageView.top = _logisticsLbl.top +2;
	
	s=[IHUtility compareCurrentTimeString:model.uploadtime];
	
	size=[IHUtility GetSizeByText:s sizeOfFont:13 width:WindowWith-_headImageView.left*2];
	
	
	//    _timeLbl.text=s;
	
	//    _timeLbl.frame=CGRectMake(_headImageView.left, _logisticsLbl.bottom+7, size.width, 13);
	//    return _timeLbl.bottom+7;
	_timeLbl.frame=CGRectMake(_headImageView.left, _logisticsLbl.bottom+7, size.width, 0);
	_lineView2.hidden = YES;
	return _logisticsLbl.bottom + 3;
	
}

-(NSMutableArray *)getLabelViewList:(CGFloat)rod_diameter
					  crown_width_s:(CGFloat)crown_width_s
					  crown_width_e:(CGFloat)crown_width_e
						   height_s:(CGFloat)height_s
						   height_e:(CGFloat)height_e
					   branch_point:(CGFloat)branch_point
							 number:(NSInteger)number
{
	NSMutableArray *arr=[[NSMutableArray alloc]init];
	
	if (number>0) {
		NSString *str=[NSString stringWithFormat:@"#数量%ld株",number];
		[arr addObject:str];
	}
	
	if (rod_diameter>0) {
		NSString *str=[NSString stringWithFormat:@"#杆径%.1fcm",rod_diameter];
		[arr addObject:str];
	}
	if (crown_width_s>0 && crown_width_e>0) {
		NSString *str=[NSString stringWithFormat:@"#冠幅%.1f-%.1fcm",crown_width_s,crown_width_e];
		[arr addObject:str];
	}else if (crown_width_s>0 || crown_width_e>0){
		if (crown_width_s>0) {
			NSString *str=[NSString stringWithFormat:@"#冠幅%.1fcm",crown_width_s];
			[arr addObject:str];
		}else{
			NSString *str=[NSString stringWithFormat:@"#冠幅%.1fcm",crown_width_e];
			[arr addObject:str];
		}
		
	}
	
	if (height_s>0 && height_e>0) {
		NSString *str=[NSString stringWithFormat:@"#高度%.1f-%.1fcm",height_s,height_e];
		[arr addObject:str];
	}else if (height_s>0 || height_e>0){
		if (height_s>0) {
			NSString *str=[NSString stringWithFormat:@"#高度%.1fcm",height_s];
			[arr addObject:str];
		}else{
			NSString *str=[NSString stringWithFormat:@"#高度%.1fcm",height_e];
			[arr addObject:str];
		}
		
	}
	
	
	if (branch_point>0) {
		NSString *str=[NSString stringWithFormat:@"#分枝点%.1fcm",branch_point];
		[arr addObject:str];
	}
	return arr;
}

@end



