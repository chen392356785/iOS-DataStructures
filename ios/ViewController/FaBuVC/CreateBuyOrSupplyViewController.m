//
//  CreateBuyOrSupplyViewController.m
//  MiaoTuProject
//
//  Created by Mac on 16/3/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "CreateBuyOrSupplyViewController.h"
//#import "ZLPhotoActionSheet.h"

#import "JLSimplePickViewComponent.h"
@interface CreateBuyOrSupplyViewController ()<UICollectionViewDelegate,
UICollectionViewDataSource,UITextViewDelegate,JLActionSheetDelegate>
{
    ZLPhotoActionSheet *actionSheet;
    UICollectionView *_collectionView;
    NSMutableArray *imgsArray;
    BOOL isFirstAddPhoto;
    
    IHTextField *_varietyTextField;
    IHTextField *_numberTextField;
    
    IHTextField *_guanFuTextField;
    IHTextField *_ganJingTextField;
    IHTextField *_gaoDuTextField;
    PlaceholderTextView *_placeholderTextView;
    IHTextField *_priceTextField;
    IHTextField *_adressTextField;
    IHTextField *_siteTextField;
    UIView *_downView;
    IHTextField *_regionTextField;
    IHTextField *_usedRegionTextField;
    BOOL isSelectedPhoto;
    UIButton *_addBtn;
    NSInteger _addBtnCount;
    NSString *_imageUrl;
    NSMutableArray *_payArr;//付款方式
    NSMutableArray *_deepArr;//紧急程度
    NSInteger _key;
    CGFloat _keybordHight;
    UIView *_lineView2;
    UIBarButtonItem *_item1;
}
@end

@implementation CreateBuyOrSupplyViewController
@synthesize type;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *img=Image(@"redstar.png");
    UIImage *toImg=Image(@"GQ_Left.png");
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(addSupply)];
    _item1=item1;
    [item1 setTintColor:cBlackColor];
    self.navigationItem.rightBarButtonItem=item1;
    
    _BaseScrollView.backgroundColor=[UIColor whiteColor];
    
    UIView *downView=[[UIView alloc]init];
    CGFloat f=(WindowWith-80)/3;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(f, f);
    layout.sectionInset = UIEdgeInsetsMake(0, 5,0, 5);
    //layout.sectionInset.right = layout.sectionInset.right + w;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 10;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(20, 30, WindowWith-40, f+12) collectionViewLayout:layout];
    
    _collectionView.userInteractionEnabled=YES;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.scrollEnabled=NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[CreateBSCollectionViewCell class] forCellWithReuseIdentifier: @"CreateBSCollectionViewCell"];
    actionSheet = [[ZLPhotoActionSheet alloc] init];
    //设置照片最大选择数
    actionSheet.maxSelectCount = 6;
    //设置照片最大预览数
    actionSheet.maxPreviewCount = 20;
    [_BaseScrollView addSubview:_collectionView];
    
    imgsArray=[[NSMutableArray alloc]init];
//    UIImage *addImg=Image(@"fb_uploadimg.png");
//    if (self.model==nil) {
//        [imgsArray addObject:addImg];
//    }
    
    NSLog(@"imgUrl=%@",self.model.imgArray);
    for (MTPhotosModel *model in self.model.imgArray) {
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.thumbUrl]]];
        [imgsArray addObject:image];
