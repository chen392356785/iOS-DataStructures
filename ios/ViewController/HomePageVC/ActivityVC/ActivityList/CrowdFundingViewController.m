//
//  CrowdFundingViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/8/8.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "CrowdFundingViewController.h"
#import "XHFriendlyLoadingView.h"
//#import "BCPayReq.h"
#import "BeeCloud.h"
#import "MTOtherInfomationMainViewController.h"
#import "PayTypeConstants.h"
#import "PayMentMangers.h"
#import "CustomView+CustomCategory2.h"

//#import "ActivityPaySuccessfulViewController.h"
@interface CrowdFundingViewController ()<UITableViewDelegate,BeeCloudDelegate>
{
    MTBaseTableView *commTableView;
    int page;
    NSMutableArray *dataArray;
    int payChanle;
    NSString *type;
    BOOL APayShow;
}

@end

@implementation CrowdFundingViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [BeeCloud setBeeCloudDelegate:self];
    
    [self setRightButtonImage:[Image(@"Group 11.png") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    rightbutton.hidden=NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    if ([self.Type isEqualToString:@"2"]) {
        [self getOrderData];
    }else {
        [self creatTableView];
        self.crowdID = [NSString stringWithFormat:@"%ld",self.model.infoModel.crowd_id];
    }
}
-(void)home:(id)sender{
    
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    NSString *phoneString = [NSString stringWithFormat:@"tel:%@",KTelNum];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:phoneString]]];
    [self.view addSubview:callWebview];
}

