//
//  PositionDetailViewController.m
//  MiaoTuProject
//
//  Created by Zmh on 12/9/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "PositionDetailViewController.h"
#import "ResumeViewController.h"
#import "PositionListViewController.h"
//#import "YLWebViewController.h"
#import "ChatViewController.h"
//#import "JLSimplePickViewComponent.h"
#import "XHFriendlyLoadingView.h"
#import "EPCloudDetailViewController.h"
#import "ActivtiesMapViewController.h"
#import "CreatPositionViewController.h"


@interface PositionDetailViewController ()<HJCActionSheetDelegate,sendResumeSuccessDelegate,ChatViewControllerDelegate>
{
    //    SelectedView *_selectView;
    PositionListModel *_detailModel;
    UIButton *_sendButton;
}

@end

@implementation PositionDetailViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setRightButtonImage:Image(@"Job_rightBtn.png") forState:UIControlStateNormal];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"职位详情"];
    [self reloadWaitingView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setview:) name:NotificationEditPosition object:nil];
}

-(void)setview:(NSNotification *)dic{
    
    _detailModel=dic.userInfo[@"key"];
    self.job_id = (int)_detailModel.job_id;
    [self addPushViewWaitingView];
    [network loadPositionDetail:stringFormatInt(self.job_id) user_id:USERMODEL.userID success:^(NSDictionary *obj) {
        
        self->_detailModel = obj[@"content"];
        
        [self removePushViewWaitingView];
        
        [self->_BaseScrollView removeAllSubviews];
        [self initViews];
        
    } failure:^(NSDictionary *obj2) {
        [self removePushViewWaitingView];
        XHFriendlyLoadingView *v=(XHFriendlyLoadingView*)[self.view viewWithTag:8172];
        [v showReloadViewWithText:reloadText];
    }];
}

#pragma mark网络断开 从新链接
-(void)reloadWaitingView{
    [self addPushViewWaitingView];
    [network loadPositionDetail:stringFormatInt(self.job_id) user_id:USERMODEL.userID success:^(NSDictionary *obj) {
        
        self->_detailModel = obj[@"content"];
        
        [self removePushViewWaitingView];
        
        [self initViews];
        
    } failure:^(NSDictionary *obj2) {
        [self removePushViewWaitingView];
        XHFriendlyLoadingView *v=(XHFriendlyLoadingView*)[self.view viewWithTag:8172];
        [v showReloadViewWithText:reloadText];
    }];
}