//        [imgsArray addObject:model.thumbUrl];
    }
    [_collectionView reloadData];
    _downView=downView;
    SMLabel *photoLbl;
    UIView *photoView;
    
    downView.frame=CGRectMake(0,  _collectionView.bottom+10, WindowWith, 650);
    if (self.type==ENT_Buy) {
        [self setTitle:@"发布求购"];
        
        photoLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(20, 0, 250, 20) textColor:RGBA(189, 202, 219, 1) textFont:sysFont(14)];
        photoLbl.text=@"上传示例图片或苗木清单（最多6张)";
        [downView addSubview:photoLbl];
        
        photoView=[[UIView alloc]initWithFrame:CGRectMake(0, photoLbl.bottom+20, WindowWith, 5)];
        photoView.backgroundColor=cLineColor;
        [downView addSubview:photoView];
        [_BaseScrollView addSubview:downView];
        
    }else
    {
        photoLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0.045*WindowHeight, WindowHeight*0.035-5, 120, 20) textColor:RGBA(189, 202, 219, 1) textFont:sysFont(15)];
        photoLbl.text=@"上传苗木图片";
        [_BaseScrollView addSubview:photoLbl];
        
        _collectionView.frame=CGRectMake(20, photoLbl.bottom+10, WindowWith-40, f+12);
    }
    
    //品种
    UIImageView *varietyImgView=[[UIImageView alloc]initWithImage:img];
    if (self.type==ENT_Supply) {
        varietyImgView.frame=CGRectMake(photoLbl.left, 20, img.size.width, img.size.height);
    }else{
        varietyImgView.frame=CGRectMake(photoLbl.left, photoView.bottom+20, img.size.width, img.size.height);
    }
    
    [downView addSubview:varietyImgView];
    
    SMLabel *varietyLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(varietyImgView.right+7, varietyImgView.top-5, 60, 20) textColor:cBlackColor textFont:sysFont(15)];
    varietyLbl.text=@"品种";
    [downView addSubview:varietyLbl];
    
    UIView *varietyView=[[UIView alloc]initWithFrame:CGRectMake(varietyImgView.left, varietyLbl.bottom+10, WindowWith-varietyImgView.left*2, 1)];
    varietyView.backgroundColor=cLineColor;
    [downView addSubview:varietyView];
    
    UIImageView *varietyToImageView=[[UIImageView alloc]initWithImage:toImg];
    varietyToImageView.frame=CGRectMake(varietyView.right, varietyLbl.top+5, toImg.size.width, toImg.size.height);
    [downView addSubview:varietyToImageView];
    
    _varietyTextField=[[IHTextField alloc]initWithFrame:CGRectMake(varietyLbl.right+20, varietyLbl.top,varietyToImageView.left-varietyLbl.right-30, 25)];
    _varietyTextField.borderStyle=UITextBorderStyleNone;
    _varietyTextField.textAlignment=NSTextAlignmentRight;
    _varietyTextField.delegate=self;
    _varietyTextField.font=sysFont(15);
    _varietyTextField.placeholder=@"填入品种名称";
    
    [downView addSubview:_varietyTextField];
    
    //单价
    
    CGFloat height;
    
    UIImageView *priceImgView=[[UIImageView alloc]initWithImage:img];
    priceImgView.frame=CGRectMake(varietyImgView.left, varietyView.bottom+15, img.size.width, img.size.height);
    
    SMLabel *priceLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(priceImgView.right+7, priceImgView.top-5, 60, 20) textColor:cBlackColor textFont:sysFont(15)];
    
    priceLbl.text=@"单价";
    
    UIImageView *priceToImageView=[[UIImageView alloc]initWithImage:toImg];
    priceToImageView.frame=CGRectMake(varietyView.right, priceLbl.top+5, toImg.size.width, toImg.size.height);
    
    UIView *priceView=[[UIView alloc]initWithFrame:CGRectMake(priceImgView.left, priceLbl.bottom+10, WindowWith-priceImgView.left*2, 1)];
    priceView.backgroundColor=cLineColor;
    
    
    _priceTextField=[[IHTextField alloc]initWithFrame:CGRectMake(priceLbl.right+20, priceLbl.top-5, priceToImageView.left-priceLbl.right-30, 25)];
    _priceTextField.delegate=self;
    _priceTextField.borderStyle=UITextBorderStyleNone;
    _priceTextField.placeholder=@"0元";
    _priceTextField.font=sysFont(15);
    _priceTextField.textAlignment=NSTextAlignmentRight;
    
    height=_priceTextField.height;
    
    //数量
    
    UIImageView *numberImgView=[[UIImageView alloc]initWithImage:img];
    
    numberImgView.frame=CGRectMake(priceImgView.left, priceView.bottom+15, img.size.width, img.size.height);
    
    if (self.type==ENT_Buy) {
        numberImgView.frame=CGRectMake(varietyImgView.left, varietyView.bottom+15, img.size.width, img.size.height);
        
    }else
    {
        [downView addSubview:priceView];
        [downView addSubview:priceToImageView];
        [downView addSubview:_priceTextField];
        [downView addSubview:priceImgView];
        [downView addSubview:priceLbl];
    }
    
    [downView addSubview:numberImgView];
    
    SMLabel *numberyLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(numberImgView.right+7, numberImgView.top-5, 60, 20) textColor:cBlackColor textFont:sysFont(15)];
    
    numberyLbl.text=@"数量";
    [downView addSubview:numberyLbl];
    
    UIImageView *numberToImageView=[[UIImageView alloc]initWithImage:toImg];
    numberToImageView.frame=CGRectMake(varietyView.right, numberyLbl.top+5, toImg.size.width, toImg.size.height);
    [downView addSubview:numberToImageView];
    UIView *numberView=[[UIView alloc]initWithFrame:CGRectMake(0, numberyLbl.bottom+10, WindowWith, 5)];
    numberView.backgroundColor=cLineColor;
    [downView addSubview:numberView];
    
    _numberTextField=[[IHTextField alloc]initWithFrame:CGRectMake(numberyLbl.right+20, numberyLbl.top, numberToImageView.left-numberyLbl.right-30, 25)];
    _numberTextField.borderStyle=UITextBorderStyleNone;
    _numberTextField.placeholder=@"0";
    _numberTextField.delegate=self;
    _numberTextField.font=sysFont(15);
    _numberTextField.textAlignment=NSTextAlignmentRight;
    [downView addSubview:_numberTextField];
    
    //杆径
    
    SMLabel *ganJingLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(numberImgView.right+7, numberView.bottom+15-5, 60, 20) textColor:cBlackColor textFont:sysFont(15)];
    
    ganJingLbl.text=@"杆径";
    [downView addSubview:ganJingLbl];

    
    UIView *ganJingView=[[UIView alloc]initWithFrame:CGRectMake(numberImgView.left, ganJingLbl.bottom+10, WindowWith-numberImgView.left*2, 1)];
    ganJingView.backgroundColor=cLineColor;
    [downView addSubview:ganJingView];
    
    UIImageView *ganJingToImageView=[[UIImageView alloc]initWithImage:toImg];
    ganJingToImageView.frame=CGRectMake(ganJingView.right, ganJingLbl.top+5, toImg.size.width, toImg.size.height);
    [downView addSubview:ganJingToImageView];
    
    _ganJingTextField=[[IHTextField alloc]initWithFrame:CGRectMake(ganJingLbl.right+20, ganJingLbl.top, ganJingToImageView.left-ganJingLbl.right-30, 25)];
    _ganJingTextField.borderStyle=UITextBorderStyleNone;
    _ganJingTextField.placeholder=@"0cm";
    _ganJingTextField.textAlignment=NSTextAlignmentRight;
    _ganJingTextField.font=sysFont(15);
    _ganJingTextField.delegate=self;
    [downView addSubview:_ganJingTextField];
    
    //冠幅
    
    SMLabel *guanFuLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(numberImgView.right+7, ganJingView.bottom+15-5, 60, 20) textColor:cBlackColor textFont:sysFont(15)];
    
    guanFuLbl.text=@"冠幅";
    [downView addSubview:guanFuLbl];
    
    UIView *guanFuView=[[UIView alloc]initWithFrame:CGRectMake(numberImgView.left, guanFuLbl.bottom+10, WindowWith-numberImgView.left*2, 1)];
    guanFuView.backgroundColor=cLineColor;
    [downView addSubview:guanFuView];
    
    UIImageView *guanFuToImageView=[[UIImageView alloc]initWithImage:toImg];
    guanFuToImageView.frame=CGRectMake(guanFuView.right, guanFuLbl.top+5, toImg.size.width, toImg.size.height);
    [downView addSubview:guanFuToImageView];
    
    _guanFuTextField=[[IHTextField alloc]initWithFrame:CGRectMake(guanFuLbl.right+20, guanFuLbl.top, guanFuToImageView.left-guanFuLbl.right-30, 25)];
    _guanFuTextField.borderStyle=UITextBorderStyleNone;
    _guanFuTextField.placeholder=@"0cm-0cm";
    _guanFuTextField.textAlignment=NSTextAlignmentRight;
    _guanFuTextField.delegate=self;
    _guanFuTextField.font=sysFont(15);
    [downView addSubview:_guanFuTextField];
    
    //高度
    
    SMLabel *gaoDuLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(numberImgView.right+7, guanFuView.bottom+15-5, 60, 20) textColor:cBlackColor textFont:sysFont(15)];
    
    gaoDuLbl.text=@"高度";
    [downView addSubview:gaoDuLbl];
    UIView *gaoDuView=[[UIView alloc]initWithFrame:CGRectMake(numberImgView.left, gaoDuLbl.bottom+10, WindowWith-numberImgView.left*2, 1)];
    gaoDuView.backgroundColor=cLineColor;
    [downView addSubview:gaoDuView];
    
    UIImageView *gaoDuToImageView=[[UIImageView alloc]initWithImage:toImg];
    gaoDuToImageView.frame=CGRectMake(gaoDuView.right, gaoDuLbl.top+5, toImg.size.width, toImg.size.height);
    [downView addSubview:gaoDuToImageView];
    
    _gaoDuTextField=[[IHTextField alloc]initWithFrame:CGRectMake(gaoDuLbl.right+20, gaoDuLbl.top, gaoDuToImageView.left-gaoDuLbl.right-30, 25)];
    _gaoDuTextField.delegate=self;
    _gaoDuTextField.font=sysFont(15);
    _gaoDuTextField.borderStyle=UITextBorderStyleNone;
    _gaoDuTextField.placeholder=@"0cm-0cm";
    _gaoDuTextField.textAlignment=NSTextAlignmentRight;
    [downView addSubview:_gaoDuTextField];
    
    UIImageView *adressImgView=[[UIImageView alloc]initWithImage:img];
    adressImgView.frame=CGRectMake(gaoDuView.left, gaoDuView.bottom+15, img.size.width, img.size.height);
    // [downView addSubview:adressImgView];
    
    SMLabel *adressLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(gaoDuLbl.left, adressImgView.top-5, 80, 20) textColor:cBlackColor textFont:sysFont(15)];
    adressLbl.text=@"分枝点";
    [downView addSubview:adressLbl];
    UIView *adressView=[[UIView alloc]initWithFrame:CGRectMake(gaoDuView.left, adressLbl.bottom+10, WindowWith-adressImgView.left*2, 1)];
    adressView.backgroundColor=cLineColor;
    [downView addSubview:adressView];
    
    UIImageView *adressToImageView=[[UIImageView alloc]initWithImage:toImg];
    adressToImageView.frame=CGRectMake(adressView.right, adressLbl.top+5, toImg.size.width, toImg.size.height);
    [downView addSubview:adressToImageView];
    
    _adressTextField=[[IHTextField alloc]initWithFrame:CGRectMake(adressLbl.right+20, adressLbl.top, adressToImageView.left-adressLbl.right-30, 25)];
    _adressTextField.font=sysFont(15);
    _adressTextField.delegate=self;
    _adressTextField.borderStyle=UITextBorderStyleNone;
    _adressTextField.textAlignment=NSTextAlignmentRight;
    _adressTextField.placeholder=@"0cm";
    [downView addSubview:_adressTextField];
    
    __weak CreateBuyOrSupplyViewController *wekSelf=self;
    
    if (self.type==ENT_Supply) {
        [self setTitle:@"发布供应"];
        //上传苗木图片
        
        if (self.model==nil) {
            _collectionView.frame=CGRectMake(20, photoLbl.bottom+10, WindowWith-40, f+12);
        }
        
        UIView *photoView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 1)];
        photoView.backgroundColor=cLineColor;
        // [downView addSubview:photoView];

        //苗源所在地
        UIImageView *siteImgView=[[UIImageView alloc]initWithImage:img];
        siteImgView.frame=CGRectMake(0.045*WindowHeight, adressView.bottom+15, img.size.width, img.size.height);
        //[downView addSubview:adressImgView];
        
        SMLabel *siteLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(siteImgView.right+7, siteImgView.top-5, 90, 20) textColor:cBlackColor textFont:sysFont(15)];
        siteLbl.text=@"苗源所在地";
        [downView addSubview:siteLbl];
        
        UIView *siteView=[[UIView alloc]initWithFrame:CGRectMake(siteImgView.left, siteLbl.bottom+10, WindowWith-siteImgView.left*2, 1)];
        siteView.backgroundColor=cLineColor;
        [downView addSubview:siteView];
        
        UIImageView *siteToImageView=[[UIImageView alloc]initWithImage:toImg];
        siteToImageView.frame=CGRectMake(siteView.right, siteLbl.top, toImg.size.width, toImg.size.height);
        [downView addSubview:siteToImageView];
        
        _siteTextField=[[IHTextField alloc]initWithFrame:CGRectMake(siteLbl.right+20, siteLbl.top, siteToImageView.left-siteLbl.right-30, 25)];
        _siteTextField.font=sysFont(15);
        _siteTextField.delegate=self;
        _siteTextField.borderStyle=UITextBorderStyleNone;
        _siteTextField.textAlignment=NSTextAlignmentRight;
        _siteTextField.placeholder=@"输入苗源所在地";
        [downView addSubview:_siteTextField];
        
        //产品卖点或要求
        
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, siteView.bottom, WindowWith, 7)];
        lineView.backgroundColor=cLineColor;
        [downView addSubview:lineView];
        
        _placeholderTextView =[[PlaceholderTextView alloc]initWithFrame:CGRectMake(10, lineView.bottom, WindowWith-20, 80)];
        
        _placeholderTextView.delegate=self;
        
        _placeholderTextView.placeholder=@"描述一下你的产品的卖点";
        
        _placeholderTextView.placeholderColor=cLineColor;
        _placeholderTextView.placeholderFont=sysFont(14);
        [downView addSubview:_placeholderTextView];
        
        _lineView2=[[UIView alloc]initWithFrame:CGRectMake(0, _placeholderTextView.bottom, WindowWith, 7)];
        _lineView2.backgroundColor=cLineColor;
        _lineView2.tag=2016;
        [downView addSubview:_lineView2];
    }else{
        
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, adressView.top, WindowWith, 5)];
        lineView.backgroundColor=cLineColor;
        [downView addSubview:lineView];
        
        //紧急程度
        EditInformationView *urgentView=[[EditInformationView alloc]initWithFrame:CGRectMake(adressView.left, lineView.bottom, adressView.width, 45) name:@"紧急程度"];
        urgentView.tag=1008;
        
        
        NSDictionary *dic2=[IHUtility getUserDefalutDic:kUserDefalutInit];
        _deepArr=[[NSMutableArray alloc]initWithArray:dic2[@"urgencyLevelList"]];
        __weak NSArray *DeepArr = _deepArr;
        urgentView.selectBlock=^(NSInteger index){
            NSLog(@"紧急程度");
            [self->_activityTextField resignFirstResponder];
            NSMutableArray *arr=[[NSMutableArray alloc]init];
            for (NSDictionary *dic in DeepArr) {
                [arr addObject:dic[@"urgency_level_name"]];
            }
            [wekSelf showPicViewWithArr:arr :@"紧急程度" :21];
        };
        [downView addSubview:urgentView];
        UIView *lineView8=[[UIView alloc]initWithFrame:CGRectMake(urgentView.left, urgentView.bottom, adressView.width, 1)];
        lineView8.backgroundColor=cLineColor;
        [downView addSubview:lineView8];
        
        //付款方式
        EditInformationView *payView=[[EditInformationView alloc]initWithFrame:CGRectMake(urgentView.left, lineView8.bottom, urgentView.width, 45) name:@"付款方式"];
        payView.tag=1009;
        
        _payArr=[[NSMutableArray alloc]initWithArray:dic2[@"paymentMethodsInfoList"]];
        __weak NSArray *PayArr = _payArr;
        payView.selectBlock=^(NSInteger index){
            NSLog(@"付款方式");
            [self->_activityTextField resignFirstResponder];
            NSMutableArray *arr=[[NSMutableArray alloc]init];
            for (NSDictionary *dic in PayArr) {
                [arr addObject:dic[@"payment_methods_dictionary_name"]];
            }
            [wekSelf showPicViewWithArr:arr :@"付款方式" :22];
        };
        [downView addSubview:payView];
        UIView *lineView9=[[UIView alloc]initWithFrame:CGRectMake(payView.left, payView.bottom, adressView.width, 1)];
        lineView9.backgroundColor=cLineColor;
        [downView addSubview:lineView9];
        
        //采苗区域
        SMLabel *regionLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(adressLbl.left-5, lineView9.bottom+15, 75, 20) textColor:cBlackColor textFont:sysFont(15)];
        regionLbl.text=@"采苗区域";
        [downView addSubview:regionLbl];
        
        UIView *regionView=[[UIView alloc]initWithFrame:CGRectMake(lineView9.left, regionLbl.bottom+10, lineView9.width, 1)];
        regionView.backgroundColor=cLineColor;
        [downView addSubview:regionView];
        
        UIImageView *regionToImageView=[[UIImageView alloc]initWithImage:toImg];
        regionToImageView.frame=CGRectMake(payView.right-8, regionLbl.top+5, toImg.size.width, toImg.size.height);
        [downView addSubview:regionToImageView];
        
        _regionTextField=[[IHTextField alloc]initWithFrame:CGRectMake(regionLbl.right+20, regionLbl.top-5, regionToImageView.left-regionLbl.right-30, 25)];
        _regionTextField.delegate=self;
        _regionTextField.font=sysFont(15);
        _regionTextField.borderStyle=UITextBorderStyleNone;
        _regionTextField.textAlignment=NSTextAlignmentRight;
        _regionTextField.placeholder=@"输入采苗区域";
        [downView addSubview:_regionTextField];
        
        //用苗区域
        SMLabel *usedRegionLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(adressLbl.left-5, regionView.bottom+15, 75, 20) textColor:cBlackColor textFont:sysFont(15)];
        usedRegionLbl.text=@"用苗地点";
        [downView addSubview:usedRegionLbl];
        
        UIView *usedRegionView=[[UIView alloc]initWithFrame:CGRectMake(0, usedRegionLbl.bottom+10, WindowWith, 5)];
        usedRegionView.backgroundColor=cLineColor;
        [downView addSubview:usedRegionView];
        
        UIImageView *usedRegionToImageView=[[UIImageView alloc]initWithImage:toImg];
        usedRegionToImageView.frame=CGRectMake(regionView.right-8, usedRegionLbl.top+5, toImg.size.width, toImg.size.height);
        [downView addSubview:usedRegionToImageView];
        
        _usedRegionTextField=[[IHTextField alloc]initWithFrame:CGRectMake(usedRegionLbl.right+20, usedRegionLbl.top-5, usedRegionToImageView.left-usedRegionLbl.right-30, 25)];
        _usedRegionTextField.delegate=self;
        _usedRegionTextField.font=sysFont(15);
        _usedRegionTextField.borderStyle=UITextBorderStyleNone;
        _usedRegionTextField.textAlignment=NSTextAlignmentRight;
        _usedRegionTextField.placeholder=@"输入用苗地点";
        [downView addSubview:_usedRegionTextField];
        
        //产品卖点或要求
        
        _placeholderTextView =[[PlaceholderTextView alloc]initWithFrame:CGRectMake(10, usedRegionView.bottom, WindowWith-20, 80)];
        _placeholderTextView.placeholder=@"描述一下你的其他要求";
        _placeholderTextView.delegate=self;
        _placeholderTextView.placeholderColor=cLineColor;
        _placeholderTextView.placeholderFont=sysFont(14);
        [downView addSubview:_placeholderTextView];
        
        _lineView2=[[UIView alloc]initWithFrame:CGRectMake(0, _placeholderTextView.bottom, WindowWith, 7)];
        _lineView2.tag=2016;
        _lineView2.backgroundColor=cLineColor;
        [downView addSubview:_lineView2];
    }
    
    _addBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    _addBtn.frame=CGRectMake(0, _lineView2.bottom+15, WindowWith-80, 40);
    _addBtn.backgroundColor=cGreenColor;
    [_addBtn setTintColor:[UIColor whiteColor]];
    
    [_addBtn addTarget:self action:@selector(addSupply) forControlEvents:UIControlEventTouchUpInside];
    [_addBtn setTitle:@"发  布" forState:UIControlStateNormal];
    _addBtn.titleLabel.font=sysFont(18.8);
    [downView addSubview:_addBtn];
    _addBtn.centerX=self.view.centerX;
    _addBtn.layer.cornerRadius=21;
    _addBtn.enabled=NO;
    
    _item1.enabled=_addBtn.enabled;
    
    if (self.model ) {
        _collectionView.userInteractionEnabled=YES;
        
        _varietyTextField.text=self.model.varieties;
        _priceTextField.text=[NSString stringWithFormat:@"%.2f元",[self.model.unit_price doubleValue]];
        _numberTextField.text=[NSString stringWithFormat:@"%@株",self.model.number];
        if (self.model.rod_diameter!=0) {
            _ganJingTextField.text=[NSString stringWithFormat:@"%.2fcm",self.model.rod_diameter];
        }
        
        if (self.model.crown_width_s!=0) {
            if (self.model.crown_width_e!=0) {
                _guanFuTextField.text=[NSString stringWithFormat:@"%.2fcm-%.2fcm",self.model.crown_width_s,self.model.crown_width_e];
            }else
            {
                _guanFuTextField.text=[NSString stringWithFormat:@"%.2fcm",self.model.crown_width_s];
            }
        }
        
        if (self.model.height_s!=0) {
            if (self.model.height_e!=0) {
                _gaoDuTextField.text=[NSString stringWithFormat:@"%.2fcm-%.2fcm",self.model.height_s,self.model.height_e];
            }else
            {
                _gaoDuTextField.text=[NSString stringWithFormat:@"%.2fcm",self.model.height_s];
            }
        }
        
        if (self.model.branch_point!=0) {
            _adressTextField.text=[NSString stringWithFormat:@"%.2fcm",self.model.branch_point];
        }
        
        if (![self.model.seedling_source_address isEqualToString:@""]) {
            _siteTextField.text=self.model.seedling_source_address;
        }
        
        if (![self.model.selling_point isEqualToString:@""]) {
            _placeholderTextView.text=self.model.selling_point;
            _placeholderTextView.placeholder=@"";
        }
        
        if (![self.model.mining_area isEqualToString:@""]) {
            _regionTextField.text=self.model.mining_area;
        }
        
        if (![self.model.use_mining_area isEqualToString:@""]) {
            _usedRegionTextField.text=self.model.use_mining_area;
        }
        
        EditInformationView *urgentView=[_downView viewWithTag:1008];
        if (self.model.urgency_level_id!=0) {
            
            for (NSDictionary *obj in _deepArr) {
                if (self.model.urgency_level_id==obj[@"urgency_level_id"]) {
                    urgentView.lbl.text=obj[@"urgency_level_name"];
                }
            }
        }
        
        EditInformationView *payView=[_downView viewWithTag:1009];
        if (self.model.payment_methods_dictionary_id!=0) {
            
            for (NSDictionary *obj in _payArr) {
                if (self.model.payment_methods_dictionary_id==obj[@"payment_methods_dictionary_id"]) {
                    payView.lbl.text=obj[@"payment_methods_dictionary_name"];
                }
            }
        }
    }
    [self setBaseScrollHeigh:imgsArray];
    
    //  NSLog(@"%f",btn.bottom);
    
    [_BaseScrollView addSubview:downView];
    
    // Do any additional setup after loading the view.
    
    //监听键盘的升起和隐藏事件,需要用到通知中心  *****IQkeymanage冲突
