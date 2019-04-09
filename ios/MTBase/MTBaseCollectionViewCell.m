//
//  MTBaseCollectionViewCell.m
//  MiaoTuProject
//
//  Created by Mac on 16/3/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTBaseCollectionViewCell.h"

@implementation MTBaseCollectionViewCell

@end

@implementation CreateBSCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.m_imgView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self.contentView addSubview:self.m_imgView];
        
        self.deleteBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        UIImage *img=Image(@"fb_close.png");
        self.deleteBtn.frame=CGRectMake(0, 0, img.size.width, img.size.height);
        [self.deleteBtn setBackgroundImage:img forState:UIControlStateNormal];
        [self.contentView addSubview:self.deleteBtn];
 
        
    }
    return self;
}

@end


@implementation ConnectionsCollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor = cGreenColor;
    }
    return self;
}

@end


@implementation ActivityVoteCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self= [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = kWidth(5);
        self.clipsToBounds = YES;
//        UIAsyncImageView *heardImg = [[UIAsyncImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, kWidth(113))];
        UIAsyncImageView *heardImg = [[UIAsyncImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.width)];
        heardImg.image = defalutHeadImage;
        _heardImg = heardImg;
        [self addSubview:heardImg];
        
        _nameLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(kWidth(15), heardImg.bottom , self.width - kWidth(30), kWidth(42)) textColor:kColor(@"#272727") textFont:sysFont(font(13))];
        _nameLbl.text = @"广东省广州市四季春~";
        _nameLbl.numberOfLines = 2;
        [self addSubview:_nameLbl];
        
        _infoLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(_nameLbl.left, _nameLbl.bottom , _nameLbl.width, kWidth(34)) textColor:kColor(@"#818181") textFont:sysFont(font(12))];
        _infoLbl.text = @"#003号 #长沙  #丰庆园林";
        _infoLbl.numberOfLines = 2;
        [self addSubview:_infoLbl];
        
        _voteNumLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(_nameLbl.left, _infoLbl.bottom + kWidth(2), _nameLbl.width, kWidth(16)) textColor:kColor(@"#FE0000") textFont:sysFont(14)];
        _voteNumLbl.text = @"221票";
        [self addSubview:_voteNumLbl];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, _voteNumLbl.bottom + kWidth(10), _nameLbl.width, kWidth(30))];
        [button setTitle:@"给TA投票" forState:UIControlStateNormal];
        [button setTitleColor:kColor(@"#00B7AA") forState:UIControlStateNormal];
        button.titleLabel.font = sysFont(font(13));
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.layer.cornerRadius = button.height/2;
        [button addTarget:self action:@selector(voteBtn:) forControlEvents:UIControlEventTouchUpInside];
        button.centerX = self.width/2.0;
        button.layer.borderWidth = 1.;
        button.layer.borderColor = kColor(@"#00B7AA").CGColor;
        [self addSubview:button];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, button.bottom + kWidth(10), self.width , 1)];
        lineView.backgroundColor = kColor(@"#F3F2F8");
        [self addSubview:lineView];
        
        _contentLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(_nameLbl.left, lineView.bottom + kWidth(2), _nameLbl.width, self.height -lineView.bottom - kWidth(4)) textColor:kColor(@"#818181") textFont:sysFont(font(12))];
        _contentLbl.text = @"想说：我不在找苗就是在找苗的路上。";
        _contentLbl.numberOfLines = 0;
        [self addSubview:_contentLbl];
        
    }
    
    return self;
}

- (void)voteBtn:(UIButton *)button
{
    self.selectBtnBlock(SelectBtnBlock);

}

- (void)setCollectionViewData:(VoteListModel *)model
{
    [_heardImg setImageAsyncWithURL:model.head_image placeholderImage:defalutHeadImage];
    _nameLbl.text = model.name;
    _voteNumLbl.text = [NSString stringWithFormat:@"%ld票",(long)model.vote_num];
    _infoLbl.text = [NSString stringWithFormat:@"#%@号 #%@  #%@",model.project_code,model.city,model.company_info];
    _contentLbl.text = [NSString stringWithFormat:@"想说:%@",model.talk];
}
@end

@implementation EPCloudCompanyCollectionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dianji)];
        [self addGestureRecognizer:tap];
        
        UIAsyncImageView *companyImg = [[UIAsyncImageView alloc] init];
        companyImg.frame = CGRectMake(0, 0, (WindowWith -60*(WindowWith/375.0))/2.0, 99.5*(WindowWith/375.0));
        companyImg.image = DefaultImage_logo;
       // companyImg.layer.cornerRadius = 2.5;
        _companyImg = companyImg;
        [self addSubview:companyImg];
        
        SMLabel *namelbl = [SMLabel new];
        namelbl.font = sysFont(12);
        namelbl.textColor = cBlackColor;
        namelbl.text = @"一片云两篇云";
        namelbl.textAlignment = NSTextAlignmentCenter;
        _nameLbl = namelbl;
        [self addSubview:namelbl];
        
        namelbl.sd_layout.topSpaceToView(companyImg,6).leftSpaceToView(self , 0).widthIs(self.width).heightIs(16);
        
        [self setupAutoHeightWithBottomView:namelbl bottomMargin:8];
        }
    return self;
    
}

-(void)dianji{
    self.selectBlock(SelectBtnBlock);
}

//企业云加载数据
- (void)setCollectionViewCompanyData:(EPCloudListModel *)model
{
    //加载头像
   
    if (model.imageArr.count > 0) {
        MTPhotosModel *mod  = model.imageArr[0];
        [_companyImg setImageAsyncWithURL:mod.imgUrl placeholderImage:DefaultImage_logo];
    }else {
        _companyImg.image = DefaultImage_logo;
    }

    _nameLbl.text = model.company_name;
    
}
@end

@implementation EPCloudConnectionCollectionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dianji)];
        [self addGestureRecognizer:tap];

        UIAsyncImageView *companyImg = [[UIAsyncImageView alloc] init];
        companyImg.frame = CGRectMake(10, 8, (WindowWith -100*(WindowWith/375.0) - 30)/3.0 - 20, (WindowWith -100*(WindowWith/375.0) - 30)/3.0 - 20);
        companyImg.image = defalutHeadImage;
       // companyImg.layer.cornerRadius = companyImg.width/2.0;
        _companyImg = companyImg;
        [self addSubview:companyImg];
        
        UIImageView *bgImageView=[[UIImageView alloc]initWithFrame:CGRectMake(companyImg.left, companyImg.top, companyImg.width, companyImg.height)];
        bgImageView.image=Image(@"Person_bg.png");
        [self addSubview:bgImageView];
        
        SMLabel *namelbl = [SMLabel new];
        namelbl.font = sysFont(12);
        namelbl.textColor = cBlackColor;
        namelbl.text = @"一片云两篇云";
        namelbl.textAlignment = NSTextAlignmentCenter;
        _nameLbl = namelbl;
        [self addSubview:namelbl];
        
        namelbl.sd_layout.topSpaceToView(companyImg,6).leftSpaceToView(self , 0).widthIs(self.width).heightIs(16);
//        [self setupAutoHeightWithBottomView:namelbl bottomMargin:32];
    }
    return self;
}

-(void)dianji{
    self.selectBlock(SelectBtnBlock);
}
//人脉云加载数据
- (void)setCollectionViewConnectionData:(MTConnectionModel *)model
{
    [_companyImg setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@%@",ConfigManager.ImageUrl,model.heed_image_url,smallHeaderImage] placeholderImage:defalutHeadImage];
    _nameLbl.text=model.nickname;
}

@end





@implementation ECloudMiaoMuYunCollectionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
    
        CGFloat w=WindowWith/4-0.5;
        UIImage *img=Image(@"cs_xz.png");
        UIAsyncImageView *imgView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(w/2-kWidth(54)/2, (w-kWidth(54))/4-5, kWidth(54), kWidth(54))];
        imgView.image=img;
        [self addSubview:imgView];
        self.imgView=imgView;
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, imgView.bottom,w,w-imgView.bottom) textColor:[IHUtility colorWithHexString:@"#333333"] textFont:sysFont(14)];
 
        lbl.textAlignment=NSTextAlignmentCenter;
        [self addSubview:lbl];
        self.titleLab=lbl;
   
    }
    return self;
}


@end


