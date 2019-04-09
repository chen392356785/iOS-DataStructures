//
//  MTTopicListViewController.m
//  MiaoTuProject
//
//  Created by Mac on 16/3/22.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTTopicListViewController.h"
//#import "AdView.h"
#import "MTOtherInfomationMainViewController.h"
//#import "MTTopicDetailsViewController.h"
#import "YLWebViewController.h"
//#import "MTNetworkData+ForModel.h"
#import "CreatTopicViewController.h"
#import "GongQiuDetailsViewController.h"
//#import "UINavigationBar+Awesome.h"
@interface MTTopicListViewController ()<UITableViewDelegate>
{
    MTBaseTableView *commTableView;
    int page;
    NSMutableArray *dataArray;
    UIButton *_createBtn;
}
@end

@implementation MTTopicListViewController
@synthesize themeMod;
-(void)pushVC:(NSDictionary *)dic type:(int)type{
    [self removeWaitingView];
    if (type==3) {
        
        MTTopicListModel *mod=[network getTopicModelForDic:dic];
        
        MTTopicDetailsViewController *vc=[[MTTopicDetailsViewController alloc]init];
        vc.model=mod;
        [self pushViewController:vc];
        
        
    }else{
        int type2 = 0;
        if (type == 1) {
            type2=IH_QuerySupplyList;
        }else if (type == 2){
            type2 = IH_QueryBuyList;
        }
        
        MTSupplyAndBuyListModel *mod=[network getSupplyAndBuyForDic:dic type:type2];
        GongQiuDetailsViewController *vc=[[GongQiuDetailsViewController alloc]init];
        vc.model=mod;
        if (type==1) {
            vc.type=ENT_Supply;
        }else if (type==2){
            vc.type=ENT_Buy;
        }
        [self pushViewController:vc];
    }
}

-(void)addTopic:(MTTopicListModel *)mod{
    
    [dataArray insertObject:mod atIndex:0];
    [commTableView.table reloadData];
}

-(void)weakPushWebVC:(NSDictionary *)dic{
    __weak MTTopicListViewController* weakSelf=self;
    int type=[dic[@"model"]intValue];
    if (type==0) {    //网页链接
        
        YLWebViewController *vc=[[YLWebViewController alloc]init];
        vc.mUrl=[NSURL URLWithString:dic[@"activities_content"]];
        vc.NameTitle=@"链接";
        [self pushViewController:vc];
    }else if (type==1){  // 供应
        [network getSupplyDetailID:USERMODEL.userID supply_id:stringFormatString(dic[@"businessid"])  success:^(NSDictionary *obj) {
            NSDictionary *dic=obj[@"content"];
            [weakSelf pushVC:dic type:1];
            
        } failure:^(NSDictionary *obj2) {
            
        }];
    }else if (type==2){  // 话题
        [network getTopicDetailID:USERMODEL.userID topic_id:stringFormatString(dic[@"businessid"]) success:^(NSDictionary *obj) {
            NSDictionary *dic=obj[@"content"];
            [weakSelf pushVC:dic type:3];
            
        } failure:^(NSDictionary *obj2) {
            
        }];
    }else if (type==3){  //求购
        
        [network getBuyDetailID:USERMODEL.userID want_buy_id:stringFormatString(dic[@"businessid"]) success:^(NSDictionary *obj) {
            NSDictionary *dic=obj[@"content"];
            [weakSelf pushVC:dic type:2];
            
        } failure:^(NSDictionary *obj2) {
            
        }];
    }
}


