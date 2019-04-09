//
//  CustomView+CustomCategory4.m
//  MiaoTuProject
//
//  Created by 徐斌 on 2016/11/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "CustomView+CustomCategory4.h"
//#import "AdView.h"
//#import "Masonry.h"

#import "HeadBannerView.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)


@implementation CustomView (CustomCategory4)


@end


/**天气view*/
@implementation WeatherView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];

    if (self) {
        
        WS(weakSelf);
    
        UIImageView *weatherImageView = [[UIImageView alloc]init];
        _weatherImageView = weatherImageView;
        weatherImageView.image = Image(@"oneday_now_weather_mostlycloudy.png");
        [self addSubview:weatherImageView];
        //添加约束
        [weatherImageView mas_makeConstraints:^(MASConstraintMaker *make) {

            make.left.equalTo(weakSelf.mas_left).offset(12);
            make.height.equalTo(@45);
            make.width.equalTo(@45);
            make.centerY.equalTo(weakSelf.mas_centerY);
            
        }];

        //时间
//        SMLabel *timeLab = [[SMLabel alloc]initWithFrameWith:CGRectMake(weatherImageView.right+7, 7.5, 41, 15) textColor:cGrayLightColor textFont:sysFont(14)];
        SMLabel *timeLab = [[SMLabel alloc] init];
        timeLab.textColor = cGrayLightColor;
        timeLab.text = @"11/10";
        timeLab.font = sysFont(14);
        _timeLbl = timeLab;
        [self addSubview:timeLab];
        //添加约束
        [timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(weatherImageView.mas_right).offset(7);
            make.top.equalTo(weatherImageView.mas_top).offset(5);
        }];
        
//        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.left, lbl.bottom+3, 32, 20) textColor:cGrayLightColor textFont:sysFont(14)];
        //天气描述
        SMLabel *weatherLab = [[SMLabel alloc] init];
        weatherLab.text = @"多云";
        _weatherLbl = weatherLab;
//        weatherLab.backgroundColor = [UIColor redColor];

        weatherLab.textColor = cGrayLightColor;
        weatherLab.font = sysFont(14);
        [self addSubview:weatherLab];
        //添加约束
        [weatherLab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(timeLab.mas_left);
            make.top.equalTo(timeLab.mas_bottom).offset(1);
        }];

        //城市图片
        UIImageView *cityImg = [[UIImageView alloc]init];
        cityImg.image = Image(@"oneday_icon_location@3x.png");
        [self addSubview:cityImg];
        //添加约束
        [cityImg mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(timeLab.mas_right).offset(10);
            make.centerY.equalTo(timeLab.mas_centerY);
            make.height.equalTo(@11);
            make.width.equalTo(@8);

        }];

        //城市
//        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(cityImg.right+5, 7.5, 60, 20) textColor:cGrayLightColor textFont:sysFont(14)];
        SMLabel *cityLab = [[SMLabel alloc] init];
        cityLab.textColor = cGrayLightColor;
        cityLab.font = sysFont(14);
        cityLab.text=@"长沙";
        _adressLbl = cityLab;
        [self addSubview:cityLab];
        //添加约束
        [cityLab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(cityImg.mas_right).offset(5);
            make.centerY.equalTo(cityImg.mas_centerY);
         }];
        
        //空气质量
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.frame=CGRectMake(cityImg.left, lbl.bottom+2, 50, 15);
        [btn setImage:[Image(@"weather_wendu.png") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
        [btn setTitle:@"43.优" forState:UIControlStateNormal];
        [btn setTitleColor:cBlackColor forState:UIControlStateNormal];
        btn.titleLabel.font = sysFont(10);
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 0);
        btn.backgroundColor = RGB(216, 216, 216);
        [btn setLayerMasksCornerRadius:7 BorderWidth:0 borderColor:cGreenColor];
        _btn=btn;
        [self addSubview:btn];
        //添加约束
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(cityImg.mas_left);
            make.top.equalTo(cityLab.mas_bottom).offset(2);
            make.height.equalTo(@15);
            make.width.equalTo(@50);

        }];

        
        //右方箭头
        UIImage *img = Image(@"iconfont-fanhui.png");
        
//        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(WindowWith-0.04*WindowWith-img.size.width, self.height/2-img.size.height/2, img.size.width, img.size.height)];
        UIImageView *imageView=[[UIImageView alloc]init];
        imageView.image = img;
        [self addSubview:imageView];
        //添加约束
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(weakSelf.mas_right).offset(-15);
            make.centerY.equalTo(weakSelf.mas_centerY);
            make.size.equalTo(CGSizeMake(img.size.width, img.size.height));
            
        }];
        //反转图片
        //1.view当前的当前状态
        CGAffineTransform tranform = imageView.transform;
        //2.创建一个平移,并且得到计算好的结果
        //tx, ty, 平移量
        CGAffineTransform translate = CGAffineTransformTranslate(tranform/*当前的状态*/, 0, 0);
        
        CGAffineTransform scale = CGAffineTransformScale(translate, 1, 1); //包含平移
        //2.创建一个旋转
        //旋转角度为弧度,顺时针为正数,逆时针为负数
        CGAffineTransform rotate = CGAffineTransformRotate(scale, -180 * M_PI / 180/*单位为弧度*/);//包含缩放
        imageView.transform = rotate;
        
        //温度
        SMLabel *temperatureLab = [[SMLabel alloc] init];
        temperatureLab.textColor = cGreenColor;
        temperatureLab.font = sysFont(25);
//        lbl = [[SMLabel alloc]initWithFrameWith:CGRectMake(0, 2, WindowWith-30, 35) textColor:cGreenColor textFont:sysFont(25)];
        temperatureLab.text=@"14°";
        _wenduLbl = temperatureLab;
        temperatureLab.textAlignment = NSTextAlignmentRight;
        [self addSubview:temperatureLab];
        //添加约束
        [temperatureLab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(imageView.mas_left).offset(-10);
            make.top.equalTo(weakSelf.mas_top).offset(2);
            
        }];

        //温度区间
        SMLabel *tempLab = [[SMLabel alloc] init];
//        tempLab.backgroundColor = [UIColor redColor];
        tempLab.textColor = cBlackColor;
        tempLab.font = sysFont(10);
//        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, imageView.bottom+3, WindowWith-35, 13) textColor:cBlackColor textFont:sysFont(10)];
        tempLab.text=@"14°/7°";
        tempLab.textAlignment = NSTextAlignmentRight;
        _wenduchaLbl = tempLab;
        [self addSubview:tempLab];
        //添加约束
        [tempLab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(imageView.mas_bottom).offset(1);
            make.centerX.equalTo(temperatureLab.mas_centerX).offset(-2);
            
        }];
    }
    
    return self;
}

