//
//  MeMainViewController.m
//  MiaoTuProject
//
//  Created by Mac on 16/3/9.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MeMainViewController.h"
//#import "PersonUserInfromationViewController.h"
#import "EditPersonInformationViewController.h"
#import "MapAnnotationViewController.h"
#import "MTMyCollectionViewController.h"
//#import "MTCommentForMeListViewController.h"
//#import "MTOtherInfomationMainViewController.h"
//#import "CompanyCumlativeViewController.h"
//#import "FindOutMeViewController.h"
#import "SettingViewController.h"
//#import "ChatListViewController.h"
//#import "MTNetworkData+ForModel.h"
//#import "MYTaskViewController.h"
//#import "ActivityListViewController.h"
//#import "IdentKeyViewController.h"
//#import "InvitedViewController.h"
#import "MapGeographicalPositionViewController.h"
#import "JionEPCloudViewController.h"
//新闻
//#import "NewsTableListViewController.h"
//#import "PositionListViewController.h"
//#import "ResumeViewController.h"
#import "EPCloudFansViewController.h"
//#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
//#import <AMapSearchKit/AMapSearchKit.h>
//#import <CoreLocation/CoreLocation.h>
//#import "JobIdentViewController.h"
//#import "MyJobViewController.h"
#import "MyReleaseViewController.h"
//#import "WXWaveView.h"

#import "MyActivityListController.h"
//#import "CrowdFundECloutController.h"

#import "ULBCollectionViewFlowLayout.h"     //分区背景色
#import "MeMainCollectionViewCell.h"
#import "MeMainCollectionReusableView.h"
//#import "UserInfoDataModel.h"
#import "MyClassSourceController.h"       //我的课程
#import "YLWebViewController.h"
#import "MeMainView.h"                    //
#import "IdeaFeedBackViewController.h"    //意见反馈
#import "MyMiaoTuBViewController.h"       //我的苗途币
//#import "MiaoTuVipViewController.h"       //加入VIP
#import "MyRankingListController.h"       //排行榜
#import "MyMTCardViewController.h"        //卡券
#import "PartenerListViewController.h"    //我邀请的合伙
#import "MiaoBiInfoViewController.h"
#import "InviteCodeViewController.h"      //邀请码输入
#import "ShareMtViewController.h"         //分享好友得奖励
#import "MyMessageListViewController.h"   //我的消息

#define  commentMeCell  4
#define  MapBZCell 2

#define  ImageHeight  0.69*WindowWith
#define  ImageWidth    _deviceSize.width
@interface MeMainViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,MapAnnotationDelegate,AMapSearchDelegate>
{
    
    NSInteger _answer;
    
    
    NSMutableArray *infoDataArr;
    UserInfoDataModel *Umodel;      //用户信息
    NSMutableArray *sectionmArr;
}
@property (nonatomic, strong) UICollectionView *collectionView;

@end


static NSString *MeMainHeadCollectionViewCellID  = @"MeMainHeadCollectionViewCell";
static NSString *MeMainVipCollectionViewCellID   = @"MeMainVipCollectionViewCell";
static NSString *MePartnerCollectionViewCellID   = @"MePartnerCollectionViewCellID";
static NSString *MeMainToolCollectionViewCellID  = @"MeMainToolCollectionViewCell";
static NSString *MeMainHelpCollectionViewCellID  = @"MeMainHelpCollectionViewCell";

static NSString *MeMainLunboCollectionViewCellID  = @"MeMainLunboCollectionViewCell";   //轮播


static NSString *MeMainCollectionReusableViewID  = @"MeMainCollectionReusableView";

