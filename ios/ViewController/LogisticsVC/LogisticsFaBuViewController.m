//
//  LogisticsFaBuViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 17/1/5.
//  Copyright © 2017年 xubin. All rights reserved.
//

#import "LogisticsFaBuViewController.h"
#import "HKLPickerView.h"
#import "AdditionalRequirementViewController.h"
#import "JLPickView.h"
#import "CustomView+category5.h"
#import "AddressDropView.h"
#import "CustomView+CustomCategory2.h"

@interface LogisticsFaBuViewController ()<UITextFieldDelegate,UITextViewDelegate>
{
    PlaceholderTextView *_placeholderTextView;
    LogisticsAddressView *_logisticsAdressView;
     LogisticsAddressView *_logisticsAdressView2;
     AreaView *_areaV;
    NSString *_provice;
    NSString *_city;
    NSString *_town;
    NSString *_provice2;
    NSString *_city2;
    NSString *_town2;
    CGFloat _keybordHight;
    IHTextField *_phoneTextField;
    IHTextField *_varietyTextField;
    IHTextField *_weightTextField;
    LogisticsInformationView *_view;
    NSString *KeybordType;
    UIView *_textBgView;
    NSArray * _bankDataSource;
    SMLabel *_carTypeLbl;
    SMLabel *_timeLbl;
    NSMutableArray *_nerseryTypeArr;
    LogisticsInformationView *_huowuView;
   
     LogisticsInformationView *_huowuNameView;
     LogisticsInformationView *_huowuWeightView;
     LogisticsInformationView *_zhuangcheView;
    LogisticsInformationView *_carTypeView;
    LogisticsInformationView *_requirementView;
    
    UIButton *_yongcheBtn;
    UIButton *_beizhuBtn;
    UIButton *_fabuBtn;
    SMLabel *_typeLbl;
    HuoWuTypeView *_huowuTypeview;
    NSMutableArray *_carTypeArr;
    NSDictionary *_timeDic;
    
    NSString *zhuangcheType;
    
    
    NSString *_zhuanghuoType;
    NSString *_luduan;
    NSString *_direverNumber;
    NSString *_payType;
    NSString *_carTime;
    int preferredModels;
    int goodsType;
    NSArray *_carArr;
    NSArray *_nerseryArr;
}

@property (nonatomic , strong)AddressDropView *view1;
@property (nonatomic , strong)AddressDropView *view2;

@end

