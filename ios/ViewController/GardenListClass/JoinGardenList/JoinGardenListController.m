//
//  JoinGardenListController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/11/24.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "JoinGardenListController.h"
#import "InPutJoinGardenModel.h"

//#import "ZLPhotoActionSheet.h"

#import "ValuePickerView.h"     //类别选择

typedef void (^CancelButBut) ();

@interface JoinGardenListSuccesView : UIView{
    UIImageView *imageView;
    UILabel *TitleLabel;
    UILabel *infoLabel;
    UIButton *SureBut;
}
@property(nonatomic,copy) CancelButBut CancelBlock;

- (void)setheadImage:(NSString *)headImage andTitle:(NSString *)title andconText:(NSString *)conText;

@end

@implementation JoinGardenListSuccesView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = kWidth(7);
        [self addlayoutSubView];
    }
    return self;
}
- (void) addlayoutSubView {
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, kWidth(202))];
    [self addSubview:imageView];
    
    TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.bottom + kWidth(17), self.width, kWidth(17))];
    TitleLabel.textAlignment = NSTextAlignmentCenter;
    TitleLabel.font = darkFont(font(17));
    [self addSubview:TitleLabel];
    
    infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, TitleLabel.bottom + kWidth(13), self.width, kWidth(16))];
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.font = boldFont(font(16));
    infoLabel.textColor = kColor(@"#2e2e2e");
    [self addSubview:infoLabel];
    
    SureBut = [UIButton buttonWithType:UIButtonTypeSystem];
    SureBut.frame = CGRectMake(0, infoLabel.bottom + kWidth(36), kWidth(150), kWidth(40));
    SureBut.layer.cornerRadius = SureBut.height/2.;
    [SureBut setTitle:@"确定" forState:UIControlStateNormal];
    SureBut.backgroundColor = kColor(@"9573ce");
    [SureBut setTitleColor:kColor(@"ffffff") forState:UIControlStateNormal];
    SureBut.titleLabel.font = boldFont(font(16));
    SureBut.centerX = self.width/2;
    [SureBut addTarget:self action:@selector(SureAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:SureBut];
}
- (void)setheadImage:(NSString *)headImage andTitle:(NSString *)title andconText:(NSString *)conText {
    [imageView sd_setImageWithURL:[NSURL URLWithString:headImage] placeholderImage:kImage(@"garden-img-bjz")];
    TitleLabel.text = title;
    infoLabel.text = conText;
    
}
- (void) SureAction {
    if (self.CancelBlock) {
        self.CancelBlock();
    }
}
@end







@interface JoinGardenListCell () {
    
}
@end

@implementation JoinGardenListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createText];
        //  添加输入完成会回调通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanging:) name:UITextFieldTextDidChangeNotification object:self.textField];

    }
    return self;
}
- (void) createText{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(kWidth(20), kWidth(10), iPhoneWidth - kWidth(40), kWidth(46))];
    bgView.backgroundColor = kColor(@"#E9E9E9");
    [self.contentView addSubview:bgView];
    bgView.layer.cornerRadius = kWidth(6);
    _textField = [[IHTextField alloc] initWithFrame:CGRectMake(kWidth(16), 0, bgView.width - kWidth(32), kWidth(25))];
    [bgView addSubview:_textField];
    _textField.centerY = bgView.height/2;
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, height(self.contentView) - 1, iPhoneWidth, 1)];
    line.backgroundColor = cLineColor;
    [self.contentView addSubview:line];
    self.lineLabel = line;
    _textField.font = sysFont(font(15));
}

