//
//  MTOtherInfomationMainViewController.m
//  MiaoTuProject
//
//  Created by Mac on 16/3/17.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTOtherInfomationMainViewController.h"
//#import "GongQiuMainViewController.h"
#import "IdentKeyViewController.h"
#import "PersonUserInfromationViewController.h"
#import "OtherUserChildSupplyAndBuyListVC.h"
//#import "MTCollectionBuyTableViewController.h"
//#import "MTTopicListViewController.h"
#import "ChatViewController.h"
#import "EPCloudFansViewController.h"
#import "EPCloudDetailViewController.h"
#import "CustomView+CustomCategory2.h"

@interface MTOtherInfomationMainViewController ()<personInfoDelegate,ChatViewControllerDelegate>
{
    PersonInformationView *_personView;
    NSInteger _supply;
    NSInteger _buy;
    NSInteger _topic;
}
@end

@implementation MTOtherInfomationMainViewController

//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
//
//}
//
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//
//}

-(instancetype)initWithUserID:(NSString *)userID :(BOOL)isMe dic:(NSDictionary *)dic
{
    
    
    OtherUserChildSupplyAndBuyListVC *gongying=[[OtherUserChildSupplyAndBuyListVC alloc]init];
    gongying.userID=userID;
    gongying.type=ENT_Supply;
    OtherUserChildSupplyAndBuyListVC *qiugou=[[OtherUserChildSupplyAndBuyListVC alloc]init];
    qiugou.userID=userID;
    qiugou.type=ENT_Buy;
    OtherUserChildSupplyAndBuyListVC *topic=[[OtherUserChildSupplyAndBuyListVC alloc]init];
    topic.type=ENT_Topic;
    topic.isMe=isMe;
    
    topic.userID=userID;
    NSMutableArray *Arr=[[NSMutableArray alloc]init];
    __weak MTOtherInfomationMainViewController *weakSelf = self;
    
    _supply=[dic[@"supplyNum"] integerValue];
    _buy=[dic[@"wantByNum"] integerValue];
    _topic=[dic[@"topicNum"] integerValue];
    gongying.selectBtnBlock=^(NSInteger index){
        if (index==deleteSupplyBlock) {
            
            [weakSelf setSupply:Arr];
        }
    };
    
    qiugou.selectBtnBlock=^(NSInteger index){
        if (index==deleteBuyBlock){
            [weakSelf setBuy:Arr];
        }
    };
    
    topic.selectBtnBlock=^(NSInteger index){
        if (index==deleteTopicBlock){
            [weakSelf setTopic:Arr];
        }
    };
    
    self = [super initWithControllersForTitle:@[[NSString stringWithFormat:@"供应 %@",[dic[@"supplyNum"] stringValue]],[NSString stringWithFormat:@"求购 %@",[dic[@"wantByNum"] stringValue]],[NSString stringWithFormat:@"参与话题 %@",[dic[@"topicNum"] stringValue]]] controller:gongying,qiugou,topic, nil];
    if (self) {
        // your code
        self.freezenHeaderWhenReachMaxHeaderHeight = YES;
        self.segmentMiniTopInset = 0;
        
        if ([dic[@"company_id"] intValue]==0) {
            self.headerHeight=134;
        }
    }
    return self;
}


-(void)setSupply:(NSMutableArray *)Arr{
    
    __weak MTOtherInfomationMainViewController *weakSelf = self;
    [Arr removeAllObjects];
    _supply=_supply-1;
    [Arr addObject:[NSString stringWithFormat:@"供应 %ld",(long)_supply]];
    [Arr addObject:[NSString stringWithFormat:@"购求 %ld",(long)_buy]];
    [Arr addObject:[NSString stringWithFormat:@"参与话题 %ld",(long)_topic]];
    [weakSelf settitle:Arr];
}


-(void)setBuy:(NSMutableArray *)Arr{
    __weak MTOtherInfomationMainViewController *weakSelf = self;
    [Arr removeAllObjects];
    _buy=_buy-1;
    [Arr addObject:[NSString stringWithFormat:@"供应 %ld",(long)_supply]];
    [Arr addObject:[NSString stringWithFormat:@"购求 %ld",(long)_buy]];
    [Arr addObject:[NSString stringWithFormat:@"参与话题 %ld",(long)_topic]];
    [weakSelf settitle:Arr];
    
}


-(void)setTopic:(NSMutableArray *)Arr{
    __weak MTOtherInfomationMainViewController *weakSelf = self;
    [Arr removeAllObjects];
    [Arr addObject:[NSString stringWithFormat:@"供应 %ld",(long)_supply]];
    [Arr addObject:[NSString stringWithFormat:@"购求 %ld",(long)_buy]];
    _topic=_topic-1;
    [Arr addObject:[NSString stringWithFormat:@"参与话题 %ld",(long)_topic]];
    [weakSelf settitle:Arr];
}


