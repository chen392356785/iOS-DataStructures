//
//  SeedCloudDetailViewController.m
//  MiaoTuProject
//
//  Created by Zmh on 8/11/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "AdView.h"
#import "ChatViewController.h"
#import "XHFriendlyLoadingView.h"
#import "CreatNerseryViewController.h"
#import "EPCloudDetailViewController.h"
#import "SeedCloudDetailViewController.h"

@interface SeedCloudDetailViewController ()<UIScrollViewDelegate,ChatViewControllerDelegate>
{
    AdView *_imagev;
    NurseryListModel *_model;
    NSDictionary *_dataDic;
}
@end

@implementation SeedCloudDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarItem:NO];
    searchBtn.hidden = YES;
    self.navigationItem.rightBarButtonItems = nil;
     UIBarButtonItem *barMoreBtn=[[UIBarButtonItem alloc]initWithCustomView:moreBtn];
    self.navigationItem.rightBarButtonItem = barMoreBtn;
    [self setTitle:self.listModel.plant_name];
    
    _BaseScrollView.backgroundColor = RGB(247, 248, 250);
    _BaseScrollView.delegate = self;
    
    [self reloadWaitingView];
}
#pragma mark网络断开 从新链接
-(void)reloadWaitingView{
    //加载试图
    [self addPushViewWaitingView];
    [network GetSeedCloudDetailByNursery_id:(int)self.listModel.nursery_id success:^(NSDictionary *obj) {
        [self removePushViewWaitingView];

       self->_model = obj[@"content2"];
        self->_dataDic = obj[@"content"];
        
        [self initViews];
        
    } failure:^(NSDictionary *obj2) {
        [self removePushViewWaitingView];
        XHFriendlyLoadingView *v=(XHFriendlyLoadingView*)[self.view viewWithTag:8172];
        [v showReloadViewWithText:reloadText];
    }];
    
}

