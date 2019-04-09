//
//  InvitedViewController.m
//  MiaoTuProject
//
//  Created by Zmh on 13/7/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "InvitedViewController.h"

@interface InvitedViewController ()<UITableViewDelegate>
{
    MTBaseTableView *commTableView;
    int page;
    NSMutableArray *dataArray;
    NSIndexPath *_indexPath;
    UIView *_headerView;
    SMLabel *_titlelbl;
    ShareView *_shareView;
    UIView *_downView;
    UIView *_topview;
    UIView *_imageView ;
}
@end

@implementation InvitedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setTitle:@"推荐给好友"];
	self.view.backgroundColor = [UIColor whiteColor];
	page= 0;
	[self creatTableView];
}

-(void)creatTableView
{
    __weak InvitedViewController *weakSelf = self;
    
    [self setbackTopFrame:backBtnY];
    ShareView *shareView=[[ShareView alloc]initWithIsFriendFrame:CGRectMake(0, 0, WindowWith, 0.85*WindowWith)];
    _shareView = shareView;
    
    shareView.selectBtnBlock=^(NSInteger index){
        
        [weakSelf ShareApp:index];
    };
    
    UIView *topview =[[UIView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, shareView.centerView.height + 6)];
    topview.backgroundColor = [UIColor whiteColor];
    _topview = topview;
    [topview addSubview:shareView];
    
    UIView *downView=[[UIView alloc]initWithFrame:CGRectMake(0, shareView.bottom, WindowWith, 45)];
    downView.backgroundColor=[UIColor whiteColor];
    _downView = downView;
    
    UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, 5)];
    lineV.backgroundColor = cLineColor;
    [downView addSubview:lineV];
    
    UIImage *img = Image(@"yaoqingNum.png");
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(12, 0, img.size.width, img.size.height)];
    imageV.image = img;
    imageV.centerY = (downView.height -5)/2.0 +5;
    [downView addSubview:imageV];
    
    SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageV.right + 6.5,5, WindowWith-imageV.right - 15, 39) textColor:RGBA(135, 134, 140, 1) textFont:sysFont(14)];
    lbl.text=@"已邀请0人注册，累计获得0元奖励";
    _titlelbl = lbl;
    [downView addSubview:lbl];
    
    lineV = [[UIView alloc] initWithFrame:CGRectMake(12, 44, WindowWith - 24, 1)];
    lineV.backgroundColor = cLineColor;
    [downView addSubview:lineV];
    [topview addSubview:downView];
    
    NSArray *arr = @[@"用户",@"时间",@"状态",@"奖金"];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, downView.bottom, WindowWith, 30)];
    headerView.backgroundColor = [UIColor whiteColor];
    _headerView = headerView;
    for (int i=0; i<arr.count; i++) {
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(50 +(WindowWith -50)/5.0*i, 0, (WindowWith-50)/5.0, 30) textColor:RGBA(135, 134, 140, 1) textFont:sysFont(14)];
        lbl.text = arr[i];
        if (i== 0) {
            lbl.width = (WindowWith-50)/5.0 * 2;
        }else {
            lbl.left = 50 +(WindowWith -50)/5.0*(i+1);
        }
        lbl.textAlignment = NSTextAlignmentCenter;
        [headerView addSubview:lbl];
    }
    topview.height = headerView.bottom;
    [topview addSubview:headerView];
    
    
    UIImage *image = Image(@"Invated_friends.png");
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, image.size.height+30)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 30, image.size.width, image.size.height)];
    imageView.image = image;
    imageView.centerX = WindowWith/2.0;
    [view addSubview:imageView];
    _imageView = view;
    
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight) tableviewStyle:UITableViewStylePlain];
    
    dataArray=[[NSMutableArray alloc]init];
    
    commTableView.attribute=self;
    commTableView.table.delegate=self;
    [commTableView setupData:dataArray index:31];
    commTableView.backgroundColor = [UIColor whiteColor];
    commTableView.table.tableHeaderView = topview;
    
    [self CreateBaseRefesh:commTableView type:ENT_RefreshFooter successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefesh:refreshView];
    }];
    [self.view addSubview:commTableView];
    [self beginRefesh:ENT_RefreshFooter];
}

-(void)backTopClick:(UIButton *)sender{
    [self scrollTopPoint:commTableView.table];
}

-(void)loadRefesh:(MJRefreshComponent *)refreshView{
    if (refreshView==commTableView.table.mj_header) {
        page=0;
    }
    [self addWaitingView];
    
    NSString *userID;
    if (!USERMODEL.isLogin) {
        userID = @"0";
    }else
    {
        userID = USERMODEL.userID;
    }
    [network getInvatedFriends:userID page:page num:10 success:^(NSDictionary *obj) {
        NSArray *arr=obj[@"content"];
        NSString *totalNum = [NSString stringWithFormat:@"%@",obj[@"totalNum"]];
        NSString *totalMoney = [NSString stringWithFormat:@"%@",obj[@"totalMoney"]];
        NSString *descStr = [NSString stringWithFormat:@"%@",obj[@"active_desc"]];
        [self setText:totalNum totalMon:totalMoney desc:descStr];
        
        [self removeWaitingView];
        
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
            if (self->dataArray.count == 0) {
                
                self->commTableView.table.tableFooterView = self->_imageView;
            }
            [self endRefresh];
            return;
        }
        
        [self->dataArray addObjectsFromArray:arr];
        [self->commTableView.table reloadData];
        
        if (self->dataArray.count == 0) {
            
            self->commTableView.table.tableFooterView = self->_imageView;
        }
        
        [self endRefresh];
        
    } failure:^(NSDictionary *obj2) {
        [self endRefresh];
    }];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}
- (void)setText:(NSString *)totalNum totalMon:(NSString *)totalMoney desc:(NSString *)desc
{
    if ([totalNum isEqualToString:@""]) {
        totalNum = @"0";
    }
    if ([totalMoney isEqualToString:@""]) {
        totalMoney = @"0";
    }
    _titlelbl.text = [NSString stringWithFormat:@"已邀请了%@人，累计获得%@元奖励",totalNum,totalMoney];
    NSMutableAttributedString *str = [IHUtility changePartTextColor:_titlelbl.text range:NSMakeRange(4,totalNum.length+1) value:RGB(245, 166, 35)];
    [str addAttribute:NSForegroundColorAttributeName value:RGB(245, 166, 35) range:NSMakeRange(_titlelbl.text.length - 3 - totalMoney.length,totalMoney.length+1)];
    _titlelbl.attributedText = str;
    
    [_shareView setdata:desc];
    _downView.top = _shareView.bottom;
    _headerView.top = _downView.bottom;
    _topview.height = _headerView.bottom;
    commTableView.table.tableHeaderView = _topview;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)BCtableViewCell:(IHTableViewCell *)cell action:(BCTableViewCellAction)action indexPath:(NSIndexPath *)indexPath attribute:(NSObject *)attribute{
    
    //拨打电话
    InvatedFriendslistModel *model = dataArray[indexPath.row];
    [self getPhoneweak:model];
}
-(void)getPhoneweak:(InvatedFriendslistModel *)model{
    
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    
    if (![model.user_name isEqualToString:@""]) {
        NSString *phoneString = [NSString stringWithFormat:@"tel:%@",model.user_name];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:phoneString]]];
        [self.view addSubview:callWebview];
    }else
    {
        [IHUtility addSucessView:@"对方没有留下电话" type:1];
    }
}
- (void)back:(id)sender
{
    if ([self.type isEqualToString:@"1"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