@implementation MeMainViewController

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        ULBCollectionViewFlowLayout *flowlayout = [[ULBCollectionViewFlowLayout alloc] init];
        //设置滚动方向
        [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, KStatusBarHeight, iPhoneWidth, iPhoneHeight  - KTabBarHeight - KStatusBarHeight) collectionViewLayout:flowlayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor] ;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        //注册Cell，必须要有
        [_collectionView registerClass:[MeMainHeadCollectionViewCell class] forCellWithReuseIdentifier:MeMainHeadCollectionViewCellID];
        [_collectionView registerClass:[MeMainVipCollectionViewCell class] forCellWithReuseIdentifier:MeMainVipCollectionViewCellID];
        [_collectionView registerClass:[MeMainLunboCollectionViewCell class] forCellWithReuseIdentifier:MeMainLunboCollectionViewCellID];   //苗途合伙人
        [_collectionView registerClass:[MeMainToolCollectionViewCell class] forCellWithReuseIdentifier:MeMainToolCollectionViewCellID];
        [_collectionView registerClass:[MeMainToolCollectionViewCell class] forCellWithReuseIdentifier:MeMainHelpCollectionViewCellID];
        
        [_collectionView registerClass:[MeMainCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MeMainCollectionReusableViewID];
        
         [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"placeholderFooter"];
        
    }
    return _collectionView;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setHomeTabBarHidden:NO];
    [self getUserInfoData];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    infoDataArr = [[NSMutableArray alloc] init];
    sectionmArr = [[NSMutableArray alloc] init];
    self.naviBarHidden = true;
    leftbutton.hidden = YES;
   
    [self creatView];
}
- (void) getUserInfoData {
    NSDictionary *dict = @{
                           @"user_id" :  USERMODEL.userID
                           };
    [network httpRequestTagWithParameter:dict method:getUserinfoDataUrl tag:IH_init success:^(NSDictionary *obj) {
        NSDictionary *dict = obj[@"content"];
        if (dict != nil) {
            [self->sectionmArr removeAllObjects];
            [IHUtility setUserDefaultDic:dict key:KUserInfoDataDic];
           self->Umodel = [[UserInfoDataModel alloc] initWithDictionary:dict error:nil];
            for (pointParamsModel * model in self->Umodel.pointParams) {
                [self->sectionmArr addObject:model];
            }

            USERMODEL.isDue = [self->Umodel.userInfo.isDue intValue];
        }
        [self.collectionView reloadData];
    } failure:^(NSDictionary *dic) {
        
    }];

}
-(void)creatView {
//    _search = [[AMapSearchAPI alloc] init];
//    _search.delegate = self;
    
    NSDictionary *Dic=[IHUtility getUserDefalutDic:KUserInfoDataDic];
    if (Dic != nil) {
        Umodel = [[UserInfoDataModel alloc] initWithDictionary:Dic error:nil];
        for (pointParamsModel * model in Umodel.pointParams) {
            [sectionmArr addObject:model];
        }
    }
    [self.view addSubview:self.collectionView];

}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return sectionmArr.count + 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else {
        pointParamsModel * model = [sectionmArr objectAtIndex:(section - 1)];
        if ([model.sortType isEqualToString:@"1"]) {
            return 1;
        }else if ([model.sortType isEqualToString:@"0"]) {
            return 1;
        }else {
            return model.pointsMenuList.count;
        }
    }
}
//每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (Umodel.topHELPMenu.count <= 0) {
            return CGSizeMake(iPhoneWidth, kWidth(163) + kWidth(48));
        }
        return CGSizeMake(iPhoneWidth, kWidth(163) + kWidth(48)) ;
    }else {
        pointParamsModel * model = [sectionmArr objectAtIndex:indexPath.section -1];
        if ([model.sortType isEqualToString:@"0"]) {
            return CGSizeMake(iPhoneWidth, kWidth(233));
        }else if ([model.sortType isEqualToString:@"1"]) {
            return CGSizeMake(iPhoneWidth, kWidth(103));
        }else{
             return CGSizeMake(kWidth(67), kWidth(62));
        }
    }
}
//cell的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return (iPhoneWidth - (kWidth(67) * 4) - kWidth(30))/3;
}
//cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return kWidth(22);
}

