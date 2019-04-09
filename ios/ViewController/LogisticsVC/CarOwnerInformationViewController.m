//
//  CarOwnerInformationViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 17/1/4.
//  Copyright © 2017年 xubin. All rights reserved.
//

#import "CarOwnerInformationViewController.h"
#import "SlideNavTabBarController.h"
#import "CarOwnerChildrenViewController.h"
#import "ChatViewController.h"
@interface CarOwnerInformationViewController ()<ChatViewControllerDelegate>
{
    SlideNavTabBarController *navTabBarController;
}

@end

@implementation CarOwnerInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"车主资料"];
    
    CarDetailTopView *carDetailTopView=[[CarDetailTopView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 70) imageUrl:_dic[@"heed_image_url"] name:_dic[@"user_name"] address:[NSString stringWithFormat:@"%@%@",_dic[@"province"],_dic[@"city"]]];
    [self.view addSubview:carDetailTopView];
    
    
    NSArray *arr=@[@"他的车源",@"他的认证"];
    NSArray *imgArr=@[@"driver_huoche.png",@"driver_renzheng.png"];
    NSArray *selectImgArr=@[@"driver_huocheSelect.png",@"driver_renzhengSelect"];
    NSMutableArray* controllerArray =[[NSMutableArray alloc]init];
    for (int i=0; i<arr.count; i++) {
        
        CarOwnerChildrenViewController *controller=[[CarOwnerChildrenViewController alloc]init];
        
        switch (i) {
            case 0:
                controller.type=ENT_cheyuan;
//                controller.order=0;
                
                break;
            case 1:
               controller.type=ENT_renzheng;
                controller.dic=self.dic;
//                controller.order=2;
                
                break;
            default:
//                controller.type=ENT_new;
//                controller.order=1;
                
                break;
        }
        controller.inviteParentController=self.inviteParentController;
        [controllerArray addObject:controller];
    }
    navTabBarController = [[SlideNavTabBarController alloc] init];
    navTabBarController.navH=70;
    navTabBarController.imgArray=imgArr;
    navTabBarController.selectImgArray=selectImgArr;
    navTabBarController.subViewControllers = controllerArray;
    navTabBarController.isShowline=YES;
    navTabBarController.isShowNavSlide=YES;
    navTabBarController.titleArray=arr;
    //  navTabBarController.navBarDelegate=self;
    // Do any additional setup after loading the view.
    [self.view addSubview:navTabBarController.view];

    
    
//    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame=CGRectMake(12, WindowHeight-48, 0.336*WindowWith, 36);
//    UIImage *img=Image(@"logistics_hi.png");
//    [btn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
//    [btn setTitle:@"打招呼" forState:UIControlStateNormal];
//    [btn setTitleColor:RGB(132, 131, 136) forState:UIControlStateNormal];
//    btn.titleLabel.font=sysFont(15);
//    btn.backgroundColor=RGB(221, 221, 223);
//    [btn addTarget:self action:@selector(pushToChatVC) forControlEvents:UIControlEventTouchUpInside];
//    [btn setLayerMasksCornerRadius:18 BorderWidth:0 borderColor:cGreenColor];
//    [self.view addSubview:btn];
//    
//    
//    UIButton *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
//    btn2.frame=CGRectMake(btn.right+17, WindowHeight-48, WindowWith-btn.right-17-12, 36);
//    btn2.backgroundColor=cGreenColor;
//    img=Image(@"logistics_phone.png");
//    btn2.titleLabel.font=sysFont(15);
//    [btn2 setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
//    [btn2 setTitle:@"电话联系" forState:UIControlStateNormal];
//    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [btn2 setLayerMasksCornerRadius:18 BorderWidth:0 borderColor:cGreenColor];
//    [btn2 addTarget:self action:@selector(getPhoneweak) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn2];


    
    
    
}


//-(void)pushToChatVC{
//
//    if (!USERMODEL.isLogin) {
//        [self prsentToLoginViewController];
//        return ;
//    }
//
//    ChatViewController *vc=[[ChatViewController alloc]initWithChatter:_dic[@"hx_user_name"] conversationType:eConversationTypeChat];
//    vc.nickName=_dic[@"user_name"];
//    vc.delelgate=self;
//    vc.toUserID=[NSString stringWithFormat:@"%ld",(long)_dic[@"user_id"]];
//    vc.HeadimgUrl=[NSString stringWithFormat:@"%@%@%@",ConfigManager.ImageUrl,_dic[@"heed_image_url"],smallHeaderImage];
//
//    [self pushViewController:vc];
//
//}

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
