//
//  CompanyCumlativeViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/3/31.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "CompanyCumlativeViewController.h"
#import "ZLPhotoActionSheet.h"
#import "InformationEditViewController.h"
#import "JLSimplePickViewComponent.h"
#import "KICropImageView.h"
@interface CompanyCumlativeViewController ()<UICollectionViewDelegate,
UICollectionViewDataSource,JLActionSheetDelegate,HJCActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    ZLPhotoActionSheet *actionSheet;
    UICollectionView *_collectionView;
    NSMutableArray *imgsArray;
    BOOL isFirstAddPhoto;
    UIView *_downView;
    
    BOOL isSelectedPhoto;
    NSMutableArray *hyArray; //行业list
    NSInteger _selIndex;
    NSDictionary *_dic;
    
    UIAsyncImageView * _companyCulative;
    KICropImageView* _cropImageView;
    
}
@end
@implementation CompanyCumlativeViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //  self.navigationController.navigationBar.hidden=YES;
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"企业认证"];
    
    _dic=[IHUtility getUserDefalutsDicKey:kUserDefalutLoginInfo];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"提 交" style:UIBarButtonItemStylePlain target:self action:@selector(submitClick:)];
    [item1 setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem=item1;
    
    UIImage *img=Image(@"redstar.png");
    UIView *downView=[[UIView alloc]init];
    
    _downView=downView;
    __weak CompanyCumlativeViewController *weakSelf=self;
    
    //上传企业营业执照
    imgsArray=[[NSMutableArray alloc]init];
    //    CGFloat f=(WindowWith-55)/3;
    //    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //    layout.itemSize = CGSizeMake(f, f);
    //    layout.sectionInset = UIEdgeInsetsMake(0, 5,0, 5);
    //    //layout.sectionInset.right = layout.sectionInset.right + w;
    //    layout.minimumInteritemSpacing = 0;
    //    layout.minimumLineSpacing = 10;
    //    UIImage *addImg=Image(@"fb_uploadimg.png");
    //
    //    if (![_dic[@"business_license_url"] isEqualToString:@""]) {
    //        [imgsArray addObject:_dic[@"business_license_url"]];
    //    }else
    //    {
    //         [imgsArray addObject:addImg];
    //    }
    //
    //
    //    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(WindowWith/2-50, 30, WindowWith-40, f+12) collectionViewLayout:layout];
    //    _collectionView.userInteractionEnabled=YES;
    //    _collectionView.dataSource = self;
    //    _collectionView.delegate = self;
    //    _collectionView.scrollEnabled=NO;
    //    _collectionView.backgroundColor = [UIColor whiteColor];
    //    [_collectionView registerClass:[CreateBSCollectionViewCell class] forCellWithReuseIdentifier: @"CreateBSCollectionViewCell"];
    //    actionSheet = [[ZLPhotoActionSheet alloc] init];
    //    //设置照片最大选择数
    //    actionSheet.maxSelectCount = 1;
    //    //设置照片最大预览数
    //    actionSheet.maxPreviewCount = 20;
    //    [_BaseScrollView addSubview:_collectionView];
    
    UIAsyncImageView * companyCulative=[[UIAsyncImageView alloc]initWithFrame:CGRectMake((WindowWith-(WindowWith-55)/3)/2.0, 30, (WindowWith-55)/3, (WindowWith-55)/3)];
    [companyCulative setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,_dic[@"business_license_url"]] placeholderImage:Image(@"fb_uploadimg.png")];
    NSLog(@"~~~~~~%@",[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,_dic[@"business_license_url"]]);
    _companyCulative=companyCulative;
    companyCulative.userInteractionEnabled=YES;
    companyCulative.clipsToBounds=YES;
    companyCulative.contentMode=UIViewContentModeScaleAspectFill;
    [_BaseScrollView addSubview:companyCulative];
    
    
    UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPhoto:)];
    tap.numberOfTapsRequired=1;
    tap.numberOfTouchesRequired=1;
    [companyCulative addGestureRecognizer:tap];
    
    downView.frame=CGRectMake(0,  companyCulative.bottom+20, WindowWith, 500);
    
    SMLabel *photoLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(20, 0, 250, 20) textColor:RGBA(189, 202, 219, 1) textFont:sysFont(14)];
    photoLbl.text=@"上传营业执照或其它资质证书图片";
    photoLbl.centerX=self.view.centerX;
    photoLbl.textAlignment=NSTextAlignmentCenter;
    [downView addSubview:photoLbl];
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(photoLbl.left, photoLbl.top+5, img.size.width, img.size.height)];
    imageView.image=img;
    [downView addSubview:imageView];
    
    UIView *photoView=[[UIView alloc]initWithFrame:CGRectMake(0, photoLbl.bottom+15, WindowWith, 5)];
    photoView.backgroundColor=cLineColor;
    [downView addSubview:photoView];
    [_BaseScrollView addSubview:downView];
    
    //公司
    MapAnnotationView *companyView=[[MapAnnotationView alloc]initWithFrame:CGRectMake(0, photoView.bottom+10, WindowWith, 48) name:@"公司" ifMust:YES];
    companyView.lbl.text=@"尚未填写";
    companyView.tag=1001;
    companyView.lbl.textColor=RGBA(232, 121, 117, 1);
    NSString *company;
    if (![_dic[@"company_name"] isEqualToString:@""]) {
        companyView.lbl.text=_dic[@"company_name"];
        company=companyView.lbl.text;
        companyView.lbl.textColor=cGrayLightColor;
    }
    
    companyView.selectBlock=^(NSInteger index){
        NSLog(@"公司");
        [weakSelf editWithTitle:@"公司名称" type:SelectCompanyBlock text:company];
    };
    [downView addSubview:companyView];
    
    //行业
    NSDictionary *dic2=[IHUtility getUserDefalutDic:kUserDefalutInit];
    hyArray=[[NSMutableArray alloc]initWithArray:dic2[@"industryInfoList"]];
    MapAnnotationView *industryView=[[MapAnnotationView alloc]initWithFrame:CGRectMake(companyView.left, companyView.bottom, companyView.width, companyView.height) name:@"行业" ifMust:YES];
    industryView.tag=1002;
    industryView.lbl.text=@"尚未填写";
    industryView.lbl.textColor=RGBA(232, 121, 117, 1);
    
    
    for (NSDictionary *obj in hyArray) {
        if ([_dic[@"i_type_id"] intValue]!=0) {
            if ([obj[@"i_type_id"] intValue]==[_dic[@"i_type_id"] intValue]) {
                industryView.lbl.text=obj[@"i_name"];
                industryView.lbl.textColor=cGrayLightColor;
            }
        }
    }
    
    industryView.selectBlock=^(NSInteger index){
        
        NSMutableArray *arr=[[NSMutableArray alloc]init];
        for (NSDictionary *dic in hyArray) {
            [arr addObject:dic[@"i_name"]];
        }
        
        [weakSelf showPicViewWithArr:arr :@"行业" :21];
    };
    [downView addSubview:industryView];
    
    //电话
    MapAnnotationView *phoneView=[[MapAnnotationView alloc]initWithFrame:CGRectMake(industryView.left, industryView.bottom, industryView.width, industryView.height) name:@"电话" ifMust:YES];
    phoneView.tag=1003;
    phoneView.lbl.text=@"尚未填写";
    phoneView.lbl.textColor=RGBA(232, 121, 117, 1);
    NSString *phone;
    if (![_dic[@"mobile"] isEqualToString:@""]) {
        phoneView.lbl.text=_dic[@"mobile"];
        phoneView.lbl.textColor=cGrayLightColor;
        phone=phoneView.lbl.text;
    }
    
    phoneView.selectBlock=^(NSInteger index){
        NSLog(@"电话");
        [weakSelf editWithTitle:@"电话" type:SelectPhoneBlock text:phone];
    };
    [downView addSubview:phoneView];
    
    //邮箱
    MapAnnotationView *emailView=[[MapAnnotationView alloc]initWithFrame:CGRectMake(phoneView.left, phoneView.bottom, phoneView.width, phoneView.height) name:@"邮箱" ifMust:NO];
    emailView.tag=1004;
    emailView.lbl.text=@"选填";
    NSString *email;
    if (![_dic[@"email"] isEqualToString:@""]) {
        emailView.lbl.text=_dic[@"email"];
        emailView.lbl.textColor=cGrayLightColor;
        email=emailView.lbl.text;
        
    }
    emailView.selectBlock=^(NSInteger index){
        NSLog(@"邮箱");
        [weakSelf editWithTitle:@"邮箱" type:SelectEmailBlock text:email];
    };
    [downView addSubview:emailView];
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, emailView.bottom-1, WindowWith, 255)];
    lineView.backgroundColor=cLineColor;
    [downView addSubview:lineView];
    
    SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(30, 20, 48, 17) textColor:cBlackColor textFont:sysFont(12)];
    lbl.text=@"温馨提示";
    [lineView addSubview:lbl];
    
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.left, lbl.bottom+15, 263, 15) textColor:cBlackColor textFont:sysFont(12)];
    lbl.text=@"1.请填写真实信息，有助于我们帮您尽快录入系统";
    [lineView addSubview:lbl];
    
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.left, lbl.bottom+2, 263, 15) textColor:cBlackColor textFont:sysFont(12)];
    lbl.text=@"2.我们将在2个工作日内完成认证审核工作";
    [lineView addSubview:lbl];
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.left, lbl.bottom+2, 263, 15) textColor:cBlackColor textFont:sysFont(12)];
    lbl.text=@"3.如需尽快审核或有其它疑问，可咨询客服";
    [lineView addSubview:lbl];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame=CGRectMake(0, lbl.bottom+35, WindowWith-80, 40);
    btn.backgroundColor=cGreenColor;
    [btn setTintColor:[UIColor whiteColor]];
    [btn setTitle:@"提  交" forState:UIControlStateNormal];
    btn.titleLabel.font=sysFont(18.8);
    [btn addTarget:self action:@selector(submitClick:) forControlEvents:UIControlEventTouchUpInside];
    [lineView addSubview:btn];
    btn.centerX=self.view.centerX;
    btn.layer.cornerRadius=21;
    
    _BaseScrollView.contentSize=CGSizeMake(WindowWith, lineView.bottom+220);
    
    NSLog(@"%f",lineView.bottom);
}

