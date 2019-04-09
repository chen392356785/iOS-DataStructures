//
//  MeMainViewController.m
//  MiaoTuProject
//
//  Created by Mac on 16/3/9.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MeMainViewController.h"
#import "PersonUserInfromationViewController.h"
#import "EditPersonInformationViewController.h"
#import "MapAnnotationViewController.h"
#import "MTMyCollectionViewController.h"
#import "MTCommentForMeListViewController.h"
#import "MTOtherInfomationMainViewController.h"
#import "CompanyCumlativeViewController.h"
#import "FindOutMeViewController.h"
#import "SettingViewController.h"
#import "ChatListViewController.h"
#import "MTNetworkData+ForModel.h"
#import "MYTaskViewController.h"
#import "ActivityListViewController.h"
#import "IdentKeyViewController.h"
#import "InvitedViewController.h"
#import "MapGeographicalPositionViewController.h"
#import "JionEPCloudViewController.h"
//新闻
#import "NewsTableListViewController.h"
#import "PositionListViewController.h"
#import "ResumeViewController.h"
#import "EPCloudFansViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <CoreLocation/CoreLocation.h>
#import "JobIdentViewController.h"
#import "MyJobViewController.h"
#import "MyReleaseViewController.h"
#import "WXWaveView.h"
#define  commentMeCell  4
#define  MapBZCell 2

#define  ImageHeight  0.69*WindowWith
#define  ImageWidth    _deviceSize.width
@interface MeMainViewController ()<UITableViewDelegate,MapAnnotationDelegate,GrageProtocol,AMapSearchDelegate>
{
    
    UIAsyncImageView *_headerImageView;
    SMLabel *_nickNameLbl;
    UIImageView *_sexImageView;
    UIButton *_cumulativeBtn;
    MTBaseTableView *commTableView;
    UIAsyncImageView *_bgView;
    UIImageView *_imgView;
    UILabel *_userGradeLabel;
    SMLabel *_cumulativeLbl;
    UIView *_heardBottomView;
    UIView *_headView;
    UIButton *_backbtn;
    SMLabel *_companyLbl;
    BQView *_bqView;
    UIImageView *_rightImgView;
    NSDictionary *_dic;
    UIView *_fansView;
    CornerView *_cornerview;
    UIButton *_guanzhuBtn;
    UIButton *_fensiBtn;
    AMapSearchAPI *_search;
    NSString *_adress;
    CGFloat _longtitude;
    CGFloat _latitude;
    NSIndexPath *_indexPath;
    NSString *_province;
    NSString *_city;
    NSString *_area;
    BOOL isFirst;
    UIImageView *_typeImageView;
    UIImageView *_typeImageView2;
    UIImageView *_typeImageView3;
    NSInteger _answer;
    WXWaveView *_waveView;
    UIButton *_infoBtn;
}
@end

@implementation MeMainViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setHomeTabBarHidden:NO];
    [self setFansNum];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.naviBarHidden = true;
    leftbutton.hidden = YES;
    [self.view setBackgroundColor:RGB(232, 240, 240)];
    [self creatView];
    
    _answer=0;
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate=self;
    
    if (BadgeMODEL.forumAnswer==1) {
        [self badgeChatNum1:nil];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setData) name:NotificationCompany object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setData) name:NotificationUpdateUserinfo object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(badgeChatNum3:) name:NotificationCurriculum object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(badgeChatNum1:) name:NotificationQAnswer object:nil];
    
    // [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationCommentMe:) name:NotificationCommentMe object:nil];
    
    //    if (BadgeMODEL.commentMeNum>0) {
    //         [self setMeNumCell:commentMeCell num:BadgeMODEL.commentMeNum];
    //    }
    
    //    if (BadgeMODEL.lookMeNum>0) {
    //        [_topView setData:BadgeMODEL.headArr num:BadgeMODEL.lookMeNum];
    //    }
}

-(void)notificationCommentMe:(NSNotification*)notification{
    
    if (BadgeMODEL.lookMeNum>0) {
        [_topView setData:BadgeMODEL.headArr num:BadgeMODEL.lookMeNum];
        //        _topView.frame = CGRectMake(0, _bgView.bottom, WindowWith, 65);
        //        _headView.frame=CGRectMake(0, 0, WindowWith, _bgView.height+_topView.height+5);
    }
    if (BadgeMODEL.commentMeNum>0) {
        [self setMeNumCell:commentMeCell num:BadgeMODEL.commentMeNum];
    }
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NotificationCompany object:nil];
    //  [[NSNotificationCenter defaultCenter]removeObserver:self name:NotificationCommentMe object:nil];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NotificationCurriculum object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NotificationQAnswer object:nil];
    
}