#pragma mark 底部或者头部 代理
-(void)personDelegate:(NSInteger )index{
    
    if (index==SelectheadImageBlock) {
        [self pushToPersonInformationWithUserId:self.userMod.user_id];
    }else if (index==SelectHiBlock){
        if (!USERMODEL.isLogin) {
            [self prsentToLoginViewController];
            return ;
        }
        ChatViewController *vc=[[ChatViewController alloc]initWithChatter:self.userMod.hx_user_name conversationType:eConversationTypeChat];
        vc.nickName=self.userMod.nickname;
        vc.toUserID=stringFormatString(self.userMod.user_id);
        vc.HeadimgUrl=[NSString stringWithFormat:@"%@%@%@",ConfigManager.ImageUrl,self.userMod.heed_image_url,smallHeaderImage];
        vc.delelgate=self;
        [self pushViewController:vc];
    }else if (index==SelectTelphoneBlock){
        
        if (![self.userMod.mobile isEqualToString:@""]) {
            NSString *phoneString = [NSString stringWithFormat:@"tel:%@",self.userMod.mobile];
            UIWebView * callWebview = [[UIWebView alloc] init];
            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:phoneString]]];
            [self.view addSubview:callWebview];
        }else
        {
            [IHUtility addSucessView:@"对方没有留下电话" type:1];
        }
        
    }else if (index==SelectPersonInfo){
        
        VisitingCardView *view=[[VisitingCardView alloc]initWith];
        
        [view setdataWithModel:self.userMod arr:self.arr dic:self.dic];
        [self.view.window addSubview:view];
        [view show];
        
        //    [self pushToPersonInformationWithUserId:self.userMod.user_id];
        
    }else if (index==SelectBackVC){
        [self back:nil];
    }
}


-(void)headViewBlockSelectIndex:(NSInteger)index{
//    __weak MTOtherInfomationMainViewController *weakSelf = self;
    if (index==SelectBtnBlock) {
        IdentKeyViewController *vc=[[IdentKeyViewController alloc]init];
        [self pushViewController:vc];
    }else if (index==SelectFansBlock){
        EPCloudFansViewController *vc=[[EPCloudFansViewController alloc]init];
        vc.selectBlock=^(NSInteger index){
            if (index==SelectFollowBlock) {
                if ([self.userMod.user_id isEqualToString:USERMODEL.userID]) {
                    [self->_personView follow];
                }
            }if (index==SelectUpFollowBlock)
            {
                if ([self.userMod.user_id isEqualToString:USERMODEL.userID]) {
                    [self->_personView quxiaofollow];
                }
            }
        };
        vc.type=ENT_fans;
        vc.userId=self.userMod.user_id;
        [self pushViewController:vc];
        
    }else if (index==SelectguanzhuBlock){
        EPCloudFansViewController *vc=[[EPCloudFansViewController alloc]init];
        vc.selectBlock=^(NSInteger index){
            if (index==SelectFollowBlock) {
                if ([self.userMod.user_id isEqualToString:USERMODEL.userID]) {
                    [self->_personView follow];
                }
            }if (index==SelectUpFollowBlock)
            {
                if ([self.userMod.user_id isEqualToString:USERMODEL.userID]) {
                    [self->_personView quxiaofollow];
                }
            }
        };
        vc.type=ENT_fowller;
        vc.userId=self.userMod.user_id;
        [self pushViewController:vc];
    }else if (index==SelectFollowBlock){
        if (!USERMODEL.isLogin) {
            [self prsentToLoginViewController];
            return ;
        }
        
        [self addWaitingView];
        [network followUser:[USERMODEL.userID intValue]follow_id:[self.userMod.user_id intValue]type:@"0" success:^(NSDictionary *obj) {
            
            [IHUtility addSucessView:@"关注成功" type:1];
            [self->_personView setbuttonValuettention];
            
            if ([self.delegate respondsToSelector:@selector(disPlayFollwer::)]) {
                [self.delegate disPlayFollwer:YES :self.indexPath];
            }
            
            NSDictionary *Dic=[IHUtility getUserDefalutDic:KFansDefalutInfo];
            NSMutableDictionary *fansDic=[[NSMutableDictionary alloc]initWithDictionary:Dic];
            [fansDic setValue:[NSString stringWithFormat:@"%ld",[ fansDic[@"followNum"] integerValue]+1] forKey:@"followNum"];
            
            [IHUtility setUserDefaultDic:fansDic key:KFansDefalutInfo];
            
        } failure:^(NSDictionary *obj2) {
            
        }];
    }else if (index==SelectUpFollowBlock){
        if (!USERMODEL.isLogin) {
            [self prsentToLoginViewController];
            return ;
        }
        
        [IHUtility addWaitingView];
        [network followUser:[USERMODEL.userID intValue]follow_id:[self.userMod.user_id intValue]type:@"1" success:^(NSDictionary *obj) {
            
            [self addSucessView:@"取消关注成功" type:1];
            [self->_personView setbuttonValueCancel];

            NSDictionary *Dic=[IHUtility getUserDefalutDic:KFansDefalutInfo];
            NSMutableDictionary *fansDic=[[NSMutableDictionary alloc]initWithDictionary:Dic];
            
            [fansDic setValue:[NSString stringWithFormat:@"%ld",[ fansDic[@"followNum"] integerValue]-1] forKey:@"followNum"];
            [IHUtility setUserDefaultDic:fansDic key:KFansDefalutInfo];
            
            
            if ([self.delegate respondsToSelector:@selector(disPlayFollwer::)]) {
                [self.delegate disPlayFollwer:NO :self.indexPath];
            }
            
        } failure:^(NSDictionary *obj2) {
            
        }];
        
    }else if (index==shareBlock){
        //
        //        [weakSelf Shareinformation:self.userMod.user_id name:self.userMod.nickname phone:self.userMod.business_direction adress:[NSString stringWithFormat:@"%@company/Card.html?id=%@",shareURL,self.userMod.user_id] imgUrl:self.userMod.heed_image_url vc:self];
        
    }else{
        
        [network getCompanyHomePage:[NSString stringWithFormat:@"%ld",index] success:^(NSDictionary *obj) {
            EPCloudDetailViewController *vc=[[EPCloudDetailViewController alloc]init];
            EPCloudListModel *model=obj[@"content"];
            vc.model=model;
            [self pushViewController:vc];
            
        } failure:^(NSDictionary *obj2) {
            
        }];
    }
    
}
-(void)home:(id)sender{
    [self Shareinformation:self.userMod.user_id name:self.userMod.nickname phone:self.userMod.business_direction adress:[NSString stringWithFormat:@"%@oneCard.html?id=%@",shareURL,self.userMod.user_id] imgUrl:self.userMod.heed_image_url vc:self];
}