@implementation LogisticsFaBuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"发布需求"];
    __weak LogisticsFaBuViewController *weakSelf=self;
    //品种类型
    [network GetMiaoMuYunListSuccess:^(NSDictionary *obj) {
		if (self->_nerseryTypeArr.count>0) {
			[self->_nerseryTypeArr removeAllObjects];
        }
        NSArray *arr=obj[@"content"];
		self->_nerseryArr=arr;
        for (NSDictionary *dic in arr) {
            
			[self->_nerseryTypeArr addObject:dic[@"parent_nursery_name"]];
            
        }
        
        
        
        
        
    } failure:^(NSDictionary *obj2) {
        
    }];

    //车型
    _carTypeArr=[[NSMutableArray alloc]init];
    [network selectAllCarType:^(NSDictionary *obj) {
        if (self->_carTypeArr.count>0) {
            [self->_carTypeArr removeAllObjects];
        }
        NSArray *arr=obj[@"content"];
        self->_carArr=arr;
        for (NSDictionary *dic in arr) {
            
            NSArray *arr1=dic[@"flowCarHeight"];
            NSMutableArray *Arr1=[[NSMutableArray alloc]init];
            for (NSDictionary *dic1 in arr1) {
                [Arr1 addObject:dic1[@"carHeight_name"]];
                
            }
            [self->_carTypeArr addObject:@{dic[@"carType_name"]:Arr1}];
            
        }
        
        
    } failure:^(NSDictionary *obj2) {
        
    }];

    //用车时间
    [network getOwnerCarTimeSuccess:^(NSDictionary *obj) {
        self->_timeDic=obj[@"content"];
    } failure:^(NSDictionary *obj2) {
        
    }];
    

    goodsType=0;
    preferredModels=0;
    
    _provice = @"";
    _city = @"";
    _town=@"";
    
    _provice2 = @"";
    _city2 = @"";
    _town2=@"";
    zhuangcheType=@"人工";
    _carTime=@"";
    _nerseryTypeArr=[[NSMutableArray alloc]init];
    UIImage *img=Image(@"redstar.png");
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [btn setTitle:@"路线信息" forState:UIControlStateNormal];
    btn.titleEdgeInsets=UIEdgeInsetsMake(0, 2.5, 0, 0);
    btn.titleLabel.font=sysFont(12);
    [btn setTitleColor:cGrayLightColor forState:UIControlStateNormal];
    btn.frame=CGRectMake(11, 8, img.size.width+2.5+52, 14);
    [_BaseScrollView addSubview:btn];
    
    LogisticsAddressView *logisticsAdressView=[[LogisticsAddressView alloc]initWithFrame:CGRectMake(btn.left, btn.bottom+5, WindowWith-btn.left*2, 90) ViewColor:cGreenColor text:@"装车地址" place:@"详细地址(选填)"];
    _logisticsAdressView=logisticsAdressView;
    if (_model) {
        _logisticsAdressView.lbl.text=[NSString stringWithFormat:@"%@%@%@",_model.placeOfDepartureProvince,_model.placeOfDepartureCity,_model.placeOfDepartureArea];
        _provice = _model.placeOfDepartureProvince;
        _city = _model.placeOfDepartureCity;
        _town=_model.placeOfDepartureArea;
        _logisticsAdressView.TextField.text=_model.placeOfDepartureAddress;
    }
    logisticsAdressView.selectBlock=^(NSInteger index){
        
       
        [weakSelf zhuangcheAddress];
        
        
        
    };
    [_BaseScrollView addSubview:logisticsAdressView];
  
    LogisticsAddressView *logisticsAdressView2=[[LogisticsAddressView alloc]initWithFrame:CGRectMake(logisticsAdressView.left, logisticsAdressView.bottom, WindowWith-btn.left*2, 90) ViewColor:RGB(232, 121, 117) text:@"到达地址" place:@"详细地址(选填)"];
    _logisticsAdressView2=logisticsAdressView2;
    if (_model) {
        _logisticsAdressView2.lbl.text=[NSString stringWithFormat:@"%@%@%@",_model.destinationProvince,_model.destinationCity,_model.destinationArea];
        _provice2 = _model.destinationProvince;
        _city2 = _model.destinationCity;
        _town2=_model.destinationArea;
        _logisticsAdressView2.TextField.text=_model.destinationAddress;
    }

    logisticsAdressView2.selectBlock=^(NSInteger index){
        
        [weakSelf arriverAddress];

        
    };
    [_BaseScrollView addSubview:logisticsAdressView2];
    
    
    img=Image(@"redstar.png");
    btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [btn setTitle:@"货物信息" forState:UIControlStateNormal];
    btn.titleEdgeInsets=UIEdgeInsetsMake(0, 2.5, 0, 0);
    btn.titleLabel.font=sysFont(12);
    [btn setTitleColor:cGrayLightColor forState:UIControlStateNormal];
    btn.frame=CGRectMake(11, logisticsAdressView2.bottom+7, img.size.width+2.5+52, 14);
    [_BaseScrollView addSubview:btn];
    
    NSArray *arr=@[@"联系电话",@"用车时间",@"货物类型",@"货物名称",@"货物重量",@"装车方式"];
    
    for (NSInteger i=0; i<arr.count; i++) {
        LogisticsInformationView *view=[[LogisticsInformationView alloc]initWithFrame:CGRectMake(btn.left, 50*i+btn.bottom+7, WindowWith-btn.left*2, 50) text:arr[i] isMust:YES];
        view.tag=2000+i;
        [_BaseScrollView addSubview:view];
        if (i==0) {
            _view=view;
            IHTextField *textView=[[IHTextField alloc]initWithFrame:CGRectMake(100, 18, view.width-100-12, 17)];
            textView.font=sysFont(15);
            _phoneTextField=textView;
            textView.delegate=self;
            textView.textAlignment=NSTextAlignmentRight;
            textView.textColor=cBlackColor;
            textView.borderStyle=UITextBorderStyleNone;
            textView.keyboardType=UIKeyboardTypeNumberPad;
            [view addSubview:textView];
            if (_model) {
                textView.text=_model.mobile;
            }

            
        }else if (i==1){
            
            UIImage *img=Image(@"GQ_Left.png");
            UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(view.width-12-img.size.width, 25-img.size.height/2, img.size.width, img.size.height)];
            imageView.image=img;
            //imageView.centerY=view.centerY;
            [view addSubview:imageView];
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(timeUse)];
            [view addGestureRecognizer:tap];
            
            SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(100, 17, view.width-100-12-img.size.width-10, 15) textColor:cGreenColor textFont:sysFont(13)];
            if (_model) {
                 lbl.text=_model.carTime;
                _carTime=_model.carTime;
            }
           
            _timeLbl=lbl;
            lbl.textAlignment=NSTextAlignmentRight;
            [view addSubview:lbl];
            
        }else if (i==2){
            
            UIImage *img=Image(@"GQ_Left.png");
            UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(view.width-12-img.size.width, 25-img.size.height/2, img.size.width, img.size.height)];
            imageView.image=img;
            //imageView.centerY=view.centerY;
            [view addSubview:imageView];
            _huowuView=view;
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(huowuType)];
            [view addGestureRecognizer:tap];
            
            SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(100, 17, view.width-100-12-img.size.width-10, 15) textColor:cGreenColor textFont:sysFont(13)];
            lbl.text=@"类型";
            if (_model) {
                lbl.text=_model.goodsTypeName;
                goodsType=[_model.goodsType intValue];
            }
            _typeLbl=lbl;
            lbl.textAlignment=NSTextAlignmentRight;
            [view addSubview:lbl];
            
            
            HuoWuTypeView *huowuTypeview=[[HuoWuTypeView alloc]initWithFrame:CGRectMake(0, _huowuView.bottom, WindowWith, 10)];
           
            huowuTypeview.hidden=YES;
            _huowuTypeview=huowuTypeview;
            //__weak HuoWuTypeView *weakView=view;
            huowuTypeview.selectBtn=^(NSString *str){
                 [self->_BaseScrollView endEditing:YES];
                self->_typeLbl.text=str;
                self->_huowuTypeview.hidden=YES;
                [weakSelf setUI:self->_huowuView.bottom];
                for (NSDictionary *dic in self->_nerseryArr) {
                    if ([str isEqualToString:dic[@"parent_nursery_name"]]) {
                        self->goodsType=[dic[@"parent_id"] intValue];
                    }
                }
                
            };
            [_BaseScrollView addSubview:huowuTypeview];
            

            
        }else if (i==3){
            
            _huowuNameView=view;
            IHTextField *textView=[[IHTextField alloc]initWithFrame:CGRectMake(100, 18, view.width-100-12, 17)];
            textView.font=sysFont(15);
            textView.textAlignment=NSTextAlignmentRight;
            textView.textColor=cBlackColor;
            textView.borderStyle=UITextBorderStyleNone;
            _varietyTextField=textView;
             textView.delegate=self;
            [view addSubview:textView];
            if (_model) {
                textView.text=_model.goodsName;
            }

            
            
        }else if (i==4){
            
            
            _huowuWeightView=view;
            SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(view.width-12-17, 18, 17, 17) textColor:cBlackColor textFont:sysFont(15)];
            lbl.text=@"吨";
            lbl.textAlignment=NSTextAlignmentRight;
            [view addSubview:lbl];

            IHTextField *textView=[[IHTextField alloc]initWithFrame:CGRectMake(100, 18, view.width-100-12-17-10, 17)];
            textView.font=sysFont(15);
            textView.textAlignment=NSTextAlignmentRight;
            textView.textColor=cBlackColor;
            textView.keyboardType=UIKeyboardTypeNumberPad;
            textView.borderStyle=UITextBorderStyleNone;
            _weightTextField=textView;
             textView.delegate=self;
            [view addSubview:textView];
            if (_model) {
                textView.text=_model.goodsWeight;
            }

            
            
            
            
        }else if (i==5){
            
            _zhuangcheView=view;
            img=Image(@"logistics_gou.png");
            if ([_model.carloadingMode isEqualToString:@"机械"]) {
                img=Image(@"logistics_gouSelect.png");
                zhuangcheType=@"机械";
            }
            btn=[UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            [btn setTitle:@"机械" forState:UIControlStateNormal];
            btn.titleEdgeInsets=UIEdgeInsetsMake(0, 4, 0, 0);
            btn.titleLabel.font=sysFont(13);
            [btn setTitleColor:cBlackColor forState:UIControlStateNormal];
            btn.frame=CGRectMake(view.width-30-4-img.size.width-12, 18, img.size.width+4+30, img.size.height);
            [btn addTarget:self action:@selector(zhuangCheType:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag=3001;
            [view addSubview:btn];
            
            
            
            img=Image(@"logistics_gouSelect.png");
            if ([_model.carloadingMode isEqualToString:@"机械"]) {
                 img=Image(@"logistics_gou.png");
            }

            btn=[UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            [btn setTitle:@"人工" forState:UIControlStateNormal];
            btn.titleEdgeInsets=UIEdgeInsetsMake(0, 4, 0, 0);
            btn.titleLabel.font=sysFont(13);
            [btn setTitleColor:cBlackColor forState:UIControlStateNormal];
             [btn addTarget:self action:@selector(zhuangCheType:) forControlEvents:UIControlEventTouchUpInside];
            btn.frame=CGRectMake(view.width-30-4-img.size.width-12-27-34-img.size.width, 18, img.size.width+4+30, img.size.height);
             btn.tag=3002;
            [view addSubview:btn];
            
            
            
            
        }
        
        
        
    }
    img=Image(@"redstar.png");
    btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [btn setTitle:@"用车要求" forState:UIControlStateNormal];
    btn.titleEdgeInsets=UIEdgeInsetsMake(0, 2.5, 0, 0);
    btn.titleLabel.font=sysFont(12);
    _yongcheBtn=btn;
    [btn setTitleColor:cGrayLightColor forState:UIControlStateNormal];
    LogisticsInformationView *view=[_BaseScrollView viewWithTag:2005];
    
    btn.frame=CGRectMake(11, view.bottom+7, img.size.width+2.5+52, 14);
    [_BaseScrollView addSubview:btn];
    
    
    
    
    
    LogisticsInformationView *view1=[[LogisticsInformationView alloc]initWithFrame:CGRectMake(btn.left, btn.bottom+7, WindowWith-btn.left*2, 50) text:@"优选车型" isMust:NO];
    SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(100, 17, view.width-100-12-img.size.width-10, 15) textColor:cGreenColor textFont:sysFont(13)];
    if (_model) {
        lbl.text=[NSString stringWithFormat:@"%@|%@",_model.carTypeName,_model.carHeight];
        preferredModels=[_model.preferredModels intValue];
        _zhuanghuoType=_model.pattern;
        _luduan=_model.section;
        _direverNumber=_model.driverNumber;
        _payType=_model.paymentType;
    }
    _carTypeLbl=lbl;
    _carTypeView=view1;
    lbl.textAlignment=NSTextAlignmentRight;
    [view1 addSubview:lbl];

    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(carType)];
    [view1 addGestureRecognizer:tap];
    
    img=Image(@"GQ_Left.png");
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(view1.width-12-img.size.width, 25-img.size.height/2, img.size.width, img.size.height)];
    imageView.image=img;
    //imageView.centerY=view.centerY;
    [view1 addSubview:imageView];
    
    
    [_BaseScrollView addSubview:view1];

    LogisticsInformationView *view2=[[LogisticsInformationView alloc]initWithFrame:CGRectMake(btn.left, view1.bottom, WindowWith-btn.left*2, 50) text:@"其他要求" isMust:NO];
    _requirementView=view2;
    tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushToRequirementVC)];
    [view2 addGestureRecognizer:tap];
    [_BaseScrollView addSubview:view2];
    
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(80, 19, 117, 15) textColor:cGrayLightColor textFont:sysFont(13)];
    lbl.text=@"(是否加宽/长/高)";
    [view2 addSubview:lbl];
    
    img=Image(@"GQ_Left.png");
   imageView=[[UIImageView alloc]initWithFrame:CGRectMake(view2.width-12-img.size.width, 25-img.size.height/2, img.size.width, img.size.height)];
    imageView.image=img;
    //imageView.centerY=view.centerY;
    [view2 addSubview:imageView];

    
    
  
    btn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setTitle:@"备注" forState:UIControlStateNormal];
    _beizhuBtn=btn;
    btn.titleLabel.font=sysFont(12);
    [btn setTitleColor:cGrayLightColor forState:UIControlStateNormal];
  
    
    btn.frame=CGRectMake(11, view2.bottom+7, 26, 14);
    [_BaseScrollView addSubview:btn];
    
    
    UIView *textBgView=[[UIView alloc]initWithFrame:CGRectMake(btn.left, btn.bottom+7, WindowWith-btn.left*2, 103)];
    textBgView.backgroundColor=[UIColor whiteColor];
    [_BaseScrollView addSubview:textBgView];
    _textBgView=textBgView;
    
    
    _placeholderTextView =[[PlaceholderTextView alloc]initWithFrame:CGRectMake(12, 15, textBgView.width-24, 55)];
    _placeholderTextView.layer.borderColor= cBgColor.CGColor;
    _placeholderTextView.layer.borderWidth=1;
    [_placeholderTextView.layer setCornerRadius:0];
    _placeholderTextView.placeholder=@"如运价好商量，高价急走";
    _placeholderTextView.placeholderColor=cGrayLightColor;
    _placeholderTextView.delegate=self;
    _placeholderTextView.placeholderFont=sysFont(14);
    [textBgView addSubview:_placeholderTextView];
    if (_model&&![_model.remark isEqualToString:@""]) {
        _placeholderTextView.text=_model.remark;
        _placeholderTextView.placeholder=@"";
        
        
       
    }

    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(_placeholderTextView.left, _placeholderTextView.bottom+5, _placeholderTextView.width, 12) textColor:cGrayLightColor textFont:sysFont(10)];
    lbl.text=@"发布的需求将实时显示在苗木物流司机端，等待司机联系并接货";
    [textBgView addSubview:lbl];
    
    
    btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(26, textBgView.bottom+18, WindowWith-26*2, 40);
    btn.backgroundColor=cGreenColor;
    [btn setTitle:@"立即发货" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font=sysFont(17);
    [btn setLayerMasksCornerRadius:18 BorderWidth:0 borderColor:cGreenColor];
    [_BaseScrollView addSubview:btn];
    _fabuBtn=btn;
    [btn addTarget:self action:@selector(fabu) forControlEvents:UIControlEventTouchUpInside];
    _BaseScrollView.contentSize=CGSizeMake(WindowWith, _fabuBtn.bottom+15+64);
    
    //监听键盘的升起和隐藏事件,需要用到通知中心 ****IQKeyboard
//    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
//
//    [center addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//
//    //监听隐藏:UIKeyboardWillHideNotification
//    [center addObserver:self selector:@selector(keyBoardWillHide) name:UIKeyboardWillHideNotification object:nil];
    
    
}

