//
//  GardenCloudViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/7/7.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "GardenCloudViewController.h"
//#import "WSHorizontalPickerView.h"
//#import "WSHorizontalPiackView2.h"
#import "EPCloudListViewController.h"
#import "CustomView+CustomCategory2.h"
#import "EPCloudConnectionViewController.h"
#import "MTOtherInfomationMainViewController.h"
#import "EPCloudDetailViewController.h"

@interface GardenCloudViewController ()<UICollectionViewDelegate, UIScrollViewDelegate>
{
//    NSMutableArray *dataArrary;
//    UICollectionView  *collectionView ;
//    UIScrollView *_scoller;
    NSArray *_arr;
     NSArray *_arr2;
}

@end

@implementation GardenCloudViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"园林云"];
    [self addPushViewWaitingView];
    
    UIScrollView *scoller=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight)];
    scoller.contentSize=CGSizeMake(WindowWith, 1000);
    scoller.showsVerticalScrollIndicator=NO;
    scoller.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:scoller];
 
//    _scoller=scoller;
    SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0.05*WindowWith, 0.062*WindowWith, 63, 21) textColor:cBlackColor textFont:sysFont(21)];
    lbl.text=@"人脉云";
    [scoller addSubview:lbl];
    
    
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.left, lbl.bottom+12, 104, 13) textColor:cGrayLightColor textFont:sysFont(13)];
    lbl.text=@"找对的人做对的事";
    [scoller  addSubview:lbl];
    
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"更多" forState:UIControlStateNormal];
    [btn setTitleColor:cGrayLightColor forState:UIControlStateNormal];
    btn.frame=CGRectMake(WindowWith-80, lbl.top-5, 80-0.05*WindowWith+10, 15+10);
    btn.titleLabel.font=sysFont(13);
    [scoller  addSubview:btn];
    [btn addTarget:self action:@selector(pushToConnectionsListView) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(lbl.left, lbl.bottom+0.05*WindowWith, WindowWith-lbl.left*2, 1)];
    lineView.backgroundColor=cLineColor;
    [scoller  addSubview:lineView];
    
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0.04*WindowWith, lineView.bottom+0.05*WindowWith, 0.92*WindowWith+0.02*WindowWith, 208 + 111*WindowWith/375.0)];
    scrollView.clipsToBounds=NO;
    scrollView.pagingEnabled=YES;
    scrollView.showsHorizontalScrollIndicator=NO;
    
    [network selectRecommendUserInfo:[USERMODEL.userID intValue] success:^(NSDictionary *obj) {
            NSArray *arr=obj[@"content"];
        [self removePushViewWaitingView];
        self->_arr=arr;
        scrollView.contentSize=CGSizeMake((0.92*WindowWith+0.02*WindowWith)*arr.count-0.02*WindowWith, 208 + 111*WindowWith/375.0);
    
        
        
        for (NSInteger i=0; i<arr.count; i++) {
            NSDictionary *dic=arr[i];
            MTConnectionModel *model=[[MTConnectionModel alloc]initWithDictionary:dic error:nil];
           
            ConnectionsView *view=[[ConnectionsView alloc]initWithFrame:CGRectMake((0.92*WindowWith+0.02*WindowWith)*i, 0, 0.92*WindowWith, 208 + 111*WindowWith/375.0)];
            [scrollView addSubview:view];
            
            view.tag=2000+i;
            
            UITapGestureRecognizer *mapTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headtap:)];
            [view addGestureRecognizer:mapTap];

            __weak ConnectionsView *viewSelf = view;
            view.selectBtnBlock=^(NSInteger index){
                
                
                            if (!USERMODEL.isLogin) {
                                [self prsentToLoginViewController];
                                return ;
                            }
                if (index==SelectFollowBlock) {
                    
                    
                                    [IHUtility addWaitingView];
                                    [network followUser:[USERMODEL.userID intValue]follow_id:[model.user_id intValue]type:@"0" success:^(NSDictionary *obj) {
                                        [IHUtility removeWaitingView];
                                        [IHUtility addSucessView:@"关注成功" type:1];
                                        NSDictionary *Dic=[IHUtility getUserDefalutDic:KFansDefalutInfo];
                                        NSMutableDictionary *fansDic=[[NSMutableDictionary alloc]initWithDictionary:Dic];
                                        [fansDic setValue:[NSString stringWithFormat:@"%ld",[ fansDic[@"followNum"] integerValue]+1] forKey:@"followNum"];
                                       
                                        model.fansNum = stringFormatInt([model.fansNum intValue] + 1);
                                        model.followStatus = @"1";
                                        [viewSelf setDataWithModel:model j:i];
                    
                                        [IHUtility setUserDefaultDic:fansDic key:KFansDefalutInfo];
                                    } failure:^(NSDictionary *obj2) {
                                        [IHUtility removeWaitingView];
                                    }];
                    
                    
                                }else if (index==SelectUpFollowBlock){
                    
                                    [IHUtility addWaitingView];
                                    [network followUser:[USERMODEL.userID intValue]follow_id:[model.user_id intValue]type:@"1" success:^(NSDictionary *obj) {
                                        [IHUtility removeWaitingView];
                                        [IHUtility addSucessView:@"取消关注成功" type:1];
                                        NSDictionary *Dic=[IHUtility getUserDefalutDic:KFansDefalutInfo];
                                        NSMutableDictionary *fansDic=[[NSMutableDictionary alloc]initWithDictionary:Dic];
                                        [fansDic setValue:[NSString stringWithFormat:@"%ld",[ fansDic[@"followNum"] integerValue]-1] forKey:@"followNum"];
                                        model.fansNum = stringFormatInt([model.fansNum intValue] - 1);
                                        model.followStatus = @"0";
                                        [viewSelf setDataWithModel:model j:i];
                                        
                                        [IHUtility setUserDefaultDic:fansDic key:KFansDefalutInfo];
                                    } failure:^(NSDictionary *obj2) {
                                        [IHUtility removeWaitingView];
                                    }];
                                    
                                    
                                }
            };


            
            
                      [view setDataWithModel:model j:i];
            
            
        
            
            
            
            
            
        }
        
        
        
    } failure:^(NSDictionary *obj2) {
        
    }];

    
    [scoller addSubview:scrollView];
    
    
    

    
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0.05*WindowWith,scrollView.bottom+20, 63, 21) textColor:cBlackColor textFont:sysFont(21)];
    lbl.text=@"企业云";
    [scoller  addSubview:lbl];
    
    
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.left, lbl.bottom+12, 124, 13) textColor:cGrayLightColor textFont:sysFont(13)];
    lbl.text=@"最全的园林企业黄页";
    [scoller  addSubview:lbl];
    
    
    btn=[UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"更多" forState:UIControlStateNormal];
    [btn setTitleColor:cGrayLightColor forState:UIControlStateNormal];
    btn.frame=CGRectMake(WindowWith-80, lbl.top-5, 80-0.05*WindowWith+10, 15+10);
    btn.titleLabel.font=sysFont(13);
    [scoller  addSubview:btn];

     [btn addTarget:self action:@selector(pushToCompanyListView) forControlEvents:UIControlEventTouchUpInside];
    
    lineView=[[UIView alloc]initWithFrame:CGRectMake(lbl.left, lbl.bottom+0.05*WindowWith, WindowWith-lbl.left*2, 1)];
    lineView.backgroundColor=cLineColor;
    [scoller  addSubview:lineView];
    
    UIScrollView *scrollView2=[[UIScrollView alloc]initWithFrame:CGRectMake(0.04*WindowWith, lineView.bottom+0.05*WindowWith, 0.92*WindowWith+0.02*WindowWith, 0.9*WindowWith)];
    scrollView2.clipsToBounds=NO;
    scrollView2.pagingEnabled=YES;
    scrollView2.showsHorizontalScrollIndicator=NO;
   
    [network selectCompanyInfoByTopsuccess:^(NSDictionary *obj) {
        NSArray *arr=obj[@"content"][@"companyInfos"];
        self->_arr2=arr;
         scrollView2.contentSize=CGSizeMake((0.92*WindowWith+0.02*WindowWith)*arr.count-0.02*WindowWith, 0.9*WindowWith);
         [scoller addSubview:scrollView2];
        
        for (NSInteger i=0; i<arr.count; i++) {
            NSDictionary *dic=arr[i];
            MTCompanyModel *model=[[MTCompanyModel alloc]initWithDictionary:dic error:nil];
            CompanyView *view=[[CompanyView alloc]initWithFrame:CGRectMake((0.92*WindowWith+0.02*WindowWith)*i, 0, 0.92*WindowWith, 0.9*WindowWith)];
            
            
           
            
            [scrollView2 addSubview:view];
            
            UITapGestureRecognizer *mapTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headtap2:)];
            [view addGestureRecognizer:mapTap];
            
            view.tag=1000+i;
            [view setDataWithModel:model];

        
        }
        
        
        
    } failure:^(NSDictionary *obj2) {
        
    }];

    scoller.contentSize=CGSizeMake(WindowWith, scrollView2.bottom+30);
    
       
}




