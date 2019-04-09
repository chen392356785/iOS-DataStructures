//
//  Contant.h
//  AlphaPorject
//
//  Created by xu bin on 13-8-14.
//  Copyright (c) 2013年 xu bin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NurseryListModel;
@class MTSupplyAndBuyListModel,MLLink;
typedef void (^DidSelectheadImageBlock) (NSInteger index);
typedef void (^DidSelectLoginBlock)(NSString *str1,NSString *str2);
typedef void (^DidSelectYZMBlock) (NSString *phone);
typedef void (^DidSelectSurnBlock) (NSString *phone,NSString *code);
typedef void (^DidSelectEditBlock) (MTSupplyAndBuyListModel *model);
typedef void (^DidSelectCommentButtonBlock)(BCTableViewCellAction action);
typedef void (^DidSelectTopViewBlock) (NSInteger index);
typedef void (^DidSelectBtnBlock) (NSInteger index);
typedef void (^LogisDidSelectBtnBlock) (NSInteger index,UIButton *button);
typedef void (^ShowUserLocationBlock)(NSString *province,NSString *city,CGFloat latitude,CGFloat longtitude);
typedef void (^DidSelectCityBlock) (NSString *city);
typedef void (^DidSelectPilotBlock) (CGFloat latitude,CGFloat longtitude,NSString *adress);
typedef void (^DidSelectAreaBlock) (NSString *city,NSString *province,CGFloat latitude,CGFloat longtitude);
typedef void (^DicSelectCompanyBlock) (NSArray *typeArray,NSString *userId,CGFloat latitude,CGFloat longtitude,NSString *companyProvince);
typedef void (^DicSelectTypdeBlock) (NSArray *typeArray);
typedef void (^DidSelectfowlloerBlock) (NSInteger index,NSString *useId);
typedef void (^DidSelectDeleteBlock) (MTSupplyAndBuyListModel *model,NSIndexPath *indexPath);
typedef void (^DidSelectJobAdressBlock) (NSString *province,NSString *city,NSString *town,NSString *street);
typedef void (^DidSelectUserName) (MLLink *link);

typedef void (^DidSelectBlock) ();
typedef void (^DidSelectStrBlock) (NSString *str1);

typedef void (^DidSelectDicBlock) (NSDictionary *dic);
typedef void (^DidSelectNerseryEditBlock) (NurseryListModel *model);

//当前试图状态
typedef enum{
    ENT_top =4,  //顶部
    ENT_midden, //  中部
    ENT_down,   //底部
}tabBarType;

typedef enum{
    ENT_Buy ,   //求购
    ENT_Supply,  //供应
    ENT_Topic,
    ENT_Activties,//活动
    ENT_Photos, //图片集
    ENT_Crowd,//众筹
    ENT_questions,//问吧
    ENT_Answer,//问吧问题分享
    ENT_SeedCloudDetail,//苗木云详情分享
    ENT_MyCrowdList, //我的众筹
}buyType;

typedef enum{
    ENT_City ,   //城市
    ENT_Province,  //省份
}CityType;

typedef enum{
    ENT_Down,//下
    ENT_Up,//上
    ENT_Left,//左
    ENT_LftDown,//左下
    ENT_LeftUp,//左上
    ENT_Right,//右
    ENT_RightDown,//右下
    ENT_RightUp,//右上
    
}DirectionType;


typedef enum{
    ENT_BiaoZhu,//标注
    ENT_RenZheng,//认证
    ENT_WanShang,//完善
    ENT_FaBu,//发布
    ENT_DianZan,//点赞
    ENT_pinglun,//评论
    ENT_RenMai,//人脉交互
   ENT_Edit,//编辑
    
    
}BtnType;




typedef enum{
    ENT_Self ,   //自己
    ENT_Other,  //别人
}PersonType;


typedef enum{
    ENT_Lagin ,   //自己
    ENT_Password,  //别人
}LaginType;



