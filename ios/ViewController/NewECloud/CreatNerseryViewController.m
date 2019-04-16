//
//  CreatNerseryViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/11/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "CreatNerseryViewController.h"
#import "JLSimplePickViewComponent.h"
#import "JLAddressPickView.h"
#import "XHFriendlyLoadingView.h"
//#import "PlantSelectedViewController.h"

@interface CreatNerseryViewController ()<JLActionSheetDelegate,JLAddressActionSheetDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate,UITextViewDelegate>
{
//    JLSimplePickViewComponent *_pickView;
    NSMutableArray *plantArr;
    NSArray *nameArr;
    NSArray *dataArr;
    NSArray *mainArr;
    UIView *_needView;
    UIView *_topView;
    
    
    ZLPhotoActionSheet *actionSheet;
    UICollectionView *_collectionView;
    NSMutableArray *imgsArray;
    BOOL isFirstAddPhoto;
//    BOOL isSelectedPhoto;
    
    CGFloat height;
    
    JLAddressPickView *_adressPickView;
    NerseryNumView *numView;
    PlaceholderTextView *_textView;//备注
    
    NSString *location;//产地
    NSString *nursery_address;//苗源
    NSString *plant_type;//品种类型
    NSString *plant_name;//品种名称
    NSString *loading_price;//装车价
    NSString *number;//数量
    NSString *unit;//单位
    NSString *diameter;//胸径
    NSString *heignt;//高度
    NSString *crown;//冠幅
    NSString *tree_age;//树龄
    NSString *branch_point;//分支点
    NSString *rod_diameter;//杆径
    NSString *weight;//公斤
    NSString *advanced;//优势
    
}
@end

@implementation CreatNerseryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"发布苗木云"];
    
    location= @"";
    nursery_address= @"";
    plant_type= @"";
    plant_name= @"";
    loading_price= @"";
    number= @"";
    unit = @"株";
    diameter= @"";
    heignt= @"";
    crown= @"";
    tree_age= @"";
    branch_point= @"";
    rod_diameter= @"";
    advanced = @"";
    weight = @"";
    
    plantArr = [[NSMutableArray alloc] init];
    //获取品类及品种
    [self addPushViewWaitingView];
    [network GetMiaoMuYunListSuccess:^(NSDictionary *obj) {
        
        [self->plantArr addObjectsFromArray:obj[@"content"]];
        
        //遍历获取对应品类下的品种名称
        for (NSDictionary *dic in self->plantArr) {
            if ([dic[@"parent_nursery_name"] containsString:self.plantStr]) {
                self->nameArr = dic[@"list"];
            }
        }
        
        [self initViews];
        [self removePushViewWaitingView];
    } failure:^(NSDictionary *obj2) {
        [self removePushViewWaitingView];
        XHFriendlyLoadingView *v=(XHFriendlyLoadingView*)[self.view viewWithTag:8172];
        [v showReloadViewWithText:reloadText];
    }];
}