-(void)setweatherDic:(NSDictionary *)obj cityID:(NSString *)cityID cityName:(NSString *)cityName{
    
    if ([cityID isEqualToString:@"101010100"]&&[cityName isEqualToString:@""]) {
        cityName=@"北京";
    }
    
    NSDictionary *dic;
    NSDictionary *Dic=[ConfigManager getWeatherImage];
    if ([IHUtility isWhetherDayOrNightWithNow]) {
        dic=obj[@"forecast"][1][@"day"];
      
        _weatherImageView.image=Image(Dic[@"暂无"][@"bigday"]);
        NSArray *arr=Dic.allKeys;
        for (NSString *key in arr) {
            if ([dic[@"wthr"] rangeOfString:key].location!=NSNotFound) {
                _weatherImageView.image=Image(Dic[key][@"bigday"]);
                continue;
            }
        }
        
    }else{
        dic=obj[@"forecast"][1][@"night"];
       
        
        NSArray *arr=Dic.allKeys;
        
        _weatherImageView.image=Image(Dic[@"暂无"][@"smallnight"]);
        
        for (NSString *key in arr) {
            if ([dic[@"wthr"] rangeOfString:key].location!=NSNotFound) {
                
                [_weatherImageView setImage:Image(Dic[key][@"bignight"])];
                NSLog(@"%@-%@-%@",key,dic[@"wthr"],Dic[key][@"bignight"]);
                continue;
            }
        }
    }
    
    NSString *str = [IHUtility getTimeStringFromString:obj[@"forecast"][1][@"date"] ];
     CGSize size=[IHUtility GetSizeByText:[IHUtility FormatMonthAndDayByString3:str] sizeOfFont:14 width:60];
     _timeLbl.size=CGSizeMake(size.width, 20);
    _timeLbl.text=[IHUtility FormatMonthAndDayByString3:str];
    _adressLbl.text=obj[@"meta"][@"city"];
    
    _weatherLbl.text=dic[@"wthr"];
   size=[IHUtility GetSizeByText:dic[@"wthr"] sizeOfFont:14 width:80];
   
    _weatherLbl.size=CGSizeMake(size.width, 20);
    //_kongqiLbl.text=[NSString stringWithFormat:@"%@.%@",obj[@"evn"][@"aqi"],obj[@"evn"][@"quality"]];
    
    size=[IHUtility GetSizeByText:[NSString stringWithFormat:@"%@.%@",obj[@"evn"][@"aqi"],obj[@"evn"][@"quality"]] sizeOfFont:10 width:100];
    [_btn setTitle:[NSString stringWithFormat:@"%@.%@",obj[@"evn"][@"aqi"],obj[@"evn"][@"quality"]] forState:UIControlStateNormal];
    
    //int aqi=[obj[@"evn"][@"aqi"] intValue];
//    if (aqi <=50 ) {
//        _kongqiLbl.backgroundColor=[IHUtility colorWithHexString:@"#00e43b"];
//    }else if (aqi >50 && aqi<=100 ){
//        _kongqiLbl.backgroundColor=[IHUtility colorWithHexString:@"#fffd46"];
//    }else if (aqi >101 && aqi<=150 ){
//        _kongqiLbl.backgroundColor=[IHUtility colorWithHexString:@"#ff7b24"];
//    }else if (aqi >150 && aqi<=200 ){
//        _kongqiLbl.backgroundColor=[IHUtility colorWithHexString:@"#ff0012"];
//    }else if (aqi >201 && aqi<301 ){
//        _kongqiLbl.backgroundColor=[IHUtility colorWithHexString:@"#9e004b"];
//    }else if (aqi >300 ){
//        _kongqiLbl.backgroundColor=[IHUtility colorWithHexString:@"#830022"];
//    }
    
    
    
//    if(aqi<=100 && aqi>50){
//        _kongqiLbl.textColor=[UIColor blackColor];
//    }else{
//        _kongqiLbl.textColor=[IHUtility colorWithHexString:@"#ffffff"];
//    }
    UIImage *img=Image(@"weather_wendu.png");
    
    
    _btn.size=CGSizeMake(size.width+img.size.width+10, 15);
    _wenduchaLbl.text=[NSString stringWithFormat:@"%@°/%@°",obj[@"forecast"][1][@"high"],obj[@"forecast"][1][@"low"]];
    
    _wenduLbl.text=[NSString stringWithFormat:@"%@°",obj[@"observe"][@"temp"]];
    size=[IHUtility GetSizeByText:[NSString stringWithFormat:@"%@°",obj[@"observe"][@"temp"]] sizeOfFont:27 width:60];
    
    if ([cityID isEqualToString:@"101010100"]&&![cityName isEqualToString:@"北京"]) {
        [IHUtility addSucessView:@"抱歉，当前城市没有数据" type:2];
    }
    
}

@end

@implementation seedCloudInfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        SMLabel *lbl = [SMLabel new];
        lbl.textColor = cBlackColor;
        lbl.font = sysFont(13);
        lbl.text= @"*苗源所在地:";
        _lbl = lbl;
        [self addSubview:lbl];
        lbl.sd_layout.leftSpaceToView(self,15).centerYIs(55/2.0).heightIs(13).widthIs(80);
        //        [lbl setSingleLineAutoResizeWithMaxWidth:100];
        
        UIView *backView = [UIView new];
        backView.layer.cornerRadius = 4;
        backView.layer.borderColor = RGBA(203, 203, 203,0.6).CGColor;
        backView.layer.borderWidth = 1;
        [self addSubview:backView];
        backView.sd_layout.leftSpaceToView(lbl,10).rightSpaceToView(self,12).heightIs(45).centerYEqualToView(lbl);
        
        
        IHTextField *textFied = [IHTextField new];
        textFied.font = sysFont(14);
        textFied.textColor = cBlackColor;
        _textFied = textFied;
        
        [backView addSubview:textFied];
        textFied.sd_layout.leftSpaceToView(backView,8).centerYEqualToView(backView).heightIs(25).rightSpaceToView(backView,20);
        
        UIImage *image= Image(@"iconfont-fanhui.png");
        UIImageView *imageView = [UIImageView new];
        imageView.image= image;
        imageView.transform= CGAffineTransformMakeRotation(-M_PI_2);
        _downImg = imageView;
        imageView.hidden = YES;
        [backView addSubview:imageView];
        imageView.sd_layout.rightSpaceToView(backView,8).centerYEqualToView(textFied).widthIs(image.size.height).heightIs(image.size.width);
        
    }
    
    return  self;
}
-(void)setTextContent:(NSString *)text
{
    _lbl.text = [NSString stringWithFormat:@"%@:",text];
    if ([text containsString:@"*"]) {
        NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:_lbl.text];
        [attriStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
        _lbl.attributedText = attriStr;
    }
    
   
}