//    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
//    [center addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    //监听隐藏:UIKeyboardWillHideNotification
//    [center addObserver:self selector:@selector(keyBoardWillHide) name:UIKeyboardWillHideNotification object:nil];
}

-(void)showPicViewWithArr:(NSArray *)arr :(NSString *)title :(NSInteger)tag
{
    [_BaseScrollView endEditing:YES];
    JLSimplePickViewComponent *pickView =(JLSimplePickViewComponent*)[self.view viewWithTag:tag];
    if(pickView == nil)
    {
        
        pickView = [[JLSimplePickViewComponent alloc] initWithParams:title withData:arr];
        pickView.tag=tag;
        pickView.ActionSheetDelegate = self;
    }
    [pickView show];
    
}

-(void)ActionSheetDoneHandle:(JLSimplePickViewComponent*)pickViewComponent selectedData:(NSString *)SelectedStr
{
    if (pickViewComponent.tag==21) {
        NSLog(@"%@",SelectedStr);
        EditInformationView *urgentView=[_downView viewWithTag:1008];
        urgentView.lbl.text=SelectedStr;
    }
    if (pickViewComponent.tag==22) {
        NSLog(@"%@",SelectedStr);
        EditInformationView *urgentView=[_downView viewWithTag:1009];
        urgentView.lbl.text=SelectedStr;
    }
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    _keybordHight=_placeholderTextView.top;
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (_addBtn.enabled) {
        return;
    }
    
    if (self.type==ENT_Supply) {
        
        if (_varietyTextField.text.length>0&&_priceTextField.text.length>0&&_numberTextField.text.length>0) {
            _addBtn.enabled=YES;
            _item1.enabled=_addBtn.enabled;
        }
        
    }else if (self.type==ENT_Buy)
    {
        
        if (_varietyTextField.text.length>0&&_numberTextField.text.length>0) {
            _addBtn.enabled=YES;
            _item1.enabled=_addBtn.enabled;
        }
    }
}

