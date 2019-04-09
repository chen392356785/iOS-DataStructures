//
//  FindCarViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/12/28.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "FindCarViewController.h"
#import "calendarView.h"
//#import "AddressPickView.h"
#import "carSourceMoreView.h"
#import "LogisyicsMyFaBuViewController.h"
#import "CarDetailViewController.h"
#import "LogisticsFaBuViewController.h"
#import "AddressDropView.h"
#import "ChatViewController.h"
@interface FindCarViewController ()<UITableViewDelegate,ChatViewControllerDelegate>
{
    MTBaseTableView *commTableView;
    int page;
    NSMutableArray *dataArray;
    
    NSString *_city;
    NSString *_province;
    NSString *_town;
    
    
    NSString *_city2;
    NSString *_province2;
    NSString *_town2;
    
    UIButton *_createBtn;
    calendarView *_calendarV;
    MTLogisticsChooseView *_logisticsView;
    carSourceMoreView *_carSV;
    UIButton *_btn;
    NSDictionary *_dic;
    NSMutableArray *_typeArr;
    AddressDropView *_view1;
    AddressDropView *_view2;
    NSIndexPath *_indexPath;
    FindCarModel *_model;
    
}
@end

@implementation FindCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"找车"];
    dataArray=[[NSMutableArray alloc]init];
    page=0;
    _province=@"";
    _city=@"";
    _town=@"";
    _province2=@"";
    _city2=@"";
    _town2=@"";
    _typeArr=[[NSMutableArray alloc]init];
     __weak FindCarViewController *weakSelf=self;
    [network getSelectCarParamsSuccess:^(NSDictionary *obj) {
        NSMutableDictionary *Dic=[[NSMutableDictionary alloc]init];
        NSArray *arr=obj[@"content"];
        for (NSDictionary *dic in arr) {
            [Dic setObject:dic[@"select_params"] forKey:dic[@"type_name"]];
            
            
        }
        self->_dic=[[NSDictionary alloc]initWithDictionary:Dic];
        
        carSourceMoreView *carSV = [[carSourceMoreView alloc] initWithFrame:CGRectMake(0,self->_logisticsView.bottom, WindowWith, WindowHeight - self->_logisticsView.height) dic:self->_dic];
        
        carSV.selectBlock=^(NSArray *arr){
          
            [weakSelf setTypeWithArr:arr];
            
        };
        carSV.hidden = YES;
        self->_carSV = carSV;
        [self.view addSubview:carSV];

        
    } failure:^(NSDictionary *obj2) {
        
    }];
    [self setRightButtonImage:Image(@"logistics_fabu.png") forState:UIControlStateNormal];
   
    self.view.backgroundColor=cBgColor;
    NSArray *arr = @[@"出发地",@"目的地",@"更多"];
    MTLogisticsChooseView *logisticsView=[[MTLogisticsChooseView alloc]initWithOrgane:CGPointMake(0, 0) array:arr];
    _logisticsView = logisticsView;
    _logisticsView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:logisticsView];
    
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(12, logisticsView.bottom, WindowWith-24, WindowHeight-43) tableviewStyle:UITableViewStylePlain];
    //commTableView.table.tableHeaderView=logisticsView;
    commTableView.table.delegate=self;
    commTableView.table.showsVerticalScrollIndicator=NO;
    
    commTableView.attribute=self;
    [commTableView setupData:dataArray index:60];
    [self CreateBaseRefesh:commTableView type:ENT_RefreshAll successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefesh:refreshView];
    }];
 
    [self beginRefesh:ENT_RefreshHeader];
    
    [self.view addSubview:commTableView];
    
    UIImage *img=Image(@"logistics_fabu-1.png");
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    btn.frame=CGRectMake(WindowWith-15-img.size.width, WindowHeight-30-img.size.height, img.size.width, img.size.height) ;
    [self.view addSubview:btn];
    _btn=btn;
    [btn addTarget:self action:@selector(pushToFaBuVC) forControlEvents:UIControlEventTouchUpInside];
    
    
    //更多
    
    logisticsView.selectBtnBlock=^(NSInteger index,UIButton *sender){
        [weakSelf btnwith:index :sender];
    };
    

    
    
    
    
}