//跳转填写
-(void)editWithTitle:(NSString *)title type:(EditBlock)type text:(NSString *)text
{
    InformationEditViewController *editView=[[InformationEditViewController alloc]init];
    editView.titl=title;
    editView.text=text;
    editView.delegate=self;
    editView.type=type;
    [self pushViewController:editView];
}

-(void)submitClick:(UIButton *)sender
{
    
    if (imgsArray.count==0&&[_dic[@"business_license_url"]isEqualToString:@""]) {
        [self addSucessView:@"未上传企业执照" type:1];
        return;
    }
    
    MapAnnotationView *companyView=[_BaseScrollView viewWithTag:1001];
    NSString *company;
    if (![companyView.lbl.text isEqualToString:@"尚未填写"]) {
        company=companyView.lbl.text;
    }else
    {
        [self addSucessView:@"未填写公司名" type:1];
        return;
    }
    MapAnnotationView *industryView=[_BaseScrollView viewWithTag:1002];
    int itypeid = 0;
    if (![industryView.lbl.text isEqualToString:@"尚未填写"]) {
        for (NSDictionary *obj in hyArray)
        {
            if ([industryView.lbl.text isEqualToString:obj[@"i_name"]]) {
                itypeid=[obj[@"i_type_id"] intValue];
            }
        }
    }else
    {
        [IHUtility addSucessView:@"未填行业" type:1];
        return;
    }
    MapAnnotationView *phoneView=[_BaseScrollView viewWithTag:1003];
    NSString *phone;
    if (![phoneView.lbl.text isEqualToString:@"尚未填写"]) {
        phone=phoneView.lbl.text;
    }else
    {
        [self addSucessView:@"未填电话" type:1];
        return;
    }
    MapAnnotationView *emailView=[_BaseScrollView viewWithTag:1004];
    NSString *email;
    if (![emailView.lbl.text isEqualToString:@"选填"]) {
        email=emailView.lbl.text;
    }
    
    
    UIImage *addimg=Image(@"fb_uploadimg.png");
    NSData *data = UIImagePNGRepresentation(addimg);
    for (int i=0; i<imgsArray.count; i++) {
        UIImage *imgA=[imgsArray objectAtIndex:i];
        NSData *data1 = UIImagePNGRepresentation(imgA);
        
        if ([data isEqual:data1]) {
            [imgsArray removeObject:imgA];
        }
    }
    
    if (imgsArray.count>0) {
        
        [self addWaitingView];
        [AliyunUpload uploadImage:imgsArray FileDirectory:ENT_fileImageHeader success:^(NSString *obj) {
            
            NSDictionary *dic=[ConfigManager getAddressInfoWithUser_id:[USERMODEL.userID intValue]country:nil province:nil city:nil area:nil street:nil longitude:0 latitude:0 company_lon:0 company_lat:0 distance:0 company_province:nil company_city:nil company_area:nil company_street:nil];
            
            
            NSDictionary *dic1=[ConfigManager getUserDicWithUser_name:nil user_id:[USERMODEL.userID intValue]  company_name:company password:nil nickname:nil address:nil hx_password:nil mobile:phone landline:nil email:email i_type_id:itypeid sexy:0 business_direction:nil user_authentication:1 identity_key:0 heed_image_url:nil brief_introduction:nil position:nil wx_key:nil business_license_url:obj map_callout:0 addressInfo:dic ];
            
            [network getUserInfoUpdate:dic1 success:^(NSDictionary *obj) {
                [self removeWaitingView];
                NSDictionary *dic=[obj objectForKey:@"content"];
                NSLog(@"%@",dic);
                [self addSucessView:@"提交成功" type:1];
                [ConfigManager setUserInfiDic:dic];
                [IHUtility saveDicUserDefaluts:dic key:kUserDefalutLoginInfo];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationCompany object:nil];
                [self.navigationController popViewControllerAnimated:YES];
                
            } failure:^(NSDictionary *obj2) {
            }];
        }];
    }else{
        NSDictionary *dic=[ConfigManager getAddressInfoWithUser_id:[USERMODEL.userID intValue]country:nil province:nil city:nil area:nil street:nil longitude:0 latitude:0 company_lon:0 company_lat:0 distance:0 company_province:nil company_city:nil company_area:nil company_street:nil];
        
        NSDictionary *dic1=[ConfigManager getUserDicWithUser_name:nil user_id:[USERMODEL.userID intValue]  company_name:company password:nil nickname:nil address:nil hx_password:nil mobile:phone landline:nil email:email i_type_id:itypeid sexy:0 business_direction:nil user_authentication:1 identity_key:0 heed_image_url:nil brief_introduction:nil position:nil wx_key:nil business_license_url:_dic[@"business_license_url"] map_callout:0 addressInfo:dic ];
        
        [self addWaitingView];
        [network getUserInfoUpdate:dic1 success:^(NSDictionary *obj) {
            [self removeWaitingView];
            NSDictionary *dic=[obj objectForKey:@"content"];
            [self addSucessView:@"提交成功" type:1];
            [ConfigManager setUserInfiDic:dic];
            [IHUtility saveDicUserDefaluts:dic key:kUserDefalutLoginInfo];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationCompany object:nil];
            [self.navigationController popViewControllerAnimated:YES];
            
        } failure:^(NSDictionary *obj2) {
        }];
    }
    //    [self addWaitingView];
    //    [AliyunUpload uploadImage:imgsArray FileDirectory:ENT_fileImageHeader success:^(NSString *obj) {
    //
    //        NSDictionary *dic=[ConfigManager getAddressInfoWithUser_id:[USERMODEL.userID intValue]country:nil province:nil city:nil area:nil street:nil longitude:0 latitude:0 company_lon:0 company_lat:0 distance:0 company_province:nil company_city:nil company_area:nil company_street:nil];
    //
    //
    //        NSDictionary *dic1=[ConfigManager getUserDicWithUser_name:nil user_id:[USERMODEL.userID intValue]  company_name:company password:nil nickname:nil address:nil hx_password:nil mobile:phone landline:nil email:email i_type_id:itypeid sexy:0 business_direction:nil user_authentication:1 identity_key:0 heed_image_url:nil brief_introduction:nil position:nil wx_key:nil business_license_url:obj map_callout:0 addressInfo:dic ];
    //
    //        [network getUserInfoUpdate:dic1 success:^(NSDictionary *obj) {
    //            [self removeWaitingView];
    //            NSDictionary *dic=[obj objectForKey:@"content"];
    //            [self addSucessView:@"提交成功" type:1];
    //            [ConfigManager setUserInfiDic:dic];
    //            [IHUtility saveDicUserDefaluts:dic key:kUserDefalutLoginInfo];
    //
    //          [[NSNotificationCenter defaultCenter] postNotificationName:NotificationCompany object:nil];
    //            [self.navigationController popViewControllerAnimated:YES];
    //
    //        } failure:^(NSDictionary *obj2) {
    //
    //        }];
    //
    //    }];
    
}