-(void)creatTableView{
    
    CGFloat hh = kBottomNoSapce;
    CGFloat nav_h = kNavigationHeight;
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-nav_h-49-hh, WindowWith, 49)];
    view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view];
    
    [self setTitle:[NSString stringWithFormat:@"%@发起的众筹",self.model.infoModel.nickname]];
    
    BtnView *btnView=[[BtnView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2+5, 6, (SCREEN_WIDTH-30)/2, 38) cornerRadius:20 text:@"找人帮我筹款" image:nil];
    
    [btnView addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    btnView.titleLabel.font=sysFont(17);
//    btnView.centerX=view.centerX;
    //[btnView addTarget:self action:@selector(pushToVisitingCard) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnView];
    
    BtnView *btnView2=[[BtnView alloc]initWithFrame:CGRectMake(10, 6, (SCREEN_WIDTH-30)/2, 38) cornerRadius:20 text:@"" image:nil];
    [btnView2 setTitleColor:cBlackColor forState:UIControlStateNormal];
    btnView2.titleLabel.font=sysFont(15);
    btnView2.centerX=view.centerX;
    btnView2.backgroundColor = RGB(214, 215, 219);
    [btnView2 addTarget:self action:@selector(filledBalance) forControlEvents:UIControlEventTouchUpInside];
    if (!APayShow) {
        btnView2.enabled=YES;
    }else{
        btnView2.enabled=NO;
    }
    
    [view addSubview:btnView2];
    
    SMLabel *lbl = [[SMLabel alloc] initWithFrameWith:btnView2.bounds textColor:cBlackColor textFont:sysFont(15)];
    lbl.text = [NSString stringWithFormat:@"补齐余款:%.2f元",self.model.infoModel.total_money - self.model.infoModel.obtain_money];
    lbl.layer.cornerRadius = 20;
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.attributedText = [IHUtility changePartTextColor:lbl.text range:NSMakeRange(5, lbl.text.length - 5) value:RGB(232, 121, 117)];
    [btnView2 addSubview:lbl];
    
    if (self.model.infoModel.crowd_method == 0) {
        btnView2.hidden = YES;
        lbl.hidden = YES;
    }else if (self.model.infoModel.crowd_method == 1){
        btnView.width = (WindowWith - 0.05*3*WindowWith)/2.0;
        btnView.right = WindowWith - 0.05*WindowWith;
        
        btnView2.width = (WindowWith - 0.05*3*WindowWith)/2.0;
        btnView2.left = 0.05*WindowWith;
    }
    
    dataArray=[[NSMutableArray alloc]init];
    [dataArray addObjectsFromArray:self.model.listModels];
    
    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 0)];
    CrowdFundingTopView *CrowdFundingtopView=[[CrowdFundingTopView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 0.95*WindowWith)];
    if (![self.model.infoModel.talk isEqualToString:@""]) {
        CrowdFundingtopView.placeholderTextView.text=self.model.infoModel.talk;
        CrowdFundingtopView.placeholderTextView.placeholder=@"";
    }
    __weak CrowdFundingTopView *weakCrowdFundingtopView=CrowdFundingtopView;
    CrowdFundingtopView.selectBlock=^(NSInteger index){
        if (index==SelectSaveBlock) {
            [self addWaitingView];
            [network UpdateCrowdTalkParams:self.model.infoModel.crowd_id talk:weakCrowdFundingtopView.placeholderTextView.text success:^(NSDictionary *obj) {
                [self removeWaitingView];
                [self addSucessView:@"保存成功" type:1];
                [weakCrowdFundingtopView.placeholderTextView resignFirstResponder];
            } failure:^(NSDictionary *obj2) {
                [self addSucessView:@"保存失败" type:2];
            }];
            
            
        }else if (index==SelectheadImageBlock){
            [self addWaitingView];
            [network selectUseerInfoForId:self.model.orderInfoModel.user_id
                                  success:^(NSDictionary *obj) {
                                      MTNearUserModel *mod=[[MTNearUserModel alloc]initWithDictionary:obj[@"content"] error:nil];
                                      UserChildrenInfo *usermodel=[[UserChildrenInfo alloc]initWithModel:mod];
                                      [network selectUserCloudInfoById:[USERMODEL.userID intValue]follow_id:(int)self.model.orderInfoModel.user_id success:^(NSDictionary *obj) {
                                          [self removeWaitingView];
                                          MTOtherInfomationMainViewController *controller=[[MTOtherInfomationMainViewController alloc]initWithUserID: [NSString stringWithFormat:@"%ld",self.model.orderInfoModel.user_id] :NO dic:obj[@"content"]];
                                          controller.userMod=usermodel;
                                          controller.dic=obj[@"content"];
                                          [self pushViewController:controller];
                                      } failure:^(NSDictionary *obj2) {
                                          
                                      }];
                                      
                                  } failure:^(NSDictionary *obj2) {
                                      
                                  }];
        }
    };
    [topView addSubview:CrowdFundingtopView];
    [CrowdFundingtopView setDatawith:self.model];
    
    
    UIView *personView=[[UIView alloc]initWithFrame:CGRectMake(0, CrowdFundingtopView.bottom, WindowWith, 0.32*WindowWith)];
    personView.backgroundColor=[UIColor whiteColor];
    
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0.04*WindowWith, 0.026*WindowWith, 48, 12) textColor:cGrayLightColor textFont:sysFont(12)];
    lbl.text=@"联系电话";
    [personView addSubview:lbl];
    
    
    SMLabel *phoneLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.right+0.05*WindowWith, lbl.top, WindowWith*0.77, 12) textColor:cBlackColor textFont:sysFont(12)];
    phoneLbl.text=self.model.orderInfoModel.contacts_phone;
    if ([self.model.orderInfoModel.contacts_phone isEqualToString:@""]) {
        lbl.hidden=YES;
        phoneLbl.hidden=YES;
    }
    
    [personView addSubview:phoneLbl];
    
    
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0.04*WindowWith, 0.026*WindowWith+lbl.bottom, 48, 12) textColor:cGrayLightColor textFont:sysFont(12)];
    if (phoneLbl.hidden) {
        lbl.origin=CGPointMake(0.04*WindowWith, phoneLbl.top);
    }
    lbl.text=@"公司名称";
    [personView addSubview:lbl];
    
    
    SMLabel *company=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.right+0.05*WindowWith, lbl.top, WindowWith*0.77, 12) textColor:cBlackColor textFont:sysFont(12)];
    company.text=self.model.orderInfoModel.company_name;
    if ([self.model.orderInfoModel.company_name isEqualToString:@""]) {
        lbl.hidden=YES;
        company.hidden=YES;
    }
    
    [personView addSubview:company];
    
    
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0.04*WindowWith, 0.026*WindowWith+lbl.bottom, 48, 12) textColor:cGrayLightColor textFont:sysFont(12)];
    if (company.hidden) {
        lbl.origin=CGPointMake(0.04*WindowWith, company.top);
    }
    lbl.text=@"姓     名";
    [personView addSubview:lbl];
    
    SMLabel *nickName=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.right+0.05*WindowWith, lbl.top, WindowWith*0.77, 14) textColor:cBlackColor textFont:sysFont(12)];
    if ([self.model.orderInfoModel.contacts_people isEqualToString:@""]) {
        lbl.hidden=YES;
        nickName.hidden=YES;
    }
    nickName.text=self.model.orderInfoModel.contacts_people;
    [personView addSubview:nickName];
    
    
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0.04*WindowWith, 0.026*WindowWith+lbl.bottom, 48, 12) textColor:cGrayLightColor textFont:sysFont(12)];
    if (nickName.hidden) {
        lbl.origin=CGPointMake(0.04*WindowWith, nickName.top);
    }
    lbl.text=@"职     位";
    [personView addSubview:lbl];
    
    SMLabel *position=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.right+0.05*WindowWith, lbl.top, WindowWith*0.77, 12) textColor:cBlackColor textFont:sysFont(12)];
    position.text=self.model.orderInfoModel.job;
    if ([self.model.orderInfoModel.job isEqualToString:@""]) {
        lbl.hidden=YES;
        position.hidden=YES;
    }
    
    [personView addSubview:position];
    
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0.04*WindowWith, 0.026*WindowWith+lbl.bottom, 48, 12) textColor:cGrayLightColor textFont:sysFont(12)];
    if (position.hidden) {
        lbl.origin=CGPointMake(0.04*WindowWith, position.top);
    }
    
    lbl.text=@"名额数量";
    [personView addSubview:lbl];
    
    
    SMLabel *number=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.right+0.05*WindowWith, lbl.top, WindowWith*0.77, 12) textColor:cGreenColor textFont:sysFont(12)];
    number.text=[NSString stringWithFormat:@"%ld",self.model.orderInfoModel.order_num];
    [personView addSubview:number];
    
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0.36*WindowWith, lbl.top, 48, 12) textColor:cGrayLightColor textFont:sysFont(12)];
    lbl.text=@"总金额";
    [personView addSubview:lbl];
    
    
    SMLabel *price=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.right+0.05*WindowWith, lbl.top, WindowWith*0.418, 12) textColor:cGreenColor textFont:sysFont(12)];
    price.text=[NSString stringWithFormat:@"%@元",self.model.orderInfoModel.unit_price];
    [personView addSubview:price];
    
    personView.height=lbl.bottom+0.04*WindowWith;

    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, personView.height-1, WindowWith, 1)];
    lineView.backgroundColor=cLineColor;
    [personView addSubview:lineView];
    
    UIView *beizhuView=[[UIView alloc]initWithFrame:CGRectMake(0, CrowdFundingtopView.bottom, WindowWith, 0.1*WindowWith)];
    
    if (self.model.infoModel.status==1) {
        [topView addSubview:personView];
        beizhuView.frame=CGRectMake(0, personView.bottom, WindowWith, 0.1*WindowWith);
    }
    
    beizhuView.backgroundColor=[UIColor whiteColor];
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0.04*WindowWith, 0.026*WindowWith, WindowWith-0.08*WindowWith, 11) textColor:cGreenColor textFont:sysFont(11)];
    lbl.text=@"快来帮我付款吧";
    lbl.numberOfLines=0;
    if (self.model.infoModel.status==1) {
        lbl.text=[NSString stringWithFormat:@"备注:%@",self.model.infoModel.remark];
        lbl.textColor=cBlackColor;
    }else if (self.model.infoModel.status==2){
        if (self.model.orderInfoModel.user_id==[USERMODEL.userID integerValue]) {
            lbl.text=@"很遗憾，此次众筹目标未完成，请联系客服处理退款事宜。";
        }else{
            lbl.text=@"很遗憾，此次众筹目标未完成。";
        }
        
    }else if (self.model.infoModel.status==3){
        lbl.text=@"您此次的众筹金额已全部退还。";
    }
    
    [beizhuView  addSubview:lbl];
    
    [topView addSubview:beizhuView];
    
    topView.size=CGSizeMake(WindowWith, beizhuView.bottom);
    
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, SCREEN_HEIGHT-hh-nav_h-49) tableviewStyle:UITableViewStylePlain];
    
    if (self.model.infoModel.status == 0) {
        [self.view addSubview:view];
    }else {
        commTableView.height = WindowHeight;
    }
    //    dataArray=[[NSMutableArray alloc]init];
    
    commTableView.attribute=self;
    commTableView.table.delegate=self;
    commTableView.table.tableHeaderView=topView;
    [commTableView setupData:dataArray index:37];
    commTableView.backgroundColor = RGB(247, 248, 249);
    
    //    __weak CrowdFundingViewController *weakSelf=self;
    
    //    [self CreateBaseRefesh:commTableView type:ENT_RefreshAll successRefesh:^(MJRefreshComponent *refreshView) {
    //       // [weakSelf loadRefesh:refreshView];
    //    }];
    //[self beginRefesh:ENT_RefreshHeader];
    [self.view addSubview:commTableView];
    
    if (dataArray.count==0) {
        
        UIImage *img=Image(@"kuku.png");
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, commTableView.table.tableHeaderView.bottom+0.13*WindowWith, img.size.width, img.size.height)];
        imageView.image=img;
        imageView.centerX=self.view.centerX;
        [commTableView.table addSubview:imageView];
        
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, imageView.bottom+20, WindowWith, 13) textColor:cGrayLightColor textFont:sysFont(13)];
        lbl.centerX=imageView.centerX;
        lbl.textAlignment=NSTextAlignmentCenter;
        lbl.text=@"还没有人参与众筹";
        [commTableView.table addSubview:lbl];
    }
}