-(void)creatView{

    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, KStatusBarHeight)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    UIView *headView = [[UIView alloc]init];
    _headView = headView;
    
    
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, KStatusBarHeight, SCREEN_WIDTH, iPhoneHeight - KStatusBarHeight - KTabBarHeight) tableviewStyle:UITableViewStylePlain];
    
    commTableView.attribute=self;
    commTableView.table.delegate=self;
    commTableView.isMe=YES;
    
    MTOppcenteView *oppcenteView=[[MTOppcenteView alloc]initWithOrgane:CGPointMake(WindowWith/2-90, kScreenHeight/2-0.23*kScreenHeight)  BtnType:ENT_BiaoZhu];
    
    [self.view addSubview:commTableView];
    
    NSDictionary *dic=[IHUtility getUserDefalutsDicKey:kUserDefalutLoginInfo];
//    _dic=dic;
    
    UIAsyncImageView *bkImageView=[[UIAsyncImageView alloc]initWithImage:[ConfigManager createImageWithColor:[UIColor whiteColor]]];
    bkImageView.frame=CGRectMake(0, 0, WindowWith, 0.69*WindowWith);
    bkImageView.contentMode=UIViewContentModeScaleToFill;
    bkImageView.clipsToBounds=YES;
    _bgView=bkImageView;
    bkImageView.userInteractionEnabled=YES;
    [headView addSubview:bkImageView];
    
    //    UITapGestureRecognizer *mapTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(personInformation)];
    //    [bkImageView addGestureRecognizer:mapTap];
    
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backImg=Image(@"Me_setting.png");
    [backBtn setImage:[backImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    _backbtn=backBtn;
    [backBtn addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
    backBtn.titleLabel.font=sysFont(17);
//    backBtn.imageEdgeInsets=UIEdgeInsetsMake(15, 0, 0, 0);
    backBtn.frame=CGRectMake(20, 10, backImg.size.width+15, backImg.size.height+15);
    [bkImageView addSubview:backBtn];
    
    UIButton *messageBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *messageImg=Image(@"Me_message.png");
    [messageBtn setImage:[messageImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    // _backbtn=backBtn;
    [messageBtn addTarget:self action:@selector(pushToChatVC) forControlEvents:UIControlEventTouchUpInside];
    messageBtn.titleLabel.font=sysFont(17);
    messageBtn.imageEdgeInsets=UIEdgeInsetsMake(15, 0, 0, 0);
    messageBtn.frame=CGRectMake(WindowWith-40-messageImg.size.width, 15, backImg.size.width+15, backImg.size.height+15);
    //    [bkImageView addSubview:messageBtn];
    
    CornerView *view=[[CornerView alloc]initWithFrame:CGRectMake(messageBtn.width-22+15, 15, 15, 10) count:BadgeMODEL.chatNum];//
    _cornerview=view;
    [messageBtn addSubview:view];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeUserIdent:) name:NotificationUserIdentity object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(badgeChatNum4:) name:NotificationMeNum object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hideReImageView) name:NotificationMyNavViewHide object:nil];
    
    self.view.backgroundColor=cLineColor;
    
    CGSize nickSize=[IHUtility GetSizeByText:dic[@"nickname"] sizeOfFont:18 width:150];
    SMLabel *nickNameLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, 60, nickSize.width, 19) textColor:cBlackColor textFont:sysFont(18)] ;
    _nickNameLbl=nickNameLbl;
    nickNameLbl.centerX=self.view.centerX;
    
    nickNameLbl.text=dic[@"nickname"];
    nickNameLbl.textAlignment=NSTextAlignmentLeft;
    [bkImageView addSubview:nickNameLbl];
    
    UIImage *headerImg=Image(@"headtjh.png");
    
    UIAsyncImageView *headerImageView=[[UIAsyncImageView alloc]initWithImage:headerImg];
    _headerImageView=headerImageView;
    headerImageView.userInteractionEnabled=YES;
    [headerImageView setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@%@",ConfigManager.ImageUrl,dic[@"heed_image_url"],smallHeaderImage] placeholderImage:defalutHeadImage];
    
    [headerImageView canClickItWithDuration:0.3 ThumbUrl:[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,dic[@"heed_image_url"]]];
    
    headerImageView.frame=CGRectMake(10, nickNameLbl.bottom+10,0.224*WindowWith, 0.224*WindowWith);
    [headerImageView setLayerMasksCornerRadius:headerImageView.width/2 BorderWidth:2 borderColor:[UIColor whiteColor]];
    headerImageView.centerX=self.view.centerX;
    [bkImageView addSubview:headerImageView];
    
    
    CGSize btnSize = [IHUtility GetSizeByText:@"编辑资料" sizeOfFont:14 width:WindowWith];
    NSString *infoStr = @"编辑资料";
//    if ( [[NSUserDefaults standardUserDefaults] integerForKey:kJobIdentKey]==1001){
//        infoStr = @"编辑资料/完善简历";
//    }else{
//        infoStr=@"编辑资料";
//    }
    
    UIButton *infoBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    infoBtn.frame=CGRectMake(0, headerImageView.bottom+0.037*WindowWith, btnSize.width, 20);
    [infoBtn setTitle:infoStr forState:UIControlStateNormal];
    [infoBtn setTitleColor:cBlackColor forState:UIControlStateNormal];
    [infoBtn addTarget:self action:@selector(editUserInfo:) forControlEvents:UIControlEventTouchUpInside];
    infoBtn.titleLabel.font=sysFont(13);
    infoBtn.centerX=self.view.centerX;
    _infoBtn = infoBtn;
    [bkImageView addSubview:infoBtn];
    
    //判断性别
    UIImage *sexImg;
    
    if ([dic[@"sexy"] integerValue]==2) {
        sexImg=Image(@"girl.png");
    }else{
        sexImg=Image(@"boy.png");
    }
    
    UIImageView *sexImageView=[[UIImageView alloc]initWithFrame:CGRectMake(nickNameLbl.right+5, headerImageView.bottom+0.037*WindowWith, sexImg.size.width, sexImg.size.height)];
    _sexImageView=sexImageView;
    sexImageView.image=sexImg;
    sexImageView.centerX=self.view.centerX;
    //    [bkImageView addSubview:sexImageView];
    
    NSDictionary *fansDic=[IHUtility getUserDefalutDic:KFansDefalutInfo];
    
    NSString *str=[NSString stringWithFormat:@"%@ 关注",fansDic[@"followNum"]];
    if (!fansDic[@"followNum"]) {
        str=[NSString stringWithFormat:@"0 关注"];
    }
    CGSize size=[IHUtility GetSizeByText:str sizeOfFont:15 width:200];
    
    UIButton *guanzhuBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [guanzhuBtn setTitle:str forState:UIControlStateNormal];
    [guanzhuBtn setTitleColor:cBlackColor forState:UIControlStateNormal];
    guanzhuBtn.titleLabel.font=sysFont(15);
    _guanzhuBtn=guanzhuBtn;
    guanzhuBtn.frame=CGRectMake(0, 5, size.width, 15);
    [guanzhuBtn addTarget:self action:@selector(guanzhu) forControlEvents:UIControlEventTouchUpInside];
    
    str=[NSString stringWithFormat:@"%@ 粉丝",fansDic[@"fansNum"]];
    if (!fansDic[@"fansNum"]) {
        str=[NSString stringWithFormat:@"0 粉丝"];
    }
    size=[IHUtility GetSizeByText:str sizeOfFont:15 width:200];
    
    UIButton *fensiBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [fensiBtn setTitle:str forState:UIControlStateNormal];
    [fensiBtn setTitleColor:cBlackColor forState:UIControlStateNormal];
    fensiBtn.titleLabel.font=sysFont(15);
    _fensiBtn=fensiBtn;
    fensiBtn.frame=CGRectMake(guanzhuBtn.right+20, 5, size.width, 15);
    [fensiBtn addTarget:self action:@selector(fans) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *fansView=[[UIView alloc]initWithFrame:CGRectMake(0, 0.027*WindowWith+infoBtn.bottom-5, guanzhuBtn.width+20+fensiBtn.width, 25)];
    [bkImageView addSubview:fansView];
    
    [fansView addSubview:guanzhuBtn];
    [fansView addSubview:fensiBtn];
    fansView.centerX=self.view.centerX;
    _fansView=fansView;
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0,  bkImageView.bottom, WindowWith, 1)];
    lineView.backgroundColor=cLineColor;
    [headView addSubview:lineView];
    headView.frame=CGRectMake(0, 0, WindowWith, bkImageView.height+1);
    commTableView.table.tableHeaderView=headView;
    
    NSArray * ListArr = [ConfigManager getMeList];
    [commTableView setupData:ListArr index:16];
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch2"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch2"];
        NSLog(@"第一次启动");
        [commTableView.table addSubview:oppcenteView];
        [commTableView.table bringSubviewToFront:oppcenteView];
        
    }else{
        NSLog(@"已经不是第一次启动了");
    }
}