- (void)initViews
{
    NSMutableArray *imageArr = [NSMutableArray array];
    for (MTPhotosModel *model in _model.imageArr) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:model.imgUrl forKey:@"activities_pic"];
        [imageArr addObject:dic] ;
    }
    
    AdView *v=[AdView adScrollViewWithFrame:CGRectMake(0, 0, WindowWith, WindowWith) imageLinkURL:imageArr placeHoderImageName:@"defaultSquare.png" pageControlShowStyle:UIPageControlShowStyleRight];
    v.isNeedCycleRoll = NO;
    _imagev=v;
    v.callBack=^(NSInteger index,NSDictionary * dic){
        
    };
    [_BaseScrollView addSubview:v];
    
    UIView *seedInfoView = [UIView new];
    seedInfoView.backgroundColor = [UIColor whiteColor];
    [_BaseScrollView addSubview:seedInfoView];
    seedInfoView.sd_layout.leftSpaceToView(_BaseScrollView,0).topSpaceToView(v,0).widthIs(WindowWith);
    
    //苗木的一些基本数据信息
    UIView *listView = [UIView new];
    listView.backgroundColor = [UIColor whiteColor];
    [seedInfoView addSubview:listView];
    listView.sd_layout.leftSpaceToView(seedInfoView,0).topSpaceToView(seedInfoView,0).widthIs(WindowWith);
    
    //获取当前苗木需要展示的信息名称
    NSArray *ListArr = [ConfigManager getSeedCloudInfoList];
    NSMutableArray *Arr = [NSMutableArray array];
    NSMutableArray *contentArr = [NSMutableArray array];
    
    //获取本地plist文件中的参数表对比返回数据 如果返回数据为空则不显示 反之加入数组循环创建显示
    for (NSDictionary *dic in ListArr) {
        NSArray *keyArr = [dic allKeys];
        NSString *str = [NSString stringWithFormat:@"%@",_dataDic[keyArr[0]]];
        
        if (str.length >0 && ![str isEqualToString:@"(null)"]) {
            NSArray *array = [dic allValues];
            [Arr addObject:array[0]];
            [contentArr addObject:str];
        }
    }
    
    for (int i = 0; i<Arr.count; i++) {
        UIImage *image = Image(@"lineImage.png");
        
        SMLabel *lbl = [SMLabel new];
        lbl.textColor = cGrayLightColor;
        lbl.font = sysFont(13);
        if ([Arr[i] isEqualToString:@"装车价"]) {
            lbl.textColor = [UIColor redColor];
            lbl.font = sysFont(13);
            lbl.text = [NSString stringWithFormat:@"%@：￥%@",Arr[i],contentArr[i]];
        }else if ([Arr[i] isEqualToString:@"数量"]){
            lbl.textColor = cGreenColor;
            lbl.font = sysFont(13);
            lbl.text = [NSString stringWithFormat:@"%@：%@%@",Arr[i],contentArr[i],_model.unit];
        }else {
            NSString *text;
            //判断是不是数字 如果是数字显示加上单位
            if ([self isPureFloat:contentArr[i]]) {
                if ([Arr[i] isEqualToString:@"公斤"]) {
                    text = [NSString stringWithFormat:@"%@：%@",Arr[i],contentArr[i]];
                }else{
                    text = [NSString stringWithFormat:@"%@：%@cm",Arr[i],contentArr[i]];
                }
            }else{
                text = [NSString stringWithFormat:@"%@：%@",Arr[i],contentArr[i]];
            }
            lbl.text = text;
            NSString *string = Arr[i];
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:lbl.text];
            [str addAttribute:NSForegroundColorAttributeName value:cBlackColor range:NSMakeRange(string.length + 1, lbl.text.length - string.length - 1)];
            lbl.attributedText = str;
        }
        [listView addSubview:lbl];
        
        lbl.sd_layout.leftSpaceToView(listView,20 + i%2 *WindowWith/2.0).topSpaceToView(listView,16 + i/2*(18.5 + 14 + image.size.height)).heightIs(18.5).widthIs(WindowWith/2.0 - 30);
        
        UIAsyncImageView *lineImage = [UIAsyncImageView new];
        lineImage.image = image;
        [listView addSubview:lineImage];
        lineImage.sd_layout.leftSpaceToView(listView,20).topSpaceToView(lbl,7).widthIs(WindowWith - 40).heightIs(image.size.height);
        
        [listView setupAutoHeightWithBottomView:lineImage bottomMargin:0];

    }
    
    //备注
    SMLabel *remarkLbl = [SMLabel new];
    remarkLbl.textColor = cGrayLightColor;
    remarkLbl.font = sysFont(13);
    if (_model.remark.length > 0) {
        remarkLbl.text = [NSString stringWithFormat:@"备注：%@",_model.remark];
    }else{
        remarkLbl.text = [NSString stringWithFormat:@"备注：无"];
    }
    
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:remarkLbl.text];
    [str addAttribute:NSForegroundColorAttributeName value:cBlackColor range:NSMakeRange(3, remarkLbl.text.length -3)];
    remarkLbl.attributedText = str;
    [seedInfoView addSubview:remarkLbl];
    remarkLbl.sd_layout.leftSpaceToView(seedInfoView,17.5).topSpaceToView(listView,16).widthIs(WindowWith - 35).autoHeightRatio(0);
    [remarkLbl setMaxNumberOfLinesToShow:0];

    [seedInfoView setupAutoHeightWithBottomView:remarkLbl bottomMargin:16];
    
    //联系人，电话，地址
    UIView *userInfoView = [UIView new];
    userInfoView.backgroundColor = [UIColor whiteColor];
    [_BaseScrollView addSubview:userInfoView];
    userInfoView.sd_layout.leftSpaceToView(_BaseScrollView,0).topSpaceToView(seedInfoView,5).widthIs(WindowWith);
    
    //联系人
    UIImage *userImg = Image(@"Nursery_lianxiren.png");
    UIImageView *userImageView = [UIImageView new];
    userImageView.image = userImg;
    [userInfoView addSubview:userImageView];
    userImageView.sd_layout.leftSpaceToView(userInfoView,19.5).topSpaceToView(userInfoView,15).widthIs(userImg.size.width).heightIs(userImg.size.height);
    
    SMLabel *nameLbl = [SMLabel new];
    nameLbl.textColor = cBlackColor;
    nameLbl.font = sysFont(12);
    if (_model.nickname.length > 0) {
        nameLbl.text = [NSString stringWithFormat:@"联系人：%@",_model.nickname];
    }else{
        nameLbl.text = [NSString stringWithFormat:@"联系人：无"];
    }
    [userInfoView addSubview:nameLbl];
    nameLbl.sd_layout.leftSpaceToView(userImageView,7.5).centerYEqualToView(userImageView).heightIs(16.5).rightSpaceToView(userInfoView,WindowWith/2.0 + 10);
    
    //电话
    UIImage *phoneImg = Image(@"Nurser_telphone.png");
    UIImageView *phoneImgImageView = [UIImageView new];
    phoneImgImageView.image = phoneImg;
    [userInfoView addSubview:phoneImgImageView];
    phoneImgImageView.sd_layout.leftSpaceToView(userInfoView,WindowWith/2.0 + 10).topSpaceToView(userInfoView,15).widthIs(phoneImg.size.width).heightIs(phoneImg.size.height);
    
    SMLabel *phoneLbl = [SMLabel new];
    phoneLbl.textColor = cBlackColor;
    phoneLbl.font = sysFont(12);
    if (_model.mobile.length > 0) {
        phoneLbl.text = [NSString stringWithFormat:@"电话：%@",_model.mobile];
    }else{
        phoneLbl.text = [NSString stringWithFormat:@"电话：无"];
    }
    [userInfoView addSubview:phoneLbl];
    phoneLbl.sd_layout.leftSpaceToView(phoneImgImageView,7.5).centerYEqualToView(phoneImgImageView).heightIs(16.5).rightSpaceToView(userInfoView,10);
    
    //地址
    UIImage *adressImg = Image(@"Nursery_adress.png");
    UIImageView *adressImgImageView = [UIImageView new];
    adressImgImageView.image = adressImg;
