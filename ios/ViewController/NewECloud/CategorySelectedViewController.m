//
//  CategorySelectedViewController.m
//  MiaoTuProject
//
//  Created by Zmh on 5/12/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "CategorySelectedViewController.h"
#import "CreatNerseryViewController.h"
#import "XHFriendlyLoadingView.h"

@interface CategorySelectedViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *commTableView;
    
    NSMutableArray *dataArr;
}

@end

@implementation CategorySelectedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"选择发布类别"];
    
    dataArr = [[NSMutableArray alloc] init];
    //    NSArray *Arr = @[@"高大乔木",@"小乔木/灌木/竹类",@"球体/色块",@"造型植物/古桩/盆景",@"种子/种球/种苗",@"草皮/草花/水生植物"];
    //    [dataArr addObjectsFromArray:Arr];
    [self initViews];
    
    //获取品类及品种
    [self addPushViewWaitingView];
    [network GetMiaoMuYunListSuccess:^(NSDictionary *obj) {
        
        for (NSDictionary *dic in obj[@"content"]) {
			[self->dataArr addObject:dic[@"parent_nursery_name"]];
        }
		[self->commTableView reloadData];
        [self removePushViewWaitingView];
    } failure:^(NSDictionary *obj2) {
        [self removePushViewWaitingView];
        XHFriendlyLoadingView *v=(XHFriendlyLoadingView*)[self.view viewWithTag:8172];
        [v showReloadViewWithText:reloadText];
    }];
}
- (void)initViews
{
    commTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0, WindowWith,WindowHeight) style:UITableViewStylePlain];
    commTableView.dataSource=self;
    commTableView.delegate=self;
    commTableView.backgroundColor = RGB(247 , 248, 250);
    [self setExtraCellLineHidden:commTableView];
    [self.view addSubview:commTableView];
}
- (void)setExtraCellLineHidden: (UITableView *)tableView

{
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identify=@"TableViewCell";
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = dataArr[indexPath.row];
    cell.textLabel.font = sysFont(14);
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 47;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cateStr = dataArr[indexPath.row];
    
    NSDictionary *dic = [ConfigManager getSendMiaoMuYunParameter];
    NSArray *Arr = dic[cateStr];
    
    CreatNerseryViewController *vc=[[CreatNerseryViewController alloc]init];
    vc.paramArr= Arr;
    vc.plantStr = cateStr;
    [self pushViewController:vc];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
