//
//  EPCloudCumlativeViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/7/5.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "CustomView+CustomCategory2.h"
#import "EPCloudCumlativeViewController.h"
#import "EPCloudEditInformationViewController.h"

@interface EPCloudCumlativeViewController ()<UITableViewDelegate>
{
    MTBaseTableView *commTableView;
}

@end

@implementation EPCloudCumlativeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"企业名片申请"];
    
    [self creatTableView];
    
    BtnView *btn=[[BtnView alloc]initWithFrame:CGRectMake(0, WindowHeight-60, 145, 38)  cornerRadius:18 text:@"提  交" image:nil];
    btn.centerX=self.view.centerX;
    [self.view addSubview:btn];
}

-(void)creatTableView
{
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight) tableviewStyle:UITableViewStylePlain];
    
    commTableView.attribute=self;
    commTableView.table.delegate=self;
    
    NSArray *arr=[ConfigManager getEPCloudCumlativeList];
    [commTableView setupData:arr index:27];
    
    [self.view addSubview:commTableView];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 72.5;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        EPCloudEditInformationViewController *vc=[[EPCloudEditInformationViewController alloc]init];
        [self pushViewController:vc];
    }else if (indexPath.row==1){
        
        
    }else if (indexPath.row==2){
        
        
    }else if (indexPath.row==3){
        
        
    }else if (indexPath.row==4){
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