//    [userInfoView addSubview:adressImgImageView];
    adressImgImageView.sd_layout.leftSpaceToView(userInfoView,19.5).topSpaceToView(userImageView,12).widthIs(adressImg.size.width).heightIs(adressImg.size.height);
    
    SMLabel *adressLbl = [SMLabel new];
    adressLbl.textColor = cBlackColor;
    adressLbl.font = sysFont(12);
    adressLbl.text = [NSString stringWithFormat:@"苗源地址：%@",_model.nursery_address];
//    [userInfoView addSubview:adressLbl];
    adressLbl.sd_layout.leftSpaceToView(adressImgImageView,7.5).centerYEqualToView(adressImgImageView).heightIs(16.5).rightSpaceToView(userInfoView,10);
    
    UIView *linView = [UIView new];
    linView.backgroundColor = cLineColor;
    [userInfoView addSubview:linView];
    linView.sd_layout.leftSpaceToView(userInfoView,0).topSpaceToView(phoneImgImageView,12).widthIs(WindowWith).heightIs(1);
    
    //公司主页
    UIView *companyView = [UIView new];
    companyView.userInteractionEnabled = YES;
    [userInfoView addSubview:companyView];
    companyView.sd_layout.leftSpaceToView(userInfoView,0).topSpaceToView(linView,0).widthIs(WindowWith).heightIs(50);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCompanyHome:)];
    tap.numberOfTapsRequired= 1.0;
    tap.numberOfTouchesRequired= 1;
    [companyView addGestureRecognizer:tap];
    
    UIImage *img = Image(@"Job_companyHome.png");
    UIImageView *companyImageV = [[UIImageView alloc] initWithFrame:CGRectMake(17.5, 0, img.size.width, img.size.height)];
    companyImageV.image = img;
    companyImageV.centerY = companyView.height/2.0;
    [companyView addSubview:companyImageV];
    
    SMLabel *lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(companyImageV.right+ 7, 0, WindowWith - companyImageV.right - 50, 15) textColor:cBlackColor textFont:sysFont(14)];
    lbl.text = _model.company_name;
    lbl.centerY = companyView.height/2.0;
    [companyView addSubview:lbl];
    
    img = Image(@"iconfont-fanhui.png");
    UIImageView *rightImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
    rightImageV.image = img;
    rightImageV.centerY = companyView.height/2.0;
    rightImageV.right = companyView.width - 12;
    rightImageV.transform= CGAffineTransformMakeRotation(M_PI);
    [companyView addSubview:rightImageV];
    
    [userInfoView setupAutoHeightWithBottomView:companyView bottomMargin:0];
    
    [_BaseScrollView setupAutoContentSizeWithBottomView:userInfoView bottomMargin:125];
    
    //电话和聊天
    UIView *BottomView = [[UIView alloc] initWithFrame:CGRectMake(0, WindowHeight-49, WindowWith, 49)];
    BottomView.backgroundColor = [UIColor whiteColor];
    
    if ([USERMODEL.userID intValue] != _model.user_id) {
        [self.view addSubview:BottomView];
    }
    UIView *linView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, 1)];
    linView2.backgroundColor = cLineColor;
    [BottomView addSubview:linView2];
    
    NSArray *arr = @[@"电话",@"立即沟通"];
   /* if (_model.user_id==[USERMODEL.userID integerValue]) {
        
        arr = @[@"删除",@"编辑"];
        
    }*/
    for (int i = 0; i<arr.count; i++) {
        float y = (WindowWith - 150*WindowWith/375.0 * 2)/3.0;
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(y + (y + 150*WindowWith/375.0)*i, 0, 150*WindowWith/375.0, 35)];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        btn.tag = 30 + i;
        btn.centerY = BottomView.height/2.0;
        [btn setTitleColor:cGreenColor forState:UIControlStateNormal];
        btn.layer.cornerRadius = 19.0;
        btn.layer.borderColor = cGreenColor.CGColor;
        btn.layer.borderWidth = 1.0;
        
        if (i == 0) {
                
            [btn setImage:phoneImg forState:UIControlStateNormal];
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8);
            for (int i = 0; i<arr.count; i++){
                 [btn setTitleColor:RGB(232, 121, 117) forState:UIControlStateNormal];
                 btn.layer.borderColor = RGB(232, 121, 117).CGColor;
            }
        }
        btn.titleLabel.font = sysFont(15);
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [BottomView addSubview:btn];
        
    }

    
}
//进入公司主页
- (void)tapCompanyHome:(UITapGestureRecognizer *)tap
{
    [network getCompanyHomePage:_model.company_id success:^(NSDictionary *obj) {
        EPCloudListModel *model = obj[@"content"];
        
        EPCloudDetailViewController *detailVC =[[EPCloudDetailViewController alloc]init];
        detailVC.model = model;
        [self pushViewController:detailVC];
        
    } failure:^(NSDictionary *obj2) {
        
    }];
    
}
//分享
- (void)share
{
     [self shareView:ENT_SeedCloudDetail object:_model vc:self];
}

