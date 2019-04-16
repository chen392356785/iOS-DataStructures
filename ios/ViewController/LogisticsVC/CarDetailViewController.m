//
//  CarDetailViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 17/1/2.
//  Copyright © 2017年 xubin. All rights reserved.
//

#import "CarDetailViewController.h"
//#import "CustomView+CustomCategory4.h"
#import "CarOwnerInformationViewController.h"
#import "ChatViewController.h"
@interface CarDetailViewController ()<ChatViewControllerDelegate>
{
    NSDictionary *_dic;
//    FindCarModel *_model;
}
@end

@implementation CarDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"车源详情"];
    
    [self addPushViewWaitingView];
    [network selectFlowCarRouteById:[self.Id intValue] success:^(NSDictionary *obj) {
        NSDictionary *dic=obj[@"content"];
        [self removePushViewWaitingView];
		self->_dic=dic;
       
        [self setUI:dic];
        
        
    } failure:^(NSDictionary *obj2) {
        
    }];
    
    
    
    
    
    
}
-(void)setUI:(NSDictionary *)dic{
    
    
    
    CarDetailTopView *carDetailTopView=[[CarDetailTopView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 70) imageUrl:dic[@"heed_image_url"] name:dic[@"user_name"] address:[NSString stringWithFormat:@"%@%@",dic[@"province"],dic[@"city"]]];
    [_BaseScrollView addSubview:carDetailTopView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushToCarOwnerVC)];
    [carDetailTopView addGestureRecognizer:tap];
    
    //路线
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, carDetailTopView.bottom, WindowWith, 24)];
    view1.backgroundColor=cBgColor;
    [_BaseScrollView addSubview:view1];
    
    
    
    
    SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(12, 0, 30, view1.height) textColor:cGrayLightColor textFont:sysFont(12)];
    lbl.text=@"路线";
    [view1 addSubview:lbl];
    
    //地址
    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(0, view1.bottom, WindowWith, 96)];
    view2.backgroundColor=[UIColor whiteColor];
    [_BaseScrollView addSubview:view2];
    
    UIView *dianView1=[[UIView alloc]initWithFrame:CGRectMake(23, 21, 8, 8)];
    dianView1.backgroundColor=cGreenColor;
    [dianView1 setLayerMasksCornerRadius:4 BorderWidth:0 borderColor:cGreenColor];
    [view2 addSubview:dianView1];
    
    
    CGSize size=[IHUtility GetSizeByText:[NSString stringWithFormat:@"%@-%@-%@",dic[@"f_province"],dic[@"f_city"],dic[@"f_area"]] sizeOfFont:15 width:WindowWith-dianView1.right-5-12];
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(dianView1.right+5, 0, size.width, 17) textColor:cBlackColor textFont:sysFont(15)];
    lbl.centerY=dianView1.centerY;
    NSArray *arr=@[dic[@"f_province"],dic[@"f_city"],dic[@"f_area"]];
    NSMutableString *str=[[NSMutableString alloc]init];
    for (NSInteger i=0; i<arr.count; i++) {
        if (i==0) {
            [str appendString:arr[i]];
        }else{
            if (![arr[i] isEqualToString:@""]) {
                [str appendFormat:@"-%@",arr[i]];
            }
        }
    }
    lbl.text=str;
    [view2 addSubview:lbl];
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(dianView1.left+3.5, dianView1.bottom+2, 1, 30)];
    lineView.backgroundColor=cLineColor;
    [view2 addSubview:lineView];
    
    UIView *dianView2=[[UIView alloc]initWithFrame:CGRectMake(dianView1.left, lineView.bottom+2, 8, 8)];
    dianView2.backgroundColor=RGB(232, 121, 117);
    [dianView2 setLayerMasksCornerRadius:4 BorderWidth:0 borderColor:cGreenColor];
    [view2 addSubview:dianView2];
    
    
    size=[IHUtility GetSizeByText:[NSString stringWithFormat:@"%@-%@-%@",dic[@"t_province"],dic[@"t_city"],dic[@"t_area"]] sizeOfFont:15 width:WindowWith-dianView2.right-5-12];
    
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(dianView2.right+5, 0, size.width, 17) textColor:cBlackColor textFont:sysFont(15)];
    lbl.centerY=dianView2.centerY;
    
    arr=@[dic[@"t_province"],dic[@"t_city"],dic[@"t_area"]];
    str=[[NSMutableString alloc]init];
    for (NSInteger i=0; i<arr.count; i++) {
        if (i==0) {
            [str appendString:arr[i]];
        }else{
            if (![arr[i] isEqualToString:@""]) {
                [str appendFormat:@"-%@",arr[i]];
            }
        }
    }
    lbl.text=str;

    [view2 addSubview:lbl];
    
    
    
    //车辆信息
    UIView *view3=[[UIView alloc]initWithFrame:CGRectMake(0, view2.bottom, WindowWith, 24)];
    view3.backgroundColor=cBgColor;
    [_BaseScrollView addSubview:view3];
    
   

    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(12, 0, 60, view3.height) textColor:cGrayLightColor textFont:sysFont(12)];
    lbl.text=@"车辆信息";
    [view3 addSubview:lbl];
    
    
    //地址
    UIView *view4=[[UIView alloc]initWithFrame:CGRectMake(0, view3.bottom, WindowWith, 100)];
    view4.backgroundColor=[UIColor whiteColor];
    [_BaseScrollView addSubview:view4];
    
    
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(12, 20, 54, 15) textColor:cGrayLightColor textFont:sysFont(13)];
    lbl.text=@"车牌号码";
    [view4 addSubview:lbl];
    
     size=[IHUtility GetSizeByText:dic[@"car_num"] sizeOfFont:15 width:WindowWith-lbl.right-12-12];
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.right+10, lbl.top, size.width, 17) textColor:cGreenColor textFont:sysFont(15)];
    lbl.text=dic[@"car_num"];
    [view4 addSubview:lbl];
    
    
    
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(12, lbl.bottom+30, 54, 15) textColor:cGrayLightColor textFont:sysFont(13)];
    lbl.text=@"车辆规格";
    [view4 addSubview:lbl];
    
    size=[IHUtility GetSizeByText:[NSString stringWithFormat:@"%@   %@米   %@吨",dic[@"car_num"],dic[@"car_num"],dic[@"loads"] ] sizeOfFont:15 width:WindowWith-lbl.right-12-12];
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.right+10, lbl.top, WindowWith-lbl.right-20, 17) textColor:cGreenColor textFont:sysFont(15)];
    lbl.text=[NSString stringWithFormat:@"%@   %@米   %@吨",dic[@"carType_name"],dic[@"car_height"],dic[@"loads"] ];
    [view4 addSubview:lbl];
    
    
    
    if (![dic[@"remark"] isEqualToString:@""]) {
       
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(12, lbl.bottom+30, 54, 15) textColor:cGrayLightColor textFont:sysFont(13)];
        lbl.text=@"备      注";
        [view4 addSubview:lbl];
         size=[IHUtility GetSizeByText:dic[@"remark"] sizeOfFont:14 width: WindowWith-lbl.right-22];
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.right+10, lbl.top, size.width, size.height) textColor:cGrayLightColor textFont:sysFont(14)];
        lbl.text=dic[@"remark"];
        lbl.numberOfLines=0;
        [view4 addSubview:lbl];
        
        view4.height=lbl.bottom+15;

    }
    
    
    _BaseScrollView.contentSize=CGSizeMake(WindowWith, view4.bottom+48);
    
    
   
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(12, WindowHeight-48, 0.336*WindowWith, 36);
     UIImage *img=Image(@"logistics_hi.png");
    [btn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    [btn setTitle:@"打招呼" forState:UIControlStateNormal];
    [btn setTitleColor:RGB(132, 131, 136) forState:UIControlStateNormal];
    btn.titleLabel.font=sysFont(15);
    btn.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
    btn.backgroundColor=RGB(221, 221, 223);
    [btn addTarget:self action:@selector(pushToChatVC) forControlEvents:UIControlEventTouchUpInside];
    [btn setLayerMasksCornerRadius:18 BorderWidth:0 borderColor:cGreenColor];
    [self.view addSubview:btn];
    
    
    UIButton *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame=CGRectMake(btn.right+17, WindowHeight-48, WindowWith-btn.right-17-12, 36);
    btn2.backgroundColor=cGreenColor;
    img=Image(@"logistics_phone.png");
     btn2.titleLabel.font=sysFont(15);
    
    [btn2 setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    [btn2 setTitle:@"电话联系" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2 setLayerMasksCornerRadius:18 BorderWidth:0 borderColor:cGreenColor];
     btn2.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
    [btn2 addTarget:self action:@selector(getPhoneweak) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];

    
}

-(void)pushToChatVC{
    
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
 
    ChatViewController *vc=[[ChatViewController alloc]initWithChatter:_dic[@"hx_user_name"] conversationType:eConversationTypeChat];
    vc.nickName=_dic[@"user_name"];
    vc.delelgate=self;
    vc.toUserID=[NSString stringWithFormat:@"%ld",(long)_dic[@"user_id"]];
    vc.HeadimgUrl=[NSString stringWithFormat:@"%@%@%@",ConfigManager.ImageUrl,_dic[@"heed_image_url"],smallHeaderImage];
    
    [self pushViewController:vc];
    
}

-(void)getPhoneweak{
    
    
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    
    if (![_dic[@"mobile"] isEqualToString:@""]) {
        NSString *phoneString = [NSString stringWithFormat:@"tel:%@",_dic[@"mobile"]];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:phoneString]]];
        [self.view addSubview:callWebview];
    }else
    {
        [IHUtility addSucessView:@"对方没有留下电话" type:1];
    }
    
}



-(void)pushToCarOwnerVC{
    CarOwnerInformationViewController *vc=[[CarOwnerInformationViewController alloc]init];
    vc.dic=_dic;
    [self pushViewController:vc];
    
    
}

#pragma mark - ChatViewControllerDelegate

// 根据环信id得到要显示头像路径，如果返回nil，则显示默认头像
- (NSString *)avatarWithChatter:(NSString *)chatter{
    NSString *str=[NSString stringWithFormat:@"%@%@%@",ConfigManager.ImageUrl,_dic[@"heed_image_url"],smallHeaderImage];
    NSString *userID=[_dic[@"hx_user_name"] lowercaseString];
    
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