typedef enum{
    ENT_register ,   //注册
    ENT_forget,  //找回密码
}RegisterType;

//view上点击头像
typedef enum{
    SelectheadImageBlock =1000,  //点击头像
    commentBlock,//点击评论
    shareBlock,//分享
    agreeBlock,//点赞
    favoriteBlock,//收藏
    SelectTopViewBlock,//看过我的人
     cancelshareBlock,//取消分享
     cancelagreeBlock,//取消点赞
     cancelfavoriteBlock,//取消收藏
    SelectBtnBlock,//点击按钮
    SelectWXpengyouBtnBlock,//分享给微信朋友圈
    SelectWXhaoyouBtnBlock,//分享给微信好友
    SelectBackVC, //返回
    SelectFansBlock,//粉丝
    SelectguanzhuBlock,//关注
    SelectSaveBlock,//保存
    SelectFollowBlock,//关注
    SelectUpFollowBlock,//取消关注
    deleteSupplyBlock,//删除供应
    deleteBuyBlock,//求购
    deleteTopicBlock,//话题
    closeBlock,//关闭
    openBlock,//开启
    
}cellBlock;


typedef enum{
    SelectCommentBlock  =100,//评论
     SelectTelphoneBlock,//打电话
     SelectHiBlock,//打招呼
     SelectEditBlock,//编辑
     SelectDeleteBlock,//删除
     SelectStoreBlock,//进商店
    SelectPersonInfo, //个人信息
    SelectAgreeBlock,
    SelectBaomingBlock,//我要报名
   
 
    SelectStartBlock,//出发地
    SelectEntBlock,//目的地
    SelectTimeBlock,//装车时间
    SelectMoreBlock,//更多
    
}bottomBlock;


typedef enum{
    SelectNameBlock,//姓名
    SelectPositionBlock,//职位
    SelectCompanyBlock,//公司
     SelectCompanyNameBlock,//公司全称
     SelectCompanyAbbreviationNameBlock,//公司简称
    SelectIndustryBlock,//行业
    SelectAdressBlock,//地址
    SelectPhoneBlock,//电话
    SelectLandBlock,//座机
    SelectEmailBlock,//邮箱
    SelectZhuyingBlock,//主营
    SelectIntroductionBlock,//简介
    SelectDetailedBlock,//详细地址
    SelectaBbreviationBlock,//公司简称
    SelectDepartmentBlock,//所属部门
    SelectLabelBlock,//头衔标签
    SelectPositionNameBlock,//职位名称
    SelectPositiontypeBlock,//职位类型
    SelectCompanyIntroduceBlock,//公司简介
    SelectCompanyWebBlock,//公司网址
     SelectPositionIntroductionBlock,//职位简介
    
    
    
    
}EditBlock;




typedef enum{
    ENT_price,//单价
     ENT_number,//数量
     ENT_ganJing,//杆径
     ENT_guanFu,//冠幅
     ENT_gaoDu,//高度
    ENT_adress,//分枝点
}ReleaseType;

typedef enum{
    ENT_hot,//最热
    ENT_new,//新人
    ENT_neighbourhood,//附近
    
}ContactType;

typedef enum{
    ENT_Collection,//收藏
    ENT_Preson,//个人资料
    ENT_gongying,//供应
    ENT_qiugou,//求购
    ENT_topic,//话题
    ENT_PerSonGongYing, //个人 主页 供应
    ENT_PerSonQiuGou,  //个人主页求购
    ENT_activity,//活动
    ENT_UserDeliveryrecord,//我的投递记录
}CollecgtionType;


typedef enum {
    ENT_Connections,//人脉
    ENT_company,//企业
    ENT_nursery,//苗木云
}EPType;

typedef enum{
    ENT_zixun, //资讯
    ENT_HeZuoQiye, //战略合作企业
    ENT_XinPinZhongPic, //新品种图库
    ENT_pinzhong, //品种
    ENT_qiye, //企业
    ENT_renmai, //人脉
    
}HomePageType;