-(void)btnwith:(NSInteger)index :(UIButton *)sender{
    if (index==SelectStartBlock) {
        
        if (sender.selected) {
            //弹出出发地界面
            [self zhuangcheAddress];
            //隐藏目的地界面
            [_view2 hiddenBottomView];
            //隐藏更多界面
            [_carSV hiddenBottomView];
        }else{
            //隐藏出发地界面
            [_view1 hiddenBottomView];
        }
        
        
    }else if (index==SelectEntBlock){
        
        if (sender.selected) {
            //弹出目的地界面
            [self arriverAddress];
            //隐藏出发地界面
            [_view1 hiddenBottomView];
            //隐藏更多界面
            [_carSV hiddenBottomView];
        }else{
            //隐藏目的地界面
            [_view2 hiddenBottomView];
        }
        
        
    }else if (index==SelectTimeBlock){
        
        //_carSV.hidden=NO;
        if (sender.selected) {
            //弹出更多界面
            [self showMoreView];
            //隐藏出发地界面
            [_view1 hiddenBottomView];
            //隐藏目的地界面
            [_view2 hiddenBottomView];
        }else {
            //隐藏更多界面
            [_carSV hiddenBottomView];
        }
        
    }else if (index==SelectMoreBlock){
        NSLog(@"more");
        
        
        
    }
}

//弹出”更多“界面
- (void)showMoreView {
    _carSV.alpha = 1;
    _carSV.hidden = NO;
}


//类型
-(void)setTypeWithArr:(NSArray *)arr{
    for (NSDictionary *dic in arr) {
        NSDictionary *Dic=@{@"type_name":dic.allKeys[0],@"select_params":dic[dic.allKeys[0]]};
        [_typeArr addObject:Dic];
    }
    UIButton *btn=[_logisticsView viewWithTag:1002];
    btn.selected=NO;
    [self beginRefesh:ENT_RefreshHeader];
}



-(void)zhuangcheAddress{
    
    __weak FindCarViewController *weakSelf=self;
    AddressDropView *view=[[AddressDropView alloc]initWithFrame:CGRectMake(0, _logisticsView.bottom, WindowWith, WindowHeight-_logisticsView.bottom)];
    _view1=view;
    view.selectBtnBlock=^(NSString *province,NSString *city,NSString *town,NSString *street){
        self->_province = province;
        self->_city = city;
        self->_town=town;
          UIButton *btn=[self->_logisticsView viewWithTag:1000];
        if (![self->_town isEqualToString:@""]) {
            [btn setTitle:self->_town forState:UIControlStateNormal];
        }else if (![self->_city isEqualToString:@""]){
            [btn setTitle:self->_city forState:UIControlStateNormal];
        }else if (![self->_province isEqualToString:@""]){
            [btn setTitle:self->_province forState:UIControlStateNormal];
        }
        [weakSelf beginRefesh:ENT_RefreshHeader];
 
       
    };
    view.selectBlock=^(NSInteger index){
          UIButton *btn=[self->_logisticsView viewWithTag:1000];
        btn.selected=NO;
    };
    [self.view addSubview:view];
    
}

-(void)arriverAddress{
     __weak FindCarViewController *weakSelf=self;
    AddressDropView *view=[[AddressDropView alloc]initWithFrame:CGRectMake(0, _logisticsView.bottom, WindowWith, WindowHeight-_logisticsView.bottom)];
    _view2=view;
    view.selectBtnBlock=^(NSString *province,NSString *city,NSString *town,NSString *street){
        self->_province2 = province;
        self->_city2 = city;
        self->_town2 = town;
        UIButton *btn=[self->_logisticsView viewWithTag:1001];
        if (![self->_town2 isEqualToString:@""]) {
            [btn setTitle:self->_town2 forState:UIControlStateNormal];
        }else if (![self->_city2 isEqualToString:@""]){
            [btn setTitle:self->_city2 forState:UIControlStateNormal];
        }else if (![self->_province2 isEqualToString:@""]){
            [btn setTitle:self->_province2 forState:UIControlStateNormal];
        }
  [weakSelf beginRefesh:ENT_RefreshHeader];
    };
    view.selectBlock=^(NSInteger index){
        UIButton *btn=[self->_logisticsView viewWithTag:1001];
        btn.selected=NO;
    };

    [self.view addSubview:view];

    
}




-(void)backTopClick:(UIButton *)sender{
    [self scrollTopPoint:commTableView.table];
}