//四周的边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
         return UIEdgeInsetsMake(0, 0, 0, 0);
    } else {
        pointParamsModel * model = [sectionmArr objectAtIndex:section - 1];
        if ([model.sortType isEqualToString:@"1"]) {
            return UIEdgeInsetsMake(0, 0, 0, 0);
        }else if ([model.sortType isEqualToString:@"0"]) {
            return UIEdgeInsetsMake(0, 0, 0, 0);
        }else{
             return UIEdgeInsetsMake(kWidth(30), kWidth(15), kWidth(38), kWidth(15));
        }
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
         MeMainHeadCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MeMainHeadCollectionViewCellID forIndexPath:indexPath];
        cell.Umodel = Umodel;
        WS(weakSelf);
        cell.UserItemBlock = ^(NSInteger index) {
            if (index == 3012) {       //卡券
                [weakSelf jumpKajuan];
            }
            if (index == 3013) {       //苗途币
                [weakSelf jumpMiaobi];
            }
            if (index == 3014) {       //粉丝
               [weakSelf jumpFens];
            }
            if (index == 3015) {       //关注
                 [weakSelf jumpGuanZ];
            } if (index == 2019) {     //发布
                MyReleaseViewController *vc = [[MyReleaseViewController alloc]init];
                [weakSelf pushViewController:vc];
            }else {
                
            }
        };
        cell.JoinVipBlock = ^{
            [weakSelf jumpJoinVip];
        };
        cell.SettingBlock = ^{
             [weakSelf jumpSetting];
        };
        cell.UserEditBlock = ^{
             [weakSelf jumpEditUserInfo];
        };
        cell.duihuanBlock = ^{
            [weakSelf duihuanCode];
        };
        return cell;
    } else {
        pointParamsModel * model = [sectionmArr objectAtIndex:indexPath.section-1];
        if ([model.sortType isEqualToString:@"0"]) {        //轮播图
            MeMainLunboCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MeMainLunboCollectionViewCellID forIndexPath:indexPath];
            [cell setModel:model];
            WS(weakSelf);
            cell.ItemBlock = ^(pointsAdvListModel * model) {
//                pointsAdvListModel *pModel = model.pointsAdvList[index];
                pointsAdvListModel *pModel = model;
                [weakSelf jumpVipServicepointsAdvListModel:pModel];
            };
            return cell;
        }else if ([model.sortType isEqualToString:@"1"]) {
            MeMainVipCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MeMainVipCollectionViewCellID forIndexPath:indexPath];
            [cell setModel:model];
            WS(weakSelf);
            cell.VipItemBlock = ^(NSInteger index) {
                pointsAdvListModel *pModel = model.pointsAdvList[index];
                [weakSelf jumpVipServicepointsAdvListModel:pModel];
            };
            return cell;
        }else {
            pointParamsModel * model = [sectionmArr objectAtIndex:indexPath.section-1];
            MeMainToolCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MeMainHelpCollectionViewCellID forIndexPath:indexPath];
            pointsAdvListModel *listModel = model.pointsMenuList[indexPath.row];
            if ([listModel.menuCode isEqualToString:@"3030"]) {   //我的消息
                cell.BadgeView.hidden = NO;
                NSLog(@"%@",Umodel.userInfo.messageNum);
                cell.BadgeView.num = [Umodel.userInfo.messageNum intValue];
            }else {
                cell.BadgeView.hidden = YES;
            }
            [cell setModel:listModel];
            return cell;
        }
    }
}
//分区头视图
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(0, 0);
    }
    pointParamsModel * model = [sectionmArr objectAtIndex:section -1];
    if ([model.sortType isEqualToString:@"1"]) {
        if (model.pointsAdvList.count <= 0) {
            return CGSizeMake(iPhoneWidth, kWidth(0));
        }
    }else if ([model.sortType isEqualToString:@"0"]) {
        if (model.pointsAdvList.count <= 0) {
            return CGSizeMake(iPhoneWidth, kWidth(0));
        }
    }else {
        if (model.pointsMenuList.count <= 0) {
             return CGSizeMake(iPhoneWidth, kWidth(0));
        }
    }
    return CGSizeMake(iPhoneWidth, kWidth(41));
}
//分区尾视图
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section == 0) {
       return CGSizeMake(iPhoneWidth, kWidth(7));
    }else {
        pointParamsModel * model = [sectionmArr objectAtIndex:section -1];
        if ([model.sortType isEqualToString:@"1"] || [model.sortType isEqualToString:@"0"]) {
            return CGSizeMake(iPhoneWidth, kWidth(0));
        }else if (section == sectionmArr.count) {
            return CGSizeMake(iPhoneWidth, kWidth(0));
        }else{
           return CGSizeMake(iPhoneWidth, kWidth(7));
        }
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if (indexPath.section != 0) {
            MeMainCollectionReusableView *DetailHeadView = [collectionView  dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MeMainCollectionReusableViewID forIndexPath:indexPath];
            DetailHeadView.backgroundColor = [UIColor whiteColor];
             pointParamsModel * model = [sectionmArr objectAtIndex:indexPath.section-1];
            [DetailHeadView setModel:model];
            return DetailHeadView;
        }else {
            UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"placeholderHeader" forIndexPath:indexPath];
            view.backgroundColor = [UIColor whiteColor];
            return view;
        }
    }else {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"placeholderFooter" forIndexPath:indexPath];
        view.backgroundColor = kColor(@"#F2F6F9");
        return view;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section != 0) {
         pointParamsModel * model = [sectionmArr objectAtIndex:indexPath.section-1];
        if (![model.sortType isEqualToString:@"1"] && ![model.sortType isEqualToString:@"0"]) {
            pointsAdvListModel *Pmodel = model.pointsMenuList[indexPath.row];
            [self jumpToolModel:Pmodel];
        }
    }
}
#pragma mark 卡卷
- (void) jumpKajuan {
//     NSLog(@"卡卷");
    MyMTCardViewController *CarVc = [[MyMTCardViewController alloc] init];
    [self pushViewController:CarVc];
}
#pragma mark 苗途币
- (void) jumpMiaobi {
//    NSLog(@"苗途币");
    MyMiaoTuBViewController *miaoVc = [[MyMiaoTuBViewController alloc] init];
    miaoVc.Umodel = Umodel;
    [self pushViewController:miaoVc];
    WS(weakSelf);
    miaoVc.yaoqinghaoyouBlock = ^{
        ShareMtViewController *shareVc = [[ShareMtViewController alloc] init];
        shareVc.model = self->Umodel.allUrl;
        shareVc.infoModel = self->Umodel.userInfo;
        [weakSelf pushViewController:shareVc];
    };
}
#pragma mark 粉丝
- (void) jumpFens {
    EPCloudFansViewController *vc=[[EPCloudFansViewController alloc]init];
    vc.userId=USERMODEL.userID;
    vc.type=ENT_fans;
    vc.selectBlock=^(NSInteger index){
        if (index== SelectFollowBlock) {
            
        }if (index==SelectUpFollowBlock)
        {
            
        }
    };
    [self pushViewController:vc];
//    NSLog(@"粉丝");
}
#pragma mark 关注
- (void) jumpGuanZ {
    EPCloudFansViewController *vc=[[EPCloudFansViewController alloc]init];
    vc.selectBlock=^(NSInteger index){
        if (index == SelectFollowBlock) {
            
            //            NSDictionary *Dic=[IHUtility getUserDefalutDic:KFansDefalutInfo];
            //            NSMutableDictionary *fansDic=[[NSMutableDictionary alloc]initWithDictionary:Dic];
            //            [fansDic setValue:[NSString stringWithFormat:@"%ld",[ fansDic[@"followNum"] integerValue]+1] forKey:@"followNum"];
            //
            //            [IHUtility setUserDefaultDic:fansDic key:KFansDefalutInfo];
        }if (index == SelectUpFollowBlock)
        {
            //            NSDictionary *Dic=[IHUtility getUserDefalutDic:KFansDefalutInfo];
            //            NSMutableDictionary *fansDic=[[NSMutableDictionary alloc]initWithDictionary:Dic];
            //            [fansDic setValue:[NSString stringWithFormat:@"%ld",[ fansDic[@"followNum"] integerValue]-1] forKey:@"followNum"];
            //
            //            [IHUtility setUserDefaultDic:fansDic key:KFansDefalutInfo];
        }

    };
    vc.userId = USERMODEL.userID;
    vc.type = ENT_fowller;
    [self pushViewController:vc];
//    NSLog(@"关注");
}
#pragma mark 编辑资料
- (void) jumpEditUserInfo {
    EditPersonInformationViewController *editVC=[[EditPersonInformationViewController alloc]init];
    [self pushViewController:editVC];
//     NSLog(@"编辑资料");
}
#pragma mark 设置
- (void) jumpSetting {
    SettingViewController *vc = [[SettingViewController alloc]init];
    [self pushViewController:vc];
//    NSLog(@"设置");
}
#pragma mark 加入会员
- (void) jumpJoinVip {
    
    MiaoBiInfoViewController *VipVc = [[MiaoBiInfoViewController alloc] init];
    //            VipVc.NameTitle = @"加入VIP";
    [VipVc setTitle:@"加入VIP" andTitleColor:kColor(@"#393838")];
    VipVc.type = 1;
    
    if(Umodel.allUrl.yearurl && ![Umodel.allUrl.yearurl isEqualToString:@""]) {
        VipVc.mUrl=[NSURL URLWithString:Umodel.allUrl.yearurl];
        [self pushViewController:VipVc];
        WS(weakSelf);
        VipVc.lianxiKefuBlock = ^{
            [weakSelf popContactKefu];
        };
    }
    
    

}