-(void)share{
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    [self shareView:ENT_Crowd object:_model vc:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CrowdListModel *model=dataArray[indexPath.row];
    
    CGSize  size=[IHUtility GetSizeByText:model.message sizeOfFont:12 width:0.728*WindowWith-0.08*WindowWith-10];
    return 15+5+12+0.0266*WindowWith+size.height+0.0266*WindowWith+10+10;
}

- (void)getOrderData
{
    [self addPushViewWaitingView];
    [network selectCrowdDetailByCrowdId:[self.crowdID intValue] openid:@"" success:^(NSDictionary *obj) {
        [self removePushViewWaitingView];
        self.model= obj[@"content"];
        [self creatTableView];
        
    } failure:^(NSDictionary *obj2) {
        
        [self removePushViewWaitingView];
        XHFriendlyLoadingView *v=(XHFriendlyLoadingView*)[self.view viewWithTag:8172];
        [v showReloadViewWithText:reloadText];
        
    }];
}
//补齐余款
- (void)filledBalance
{
    ApliayView *alipayView = [[ApliayView alloc] initWithFrame:self.view.window.bounds];
    alipayView.top = kScreenHeight;
    APayShow=YES;
    alipayView.selectBlock = ^(NSInteger index){
        if (index == ENT_top) {
            //锁定众筹
            self->type = @"1";
            [self lockCrowd];
            self->payChanle = PayChannelWxApp;
            self.payType = [NSString stringWithFormat:@"%d",WEICHAT_TYPE];
        }else if (index == ENT_midden){
            //锁定众筹
            self->type = @"1";
            [self lockCrowd];
            self.payType = [NSString stringWithFormat:@"%d",AlIPAY_TYPE];
            self->payChanle = PayChannelAliApp;
        }
    };
    
    [self.view.window addSubview:alipayView];
    
    [UIView animateWithDuration:.5 animations:^{
        alipayView.top = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.3 animations:^{
            alipayView.backgroundColor = RGBA(0, 0, 0, 0.3);
            self->APayShow=NO;
        }];
    }];
}