- (BOOL)textFieldShouldBeginEditing:(IHTextField *)textField {
    
    KeybordView *keybordView=[[KeybordView alloc]initWith];
    __weak KeybordView *weakView=keybordView;
    
    _activityTextField=textField;
    
    if (_varietyTextField==textField) {
        
        _keybordHight=_varietyTextField.top;
        return YES;
    }
    if (_regionTextField==textField) {
        
        _keybordHight=_regionTextField.top;
        return YES;
    }
    if (_usedRegionTextField==textField) {
        
        _keybordHight=_usedRegionTextField.top;
        return YES;
    }
    if (_siteTextField==textField) {
        
        _keybordHight=_siteTextField.top;
        return YES;
    }
    
    [textField resignFirstResponder];
    textField.inputAccessoryView.hidden=YES;
    
    if (_gaoDuTextField ==textField) {
        [textField resignFirstResponder];
        
        [keybordView creatViewWiyhType:ENT_gaoDu];
        keybordView.block=^(NSString *String){
            weakView.block2=^(NSString *String2){
                if (![String2 isEqualToString:@""]) {
                    self->_gaoDuTextField.text=[NSString stringWithFormat:@"%@cm-%@cm",String,String2];
                }else
                {
                    self->_gaoDuTextField.text=[NSString stringWithFormat:@"%@cm",String];
                }
                
                if (self.type==ENT_Supply) {
					if (self->_varietyTextField.text.length>0&&self->_priceTextField.text.length>0&&self->_numberTextField.text.length>0) {
                        self->_addBtn.enabled=YES;
						self->_item1.enabled=self->_addBtn.enabled;
                    }
                    
                }else
                {
					if (self->_varietyTextField.text.length>0&&self->_numberTextField.text.length>0) {
                        self->_addBtn.enabled=YES;
						self->_item1.enabled=self->_addBtn.enabled;
                    }
                }
            };
        };
        
        [self.view addSubview:keybordView];
    }
    if (_priceTextField ==textField) {
        [textField resignFirstResponder];
        [keybordView creatViewWiyhType:ENT_price];
        keybordView.block=^(NSString *String) {
            self->_priceTextField.text=[NSString stringWithFormat:@"%.2f元",[String doubleValue]];
            if (self.type==ENT_Supply) {
				if (self->_varietyTextField.text.length>0&&self->_priceTextField.text.length>0&&self->_numberTextField.text.length>0) {
                    self->_addBtn.enabled=YES;
					self->_item1.enabled=self->_addBtn.enabled;
                }
                
            }else
            {
                if (self->_varietyTextField.text.length>0&&self->_numberTextField.text.length>0) {
                    self->_addBtn.enabled=YES;
                    self->_item1.enabled= self->_addBtn.enabled;
                }
            }
        };
        
        [self.view addSubview:keybordView];
    }
    if (_numberTextField ==textField) {
        [textField resignFirstResponder];
        [keybordView creatViewWiyhType:ENT_number];
        keybordView.block=^(NSString *String) {
            self->_numberTextField.text=[NSString stringWithFormat:@"%@株",String];
            if (self.type==ENT_Supply) {
                if (self->_varietyTextField.text.length>0&&self->_priceTextField.text.length>0&&self->_numberTextField.text.length>0) {
                    self->_addBtn.enabled=YES;
                   self-> _item1.enabled=self->_addBtn.enabled;
                }
                
            }else
            {
                if (self->_varietyTextField.text.length>0&&self->_numberTextField.text.length>0) {
                    self->_addBtn.enabled=YES;
                    self->_item1.enabled=self->_addBtn.enabled;
                }
            }
        };
        [self.view addSubview:keybordView];
    }
    if (_ganJingTextField ==textField) {
        [textField resignFirstResponder];
        [keybordView creatViewWiyhType:ENT_ganJing];
        keybordView.block=^(NSString *String) {
            self->_ganJingTextField.text=[NSString stringWithFormat:@"%@cm",String];
            if (self.type==ENT_Supply) {
                if (self->_varietyTextField.text.length>0&&self->_priceTextField.text.length>0&&self->_numberTextField.text.length>0) {
                    self->_addBtn.enabled=YES;
                    self->_item1.enabled=self->_addBtn.enabled;
                }
            }else
            {
                if (self->_varietyTextField.text.length>0&&self->_numberTextField.text.length>0) {
                    self->_addBtn.enabled=YES;
                    self->_item1.enabled=self->_addBtn.enabled;
                }
            }
        };
        [self.view addSubview:keybordView];
    }
    if (_guanFuTextField ==textField) {
        [textField resignFirstResponder];
        [keybordView creatViewWiyhType:ENT_guanFu];
        keybordView.block=^(NSString *String){
            weakView.block2=^(NSString *String2){
                
                if (![String2 isEqualToString:@""]) {
                    self->_guanFuTextField.text=[NSString stringWithFormat:@"%@cm-%@cm",String,String2];
                }else
                {
                    self->_guanFuTextField.text=[NSString stringWithFormat:@"%@cm",String];
                    
                }
                
                if (self.type==ENT_Supply) {
                    if (self->_varietyTextField.text.length>0&&self->_priceTextField.text.length>0&&self->_numberTextField.text.length>0) {
                       self->_addBtn.enabled=YES;
						self->_item1.enabled=self->_addBtn.enabled;
                    }
                }else
                {
                    if (self->_varietyTextField.text.length>0&&self->_numberTextField.text.length>0) {
                        self->_addBtn.enabled=YES;
                        self->_item1.enabled=self->_addBtn.enabled;
                    }
                }
            };
        };
        
        [self.view addSubview:keybordView];
    }
    if (_adressTextField==textField) {
        
        [textField resignFirstResponder];
        [keybordView creatViewWiyhType:ENT_adress];
        keybordView.block=^(NSString *String) {
            self->_adressTextField.text=[NSString stringWithFormat:@"%@cm",String];
            
            if (self.type==ENT_Supply) {
                if (self->_varietyTextField.text.length>0&&self->_priceTextField.text.length>0&&self->_numberTextField.text.length>0) {
                    self->_addBtn.enabled=YES;
                    self->_item1.enabled=self->_addBtn.enabled;
                }
                
            }else
            {
                if (self->_varietyTextField.text.length>0&&self->_numberTextField.text.length>0) {
                    self->_addBtn.enabled=YES;
                    self->_item1.enabled=self->_addBtn.enabled;
                }
            }
        };
        [self.view addSubview:keybordView];
    }
    
    [_downView endEditing:YES];

    return NO;
}