- (void)viewDidLayoutSubviews {
    if (!_waveView) {
        
        // Initialization
        _waveView = [WXWaveView addToView:commTableView.table.tableHeaderView withFrame:CGRectMake(0, commTableView.table.tableHeaderView.height - 4.5, commTableView.table.width, 5)];
        
        // Optional Setting
        _waveView.waveTime = 1.0f;     // When 0, the wave will never stop;
        _waveView.waveColor = cLineColor;
        _waveView.waveSpeed = 15.f;
        _waveView.angularSpeed = 1.8f;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([_waveView wave]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_waveView stop];
        });
    }
}

-(void)setFansNum{
    NSDictionary *fansDic=[IHUtility getUserDefalutDic:KFansDefalutInfo];
    NSString *str=[NSString stringWithFormat:@"%@ 关注",fansDic[@"followNum"]];
    if (!fansDic[@"followNum"]) {
        str=[NSString stringWithFormat:@"0 关注"];
    }
    
    CGSize size=[IHUtility GetSizeByText:str sizeOfFont:15 width:200];
    [_guanzhuBtn setTitle:str forState:UIControlStateNormal];
    _guanzhuBtn.frame=CGRectMake(0, 5, size.width, 15);
    
    
    
    str=[NSString stringWithFormat:@"%@ 粉丝",fansDic[@"fansNum"]];
    if (!fansDic[@"fansNum"]) {
        str=[NSString stringWithFormat:@"0 粉丝"];
    }
    
    size=[IHUtility GetSizeByText:str sizeOfFont:15 width:200];
    [_fensiBtn setTitle:str forState:UIControlStateNormal];
    _fensiBtn.frame=CGRectMake(_guanzhuBtn.right+20, 5, size.width, 15);
    
    _fansView.size=CGSizeMake(_guanzhuBtn.width+20+_fensiBtn.width, 25);
    _fansView.centerX=self.view.centerX;
}
//编辑资料/完善简历
- (void)editUserInfo:(UIButton *)btn
{
    if ( [[NSUserDefaults standardUserDefaults] integerForKey:kJobIdentKey]==1001){
        ResumeViewController *VC=[[ResumeViewController alloc]init];
        VC.type=ENT_Seek;
        VC.Mytype=ENT_CurriculumVitae;
        [self pushViewController:VC];
        
    }else{
        EditPersonInformationViewController *editVC=[[EditPersonInformationViewController alloc]init];
        [self pushViewController:editVC];
    }
}
//切换身份
- (void)changeUserIdent:(NSNotification *)notification{
    NSString *infoStr ;
    if ( [[NSUserDefaults standardUserDefaults] integerForKey:kJobIdentKey]==1001){
        infoStr = @"编辑资料/完善简历";
    }else{
        infoStr=@"编辑资料";
    }
    [_infoBtn setTitle:infoStr forState:UIControlStateNormal];
    
    
    [commTableView.table reloadData];
}
-(void)badgeChatNum3:(NSNotification *)notification{//收到简历
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:5 inSection:0];
    MTMeListTableViewCell *cell=(MTMeListTableViewCell *)[commTableView.table cellForRowAtIndexPath:indexPath];
    UIImage *img=Image(@"redpoint.png");
    _typeImageView2=[[UIImageView alloc]initWithFrame:CGRectMake(cell.typeImageView.width, -2, img.size.width, img.size.height)];
    _typeImageView2.image=img;
    [cell.typeImageView addSubview:_typeImageView2];
    _typeImageView2.hidden=NO;
}