@end

@implementation NerseryNumView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        SMLabel *lbl = [SMLabel new];
        lbl.textColor = cBlackColor;
        lbl.font = sysFont(13);
        lbl.text= @"*数量:";
        _lbl = lbl;
        [self addSubview:lbl];
        lbl.sd_layout.leftSpaceToView(self,15).centerYIs(55/2.0).heightIs(13).widthIs(85);
        NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:_lbl.text];
        [attriStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
        _lbl.attributedText = attriStr;
        
        UIImage *img = Image(@"Nusrsery_addNum.png");
        
        UIButton *addBtn = [UIButton new];
        [addBtn setImage:img forState:UIControlStateNormal];
        [addBtn addTarget:self action:@selector(addNumAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:addBtn];
        addBtn.tag = 10;
        addBtn.sd_layout.rightSpaceToView(self,18).heightIs(img.size.height).widthIs(img.size.width).centerYIs(55/2.0);
        
        IHTextField *numLbl = [IHTextField new];
        numLbl.textColor = cBlackColor;
        numLbl.font = sysFont(17);
        numLbl.text = @"0";
        numLbl.delegate = self;
        numLbl.textAlignment = NSTextAlignmentCenter;
        self.numLbl = numLbl;
        [self addSubview:numLbl];
        [numLbl addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        numLbl.sd_layout.rightSpaceToView(addBtn,10).heightIs(35).widthIs(40).centerYIs(55/2.0);
        
        img = Image(@"Nursery_reduceNum.png");
        UIButton *reduceBtn = [UIButton new];
        [reduceBtn setImage:img forState:UIControlStateNormal];
        [reduceBtn addTarget:self action:@selector(addNumAction:) forControlEvents:UIControlEventTouchUpInside];
        reduceBtn.tag = 11;
        [self addSubview:reduceBtn];
        reduceBtn.sd_layout.rightSpaceToView(numLbl,10).heightIs(img.size.height).widthIs(img.size.width).centerYIs(55/2.0);
        
        
        NSArray *arr = @[@"株",@"丛",@"袋",@"平方"];
        for (int i = 0; i<arr.count; i++) {
            UIImage *img = Image(@"Nursery_advant.png");
            UIImage *selectedImg = Image(@"Nursery_advantSelected.png");
            
            UIButton *btn = [UIButton new];
            [btn setTitle:arr[i] forState:UIControlStateNormal];
            [btn setTitleColor:cBlackColor forState:UIControlStateNormal];
            [btn setImage:img forState:UIControlStateNormal];
            [btn setImage:selectedImg forState:UIControlStateSelected];
            btn.titleLabel.font = sysFont(13);
            btn.tag = 200 + i;
            if (i==0) {
                btn.selected = YES;
            }
            
            btn.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 6);
            btn.titleEdgeInsets=UIEdgeInsetsMake(0, 6, 0, 0);
            [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            btn.sd_layout.leftSpaceToView(self,(WindowWith - 125)/4 * i + 110).heightIs(img.size.height).widthIs((WindowWith - 125)/3).topSpaceToView(self,55);
            
            
        }
        
    }
    return self;
}
- (void)textFieldDidChange:(IHTextField *)textFiled
{
    if (textFiled.text.length>0) {
        CGSize size = [IHUtility GetSizeByText:textFiled.text sizeOfFont:17 width:100];
        if (size.width > 40) {
            self.numLbl.sd_layout.widthIs(size.width + 20);
        }else{
            self.numLbl.sd_layout.widthIs(40);
        }
    }
    
}

- (void)buttonAction:(UIButton *)btn
{
    btn.selected = YES;
    NSArray *views = self.subviews;
    for (UIView *view in views) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            if (button != btn) {
                button.selected = NO;
            }
        }
    }
    
    self.selectBlock(btn.tag);
}
- (void)addNumAction:(UIButton *)btn
{
    [self.numLbl resignFirstResponder];
    
    if (btn.tag ==10) {
        int number = [self.numLbl.text intValue];
        number ++;
        self.numLbl.text = stringFormatInt(number);
        CGSize size = [IHUtility GetSizeByText:stringFormatInt(number) sizeOfFont:17 width:100];
        if (size.width > 40) {
            self.numLbl.sd_layout.widthIs(size.width +20);
        }else{
            self.numLbl.sd_layout.widthIs(40);
        }
    }else if (btn.tag ==11){
        int number = [self.numLbl.text intValue];
        if (number>0) {
            number --;
            self.numLbl.text = stringFormatInt(number);
            CGSize size = [IHUtility GetSizeByText:stringFormatInt(number) sizeOfFont:17 width:100];
            if (size.width > 40) {
                self.numLbl.sd_layout.widthIs(size.width+20);
            }else{
                self.numLbl.sd_layout.widthIs(40);
            }
        }
        
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.text.length<=0) {
        self.numLbl.text = @"0";
        self.numLbl.sd_layout.widthIs(40);
    }
}
@end


@implementation NerseryAdvantageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame: frame];
    if (self) {
        SMLabel *lbl = [SMLabel new];
        lbl.textColor = cBlackColor;
        lbl.font = sysFont(13);
        lbl.text= @"*优势:";
        _lbl = lbl;
        [self addSubview:lbl];
        lbl.sd_layout.leftSpaceToView(self,15).centerYIs(55/2.0).heightIs(13).widthIs(85);
        NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:_lbl.text];
        [attriStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
        _lbl.attributedText = attriStr;
        
        UIView *backView = [UIView new];
        _backView = backView;
        [self addSubview:backView];
        backView.sd_layout.leftSpaceToView(lbl,10).rightSpaceToView(self,12).heightIs(45).centerYEqualToView(lbl);
        
        NSArray *arr = @[@"数量",@"统一性",@"新品种"];
        for (int i = 0; i<arr.count; i++) {
            UIImage *img = Image(@"Nursery_advant.png");
            UIImage *selectedImg = Image(@"Nursery_advantSelected.png");
            
            UIButton *btn = [UIButton new];
            [btn setTitle:arr[i] forState:UIControlStateNormal];
            [btn setTitleColor:cBlackColor forState:UIControlStateNormal];
            [btn setImage:img forState:UIControlStateNormal];
            [btn setImage:selectedImg forState:UIControlStateSelected];
            btn.titleLabel.font = sysFont(13);
            btn.tag = 20 + i;
            
          //  CGSize size=[IHUtility GetSizeByText:arr[i] sizeOfFont:13 width:(WindowWith-36)/4.0];
            btn.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 6);
            btn.titleEdgeInsets=UIEdgeInsetsMake(0, 6, 0, 0);
            [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [backView addSubview:btn];
            btn.sd_layout.leftSpaceToView(backView,(WindowWith - 115)/3 * i).heightIs(img.size.height).widthIs((WindowWith - 115)/3).centerYIs(45/2.0);
            
            
        }
        
    }
    return self;
}
- (void)buttonAction:(UIButton *)btn
{
    btn.selected = !btn.selected;
    self.selectBlock(btn.tag);
}