- (void)referAlipay
{
    
    NSString *subTitle = self.model.infoModel.activities_titile .length > 16 ? [self.model.infoModel.activities_titile substringToIndex:15]:self.model.infoModel.activities_titile;
    NSString *price = [NSString stringWithFormat:@"%.f",((self.model.infoModel.total_money - self.model.infoModel.obtain_money)*100)];

    NSString *crowdID  = [NSString stringWithFormat:@"%ld",self.model.infoModel.crowd_id];
    [[PayMentMangers manager] payment:self.model.orderInfoModel.order_no orderPrice:price type:self.payType subject:subTitle crowID:crowdID activitieID:self.model.selectActivitiesListInfo.activities_id parentVC:self resultBlock:^(BOOL isPaySuccess, NSString *msg) {
        if (isPaySuccess) {
            
        }
    }];

/*      //微信走bCloud
    if ([self.payType isEqualToString:[NSString stringWithFormat:@"%d",WEICHAT_TYPE]]) {
        // NSString *billno = [IHUtility genBillNo];
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:crowdID,@"crowdId", nil];
        BCPayReq *payReq = [[BCPayReq alloc] init];
        payReq.channel = payChanle; //支付渠道 //PayChannelAliApp   ,PayChannelWxApp
        NSString *subTitle = self.model.infoModel.activities_titile .length > 16 ? [self.model.infoModel.activities_titile substringToIndex:15]:self.model.infoModel.activities_titile;
        payReq.title = subTitle;
        payReq.totalFee =[NSString stringWithFormat:@"%d",(int)((self.model.infoModel.total_money - self.model.infoModel.obtain_money)*100)];//订单价格
        payReq.billNo = self.model.orderInfoModel.order_no;//商户自定义订单号
        payReq.scheme = @"payDemo";//URL Scheme,在Info.plist中配置; 支付宝必有参数
        payReq.billTimeOut = 300;//订单超时时间
        payReq.viewController = self; //银联支付和Sandbox环境必填
        payReq.optional = dict;//商户业务扩展参数，会在webhook回调时返回
        [BeeCloud sendBCReq:payReq];
    }
    if ([self.payType isEqualToString:[NSString stringWithFormat:@"%d",AlIPAY_TYPE]]) {
        //支付宝、微信
        if (self.payBlock) {
            self.payBlock(price, self.model.orderInfoModel.order_no,self.payType,subTitle,crowdID,self);
        }
    }
*/
}