@implementation CloudMiaoMuYunHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
         self.backgroundColor =[UIColor whiteColor];
        
        
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 9)];
        lineView.backgroundColor=cBgColor;
        [self addSubview:lineView];
        
        UIImage *img=Image(@"ep_header.png");
        UIAsyncImageView *imgView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(12, 17, img.size.width, img.size.height)];
        imgView.image=img;
        [self addSubview:imgView];
        
        self.imgView=imgView;
        
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imgView.right+5, 9, WindowWith, 32) textColor:cBlackColor textFont:sysFont(13)];
        lbl.text=@"灌木";
        
        [self addSubview:lbl];
        self.titleLab=lbl;
        
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(WindowWith-100, 9, 100, 32);
        [btn setTitle:@"更多" forState:UIControlStateNormal];
        [btn setTitleColor:cGrayLightColor forState:UIControlStateNormal];
        btn.titleLabel.font=sysFont(12);
        self.btn=btn;
        [btn addTarget:self action:@selector(dianji) forControlEvents:UIControlEventTouchUpInside];
        btn.hidden=YES;
        [self addSubview:btn];
        
        img=Image(@"GQ_Left.png");
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(btn.right-img.size.width-20, 0, img.size.width, img.size.height)];
        imageView.image=img;
        self.imageView=imageView;
        imageView.centerY=imgView.centerY;
        [self addSubview:imageView];
        
        lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 40, WindowWith, 1)];
        lineView.backgroundColor=cBgColor;
        [self addSubview:lineView];
        
        
    }
    return self;
}

-(void)dianji{
    self.selectBlock(self.tag);
}

@end


@implementation WeatherCityCollectionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.borderColor = RGBA(203, 203, 203,0.7).CGColor;
        self.layer.borderWidth = 1;
        self.layer.cornerRadius = 3;
        UIButton *addBtn = [[UIButton alloc] initWithFrame:self.bounds];
        [addBtn setImage:Image(@"weather_addCity.png") forState:UIControlStateNormal];
        addBtn.hidden= YES;
        _addBtn = addBtn;
        
        [self addSubview:addBtn];
        
        UIButton *delegteBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 23, 23)];
        [delegteBtn setImage:Image(@"weather_delegte.png") forState:UIControlStateNormal];
        delegteBtn.right = self.width;
        delegteBtn.hidden = YES;
        self.delegteBtn= delegteBtn;
        [self addSubview:delegteBtn];
        
        SMLabel *cityLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(8, 15, self.width - 16, 15) textColor:[UIColor whiteColor] textFont:boldFont(16)];
        cityLbl.textAlignment = NSTextAlignmentCenter;
        
        _cityLbl = cityLbl;
        [self addSubview:cityLbl];
        
        UIAsyncImageView *weatherImg = [[UIAsyncImageView alloc] initWithFrame:CGRectMake(0, cityLbl.bottom + 20, 47, 47)];
        weatherImg.right = self.width/2.0;
        _weatherImg = weatherImg;
        
        [self addSubview:weatherImg];
    
        SMLabel *highLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(self.width/2.0 +8, weatherImg.top + 5, self.width/2.0 - 16, 15) textColor:[UIColor whiteColor] textFont:sysFont(15)];
        
        _highLbl = highLbl;
        [self addSubview:highLbl];
        
        SMLabel *downLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(self.width/2.0 +8, 0, self.width/2.0 - 16, 15) textColor:[UIColor whiteColor] textFont:sysFont(15)];

        downLbl.bottom = weatherImg.bottom - 5;
        _downLbl = downLbl;
        [self addSubview:downLbl];
        
        SMLabel *weatherLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(8, weatherImg.bottom + 20, self.width - 16, 15) textColor:[UIColor whiteColor] textFont:sysFont(15)];
        weatherLbl.textAlignment = NSTextAlignmentCenter;
        _weatherLbl = weatherLbl;
        [self addSubview:weatherLbl];
    
        
    }
    
    return self;
}


- (void)setWeatherData:(NSDictionary *)dic
{
    if (dic) {
        _cityLbl.text = dic[@"meta"][@"city"];
        
        //天气图片
        NSArray *tampArr = dic[@"forecast15"];
        NSDictionary *todayDic = tampArr[1];
        NSDictionary *dayDic;
        if ([IHUtility isWhetherDayOrNightWithNow]) {
            dayDic= todayDic[@"day"];
        }else{
            dayDic= todayDic[@"night"];
        }
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
        
        
        _highLbl.text = [NSString stringWithFormat:@"%@ ℃",todayDic[@"high"]];
        
        _downLbl.text = [NSString stringWithFormat:@"%@℃",todayDic[@"low"]];
        _weatherLbl.text = dayDic[@"wthr"];

    }else{
        _weatherImg.image = nil;
        _cityLbl.text = @"";
        _highLbl.text = @"";
        _downLbl.text = @"";
        _weatherLbl.text = @"";
    }
}
@end