-(void)textFieldChanging:(id)sender{
    if (self.inputBlock) {
        self.inputBlock(self.textField.text);
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}
@end




@interface JoinGardenListController () <UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UITextViewDelegate,UITextFieldDelegate>{
//    NSString *CompanyStr;           //企业名称
//    NSString *nameStr;              //姓名
//    NSString *phoneStr;             //电话
//    NSString *CompanyInfo;          //企业地址
//    NSString *guimoinfoStr;         //种植规模
//    NSString *guigestr;             //规格
//    NSString *miaomuNum;            //数量

    NSMutableDictionary *InputDic;  //填写内容
    NSMutableArray *DataArr;        //填写榜单那内容
    UITableView *_tableView;        //
    UIButton *_submitBut;
    UITextField *_textField;
    
    UIView *footView;
    ZLPhotoActionSheet *actionSheet;
    BOOL isFirstAddPhoto;
    UICollectionView *_collectionView;
    NSMutableArray *imgsArray;
//    BOOL isSelectedPhoto;
                 //榜单类别
    
}
@property (nonatomic,strong)  UITableView *tableView;

@property (nonatomic,strong)  NSMutableArray *typeArray;      //类别
@property (nonatomic,strong)  NSMutableArray *bangListArr;    //榜单

@property (nonatomic, strong) PlaceholderTextView *CompanyInfoTextView;
@property (nonatomic, strong) ValuePickerView *TeampickerView;      //类别选择
@property (nonatomic,strong) InPutJoinGardenModel *currentModel;    //当前榜单类别
@property (nonatomic,strong) gardensubListsModel *gardensubmodel;   //当前榜单
@property (nonatomic,strong)  UILabel *typeLab;             //榜单类别
@property (nonatomic,strong)  UILabel *bangdanLab;          //榜单
@end

static NSString *JoinGardenListCellID = @"JoinGardenListCell";

@implementation JoinGardenListController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [leftbutton setImage:kImage(@"icon_fh_b") forState:UIControlStateNormal];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    UIImage *bgImage1 = [UIImage imageWithColor:kColor(@"#54c9c3") size:CGSizeMake(iPhoneWidth, KtopHeitht)];
    UIImage *bgImage = [bgImage1 resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    [self.navigationController.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //设置全局状态栏字体颜色为黑色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    leftbutton.frame = CGRectMake(0, 0, 44, 44);
    [self.navigationController.navigationBar setBackgroundImage:Image(@"") forBarMetrics:UIBarMetricsDefault];
}

- (UILabel *)typeLab {
    if (_typeLab == nil) {
        _typeLab = [[UILabel alloc] init];
        _typeLab.textColor = kColor(@"#9B9B9B");
        _typeLab.text = @"请选择榜单类别";
        _typeLab.font = [UIFont fontWithName:@"PingFangSC-Regular" size: font(16)];
    }
    return _typeLab;
}
- (UILabel *)bangdanLab {
    if (_bangdanLab == nil) {
        _bangdanLab = [[UILabel alloc] init];
        _bangdanLab.textColor = kColor(@"#9B9B9B");
        _bangdanLab.text = @"请选择榜单";
        _bangdanLab.font = [UIFont fontWithName:@"PingFangSC-Regular" size: font(16)];
    }
    return _bangdanLab;
}

- (PlaceholderTextView *)CompanyInfoTextView {
    if (_CompanyInfoTextView == nil) {
        _CompanyInfoTextView = [[PlaceholderTextView alloc] initWithFrame:CGRectMake(kWidth(20), kWidth(10), iPhoneWidth - kWidth(40), kWidth(190))];
        _CompanyInfoTextView.backgroundColor = kColor(@"#E9E9E9");
        _CompanyInfoTextView.layer.cornerRadius = kWidth(6);
        _CompanyInfoTextView.delegate = self;
        _CompanyInfoTextView.placeholderColor = kColor(@"#9B9B9B");
        _CompanyInfoTextView.placeholderFont = sysFont(14);
        _CompanyInfoTextView.font = sysFont(14);
        _CompanyInfoTextView.placeholder = @"企业介绍";
    }
    return _CompanyInfoTextView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = nil;
    if (self.titleStr) {
        [self setTitle:self.titleStr andTitleColor:kColor(@"#ffffff")];
    }
    [self inPutGardenListinfoData];
    [self getJoinBangList];
    self.typeArray = [[NSMutableArray alloc] init];
    InputDic = [[NSMutableDictionary alloc] init];
    [self createTableview];
}
- (void) getJoinBangList{
    [self addWaitingView];
    [network httpRequestWithParameter:nil method:getJoinGardenListUrl success:^(NSDictionary *dic) {
        [self removeWaitingView];
        NSDictionary *dict = dic[@"content"];
        NSArray *arr = dict[@"gardenCategoryPojos"];
        if (arr.count > 0) {
            for (NSDictionary *mDic in arr) {
                InPutJoinGardenModel *model = [[InPutJoinGardenModel alloc] initWithDictionary:mDic error:nil];
                [self->_typeArray addObject:model];
            }
        }
    } failure:^(NSDictionary *dic) {
        [self removeWaitingView];
    }];
}



- (void) inPutGardenListinfoData {
    DataArr = [[NSMutableArray alloc] init];
    self.TeampickerView = [[ValuePickerView alloc]init];
};


- (void) createTableview {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight - KtopHeitht - kWidth(50)) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.tableView = _tableView;
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.estimatedSectionHeaderHeight = 8;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:_tableView];
    _tableView.estimatedSectionHeaderHeight = 0.;
    
    _submitBut = [UIButton buttonWithType:UIButtonTypeSystem];
    _submitBut.frame = CGRectMake(0,_tableView.bottom, iPhoneWidth, kWidth(50));
    _submitBut.backgroundColor = kColor(@"#05c1b0");
    [_submitBut setTitle:@"提交" forState:UIControlStateNormal];
    [_submitBut setTitleColor:kColor(@"#ffffff") forState:UIControlStateNormal];
    _submitBut.titleLabel.font = boldFont(17);
    [_submitBut addTarget:self action:@selector(submitJoinGardenListInfoAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_submitBut];
    
    
    footView = [[UIView alloc]init];
    CGFloat f=(WindowWith-kWidth(80))/3;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(f, f);
    layout.sectionInset = UIEdgeInsetsMake(0, 5,0, 5);
    //layout.sectionInset.right = layout.sectionInset.right + w;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 10;
    footView.frame = CGRectMake(0, 0, iPhoneWidth, f + kWidth(30) + kWidth(70));
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(kWidth(15), kWidth(30), WindowWith-kWidth(30), f+kWidth(10)) collectionViewLayout:layout];
    [footView addSubview:_collectionView];
    footView.backgroundColor = [UIColor whiteColor];
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
    _tableView.tableFooterView = footView;
    imgsArray=[[NSMutableArray alloc]init];
    
    UILabel *photoLab = [[UILabel alloc] init];
    photoLab.text = @"三张产品图*";
    photoLab.textColor =  kColor(@"#727272");
    photoLab.font = sysFont(14);
    [footView addSubview:photoLab];
    [photoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_collectionView.mas_left);
        make.top.mas_equalTo(self->_collectionView.mas_bottom).mas_offset(3);
        make.right.mas_offset(self->footView.right).mas_offset(-kWidth(20));
        make.height.mas_offset(17);
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return DataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kWidth(66);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kWidth(76);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *infoLab = [[UILabel alloc] initWithFrame:CGRectMake(kWidth(20), kWidth(10), iPhoneWidth - kWidth(50), kWidth(14))];
    infoLab.textAlignment = NSTextAlignmentRight;
    infoLab.font = [UIFont fontWithName:@"PingFangSC-Regular" size: font(12)];
    infoLab.text = @"“*”为必填项目";
    infoLab.textColor = kColor(@"#9B9B9B");
    [view addSubview:infoLab];
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(kWidth(20), infoLab.bottom + kWidth(3), iPhoneWidth - kWidth(40), kWidth(46))];
    [view addSubview:bgView];
    bgView.backgroundColor = kColor(@"#E9E9E9");
    bgView.layer.cornerRadius = kWidth(6);
    self.typeLab.frame = CGRectMake(kWidth(16), 0, bgView.width - kWidth(60),kWidth(25));
    self.typeLab.textColor = kColor(@"#9B9B9B");
    self.typeLab.centerY = bgView.height/2;
    [bgView addSubview:self.typeLab];
    
    UIImageView *rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(bgView.width - kWidth(33), 0, kWidth(19), kWidth(13))];
    rightImg.image = kImage(@"icon_zhankai");
    rightImg.centerY = _typeLab.centerY;
    [bgView addSubview:rightImg];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SlideTypeAction:)];
    // 允许用户交互
    bgView.userInteractionEnabled = YES;
    [bgView addGestureRecognizer:tap];
    
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return kWidth(66) + kWidth(200);
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(kWidth(20), kWidth(10) + kWidth(3), iPhoneWidth - kWidth(40), kWidth(46))];
    [view addSubview:bgView];
    bgView.backgroundColor = kColor(@"#E9E9E9");
    bgView.layer.cornerRadius = kWidth(6);
    self.bangdanLab.frame = CGRectMake(kWidth(16), 0, bgView.width - kWidth(60),kWidth(25));
    self.bangdanLab.textColor = kColor(@"#9B9B9B");
    self.bangdanLab.centerY = bgView.height/2;
    [bgView addSubview:self.bangdanLab];
    
    UIImageView *rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(bgView.width - kWidth(33), 0, kWidth(19), kWidth(13))];
    rightImg.image = kImage(@"icon_zhankai");
    rightImg.centerY = _bangdanLab.centerY;
    [bgView addSubview:rightImg];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SlidebangdanAction:)];
    // 允许用户交互
    bgView.userInteractionEnabled = YES;
    [bgView addGestureRecognizer:tap];
    self.CompanyInfoTextView.frame = CGRectMake(kWidth(20), bgView.bottom + kWidth(20), iPhoneWidth - kWidth(40), kWidth(190));
    [view addSubview:self.CompanyInfoTextView];
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
     NSString *identifier = [NSString stringWithFormat:@"JoinGardenListCellIdentifier%ld",indexPath.row];
    
    JoinGardenListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    buttonJsonModel *model = DataArr[indexPath.row];
    if (!cell) {
        cell = [[JoinGardenListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.inputBlock = ^(NSString *inputResult) {
        model.valueStr = inputResult;
    };
//    JoinGardenListCell *cell = [tableView dequeueReusableCellWithIdentifier:JoinGardenListCellID];
//    if (cell == nil) {
//        cell = [[JoinGardenListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:JoinGardenListCellID];
//        cell.textField.delegate = self;
//    }
    cell.lineLabel.hidden = YES;
    cell.textField.font = sysFont(16);
    cell.selectionStyle = UITableViewCellStyleDefault;
    [cell.textField setValue:[NSNumber numberWithInt:5] forKey:@"paddingLeft"];
    
    if ([model.name containsString:@"联系方式"]) {
        cell.textField.keyboardType = UIKeyboardTypePhonePad;
        cell.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    if ([model.name containsString:@"数量"]) {
        cell.textField.keyboardType = UIKeyboardTypeDecimalPad;
        cell.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    NSString *String;
    if ([model.isBiTian isEqualToString:@"1"]) {
        String = [NSString stringWithFormat:@" 请输入%@ *",model.name];
    }else {
        String = [NSString stringWithFormat:@" 请输入%@",model.name];
    }
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:String attributes:@{NSForegroundColorAttributeName:kColor(@"#727272"),
        NSFontAttributeName:cell.textField.font}];
    cell.textField.attributedPlaceholder = attrString;
    return cell;
}
#pragma - mark 提交加入榜单
- (void) submitJoinGardenListInfoAction {
    if ([self.typeLab.text isEqualToString:@"请选择榜单类别"]) {
        [self showHomeHint:@"请先选择榜单类别" backgroundColor:kColor(@"#000000") alpha:0.8 yOffset:0 textColor:kColor(@"#ffffff")];
        return;
    }
    if ([self.bangdanLab.text isEqualToString:@"请选择榜单"]) {
        [self showHomeHint:@"请选择榜单" backgroundColor:kColor(@"#000000") alpha:0.8 yOffset:0 textColor:kColor(@"#ffffff")];
        return;
    }
    [InputDic removeAllObjects];
    for (int i = 0; i < DataArr.count; i ++) {
//        JoinGardenListCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        buttonJsonModel *model = DataArr[i];
        if ([model.isBiTian isEqualToString:@"1"]) {
            if (model.valueStr.length <= 0) {
                [self showTextHUD:[NSString stringWithFormat:@"请输入%@",model.name]];
                return;
            }
        }
        [InputDic setObject:model.valueStr forKey:model.key];
     }
     [InputDic setObject:self.CompanyInfoTextView.text forKey:@"gardenContent"]; //公司简介

     [InputDic setObject:self.currentModel.jid forKey:@"cateId"];        //榜单类别ID
     [InputDic setObject:self.gardensubmodel.listUuid forKey:@"gardenListUuid"];//榜单ID
      NSLog(@"InputDic == %@",InputDic);
    if (imgsArray.count < 3) {
        [self showTextHUD:@"请选择三张图片上传"];
        return;
    }
    [self sendNewGardenListInfo];
}

- (void) sendNewGardenListInfo {
	
	[self addWaitingView];
	[AliyunUpload uploadImage:imgsArray FileDirectory:ENT_fileImagesAdd success:^(NSString *obj) {
		NSLog(@"--------           %@%@",@"http://8yyq8.com",obj);
		NSLog(@"--------           %@%@",@"https://image.8yyq8.com",obj);
		[self->InputDic setObject:obj forKey:@"gardenPic"];
		[network httpRequestWithParameter:self->InputDic method:JoinGardenListUrl success:^(NSDictionary *dic) {
			[self removeWaitingView];
			[self popJoinGardenListSuccess];
		} failure:^(NSDictionary *dic) {
			[self removeWaitingView];
		}];
		
	} failure:^(NSError *error) {
		[self removeWaitingView];
	}];
	
    
}

#pragma mark - Pop
- (void) popJoinGardenListSuccess {
    JoinGardenListSuccesView * gardPopView = [[JoinGardenListSuccesView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth - kWidth(84), kWidth(354))];
    [gardPopView setheadImage:self.successImg andTitle:@"提交成功" andconText:@"客服小姐姐会尽快联系您"];
    [self showPopupWithStyle:CNPPopupStyleCentered popupView:gardPopView];
    __weak typeof (self) weekSelf = self;
    gardPopView.CancelBlock = ^{
        [weekSelf dismissPopupController];
        [weekSelf.navigationController popViewControllerAnimated:YES];
    };
}
#pragma mark - 界面弹出框
- (void)showPopupWithStyle:(CNPPopupStyle)popupStyle popupView:(UIView *)popupView {
    self.popupViewController = [[CNPPopupController alloc] initWithContents:@[popupView]];
    self.popupViewController.theme = [CNPPopupTheme defaultTheme:popupView.frame.size.width];
    self.popupViewController.theme.popupStyle = popupStyle;
    self.popupViewController.theme.presentationStyle = CNPPopupPresentationStyleFadeIn;
    [self.popupViewController presentPopupControllerAnimated:YES];
}
- (void)dismissPopupController {
    [self.popupViewController dismissPopupControllerAnimated:YES];
}

#pragma - mark 选择榜单类别
-(void)SlideTypeAction:(UITapGestureRecognizer *)sender{
//    NSLog(@"选择榜单类别");
    [_textField resignFirstResponder];
    [self.CompanyInfoTextView resignFirstResponder];
    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
    for (InPutJoinGardenModel *model in _typeArray) {
        [tempArr addObject:model.cateName];
    }
    if (tempArr.count <= 0) {
        return;
    }
    _TeampickerView.dataSource = tempArr;
    _TeampickerView.pickerTitle = @"请选择榜单类别";
    WS(weakSelf);
    _TeampickerView.valueDidSelect = ^(NSString *value){
        NSArray * stateArr = [value componentsSeparatedByString:@"/"];
        NSString *str = stateArr[0];
        weakSelf.typeLab.text = str;
        NSInteger index = [stateArr[1] integerValue];
        weakSelf.currentModel = weakSelf.typeArray[index-1];
        if(weakSelf.currentModel.gardenLists.count > 0){
            weakSelf.gardensubmodel = weakSelf.currentModel.gardenLists[0];
            weakSelf.bangdanLab.text = weakSelf.gardensubmodel.name;
        }else {
            weakSelf.bangdanLab.text = @"请选择榜单";
        }
        [weakSelf getListData];
    };
    [_TeampickerView show];
}
- (void) getListData {
    NSData * jsonData = [_currentModel.buttonJson dataUsingEncoding:NSUTF8StringEncoding];
    //json解析
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    [DataArr removeAllObjects];
    for (NSDictionary *dict in arr) {
        buttonJsonModel *model = [[buttonJsonModel alloc] initWithDictionary:dict error:nil];
        model.valueStr = @"";
        if ([model.isLook isEqualToString:@"1"]) {
            [DataArr addObject:model];
        }
    }
    for (int i = 0; i < DataArr.count; i ++) {
        JoinGardenListCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        cell.textField.text = @"";
    }
    WS(weakSelf);
    [weakSelf.tableView reloadData];
}
#pragma - mark 选择榜单
-(void)SlidebangdanAction:(UITapGestureRecognizer *)sender {
    [_textField resignFirstResponder];
    [self.CompanyInfoTextView resignFirstResponder];
    
    if ([self.typeLab.text isEqualToString:@"请选择榜单类别"]) {
        [self showHomeHint:@"请先选择榜单类别" backgroundColor:kColor(@"#000000") alpha:0.8 yOffset:0 textColor:kColor(@"#ffffff")];
        return;
    }
    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
    for (gardensubListsModel *model in _currentModel.gardenLists) {
        [tempArr addObject:model.name];
    }
    if (tempArr.count <= 0) {
        return;
    }
    _TeampickerView.dataSource = tempArr;
    _TeampickerView.pickerTitle = @"请选择榜单";
    WS(weakSelf);
    _TeampickerView.valueDidSelect = ^(NSString *value){
        NSArray * stateArr = [value componentsSeparatedByString:@"/"];
        NSString *str = stateArr[0];
        weakSelf.bangdanLab.text = str;
        NSInteger index = [stateArr[1] integerValue];
        weakSelf.gardensubmodel = weakSelf.currentModel.gardenLists[index-1];
    };
    [_TeampickerView show];
    
}


#pragma mark - collection数据源代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (imgsArray.count >= 3) {
        return imgsArray.count;
    }
    return imgsArray.count + 1;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
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
        if (imgsArray.count == 3) {
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
		UIImage *img = [imgsArray objectAtIndex:indexPath.row];
		[cell.m_imgView setImage:img];
		cell.m_imgView.tag = [indexPath row];
		cell.deleteBtn.tag=indexPath.row;
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
    [imgsArray removeObjectAtIndex:sender.tag];
    [_collectionView reloadData];
    [self setBaseScrollHeigh:imgsArray];
//    if (imgsArray.count==0) {
//        isSelectedPhoto=NO;
//    }
}
-(void)setBaseScrollHeigh:(NSArray *)arr2{
    CGFloat f=(WindowWith-kWidth(80))/3;
    CGRect rect=_collectionView.frame;
    if ((arr2.count) <4) {
        rect.size.height=f+kWidth(10);
    }else if (arr2.count < 7){
        rect.size.height=f*2+kWidth(20);
    }else{
        rect.size.height=f*3+kWidth(30);
    }
    _collectionView.frame=rect;
    footView.size = CGSizeMake(iPhoneWidth, _collectionView.height + kWidth(70));
}

- (void)btnSelectPhoto_Click:(id)sender {
    [actionSheet showWithSender:self animate:YES completion:^(NSArray<UIImage *> * _Nonnull selectPhotos) {
        for (int i=0; i<selectPhotos.count; i++) {
            UIImage *img2 = [selectPhotos objectAtIndex:i];
            if (!self->isFirstAddPhoto) {
                [self->imgsArray addObject:img2];
                self->isFirstAddPhoto=YES;
            }else{
                [self->imgsArray addObject:img2];
            }
        }
        if (self->imgsArray.count>=3) {
            NSMutableArray *arr2=[[NSMutableArray alloc]init];
            for (int i=0; i<3; i++) {
                [arr2 addObject:[self->imgsArray objectAtIndex:i]];
            }
            [self->imgsArray removeAllObjects];
            [self->imgsArray addObjectsFromArray:arr2];
        }
        [self->_collectionView reloadData];
        [self setBaseScrollHeigh:self->imgsArray];
    }];
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    _textField = textField;
}
@end