//发布供应
-(void)addSupply
{
    if (self.type==ENT_Supply) {
        
        if ([_varietyTextField.text isEqualToString:@""]) {
            [self addSucessView:@"未填写品种名" type:2];
            return;
        }
        if ([_numberTextField.text isEqualToString:@""]) {
            [self addSucessView:@"未填写数量" type:2];
            return;
        }
        if ([_priceTextField.text isEqualToString:@""]) {
            [self addSucessView:@"未填写单价" type:2];
            return;
        }
        
        if (self.model==nil) {
            UIImage *addimg=Image(@"fb_uploadimg.png");
            NSData *data = UIImagePNGRepresentation(addimg);
            for (int i=0; i<imgsArray.count; i++) {
                UIImage *imgA=[imgsArray objectAtIndex:i];
                NSData *data1 = UIImagePNGRepresentation(imgA);
                
                if ([data isEqual:data1]) {
                    [imgsArray removeObject:imgA];
                }
            }
        }
        
        //数量
        NSRange numberRange = [_numberTextField.text rangeOfString:@"株"];
        NSMutableString *number=[[NSMutableString alloc]init];
        [number appendString:_numberTextField.text];
        [number deleteCharactersInRange:numberRange];
        //单价
        NSRange priceRange = [_priceTextField.text rangeOfString:@"元"];
        NSMutableString *price=[[NSMutableString alloc]init];
        [price appendString:_priceTextField.text];
        [price deleteCharactersInRange:priceRange];
        
        //分枝点
        NSMutableString *point=[[NSMutableString alloc]init];
        [point appendString:_adressTextField.text];
        if (_adressTextField.text.length>0) {
            if (![_adressTextField.text isEqualToString:@""]) {
                NSRange pointRange = [_adressTextField.text rangeOfString:@"cm"];
                [point deleteCharactersInRange:pointRange];
            }
        }
        
        //杆径
        NSRange ganjingRange = [_ganJingTextField.text rangeOfString:@"cm"];
        NSMutableString *ganjing=[[NSMutableString alloc]init];
        if (_ganJingTextField.text.length>0) {
            [ganjing appendString:_ganJingTextField.text];
            [ganjing deleteCharactersInRange:ganjingRange];
        }
        
        //冠幅
        //找出-第一次出现的位置
        
        NSMutableString *guanFu=[[NSMutableString alloc]init];
        [guanFu appendString:_guanFuTextField.text];
        NSRange range2 = [guanFu rangeOfString:@"-"];
        NSString *guanFuFrom;
        NSString *guanFuTo;
        //如果找不到
        if (![_guanFuTextField.text isEqualToString:@""]) {
            if (range2.location == NSNotFound)
            {
                NSLog(@"没找着");
                NSRange guanFuRange = [_guanFuTextField.text rangeOfString:@"cm"];
                [guanFu deleteCharactersInRange:guanFuRange];
                guanFuFrom=guanFu;
                guanFuTo=@"";
            }
            else
            {
                NSArray *result=[guanFu componentsSeparatedByString:@"-"];
                for (NSInteger i=0; i<result.count; i++) {
                    if (i==0) {
                        NSMutableString *str=[[NSMutableString alloc]init];
                        [str appendString:result[i]];
                        NSRange guanFuRange = [str rangeOfString:@"cm"];
                        [str deleteCharactersInRange:guanFuRange];
                        guanFuFrom=str;
                        
                    }else
                    {
                        NSMutableString *str=[[NSMutableString alloc]init];
                        [str appendString:result[i]];
                        NSRange guanFuRange = [str rangeOfString:@"cm"];
                        [str deleteCharactersInRange:guanFuRange];
                        guanFuTo=str;
                    }
                }
            }
        }else
        {
            guanFuFrom=@"";
            guanFuTo=@"";
        }
        
        NSLog(@"guanFuFrom=%@,guanFuTo=%@",guanFuFrom,guanFuTo);
        
        //高度
        NSMutableString *gaoDu=[[NSMutableString alloc]init];
        [gaoDu appendString:_gaoDuTextField.text];
        NSLog(@"-----%@",_gaoDuTextField.text);
        NSRange range3 = [guanFu rangeOfString:@"-"];
        NSString *gaoDuFrom;
        NSString *gaoDuTo;
        if (_gaoDuTextField.text.length>0) {
            if (range3.location == NSNotFound)
            {
                NSLog(@"没找着");
                NSRange gaoDuRange = [_gaoDuTextField.text rangeOfString:@"cm"];
                [gaoDu deleteCharactersInRange:gaoDuRange];
                gaoDuFrom=gaoDu;
                gaoDuTo=@"";
            }
            else
            {
                NSArray *result=[gaoDu componentsSeparatedByString:@"-"];
                for (NSInteger i=0; i<result.count; i++) {
                    if (i==0) {
                        NSMutableString *str=[[NSMutableString alloc]init];
                        [str appendString:result[i]];
                        NSRange gaoDuRange = [str rangeOfString:@"cm"];
                        [str deleteCharactersInRange:gaoDuRange];
                        
                        gaoDuFrom=str;
                        
                    }else
                    {
                        NSMutableString *str=[[NSMutableString alloc]init];
                        [str appendString:result[i]];
                        NSRange gaoDuRange = [str rangeOfString:@"cm"];
                        [str deleteCharactersInRange:gaoDuRange];
                        
                        gaoDuTo=str;
                    }
                }
            }
        }else
        {
            gaoDuFrom=@"";
            gaoDuTo=@"";
        }
        
        NSLog(@"gaoDrom=%@,guanFuTo=%@",gaoDuFrom,gaoDuTo);
        
        NSLog(@"userid=%@  %@  %@  %@",gaoDuFrom,gaoDuTo ,guanFuFrom,guanFuTo);
        
        if (self.model!=nil) {
            [self addWaitingView];
            if (imgsArray.count>0) {
                [AliyunUpload uploadImage:imgsArray FileDirectory:ENT_fileImageBody success:^(NSString *obj) {
                    
					[network getUpdateSupplyInfo:[USERMODEL.userID intValue] supply_id:[self.model.supply_id intValue]number:[number integerValue] price:[price doubleValue] point:[point doubleValue]diameter:[ganjing doubleValue] width_s:[guanFuFrom doubleValue]width_e:[guanFuTo doubleValue] height_s:[gaoDuFrom doubleValue] height_e:[gaoDuTo doubleValue] varieties:self->_varietyTextField.text selling:self->_placeholderTextView.text seedling:self->_siteTextField.text supply_url:obj address:[NSString stringWithFormat:@"%@ %@",[ConfigManager returnString:USERMODEL.province],[ConfigManager returnString:USERMODEL.city]]  success:^(NSDictionary *obj) {
                        
                        [network getSupplyDetailID:USERMODEL.userID supply_id:self.model.supply_id success:^(NSDictionary *obj) {
                            
                            NSDictionary *dic2=obj[@"content"];
                            NSDictionary *NumDic = obj[@"errorContent"];
                            NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:dic2,@"content",@"2",@"type",NumDic,@"errorContent", nil];
                            [[NSNotificationCenter defaultCenter]postNotificationName:NotificationAddSupplyBuyTopic object:dictionary];
                            
                            //                        MTSupplyAndBuyListModel *model=[network getSupplyAndBuyForDic:obj[@"content"] type:IH_QuerySupplyList];
                            //                        if (self.ifEdit) {
                            //                            self.selectEditBlock(model);
                            //                        }
                            [self commit];
                        } failure:^(NSDictionary *obj2) {
                            
                        }];
                        
                    }];
                }];
            }else
            {
                [network getUpdateSupplyInfo:[USERMODEL.userID intValue] supply_id:[self.model.supply_id intValue]number:[number integerValue] price:[price doubleValue] point:[point doubleValue]diameter:[ganjing doubleValue] width_s:[guanFuFrom doubleValue]width_e:[guanFuTo doubleValue] height_s:[gaoDuFrom doubleValue] height_e:[gaoDuTo doubleValue] varieties:_varietyTextField.text selling:_placeholderTextView.text seedling:_siteTextField.text supply_url:@"" address:[NSString stringWithFormat:@"%@ %@",[ConfigManager returnString:USERMODEL.province],[ConfigManager returnString:USERMODEL.city]]  success:^(NSDictionary *obj) {
                    
//                    NSDictionary *dic2=obj[@"content"];
//                    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:dic2,@"content",@"2",@"type", nil];
//                    [[NSNotificationCenter defaultCenter]postNotificationName:NotificationAddSupplyBuyTopic object:dictionary];
                    
                    //                        MTSupplyAndBuyListModel *model=[network getSupplyAndBuyForDic:obj[@"content"] type:IH_QuerySupplyList];
                    //                        if (self.ifEdit) {
                    //                            self.selectEditBlock(model);
                    //                        }
                    [self commit];
                    
                }];
            }
           
        }else
        {
            [self addWaitingView];
            if (imgsArray.count>0) {
                
                [AliyunUpload uploadImage:imgsArray FileDirectory:ENT_fileImageBody success:^(NSString *obj) {
                    
					[network getAddSupplyInfo:[USERMODEL.userID intValue] number:[number integerValue] price:[price doubleValue] point:[point doubleValue]diameter:[ganjing doubleValue] width_s:[guanFuFrom doubleValue]width_e:[guanFuTo doubleValue] height_s:[gaoDuFrom doubleValue] height_e:[gaoDuTo doubleValue] varieties:self->_varietyTextField.text selling:self->_placeholderTextView.text seedling:self->_siteTextField.text supply_url:obj address:[NSString stringWithFormat:@"%@ %@",[ConfigManager returnString:USERMODEL.province],[ConfigManager returnString:USERMODEL.city]]success:^(NSDictionary *obj) {
                        
                        NSDictionary *dic2=obj[@"content"];
                        NSDictionary *NumDic = obj[@"errorContent"];
                        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:dic2,@"content",@"1",@"type",NumDic,@"errorContent", nil];
                        
                        [[NSNotificationCenter defaultCenter]postNotificationName:NotificationAddSupplyBuyTopic object:dictionary];
                        [self commit];
                    }];
                }];
            }else
            {
                [network getAddSupplyInfo:[USERMODEL.userID intValue] number:[number integerValue] price:[price integerValue] point:[point doubleValue]diameter:[ganjing doubleValue] width_s:[guanFuFrom doubleValue]width_e:[guanFuTo doubleValue] height_s:[gaoDuFrom doubleValue] height_e:[gaoDuTo doubleValue] varieties:_varietyTextField.text selling:_placeholderTextView.text seedling:_siteTextField.text supply_url:@"" address:[NSString stringWithFormat:@"%@ %@",[ConfigManager returnString:USERMODEL.province],[ConfigManager returnString:USERMODEL.city]]success:^(NSDictionary *obj) {
                    
                    NSDictionary *dic2=obj[@"content"];
                    NSDictionary *NumDic = obj[@"errorContent"];
                    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:dic2,@"content",@"1",@"type",NumDic,@"errorContent", nil];
                    [[NSNotificationCenter defaultCenter]postNotificationName:NotificationAddSupplyBuyTopic object:dictionary];
                    [self commit];
                }];
            }
        }
    }else
    {
        if ([_varietyTextField.text isEqualToString:@""]) {
            [self addSucessView:@"未填写品种名" type:2];
            return;
        }
        if ([_numberTextField.text isEqualToString:@""]) {
            [self addSucessView:@"未填写数量" type:2];
            return;
        }
        
        UIImage *addimg=Image(@"fb_uploadimg.png");
        NSData *data = UIImagePNGRepresentation(addimg);
        if (self.model==nil) {
            for (int i=0; i<imgsArray.count; i++) {
                UIImage *imgA=[imgsArray objectAtIndex:i];
                NSData *data1 = UIImagePNGRepresentation(imgA);
                if (i==0) {
                    if ([data1 isEqual:data]) {
                        
                    }
                    else
                    {
                        
                    }
                    
                }
                if ([data isEqual:data1]) {
                    [imgsArray removeObject:imgA];
                }
            }
        }
        //分枝点
        NSMutableString *point=[[NSMutableString alloc]init];
        [point appendString:_adressTextField.text];
        if (![_adressTextField.text isEqualToString:@""]) {
            if (![_adressTextField.text isEqualToString:@""]) {
                NSRange pointRange = [_adressTextField.text rangeOfString:@"cm"];
                [point deleteCharactersInRange:pointRange];
            }
        }
        //杆径
        NSRange ganjingRange = [_ganJingTextField.text rangeOfString:@"cm"];
        NSMutableString *ganjing=[[NSMutableString alloc]init];
        [ganjing appendString:_ganJingTextField.text];
        if (_ganJingTextField.text.length>0) {
            
            [ganjing deleteCharactersInRange:ganjingRange];
        }
        //冠幅
        //找出-第一次出现的位置
        
        NSMutableString *guanFu=[[NSMutableString alloc]init];
        [guanFu appendString:_guanFuTextField.text];
        NSRange range2 = [guanFu rangeOfString:@"-"];
        NSString *guanFuFrom=@"";
        NSString *guanFuTo=@"";
        if (![_guanFuTextField.text isEqualToString:@""]) {
            //如果找不到
            if (range2.location == NSNotFound)
            {
                NSLog(@"没找着");
                NSRange guanFuRange = [_guanFuTextField.text rangeOfString:@"cm"];
                [guanFu deleteCharactersInRange:guanFuRange];
                guanFuFrom=guanFu;
                guanFuTo=@"";
            }
            else
            {
                NSArray *result=[guanFu componentsSeparatedByString:@"-"];
                for (NSInteger i=0; i<result.count; i++) {
                    if (i==0) {
                        NSMutableString *str=[[NSMutableString alloc]init];
                        [str appendString:result[i]];
                        NSRange guanFuRange = [str rangeOfString:@"cm"];
                        [str deleteCharactersInRange:guanFuRange];
                        guanFuFrom=str;
                        
                    }else
                    {
                        NSMutableString *str=[[NSMutableString alloc]init];
                        [str appendString:result[i]];
                        NSRange guanFuRange = [str rangeOfString:@"cm"];
                        [str deleteCharactersInRange:guanFuRange];
                        guanFuTo=str;
                    }
                }
            }
        }
        //高度
        NSMutableString *gaoDu=[[NSMutableString alloc]init];
        [gaoDu appendString:_gaoDuTextField.text];
        NSRange range3 = [gaoDu rangeOfString:@"-"];
        NSString *gaoDuFrom=@"";
        NSString *gaoDuTo=@"";
        
        if (![_gaoDuTextField.text isEqualToString:@""]) {
            if (range3.location == NSNotFound)
            {
                NSLog(@"没找着");
                NSRange gaoDuRange = [_gaoDuTextField.text rangeOfString:@"cm"];
                [gaoDu deleteCharactersInRange:gaoDuRange];
                gaoDuFrom=gaoDu;
                gaoDuTo=@"";
            }
            else
            {
                NSArray *result=[gaoDu componentsSeparatedByString:@"-"];
                for (NSInteger i=0; i<result.count; i++) {
                    if (i==0) {
                        NSMutableString *str=[[NSMutableString alloc]init];
                        [str appendString:result[i]];
                        NSRange guanFuRange = [str rangeOfString:@"cm"];
                        [str deleteCharactersInRange:guanFuRange];
                        gaoDuFrom=str;
                        
                    }else
                    {
                        NSMutableString *str=[[NSMutableString alloc]init];
                        [str appendString:result[i]];
                        NSRange guanFuRange = [str rangeOfString:@"cm"];
                        [str deleteCharactersInRange:guanFuRange];
                        gaoDuTo=str;
                    }
                }
            }
        }
        //紧急程度
        EditInformationView *deep=[self.view viewWithTag:1008];
        NSInteger deepInter =0;
        for (NSDictionary *obj in _deepArr) {
            if ([deep.lbl.text isEqualToString:obj[@"urgency_level_name"]]) {
                deepInter=[obj[@"urgency_level_id"] integerValue];
            }
        }
        
        //付款方式
        EditInformationView *pay=[self.view viewWithTag:1009];
        NSInteger payInter=0;
        for (NSDictionary *obj in _payArr) {
            if ([pay.lbl.text isEqualToString:obj[@"payment_methods_dictionary_name"]]) {
                payInter=[obj[@"payment_methods_dictionary_id"] integerValue];
            }
        }
        
        if (self.model!=nil) {
            [self addWaitingView];
            if (imgsArray.count > 0) {
                [AliyunUpload uploadImage:imgsArray FileDirectory:ENT_fileImageBody success:^(NSString *obj) {
                    
					[network getUpdateBuyInfo:[USERMODEL.userID intValue]number:[self->_numberTextField.text integerValue]  want_buy_id:[self.model.want_buy_id intValue]  point:[point doubleValue] diameter:[ganjing doubleValue] width_s:[guanFuFrom doubleValue]width_e:[guanFuTo doubleValue] height_s:[gaoDuFrom doubleValue] height_e:[gaoDuTo doubleValue] varieties:self->_varietyTextField.text selling:self->_placeholderTextView.text payment_methods_dictionary_id:(long)payInter use_mining_area:self->_usedRegionTextField.text mining_area:self->_regionTextField.text urgency_level_id:(long)deepInter want_buy_url:obj address:[NSString stringWithFormat:@"%@ %@",[ConfigManager returnString:USERMODEL.province],[ConfigManager returnString:USERMODEL.city]]success:^(NSDictionary *obj) {
                        
                        [network getBuyDetailID:USERMODEL.userID want_buy_id:self.model.want_buy_id success:^(NSDictionary *obj) {
                            
                            NSDictionary *dic2=obj[@"content"];
                            NSDictionary *NumDic = obj[@"errorContent"];
                            NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:dic2,@"content",@"2",@"type",NumDic,@"errorContent", nil];
                            [[NSNotificationCenter defaultCenter]postNotificationName:NotificationAddSupplyBuyTopic object:dictionary];
                            //                    MTSupplyAndBuyListModel *model=[network getSupplyAndBuyForDic:obj[@"content"] type:IH_QuerySupplyList];
                            //                    if (self.ifEdit) {
                            //                        self.selectEditBlock(model);
                            //                    }
                            [self commit];
                        } failure:^(NSDictionary *obj2) {
                            
                        }];
                        
                    }];
                }];
            }else {
                [network getUpdateBuyInfo:[USERMODEL.userID intValue]number:[_numberTextField.text integerValue]  want_buy_id:[self.model.want_buy_id intValue]  point:[point doubleValue] diameter:[ganjing doubleValue] width_s:[guanFuFrom doubleValue]width_e:[guanFuTo doubleValue] height_s:[gaoDuFrom doubleValue] height_e:[gaoDuTo doubleValue] varieties:_varietyTextField.text selling:_placeholderTextView.text payment_methods_dictionary_id:(long)payInter use_mining_area:_usedRegionTextField.text mining_area:_regionTextField.text urgency_level_id:(long)deepInter want_buy_url:@"" address:[NSString stringWithFormat:@"%@ %@",[ConfigManager returnString:USERMODEL.province],[ConfigManager returnString:USERMODEL.city]]success:^(NSDictionary *obj) {
                    
//                    NSDictionary *dic2=obj[@"content"];
//                    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:dic2,@"content",@"2",@"type", nil];
//                    [[NSNotificationCenter defaultCenter]postNotificationName:NotificationAddSupplyBuyTopic object:dictionary];
                    //                    MTSupplyAndBuyListModel *model=[network getSupplyAndBuyForDic:obj[@"content"] type:IH_QuerySupplyList];
                    //                    if (self.ifEdit) {
                    //                        self.selectEditBlock(model);
                    //                    }
                    [self commit];
                    
                }];
            }
            
        }else
        {
            [self addWaitingView];
            if (imgsArray.count>0) {
                [AliyunUpload uploadImage:imgsArray FileDirectory:ENT_fileImageBody success:^(NSString *obj) {
					[network getAddBuyInfo:[USERMODEL.userID intValue]number:[self->_numberTextField.text integerValue]  point:[point doubleValue] diameter:[ganjing doubleValue] width_s:[guanFuFrom doubleValue]width_e:[guanFuTo doubleValue] height_s:[gaoDuFrom doubleValue] height_e:[gaoDuTo doubleValue] varieties:self->_varietyTextField.text selling:self->_placeholderTextView.text payment_methods_dictionary_id:(long)payInter use_mining_area:self->_usedRegionTextField.text mining_area:self->_regionTextField.text urgency_level_id:(long)deepInter want_buy_url:obj address:[NSString stringWithFormat:@"%@ %@",[ConfigManager returnString:USERMODEL.province],[ConfigManager returnString:USERMODEL.city]]success:^(NSDictionary *obj) {
                        NSDictionary *dic2=obj[@"content"];
                        NSDictionary *NumDic = obj[@"errorContent"];
                        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:dic2,@"content",@"2",@"type",NumDic,@"errorContent", nil];
                        
                        [[NSNotificationCenter defaultCenter]postNotificationName:NotificationAddSupplyBuyTopic object:dictionary];
                        [self commit];
                    }];
                }];
            }else{
                [network getAddBuyInfo:[USERMODEL.userID intValue]
                                number:[_numberTextField.text integerValue]
                                 point:[point doubleValue]
                              diameter:[ganjing doubleValue]
                               width_s:[guanFuFrom doubleValue]
                               width_e:[guanFuTo doubleValue]
                              height_s:[gaoDuFrom doubleValue]
                              height_e:[gaoDuTo doubleValue]
                             varieties:_varietyTextField.text
                               selling:_placeholderTextView.text
         payment_methods_dictionary_id:(long)payInter
                       use_mining_area:_usedRegionTextField.text
                           mining_area:_regionTextField.text
                      urgency_level_id:(long)deepInter
                          want_buy_url:nil
                               address:[NSString stringWithFormat:@"%@ %@",[ConfigManager returnString:USERMODEL.province],[ConfigManager returnString:USERMODEL.city]]success:^(NSDictionary *obj) {
                                   
                                   NSDictionary *dic2=obj[@"content"];
                                   NSDictionary *NumDic = obj[@"errorContent"];
                                   NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:dic2,@"content",@"2",@"type",NumDic,@"errorContent", nil];
                                   
                                   [[NSNotificationCenter defaultCenter]postNotificationName:NotificationAddSupplyBuyTopic object:dictionary];
                                   
                                   [self commit];
                               }];
            }
        }
    }
}