typedef enum {
    ENT_fans,//粉丝
    ENT_fowller,//关注
}FansType;


typedef enum {
    ENT_Search,//搜索
    ENT_CloseSearch,
}SearchType;



typedef enum {
    ENT_Person,//个人资料
    ENT_Visitingcard,//个人名片
}PersonInformationType;

typedef enum {
    ENT_Invite,//招聘
    ENT_Seek,//求职
    ENT_Null,//空
}JobType;

typedef enum {
    ENT_CurriculumVitae,//简历
    ENT_Position,//职位
}MyJobType;



typedef enum {
    ENT_cheyuan,//他的车源
    ENT_renzheng,//他的认证
}DriverType;//车主资料





#define kUserDefalutPositionInfo                   @"kUserDefalutPositionInfo"  // 职位类型

#define kUserDefalutLoginInfo                   @"kUserDefalutLoginInfo"  // 用户登录信息

#define kUserDefalutInit                        @"kUserDefalutInit"  //初始化数据

#define kUserDefalutInitcity                        @"kUserDefalutInitcity"  //初始化数据获取成市

#define KFansDefalutInfo                        @"KFansDefalutInfo"    //关注 粉丝数

#define KUserInfoDataDic                        @"KUserInfoDataDic"//个人中心
#define KGardenHomeDataDic                      @"GardenHomeDataDic"//园榜首页
#define KGardenSearchDataDic                    @"GardenSearchDataDic"//园榜首页搜索

#define kSupplyDefaultUserList                  @"kSupplyDefaultUserList" // 供应列表缓存
#define  kSupplyUserDate                        @"kSupplyUserDate" //供应时间

#define kBuyDefaultUserList                  @"kBuyDefaultUserList" // 求购列表缓存
#define  kBuyUserDate                        @"kBuyUserDate" //求购时间

#define kSupplyAndBuyDefaultUserList            @"kSupplyAndBuyDefaultUserList"
#define kSupplyAndBuyUserDate                   @"kSupplyAndBuyUserDate"

#define kTopicDefaultUserList               @"kTopicDefaultUserList" //话题 缓存列表
#define  kTopicUserDate                     @"kTopicUserDate"  //话题缓存时间

#define kTopicDefaultUserList                  @"kTopicDefaultUserList" // 话题 列表缓存
#define  kTopicUserDate                        @"kTopicUserDate" //话题时间

#define kThemeDefaultUserList           @"kThemeDefaultUserList"
#define  kThemeUserDate                 @"kThemeUserDate"

#define  kBadgeSumNum               @"kBadgeSumNum"  //角标
#define  kGetInteralDate               @"kGetInteralDate"  //角标
#define  kIdentKey                    @"kIdentKey"//物流身份

#define  KSheQuBadgeSumNum               @"kSheQuBadgeSumNum"  //社区角标
#define  KPopHomeView                  @"KPopHomeView"  //进入首页弹出首页弹框

#define  kJobIdentKey                    @"kJobIdentKey"//招聘求职身份
#define  kJobExprience                    @"kJobExprience"//个人经历
#define  kStudyExprience                    @"kStudyExprience"//个人经历

#define  kSearchHistory                    @"kSearchHistory"//人脉云搜索历史记录
#define  kEPCloudSearchHistory                    @"kEPCloudSearchHistory"//企业云搜索历史记录
#define  kNurserySearchHistory                    @"kNurserySearchHistory"//苗木云搜索历史记录

#define  KWeatherCityArrHistory                    @"KWeatherCityArrHistory"//本地保存天气城市历史记录

#define  kSearchNewsHistory                    @"kSearchNewsHistory"//资讯搜索历史记录



//通知宏
#define NotificationLoginIn         @"NotificationLoginIn"
#define NotificationOutLogin        @"NotificationOutLogin"
#define  NotificationtabBarHidden    @"NotificationtabBarHidden"
#define NotificationHomePageBadgeNum   @"NotificationHomePageBadgeNum"
#define NotificationMeNum   @"NotificationMeNum"