- (void)setTextContent:(NSString *)text
{
    if ([text containsString:@","]) {
        NSArray *arr = [text componentsSeparatedByString:@","];
        
        for (UIButton *view in [_backView subviews]) {
                if ([arr containsObject:view.titleLabel.text]) {
                    view.selected= YES;
                }
            
        }
    }else{
        for (UIButton *view in [_backView subviews]) {
            if ([text containsString:view.titleLabel.text]) {
                view.selected= YES;
            }
            
        }
    }
   
}
@end


@implementation ScoreConvertView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame: frame];
    if (self) {
        self.backgroundColor=RGBA(44, 44, 46, 0.3);
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
        [self addGestureRecognizer:tap];
        
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0.621*WindowWith, 0.773*WindowWith, 0.506*WindowWith)];
        view.centerX=self.centerX;
        view.backgroundColor=[UIColor whiteColor];
        [view setLayerMasksCornerRadius:5 BorderWidth:1 borderColor:[UIColor clearColor]];
        [self addSubview:view];
        
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(view.width/2-0.173*WindowWith/2, 0.066*WindowWith, 0.173*WindowWith, 0.173*WindowWith)];
        _imageView=imageView;
        imageView.image=Image(@"Score_cion.png");
        [view addSubview:imageView];
        
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, imageView.bottom+5, view.width, 15) textColor:cGrayLightColor textFont:sysFont(13)];
        lbl.textAlignment=NSTextAlignmentCenter;
        lbl.text=@"确认兑换吗？";
        _lbl=lbl;
        [view addSubview:lbl];
        
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(0.053*WindowWith, 0.36*WindowWith, 0.325*WindowWith, 0.104*WindowWith);
        [btn setLayerMasksCornerRadius:5 BorderWidth:0.5 borderColor:cGrayLightColor];
        [btn setTitle:@"取消" forState:UIControlStateNormal];
        _btn=btn;
        [btn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:cBlackColor forState:UIControlStateNormal];
        btn.titleLabel.font=sysFont(17);
        [view addSubview:btn];
        
        
        
        UIButton *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame=CGRectMake(0.0183*WindowWith+btn.right, btn.top, btn.width, btn.height);
        [btn2 setLayerMasksCornerRadius:5 BorderWidth:0 borderColor:cGrayLightColor];
        [btn2 setTitle:@"确认" forState:UIControlStateNormal];
        _btn2=btn2;
        [btn2 addTarget:self action:@selector(certain) forControlEvents:UIControlEventTouchUpInside];
        [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn2.backgroundColor=cGreenColor;
        btn2.titleLabel.font=sysFont(17);
        [view addSubview:btn2];
        
        
        UIButton *btn3=[UIButton buttonWithType:UIButtonTypeCustom];
        btn3.frame=CGRectMake(0, btn.top, 0.656*WindowWith, btn.height);
        [btn3 setLayerMasksCornerRadius:5 BorderWidth:0 borderColor:cGrayLightColor];
        btn3.centerX=imageView.centerX;
        [btn3 setTitle:@"查看详情" forState:UIControlStateNormal];
        _btn3=btn3;
        btn3.hidden=YES;
        [btn3 addTarget:self action:@selector(detile) forControlEvents:UIControlEventTouchUpInside];
        [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn3.backgroundColor=cGreenColor;
        btn3.titleLabel.font=sysFont(17);
        [view addSubview:btn3];
        
        
        
    }
    
    return self;
}
-(void)hide{
    [self removeFromSuperview];
    
}

-(void)detile{
     self.selectBlock(openBlock);
    [self hide];
}

-(void)certain{
    
    [UIView animateWithDuration:0.3 animations:^{
    
        
        CGAffineTransform tranform = self->_imageView.transform;
        //2.创建一个平移,并且得到计算好的结果
        //tx, ty, 平移量
        CGAffineTransform translate = CGAffineTransformTranslate(tranform/*当前的状态*/, 0, 0);
        
        CGAffineTransform scale = CGAffineTransformScale(translate, 1, 1); //包含平移
        //2.创建一个旋转
        //旋转角度为弧度,顺时针为正数,逆时针为负数
        CGAffineTransform rotate = CGAffineTransformRotate(scale, -180 * M_PI / 180/*单位为弧度*/);//包含缩放
        
        self->_imageView.transform=rotate;

        self->_btn.alpha=0;
        self->_btn2.alpha=0;
       
    
    } completion:^(BOOL finished) {
        
        self->_imageView.image=Image(@"Score_liwu.png");
        self->_lbl.text=@"兑换成功";
        
        CGAffineTransform tranform = self->_imageView.transform;
        //2.创建一个平移,并且得到计算好的结果
        //tx, ty, 平移量
        CGAffineTransform translate = CGAffineTransformTranslate(tranform/*当前的状态*/, 0, 0);
        
        CGAffineTransform scale = CGAffineTransformScale(translate, 1, 1); //包含平移
        //2.创建一个旋转
        //旋转角度为弧度,顺时针为正数,逆时针为负数
        CGAffineTransform rotate = CGAffineTransformRotate(scale, -180 * M_PI / 180/*单位为弧度*/);//包含缩放
        
        self->_imageView.transform=rotate;
        
        self->_btn.hidden=YES;
        self->_btn.hidden=YES;
        self->_btn3.hidden=NO;
    }];


    self.selectBlock(SelectBtnBlock);
    
    

    
    
   
}


@end


#define  itemWidth    SCREEN_WIDTH/3
#define  itemHeight   SCREEN_WIDTH/4