-(void)back:(id)sender{
    
    if (_model) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

-(void)fabu{
    
    if ([_logisticsAdressView.lbl.text isEqualToString:@""]) {
        [self addSucessView:@"未选择装车地址" type:2];
        return;
    }
    
    if ([_logisticsAdressView2.lbl.text isEqualToString:@""]) {
        [self addSucessView:@"未选择到达地址" type:2];
        return;
    }
    if ([_phoneTextField.text isEqualToString:@""]) {
        [self addSucessView:@"未填写联系电话" type:2];
        return;
    }
    if ([_carTime isEqualToString:@""]) {
        [self addSucessView:@"未填写用车时间" type:2];
        return;
 
    }
    if ([_carTypeLbl.text isEqualToString:@""]) {
        [self addSucessView:@"未填写货物类型" type:2];
        return;

    }
    if ([_typeLbl.text isEqualToString:@"类型" ]) {
        [self addSucessView:@"未填写货物类型" type:2];
        return;
   
    }
    if ([_varietyTextField.text isEqualToString:@""]) {
        [self addSucessView:@"未填写货物名称" type:2];
        return;

    }
    if ([_weightTextField.text isEqualToString:@""]) {
        [self addSucessView:@"未填写货物重量" type:2];
        return;

    }
    if ([_carTypeLbl.text isEqualToString:@""]) {
        [self addSucessView:@"未填写优选车型" type:2];
        return;

    }
    
    [self addWaitingView];
    int ownerOrderId=0;
    if (_model) {
        ownerOrderId=[_model.ownerOrderId intValue];
    }
    [network saveOwnerOrder:[USERMODEL.userID intValue] placeOfDepartureProvince:_provice placeOfDepartureCity:_city placeOfDepartureArea:_town placeOfDepartureAddress:_logisticsAdressView.TextField.text destinationProvince:_provice2 destinationCity:_city2 destinationArea:_town2 destinationAddress:_logisticsAdressView2.TextField.text mobile:_phoneTextField.text carTime:_carTime goodsType:goodsType goodsName:_varietyTextField.text goodsWeight:[_weightTextField.text intValue] preferredModels:preferredModels carloadingMode:zhuangcheType pattern:_zhuanghuoType section:_luduan driverNumber:_direverNumber paymentType:_payType remark:_placeholderTextView.text ownerOrderId:ownerOrderId success:^(NSDictionary *obj) {
        
        [self removeWaitingView];
        [self addSucessView:@"发布成功" type:1];
        if (self->_model) {
            
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationEditLogistics object:nil userInfo:obj];
        }
        [self back:nil];
        
    } failure:^(NSDictionary *obj2) {
        
    }];
    
    
    
}