#pragma mark 会员服务
- (void) jumpVipServicepointsAdvListModel:(pointsAdvListModel *) pointsModel{
   
        WS(weakSelf);
       if ([pointsModel.menuCode isEqualToString:@"2005"] || [pointsModel.menuCode isEqualToString:@"2003"]) {   //加入 月卡 - 年卡
            MiaoBiInfoViewController *VipVc = [[MiaoBiInfoViewController alloc] init];
//            VipVc.NameTitle = @"加入VIP";
           [VipVc setTitle:@"加入VIP" andTitleColor:kColor(@"#393838")];
            VipVc.type = 1;
//            VipVc.navBg = @"img_joinVip_img";
          
            VipVc.mUrl=[NSURL URLWithString:pointsModel.jumpUrl];
            [self pushViewController:VipVc];
            WS(weakSelf);
            VipVc.lianxiKefuBlock = ^{
                [weakSelf popContactKefu];
            };
            NSLog(@"加入vip");
        }else if ([pointsModel.menuCode isEqualToString:@"2002"]) {   //城市记忆
            PartenerListViewController *partListVc = [[PartenerListViewController alloc] init];
            [self pushViewController:partListVc];
            
            NSLog(@"城市记忆");
        }else if ([pointsModel.menuCode isEqualToString:@"2004"]) {   //苗途合伙人
            NSLog(@"苗途合伙人");
            [weakSelf joinPartner];
        }else if ([pointsModel.menuCode isEqualToString:@"2000"]) {   //ip升级会员享特权
            NSLog(@"ip升级会员享特权");
        }else if ([pointsModel.menuCode isEqualToString:@"2001"]) {   //马后优选
            NSLog(@"2001");
        }else  if ([pointsModel.isJump isEqualToString:@"2"]) {
            MiaoBiInfoViewController *controller=[[MiaoBiInfoViewController alloc]init];
            controller.NameTitle = pointsModel.menuName;
            controller.type = 1;
            controller.mUrl=[NSURL URLWithString:pointsModel.jumpUrl];
            [self pushViewController:controller];
        } else {
            
        }
}