@implementation PlantSelectedView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIWindow * window = [UIApplication sharedApplication].keyWindow;
        self.backgroundColor = RGBA(44, 44, 46,0.3);
        self.userInteractionEnabled = YES;
        self.tag = 2222;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenView)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:tap];
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(22.5, 85, self.width- 45, self.height - 170)];
        backView.backgroundColor = [UIColor whiteColor];
        backView.layer.cornerRadius = 12;
        [self addSubview:backView];
        
        UIView *textView = [[UIView alloc] initWithFrame:CGRectMake(13, 9, backView.width - 58, 30)];
        textView.backgroundColor = RGB(236, 236, 236);
        textView.layer.cornerRadius = 15;
        [backView addSubview:textView];
        
        UIImage *img = Image(@"EP_search.png");
        UIImageView *imageView= [[UIImageView alloc] initWithFrame:CGRectMake(8, 0, img.size.width, img.size.height)];
        imageView.image = img;
        imageView.centerY = 15;
        [textView addSubview:imageView];
        
        IHTextField *textFiled = [[IHTextField alloc] initWithFrame:CGRectMake(imageView.right + 7, 0, textView.width - imageView.right - 15, 30)];
        textFiled.font = sysFont(12);
        textFiled.placeholder = @"搜索苗木品种";
        [textFiled addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [textView addSubview:textFiled];
        
        img = Image(@"Nursery_selectedPlant.png");
        UIButton *deleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
        
        deleBtn.centerY=textView.centerY;
        deleBtn.right= backView.width - 15;
        
        [deleBtn setImage:img forState:UIControlStateNormal];
        [deleBtn addTarget:self action:@selector(hiddenView) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:deleBtn];
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(13, textView.bottom + 12, backView.width - 26, backView.height - 55 - textView.bottom - 12)];
        _scrollView = scrollView;
        [backView addSubview:scrollView];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, scrollView.bottom + 8, 140, 40)];
        btn.centerX = backView.width/2.0;
        [btn setTitle:@"确定" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        btn.titleLabel.font = sysFont(16);
        btn.backgroundColor = cGreenColor;
        btn.layer.cornerRadius = 20.0;
        [btn addTarget:self action:@selector(selectedBtn:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:btn];
        
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
    self.selectBlock(btnTag);
    
}
- (void)setPlantBtn:(NSArray *)array text:(NSString *)text
{
    if(dataArr.count<=0){
       dataArr = array;
    }
    _text = text;
    
    _scrollView.contentSize = CGSizeMake(_scrollView.width, (array.count-1)/3*44);
    for (int i =0; i<array.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i%3 *((_scrollView.width- 14)/3.0 + 7), i/3 * 44, (_scrollView.width- 14)/3.0, 38)];
        btn.layer.borderColor= cLineColor.CGColor;
        btn.layer.borderWidth = 0.7;
        btn.layer.cornerRadius = 2.5;
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setTitleColor:cBlackColor forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        btn.titleLabel.font = sysFont(13);
        [btn addTarget:self action:@selector(plantBtn:) forControlEvents:UIControlEventTouchUpInside];
        if ([array[i] isEqualToString:text]) {
            btn.selected = YES;
            btn.backgroundColor = cGreenColor;
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        
        btn.tag = 800+i;
        [_scrollView addSubview:btn];
        
    }
}

- (void)plantBtn:(UIButton *)button
{

    button.selected = YES;
    button.backgroundColor = cGreenColor;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnTag = button.tag - 800;
    _text = dataArr[btnTag];
    
    NSArray *views = _scrollView.subviews;
    for (UIView *view in views) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            if (btn != button) {
                btn.selected = NO;
                btn.backgroundColor = [UIColor whiteColor];
                [btn setTitleColor:cBlackColor forState:UIControlStateNormal];
            }
        }       
    }
    
}
- (void)textFieldDidChange:(IHTextField *)textFiled
{
    if (textFiled.text.length>0) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (NSString *str in dataArr) {
            if ([str containsString:textFiled.text]) {
                [array addObject:str];
            }
        }
        NSArray *views = _scrollView.subviews;
        for (UIView *view in views) {
            if ([view isKindOfClass:[UIButton class]]) {
                [view removeFromSuperview];
            }       
        }

        [self setPlantBtn:array text:_text];
    }else{
        NSArray *views = _scrollView.subviews;
        for (UIView *view in views) {
            if ([view isKindOfClass:[UIButton class]]) {
                [view removeFromSuperview];
            }
        }
        
        [self setPlantBtn:dataArr text:_text];
    }
}

-(void)hiddenView{
    
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    
    UIView *v=[window viewWithTag:2222];
    v.alpha=1;
    [UIView animateWithDuration:0.2 animations:^{
        v.alpha=0;
    } completion:^(BOOL finished) {
        [v removeFromSuperview];
    }];
}
@end


@implementation HomePageTopView