-(void)zhuangcheAddress{
    
     [_BaseScrollView endEditing:YES];
    
    if (_view1 != nil) {
        [_view1 removeFromSuperview];
        return;
    }
    _view1=[[AddressDropView alloc]initWithFrame:CGRectMake(0, _logisticsAdressView.bottom, WindowWith, WindowHeight-_logisticsAdressView.bottom)];
    [self.view addSubview:_view1];
	__weak typeof(self)weakSelf = self;
    _view1.selectBtnBlock=^(NSString *province,NSString *city,NSString *town,NSString *street){
		__strong typeof(weakSelf)strongSelf = weakSelf;
        strongSelf->_provice = province;
        strongSelf->_city = city;
        strongSelf->_town=town;
        strongSelf->_logisticsAdressView.lbl.text=[NSString stringWithFormat:@"%@%@%@",province,city,town];
    };
    _view1.selectBlock=^(NSInteger index){
        
    };
    
    
}

-(void)arriverAddress{
     [_BaseScrollView endEditing:YES];
    
    if (_view2 != nil) {
        [_view2 removeFromSuperview];
        return;
    }
    
    _view2=[[AddressDropView alloc]initWithFrame:CGRectMake(0, _logisticsAdressView2.bottom, WindowWith, WindowHeight-_logisticsAdressView2.bottom)];
    [self.view addSubview:_view2];
	__weak typeof(self)weakSelf = self;

    _view2.selectBtnBlock=^(NSString *province,NSString *city,NSString *town,NSString *street){
		__strong typeof(weakSelf)strongSelf = weakSelf;
        strongSelf->_provice2 = province;
        strongSelf->_city2 = city;
        strongSelf->_town2=town;
        strongSelf->_logisticsAdressView2.lbl.text=[NSString stringWithFormat:@"%@%@%@",province,city,town];
    };
    _view2.selectBlock=^(NSInteger index){
        
    };

    
    
}


