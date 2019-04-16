//
//  MYTaskViewController.m
//  MiaoTuProject
//
//  Created by XBL on 16/5/4.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MYTaskViewController.h"
#import "EditPersonInformationViewController.h"
#import "MapAnnotationViewController.h"
#import "CreatTopicViewController.h"
#import "ActivityListViewController.h"
#import "InvitedViewController.h"
#import "MTOtherInfomationMainViewController.h"
@interface MYTaskViewController ()<UITableViewDelegate,UITableViewDataSource,BtnClick>
{
    UITableView * commTableView;
    NSMutableArray * dataArray;
    NSDictionary * infoDic;
    UIView * headView;
}
@end

@implementation MYTaskViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"我的任务"];
    [self.view setBackgroundColor:RGB(232, 240, 240)];
    __weak MYTaskViewController * weakSelf=self;
    dataArray=[[NSMutableArray alloc]initWithArray:[ConfigManager getMyTaskInfo]];
    infoDic=[[NSDictionary alloc]init];
    
    [network selectUserTaskInfoForId:[USERMODEL.userID intValue] success:^(NSDictionary *obj) {
        
        self->infoDic=obj[@"content"];
        
        NSArray *arr = self->dataArray[0];
        NSDictionary *dic1 = arr[0];
        NSDictionary *dic2 = arr[1];
        
        if ([self->infoDic[dic1[@"tag"]] intValue]>0 && [self->infoDic[dic2[@"tag"]] intValue]>0) {
            [self->dataArray removeObjectAtIndex:0];
        }
        
        [self->commTableView reloadData];
        
        [weakSelf upData];
        [self createView1];
        
        self->commTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 88, WindowWith, WindowHeight-88) style:UITableViewStyleGrouped];
        self->commTableView.delegate=self;
        self->commTableView.dataSource=self;
        
        [self->_BaseScrollView addSubview:self->commTableView];
    } failure:^(NSDictionary *obj2) {
        
    }];
}
- (void)createView1
{
    headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 82)];
    headView.backgroundColor=RGB(255, 255, 255);
    [_BaseScrollView addSubview:headView];
    
    
    NSDictionary *dic=[IHUtility getUserDefalutsDicKey:kUserDefalutLoginInfo];
    
    HeadButton *head=[[HeadButton alloc]initWithFrame:CGRectMake((WindowWith-131)/2.0, 13, 52, 52)];
    [head setHeadImageUrl:[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,dic[@"heed_image_url"]] type:[dic[@"identity_key"] intValue]];
    [headView addSubview:head];
    
    
    SMLabel * grade=[[SMLabel alloc]initWithFrameWith:CGRectMake((WindowWith-131)/2.0+75, 18, 60, 17) textColor:RGB(181, 230, 228) textFont:sysFont(12)];
    grade.text=@"我的积分";
    [headView addSubview:grade];
    
    //我的积分显示
    
    UIButton * gradeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    gradeBtn.frame=CGRectMake((WindowWith-131)/2.0+67, 35, 100, 30);
    [gradeBtn setImage:Image(@"glod.png") forState:UIControlStateNormal];
    [gradeBtn setTitle:[NSString stringWithFormat:@"%@",dic[@"experience_info"][@"residual_value"]] forState:UIControlStateNormal];
    [gradeBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    gradeBtn.tag=100;
    gradeBtn.titleLabel.font=sysFont(12);
    [gradeBtn setTitleColor:RGB(6, 193, 174) forState:UIControlStateNormal];
    gradeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [headView addSubview:gradeBtn];
}
- (void)upData
{
    UIButton * gradeBtn=(UIButton *)[headView viewWithTag:100];
    NSString * str=stringFormatInt([infoDic[@"behavior_value"] intValue]);
    [gradeBtn setTitle:str forState:UIControlStateNormal];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(upDateGrade: indexPath:)]) {
        [self.delegate upDateGrade:str indexPath:self.indexPath];
    }
}