- (void)showAlertView:(NSString *)msg {
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}
#pragma mark - BCPay回调

- (void)onBeeCloudResp:(BCBaseResp *)resp {
    
    type = @"0";
    [self lockCrowd];
    
    switch (resp.type) {
        case BCObjsTypePayResp:
        {
            // 支付请求响应
            BCPayResp *tempResp = (BCPayResp *)resp;
            if (tempResp.resultCode == 0) {
                
                //百度钱包比较特殊需要用户用获取到的orderInfo，调用百度钱包SDK发起支付
                //微信、支付宝、银联支付成功
                //  [self showAlertView:resp.resultMsg];
                
                NSLog(@"支付成功");
                [self.view removeAllSubviews];
                [self getOrderData];
                
                if (self.indexPath) {
                    [self.delgate crowdSuccessIndexPath:self.indexPath];
                }
            } else {
                //支付取消或者支付失败
                [self showAlertView:[NSString stringWithFormat:@"%@ : %@",tempResp.resultMsg, tempResp.errDetail]];
            }
        }
            break;
        case BCObjsTypeQueryBillsResp:
        {
            BCQueryBillsResp *tempResp = (BCQueryBillsResp *)resp;
            if (resp.resultCode == 0) {
                if (tempResp.count == 0) {
                    [self showAlertView:@"未找到相关订单信息"];
                } else {
                    self.orderList = tempResp;
                    [self performSegueWithIdentifier:@"queryResult" sender:self];
                }
            } else {
                [self showAlertView:[NSString stringWithFormat:@"%@ : %@",tempResp.resultMsg, tempResp.errDetail]];
            }
        }
            break;
        case BCObjsTypeQueryRefundsResp:
        {
            BCQueryRefundsResp *tempResp = (BCQueryRefundsResp *)resp;
            if (resp.resultCode == 0) {
                if (tempResp.count == 0) {
                    [self showAlertView:@"未找到相关订单信息"];
                } else {
                    self.orderList = tempResp;
                    [self performSegueWithIdentifier:@"queryResult" sender:self];
                }
            } else {
                [self showAlertView:[NSString stringWithFormat:@"%@ : %@",tempResp.resultMsg, tempResp.errDetail]];
            }
        }
            break;
            
        default:
        {
            if (resp.resultCode == 0) {
                [self showAlertView:resp.resultMsg];
            } else {
                [self showAlertView:[NSString stringWithFormat:@"%@ : %@",resp.resultMsg, resp.errDetail]];
            }
        }
            break;
    }
}
- (void)lockCrowd
{
    [network getlockCrowd:type crowd_id:[NSString stringWithFormat:@"%ld",self.model.infoModel.crowd_id] success:^(NSDictionary *obj) {
        
        if ([self->type isEqualToString:@"1"]) {
            [self referAlipay];
        }
        
    }failure:^(NSDictionary *obj2) {
        
        [self addSucessView:@"系统繁忙，请稍后再试!" type:2];
    }];
}

- (void)back:(id)sender
{
    if ([self.Type isEqualToString:@"2"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self popViewController:2];
    }
}

@end