-(void)loadRefesh:(MJRefreshComponent *)refreshView{
    if (refreshView==commTableView.table.mj_header) {
        page=0;
    }
    
    
    [network selectOwnerOrderList:_province
                           t_city:_city
                           t_area:_town
                       f_province:_province2
                           f_city:_city2
                           f_area:_town2
                       flowCarSelectParamsInfos:_typeArr
                             page:page
                              num:pageNum
                          success:^(NSDictionary *obj) {
        NSArray *arr=obj[@"content"];
                                                        
        
        if (refreshView==self->commTableView.table.mj_header) {
            
            [self->dataArray removeAllObjects];
            self->page=0;
            if (arr.count==0) {
                [self->dataArray addObjectsFromArray:arr];
                [self->commTableView.table reloadData];
            }
            [self->commTableView.table.mj_footer resetNoMoreData];
        }
        
        if (arr.count>0) {
            self->page++;
            if (arr.count<pageNum) {
                [self->commTableView.table.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            [self->commTableView.table.mj_footer endRefreshingWithNoMoreData];
            [self endRefresh];
            return;
        }
        
        [self->dataArray addObjectsFromArray:arr];
        [self->commTableView.table reloadData];
        [self endRefresh];
    } failure:^(NSDictionary *obj2) {
        [self endRefresh];
    }];
    
}






- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat y=scrollView.contentOffset.y;
    
    if (y<=0) {
        [UIView animateWithDuration:0.5f animations:^{
            self->_btn.alpha=1;
        } completion:^(BOOL finished) {
        }];
    }else{
        [UIView animateWithDuration:0.5f animations:^{
            self->_btn.alpha=0;
        } completion:^(BOOL finished) {
        }];
    }
    if (y>_boundHeihgt) {
        [UIView animateWithDuration:0.5f animations:^{
            self->backTopbutton.alpha=1;
            [self.view bringSubviewToFront:self->backTopbutton];
        } completion:^(BOOL finished) {
        }];
    }else{
        [UIView animateWithDuration:0.5f animations:^{
            self->backTopbutton.alpha=0;
            // [self.view bringSubviewToFront:backTopbutton];
        } completion:^(BOOL finished) {
        }];
    }
    
    
}



-(void)BCtableViewCell:(IHTableViewCell *)cell action:(BCTableViewCellAction)action indexPath:(NSIndexPath *)indexPath attribute:(NSObject *)attribute{
    FindCarModel *model=dataArray[indexPath.row];
    _model=model;
    _indexPath=indexPath;
    if (action==MTLianXiActionTableViewCell) {
        [self pushToChatVC:model];
       
    }else if (action==MTPhoneActionTableViewCell){
        
        [self getPhoneweak:model];
        
        
        
    }
    
    
}

-(void)getPhoneweak:(FindCarModel *)model{
    
    
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    
    if (![model.mobile isEqualToString:@""]) {
        NSString *phoneString = [NSString stringWithFormat:@"tel:%@",model.mobile];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:phoneString]]];
        [self.view addSubview:callWebview];
    }else
    {
        [IHUtility addSucessView:@"对方没有留下电话" type:1];
    }
    
}

-(void)pushToChatVC:(FindCarModel *)model{
    
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    
    ChatViewController *vc=[[ChatViewController alloc]initWithChatter:model.hx_user_name conversationType:eConversationTypeChat];
    vc.nickName=model.nickname;
    vc.delelgate=self;
    vc.toUserID=[NSString stringWithFormat:@"%ld",(long)model.user_id];
    vc.HeadimgUrl=[NSString stringWithFormat:@"%@%@%@",ConfigManager.ImageUrl,model.heed_image_url,smallHeaderImage];
    
    [self pushViewController:vc];
    
}




-(void)pushToFaBuVC{
    
    LogisticsFaBuViewController *vc=[[LogisticsFaBuViewController alloc]init];
    [self pushViewController:vc];
}



-(void)home:(id)sender{
    LogisyicsMyFaBuViewController *vc=[[LogisyicsMyFaBuViewController alloc]init];
    [self pushViewController:vc];
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CarDetailViewController *vc=[[CarDetailViewController alloc]init];
    FindCarModel *model=dataArray[indexPath.row];
    vc.Id=model.Id;
    [self pushViewController:vc];
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    FindCarModel *model=dataArray[indexPath.row];
    CGSize size=[IHUtility GetSizeByText:model.remark sizeOfFont:12 width:WindowWith-24-62-13];
    if ([model.remark isEqualToString:@""]) {
        return 174-33-10;
    }
    
    return 174-33+size.height;
}



#pragma mark - ChatViewControllerDelegate

// 根据环信id得到要显示头像路径，如果返回nil，则显示默认头像
- (NSString *)avatarWithChatter:(NSString *)chatter{
    NSString *str=[NSString stringWithFormat:@"%@%@%@",ConfigManager.ImageUrl,_model.heed_image_url,smallHeaderImage];
    NSString *userID=[_model.hx_user_name lowercaseString];
    
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



@end