- (void)initViews
{
    
    __weak PositionDetailViewController *weakSelf = self;
    _BaseScrollView.backgroundColor = cLineColor;
    
    //职位详情关于职位的基本信息
    PositionRequirementView *requeView =[[PositionRequirementView alloc] initWithFrame:CGRectMake(7, 10, WindowWith-14, 200)];
    [requeView setCellDate:_detailModel];
    //判断是如果是职位列表进入显示更多职位按钮  如果是公司其他职位列表进入就隐藏
    if (self.i == 1) {
        requeView.button.hidden = YES;
    }
    requeView.selectBlock = ^(NSInteger index){
        if (index == SelectBtnBlock) {
            PositionListViewController *vc = [[PositionListViewController alloc] init];
            vc.model = self->_detailModel;
            [weakSelf pushViewController:vc];
        }else {
            //进入公司主页
            [weakSelf getCompanyHomePage];
        }
    };
    [_BaseScrollView addSubview:requeView];
    
    //职位描述
    CGSize size= [IHUtility GetSizeByText:_detailModel.job_desc sizeOfFont:13 width:WindowWith-34];
    ContentView *mainV;
    //判断描述内容的高度 来决定显示全部按钮的显示与隐藏
    if (size.height <= 120) {
        mainV = [[ContentView alloc] initWithFrame:CGRectMake(7, requeView.bottom+10, WindowWith-14, size.height+90) title:@"职位描述" content:_detailModel.job_desc btnHidden:YES];
    }else {
        mainV = [[ContentView alloc] initWithFrame:CGRectMake(7, requeView.bottom+10, WindowWith-14, 210) title:@"职位描述" content:_detailModel.job_desc btnHidden:NO];
    }
    
    [_BaseScrollView addSubview:mainV];
    
    //公司团队介绍
    ContentView *teamV = [[ContentView alloc] initWithFrame:CGRectMake(7, mainV.bottom+10, WindowWith-14, 210) title:@"团队介绍" content:_detailModel.company_desc btnHidden:YES];
    [_BaseScrollView addSubview:teamV];
    
    UIView *infoView = [[UIView alloc] initWithFrame:CGRectMake(7, teamV.bottom + 10, WindowWith-14, 132)];
    infoView.backgroundColor = cLineColor;
    infoView.layer.cornerRadius = 3.0;
    infoView.clipsToBounds = YES;
    [_BaseScrollView addSubview:infoView];
    
    //公司地址，规模展示
    NSArray *imageArr = @[@"Job_companySize",@"Job_companyName",@"Job_adress"];
    NSArray *contentArr = @[_detailModel.staff_size,_detailModel.company_name,_detailModel.work_address];
    for (int i=0; i<imageArr.count; i++) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 44*i, infoView.width, 43.5)];
        view.backgroundColor = [UIColor whiteColor];
        [infoView addSubview:view];
        
        UIImage *img = Image(imageArr[i]);
        UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake(11, 0, img.size.width, img.size.height)];
        imageView.image = img;
        imageView.centerY= view.height/2.0;
        [view addSubview:imageView];
        
        SMLabel *lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(imageView.right + 6, 0, view.width - imageView.right - 15, 15) textColor:cGrayLightColor textFont:sysFont(13)];
        lbl.centerY = view.height/2.0;
        lbl.text = contentArr[i];
        [view addSubview:lbl];
        
        //点击进行地图定位
        if (i==2) {
            
            view.userInteractionEnabled= YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getaddressTomap:)];
            tap.numberOfTapsRequired = 1;
            tap.numberOfTouchesRequired= 1;
            [view addGestureRecognizer:tap];
            
        }
    }
    
    _BaseScrollView.contentSize = CGSizeMake(WindowWith, infoView.bottom + 119);
    mainV.selectBlock = ^(NSInteger index){
        teamV.top = mainV.bottom + 10;
        infoView.top = teamV.bottom + 10;
        self->_BaseScrollView.contentSize = CGSizeMake(WindowWith, infoView.bottom + 119);
    };
    
    UIView *BottomView = [[UIView alloc] initWithFrame:CGRectMake(0, WindowHeight-49, WindowWith, 49)];
    BottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:BottomView];
    
    NSArray *arr = @[@"立即沟通",@"投递简历"];
    
    if ([_detailModel.user_id isEqualToString:USERMODEL.userID]) {
        
        
        arr = @[@"编辑职位",@"关闭职位"];
        if ([_detailModel.status isEqualToString:@"0"]) {
            arr = @[@"编辑职位",@"开启职位"];
        }
    }
    if ([_detailModel.sendFlag isEqualToString:@"1"]) {
        arr = @[@"立即沟通",@"已投递"];
    }
    for (int i = 0; i<arr.count; i++) {
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 150*WindowWith/375.0, 35)];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        btn.tag = 30 + i;
        btn.centerY = BottomView.height/2.0;
        if (i==0) {
            btn.centerX = WindowWith/4.0;
            [btn setTitleColor:cGreenColor forState:UIControlStateNormal];
            btn.layer.cornerRadius = 19.0;
            btn.layer.borderColor = cGreenColor.CGColor;
            btn.layer.borderWidth = 1.0;
        }else {
            
            btn.centerX = WindowWith/4.0 + WindowWith/2.0;
            if ([_detailModel.user_id isEqualToString:USERMODEL.userID])
            {
                [btn setTitleColor:cGreenColor forState:UIControlStateNormal];
                btn.layer.cornerRadius = 19.0;
                btn.layer.borderColor = cGreenColor.CGColor;
                btn.layer.borderWidth = 1.0;
            }else{
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                btn.layer.cornerRadius = 19.0;
                if ([_detailModel.sendFlag isEqualToString:@"1"]) {
                    
                    btn.backgroundColor = cGrayLightColor;
                }else{
                    btn.backgroundColor = cGreenColor;
                }
            }
            _sendButton = btn;
        }
        
        btn.titleLabel.font = sysFont(15);
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [BottomView addSubview:btn];
    }
}
//根据公司ID进入公司主页
- (void)getCompanyHomePage
{
    [network getCompanyHomePage:_detailModel.company_id success:^(NSDictionary *obj) {
        EPCloudListModel *model = obj[@"content"];
        
        EPCloudDetailViewController *detailVC =[[EPCloudDetailViewController alloc]init];
        detailVC.model = model;
        [self pushViewController:detailVC];
        
    } failure:^(NSDictionary *obj2) {
        
    }];
}
- (void)btnAction:(UIButton *)button
{
    if (button.tag == 31) {
        //关闭职位
        if ([_detailModel.user_id isEqualToString:USERMODEL.userID]){
            
            if ([button.titleLabel.text isEqualToString:@"关闭职位"]) {
                [network closeRecruitJob:(int)self->_detailModel.job_id status:0 success:^(NSDictionary *obj) {
                    
                    [IHUtility addSucessView:@"职位关闭成功" type:1];
                    if ([self.delegate respondsToSelector:@selector(closeOrOpenPosition:)]) {
                        [self.delegate closeOrOpenPosition:YES];
                    }
                    [button setTitle:@"开启职位" forState:UIControlStateNormal];
                }];
                
            }else{
                //开启职位
                [network closeRecruitJob:(int)self->_detailModel.job_id status:1 success:^(NSDictionary *obj) {
                    [IHUtility addSucessView:@"职位开启成功" type:1];
                    if ([self.delegate respondsToSelector:@selector(closeOrOpenPosition:)]) {
                        [self.delegate closeOrOpenPosition:NO];
                    }
                    
                    [button setTitle:@"关闭职位" forState:UIControlStateNormal];
                }];
            }
        }else{
            //投递简历
            if (!USERMODEL.isLogin) {
                [self prsentToLoginViewController];
                return ;
            }
            
            [self addWaitingView];
            [network getDeliveryResume:USERMODEL.nickName hx_user_name:_detailModel.hx_user_name job_id:(int)self->_detailModel.job_id company_name:_detailModel.company_name staff_size:_detailModel.staff_size success:^(NSDictionary *obj) {
                
                [self addSucessView:@"投递成功" type:1];
                [button setTitle:@"已投递" forState:UIControlStateNormal];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                button.backgroundColor = cGrayLightColor;
                
            } failure:^(NSDictionary *obj2) {
                
                if ([obj2[@"errorNo"] intValue]== 501) {
                    ResumeViewController *vc = [[ResumeViewController alloc] init];
                    vc.Delegate= self;
                    vc.model = self->_detailModel;
                    [self pushViewController:vc];
                }
            }];
        }
    }else {
        if (!USERMODEL.isLogin) {
            [self prsentToLoginViewController];
            return ;
        }
        
        if ([_detailModel.user_id isEqualToString:USERMODEL.userID]){
            CreatPositionViewController *vc=[[CreatPositionViewController alloc]init];
            vc.model=_detailModel;
            [self pushViewController:vc];
        }else{
            //立即沟通
            ChatViewController *vc=[[ChatViewController alloc]initWithChatter:_detailModel.hx_user_name conversationType:eConversationTypeChat];
            vc.nickName=_detailModel.nickname;
            vc.toUserID=stringFormatString(_detailModel.user_id);
            vc.HeadimgUrl=[NSString stringWithFormat:@"%@%@",_detailModel.heed_image_url,smallHeaderImage];
            vc.delelgate=self;
            [self pushViewController:vc];
        }
    }
}
- (void)home:(id)sender
{
    //    UIButton *btn =  (UIButton *)sender;
    __weak PositionDetailViewController *weakSelf = self;
    NSArray *arr = @[@"分享",@"举报"];
    NSArray *imgArr = @[@"Job_share.png",@"Job_Report.png"];
    SelectedView *view = [[SelectedView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) array:arr imageArr:imgArr rectY:60 rectX:WindowWith-80 - 10 width:80];
    view.selectBlock = ^(NSInteger index){
        if (index==10) {
            NSString *str = [NSString stringWithFormat:@"【招聘】强烈推荐！%@正在招聘%@",self->_detailModel.company_name,self->_detailModel.job_name];
            NSString *urlStr = [NSString stringWithFormat:@"%@recruit.html?id=%d",shareURL,(int)self->_detailModel.job_id];
            [weakSelf ShareUrl:self withTittle:str content:[NSString stringWithFormat:@"%@-园林行业优秀企业与专业人才的桥梁",KAppName] withUrl:urlStr imgUrl:self->_detailModel.heed_image_url];
        }else{
            HJCActionSheet *sheet = [[HJCActionSheet alloc] initWithDelegate:self CancelTitle:@"取消" title:@"举报对方" OtherTitles:@"广告",@"色情",@"违法-政治敏感内容",@"信息造假",@"索取隐私",@"人身攻击",@"其他", nil];
            
            [sheet show];
        }
    };
    //    [self.view addSubview:view];
}
- (void)getaddressTomap:(UITapGestureRecognizer *)tap
{
    
    ActivtiesMapViewController *ActivtiesMapVC = [[ActivtiesMapViewController alloc] init];
    CLLocationCoordinate2D   coordinate= CLLocationCoordinate2DMake([[NSString stringWithFormat:@"%@",_detailModel.job_lat] doubleValue],[[NSString stringWithFormat:@"%@",_detailModel.job_lon] doubleValue]);
    
    ActivtiesMapVC.coordinate = coordinate;
    ActivtiesMapVC.name = _detailModel.work_address;
    [self pushViewController:ActivtiesMapVC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)actionSheet:(HJCActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSArray *arr=@[@"广告",@"色情",@"违法-政治敏感内容",@"信息造假",@"索取隐私",@"人身攻击",@"其他"];
    NSString *str=[arr objectAtIndex:buttonIndex-2];
    
    [network userReportPosition:stringFormatInt(_detailModel.job_id) content:str success:^(NSDictionary *obj) {
        
        [self addSucessView:@"举报成功" type:1];
        
    } failure:^(NSDictionary *obj2) {
        
    }];
}
//发布简历
- (void)disPalySendResumeSuccess
{
    [_sendButton setTitle:@"已投递" forState:UIControlStateNormal];
    [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _sendButton.backgroundColor = cGrayLightColor;
}
-(void)backTopClick:(UIButton *)sender{
    
    [self scrollTopPoint:_BaseScrollView];
}

#pragma mark - ChatViewControllerDelegate

// 根据环信id得到要显示头像路径，如果返回nil，则显示默认头像
- (NSString *)avatarWithChatter:(NSString *)chatter{
    NSString *str=[NSString stringWithFormat:@"%@%@",_detailModel.heed_image_url,smallHeaderImage];
    NSString *userID=[_detailModel.hx_user_name lowercaseString];
    
    if ([chatter isEqualToString:userID]) {
        return str;
    }else{
        return USERMODEL.userHeadImge80;
    }
    
    return nil;
    
}
// 根据环信id得到要显示用户名，如果返回nil，则默认显示环信id
- (NSString *)nickNameWithChatter:(NSString *)chatter{
    return chatter;
}

@end