-(void)displayTiyle:(NSString *)title type:(EditBlock)type
{
    if (type==SelectCompanyBlock) {
        EditInformationView *view=[self.view viewWithTag:1001];
        if (![title isEqualToString:@""]) {
            view.lbl.text=title;
            view.lbl.textColor=cBlackColor;
        }
        
    }
    if (type==SelectIndustryBlock) {
        EditInformationView *view=[self.view viewWithTag:1002];
        if (![title isEqualToString:@""]) {
            view.lbl.text=title;
            view.lbl.textColor=cBlackColor;
        }
        
    }
    if (type==SelectPhoneBlock) {
        EditInformationView *view=[self.view viewWithTag:1003];
        if (![title isEqualToString:@""]) {
            view.lbl.text=title;
            view.lbl.textColor=cBlackColor;
        }
        
    }
    if (type==SelectEmailBlock) {
        EditInformationView *view=[self.view viewWithTag:1004];
        if (![title isEqualToString:@""]) {
            view.lbl.text=title;
            view.lbl.textColor=cBlackColor;
        }
    }
}

//- (void)btnSelectPhoto_Click:(id)sender
//{
//    [actionSheet showWithSender:self animate:YES completion:^(NSArray<UIImage *> * _Nonnull selectPhotos) {
//        for (int i=0; i<selectPhotos.count; i++) {
//            UIImage *img2 = [selectPhotos objectAtIndex:i];
//            if (!isFirstAddPhoto) {
//                [imgsArray removeAllObjects];
//                [imgsArray addObject:img2];
//                isFirstAddPhoto=YES;
//            }else{
//                [imgsArray insertObject:img2 atIndex:0];
//            }
//        }
//        if (imgsArray.count>=6) {
//            NSMutableArray *arr2=[[NSMutableArray alloc]init];
//            for (int i=0; i<6; i++) {
//                UIImage *img=[imgsArray objectAtIndex:i];
//                [arr2 addObject:img];
//            }
//            [imgsArray removeAllObjects];
//            [imgsArray addObjectsFromArray:arr2];
//            UIImage *addimg=Image(@"fb_uploadimg.png");
//            [imgsArray addObject:addimg];
//        }
//        UIImage *addimg=Image(@"fb_uploadimg.png");
//        NSData *data = UIImagePNGRepresentation(addimg);
//        if (imgsArray.count<=6) {
//            UIImage *img1=[imgsArray lastObject];
//            NSData *data1 = UIImagePNGRepresentation(img1);
//            if (![data1 isEqual:data]) {
//                [imgsArray addObject:addimg];
//            }
//        }
//        [_collectionView reloadData];
//        [self setBaseScrollHeigh:imgsArray];
//    }];
//}
//
//
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//
//#pragma mark - collection数据源代理
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    return imgsArray.count;
//}
//
//-(NSInteger)numberOfSectionsInCollectionView:
//(UICollectionView *)collectionView
//{
//    return 1;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    CreateBSCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CreateBSCollectionViewCell" forIndexPath:indexPath];
//
//    UIImage *img=[imgsArray objectAtIndex:indexPath.row];
//
//    if (![_dic[@"business_license_url"] isEqualToString:@""])
//    {   NSLog(@"%@",_dic[@"business_license_url"]);
//        [cell.imgView setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,_dic[@"business_license_url"]] placeholderImage:DefaultImage_logo];
//        cell.deleteBtn.hidden=YES;
//    }else
//    {
//        [cell.imgView setImage:img];
//        cell.imgView.tag = [indexPath row];
//        cell.deleteBtn.tag=indexPath.row;
//        [cell.deleteBtn addTarget:self action:@selector(deleteIMGClick:) forControlEvents:UIControlEventTouchUpInside];
//    }
//
//
//
//
//
//
//    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapProfileImage:)];
//    singleTap.numberOfTapsRequired = 1;
//    cell.imgView.userInteractionEnabled = YES;
//    [cell.imgView  addGestureRecognizer:singleTap];
//    cell.deleteBtn.tag = [indexPath row];
//    if ([indexPath row] != (imgsArray.count - 1)){
//        [cell.deleteBtn setHidden:NO];
//    }
//    else {
//        [cell.deleteBtn setHidden:YES];
//    }
//
//    return cell;
//}
//
//
//
//- (void) tapProfileImage:(UITapGestureRecognizer *)gestureRecognizer{
//
//    UIImageView *tableGridImage = (UIImageView*)gestureRecognizer.view;
//    NSInteger index = tableGridImage.tag;
//    if (index == (imgsArray.count -1))
//    {
//        [self btnSelectPhoto_Click:nil];
//    }else{
//
//
//    }
//
//
//}
//
//
//-(void)deleteIMGClick:(UIButton*)sender{
//    [imgsArray removeObjectAtIndex:sender.tag];
//    //    UIImage *img1=[imgsArray lastObject];
//    //    NSData *data1 = UIImagePNGRepresentation(img1);
//    //    UIImage *addimg=Image(@"fb_uploadimg.png");
//    //
//    //    if (imgsArray.count<6 ) {
//    //        if (![data1 isEqual:addimg]) {
//    //            [imgsArray addObject:addimg];
//    //        }
//    //    }
//
//    [_collectionView reloadData];
//    [self setBaseScrollHeigh:imgsArray];
//}
//
//
//-(void)setBaseScrollHeigh:(NSArray *)arr2{
//
//
//    CGFloat f=(WindowWith-80)/3;
//
//    CGRect rect=_collectionView.frame;
//    if (arr2.count<4) {
//        rect.size.height=f+20;
//    }else if (arr2.count<7){
//        rect.size.height=f*2+30;
//    }else{
//        rect.size.height=f*3+40;
//    }
//    _collectionView.frame=rect;
//
//    CGRect rect2=_downView.frame;
//
//    rect2.origin.y=_collectionView.bottom;
//    _downView.frame=rect2;
//
//
//
//
//
//
//}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