-(void)commit{
    if (!self.ifEdit) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationChangeTabBarSelectedIndex object:[NSNumber numberWithInt:1]];
    }
    
    [self removeWaitingView];
    [self addSucessView:@"发布成功" type:1];
    
    
    
    if (self.presentingViewController) {
        //判断1
        [self dismissViewControllerAnimated:YES completion:nil];
    } else if ([self.navigationController respondsToSelector:@selector(popViewControllerAnimated:)]) {
        //判断2
        [self popViewController:0];
    }
    return;
}

- (void)btnSelectPhoto_Click:(id)sender
{
    
    _addBtn.enabled=YES;
    
    [_BaseScrollView endEditing:YES];
    
    [actionSheet showWithSender:self animate:YES completion:^(NSArray<UIImage *> * _Nonnull selectPhotos) {
        for (int i=0; i<selectPhotos.count; i++) {
            UIImage *img2 = [selectPhotos objectAtIndex:i];
            if (!self->isFirstAddPhoto) {
                if (self.model == nil) {
                    [self->imgsArray removeAllObjects];
                }
                [self->imgsArray addObject:img2];
                self->isFirstAddPhoto=YES;
            }else{
                [self->imgsArray addObject:img2];
            }
        }
        if (self->imgsArray.count>=6) {
            NSMutableArray *arr2=[[NSMutableArray alloc]init];
            for (int i=0; i<6; i++) {
                [arr2 addObject:[self->imgsArray objectAtIndex:i]];
            }
            [self->imgsArray removeAllObjects];
            [self->imgsArray addObjectsFromArray:arr2];
            //            UIImage *addimg=Image(@"fb_uploadimg.png");
            //            [imgsArray addObject:addimg];
        }
        
        [self->_collectionView reloadData];
        [self setBaseScrollHeigh:self->imgsArray];
    }];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.ifEdit) {
        [self setHomeTabBarHidden:NO];
    }
}

