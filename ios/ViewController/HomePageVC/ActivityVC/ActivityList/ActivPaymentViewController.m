//
//  PaymentViewController.m
//  MiaoTuProject
//
//  Created by Zmh on 5/5/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "ActivPaymentViewController.h"
//#import "ACtivityTopView.h"
#import "ActvRegInfoView.h"
#import "AlipayWayView.h"
#import "BCPayReq.h"
#import "BeeCloud.h"
#import "ActivityPaySuccessfulViewController.h"
#import "orderStateView.h"
//#import "ActivityDetailViewController.h"
#import "ActivtiesVoteViewController.h"
//#import "NSObject+GetIP.h"
#import "PayTypeConstants.h"

#import "ActivesCrowdFundController.h"

@interface ActivPaymentViewController ()<BeeCloudDelegate>
{
    UIView *_alipayView;
    UIButton *_selButton;
    int payChanle;
}
@end

@implementation ActivPaymentViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [BeeCloud setBeeCloudDelegate:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"确认订单";
    self.payType = [NSString stringWithFormat:@"%d",WEICHAT_TYPE];
    
    _BaseScrollView.backgroundColor = RGB(228, 235, 235);
    orderStateView *orderView = [[orderStateView alloc] initWithFrame:CGRectMake(0, 3, kScreenWidth, 100)];
    [orderView setActivtiesData:self.model];
    [_BaseScrollView addSubview:orderView];
    
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(comeActivtDetail:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired= 1;
    [orderView addGestureRecognizer:tap];

    //订单信息
    ActvRegInfoView *infoView = [[ActvRegInfoView alloc] initWithFrame:CGRectMake(0, orderView.bottom + 6, kScreenWidth, 121)];
    [infoView setdata:self.model.contacts_people phone:self.model.contacts_phone company:self.model.company_name jobStr:self.model.job];
    [_BaseScrollView addSubview:infoView];
    
    NSArray *imageNames = @[@"alipay_weixing.png",@"alipay_zhifubaozhifu.png"];
    NSArray *nameArr = @[@"微信支付",@"支付宝支付"];
    
    _alipayView = [[UIView alloc] initWithFrame:CGRectMake(0, infoView.bottom + 6, kScreenWidth, 140)];
    _alipayView.backgroundColor = [UIColor whiteColor];
    
    UIImage *image = Image(@"iconfont-zhifufangshi.png");
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 10, image.size.width, image.size.height)];
    imageView.image = image;
    [_alipayView addSubview:imageView];
    
    SMLabel *lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(imageView.right + 5, 10, 56, 20) textColor:cBlackColor textFont:sysFont(14)];
    lbl.text = @"支付方式";
    [_alipayView addSubview:lbl];
    
    //创建支付方式
    for (int i=0; i<nameArr.count; i++) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, lbl.bottom + 8 + 50.5*i, WindowWith - 30, 0.5)];
        lineView.backgroundColor = RGB(239, 239, 239);
        [_alipayView addSubview:lineView];
        
        AlipayWayView *alipayWayView = [[AlipayWayView alloc] initWithFrame:CGRectMake(0, lineView.bottom, kScreenWidth, 50)];
        alipayWayView.userInteractionEnabled=YES;
        alipayWayView.backgroundColor = [UIColor whiteColor];
        [alipayWayView.selectedBtu addTarget:self action:@selector(selectedAlipayWay:) forControlEvents:UIControlEventTouchUpInside];
        alipayWayView.selectedBtu.tag = i + 10;
        if (alipayWayView.selectedBtu.tag == 10) {
            alipayWayView.selectedBtu.selected = YES;
            _selButton=alipayWayView.selectedBtu;
        }
        [alipayWayView setDataImage:imageNames[i] name:nameArr[i]];
        [_alipayView addSubview:alipayWayView];
        
        IHTapGesureRecornizer *tap=[[IHTapGesureRecornizer alloc]initWithTarget:self action:@selector(selectedPayType:)];
        tap.objectTag=100+i;
        [alipayWayView addGestureRecognizer:tap];
        
    }
    [_BaseScrollView addSubview:_alipayView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(33, _alipayView.bottom + 8, 159, 14)];
    label.text = @"注：报名支付暂不支持退款服务哦";
    label.backgroundColor = [UIColor clearColor];
    label.textColor = RGB(108, 123, 138);
    label.font = sysFont(10);
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
    [str addAttribute:NSForegroundColorAttributeName value:RGB(232, 121, 117)range:NSMakeRange(0, 1)];
    label.attributedText = str;
    [_BaseScrollView addSubview:label];

    CGFloat hh =  kBottomNoSapce;
    CGFloat nav_h = kNavigationHeight;
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0,SCREEN_HEIGHT-hh-nav_h-45, WindowWith, 45)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    UIButton *referAlipayBtu = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 45)];
    referAlipayBtu.right = WindowWith;
    referAlipayBtu.backgroundColor = RGB(232, 121, 117);
    [referAlipayBtu setTitle:@"确认" forState:UIControlStateNormal];
    [referAlipayBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [referAlipayBtu addTarget:self action:@selector(referAlipay:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:referAlipayBtu];
    
    SMLabel *lbl2 = [[SMLabel alloc] initWithFrameWith:CGRectMake(0, 0, 35, 20) textColor:cBlackColor textFont:sysFont(14)];
    lbl2.text = @"合计:";
    lbl2.right = WindowWith/2.0;
    lbl2.centerY = bottomView.height/2.0;
    [bottomView addSubview:lbl2];
    
    SMLabel *lbl3 = [[SMLabel alloc] initWithFrameWith:CGRectMake(lbl2.right, 0, referAlipayBtu.left - lbl2.right, 20) textColor:RGB(232, 121, 117) textFont:sysFont(14)];
    lbl3.text = [NSString stringWithFormat:@"¥%.2f",[self.model.payment_amount floatValue]/100];
    lbl3.centerY = bottomView.height/2.0;
    [bottomView addSubview:lbl3];
    
    _BaseScrollView.contentSize = CGSizeMake(kScreenWidth, label.bottom + 100);
    if ([self.type isEqualToString:@"1"]) {
        _alipayView.hidden = YES;
        label.hidden = YES;
        referAlipayBtu.hidden = YES;
        _BaseScrollView.contentSize = CGSizeMake(kScreenWidth, infoView.bottom + 85);
    }
    
    payChanle=PayChannelWxApp;

}
//点击顶部订单信息进入活动详情
- (void)comeActivtDetail:(UITapGestureRecognizer *)tap
{
        [network getActivitiesDetail:self.model.activities_id type:self.model.model success:^(NSDictionary *obj) {
            ActivitiesListModel *detailModel = obj[@"content"];
            if ([detailModel.model isEqualToString:@"7"])
            {
                
                ActivtiesVoteViewController *vc = [[ActivtiesVoteViewController alloc] init];
                vc.model = detailModel;
                vc.indexPath = self.indexPath;
                [self pushViewController:vc];
            }else{
                ActivesCrowdFundController *vc=[[ActivesCrowdFundController alloc]init];
                vc.model = detailModel;
                vc.indexPath = self.indexPath;
                vc.type = @"1";
                [self pushViewController:vc];
            }
        } failure:^(NSDictionary *obj2) {
        }];
}

//选择支付方式
-(void)selectedPayType:(IHTapGesureRecornizer *)tap{
    UIButton *WXBtu = [_alipayView viewWithTag:10];
    UIButton *ZFBBtu = [_alipayView viewWithTag:11];
    if (tap.objectTag==100) {
        [self selectedAlipayWay:WXBtu];
    }else if (tap.objectTag==101){
         [self selectedAlipayWay:ZFBBtu];
    }
}
    

-(void)back:(id)sender{
    [self popViewController:1];
}

- (void)selectedAlipayWay:(UIButton *)button
{
    if (button == _selButton) {
        return;
    }
    UIButton *WXBtu = [_alipayView viewWithTag:10];
    UIButton *ZFBBtu = [_alipayView viewWithTag:11];
    
    button.selected = !button.selected;
    if (button.tag == 10&&button.selected == YES) {
        if (ZFBBtu.selected) {
            ZFBBtu.selected = NO;
        }
         payChanle=PayChannelWxApp;
        self.payType = [NSString stringWithFormat:@"%d",WEICHAT_TYPE];
    }else if (button.tag == 11&&button.selected == YES){
        if (WXBtu.selected) {
            WXBtu.selected = NO;
        }
        payChanle=PayChannelAliApp;
        self.payType = [NSString stringWithFormat:@"%d",AlIPAY_TYPE];
    }
    _selButton=button;
    
}
- (void)referAlipay:(UIButton *)button
{
    //微信走bCloud
    if ([self.payType isEqualToString:[NSString stringWithFormat:@"%d",WEICHAT_TYPE]]) {
        if (self.payBlock) {
            self.payBlock(self.model.payment_amount, self.model.order_no,self.payType,self.model.activities_titile,self);
        }
    }else{
        //支付宝、微信
        if (self.payBlock) {
            self.payBlock(self.model.payment_amount, self.model.order_no,self.payType,self.model.activities_titile,self);
        }
    }
    
}
# pragma mark - 使用BeeCloud
- (void) makeWithBeeCloudPlay {
    //微信走bCloud
    if ([self.payType isEqualToString:[NSString stringWithFormat:@"%d",WEICHAT_TYPE]]) {
        //beCloud 支付
        //    NSString *billno = [IHUtility genBillNo];
        //        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"value",@"key", nil];
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"value",@"key", nil];
        /**
         按住键盘上的option键，点击参数名称，可以查看参数说明
         **/
        BCPayReq *payReq = [[BCPayReq alloc] init];
        payReq.channel = payChanle; //支付渠道 //PayChannelAliApp   ,PayChannelWxApp
        if (self.model.activities_titile.length > 16) {
            payReq.title = [self.model.activities_titile substringToIndex:15];
        }else{
            payReq.title = self.model.activities_titile;//订单标题
        }
        payReq.totalFee =self.model.payment_amount;//订单价格
        payReq.billNo = self.model.order_no;//商户自定义订单号
        payReq.scheme = @"MiaoToProject";//URL Scheme,在Info.plist中配置; 支付宝必有参数
        payReq.billTimeOut = 300;//订单超时时间
        payReq.viewController = self; //银联支付和Sandbox环境必填
        payReq.optional = dict;//商户业务扩展参数，会在webhook回调时返回
        [BeeCloud sendBCReq:payReq];
    }
}

- (void)showAlertView:(NSString *)msg {
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}
#pragma mark - BCPay回调

- (void)onBeeCloudResp:(BCBaseResp *)resp {
    
    switch (resp.type) {
        case BCObjsTypePayResp:
        {
            // 支付请求响应
            BCPayResp *tempResp = (BCPayResp *)resp;
            if (tempResp.resultCode == 0) {
                
                //百度钱包比较特殊需要用户用获取到的orderInfo，调用百度钱包SDK发起支付
                //微信、支付宝、银联支付成功
              //  [self showAlertView:resp.resultMsg];
                ActivityPaySuccessfulViewController *vc=[[ActivityPaySuccessfulViewController alloc]init];
                vc.indexPath = self.indexPath;
                vc.model = self.model;
                [self pushViewController:vc];
                 [[NSNotificationCenter defaultCenter]postNotificationName:@"paySuccess" object:self.indexPath];
                
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