- (NSMutableArray *)dataArrM {
    
    if (!_dataArrM) {
        
        _dataArrM = [NSMutableArray array];
    }
    return _dataArrM;
}
- (NSMutableArray *)banArrM {
    
    if (!_banArrM) {
        
        _banArrM = [NSMutableArray array];
    }
    return _banArrM;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        //获取缓存
        NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *file = [path stringByAppendingPathComponent:@"myBannerList.data"];
        NSArray *resultArr = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
        if ([resultArr isKindOfClass:[NSArray class]] && resultArr != nil) {
            [self.dataArrM addObjectsFromArray:resultArr];
            if (self.BannerV) {
                [self.BannerV removeFromSuperview];
            }else {
                HeadBannerView * _scrollView = [HeadBannerView initWithFrame:CGRectMake(0, kWidth(10), iPhoneWidth, kWidth(142)) imageSpacing:10 imageWidth:kWidth(305)];
                _scrollView.initAlpha = 0.5;    // 设置两边卡片的透明度
                _scrollView.backgroundColor = [UIColor whiteColor];
                _scrollView.imageRadius = kWidth(6);   // 设置卡片圆角
                _scrollView.imageHeightPoor = 10; // 设置中间卡片与两边卡片的高度差
                _scrollView.placeHolderImage = kImage(@"defaulLogo");
                self.BannerV = _scrollView;
            }
           
            [self addSubview:self.BannerV];
            [self.banArrM removeAllObjects];
            for (NSDictionary * dic in self.dataArrM)
            {
                if (dic[@"activities_pic"]) {
                    [self.banArrM addObject:dic[@"activities_pic"]];
                }
            }
            self.BannerV.data = self.banArrM;
            WS(weakSelf);
            weakSelf.BannerV.clickImageBlock = ^(NSInteger currentIndex) { // 点击中间图片的回调
                NSLog(@"===");
                NSDictionary * dic = self.dataArrM[currentIndex];
                weakSelf.callBack(currentIndex,dic);
            };
        }
        
        [network getActivityList:0 num:10 success:^(NSDictionary *obj) {
            
            [self.dataArrM removeAllObjects];

            NSArray *arr = obj[@"content"];
            if ([arr isKindOfClass:[NSArray class]] && arr != nil) {
                
                //缓存数据
                NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString *file = [path stringByAppendingPathComponent:@"myBannerList.data"];
                [NSKeyedArchiver archiveRootObject:arr toFile:file];
                if (self.BannerV) {
                    [self.BannerV removeFromSuperview];
                }else {
                    HeadBannerView * scrollView = [HeadBannerView initWithFrame:CGRectMake(0, kWidth(10), iPhoneWidth, kWidth(142)) imageSpacing:10 imageWidth:kWidth(305)];
                    scrollView.initAlpha = 0.5;    // 设置两边卡片的透明度
                    scrollView.imageRadius = kWidth(6);   // 设置卡片圆角
                    scrollView.backgroundColor = [UIColor whiteColor];
                    scrollView.imageHeightPoor = 10; // 设置中间卡片与两边卡片的高度差
                    scrollView.placeHolderImage = kImage(@"defaulLogo");
                    self.BannerV = scrollView;
                }
                [self addSubview:self.BannerV];
                [self.banArrM removeAllObjects];
                for (NSDictionary * dic in arr)
                {
                    if (dic[@"activities_pic"]) {
                        [self.banArrM addObject:dic[@"activities_pic"]];
                    }
                    
                }
                self.BannerV.data = self.banArrM;
                WS(weakSelf);
                weakSelf.BannerV.clickImageBlock = ^(NSInteger currentIndex) { // 点击中间图片的回调
                    NSDictionary * dic = arr[currentIndex];
                    weakSelf.callBack(currentIndex,dic);
                };
//                AdView *v=[AdView adScrollViewWithFrame:frame imageLinkURL:arr placeHoderImageName:@"defaulLogo.png" pageControlShowStyle:UIPageControlShowStyleRight];
//                self.v=v;
//                v.callBack=^(NSInteger index,NSDictionary * dic){
//                    self.callBack(index,dic);
//                };
//                [self addSubview:v];
            }
            
        } failure:^(NSDictionary *obj2) {
            
        }];
        
        UIView *BtnView = [[UIView alloc]init];
        BtnView.backgroundColor = [UIColor whiteColor];
        NSArray *arr = [ConfigManager getHomePageListView];
        
#ifdef APP_MiaoTu
        NSMutableArray *arr1 = [[NSMutableArray alloc]initWithArray:[[IHUtility getUserDefalutDic:kUserDefalutInit] objectForKey:@"configClientItemList"]] ;
        
        if (arr1.count==0) {
            [arr1 addObjectsFromArray:arr];
        }
        
#elif defined APP_YiLiang
        NSMutableArray *arr1=[[NSMutableArray alloc]initWithArray:arr] ;
        
#endif
        
        NSMutableArray *itemArray=[[NSMutableArray alloc]init];
        NSMutableDictionary *weatherDic;
        for (int i=0; i<arr1.count; i++) {
            NSDictionary *dic=[arr1 objectAtIndex:i];
            
            int status = [dic[@"status"]intValue];
            
            if ([dic[@"itemCode"]intValue] == 1007) {  //天气模块
                weatherDic=[[NSMutableDictionary alloc]initWithDictionary:dic];
            }else{
                if (status==1) {
                    [itemArray addObject:dic];
                }
            }
        }
//        int weatherY = WindowWith*0.453;
        int weatherHeigh=0;
//        if ([weatherDic[@"status"] intValue]==1) {
//
//            WeatherView *weatherView=[[WeatherView alloc]initWithFrame:CGRectMake(0, WindowWith*0.453, WindowWith, 50)];
//            weatherView.backgroundColor=[UIColor whiteColor];
//            self.weatherView = weatherView;
//            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back)];
//            weatherView.userInteractionEnabled=YES;
//            [weatherView addGestureRecognizer:tap];
//            [self addSubview:weatherView];
//            weatherY = weatherView.bottom;
//            weatherHeigh = weatherView.height;
//        }
        
        NSInteger lineNums_per = [[[IHUtility getUserDefalutDic:kUserDefalutInit] objectForKey:@"lineItemSum"] integerValue];
        if (lineNums_per == 0) {
            lineNums_per = 3;
        }
        CGFloat item_Width = SCREEN_WIDTH/lineNums_per;
        NSInteger lineNum = itemArray.count%lineNums_per==0 ? itemArray.count/lineNums_per : itemArray.count/lineNums_per+1;
        _tagArr = itemArray;
        for (NSInteger i = 0; i < itemArray.count; i++) {
            
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(item_Width*(i%lineNums_per), (i/lineNums_per)*itemHeight, item_Width, itemHeight)];
            UIImage *img = Image(@"icon3.png");
            
            
            UIAsyncImageView *imageView = [[UIAsyncImageView alloc]initWithFrame:CGRectMake(view.width/2-kWidth(49)/2, 0.17*0.23*WindowWith , kWidth(49), kWidth(49))];
            
//            UIAsyncImageView *imageView = [[UIAsyncImageView alloc]initWithFrame:CGRectMake(view.width/2-img.size.width/2, 0.17*0.23*WindowWith , img.size.width, img.size.height)];
            
#ifdef APP_MiaoTu
            
            [imageView setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,itemArray[i][@"itemIcon"]] placeholderImage:img];
            
//            [imageView setImageAsyncWithURL:[NSString stringWithFormat:@"%@",itemArray[i][@"iconUrl"]] placeholderImage:img];
            
#elif defined APP_YiLiang
            
            imageView.image=Image(itemArray[i][@"itemIcon"]);
            
#endif
            //imageView.image=img;