#pragma mark 兑换码兑换
- (void) duihuanCode{
    InviteCodeViewController *inviteVc = [[InviteCodeViewController alloc] init];
    inviteVc.titleName = @"我的兑换码";
    inviteVc.typeStr = @"2";
    [self pushViewController:inviteVc];
}

#pragma mark - 工具模块
- (void) jumpToolModel:(pointsAdvListModel *)model {
    if ([model.isJump isEqualToString:@"2"]) {
        YLWebViewController *controller=[[YLWebViewController alloc]init];
        controller.NameTitle = model.menuName;
        controller.type = 1;
        controller.mUrl = [NSURL URLWithString:model.jumpUrl];
        [self pushViewController:controller];
    }else {
        if ([model.menuCode isEqualToString:@"3001"]) {         //我的学习
            MyClassSourceController *myClassVc = [[MyClassSourceController alloc] init];
            [self pushViewController:myClassVc];
//        NSLog(@"我的学习");
        }else if ([model.menuCode isEqualToString:@"3002"]) {   //我要充值
            NSLog(@"我要充值");
        }else if ([model.menuCode isEqualToString:@"3003"]) {   //我的收藏
            MTMyCollectionViewController *vc=[[MTMyCollectionViewController alloc]init];
            [self pushViewController:vc];
//        NSLog(@"我的收藏");
        }else if ([model.menuCode isEqualToString:@"3004"]) {   //我的发布
            MyReleaseViewController *vc = [[MyReleaseViewController alloc]init];
            [self pushViewController:vc];
//        NSLog(@"我的发布");
        }else if ([model.menuCode isEqualToString:@"3005"]) {   //我的活动
            MyActivityListController *vc=[[MyActivityListController alloc]init];
//        vc.type = @"2";
            [self pushViewController:vc];
//        NSLog(@"我的活动");
        }else if ([model.menuCode isEqualToString:@"3006"]) {   //地图标注
            NSDictionary *dic = [IHUtility getUserDefalutDic:kUserDefalutLoginInfo];
            MapGeographicalPositionViewController *vc=[[MapGeographicalPositionViewController alloc]init];
            vc.selectPilotBlock=^(CGFloat latitude,CGFloat longtitude,NSString *adress){
                [self addSucessView:@"标注成功" type:1];
            };
            vc.latitude=[NSString stringWithFormat:@"%@",dic[@"addressInfo"][@"latitude"]] ;
            vc.longitude=[NSString stringWithFormat:@"%@",dic[@"addressInfo"][@"longitude"]];
            [self pushViewController:vc];
//        NSLog(@"地图标注");
        }else if ([model.menuCode isEqualToString:@"3007"]) {   //排行榜
            NSLog(@"排行榜");
            MyRankingListController *rankListVc = [[MyRankingListController alloc] init];
            [self pushViewController:rankListVc];
        }else if ([model.menuCode isEqualToString:@"3008"]) {   //邀请好友
            ShareMtViewController *shareVc = [[ShareMtViewController alloc] init];
            shareVc.model = Umodel.allUrl;
            shareVc.infoModel = Umodel.userInfo;
            [self pushViewController:shareVc];        
        }else if ([model.menuCode isEqualToString:@"3009"]) {   //联系客服
//            NSLog(@"联系客服");
            [self popContactKefu];
        }else if ([model.menuCode isEqualToString:@"3010"]) {   //意见反馈
//            NSLog(@"意见反馈");
            IdeaFeedBackViewController *vc=[[IdeaFeedBackViewController alloc]init];
            [self pushViewController:vc];
        }else if ([model.menuCode isEqualToString:@"3011"]) {   //我的园林云
            JionEPCloudViewController *vc=[[JionEPCloudViewController alloc]init];
            [self pushViewController:vc];
        }else if ([model.menuCode isEqualToString:@"3027"]) {   //加入合伙人
//            if ([Umodel.userInfo.isPartner isEqualToString:@"0"]) {
//                NSLog(@"加入合伙人");
//                MiaoBiInfoViewController *partVc = [[MiaoBiInfoViewController alloc] init];
//                partVc.navBgColor = kColor(@"#15CEB7");
//                partVc.NameTitle = @"加入合伙人规则";
//                partVc.type = 1;
//                partVc.mUrl = [NSURL URLWithString:Umodel.allUrl.toPartnerRules_Url];
//                [self pushViewController:partVc];
//            }else {
                PartenerListViewController *partListVc = [[PartenerListViewController alloc] init];
                [self pushViewController:partListVc];
//            }
        }else if ([model.menuCode isEqualToString:@"3029"]) {   //兑付
            MyMTCardViewController *CarVc = [[MyMTCardViewController alloc] init];
            [self pushViewController:CarVc];
            NSLog(@"兑换");
        }else if ([model.menuCode isEqualToString:@"3030"]) {   //我的消息
            NSLog(@"我的消息");
            if (!USERMODEL.isLogin) {
                [self prsentToLoginViewController];
                return;
            }
            MyMessageListViewController *myMessVc = [[MyMessageListViewController alloc] init];
            [self pushViewController:myMessVc];
        }else if ([model.menuCode isEqualToString:@"3031"]) {   //邀请码输入
            InviteCodeViewController *inviteVc = [[InviteCodeViewController alloc] init];
            inviteVc.title = @"邀请码";
            inviteVc.typeStr = @"1";
            [self pushViewController:inviteVc];
        }else{
        
        }
    }
}