-(void)badgeChatNum4:(NSNotification *)notification{//企业云申请
    
    //    [_cornerview setNum:[[notification object] intValue]];
    
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:3 inSection:0];
    MTMeListTableViewCell *cell=(MTMeListTableViewCell *)[commTableView.table cellForRowAtIndexPath:indexPath];
    UIImage *img=Image(@"redpoint.png");
    _typeImageView=[[UIImageView alloc]initWithFrame:CGRectMake(cell.typeImageView.width, -2, img.size.width, img.size.height)];
    _typeImageView.image=img;
    [cell.typeImageView addSubview:_typeImageView];
    _typeImageView.hidden=NO;
}

-(void)badgeChatNum1:(NSNotification *)notification{//我的问吧
    _answer=1;
    //    [_cornerview setNum:[[notification object] intValue]];
    
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:0];
    MTMeListTableViewCell *cell=(MTMeListTableViewCell *)[commTableView.table cellForRowAtIndexPath:indexPath];
    UIImage *img=Image(@"redpoint.png");
    _typeImageView3=[[UIImageView alloc]initWithFrame:CGRectMake(cell.typeImageView.width, -2, img.size.width, img.size.height)];
    _typeImageView3.image=img;
    [cell.typeImageView addSubview:_typeImageView3];
    _typeImageView3.hidden=NO;
    
}