-(void)pushToRequirementVC{
    AdditionalRequirementViewController *vc=[[AdditionalRequirementViewController alloc]init];
    vc.ZhuanghuoType=@"";
    vc.Luduan=@"";
    vc.DireverNumber=@"";
    vc.PayType=@"";
    if (_model) {
        vc.ZhuanghuoType=_model.pattern;
        vc.Luduan=_model.section;
        vc.DireverNumber=_model.driverNumber;
        vc.PayType=_model.paymentType;
    }
    vc.selectBlock=^(NSString *str1,NSString *str2,NSString *str3,NSString *str4){
        
        self->_zhuanghuoType=str1;
        self->_luduan=str2;
        self->_direverNumber=str3;
        self->_payType=str4;
    };
    [self pushViewController:vc];
    
}

-(void)huowuType{
    __weak LogisticsFaBuViewController *weakSelf=self;
    _huowuTypeview.hidden=NO;
    _huowuTypeview.height=[_huowuTypeview setDataWith:_nerseryTypeArr];
    
    
    [weakSelf setUI:_huowuTypeview.bottom];

    
    
}

-(void)setUI:(CGFloat)y{
    
    [UIView animateWithDuration:0.1 animations:^{
		self->_huowuNameView.top=y;
		self->_huowuWeightView.top=self->_huowuNameView.bottom;
		self->_zhuangcheView.top=self->_huowuWeightView.bottom;
		self->_yongcheBtn.top=self->_zhuangcheView.bottom+7;
		self-> _carTypeView.top=self->_yongcheBtn.bottom+7;
		self->_requirementView.top=self->_carTypeView.bottom;
		self->_beizhuBtn.top=self->_requirementView.bottom+7;
		self->_textBgView.top=self->_beizhuBtn.bottom+7;
		self->_fabuBtn.top=self->_textBgView.bottom+18;
		self->_BaseScrollView.contentSize=CGSizeMake(WindowWith, self->_fabuBtn.bottom+15+64);
		
    }];

    
}