-(void)back:(id)sender{
	if (self.presentingViewController) {
		//判断1
		[self dismissViewControllerAnimated:YES completion:nil];
	} else if ([self.navigationController respondsToSelector:@selector(popViewControllerAnimated:)]) {
		//判断2
		[self.navigationController popViewControllerAnimated:YES];
	}
}

#pragma mark - collection数据源代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (imgsArray.count >= 6) {
        return imgsArray.count;
    }
    return imgsArray.count + 1;
}

-(NSInteger)numberOfSectionsInCollectionView:
(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CreateBSCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CreateBSCollectionViewCell" forIndexPath:indexPath];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapProfileImage:)];
    singleTap.numberOfTapsRequired = 1;
    cell.m_imgView.userInteractionEnabled = YES;
    [cell.m_imgView  addGestureRecognizer:singleTap];
    cell.deleteBtn.tag = [indexPath row];
    if ([indexPath row] != (imgsArray.count)){
        [cell.deleteBtn setHidden:NO];
    }
    else {
        if (imgsArray.count == 6) {
            UIImage *addimg=Image(@"fb_uploadimg.png");
            NSData *data = UIImagePNGRepresentation(addimg);
            UIImage *img1;
            if ([[imgsArray lastObject] isKindOfClass:[UIImage class]]) {
                img1=[imgsArray lastObject];
            }else {
                NSString *url = [imgsArray lastObject];
                img1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
            }
            
            NSData *data1 = UIImagePNGRepresentation(img1);
            if (![data1 isEqual:data]) {
                [cell.deleteBtn setHidden:NO];
            }else{
                [cell.deleteBtn setHidden:YES];
            }
        }else {
            [cell.deleteBtn setHidden:YES];
        }
    }
    if (indexPath.row == imgsArray.count) {
        UIImage *addimg=Image(@"fb_uploadimg.png");
        [cell.m_imgView setImage:addimg];
        cell.m_imgView.tag = [indexPath row];
        cell.deleteBtn.tag=indexPath.row;
        return cell;
    }
    if ([[imgsArray objectAtIndex:indexPath.row] isKindOfClass:[NSString class]]) {
        NSString *imgUrl=[imgsArray objectAtIndex:indexPath.row];
        [cell.m_imgView setImageAsyncWithURL:[NSString stringWithFormat:@"%@",imgUrl] placeholderImage:DefaultImage_logo];
        cell.m_imgView.tag = [indexPath row];
        cell.deleteBtn.tag=indexPath.row;
        [cell.deleteBtn addTarget:self action:@selector(deleteIMGClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }else{
        UIImage *img=[imgsArray objectAtIndex:indexPath.row];
        [cell.m_imgView setImage:img];
        cell.m_imgView.tag = [indexPath row];
        cell.deleteBtn.tag = indexPath.row;
        [cell.deleteBtn addTarget:self action:@selector(deleteIMGClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}

- (void) tapProfileImage:(UITapGestureRecognizer *)gestureRecognizer{
    
    UIImageView *tableGridImage = (UIImageView*)gestureRecognizer.view;
    NSInteger index = tableGridImage.tag;
    if (index == (imgsArray.count))
    {
        [self btnSelectPhoto_Click:nil];
    }else{
        
    }
}


-(void)deleteIMGClick:(UIButton*)sender{
    _addBtn.enabled=YES;
    [imgsArray removeObjectAtIndex:sender.tag];
//    UIImage *addimg=Image(@"fb_uploadimg.png");
//    NSData *data = UIImagePNGRepresentation(addimg);
    [_collectionView reloadData];
    [self setBaseScrollHeigh:imgsArray];
    if (imgsArray.count==0) {
        isSelectedPhoto=NO;
    }
    
}

-(void)setBaseScrollHeigh:(NSArray *)arr2{
    
    CGFloat f=(WindowWith-80)/3;
    
    CGRect rect=_collectionView.frame;
    if ((arr2.count+1) <4) {
        rect.size.height=f+20;
    }else if (arr2.count <7){
        rect.size.height=f*2+30;
    }else{
        rect.size.height=f*3+40;
    }
    _collectionView.frame=rect;
    
    CGRect rect2=_downView.frame;
    
    rect2.origin.y=_collectionView.bottom;
    _downView.frame=rect2;
    _BaseScrollView.contentSize=CGSizeMake(WindowWith, _addBtn.bottom+_collectionView.bottom+100);
}

- (void)keyBoardWillShow:(NSNotification *)notification{
    
    //获取键盘的相关属性(包括键盘位置,高度...)
//    NSDictionary *userInfo = notification.userInfo;
	
    //获取键盘的位置和大小
    //CGRect rect = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue /*将对象转换为CGRect结构体*/];
    
    //键盘升起的时候
    
    [_BaseScrollView setContentOffset:CGPointMake(0, _downView.top+_keybordHight-70) animated:YES];
}

- (void)keyBoardWillHide
{
    //键盘隐藏的时候
    [_BaseScrollView setContentOffset:CGPointMake(0, _activityTextField.bottom+20) animated:YES];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	// Return YES for supported orientations
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
#pragma clang diagnostic pop


@end
