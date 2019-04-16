//
//  MTSearchViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/3/31.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTSearchViewController.h"

@interface MTSearchViewController ()<UITableViewDelegate,UITextFieldDelegate>
{
    IHTextField *_textFiled;
    UIScrollView *_scroll;
    MTBaseTableView *commTableView;
    int page;
    NSMutableArray *dataArray;
//    NSString *_companyName;
    NSArray * _typeId;
    SMLabel *_lbl;
}
@end

@implementation MTSearchViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_textFiled becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dataArray=[[NSMutableArray alloc]init];
    UIImage *searchImg=Image(@"search_white2.png");
    _typeId=@[@0,@1,@2,@3,@4,@5];
    rightbutton.hidden=NO;
    
    [rightbutton setImage:[searchImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    rightbutton.frame=CGRectMake(0, 0, searchImg.size.width, searchImg.size.height);
    
    _textFiled=[[IHTextField alloc]initWithFrame:CGRectMake(5, 0, 0.8*WindowWith-rightbutton.width-10, searchImg.size.height)];
    [_textFiled setClearButtonMode:UITextFieldViewModeAlways];
    _textFiled.borderStyle=UITextBorderStyleRoundedRect;
    _textFiled.delegate=self;
    
    _lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, 0, 55, 20) textColor:[UIColor whiteColor] textFont:sysFont(12)];
    _lbl.layer.cornerRadius=5;
    _lbl.clipsToBounds=YES;
    _lbl.text=@"全部类别";
    _lbl.tag=1001;
    
    _lbl.textAlignment=NSTextAlignmentCenter;
    _lbl.backgroundColor=cBlackColor;
    _textFiled.leftView=_lbl;
    _textFiled.placeholder=@"公司/昵称";
    _textFiled.font =sysFont(12);
    _textFiled.leftViewMode=UITextFieldViewModeAlways;
    _textFiled.layer.cornerRadius=5;
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0.8*WindowWith, searchImg.size.height)];
    view.backgroundColor=RGBA(255, 255, 255, 0.5);
    [view addSubview:_textFiled];
    
    view.layer.cornerRadius=5;
    self.navigationItem.titleView = view;
    UIView  *View=[[UIView alloc]initWithFrame:CGRectMake(view.width-rightbutton.width-10, 0, 10, view.height)];
    View.backgroundColor=cGreenColor;
    // [view addSubview:View];
    _scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 115)];
    _scroll.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_scroll];
    
    NSArray *imgArr=@[@"Group.png",@"Group 12.png",@"Group 14.png",@"Group 13.png",@"Group 15.png",];
    NSArray *strArr=@[@"全部类别",@"苗木基地",@"景观设计",@"园林施工",@"园林资材"];
    for (NSInteger i=0; i<imgArr.count; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame=CGRectMake(13+i*(Image(imgArr[i]).size.width+20), 16, Image(imgArr[i]).size.width,  Image(imgArr[i]).size.height);
        [btn setImage:[Image(imgArr[i]) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
        btn.tag=1000+i;
        [btn addTarget:self action:@selector(type:) forControlEvents:UIControlEventTouchUpInside];
        [_scroll addSubview:btn];
        CGSize size=[IHUtility GetSizeByText:strArr[i] sizeOfFont:13 width:200];
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, btn.bottom+15, size.width, size.height) textColor:cBlackColor textFont:sysFont(13)];
        lbl.text=strArr[i];
        lbl.centerX=btn.centerX;
        [_scroll addSubview:lbl];
        
    }
    UIButton *btn=[_scroll viewWithTag:1000+imgArr.count-1];
    _scroll.contentSize=CGSizeMake(btn.right+15, 100);
    
    [self creatTableView];
}

-(void)home:(id)sender{
    _typeId=@[@0,@1,@2,@3,@4,@5];
    [self beginRefesh:ENT_RefreshHeader];
}

-(void)type:(UIButton *)sender
{
    UIButton *btn=(UIButton *)sender;
    if (btn.tag==1000) {
        _typeId=@[@0,@1,@2,@3,@4,@5];
    }else
    {
        _typeId=@[@(btn.tag-1000)];
    }
    
    self.selectTypeBlock(_typeId);
    
    [self back:nil];
}
-(void)back:(id)sender{
    [_textFiled resignFirstResponder];
    [super back:nil];
}

-(void)creatTableView
{
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, _scroll.bottom, WindowWith, 1)];
    lineView.backgroundColor=cLineColor;
    [self.view addSubview:lineView];
    
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, _scroll.bottom+21, WindowWith, WindowHeight+23-_scroll.height) tableviewStyle:UITableViewStylePlain];
    commTableView.attribute=self;
    commTableView.table.delegate=self;
    [commTableView setupData:dataArray index:8];
    
    [self.view addSubview:commTableView];
    __weak MTSearchViewController *weakSelf = self;
    
    [self CreateBaseRefesh:commTableView type:ENT_RefreshAll successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefresh:refreshView];
    }];
    
    [self beginRefesh:ENT_RefreshHeader]; //进行下拉刷新
}

-(void)loadRefresh:(MJRefreshComponent*)refreshView{
    if (refreshView==commTableView.table.mj_header) {
        page=0;
    }
    [network getSelectUserCompanyNameforTypeId:(NSArray *)_typeId
                                           num:(int)pageNum
                                          page:(int)page
                                      latitude:USERMODEL.latitude
                                     longitude:USERMODEL.longitude
                                  company_name:_textFiled.text
                                       success:^(NSDictionary *obj) {
                                           
                                           if (refreshView==self->commTableView.table.mj_header) {
                                               [self->dataArray removeAllObjects];
                                               self->page=0;
                                           }
                                           NSArray *arr=obj[@"content"];
                                           
                                           if (arr.count>0) {
                                               self->page++;
                                               if (arr.count<pageNum) {
                                                   [self->commTableView.table.mj_footer endRefreshingWithNoMoreData];
                                               }
                                           }else{
                                               
                                               [self->commBaseTableView.table.mj_header endRefreshing];
                                               [self->commTableView.table.mj_footer endRefreshingWithNoMoreData];
                                               [self endRefresh];
                                               return ;
                                           }
                                           
                                           [self->dataArray addObjectsFromArray:arr];
                                           [self->commTableView.table reloadData];
                                           [self endRefresh];
                                       } failure:^(NSDictionary *obj2) {
                                           [self endRefresh];
                                       }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.row>dataArray.count) {
        return;
    }
    UserChildrenInfo *model=dataArray[indexPath.row];
    
    self.selectCompanyBlock(_typeId,model.user_id,[model.company_lat doubleValue],[model.company_lon doubleValue],model.company_province);
    [self back:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
