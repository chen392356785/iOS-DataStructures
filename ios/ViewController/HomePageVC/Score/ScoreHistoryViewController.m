//
//  ScoreHistoryViewController.m
//  MiaoTuProject
//
//  Created by Zmh on 30/11/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "ScoreHistoryViewController.h"

@interface ScoreHistoryViewController ()<UITableViewDelegate>
{
    MTBaseTableView *commTableView;
//    int page;
    NSMutableArray *dataArray;
    
    EmptyPromptView *_EPView;
}
@end

@implementation ScoreHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"兑换记录"];
    
    dataArray=[[NSMutableArray alloc]init];
    //    NSArray *Arr = @[@"",@"",@""];
    //    [dataArray addObjectsFromArray:Arr];
    
    
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight) tableviewStyle:UITableViewStylePlain];
    commTableView.attribute=self;
    commTableView.table.backgroundColor = cLineColor;
    commTableView.table.delegate=self;
    [commTableView setupData:dataArray index:56];
    
    [self.view addSubview:commTableView];
    [self loadRefesh];
    
    EmptyPromptView *EPView  = [[EmptyPromptView alloc] initWithFrame:commTableView.table.frame context:@"您还没有兑换记录~!"];
    EPView.hidden = YES;
    _EPView = EPView;
    [commTableView.table addSubview:EPView];
}
-(void)loadRefesh{
    NSString *userID;
    if (!USERMODEL.isLogin) {
        userID = @"0";
    }else
    {
        userID = USERMODEL.userID;
    }
    
    [network userScoreConvertHistory:userID success:^(NSDictionary *obj) {
        NSArray *arr=obj[@"content"];
        
        [self->dataArray addObjectsFromArray:arr];
        [self->commTableView.table reloadData];
        if (self->dataArray.count == 0) {
            
            self->_EPView.hidden = NO;
        }else{
            self->_EPView.hidden = YES;
        }
        [self endRefresh];
        
    } failure:^(NSDictionary *obj2) {
        [self endRefresh];
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 188.5;
}
-(void)backTopClick:(UIButton *)sender{
    [self scrollTopPoint:commTableView.table];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