-(void)hideReImageView{
    [_typeImageView3 removeFromSuperview];
    _answer=0;
    BadgeMODEL.forumAnswer=0;
    [[NSNotificationCenter defaultCenter]postNotificationName:NotificationTabBar4HiddenRedPoint object:nil];
}

-(void)pushToChatVC{
    ChatListViewController *vc=[[ChatListViewController alloc]init];
    [self pushViewController:vc];
}

//关注列表
-(void)guanzhu{
    EPCloudFansViewController *vc=[[EPCloudFansViewController alloc]init];
    vc.selectBlock=^(NSInteger index){
        if (index==SelectFollowBlock) {
            
            //            NSDictionary *Dic=[IHUtility getUserDefalutDic:KFansDefalutInfo];
            //            NSMutableDictionary *fansDic=[[NSMutableDictionary alloc]initWithDictionary:Dic];
            //            [fansDic setValue:[NSString stringWithFormat:@"%ld",[ fansDic[@"followNum"] integerValue]+1] forKey:@"followNum"];
            //
            //            [IHUtility setUserDefaultDic:fansDic key:KFansDefalutInfo];
        }if (index==SelectUpFollowBlock)
        {
            //            NSDictionary *Dic=[IHUtility getUserDefalutDic:KFansDefalutInfo];
            //            NSMutableDictionary *fansDic=[[NSMutableDictionary alloc]initWithDictionary:Dic];
            //            [fansDic setValue:[NSString stringWithFormat:@"%ld",[ fansDic[@"followNum"] integerValue]-1] forKey:@"followNum"];
            //
            //            [IHUtility setUserDefaultDic:fansDic key:KFansDefalutInfo];
        }
        
    };
    vc.userId=USERMODEL.userID;
    vc.type=ENT_fowller;
    [self pushViewController:vc];
}
//粉丝
-(void)fans{
    
    EPCloudFansViewController *vc=[[EPCloudFansViewController alloc]init];
    vc.userId=USERMODEL.userID;
    vc.type=ENT_fans;
    vc.selectBlock=^(NSInteger index){
        if (index==SelectFollowBlock) {
            
        }if (index==SelectUpFollowBlock)
        {
        }
    };
    [self pushViewController:vc];
}

