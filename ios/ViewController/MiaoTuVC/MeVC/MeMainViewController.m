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

#import "MyActivityListController.h"
#import "CrowdFundECloutController.h"
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

    UIAsyncImageView *_bgView;
    UIImageView *_imgView;
    UILabel *_userGradeLabel;
    SMLabel *_cumulativeLbl;
    UIView *_heardBottomView;
    UIView *_headView;

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
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = kColor(@"#FFFFFF");
    
    self.naviBarHidden = true;
    leftbutton.hidden = YES;
    [self.view setBackgroundColor:RGB(232, 240, 240)];
    [self creatView];
  
}

-(void)creatView{

    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, iPhoneWidth, kWidth(156) + KStatusBarHeight)];
    _headView = headView;
    
   
    NSDictionary *dic=[IHUtility getUserDefalutsDicKey:kUserDefalutLoginInfo];
    
    UIAsyncImageView *bkImageView=[[UIAsyncImageView alloc]initWithImage:[ConfigManager createImageWithColor:[UIColor whiteColor]]];
    bkImageView.frame=CGRectMake(kWidth(15), kWidth(24) + KStatusBarHeight, kWidth(58), kWidth(58));
    bkImageView.contentMode=UIViewContentModeScaleToFill;
    bkImageView.clipsToBounds=YES;
    _bgView=bkImageView;
    bkImageView.userInteractionEnabled=YES;
    [headView addSubview:bkImageView];
    
    //    UITapGestureRecognizer *mapTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(personInformation)];
    //    [bkImageView addGestureRecognizer:mapTap];
    
    
    
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
    
}



@end