-(void)headtap2:(UITapGestureRecognizer *)tap{
    
    
    NSDictionary *Dic = _arr2[tap.view.tag-1000];
    
                EPCloudListModel *model = [[EPCloudListModel alloc] initWithDictionary:Dic error:nil];
    
    
                NSString * str=model.company_image;
                if (str.length>0) {
    
                    NSArray *arr1=[network getJsonForString:str];
                    NSMutableArray *imgArr=[[NSMutableArray alloc]initWithCapacity:arr1.count];
    
                    for (NSDictionary * dic2 in arr1) {
                        MTPhotosModel * photoModel=[[MTPhotosModel alloc]initWithUrlDic:dic2];
                        [imgArr addObject:photoModel];
                    }
                    model.imageArr=imgArr;
                }
    
                    EPCloudDetailViewController *detailVC =[[EPCloudDetailViewController alloc]init];
                    detailVC.model = model;
                    [self pushViewController:detailVC];
    

    
}





-(void)headtap:(UITapGestureRecognizer *)tap{
    
      NSDictionary *dic=_arr[tap.view.tag-2000];
    MTConnectionModel *model=[[MTConnectionModel alloc]initWithDictionary:dic error:nil];
                    [self addWaitingView];
                    [network selectUseerInfoForId:[model.user_id intValue]
                                          success:^(NSDictionary *obj) {
    
                                              MTNearUserModel *mod=[[MTNearUserModel alloc]initWithDictionary:obj[@"content"] error:nil];
                                              UserChildrenInfo *usermodel=[[UserChildrenInfo alloc]initWithModel:mod];
                                              [network selectUserCloudInfoById:[USERMODEL.userID intValue]follow_id:[model.user_id intValue]success:^(NSDictionary *obj) {
                                                  [self removeWaitingView];
                                                  MTOtherInfomationMainViewController *controller=[[MTOtherInfomationMainViewController alloc]initWithUserID:model.user_id :NO dic:obj[@"content"]];
                                                  controller.userMod=usermodel;
                                                  controller.dic=obj[@"content"];
                                                  [self pushViewController:controller];
                                              } failure:^(NSDictionary *obj2) {
    
                                              }];
    
    
    
                                          } failure:^(NSDictionary *obj2) {
    
                                          }];

    
    
}


-(void)pushToCompanyListView{
    EPCloudListViewController *vc=[[EPCloudListViewController alloc]init];
    [self pushViewController:vc];
    
}


-(void)pushToConnectionsListView{
    EPCloudConnectionViewController *vc=[[EPCloudConnectionViewController alloc]init];
    [self pushViewController:vc];
    
}




-(void)selectItemAtIndex:(NSInteger)index
{

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
