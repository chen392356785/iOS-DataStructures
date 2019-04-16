//
//  EPCloudCommentListViewController.m
//  MiaoTuProject
//
//  Created by Zmh on 6/7/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "CustomView+CustomCategory2.h"
#import "EPCloudCommentListViewController.h"

@interface EPCloudCommentListViewController ()<UITableViewDelegate>
{
    MTBaseTableView *commTableView;
    int page;
    NSMutableArray *dataArray;
//    NSIndexPath *_indexPath;
    EPCloudCommentView *_commentView;
    EPCloudCommentListTopView *_topview;
}

@end

@implementation EPCloudCommentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"评价"];
    backTopbutton.hidden = YES;
    
    [self creatTableView];
    
}
-(void)creatTableView
{
    self.view.backgroundColor = cLineColor;
    
    UIView *view  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, 200)];
    view.backgroundColor = cLineColor;
    
    EPCloudCommentListTopView *topview  = [[EPCloudCommentListTopView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, 100)];
    [topview setData:self.model];
    _topview = topview;
    [view addSubview:topview];
    
    UIView *downView=[[UIView alloc]initWithFrame:CGRectMake(0, topview.bottom + 6, WindowWith, 37)];
    downView.backgroundColor=[UIColor whiteColor];
//    _downView = downView;
    
    UIImage *img = Image(@"comment.png");
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(12, 0, img.size.width, img.size.height)];
    imageV.image = img;
    imageV.centerY = downView.height/2.0;
    [downView addSubview:imageV];
    
    CGSize size=[IHUtility GetSizeByText:@"所有评论" sizeOfFont:15 width:100];
    SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageV.right + 6.5,0, size.width, 36) textColor:RGBA(135, 134, 140, 1) textFont:sysFont(15)];
    lbl.text=@"所有评论";
    [downView addSubview:lbl];
    
    UIView *lineView2=[[UIView alloc]initWithFrame:CGRectMake(12, 35, WindowWith - 24, 0.5)];
    lineView2.backgroundColor=cLineColor;
    [downView addSubview:lineView2];
    [view addSubview:downView];
    view.height = downView.bottom;
    [self.view addSubview:view];
    
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, view.bottom, WindowWith, WindowHeight - 49 - view.height) tableviewStyle:UITableViewStylePlain];
    
    dataArray=[[NSMutableArray alloc]init];
    
    commTableView.attribute=self;
    commTableView.table.delegate=self;
    commTableView.table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [commTableView setupData:dataArray index:30];
    
    __weak EPCloudCommentListViewController *weakSelf=self;
    
    [self CreateBaseRefesh:commTableView type:ENT_RefreshAll successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefesh:refreshView];
    }];
    [self.view addSubview:commTableView];
    [self beginRefesh:ENT_RefreshHeader];
    
    EPCloudCommentView *commentView = [[EPCloudCommentView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, kScreenHeight)];
    commentView.alpha =0;
    _commentView = commentView;
    
//    __weak EPCloudCommentView *weakView = commentView;
    commentView.selectBlock = ^(NSString *score,NSString *content){
        
        if (commentView.textView.text.length<=0 || [commentView.textView.text isEqualToString:@"写下对它的印象吧，对他人帮助很大哦..."]) {
            [weakSelf addSucessView:@"请输入评价内容" type:2];
            return ;
        }
        
        if (commentView.ratingImage.rating == 0) {
            [weakSelf addSucessView:@"请评论星级" type:2];
            return ;
        }

        [weakSelf createComment:content];

    };
    
    NSArray *titlArr = @[@"我要评价"];
    NSArray *imageArr = @[@"hi.png"];
    EPCloudListBottonView *bottomView = [[EPCloudListBottonView alloc] initWithFrame:CGRectMake(0, WindowHeight-49, WindowWith, 49) btnTitle:titlArr images:imageArr];
    bottomView.selectBlock = ^(NSInteger index){
        //加入企业云
        
        if (!USERMODEL.isLogin) {
            [weakSelf prsentToLoginViewController];
            return;
        }
        [weakSelf.view.window addSubview:commentView];
        [UIView animateWithDuration:1 animations:^{
            commentView.alpha = 1;
        } completion:^(BOOL finished) {
        }];
    };
    [self.view addSubview:bottomView];
    
}

-(void)loadRefesh:(MJRefreshComponent *)refreshView{
    if (refreshView==commTableView.table.mj_header) {
        page=0;
    }
    
    NSString *userID;
    if (!USERMODEL.isLogin) {
        userID = @"0";
    }else
    {
        userID = USERMODEL.userID;
    }
    [network getCompanyCommentList:(int)self.model.company_id page:page num:10 success:^(NSDictionary *obj) {
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
-(void)createComment:(NSString *)content{
    
    __weak typeof(self) weakSelf = self;
    
    [self addWaitingView]; 
    
    
    [network addCompanyComment:USERMODEL.userID companyId:(int)self.model.company_id content:content anonymous:_commentView.btn.selected level:_commentView.ratingImage.rating success:^(NSDictionary *obj) {
        [UIView animateWithDuration:1 animations:^{
            self->_commentView.alpha = 0;
        } completion:^(BOOL finished) {
            [self->_commentView removeFromSuperview];
        }];
        [weakSelf addComment:obj[@"content"]];
    } failure:^(NSDictionary *obj2) {
        
    }];
    
    
}


-(void)addComment:(NSDictionary *)commentDic{
    companyListModel *mod=[[companyListModel alloc]initWithDictionary:commentDic error:nil];
    CGSize size=[IHUtility GetSizeByText:mod.comment_content sizeOfFont:14 width:WindowWith-75];
    mod.heed_image_url = USERMODEL.userHeadImge40;
    mod.nickname = USERMODEL.userName;
    mod.cellHeigh=[NSNumber numberWithFloat:65+size.height];
    [dataArray insertObject:mod atIndex:0];
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
    [commTableView.table insertRowsAtIndexPaths:[NSArray arrayWithObject:path] withRowAnimation:UITableViewRowAnimationAutomatic];
    self.model.comment_num++;
    [_topview setData:self.model];
    [self.delegate disPalyCommentNum:self.model];
    [self addSucessView:@"评论成功" type:1];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    companyListModel *model = dataArray[indexPath.row];
    return [model.cellHeigh floatValue];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

//    EPCloudDetailViewController *detailVC =[[EPCloudDetailViewController alloc]init];
//    [self pushViewController:detailVC];
}



@end