-(void)carType{
     [_BaseScrollView endEditing:YES];
    JLPickView *view=[[JLPickView alloc]initWithFrame:CGRectMake(0, WindowHeight-240, WindowWith, 240) text:@"优选车型"];
    view.citiesArray=_carTypeArr;
    view.SelectBlock=^(NSString *str1,NSString *str2){
        
        self->_carTypeLbl.text=[NSString stringWithFormat:@"%@|%@",str1,str2];
        for (NSDictionary *dic in self->_carArr) {
            if ([dic[@"carType_name"] isEqualToString:str1]) {
                NSArray *arr=dic[@"flowCarHeight"];
                for (NSDictionary *Dic in arr) {
                    if ([Dic[@"carHeight_name"] isEqualToString:str2]) {
                        self->preferredModels=[Dic[@"carType_id"] intValue];
                    }
                }
            }
        }
    };
    [self.view addSubview:view];
    

    
}



- (void)keyBoardWillShow:(NSNotification *)notification
{
    
    
    //获取键盘的相关属性(包括键盘位置,高度...)
    //NSDictionary *userInfo = notification.userInfo;
    
    //获取键盘的位置和大小
    //CGRect rect = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue /*将对象转换为CGRect结构体*/];
    
    
    //键盘升起的时候
    if ([KeybordType isEqualToString:@"textField"]) {
        [_BaseScrollView setContentOffset:CGPointMake(0, _view.top+_keybordHight-70) animated:YES];
        
    }else if ([KeybordType isEqualToString:@"textView"]){
        [_BaseScrollView setContentOffset:CGPointMake(0, _textBgView.top+_keybordHight-70) animated:YES];
    }
    
    
    
    
    
    
    
    
    
}