- (void)btnAction:(UIButton *)button
{
    
   
        if (button.tag == 30) {
            
            //拨打电话
            [self getPhoneweak];
            
        }else {
            //立即沟通
            ChatViewController *vc=[[ChatViewController alloc]initWithChatter:_model.hx_user_name conversationType:eConversationTypeChat];
            vc.nickName=_model.nickname;
            vc.toUserID=[NSString stringWithFormat:@"%ld",_model.user_id];
            vc.HeadimgUrl=[NSString stringWithFormat:@"%@%@",_model.heed_image_url,smallHeaderImage];
            vc.delelgate=self;
            [self pushViewController:vc];
            
        }

    
    
   }




-(void)backTopClick:(UIButton *)sender{
    
    [self scrollTopPoint:_BaseScrollView];
    
}
-(void)getPhoneweak{
    
    
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    
    if (![_model.mobile isEqualToString:@""]) {
        NSString *phoneString = [NSString stringWithFormat:@"tel:%@",_model.mobile];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:phoneString]]];
        [self.view addSubview:callWebview];
    }else
    {
        [IHUtility addSucessView:@"对方没有留下电话" type:1];
    }
    
}
//判断字符串是否是数字
- (BOOL)isPureFloat:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat y = scrollView.contentOffset.y;
    if (y>0) {
        //设置图片的大小位置
        _imagev.height = WindowWith;
        _imagev.top = 0;
    }else {
        //设置图片的大小位置
        _imagev.height = WindowWith + fabs(y);
        _imagev.top = y;
    }
    
    UIView *firstView = _imagev.subviews[0];
    firstView.height = _imagev.height;
    firstView.top = 0;
    NSArray *views = firstView.subviews;
    for (UIView *View in views) {
        if ([View isKindOfClass:[UIImageView class]]) {
            View.height = _imagev.height;
            View.top = 0;
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