//点击积分
- (void)myGold
{
    [self task:nil];
}
- (void)myGrade
{
    IdentKeyViewController *identVC =[[IdentKeyViewController alloc] init];
    [self pushViewController:identVC];
}
//我的任务
- (void)task:(NSIndexPath *)indexPath
{
    //    MYTaskViewController * task=[[MYTaskViewController alloc]init];
    //    task.delegate=self;
    //    task.indexPath = indexPath;
    //    [self pushViewController:task];
    ScoreConvertViewController *vc=[[ScoreConvertViewController alloc]init];
    [self pushViewController:vc];
    
    
}
- (void)upDateGrade:(NSString *)str indexPath:(NSIndexPath *)indexPath
{
    MTMeListTableViewCell *cell = [commTableView.table cellForRowAtIndexPath:indexPath];
    
    SMLabel *cumulativeLbl = [cell viewWithTag:101];
    cumulativeLbl.hidden = NO;
    cumulativeLbl.text=[NSString stringWithFormat:@"当前积分%@",str];
    cumulativeLbl.frame=CGRectMake(0.355*WindowWith, 23, 0.92*WindowWith-0.355*WindowWith-10 ,14);
    cumulativeLbl.textAlignment=NSTextAlignmentRight;
    
}
-(void)setMapCellBZ:(BOOL)isHidden{
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:MapBZCell inSection:0];
    MTMeListTableViewCell *cell=(MTMeListTableViewCell *)[commTableView.table cellForRowAtIndexPath:indexPath];
    if (isHidden) {
        UIImageView *imgView=[cell.contentView viewWithTag:1001];
        [imgView removeFromSuperview];
        SMLabel * finfihL=[cell.contentView viewWithTag:101];
        finfihL.hidden=NO;
    }else{
        UIImage *img=Image(@"zy1.png");
        
        NSArray *magesArray = [NSArray arrayWithObjects:
                               img,
                               Image(@"zy2.png"),nil];
        
        UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(WindowWith-90, 47/2-img.size.height/2, img.size.width, img.size.height)];
        imgView.image=img;
        imgView.animationImages = magesArray;//将序列帧数组赋给UIImageView的animationImages属性
        imgView.animationDuration = 0.45;//设置动画时间
        imgView.animationRepeatCount = 0;
        [imgView startAnimating];
        imgView.tag=1001;
        [cell.contentView addSubview:imgView];
    }
}

//设置角标数字
-(void)setMeNumCell:(int)numCell num:(int)num{
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:numCell inSection:0];
    MTMeListTableViewCell *cell=(MTMeListTableViewCell *)[commTableView.table cellForRowAtIndexPath:indexPath];
    cell.numView.num=num;
}