#pragma mark tableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 42;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 6;
}
#pragma mark tableDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (dataArray.count == 3) {
        if(section==0)
            return 2;
        else
            return 3;
    }else {
        return 3;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 42)];
    view.backgroundColor=RGB(255, 255, 255);
    
    SMLabel * tittle=[[SMLabel alloc]initWithFrameWith:CGRectMake(23, 11, 100, 21) textColor:RGB(6, 193, 174) textFont:sysFont(15)];
    if (dataArray.count == 3) {
        
        if (section==0) {
            tittle.text=@". 新手任务 .";
        }else if (section==1)
        {
            tittle.text=@". 每日任务 .";
        }else
        {
            tittle.text=@". 每周任务 .";
        }
    }else if (dataArray.count == 2){
        if (section==0)
        {
            tittle.text=@". 每日任务 .";
        }else
        {
            tittle.text=@". 每周任务 .";
        }
    }
    [view addSubview:tittle];
    
    return view;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"MTTaskTableViewCell";
    MyTaskTableViewCell* cell=(MyTaskTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[MyTaskTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.delegate = (id<BtnClick,BCBaseTableViewCellDelegate>)self;
    int tag= [dataArray[indexPath.section][indexPath.row][@"grade"]intValue];
    if (dataArray.count == 3) {
        
        if (indexPath.section==2) {
            cell.finishBtn.tag=tag+5;
        }else
        {
            cell.finishBtn.tag=tag+indexPath.row;
        }
    }else if (dataArray.count == 2){
        if (indexPath.section==1) {
            cell.finishBtn.tag=tag+5;
        }else
        {
            cell.finishBtn.tag=tag+indexPath.row;
            
        }
    }
    [cell setDataWithDic:dataArray[indexPath.section][indexPath.row]withInfoDic:infoDic];
    
    if (dataArray.count==2) {
        
        if (indexPath.section==1) {
            if (indexPath.row==0) {
                
                if ([infoDic[dataArray[indexPath.section][indexPath.row][@"tag"]] intValue]==0) {
                    NSLog(@"%@",infoDic[dataArray[indexPath.section][indexPath.row][@"tag"]]);
                    
                    cell.finishBtn.backgroundColor=nil;
                    [cell.finishBtn setTitle:@"未完成" forState:UIControlStateNormal];
                    [cell.finishBtn setTitleColor:cGrayLightColor forState:UIControlStateNormal];
                    cell.finishBtn.enabled=NO;
                }
            }
        }
    }
    
    if (dataArray.count==3) {
        if (indexPath.section==2) {
            if (indexPath.row==0) {
                
                
                if ([infoDic[dataArray[indexPath.section][indexPath.row][@"tag"]] intValue]==0) {
                    
                    NSLog(@"%@",dataArray[indexPath.section][indexPath.row][@"tag"]);
                    
                    cell.finishBtn.backgroundColor=nil;
                    [cell.finishBtn setTitle:@"未完成" forState:UIControlStateNormal];
                    [cell.finishBtn setTitleColor:cGrayLightColor forState:UIControlStateNormal];
                    cell.finishBtn.enabled=NO;
                }
            }
        }
    }
    if (dataArray.count==0) {
        return cell;
    }
    return cell;
}
- (void)goTask:(id)sender
{
    UIButton * btn=(UIButton *)sender;
    if (btn.tag==100)
    {
        EditPersonInformationViewController * edit=[[EditPersonInformationViewController alloc]init];
        [self pushViewController:edit];
        
    }else if (btn.tag==201)
    {
        MapAnnotationViewController * map=[[MapAnnotationViewController alloc]init];
        [self pushViewController:map];
        
    }else if (btn.tag==101)
    {
        //        [self taskShareApp:self];
        InvitedViewController *InvitedVC =[[InvitedViewController alloc]init];
        InvitedVC.type = @"1";
        
        [self pushViewController:InvitedVC];
        
    }else if (btn.tag==10)
    {
        
    }else if (btn.tag==11)
    {
        NSDictionary *dic=[IHUtility getUserDefalutsDicKey:kUserDefalutLoginInfo];
        
        UserChildrenInfo *mod=[[UserChildrenInfo alloc]initWithDic:dic];
        [network selectUserCloudInfoById:[USERMODEL.userID intValue]follow_id:[mod.user_id intValue]success:^(NSDictionary *obj) {
            
            MTOtherInfomationMainViewController *controller=[[MTOtherInfomationMainViewController alloc]initWithUserID:mod.user_id :NO dic:obj[@"content"]];
            controller.userMod=mod;
            controller.dic=obj[@"content"];
            [self pushViewController:controller];
        } failure:^(NSDictionary *obj2) {
            
        }];
        
    }else if (btn.tag==12)
    {
        CreatTopicViewController * create=[[CreatTopicViewController alloc]init];
        [self presentViewController:create];
        
    }else if (btn.tag==105)
    {
        
    }else if (btn.tag==25)
    {
        CreatTopicViewController * create=[[CreatTopicViewController alloc]init];
        [self presentViewController:create];
        
    }else if (btn.tag==205)
    {
        ActivityListViewController * activi=[[ActivityListViewController alloc]init];
        activi.type=@"1";
        [self pushViewController:activi];
    }
}

- (void)back:(id)sender
{
    if ([self.type isEqualToString:@"2"]) {
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