-(UIView<ARSegmentPageControllerHeaderProtocol> *)customHeaderView
{
    
    __weak MTOtherInfomationMainViewController *weakSelf = self;
    PersonInformationView *personView=[[PersonInformationView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, self.headerHeight) ];
    personView.delegate=self;
    _personView=personView;
    
    personView.selectBtnBlock=^(NSInteger index){
        [weakSelf headViewBlockSelectIndex:index];
    };
    [personView setDataWithdic:self.dic];
    [personView setUserChildrenInfo:self.userMod];
    return personView;
}

-(void)pushPersonInfo:(NSDictionary *)obj{
    [self removeWaitingView];
    if ([[obj[@"content"][@"user_id"] stringValue]isEqualToString:USERMODEL.userID]) {
        [ConfigManager setUserInfiDic:obj[@"content"]];
        [IHUtility saveDicUserDefaluts:obj[@"content"] key:kUserDefalutLoginInfo];
    }
//    UserChildrenInfo *userModel=[[UserChildrenInfo alloc]initWithDic:obj[@"content"]];
    PersonUserInfromationViewController *personVC=[[PersonUserInfromationViewController alloc]init];
    personVC.userid=[obj[@"content"][@"user_id"] stringValue];
    personVC.dic=obj[@"content"];
//    personVC.UserModel=userModel;
    personVC.arr=self.arr;
    [self pushViewController:personVC];
}

-(void)pushToPersonInformationWithUserId:(NSString*)userid
{
    __weak MTOtherInfomationMainViewController *weakSelf=self;
    [self addWaitingView];
    [network selectUseerInfoForId:[userid intValue] success:^(NSDictionary *obj) {
        
        [weakSelf pushPersonInfo:obj];
        
    } failure:^(NSDictionary *obj2) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    BOOL isSelf=NO;
    [self setTitle:self.dic[@"nickname"]];
    self.view.backgroundColor = cBgColor;
    NSString *MyuserID=USERMODEL.userID;
    [self setRightButtonImage:Image(@"shareGreen.png") forState:UIControlStateNormal];
    if (![self.userMod.user_id isEqualToString:MyuserID]) {
        PersonInformationBottomView *bottomView=[[PersonInformationBottomView alloc]initWithisSelf:isSelf];
        bottomView.delegate=self;
        [self.view addSubview:bottomView];
        
        [network getuserView:[USERMODEL.userID intValue] view_user_id:[self.userMod.user_id intValue]success:^(NSDictionary *obj) {
            
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ChatViewControllerDelegate

// 根据环信id得到要显示头像路径，如果返回nil，则显示默认头像
- (NSString *)avatarWithChatter:(NSString *)chatter{
    NSString *str=[NSString stringWithFormat:@"%@%@",self.userMod.heed_image_url,smallHeaderImage];
    NSString *userHead=USERMODEL.userHeadImge80;
    NSString *userID=[self.userMod.hx_user_name lowercaseString];
    
    if ([chatter isEqualToString:userID]) {
        return str;
    }else{
        return userHead;
    }
    
    return nil;
}

// 根据环信id得到要显示用户名，如果返回nil，则默认显示环信id
- (NSString *)nickNameWithChatter:(NSString *)chatter{
    return chatter;
}

@end