-(void)showPicViewWithArr:(NSArray *)arr :(NSString *)title :(NSInteger)tag
{
    JLSimplePickViewComponent *pickView =(JLSimplePickViewComponent*)[self.view viewWithTag:tag];
    if(pickView == nil)
    {
        
        pickView = [[JLSimplePickViewComponent alloc] initWithParams:title withData:arr];
        pickView.tag=tag;
        pickView.ActionSheetDelegate = self;
    }
    [pickView show];
    
}

-(void)ActionSheetDoneHandle:(JLSimplePickViewComponent*)pickViewComponent selectedIndex:(NSInteger)index{
    if (pickViewComponent.tag==21) {
        
        NSDictionary *dic=[hyArray objectAtIndex:index];
        EditInformationView *urgentView=[_BaseScrollView viewWithTag:1002];
        urgentView.lbl.textColor=cBlackColor;
        urgentView.lbl.text=[dic objectForKey:@"i_name"];
        _selIndex=index;
    }
    
}

//拍照相册选择
-(void)tapPhoto:(UITapGestureRecognizer *)tap
{
    NSLog(@"tap++++");
    HJCActionSheet *sheet = [[HJCActionSheet alloc] initWithDelegate:self CancelTitle:@"取消" OtherTitles:@"拍照", @"从手机相册选择", nil];
    // 2.显示出来
    [sheet show];
}
// 3.实现代理方法，需要遵守HJCActionSheetDelegate代理协议
- (void)actionSheet:(HJCActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    UIImagePickerController * ip=[[UIImagePickerController alloc]init];
    ip.delegate=self;
    
    // ip.allowsEditing = YES;
    BOOL isOpen=[UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    if (isOpen)
    {
        if (buttonIndex==1) {
            ip.sourceType=UIImagePickerControllerSourceTypeCamera;
        }else if (buttonIndex==2){
            ip.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
        }
        //设置控件是打开相机还是相册，默认是相册，设置UIImagePickerControllerSourceTypeCamera 打开相机
    }
    [self presentViewController:ip animated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage * img=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
    img=[UIImage rotateImage:img];
    [imgsArray addObject:img];
    _companyCulative.image=img;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