- (void)initViews
{
    _BaseScrollView.backgroundColor = RGB(247 , 248, 250);
    
    imgsArray=[[NSMutableArray alloc]init];
    
    if (self.type==ENT_Edit) {
        // self.listModel.hint;
        for (MTPhotosModel *model in self.listModel.imageArr) {
            if (imgsArray.count <3) {
                [imgsArray addObject:model.imgUrl];
            }
        }
    }else{
        UIImage *addImg=Image(@"fb_uploadimg.png");
        [imgsArray addObject:addImg];
    }
    UIView *errorView = [UIView new];
    errorView.backgroundColor = RGB(245, 165, 35);
    [_BaseScrollView addSubview:errorView];
    errorView.sd_layout.leftSpaceToView(_BaseScrollView,0).topSpaceToView(_BaseScrollView,0).widthIs(WindowWith);
    
    SMLabel *errorLbl = [SMLabel new];
    errorLbl.text = self.listModel.hint;
    errorLbl.textColor=[UIColor whiteColor];
    errorLbl.font = sysFont(14);
    [errorView addSubview: errorLbl];
    errorLbl.sd_layout.leftSpaceToView(errorView,15).topSpaceToView(errorView,10).widthIs(WindowWith - 30).autoHeightRatio(0);
    [errorLbl setMaxNumberOfLinesToShow:0];
    if (self.type==ENT_Edit) {
        [errorView setupAutoHeightWithBottomView:errorLbl bottomMargin:10];
    }else {
        errorView.sd_layout.heightIs(0);
    }
    
    //上传图片
    UIView *topView = [UIView new];
    topView.backgroundColor = [UIColor whiteColor];
    _topView = topView;
    [_BaseScrollView addSubview:topView];
    
    SMLabel *lbl = [SMLabel new];
    lbl.font = sysFont(13);
    lbl.textColor = [UIColor redColor];
    lbl.text = @"*请上传3张真实的苗木图片";
    [topView addSubview:lbl];
    lbl.sd_layout.leftSpaceToView(topView,15).topSpaceToView(topView,15).heightIs(13).widthIs(WindowWith-30);
    
    CGFloat f=(WindowWith-60)/3;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(f, f);
    layout.sectionInset = UIEdgeInsetsMake(0, 5,0, 5);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 10;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    [topView addSubview:_collectionView];
    _collectionView.sd_layout.leftSpaceToView(topView,20).topSpaceToView(lbl,15).widthIs(WindowWith-40);
    _collectionView.userInteractionEnabled=YES;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.scrollEnabled=NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[CreateBSCollectionViewCell class] forCellWithReuseIdentifier: @"CreateBSCollectionViewCell"];
    actionSheet = [[ZLPhotoActionSheet alloc] init];
    //设置照片最大选择数
    actionSheet.maxSelectCount = 3;
    //设置照片最大预览数
    actionSheet.maxPreviewCount = 20;
    
    _collectionView.sd_layout.heightIs(((imgsArray.count-1)/3+1) *(f +20));
    [_collectionView reloadData];
    
    topView.sd_layout.leftSpaceToView(_BaseScrollView,0).topSpaceToView(errorView,0).widthIs(WindowWith);
    [topView setupAutoHeightWithBottomView:_collectionView bottomMargin:10];
    
    
    UIView *needView = [UIView new];
    needView.backgroundColor = [UIColor whiteColor];
    _needView = needView;
    [_BaseScrollView addSubview:needView];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSArray *arr =@[@"产地",@"品种",@"价格",@"苗源地址",@"数量"];
    [array addObjectsFromArray:arr];
    [array addObjectsFromArray:self.paramArr];
    [array addObject:@"优势"];
    
    dataArr = array;
    mainArr = array;
    
    needView.sd_layout.leftSpaceToView(_BaseScrollView,0).topSpaceToView(topView,0).widthIs(WindowWith).heightIs(dataArr.count *55);
    
    //创建上传参数试图
    [self initInfoViewWith:array];
    
    //备注信息
    UIView *remarkView = [UIView new];
    remarkView.backgroundColor = [UIColor whiteColor];
    [_BaseScrollView addSubview:remarkView];
    remarkView.sd_layout.leftSpaceToView(_BaseScrollView,0).topSpaceToView(needView,0).widthIs(WindowWith).heightIs(80);
    
    PlaceholderTextView *textView = [[PlaceholderTextView alloc]initWithFrame:CGRectMake(15, 15, WindowWith-30, 50)];
    textView.layer.cornerRadius = 4;
    textView.layer.borderColor = cLineColor.CGColor;
    textView.layer.borderWidth = 1;
    textView.font = sysFont(13);
    textView.placeholder = @"备注信息";
    textView.placeholderFont = sysFont(13);
    textView.delegate = self;
    _textView = textView;
    [remarkView addSubview:textView];
    
    if (self.listModel != nil) {
        textView.text = self.listModel.remark;
    }
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    bottomView.sd_layout.leftSpaceToView(self.view,0).topSpaceToView(self.view,iPhoneHeight - KtopHeitht -50).widthIs(WindowWith).heightIs(50);
    
    UIButton *button = [UIButton new];
    [button setTitle:@"确认发布" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = cGreenColor;
    button.layer.cornerRadius = 21;
    [button addTarget:self action:@selector(referAction:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:button];
    button.sd_layout.leftSpaceToView(bottomView,25).topSpaceToView(bottomView,5).rightSpaceToView(bottomView,25).heightIs(40);
    
    [_BaseScrollView setupAutoContentSizeWithBottomView:remarkView bottomMargin:130];
}
- (void)initInfoViewWith:(NSArray *)array
{
    //    __weak CreatNerseryViewController *weakSelf = self;
    for (int i=0; i<array.count; i++) {
        if ([array[i] isEqualToString:@"数量"]) {
            NSArray *arr = @[@"株",@"丛",@"袋",@"平方"];
            
            NerseryNumView *view = [NerseryNumView new];
            view.selectBlock = ^(NSInteger index){
                [self->_BaseScrollView endEditing:YES];
                self->unit = arr[index - 200];
            };
            [_needView addSubview:view];
            view.tag = i + 100;
            numView = view;
            
            UIView *lastView = [_needView viewWithTag:(i -1) +100];
            view.sd_layout.leftSpaceToView(_needView,0).topSpaceToView(lastView, 0).heightIs(95).widthIs(WindowWith);
            [_needView setupAutoHeightWithBottomView:view bottomMargin:10];
            
            if (self.listModel !=nil) {
                view.numLbl.text = self.listModel.num;
                NSArray *views = view.subviews;
                for (UIView *view in views) {
                    if ([view isKindOfClass:[UIButton class]]) {
                        UIButton *button = (UIButton *)view;
                        if ([button.titleLabel.text isEqualToString:self.listModel.unit]) {
                            button.selected = YES;
                        }
                    }
                }
            }
        }else if ([array[i] isEqualToString:@"优势"]){
            NerseryAdvantageView *view = [NerseryAdvantageView new];
            __weak NerseryAdvantageView *viewSelf = view;
            view.selectBlock = ^(NSInteger index){
                [self->_BaseScrollView endEditing:YES];
                
                //判断选择的优势，将优势拼接为字符串
                UIButton *btn = (UIButton *)[viewSelf viewWithTag:index];
                if (btn.selected) {
					if (![self->advanced containsString:btn.titleLabel.text]) {
                        if (self->advanced.length > 0) {
                            self->advanced = [NSString stringWithFormat:@"%@,%@",self->advanced,btn.titleLabel.text];
                        }else {
                            self->advanced = btn.titleLabel.text;
                        }
                    }
                }else {
                    NSArray *arr = [self->advanced componentsSeparatedByString:@","];
                    NSMutableArray *textArr = [[NSMutableArray alloc]initWithArray:arr];
                    [textArr removeObject:btn.titleLabel.text];
                    NSString *str;
                    for (int i=0; i<textArr.count; i++) {
                        if (str.length > 0) {
                            str = [NSString stringWithFormat:@"%@,%@",str,textArr[i]];
                        }else {
                            str = textArr[i];
                        }
                    }
                    self->advanced = str;
                }
            };
            [_needView addSubview:view];
            view.tag = i + 100;
            
            UIView *lastView = [_needView viewWithTag:(i -1) +100];
            
            view.sd_layout.leftSpaceToView(_needView,0).topSpaceToView(lastView, 0).heightIs(55).widthIs(WindowWith);
            [_needView setupAutoHeightWithBottomView:view bottomMargin:10];
            
            if (self.listModel != nil) {
                [view setTextContent:self.listModel.advanced];
                advanced = self.listModel.advanced;
            }
            
        }else {
            seedCloudInfoView *view = [seedCloudInfoView new];
            [_needView addSubview:view];
            view.userInteractionEnabled = YES;
            
            if ([self.paramArr containsObject:array[i]]&&![array[i] isEqualToString:@"胸径(cm)"]) {
                [view setTextContent:array[i]];
            }else{
                [view setTextContent:[NSString stringWithFormat:@"*%@",array[i]]];
            }
            
            view.textFied.delegate = self;
            view.tag = i + 100;
            view.textFied.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            
            
            UIView *lastView = [_needView viewWithTag:(i -1) +100];
            view.sd_layout.leftSpaceToView(_needView,0).topSpaceToView(lastView, 0).heightIs(55).widthIs(WindowWith);
            [_needView setupAutoHeightWithBottomView:view bottomMargin:10];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapInfoView:)];
            tap.numberOfTapsRequired = 1;
            tap.numberOfTouchesRequired= 1;
            if (i ==0||i ==1) {
                view.downImg.hidden = NO;
                view.textFied.userInteractionEnabled = NO;
                [view addGestureRecognizer:tap];
                if (i==0) {
                    view.textFied.placeholder = @"请选择苗木产地";
                }else{
                    view.textFied.placeholder = @"请选择您的品种";
                }
            }
            if (self.listModel != nil) {
                if ([array[i] isEqualToString:@"产地"]) {
                    view.textFied.text = self.listModel.location;
                }else if ([array[i] isEqualToString:@"品种"]){
                    plant_type = self.listModel.plant_type;
                    for (NSDictionary *dic in plantArr) {
                        if ([dic[@"parent_nursery_name"] containsString:self.listModel.parent_nursery_name]) {
                            nameArr = dic[@"list"];
                            for (NSDictionary *Dic in nameArr) {
                                if ([[NSString stringWithFormat:@"%@",Dic[@"nursery_type_id"]] isEqualToString:self.listModel.plant_type]){
                                    view.textFied.text = Dic[@"nursery_type_name"];
                                }
                            }
                        }
                    }
                }else if ([array[i] isEqualToString:@"价格"]){
                    view.textFied.text = self.listModel.loading_price;
                }else if ([array[i] isEqualToString:@"苗源地址"]){
                    view.textFied.text = self.listModel.nursery_address;
                }else if ([array[i] isEqualToString:@"胸径(cm)"]){
                    view.textFied.text = self.listModel.diameter;
                }else if ([array[i] isEqualToString:@"高度(cm)"]){
                    view.textFied.text = self.listModel.heignt;
                }else if ([array[i] isEqualToString:@"冠幅(cm)"]){
                    view.textFied.text = self.listModel.crown;
                }else if ([array[i] isEqualToString:@"树龄(年)"]){
                    view.textFied.text = self.listModel.tree_age;
                }else if ([array[i] isEqualToString:@"分枝点(cm)"]){
                    view.textFied.text = self.listModel.branch_point;
                }else if ([array[i] isEqualToString:@"杆径(cm)"]){
                    view.textFied.text = self.listModel.rod_diameter;
                }else if ([array[i] isEqualToString:@"公斤"]){
                    view.textFied.text = self.listModel.weight;
                }
            }
        }
    }
}
//选择苗木产地以及品种
- (void)tapInfoView:(UITapGestureRecognizer *)tap
{
    
    UIView *view = tap.view;
    if (view.tag == 101) {
        
        [self selectedPlantView];
        
    }else if (view.tag == 100){
        [self chooseAdress:@"选择产地" tag:view.tag];
    }
    
}
//选择品种弹层
- (void)selectedPlantView
{
    //获取所有品种名
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in nameArr) {
        [array addObject:dic[@"nursery_type_name"]];
    }
    seedCloudInfoView *view = (seedCloudInfoView *)[_BaseScrollView viewWithTag:101];
    NSString *str;
    if (view.textFied.text.length >0) {
        str = view.textFied.text;
    }else{
        str = @"";
    }
    PlantSelectedView *plantView = [[PlantSelectedView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [plantView setPlantBtn:array text:str];
    plantView.selectBlock = ^(NSInteger index){
        
        self->plant_name = array[index];
        view.textFied.text = array[index];
        
        for (NSDictionary *dic in self->nameArr) {
            if ([dic[@"nursery_type_name"] isEqualToString:self->plant_name]) {
                self->plant_type = [NSString stringWithFormat:@"%@",dic[@"nursery_type_id"]];
            }
        }
    };
}

- (void)home:(id)sender
{
    [self referAction:nil];
}
//提交
- (void)referAction:(UIButton *)button
{
    [_BaseScrollView endEditing:YES];
    
    for (NSString *Str in mainArr) {
        if (![self writeParameterWithType:Str]) {
            return;
        }
    }
    
    [self addWaitingView];
    if (self.type==ENT_Edit) {
        //编辑状态
        NSString *remark;
        if (_textView.text.length >0) {
            remark = _textView.text;
        }else{
            remark = @"";
        }
        [network editNerseryDetailWith:plant_type plant_name:plant_name show_pic:self.listModel.show_pic loading_price:loading_price location:location heignt:heignt crown:crown tree_age:tree_age diameter:diameter num:number unit:unit rod_diameter:rod_diameter four:@"" ground_diameter:@"" branch_point:branch_point offspring:@"" seedling_type:@"" dendroids:@"" branch:@"" density:@"" soil_ball_dress:@"" soil_ball:@"" soil_ball_size:@"" soil_thickness:@"" soil_ball_shape:@"" safeguard:@"" remark:remark nursery_address:nursery_address material:@"" subsoil:@"" size:@"" wear_bag:@"" a_require:@"" advanced:advanced has_trunk:@"" create_time:@"" status:@"0" nursery_id:stringFormatInt((int)self.listModel.nursery_id) weight:weight success:^(NSDictionary *obj) {
            
            [self addSucessView:@"苗木云编辑成功！" type:1];
            [self reAssignListModel];
            //            [self back:nil];
            [self popViewController:1];
            [self removeWaitingView];
        } failure:^(NSDictionary *obj2) {
            
        }];
        
    }else {
        //判断是否已经上传了3张图片，通过判断图片数组中是否含有加号图片
        BOOL isCount = YES;
        UIImage *addimg=Image(@"fb_uploadimg.png");
        NSData *data = UIImagePNGRepresentation(addimg);
        for (int i=0; i<imgsArray.count; i++) {
            UIImage *imgA=[imgsArray objectAtIndex:i];
            NSData *data1 = UIImagePNGRepresentation(imgA);
            if ([data isEqual:data1]) {
                isCount = NO;
            }
        }
        
        if (isCount) {
            
            [AliyunUpload uploadImage:imgsArray FileDirectory:ENT_fileImageBody success:^(NSString *obj) {
                
                //判断是否填写备注信息
                NSString *remark;
                if (self->_textView.text.length >0) {
                    remark = self->_textView.text;
                }else{
                    remark = @"";
                }
                
                [network sendNerseryDetailWith:self->plant_type plant_name:self->plant_name show_pic:obj loading_price:self->loading_price location:self->location heignt:self->heignt crown:self->crown tree_age:self->tree_age diameter:self->diameter num:self->number unit:self->unit rod_diameter:self->rod_diameter four:@"" ground_diameter:@"" branch_point:self->branch_point offspring:@"" seedling_type:@"" dendroids:@"" branch:@"" density:@"" soil_ball_dress:@"" soil_ball:@"" soil_ball_size:@"" soil_thickness:@"" soil_ball_shape:@"" safeguard:@"" remark:remark nursery_address:self->nursery_address material:@"" subsoil:@"" size:@"" wear_bag:@"" a_require:@"" advanced:self->advanced has_trunk:@"" create_time:@"" weight:self->weight status:@"0" success:^(NSDictionary *obj) {
                    
                    [self addSucessView:@"苗木云发布成功！" type:1];
                    [self popViewController:1];
                    [self removeWaitingView];
                } failure:^(NSDictionary *obj2) {
                    
                }];
                
			} failure:^(NSError *error) {
				
			}];
        }else {
            [self addSucessView:@"请上传3张真实苗木图片" type:2];
        }
    }
}

//model重新赋值以便回调
- (void)reAssignListModel
{
    self.listModel.plant_type = plant_type;
    self.listModel.num = number;
    self.listModel.unit = unit;
    self.listModel.advanced = advanced;
    NSString *remark;
    if (_textView.text.length >0) {
        remark = _textView.text;
    }else{
        remark = @"";
    }
    self.listModel.remark = remark;
    self.listModel.location = location;
    self.listModel.nursery_address = nursery_address;
    self.listModel.plant_name = plant_name;
    self.listModel.loading_price = loading_price;
    self.listModel.diameter = diameter;
    self.listModel.heignt = heignt;
    self.listModel.crown = crown;
    self.listModel.tree_age = tree_age;
    self.listModel.branch_point = branch_point;
    self.listModel.rod_diameter = rod_diameter;
    self.listModel.weight = weight;
    
    //回调
    self.selectEditBlock(self.listModel);
}

//判断每个必填参数是否填写
- (BOOL)writeParameterWithType:(NSString *)parameter
{
    if ([mainArr containsObject:parameter]) {
        NSInteger index = [mainArr indexOfObject:parameter];
        
        if ([parameter isEqualToString:@"品种"]){
            if ([plant_type isEqualToString:@""]) {
                [self addSucessView:[NSString stringWithFormat:@"请上传%@",parameter] type:2];
                return NO;
            }
        }
        
        if ([parameter isEqualToString:@"数量"]){
            if ([numView.numLbl.text intValue] > 0 ) {
                number = numView.numLbl.text;
            }else{
                [self addSucessView:[NSString stringWithFormat:@"请上传%@",parameter] type:2];
                return NO;
            }
            
        }else if ([parameter isEqualToString:@"苗源地址"]){
            seedCloudInfoView *view = [_needView viewWithTag:index+100];
            nursery_address = view.textFied.text;
            if (nursery_address.length <= 0) {
                [self addSucessView:[NSString stringWithFormat:@"请上传%@",parameter] type:2];
                return NO;
            }
        }else if ([parameter isEqualToString:@"优势"]){
            if (advanced.length<=0) {
                [self addSucessView:[NSString stringWithFormat:@"请上传%@",parameter] type:2];
                return NO;
            }
        }else{
            seedCloudInfoView *view = [_needView viewWithTag:index+100];
            if (view.textFied.text.length>0) {
                if ([parameter isEqualToString:@"产地"]) {
                    location = view.textFied.text;
                }else if ([parameter isEqualToString:@"价格"]){
                    if (![IHUtility IsFloat:view.textFied.text]) {
                        [self addSucessView:@"价格输入有误" type:2];
                        return NO;
                    }
                    loading_price = view.textFied.text;
                }else if ([parameter isEqualToString:@"胸径(cm)"]){
                    if (![IHUtility IsFloat:view.textFied.text]) {
                        [self addSucessView:@"胸径输入有误" type:2];
                        return NO;
                    }
                    diameter = view.textFied.text;
                }else if ([parameter isEqualToString:@"高度(cm)"]){
                    if (![IHUtility IsFloat:view.textFied.text]) {
                        [self addSucessView:@"高度输入有误" type:2];
                        return NO;
                    }
                    heignt = view.textFied.text;
                }else if ([parameter isEqualToString:@"冠幅(cm)"]){
                    if (![IHUtility IsFloat:view.textFied.text]) {
                        [self addSucessView:@"冠幅输入有误" type:2];
                        return NO;
                    }
                    crown = view.textFied.text;
                }else if ([parameter isEqualToString:@"树龄(年)"]){
                    if (![IHUtility IsFloat:view.textFied.text]) {
                        [self addSucessView:@"树龄输入有误" type:2];
                        return NO;
                    }
                    tree_age = view.textFied.text;
                }else if ([parameter isEqualToString:@"分枝点(cm)"]){
                    
                    if (![IHUtility IsFloat:view.textFied.text]) {
                        [self addSucessView:@"分枝点输入有误" type:2];
                        return NO;
                    }
                    branch_point = view.textFied.text;
                }else if ([parameter isEqualToString:@"杆径(cm)"]){
                    if (![IHUtility IsFloat:view.textFied.text]) {
                        [self addSucessView:@"杆径输入有误" type:2];
                        return NO;
                    }
                    rod_diameter = view.textFied.text;
                }else if ([parameter isEqualToString:@"公斤"]){
                    if (![IHUtility IsFloat:view.textFied.text]) {
                        [self addSucessView:@"公斤输入有误" type:2];
                        return NO;
                    }
                    weight = view.textFied.text;
                }
            }else{
                if ([parameter isEqualToString:@"产地"]||[parameter isEqualToString:@"价格"]||[parameter isEqualToString:@"胸径(cm)"]) {
                    [self addSucessView:[NSString stringWithFormat:@"请上传%@",parameter] type:2];
                    return NO;
                }
            }
        }
    }
    
    return YES;
}
- (void)btnSelectPhoto_Click:(id)sender
{
    [_BaseScrollView endEditing:YES];
    
    [actionSheet showWithSender:self animate:YES completion:^(NSArray<UIImage *> * _Nonnull selectPhotos) {
        for (int i=0; i<selectPhotos.count; i++) {
            UIImage *img2 = [selectPhotos objectAtIndex:i];
            if (!self->isFirstAddPhoto) {
                [self->imgsArray removeAllObjects];
                [self->imgsArray addObject:img2];
                self->isFirstAddPhoto=YES;
            }else{
                [self->imgsArray insertObject:img2 atIndex:0];
            }
        }
        //如果选择的图片多余5张 则选择最先的5张
        if (self->imgsArray.count>=3) {
            NSMutableArray *arr2=[[NSMutableArray alloc]init];
            for (int i=0; i<3; i++) {
                UIImage *img=[self->imgsArray objectAtIndex:i];
                [arr2 addObject:img];
            }
            [self->imgsArray removeAllObjects];
            [self->imgsArray addObjectsFromArray:arr2];
            //            UIImage *addimg=Image(@"fb_uploadimg.png");
            //            [imgsArray addObject:addimg];
        }
        UIImage *addimg=Image(@"fb_uploadimg.png");
        NSData *data = UIImagePNGRepresentation(addimg);
        if (self->imgsArray.count<3) {
            UIImage *img1=[self->imgsArray lastObject];
            NSData *data1 = UIImagePNGRepresentation(img1);
            if (![data1 isEqual:data]) {
                [self->imgsArray addObject:addimg];
            }
        }
        [self->_collectionView reloadData];
        self->_collectionView.sd_layout.heightIs(((self->imgsArray.count-1)/3+1) *((WindowWith-60)/3 +20));
        [self->_topView setupAutoHeightWithBottomView:self->_collectionView bottomMargin:15];
    }];
}

//选择地址
- (void)chooseAdress:(NSString *)title tag:(NSInteger)tag
{
    [_BaseScrollView endEditing:YES];
    if(_adressPickView == nil)
    {
        _adressPickView = [[JLAddressPickView alloc] initWithParams:title type:0];
        _adressPickView.tag=tag;
        _adressPickView.ActionSheetDelegate = self;
    }
    [_adressPickView show];
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (textField.superview.superview.tag == 100 || textField.superview.superview.tag == 101) {
        [textField resignFirstResponder];
    }
}

#pragma mark - collection数据源代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return imgsArray.count;
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
    
    //判断最后一张是否已经添加了5张图片 如果添加了5张最后一张就不能点击
    UIImage *addimg=Image(@"fb_uploadimg.png");
    NSData *data = UIImagePNGRepresentation(addimg);
    if (imgsArray.count>=3) {
        UIImage *img1;
        if ([[imgsArray lastObject] isKindOfClass:[UIImage class]]) {
            img1=[imgsArray lastObject];
        }else {
            NSString *url = [imgsArray lastObject];
            img1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
        }
        NSData *data1 = UIImagePNGRepresentation(img1);
        if (![data1 isEqual:data]) {
            cell.m_imgView.userInteractionEnabled = NO;
        }
    }
    cell.deleteBtn.tag = [indexPath row];
    if ([indexPath row] != (imgsArray.count - 1)){
        [cell.deleteBtn setHidden:NO];
        
    }
    else {
        if (imgsArray.count >= 3) {
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
    
    if (self.listModel!=nil) {
        NSString *imgUrl=[imgsArray objectAtIndex:indexPath.row];
        [cell.m_imgView setImageAsyncWithURL:[NSString stringWithFormat:@"%@",imgUrl] placeholderImage:DefaultImage_logo];
        cell.deleteBtn.hidden=YES;
    }else{
        UIImage *img=[imgsArray objectAtIndex:indexPath.row];
        [cell.m_imgView setImage:img];
        
        cell.m_imgView.tag = [indexPath row];
        cell.deleteBtn.tag=indexPath.row;
        [cell.deleteBtn addTarget:self action:@selector(deleteIMGClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}

//点击添加图片的加号按钮
- (void) tapProfileImage:(UITapGestureRecognizer *)gestureRecognizer{
    
    UIImageView *tableGridImage = (UIImageView*)gestureRecognizer.view;
    NSInteger index = tableGridImage.tag;
    if (index == (imgsArray.count -1))
    {
        [self btnSelectPhoto_Click:nil];
    }else{
        
    }
}

//删除已选择的图片
-(void)deleteIMGClick:(UIButton*)sender{
    [imgsArray removeObjectAtIndex:sender.tag];
    UIImage *addimg=Image(@"fb_uploadimg.png");
    NSData *data = UIImagePNGRepresentation(addimg);
    if (imgsArray.count<3) {
        UIImage *img1=[imgsArray lastObject];
        NSData *data1 = UIImagePNGRepresentation(img1);
        if (![data1 isEqual:data]) {
            [imgsArray addObject:addimg];
        }
    }
    [_collectionView reloadData];
    
    //重新刷新布局
    _collectionView.sd_layout.heightIs(((imgsArray.count-1)/3+1) *((WindowWith-60)/3 +20));
    [_topView setupAutoHeightWithBottomView:_collectionView bottomMargin:15];
//    
//    if (imgsArray.count==0) {
//        isSelectedPhoto=NO;
//    }
}

//接收选择的城市和省份名称
- (void)ActionSheetDoneHandle:(JLAddressPickView *)pickViewComponent selectedProData:(NSString *)SelectedStr selectedCityData:(NSString *)SelectedCityStr
{
    seedCloudInfoView *view = (seedCloudInfoView *)[_BaseScrollView viewWithTag:pickViewComponent.tag];
    
    view.textFied.text = SelectedCityStr;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