-(UIView *)setTopView{
    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 300)];
    topView.tag=1001;
    topView.backgroundColor=RGB(236, 238, 238);
    UIAsyncImageView *topImageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(0, 10, WindowWith, WindowWith/2)];
    [topImageView setImageAsyncWithURL:themeMod.content_url  placeholderImage:DefaultImage_logo];
    [topView addSubview:topImageView];
    
    
    SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(25,topImageView.bottom+10, WindowWith-50, 153) textColor:[IHUtility colorWithHexString:@"#666666"] textFont:sysFont(15)];
    lbl.numberOfLines=0;
    NSString *str=themeMod.theme_content;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:str];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:5];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,str.length)];
    lbl.attributedText=attributedString;
    
    [topView addSubview:lbl];
    
    CGSize size=[lbl sizeThatFits:CGSizeMake(WindowWith-50, CGFLOAT_MAX)];
    CGRect rect=lbl.frame;
    rect.size.height=size.height;
    lbl.frame=rect;
    
    rect=topView.frame;
    rect.size.height=lbl.bottom+17;
    topView.frame=rect;
    
    return topView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak MTTopicListViewController *weakSelf=self;
    
    [self setTitle:themeMod.theme_header];
    if (!self.themeMod) {
        [self setTitle:@"热门话题"];
    }
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight) tableviewStyle:UITableViewStylePlain];
    
    dataArray=[[NSMutableArray alloc]init];
    if (self.themeMod) {
        commTableView.table.tableHeaderView=[self setTopView];
    }
    
    commTableView.type=self.type;
    commTableView.attribute=self;
    
    //    NSArray *array=[IHUtility getUserdefalutsList:kTopicDefaultUserList];
    //    for (NSDictionary *dic in array) {
    //        MTTopicListModel *model=[network getTopicModelForDic:dic];
    //        [dataArray addObject:model];
    //    }
    commTableView.table.delegate=self;
    [commTableView setupData:dataArray index:4];
    [self.view addSubview:commTableView];
    
    UIButton* createBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    createBtn.frame=CGRectMake(WindowWith/2-80/2, WindowHeight-60, 80, 40) ;
    [createBtn setTitle:@"发  布" forState:UIControlStateNormal];
    _createBtn=createBtn;
    [createBtn setLayerMasksCornerRadius:20 BorderWidth:0.1 borderColor:cGreenColor];
    [createBtn setBackgroundColor:cGreenColor];
    createBtn.titleLabel.font=sysFont(15);
    [createBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [createBtn addTarget:self action:@selector(createBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:createBtn];
    
    
    [self CreateBaseRefesh:commTableView type:ENT_RefreshAll successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefesh:refreshView];
    }];
    page=1;
    //   [self refreshTableViewLoading:commTableView data:dataArray dateType:kTopicUserDate];
    [self beginRefesh:ENT_RefreshHeader];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(noticitionAddSupplyAndBuy:) name:NotificationAddSupplyBuyTopic object:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    CGFloat y=scrollView.contentOffset.y;
    
    if (y<=0) {
        [UIView animateWithDuration:0.5f animations:^{
            self->_createBtn.alpha=1;
        } completion:^(BOOL finished) {
        }];
    }else{
        [UIView animateWithDuration:0.5f animations:^{
            self->_createBtn.alpha=0;
        } completion:^(BOOL finished) {
        }];
    }
    if (y>_boundHeihgt) {
        [UIView animateWithDuration:0.5f animations:^{
           self-> backTopbutton.alpha=1;
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

- (void)scrollViewDidEndDecelerating:(MTBaseTableView *)scrollView
{
    [UIView animateWithDuration:0.5 animations:^{
        self->_createBtn.alpha=1;
    }];
}

-(void)noticitionAddSupplyAndBuy:(NSNotification *)notificaiton{
    NSDictionary *dic=[notificaiton object];
    int type=[dic[@"type"]intValue];
    NSDictionary *contentDic=[dic objectForKey:@"content"];
    if (type==3) { //供应
        MTTopicListModel *mod2=[network getTopicModelForDic:contentDic];
        [dataArray insertObject:mod2 atIndex:0];
        [commTableView.table reloadData];
    }
}

-(void)createBtnClick:(UIButton *)sender{
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    
    CreatTopicViewController * create=[[CreatTopicViewController alloc]init];
    create.theme_Id=themeMod.theme_id;
    create.themeName=themeMod.theme_header;
    [self presentViewController:create];
}

-(void)backTopClick:(UIButton *)sender{
    [self scrollTopPoint:commTableView.table];
}

-(void)loadRefesh:(MJRefreshComponent *)refreshView{
    if (refreshView==commTableView.table.mj_header) {
        page=0;
    }
    int userID=0;
    if (USERMODEL.isLogin) {
        userID=[USERMODEL.userID intValue];
    }
    
    [network getTopicList:page maxResults:pageNum userID:userID  isHot:self.isHot my_user_id:0 theme_id:[themeMod.theme_id intValue] success:^(NSDictionary *obj) {
        NSArray *arr=obj[@"content"];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:NotificationSeeTopic object:nil];
        if (refreshView==self->commTableView.table.mj_header) {
            
            [self->dataArray removeAllObjects];
            self->page=0;
            if (arr.count==0) {
                [self->dataArray addObjectsFromArray:arr];
                [self->commTableView.table reloadData];
            }
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    // GongQiuListTableViewCell *cell;
    MTTopicListModel *model=[dataArray objectAtIndex:indexPath.row];
    if (self.type==ENT_Preson) {
        return [model.cellHeigh floatValue]-60;
    }
    else if (self.type==ENT_topic){
        
        return [model.cellHeigh floatValue];
    }
    return 516;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MTTopicListModel *model=[dataArray objectAtIndex:indexPath.row];
    
    [network updateTopicLookersUser:[model.topic_id intValue]success:^(NSDictionary *obj) {
        MTTopicDetailsViewController *controller=[[MTTopicDetailsViewController alloc]init];
        controller.model=model;
        controller.delegate = self;
        controller.indexPath = indexPath;
        controller.topicTitle = self->themeMod.theme_header;
        controller.subTitle = self.themeMod.theme_content;
        [self pushViewController:controller];
    }];
}

-(void)headWork:(MTTopicListModel *)model
{
    [network selectUserCloudInfoById:[USERMODEL.userID intValue]follow_id:[model.userChildrenInfo.user_id intValue]success:^(NSDictionary *obj) {
        
        MTOtherInfomationMainViewController *controller=[[MTOtherInfomationMainViewController alloc]initWithUserID:model.userChildrenInfo.user_id :NO dic:obj[@"content"]];
        controller.userMod=model.userChildrenInfo;
        controller.dic=obj[@"content"];
        [self pushViewController:controller];
    } failure:^(NSDictionary *obj2) {
        
    }];
}


#pragma mark cell分支点击事件
-(void)BCtableViewCell:(IHTableViewCell *)cell action:(BCTableViewCellAction)action indexPath:(NSIndexPath *)indexPath attribute:(NSObject *)attribute{
    MTTopicListModel *model=dataArray[indexPath.row];
    
    __weak MTTopicListViewController *weakSelf = self;
    if (action==MTHeadViewActionTableViewCell) {
        NSLog(@"点击头像");
        
        [self headWork:model];
        
    }else if (action==MTAgreeActionTableViewCell){
        
        if (!USERMODEL.isLogin) {
            [self prsentToLoginViewController];
            return ;
        }
        
        MTTopicListModel *mod= (MTTopicListModel*)attribute;
        [network getTopicAddLike:USERMODEL.userID topic_id:mod.topic_id success:^(NSDictionary *obj) {
            
            MTTopicListModel *mod2=[self->dataArray objectAtIndex:indexPath.row];
            int num=mod2.clickLikeTotal;
            mod2.hasClickLike=YES;
            mod2.clickLikeTotal=num+1;
            NSArray *indexArray=[NSArray arrayWithObject:indexPath];
            [self->commTableView.table reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
            [self addSucessView:@"点赞成功!" type:1];
            
        } failure:^(NSDictionary *obj2) {
            
        }];
        
    }else if (action == MTCommentActionTableViewCell){
        
        if (!USERMODEL.isLogin) {
            [self prsentToLoginViewController];
            return ;
        }
        [weakSelf detail:model isComment:YES indexPath:indexPath];
    }
}

-(void)detail:(MTTopicListModel *)model isComment:(BOOL)isComment indexPath:(NSIndexPath *)indexPath
{
    MTTopicDetailsViewController *vc=[[MTTopicDetailsViewController alloc]init];
    vc.model=model;
    vc.isBeginComment=isComment;
    vc.indexPath=indexPath;
    vc.delegate=self;
    vc.topicTitle = themeMod.theme_header;
    vc.subTitle = self.themeMod.theme_content;
    [self pushViewController:vc];
}
- (void)disPlayTopicAgree:(MTTopicListModel *)model indexPath:(NSIndexPath *)indexPath
{
    MTTopicListModel *mod=[dataArray objectAtIndex:indexPath.row];
    mod.hasClickLike=YES;
    
    NSArray *indexArray=[NSArray arrayWithObject:indexPath];
    [commTableView.table reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
    
}
- (void)disPlayTopicComment:(MTTopicListModel *)model indexPath:(NSIndexPath *)indexPath
{
//    MTTopicListModel *mod=[dataArray objectAtIndex:indexPath.row];
	
    NSArray *indexArray=[NSArray arrayWithObject:indexPath];
    [commTableView.table reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
