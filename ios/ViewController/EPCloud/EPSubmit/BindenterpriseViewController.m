//
//  BindenterpriseViewController.m
//  MiaoTuProject
//
//  Created by Zmh on 15/7/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "BindenterpriseViewController.h"

@interface BindenterpriseViewController ()<UITableViewDelegate>
{
    int page;
	MTBaseTableView *commTableView;
    NSMutableArray *dataArray;
    NSIndexPath *_indexPath;
    SearchView *_searchV;
    NSString *_company_name;
    SMLabel *_label;
    BindCompanyModel *model;
}
@end

@implementation BindenterpriseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"绑定企业"];
    [self creatTableView];
}

-(void)creatTableView
{
    __weak BindenterpriseViewController *weakSelf = self;
    
    self.view.backgroundColor = cLineColor;
    SearchView *searchV = [[SearchView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, 45)];
    [searchV.button setTitle:@"搜索" forState:UIControlStateNormal];
    searchV.button.backgroundColor = RGB(85, 201, 196);
    searchV.button.layer.cornerRadius =4.0;
    [searchV.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    _searchV = searchV;
    [self.view addSubview:searchV];
    
    __weak SearchView *searchSelf = searchV;
    searchV.selectBtnBlock = ^(NSInteger index){
        [searchSelf.textfiled resignFirstResponder];
		self->_company_name = searchSelf.textfiled.text;
		[self->dataArray removeAllObjects];
        //刷新列表
        [weakSelf loadRefesh];
    };
    
    SMLabel *label = [[SMLabel alloc] initWithFrameWith:CGRectMake(0, searchV.bottom + 10, WindowWith, 20) textColor:cGrayLightColor textFont:sysFont(14)];
    _label = label;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    [self.view addSubview:label];
    
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, label.bottom + 10 , WindowWith, WindowHeight - label.bottom - 10) tableviewStyle:UITableViewStylePlain];
    
    dataArray=[[NSMutableArray alloc]init];
    commTableView.attribute=self;
    commTableView.table.delegate=self;
    [commTableView setupData:dataArray index:34];
    commTableView.backgroundColor = cLineColor;
    
    [self.view addSubview:commTableView];
    
    //尾部试图
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, 110)];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0,20, 100, 20)];
    button.centerX = WindowWith/2.0;
    [button setTitle:@"绑定有啥好处？" forState:UIControlStateNormal];
    [button setTitleColor:RGB(6, 193, 174) forState:UIControlStateNormal];
    button.titleLabel.font = sysFont(14);
    [button addTarget:self action:@selector(cancle:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:button];
    
    button = [[UIButton alloc] initWithFrame:CGRectMake(0, button.bottom + 30, 140, 37)];
    button.centerX = WindowWith/2.0;
    button.backgroundColor = RGB(6, 193, 174);
    button.layer.cornerRadius = 18;
    [button setTitle:@"保 存" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = sysFont(14);
    [button addTarget:self action:@selector(referBtn:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:button];
    
    commTableView.table.tableFooterView = footView;
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(20, 0, 40, 30);
    
    [shareBtn setTitle:@"保存" forState:UIControlStateNormal];
    [shareBtn setTitleColor:cGreenColor forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(referBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *shareBarItem = [[UIBarButtonItem alloc] initWithCustomView:shareBtn];
    
    self.navigationItem.rightBarButtonItem = shareBarItem;
}

- (void)cancle:(UIButton *)button
{
    [_searchV.textfiled resignFirstResponder];
    bindGoodView *view = [[bindGoodView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, kScreenHeight)];
    view.alpha = 0;
    [self.view.window addSubview:view];
    [UIView animateWithDuration:1 animations:^{
        view.alpha = 1;
    }];
}
- (void)referBtn:(UIButton *)button
{
    if (model) {
        [_searchV.textfiled resignFirstResponder];
		if ([self.delegate respondsToSelector:@selector(disPalyBindCompany:)]) {
			[self.delegate disPalyBindCompany:model];
		}
		[self.navigationController popViewControllerAnimated:YES];
    }else{
        [self addSucessView:@"未选择企业" type:2];
    }
}
-(void)loadRefesh{
    
    [self addWaitingView];
    [network getCompanyBycompanyName:_company_name success:^(NSDictionary *obj) {
        NSArray *arr=obj[@"content"];
        
        [self removeWaitingView];
		[self->dataArray addObjectsFromArray:arr];
		[self->commTableView.table reloadData];
        
		self->_label.text = [NSString stringWithFormat:@"“%@”共有%ld个结果，请选择你所属的企业",self->_company_name,self->dataArray.count];
        
		if (self->dataArray.count == 0) {
			self->_label.text = [NSString stringWithFormat:@"“%@”未能找到相关企业",self->_company_name];
            
            
			UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(35, self->_label.bottom + 18, WindowWith - 70, 20)];
            lbl.numberOfLines= 0;
            lbl.font = sysFont(14);
            lbl.textColor = cGrayLightColor;
            
            
            lbl.text = [NSString stringWithFormat:@"      原因很可能是%@未能及时收录你的企业信息，建议你与我们的客服联系，我们将第一时间为将您的企业录入园林云数据库。\n\n      客服热线：%@",KAppName,KTelNum];
            
            [lbl sizeToFit];
            NSMutableAttributedString *str = [IHUtility changePartTextColor:lbl.text range:NSMakeRange(lbl.text.length - 12, 12) value:RGB(6, 193, 174)];
            lbl.attributedText = str;
            
            [self.view addSubview:lbl];
			self->commTableView.top = lbl.bottom + 10;
        }
    } failure:^(NSDictionary *obj2) {
        
    }];
}
-(void)backTopClick:(UIButton *)sender{
    [self scrollTopPoint:commTableView.table];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 98;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    model  = dataArray[indexPath.row];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_searchV.textfiled resignFirstResponder];
}

@end