-(void)setData{
    NSDictionary *dic=[IHUtility getUserDefalutsDicKey:kUserDefalutLoginInfo];
    [_headerImageView setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@%@",ConfigManager.ImageUrl,dic[@"heed_image_url"],smallHeaderImage] placeholderImage:defalutHeadImage];
    [_headerImageView canClickItWithDuration:0.3 ThumbUrl:[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,dic[@"heed_image_url"]]];
    CGSize nickSize=[IHUtility GetSizeByText:dic[@"nickname"] sizeOfFont:20 width:150];
    _nickNameLbl.text=dic[@"nickname"];
    _nickNameLbl.size=CGSizeMake(nickSize.width,20);
    
    UIImage *sexImg;
    
    if ([dic[@"sexy"] integerValue]==2) {
        sexImg=Image(@"girl.png");
    }else {
        sexImg=Image(@"boy.png");
    }
    _sexImageView.image=sexImg;
}

//设置
-(void)setting
{
    SettingViewController *vc=[[SettingViewController alloc]init];
    [self pushViewController:vc];
}
//认证
-(void)cumlative{
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    CompanyCumlativeViewController *vc=[[CompanyCumlativeViewController alloc]init];
    [self pushViewController:vc];
}


//看过我的人
-(void)pushToFindOut
{
    //  [BadgeMODEL.headArr removeAllObjects];
    BadgeMODEL.lookMeNum=0;
    [_topView setData:BadgeMODEL.headArr num:BadgeMODEL.lookMeNum];
    FindOutMeViewController *vc=[[FindOutMeViewController alloc]init];
    [self pushViewController:vc];
}

-(void)personInformation{
    EditPersonInformationViewController *editVC=[[EditPersonInformationViewController alloc]init];
    [self pushViewController:editVC];
}

//我的招聘求职
-(void)pushToJob{
    [_typeImageView2 removeFromSuperview];
    [[NSNotificationCenter defaultCenter]postNotificationName:NotificationTabBar4HiddenRedPoint object:nil];
    
    if ( [[NSUserDefaults standardUserDefaults] integerForKey:kJobIdentKey]==1002)
    {
        MyJobViewController *vc=[[MyJobViewController alloc]init];
        vc.text=@"我的招聘";
        vc.arr=@[@"接收简历",@"发布职位"];
        vc.type=ENT_Invite;
        [self pushViewController:vc];
        return;
    }else if ([[NSUserDefaults standardUserDefaults] integerForKey:kJobIdentKey]==1001){
        PositionListViewController *zhaoping=[[PositionListViewController alloc]init];
        zhaoping.type=ENT_Seek;
        zhaoping.Mytype=ENT_Position;
        //        MyJobViewController *vc=[[MyJobViewController alloc]init];
        //        vc.text=@"投递记录";
        //         vc.arr=@[@"投递记录"];
        //         vc.type=ENT_Seek;
        [self pushViewController:zhaoping];
        return;
    }
    JobIdentViewController *vc=[[JobIdentViewController alloc]init];//招聘求职
    vc.type=ENT_Invite;
    [self pushViewController:vc];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 65;
}

- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:
(AMapReGeocodeSearchResponse *)response{
    NSString *title = response.regeocode.addressComponent.city;
    if (title.length == 0)
    {
        title = response.regeocode.addressComponent.province;
    }
    // _mapView.userLocation.title = title;
    // _mapView.userLocation.subtitle = response.regeocode.formattedAddress;
    
    if(response.regeocode != nil)
    {
        //通过AMapReGeocodeSearchResponse对象处理搜索结果
        // NSString *result = [NSString stringWithFormat:@"ReGeocode: %@", response.regeocode];
        
        _adress=[NSString stringWithFormat:@"%@",response.regeocode.formattedAddress];
        _province=response.regeocode.addressComponent.province;
        _city=response.regeocode.addressComponent.city;
        _area=response.regeocode.addressComponent.district;
        
        [network updataMap:_adress longitude:_longtitude latitude:_latitude user_id:[USERMODEL.userID intValue]map_callout:1  province:_province city:_city area:_area  success:^(NSDictionary *obj) {
        } failure:^(NSDictionary *obj2) {
        }];
    }
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==2016) {
        if (buttonIndex==0){
            [self addWaitingView];
            [self showUserLocation:^(NSString *province, NSString *city, CGFloat latitude, CGFloat longtitude) {
                
                AMapReGeocodeSearchRequest *regeoRequest = [[AMapReGeocodeSearchRequest alloc] init];
                // regeoRequest.searchType = AMapSearchType_ReGeocode;
                regeoRequest.location = [AMapGeoPoint locationWithLatitude:latitude longitude:longtitude];
                regeoRequest.radius = 10000;
                regeoRequest.requireExtension = YES;
                _latitude=latitude;
                _longtitude=longtitude;
                //发起逆地理编码
                [_search AMapReGoecodeSearch: regeoRequest];
            }];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    
    NSMutableArray *arr1=[[NSMutableArray alloc]initWithArray:[[IHUtility getUserDefalutDic:kUserDefalutInit] objectForKey:@"configClientItemList"]] ;
    
    MTMeListTableViewCell *cell=[commTableView.table cellForRowAtIndexPath:indexPath];
    
    if (cell.tag==1000) {
        NSDictionary *dic=[IHUtility getUserDefalutDic:kUserDefalutLoginInfo];
        
        MapGeographicalPositionViewController *vc=[[MapGeographicalPositionViewController alloc]init];
        vc.selectPilotBlock=^(CGFloat latitude,CGFloat longtitude,NSString *adress){
            
            UIImage *typeImg=Image(@"store.png");
            UIImage *img=Image(@"GQ_Left.png");
            
            [self addSucessView:@"标注成功" type:1];
            
            //   MTNearUserModel *model=[[MTNearUserModel alloc]initWithDictionary:obj[@"content"] error:nil];
            MTMeListTableViewCell *cell=(MTMeListTableViewCell *)[commTableView.table cellForRowAtIndexPath:_indexPath];
            SMLabel *lbl=[cell viewWithTag:101];
            lbl.frame=CGRectMake(15+typeImg.size.width+100, 25, WindowWith-(15+typeImg.size.width+100)-20-img.size.width-10,15);
            lbl.textAlignment=NSTextAlignmentRight;
            if (WindowWith==320) {
                lbl.font=sysFont(14);
                lbl.height=14;
            }
            lbl.textColor=cGreenColor;
            lbl.text=@"已标注";
            lbl.hidden=NO;
            
        };
        vc.latitude=[NSString stringWithFormat:@"%@",dic[@"addressInfo"][@"latitude"]] ;
        vc.longitude=[NSString stringWithFormat:@"%@",dic[@"addressInfo"][@"longitude"]];
        [self pushViewController:vc];
        
        //        [IHUtility AlertMessage:@"温馨提示" message:@"此操作将覆盖您的地图标注位置" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消" tag:2016];
        _indexPath=indexPath;
    }
    
    if (cell.tag==1001) {
        NSLog(@"我的发布");
        
        [_typeImageView3 removeFromSuperview];
        NSDictionary *dic2=[IHUtility getUserDefalutsDicKey:kBadgeSumNum];
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithDictionary:dic2];
        [dic setObject:@"0" forKey:@"forumAnswer"];
        [IHUtility saveDicUserDefaluts:dic key:kBadgeSumNum];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:NotificationTabBar4HiddenRedPoint object:nil];
        MyReleaseViewController *vc=[[MyReleaseViewController alloc]init];
        vc.i=_answer;
        [self pushViewController:vc];
    }
    
    if (cell.tag==1002) {
        for (NSDictionary *dic in arr1) {
            int itemCode=[dic[@"itemCode"]intValue];
            if (itemCode==1003) {
                int status=[dic[@"status"]intValue];
                if (status==0) {
                    [IHUtility AlertMessage:@"" message:@"服务暂未开通，敬请期待！"];
                    return;
                }
            }
        }
        
        ActivityListViewController *vc=[[ActivityListViewController alloc]init];
        vc.type = @"2";
        [self pushViewController:vc];
    }
    if (cell.tag==1003) {
        for (NSDictionary *dic in arr1) {
            
            int itemCode=[dic[@"itemCode"]intValue];
            if (itemCode==1005) {
                int status=[dic[@"status"]intValue];
                if (status==0) {
                    [IHUtility AlertMessage:@"" message:@"服务暂未开通，敬请期待！"];
                    return;
                }
            }
        }
        
        JionEPCloudViewController *vc=[[JionEPCloudViewController alloc]init];
        [_typeImageView removeFromSuperview];
        [[NSNotificationCenter defaultCenter]postNotificationName:NotificationTabBar4HiddenRedPoint object:nil];
        [self pushViewController:vc];
    }
    
    if (cell.tag==1004) {
        NSLog(@"我的收藏");
        MTMyCollectionViewController *vc=[[MTMyCollectionViewController alloc]init];
        [self pushViewController:vc];
    }
    if (cell.tag==1005) {
        for (NSDictionary *dic in arr1) {
            int itemCode=[dic[@"itemCode"]intValue];
            if (itemCode==1006) {
                int status=[dic[@"status"]intValue];
                if (status==0) {
                    [IHUtility AlertMessage:@"" message:@"服务暂未开通，敬请期待！"];
                    return;
                }
            }
        }
        [self pushToJob];
    }
    if (cell.tag==1006) {
        NSLog(@"我的任务");
        for (NSDictionary *dic in arr1) {
            
            int itemCode=[dic[@"itemCode"]intValue];
            if (itemCode==1010) {
                int status=[dic[@"status"]intValue];
                if (status==0) {
                    [IHUtility AlertMessage:@"" message:@"服务暂未开通，敬请期待！"];
                    return;
                }
            }
        }
        
        [self task:indexPath];
    }
    if (cell.tag==1007) {
        [self ShareUrl:self withTittle:[NSString stringWithFormat:@"%@，加入%@，携手共赢",KAppTitle,KAppName] content:[NSString stringWithFormat:@"我一直在用%@找苗木、搜人脉、找企业。邀你一起来体验，积分还可抵现金用哦",KAppName] withUrl:dwonShareURL imgUrl:@""];
    }
}

-(void)MapAnnotationDelegateSubmit:(int)index{
    // [self setMapCellBZ:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat yOffset   = commTableView.table.contentOffset.y;
    
    _heardBottomView.bottom = _bgView.height;
    if (yOffset < 0) {
        //CGFloat factor = ((ABS(yOffset)+ImageHeight)*ImageWidth)/ImageHeight;
        CGRect f = CGRectMake(0,yOffset, WindowWith, ImageHeight+ABS(yOffset));
        
        _bgView.frame=f;
        _nickNameLbl.origin=CGPointMake(_headerImageView.right+10, 60-yOffset);
        _nickNameLbl.centerX=self.view.centerX;
        _headerImageView.origin=CGPointMake(10, _nickNameLbl.bottom+10);
        _headerImageView.centerX=self.view.centerX;
        _infoBtn.origin=CGPointMake(_nickNameLbl.right+5, _headerImageView.bottom+0.037*WindowWith);
        _infoBtn.centerX=self.view.centerX;
        _fansView.origin=CGPointMake(0, 0.027*WindowWith+_infoBtn.bottom-5);
        _fansView.centerX=self.view.centerX;
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    _heardBottomView.bottom = _bgView.height;
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
