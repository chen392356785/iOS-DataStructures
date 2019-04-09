//
//  MTContactTableViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/3/24.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTContactTableViewController.h"
#import "MTOtherInfomationMainViewController.h"
#import "EditPersonInformationViewController.h"
@interface MTContactTableViewController()<UITableViewDelegate>
{
    MTBaseTableView *commTableView;
    int page;
    NSMutableArray *dataArray;
    float lastContentOffset;
    IHTextField *_textField;
    NSString *_nickname;
    UIImageView *_imageView;
}
@end
@implementation MTContactTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    dataArray=[[NSMutableArray alloc]init];
    [self creatTableView];
    self.view.backgroundColor=RGB(240, 240, 240);
    if (self.type!=ENT_new) {
        _nickname=@"";
        UIImageView *imageView=[[UIImageView alloc]initWithImage:[ConfigManager createImageWithColor:RGB(232, 121, 117)]];
        imageView.frame=CGRectMake(0, 0, WindowWith, 40);
        CGSize size=[IHUtility GetSizeByText:@"完善个人资料可推荐至人脉表单" sizeOfFont:15 width:WindowWith];
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, 0, size.width, 15) textColor:[UIColor whiteColor] textFont:sysFont(15)];
        lbl.text=@"完善个人资料可推荐至人脉表单";
        lbl.center=imageView.center;
        [imageView addSubview:lbl];
        
        UIImage *img=Image(@"xx.png");
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
        
        btn.frame=CGRectMake(WindowWith-40, 0, img.size.width, img.size.height);
        btn.centerY=imageView.centerY;
        [btn addTarget:self action:@selector(hideView) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:btn];
        
        UITapGestureRecognizer *Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideTopView)];
        _imageView=imageView;
        imageView.userInteractionEnabled=YES;
        [imageView addGestureRecognizer:Tap];
        [self.view addSubview:imageView];
        commTableView.hidden=NO;
        
    }else
    {
        commTableView.hidden=YES;
        commTableView.frame=CGRectMake(0, 40, WindowWith, WindowHeight-40);
        
        _textField=[[IHTextField alloc]initWithFrame:CGRectMake(10, 10, WindowWith-20, 28)];
        _textField.borderStyle=UITextBorderStyleNone;
        _textField.backgroundColor=[UIColor whiteColor];
        _textField.layer.cornerRadius=15;
        _textField.font = sysFont(12);
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 28)];
        view.backgroundColor=[UIColor whiteColor];
        _textField.leftView=view;
        _textField.leftViewMode=UITextFieldViewModeAlways;
        _textField.placeholder=@"搜索昵称／公司";
        _textField.font = sysFont(12);
        [self.view addSubview:_textField];
        UIImage *img=Image(@"search buttom.png");
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
        btn.frame=CGRectMake(_textField.right-img.size.width, 10, img.size.width, img.size.height);
        
        [btn addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        _textField.clearButtonMode=UITextFieldViewModeNever;
    }
    // Do any additional setup after loading the view.
}

-(void)hideTopView
{
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    _imageView.hidden=YES;
    commTableView.frame=CGRectMake(0, 0, WindowWith, WindowHeight);
    EditPersonInformationViewController *vc=[[EditPersonInformationViewController alloc]init];
    [self.inviteParentController pushViewController:vc];
    
}

-(void)hideView
{
    _imageView.hidden=YES;
    commTableView.frame=CGRectMake(0, 0, WindowWith, WindowHeight);
}

-(void)search
{
    self.order=0;
    _nickname=_textField.text;
    [dataArray removeAllObjects];
    [commTableView.table reloadData];
    [self beginRefesh:ENT_RefreshHeader];
    commTableView.hidden=NO;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setHomeTabBarHidden:NO];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    lastContentOffset = scrollView.contentOffset.y;
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    if (lastContentOffset < scrollView.contentOffset.y) {
        [self setHomeTabBarHidden:YES];
    }else{
        [self setHomeTabBarHidden:NO];
    }
}

-(void)creatTableView
{
    
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, 40, WindowWith, WindowHeight-40) tableviewStyle:UITableViewStylePlain];
    commTableView.type2=self.type;
    commTableView.table.delegate=self;
    commTableView.attribute=self;
    [commTableView setupData:dataArray index:5];
    
    [self.view addSubview:commTableView];
    __weak MTContactTableViewController *weakSelf = self;
    [self CreateBaseRefesh:commTableView type:ENT_RefreshAll successRefesh:^(MJRefreshComponent *refreshView) {
        if (refreshView==self->commTableView.table.mj_header) {
            self->page=0;
        }
        [network getQueryUserByList:self.order
                                num:pageNum
                               page:self->page
                           latitude:USERMODEL.latitude
                          longitude:USERMODEL.longitude
                           nickname:self->_nickname
                            version:@"2"
                            success:^(NSDictionary *obj) {
                                NSLog(@"%f-----%f",USERMODEL.latitude,USERMODEL.longitude);
                                
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
                                    [self->commTableView.table.mj_footer endRefreshingWithNoMoreData];
                                    [self endRefresh];
                                    return ;
                                }
                                
                                [self->dataArray addObjectsFromArray:arr];
                                
                                [self->commTableView.table reloadData];
                                [weakSelf endRefresh];
                            } failure:^(NSDictionary *obj2) {
                                [weakSelf endRefresh];
                            }];
        
    }];
    [self setbackTopFrame:backBtnY-30];
    [self beginRefesh:ENT_RefreshHeader]; //进行下拉刷新
    
}

-(void)backTopClick:(UIButton *)sender{
    [self scrollTopPoint:commTableView.table];
}

#pragma mark cell分支点击事件
-(void)BCtableViewCell:(IHTableViewCell *)cell action:(BCTableViewCellAction)action indexPath:(NSIndexPath *)indexPath attribute:(NSObject *)attribute{
    if (action==MTHeadViewActionTableViewCell) {
        NSLog(@"点击头像");
    }
}

-(void)headwork:(MTNearUserModel *)model
{
    [self removeWaitingView];
    UserChildrenInfo *userModel=[[UserChildrenInfo alloc]initWithModel:model];
    [network selectUserCloudInfoById:[USERMODEL.userID intValue]follow_id:[userModel.user_id intValue]success:^(NSDictionary *obj) {
        
        MTOtherInfomationMainViewController *controller=[[MTOtherInfomationMainViewController alloc]initWithUserID:userModel.user_id :NO dic:obj[@"content"]];
        controller.userMod=userModel;
        controller.dic=obj[@"content"];
        [self.inviteParentController pushViewController:controller];
    } failure:^(NSDictionary *obj2) {
        
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MTNearUserModel *model=dataArray[indexPath.row];
    
    [self headwork:model];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 0.3*WindowWith+10;
}

@end