#define NotificationMessageNum    @"NotificationMessageNum"  //消息列表

#define NotificationCurriculum   @"NotificationCurriculum"//收到简历

#define NotificationQusetion   @"NotificationQusetion"//版主有未回复消息
#define NotificationQAnswer   @"NotificationQAnswer"//问题被回复

#define NotificationNavViewHide   @"NotificationNavViewHide"//隐藏话题naview红点

#define NotificationSeeQuestion   @"NotificationSeeQuestion"//看过问吧

#define NotificationSeeTopic   @"NotificationSeeTopic"//看过话题


#define NotificationMyNavViewHide   @"NotificationMyNavViewHide"//隐藏我的发布naview红点

#define NotificationShareSucces   @"NotificationShareSucces" //课程分享成功分享


#define  NotificationPushVC             @"NotificationPushVC"   //消息推送 
#define  NotificationTabBarHiddenRedPoint      @"NotificationTabBarHiddenRedPoint" //是否隐藏红点
#define  NotificationTabBar4HiddenRedPoint      @"NotificationTabBar4HiddenRedPoint" //是否隐藏我的红点
#define NotificationAddSupplyBuyTopic      @"NotificationAddSupplyBuyTopic" //新增供应、求购、话题
#define NotificationAddPosition      @"NotificationAddPosition" //新增职位
#define NotificationEditPosition      @"NotificationEditPosition" //编辑职位
#define NotificationEditLogistics     @"NotificationEditLogistics" //编辑物流需求
#define NotificationEcloud      @"NotificationEcloud" //企业云
#define NotificationChangeTabBarSelectedIndex       @"NotificationChangeTabBarSelectedIndex"//切换tabbar
#define NotificationUpdateUserinfo  @"NotificationUpdateUserinfo"//更新用户信息
#define NotificationRefeshInit    @"NotificationRefeshInit" //更新初始化 //保证每天更新一次
#define NotificationChooseCity    @"NotificationChooseCity"//选择城市
#define NotificationAgree         @"NotificationAgree"//点赞
#define NotificationJobCommunite         @"NotificationJobCommunite"//沟通
#define NotificationloginInfo             @"NotificationloginInfo"  //挤登录
#define NotificationChoosePosition          @"NotificationChoosePosition"//选择职位
#define NotificationCompany @"NotificationCompany"//提交企业认证
#define NotificationCommentMe   @"NotificationCommentMe"  //评论我的
#define NotificationTapLanuch   @"NotificationTapLanuch"//点击启动页活动
#define NotificationIdentAuth   @"NotificationIdentAuth"//提交身份认证资料
#define NotificationUserIdentity   @"NotificationUserIdentity"//切换用户招聘与求职的身份

#define NotificationVoteAction   @"NotificationVoteAction"//投票购买选票购买成功返回时回调

#define NotificationBuyFabuAction   @"NotificationBuyFabuAction"   //提交求购


//保存聊天的对象，用于会话查询
#define kMessageList                    @"kMessageList"
#define kMessageDic                      @"kMessageDic"
/**
 *聊天数据对象
 */
#define  kFromeUserID                    @"kFromeUserID"  //环信id
#define  kFromeNickName                  @"kFromeNickName"
#define  kFromeHeadImage                  @"kFromeHeadImage"
#define  kFromeUser_ID                     @"kFromeUser_ID" //用户id

#define  kToUserID                    @"kToUserID"      //环信id
#define  kToNickName                  @"kToNickName"
#define  kToHeadImage                  @"kToHeadImage"
#define  kToUser_ID                    @"kToUser_ID"  //用户id
//***************************************************************


#define  kYesterday                     @"kYesterday"  //昨天
#define  kToday                         @"kToday" //今天

#define  pageNum      10

#define RGBA(r,g,b,a)							[UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGB(r,g,b)							[UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define kColor(hexString)                 [UIColor colorWithHexString:[NSString stringWithFormat:@"%@",hexString]]