//            view.tag=[itemArray[i][@"itemCode"] integerValue];
            view.tag=i + 100;;
            imageView.userInteractionEnabled=YES;
            [view addSubview:imageView];
            
            if ([itemArray[i][@"itemCode"] integerValue]==1002) { //话题
                UIImage *img=Image(@"redpoint.png");
                UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(imageView.width-15, 0, img.size.width, img.size.height)];
                imgView.image=img;
                
                self.redImageView = imgView;
                self.redImageView.hidden = YES;
                [imageView addSubview:imgView];
            }
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(BtnTap:)];
            [view addGestureRecognizer:tap];
            
            SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, imageView.bottom, view.width, view.height-imageView.bottom) textColor:RGB(44, 44, 46) textFont:sysFont(13)];
            lbl.text=itemArray[i][@"itemName"];
            lbl.numberOfLines = 2;
            lbl.textAlignment=NSTextAlignmentCenter;
            
            [view addSubview:lbl];
            [BtnView addSubview:view];
            view.backgroundColor=[UIColor whiteColor];
            
            UIView *lineView_V= [[UIView alloc]initWithFrame:CGRectMake(item_Width-1, 0, 1, itemHeight)];
            lineView_V.backgroundColor=cLineColor;
            [view addSubview:lineView_V];
            
            if ([itemArray[i][@"itemCode"] integerValue]==1031) {  //社区
//                self.BadgeNumLabel = [[CornerView alloc] initWithFrame:CGRectMake(view.width - 30 , 5, 15, 15)];
                self.BadgeView = [[CornerView alloc] initWithFrame:CGRectMake(view.width - 30 , 5, 15, 15) count:[BadgeMODEL getSumNum]];
//                [view addSubview:self.BadgeView];
            }
            UIView *lineView_H = [[UIView alloc]initWithFrame:CGRectMake(0, itemHeight-1, item_Width, 1)];
            lineView_H.backgroundColor=cLineColor;
            [view addSubview:lineView_H];
            lineView_H.hidden = YES;
            lineView_V.hidden = YES;
        }

  
        BtnView.frame=CGRectMake(0, 0.453*WindowWith+weatherHeigh+7, WindowWith, itemHeight*lineNum);
        BtnView.backgroundColor = [UIColor whiteColor];

        [self addSubview:BtnView];

        self.frame=CGRectMake(0, 0, WindowWith, WindowWith*0.453+BtnView.height+1+weatherHeigh);//+topicView.height
    }
    
    return self;
}

-(void)BtnTap:(UITapGestureRecognizer *)tap{
    NSInteger tag = tap.view.tag - 100;
    NSDictionary *dict = _tagArr[tag];
    NSInteger index = [dict[@"itemCode"] intValue];
    self.selectBlock(index,dict);
}
#pragma mark --天气模块点击处理--

-(void)back{
    self.selectBlock(SelectBtnBlock,nil);
}


@end



@implementation ChoosePositionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=cBgColor;
        NSArray *arr=@[@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理",@"苗木管理"];
        CGFloat x=0;
        CGFloat y=0;
    
        for (NSInteger i=0; i<arr.count; i++) {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            if (i%3==0&&i>0) {
                x=0;
                y=y+5+0.117*WindowWith;
            }
            btn.frame=CGRectMake(x, y, (frame.size.width-10)/3, 0.117*WindowWith);
            x=x+btn.width+5;
            y=btn.top;
           
            btn.hidden=YES;
            
            btn.tag=i+1000;
            btn.backgroundColor=[UIColor whiteColor];
            btn.titleLabel.font=sysFont(14);
            btn.titleLabel.numberOfLines=2;
            [btn setTitleColor:cBlackColor forState:UIControlStateNormal];
            [self addSubview:btn];
            [btn addTarget:self action:@selector(dianji:) forControlEvents:UIControlEventTouchUpInside];
            
            
        }
        
        
    }
    
    return  self;
}

-(void)dianji:(UIButton *)sender{
 
    self.selectBtnBlock(sender.tag);
    
}


-(CGFloat)setDataWithArr:(NSArray *)arr{
    
    CGFloat height=0;
    for (NSInteger i=0; i<arr.count; i++) {
        UIButton *btn=[self viewWithTag:1000+i];
      //  CGSize size=[IHUtility GetSizeByText:arr[i] sizeOfFont:14 width:WindowWith];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        btn.hidden=NO;
      
        
    }
      UIButton *btn=[self viewWithTag:1000+arr.count-1];
    
     height=btn.bottom;
    
    for (NSInteger i=arr.count; i<50; i++) {
        UIButton *btn=[self viewWithTag:1000+i];
        btn.hidden=YES;
    }
    

    return height;
    
    
}



@end

@implementation CarDetailTopView
- (id)initWithFrame:(CGRect)frame imageUrl:(NSString *)imageUrl name:(NSString *)name address:(NSString *)address
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        UIAsyncImageView *headImageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(12, 15, 40, 40)];
        [headImageView setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@%@",ConfigManager.ImageUrl,imageUrl,smallHeaderImage] placeholderImage:defalutHeadImage];
        [headImageView setLayerMasksCornerRadius:20 BorderWidth:0 borderColor:cGreenColor];
        [self addSubview:headImageView];
        
        
        
        CGSize size=[IHUtility GetSizeByText:name sizeOfFont:15 width:120];
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(headImageView.right+12, 0, size.width, 16) textColor:cBlackColor textFont:sysFont(15)];
        lbl.centerY=headImageView.centerY;
        lbl.text=name;
        [self addSubview:lbl];
        
        UIImage *img=Image(@"logistics_renzheng");
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(lbl.right+8, 0, img.size.width, img.size.height)];
        imageView.image=img;
        imageView.centerY=lbl.centerY;
        [self addSubview:imageView];
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+2, 0, 24, 14) textColor:cGreenColor textFont:sysFont(12)];
        lbl.centerY=headImageView.centerY;
        lbl.text=@"司机";
        [self addSubview:lbl];
        
        
        size=[IHUtility GetSizeByText:address sizeOfFont:12 width:150];
        img=Image(@"MT_adress.png");
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(WindowWith-12-size.width-14, 0, img.size.width+size.width+3, 16);
        btn.centerY=headImageView.centerY;
        [btn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
        [btn setTitle:@"湖南省长沙市" forState:UIControlStateNormal];
        [btn setTitleColor:cGrayLightColor forState:UIControlStateNormal];
        btn.titleEdgeInsets=UIEdgeInsetsMake(0, 3, 0, 0);
        btn.titleLabel.font=sysFont(12);
        [self addSubview:btn];
        
        
    }
    
    
    return self;
}
@end