#pragma mark - 加入合伙人
- (void) joinPartner{
    
    MiaoBiInfoViewController *partVc = [[MiaoBiInfoViewController alloc] init];
    partVc.navBgColor = kColor(@"#15CEB7");
    partVc.NameTitle = @"加入合伙人规则";
    partVc.type = 1;
    NSString *mUrl;
    if ([Umodel.userInfo.isPartner isEqualToString:@"0"]) {
        NSLog(@"加入合伙人");
        mUrl = [NSString stringWithFormat:@"%@?isPartner=%@",Umodel.allUrl.toPartnerRules_Url,@"2"];
    }else {
        mUrl = [NSString stringWithFormat:@"%@?isPartner=%@",Umodel.allUrl.toPartnerRules_Url,@"1"];
    }
    partVc.mUrl = [NSURL URLWithString:mUrl];
    WS(weakSelf);
    partVc.lianxiKefuBlock = ^{
        [weakSelf popContactKefu];
    };
    [self pushViewController:partVc];
    
}

#pragma mark - 联系客服
- (void) popContactKefu{
    MeMainKefuView * kefuPopView = [[MeMainKefuView alloc] initWithFrame:CGRectMake(0, 0, kWidth(262), kWidth(323))];
    [kefuPopView setkefuNum:Umodel.wx_code];
    [self showPopupWithStyle:CNPPopupStyleCentered popupView:kefuPopView];
    __weak typeof (self) weekSelf = self;
    kefuPopView.CancelBlock = ^{
        [weekSelf.popupViewController dismissPopupControllerAnimated:YES];
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

@end