-(void)zhuangCheType:(UIButton *)sender{
    UIImage * img=Image(@"logistics_gou.png");
    UIImage * selectImg=Image(@"logistics_gouSelect.png");
    for (NSInteger i=0; i<2; i++) {
        UIButton *btn=[_BaseScrollView viewWithTag:3001+i];
         [btn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    }
   
     zhuangcheType=sender.titleLabel.text;
    
        [sender setImage:[selectImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    
    
    
}


- (void)keyBoardWillHide
{
    
    
    //键盘隐藏的时候
    if ([KeybordType isEqualToString:@"textField"]) {
        [_BaseScrollView setContentOffset:CGPointMake(0, _activityTextField.bottom+20) animated:YES];
        
    }else if ([KeybordType isEqualToString:@"textView"]){
         [_BaseScrollView setContentOffset:CGPointMake(0, _activityTextView.bottom+20) animated:YES];
    }

    
   
}







-(BOOL)textFieldShouldBeginEditing:(IHTextField *)textField{
     KeybordType=@"textField";
     _activityTextField=textField;
    _keybordHight=textField.top;
    return YES;
    
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    KeybordType=@"textView";
    _activityTextView=textView;
    _keybordHight=_placeholderTextView.top;
    return YES;
}


/**数据源数组 必须是指定格式: 外层数组包含pickView每一列要显示的子数组 如下bankDataSource数组**/
//- (NSArray *)bankDataSource {
//    if (!_bankDataSource) {
//        
//       
//       
//   
//    }
//      _bankDataSource = @[@[@"今天",@"明天",@"后台"],@[@"10:00",@"11:00",@"12:00",@"13:00",@"14:00"]];
//    return @[@[@"1"],@[@"2"]];
//}

-(void)timeUse{
     [_BaseScrollView endEditing:YES];
    //1,创建实例
    HKLPickerView * pickView = [[HKLPickerView alloc]init];
    //2,数据源属性赋值
  
    
    
    NSMutableArray *firstArr=[[NSMutableArray alloc]init];
    NSMutableArray *secondArr=[[NSMutableArray alloc]init];
    
    
	
    NSInteger dis = [_timeDic[@"carTime"] integerValue]; //前后的天数
    
    
    for (NSInteger i=0; i<dis; i++) {
        if (i==0) {
            [firstArr addObject:@"今天"];
        }else if (i==1){
            [firstArr addObject:@"明天"];
        }else if (i==2){
            [firstArr addObject:@"后天"];
        }else if (i>=3){
            
            
            NSDate*nowDate = [NSDate date];
            NSDate* theDate;
            
            
            NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
            
            theDate = [nowDate initWithTimeIntervalSinceNow: +oneDay*i ];
            
            NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
            
            [dateformatter setDateFormat:@"YYYY-MM-dd"];
            
            NSString *  locationString=[dateformatter stringFromDate:theDate];
            [firstArr addObject:locationString];
            
        }
        
        
        
    }
    
    if ([_timeDic[@"carTimeSpan"] isEqualToString:@"0.5"]) {
        
        for (NSInteger i=0; i<24; i++) {
            [secondArr addObject:[NSString stringWithFormat:@"%ld:00",i]];
            
            [secondArr addObject:[NSString stringWithFormat:@"%ld:30",i]];
            
            
        }
        
    }else if ([_timeDic[@"carTimeSpan"] isEqualToString:@"1"]){
        
        for (NSInteger i=0; i<24; i++) {
            [secondArr addObject:[NSString stringWithFormat:@"%ld:00",i]];
            
            
            
            
        }
        
        
    }
    
    pickView.dataSource = @[firstArr,secondArr];
    
    [pickView showCoverView];
    
    //4,可选(个性化设置,可点进入HKLPickerView.h文件，查看具体可以设置的属性)
    pickView.animationTime = 0.1;
    pickView.BackgroundAlpha = 0.1;
    pickView.screenHeightPercent = 0.3;
    
    //5,Block回调，拿到选中的内容  contents是存放选中结果的字符串数组
    [pickView setConfirmBtnClickBlock:^(NSArray * contents) {
        //self.showResultLabel.text = [NSString stringWithFormat:@"%@ %@",contents[0],contents[1]];
		self->_timeLbl.text=[NSString stringWithFormat:@"%@ | %@",contents[0],contents[1]];
        NSInteger dis = 0;
		NSString *dayString = [contents firstObject] ?: @"";
        if ([dayString isEqualToString:@"今天"]) {
            dis=0;
        } else if ([dayString isEqualToString:@"明天"]){
            dis = 1;
        } else if ([dayString isEqualToString:@"后天"]) {
            dis = 2;
        }
        NSDate*nowDate = [NSDate date];
        NSDate* theDate;
        
        
        NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
        
        theDate = [nowDate initWithTimeIntervalSinceNow: +oneDay*dis ];
        
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        
        [dateformatter setDateFormat:@"YYYY-MM-dd"];
        
        NSString *  locationString=[dateformatter stringFromDate:theDate];
        self->_carTime=[NSString stringWithFormat:@"%@ %@",locationString,contents[1]];
        if (!dis) {
        self->_carTime=[NSString stringWithFormat:@"%@ %@",contents[0],contents[1]];
        }
        
        
    }];
    
    
    
    //[IHUtility GetDayFromData:theDate];
    //or
    // theDate = [nowDate initWithTimeIntervalSinceNow: -oneDay*dis ];
    
    
  
    
    
    //3,显示
    
}


@end
