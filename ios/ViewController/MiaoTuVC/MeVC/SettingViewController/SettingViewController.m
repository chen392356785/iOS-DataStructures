//
//  SettingViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/4/1.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SettingViewController.h"
#import "IdeaFeedBackViewController.h"
#import "AboutUsViewController.h"
#import "InformationEditViewController.h"
#import "EditPersonInformationViewController.h"
//#import "BindenterpriseViewController.h"
#import "ZhuCeViewController.h"
#import <StoreKit/StoreKit.h>
//#import "JobIdentViewController.h"
#import <WebKit/WebKit.h>

#ifdef APP_MiaoTu

#define kAppId @"1080191917"
#elif defined APP_YiLiang
#define kAppId @"1178834496"

#endif



@interface SettingViewController ()<UITableViewDelegate,SKStoreProductViewControllerDelegate>
{
//    UIView *_headView;
    MTBaseTableView *commTableView;
}
@end

@implementation SettingViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //  self.navigationController.navigationBar.hidden=YES;
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"个人设置"];
   
    [self creatTableView];
      
    
}

-(void)creatTableView{
    
    
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight) tableviewStyle:UITableViewStylePlain];
    
    commTableView.attribute=self;
    commTableView.table.delegate=self;
     [self.view addSubview:commTableView];
     NSArray * ListArr = [ConfigManager getSettingView];
    [commTableView setupData:ListArr index:16];
    
    //切换身份之后的回调
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeUserIdent:) name:NotificationUserIdentity object:nil];
    
}


-(void)leaveLogin
{
    [IHUtility AlertMessage:@"确定退出登录？" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消" tag:2016];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(buttonIndex==0){
        
        [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
            if (!error && info) {
                NSLog(@"退出成功");
            }
        } onQueue:nil];
        [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES];
          [self back:nil];
        [self addSucessView:@"退出成功!" type:1];
        [self performSelector:@selector(notifyLoginOut) withObject:self afterDelay:0.5];
        
    
    }
    
}

- (void)loadAppStoreController

{
    
   
    // 初始化控制器
    
    SKStoreProductViewController *storeProductViewContorller = [[SKStoreProductViewController alloc] init];
    
    // 设置代理请求为当前控制器本身
    [self addWaitingView];
    storeProductViewContorller.delegate = self;
    [storeProductViewContorller loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier:kAppId}  completionBlock:^(BOOL result, NSError *error)   {
        [self removeWaitingView];
        if(error)
        {
            NSLog(@"error %@ with userInfo %@",error,[error userInfo]);
        }  else
        {
            // 模态弹出appstore
            [self presentViewController:storeProductViewContorller animated:YES completion:^{
                
            }];
        }
    }];
    
}

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController

{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];  
    
}


-(void)notifyLoginOut{
   
    [USERMODEL removeUserModel];
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationChangeTabBarSelectedIndex object:[NSNumber numberWithInt:0]];

}
//意见反馈
-(void)pushToIdeaFeedBack
{  if (!USERMODEL.isLogin) {
    [self prsentToLoginViewController];
    return ;
}

    IdeaFeedBackViewController *vc=[[IdeaFeedBackViewController alloc]init];
    [self pushViewController:vc];
}

//关于我们
-(void)pushToAboutUs
{
    AboutUsViewController *vc=[[AboutUsViewController alloc]init];
    [self pushViewController:vc];
}

