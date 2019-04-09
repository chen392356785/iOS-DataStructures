//
//  IdentKeyViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/5/5.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "IdentKeyViewController.h"
#import "YLWebViewController.h"
#import "IdentWebViewViewController.h"
@interface IdentKeyViewController ()<UITableViewDelegate>
{
    MTBaseTableView *commTableView;
}
@end

@implementation IdentKeyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"身份勋章"];
    [self creatTableView];
}

-(void)creatTableView
{
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight) tableviewStyle:UITableViewStylePlain];
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 40)];
    SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(WindowWith-180, 10, 150, 15) textColor:cBlackColor textFont:sysFont(15)];
    lbl.text=@"最终解释权归苗途所有";
    [view addSubview:lbl];
    commTableView.table.tableFooterView=view;
    commTableView.attribute=self;
    commTableView.table.delegate=self;
    
    NSArray * ListArr = [ConfigManager getIdentList1];
    [commTableView setupData:ListArr index:19];
    
    [self.view addSubview:commTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 300;
}

-(void)BCtableViewCell:(IHTableViewCell *)cell action:(BCTableViewCellAction)action indexPath:(NSIndexPath *)indexPath attribute:(NSObject *)attribute
{
    if (action==MTActivityBMTableViewCell) {
        NSLog(@"申请");
        YLWebViewController *vc=[[YLWebViewController alloc]init];
        vc.mUrl=[NSURL URLWithString:@"http://www.sojump.com/jq/8063326.aspx"];
        vc.NameTitle=@"报名申请";
        [self pushViewController:vc];
    }
}
@end