@implementation LogisticsAddressView
- (id)initWithFrame:(CGRect)frame ViewColor:(UIColor *)color text:(NSString *)text place:(NSString *)place
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        UIView *addressView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 35)];
        [self addSubview:addressView];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dianji)];
        [addressView addGestureRecognizer:tap];
        
        
        
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(11, 22, 8, 8)];
        view.backgroundColor=color;
        [view setLayerMasksCornerRadius:4 BorderWidth:0 borderColor:cGreenColor];
        [addressView addSubview:view];
        
        
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(view.right+5, 0, 70, 18) textColor:cBlackColor textFont:sysFont(16)];
        lbl.text=text;
        lbl.centerY=view.centerY;
        [addressView addSubview:lbl];
        
        
        UIImage *img=Image(@"GQ_Left.png");
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.width-12-img.size.width, 0, img.size.width, img.size.height)];
        imageView.image=img;
        imageView.centerY=view.centerY;
        [addressView addSubview:imageView];
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.right+10, 0, self.width-lbl.right-10-img.size.width-12-10, 15) textColor:cGreenColor textFont:sysFont(13)];
        lbl.text=@"";
        self.lbl=lbl;
        lbl.textAlignment=NSTextAlignmentRight;
        lbl.centerY=view.centerY;
        [addressView addSubview:lbl];
        
        
        IHTextField *textView=[[IHTextField alloc]initWithFrame:CGRectMake(view.right+5, addressView.bottom+22, self.width-view.right-5-12, 15)];
        textView.font=sysFont(13);
        textView.textColor=cBlackColor;
        self.TextField=textView;
         textView.borderStyle=UITextBorderStyleNone;
       textView.placeholder=place;
        [self addSubview:textView];
        
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(textView.left, textView.bottom+2, textView.width, 1)];
        lineView.backgroundColor=cLineColor;
        [self addSubview:lineView];
        
    }
    
    return self;
}

-(void)dianji{
    
    self.selectBlock(SelectBtnBlock);
    
}

@end


@implementation LogisticsInformationView
-(id)initWithFrame:(CGRect)frame text:(NSString *)text isMust:(BOOL)isMust{
    
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        UIImage *img=Image(@"redstar.png");
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
       
        if (isMust) {
             [btn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
             btn.titleEdgeInsets=UIEdgeInsetsMake(0, 2.5, 0, 0);
             btn.frame=CGRectMake(11, 18, img.size.width+2.5+65, 17);
        }else{
             btn.frame=CGRectMake(11, 18, 65, 17);
        }
        
        [btn setTitle:text forState:UIControlStateNormal];
        
       
        btn.titleLabel.font=sysFont(15);
        [btn setTitleColor:cBlackColor forState:UIControlStateNormal];
       
        [self addSubview:btn];
        
        
        
        
        
        
    }
    
    return self;
}


@end

@implementation RequirementChooseView
-(id)initWithFrame:(CGRect)frame text:(NSString *)text {
    
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        
        NSArray *arr=@[@"超高",@"超宽",@"超长"];
        
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(12, 20, 100, 17) textColor:cBlackColor textFont:sysFont(15)];
        lbl.text=text;
       // lbl.centerY=self.centerY;
        [self addSubview:lbl];
        CGFloat lastBtnLeft=self.width-12;
        for (NSInteger i=0; i<arr.count; i++) {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            UIImage *img=Image(@"logistics_gou.png");
            btn.frame=CGRectMake(lastBtnLeft-26-4-img.size.width, 20, 26+4+img.size.width, img.size.height);
            lastBtnLeft=btn.left-15;
            [btn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
            [btn setTitle:arr[i] forState:UIControlStateNormal];
            [btn setTitleColor:cBlackColor forState:UIControlStateNormal];
            btn.titleEdgeInsets=UIEdgeInsetsMake(0, 4, 0, 0);
            btn.titleLabel.font=sysFont(13);
            [self addSubview:btn];
            btn.tag=1000+i;
            btn.hidden=YES;
            
        }
        
        
        
        
    }
    
    return self;
}

-(void)setDataWith:(NSArray *)arr isSigle:(BOOL)isSigle text:(NSString *)text{
    _arr=arr;
    _Arr=[[NSMutableArray alloc]init];
      CGFloat lastBtnLeft=self.width-12;
    for (NSInteger i=0; i<arr.count; i++){
         UIImage *img=Image(@"logistics_gou.png");
         UIImage * selectImg=Image(@"logistics_gouSelect.png");
        CGSize size=[IHUtility GetSizeByText:arr[i] sizeOfFont:13 width:100];
        UIButton *btn=[self viewWithTag:1000+i];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        btn.frame=CGRectMake(lastBtnLeft-size.width-4-img.size.width, 20, size.width+4+img.size.width, img.size.height);
        lastBtnLeft=btn.left-15;
        btn.hidden=NO;
        if (isSigle) {
            [btn addTarget:self action:@selector(sigleChoose:) forControlEvents:UIControlEventTouchUpInside];
            if ([arr[i] isEqualToString:text]) {
                 [btn setImage:[selectImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
                btn.selected=YES;
            }
        }else{
            //如果分隔符出现在字符串的开头和结尾,则会出现空字符串 @""
            NSCharacterSet *sp = [NSCharacterSet characterSetWithCharactersInString:@","];
            
            NSArray *result3 = [text componentsSeparatedByCharactersInSet:sp];
            NSMutableArray *result4 = [[NSMutableArray alloc] initWithArray:result3];
            //删除空字符串
            [result4 removeObject:@""];
            for (NSString *str in result4) {
                if ([str isEqualToString:arr[i]]) {
                     [btn setImage:[selectImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
                    btn.selected=YES;
                    [_Arr addObject:str];
                }
            }
            
            
             [btn addTarget:self action:@selector(multipleChoose:) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    
    for (NSInteger i=arr.count; i<3; i++) {
         UIButton *btn=[self viewWithTag:1000+i];
        btn.hidden=YES;
        
    }
    
    
    
}

-(void)sigleChoose:(UIButton *)sender{
    UIImage * img=Image(@"logistics_gou.png");
    UIImage * selectImg=Image(@"logistics_gouSelect.png");
    for (NSInteger i=0; i<_arr.count; i++) {
        UIButton *btn=[self viewWithTag:1000+i];
        [btn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    }
    
    [sender setImage:[selectImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    
    self.selectBtn(sender.titleLabel.text);
    
    
}

-(void)multipleChoose:(UIButton *)sender{
    UIImage * img=Image(@"logistics_gou.png");
    UIImage * selectImg=Image(@"logistics_gouSelect.png");
    //NSMutableArray *arr=[[NSMutableArray alloc]init];
    sender.selected=!sender.selected;
    if (sender.selected) {
        [_Arr addObject:sender.titleLabel.text];
         [sender setImage:[selectImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    }else{
        [_Arr removeObject:sender.titleLabel.text];
          [sender setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    }
    self.selectArrBtnBlock(_Arr);
    
}




@end