#define SDColor(r, g, b, a) [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a]

#define Global_tintColor [UIColor colorWithRed:0 green:(190 / 255.0) blue:(12 / 255.0) alpha:1]

#define Global_mainBackgroundColor SDColor(248, 248, 248, 1)

#define TimeLineCellHighlightedColor [UIColor colorWithRed:92/255.0 green:140/255.0 blue:193/255.0 alpha:1.0]


#define autoScaleW(width) [(AppDelegate *)[UIApplication sharedApplication].delegate autoScaleW:width]
#define autoScaleH(height) [(AppDelegate *)[UIApplication sharedApplication].delegate autoScaleH:height]


//#define font(R) (R)*(kScreenWidth)/375.0     //这里是iPhone 6屏幕字体

#define font(R) (kScreenWidth> 375? (R) : ((R) *(kScreenWidth)/375.0))            //这里是iPhone 6屏幕字体

#define sysFont(f)  [UIFont fontWithName:@"STHeitiSC-Light" size:autoScaleW(f)]
#define boldFont(f) [UIFont fontWithName:@"Arial-ItalicMT" size:autoScaleW(f)]         //斜体
#define HBoldFont(f) [UIFont fontWithName:@"PingFang-SC-Bold" size:autoScaleW(f)]         //Arial-ItalicMT
#define darkFont(f) [UIFont fontWithName:@"PingFangSC-Medium" size:autoScaleW(f)]      //粗体
#define RegularFont(f) [UIFont fontWithName:@"PingFangSC-Regular" size:autoScaleW(f)]  //
#define LightFont(f) [UIFont fontWithName:@"Helvetica-Light" size:autoScaleW(f)]  //



#define KAmapKey @"ef4a7352e68626c6e1951527aaa07257"//高德key

#define KAmapKey2 @"3c1bf0cbb1661d99fec40a402ab552b3"//高德key企业

#define KAmapKeyYL @"090fe1987767e0cb3b5a2e405b60688d"//宜良高德key

#define kContactType            @"kContactType"


 #ifdef APP_MiaoTu
#define KAppName @"苗途"

#define KAppName2 @"苗 途"//带空格的

#define KAppTitle @"苗木交易 随时随地"

 #elif defined APP_YiLiang

#define KAppName @"宜良苗木"
#define KAppName2 @"宜良苗木"
#define KAppTitle @"优质苗木 一手掌握"

#endif

#define  Image(png) [UIImage imageNamed:png]
#define defalutHeadImage                [UIImage imageNamed:@"defaulthead.png"]

#define DefaultImage_logo           [UIImage imageNamed:@"defaultlogoF.png"]
#define EPDefaultImage_logo           [UIImage imageNamed:@"defaultlogo.png"]

#define DefaultSquareImage           [UIImage imageNamed:@"defaultSquare.png"]
#define kCalloutViewMargin          -8

#define  cBgColor     RGB(247,248,250)   //背景色
#define  cBlackColor  RGB(44, 44, 46)   //深黑色
#define  cLineColor   RGBA(240,240,240,1)   //线得色值
#define  cGrayLightColor    RGBA(135, 134, 140,1)   //浅灰色字体
#define  cGreenColor  RGB(85,201,196)   //绿色
#define  cGreenLightColor  RGB(6,193,174)   //浅绿色
#define windowColor  [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]




#define stringFormatInt(n) [NSString stringWithFormat:@"%@",@(n)]
#define stringFormatString(n)  [NSString stringWithFormat:@"%@",n]
#define stringFormatDouble(n)  [NSString stringWithFormat:@"%f",n]

#define TFTabBarHeight (_boundHeihgt == 812 ? 83 : 49)
#define TFNavigationBar  (_boundHeihgt == 812 ? 88 : 64)
#define TFXHomeHeight  (kScreenHeight == 812 ? 34 : 0)
#define TFStatusHeight (kScreenHeight == 812 ? 44 : 20)