-(void)RemoveImageCache
{
 
    
    SDImageCache * imageCache = [SDImageCache sharedImageCache];
    [imageCache clearMemory];
    [imageCache clearDiskOnCompletion:^{
        
    }];
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *file = [path stringByAppendingPathComponent:@"ClassRoomList.data"];
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager removeItemAtPath:file error:nil];
    
    NSString *file2 = [path stringByAppendingPathComponent:@"ClassHomeList.data"];
    [manager removeItemAtPath:file2 error:nil];
    
    NSUserDefaults *userDefaluts=[NSUserDefaults standardUserDefaults];
    [userDefaluts removeObjectForKey:KGardenHomeDataDic];           //园榜首页
    [userDefaluts removeObjectForKey:KGardenSearchDataDic];         //园榜搜索
    [userDefaluts synchronize];
    
    //清除wevView 缓存
    NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        
    }];
    
    [self addSucessView:@"缓存清理成功！" type:1] ;
   
	CGFloat cachesize = [SDImageCache sharedImageCache].totalDiskSize/(1024 * 1024);
    NSString *text = [NSString stringWithFormat:@"占用：%.2f MB",cachesize];
    
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:2 inSection:0];
    MTMeListTableViewCell *cell=(MTMeListTableViewCell *)[commTableView.table cellForRowAtIndexPath:indexPath];
    
    SMLabel *lbl=[cell viewWithTag:101];
    lbl.frame=CGRectMake(0.355*WindowWith, 23, 0.92*WindowWith-0.355*WindowWith-10 ,14);
    lbl.textAlignment=NSTextAlignmentRight;
    lbl.textColor=[UIColor redColor];
    lbl.text=text;
    lbl.hidden=NO;

    
    
    
    
}
// 切换身份
- (void)changeUserIdent:(NSNotification *)notification{
    
    [commTableView.table reloadData];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 65;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
//    if (indexPath.row==0) {
//        
//        EditPersonInformationViewController *editVC=[[EditPersonInformationViewController alloc]init];
//        
//        [self pushViewController:editVC];
//
//        
//        
//    }
    if (indexPath.row==0){
        EditPersonInformationViewController *editVC=[[EditPersonInformationViewController alloc]init];
        [self pushViewController:editVC];
    }
    if (indexPath.row==1) {
      
        ZhuCeViewController *vc=[[ZhuCeViewController alloc]init];
        vc.type=ENT_forget;
        [self pushViewController:vc];
        
    }
    if (indexPath.row==2) {
        [self RemoveImageCache];
    }
    if (indexPath.row==3) {
        [self pushToIdeaFeedBack];
    }
    if(indexPath.row==4){
        
        NSString *str;
        
#ifdef APP_MiaoTu
        
        if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
            
        {
            
            str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id1080191917"];
            
        }else
            
        {
            
            str = [NSString stringWithFormat:
                   
                   @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=1080191917"];
            
        }
  

#elif defined APP_YiLiang
        if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
            
        {
            
            str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id1178834496"];
            
        }else
            
        {
            
            str = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=1178834496"];
            
        }

        
#endif
        
      
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
//        [self loadAppStoreController];
        
        
    }if (indexPath.row==5) {
        [self pushToAboutUs];
        
    }if (indexPath.row==6) {
        [self leaveLogin];
//        JobIdentViewController *vc=[[JobIdentViewController alloc]init];//招聘求职
//        vc.type = ENT_Null;
//        [self pushViewController:vc];
    }
//    if (indexPath.row==6) {
//        [self leaveLogin];
//    }
    
    
}


//-(void)pushToCompany{
//    BindenterpriseViewController *vc=[[BindenterpriseViewController alloc]init];
//    vc.delegate=self;
//    [self pushViewController:vc];
//
//}

//-(void)disPalyBindCompany:(BindCompanyModel *)model{
//    
//    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:0];
//    MTMeListTableViewCell *cell=(MTMeListTableViewCell *)[commTableView.table cellForRowAtIndexPath:indexPath];
//	UIImage *typeImg = Image(@"store.png");
//	UIImage *img = Image(@"GQ_Left.png");
//	SMLabel *lbl=[cell viewWithTag:101];
//	lbl.frame=CGRectMake(15+typeImg.size.width+100, 25, WindowWith-(15+typeImg.size.width+100)-20-img.size.width,15);
//	if (WindowWith==320) {
//		lbl.font=sysFont(14);
//		lbl.height=14;
//	}
//
//    lbl.textAlignment=NSTextAlignmentRight;
//    lbl.textColor=cGrayLightColor;
//    lbl.text=model.company_name;
//    lbl.hidden=NO;    
//    
//}




@end
