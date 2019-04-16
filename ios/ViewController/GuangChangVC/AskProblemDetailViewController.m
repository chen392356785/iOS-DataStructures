//
//  AskProblemDetailViewController.m
//  MiaoTuProject
//
//  Created by Zmh on 31/10/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "AskProblemDetailViewController.h"
#import "InputKeyBoardView.h"
#import "XHFriendlyLoadingView.h"
#import "CustomView+AskBarSubViews.h"
#import "MTOtherInfomationMainViewController.h"

@interface AskProblemDetailViewController ()<UITableViewDelegate,UIScrollViewDelegate>
{
    MTBaseTableView *commTableView;
    int page;
    NSMutableArray *dataArray;
    UIView *_topView;
    
//    UIView *_sectionView;
    UIView *_firstView;
    
    UITextField *_pltxt;
    InputKeyBoardView *_keyBoardView;
    AskBarContentView *_contentView;
    
    SMLabel *_lbl;
}
@end

@implementation AskProblemDetailViewController
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"回复详情"];
    

    [self reloadWaitingView];
}
#pragma mark网络断开 从新链接
-(void)reloadWaitingView{
    //加载试图
    [self addPushViewWaitingView];
    NSString *userId;
    if (USERMODEL.userID) {
        userId = USERMODEL.userID;
    }else{
        userId = @"0";
    }
    [network loadAnswerCommentList:[self.answer_id intValue] user_id:[userId intValue] page:0 num:10 success:^(NSDictionary *obj) {
        self.model = obj[@"question"];
        [self GreatTableView];
        [self removePushViewWaitingView];
        
    } failure:^(NSDictionary *obj2) {
        [self removePushViewWaitingView];
        XHFriendlyLoadingView *v=(XHFriendlyLoadingView*)[self.view viewWithTag:8172];
        [v showReloadViewWithText:reloadText];
    }];
    
}
- (void)GreatTableView
{
    __weak AskProblemDetailViewController *weakSelf = self;
    _BaseScrollView.delegate = self;
    
    UIView *topView = [UIView new];
    topView.backgroundColor = [UIColor whiteColor];
    _topView = topView;
    topView.sd_layout.leftSpaceToView(0,0).topSpaceToView(0,0).widthIs(WindowWith);
    
    AskBarContentView *contentView = [AskBarContentView new];
    [contentView setData:self.model];
    _contentView = contentView;
    contentView.commentBtn.hidden = YES;

    if (!self.model.infoModel) {
        _contentView.deleteBtn.hidden = NO;
    }
    contentView.selectBtnBlock = ^(NSInteger index){
        if (index == agreeBlock) {
            if (!USERMODEL.isLogin) {
                [weakSelf prsentToLoginViewController];
                return ;
            }
            [weakSelf agreeAnswer];
        }else if (index == shareBlock){
            [weakSelf shareView:ENT_Answer object:weakSelf.model vc:weakSelf];
        }else if (index == closeBlock){
            
            if (!USERMODEL.isLogin) {
                [weakSelf prsentToLoginViewController];
                return ;
            }
            [weakSelf deleteQuestion];
            
        }else if (index == SelectheadImageBlock){
            //提问人头像
            [weakSelf tapNameHead:stringFormatInt(self.model.user_id)];
        }else if (index == SelectTopViewBlock){
            //回答人头像
            [weakSelf tapNameHead:stringFormatInt(self.model.infoModel.user_id)];
        }
    };
    
    [topView addSubview:contentView];
    
    contentView.sd_layout.leftSpaceToView(topView,0).topSpaceToView(topView,0).widthIs(WindowWith);
    
    UIView *sectionView = [UIView new];
    sectionView.backgroundColor = RGB(247, 248, 250);
//    _sectionView = sectionView;
    [topView addSubview:sectionView];
    sectionView.sd_layout.leftSpaceToView(0,0).topSpaceToView(contentView,0).widthIs(WindowWith).heightIs(43);
    
    SMLabel *lbl = [SMLabel new];
    lbl.text = @"网友评论";
    _lbl = lbl;
    lbl.textColor = cGreenColor;
    lbl.font = sysFont(14);
    [sectionView addSubview:lbl];
    lbl.sd_layout.leftSpaceToView(sectionView,13).topSpaceToView(sectionView,16).heightIs(20).autoHeightRatio(0);
    [lbl setSingleLineAutoResizeWithMaxWidth:100];
    
    [_topView setupAutoHeightWithBottomView:sectionView bottomMargin:0];
    
    commTableView=[MTBaseTableView new];
    dataArray=[[NSMutableArray alloc]init];
    commTableView.personType = ENT_Other;
    commTableView.attribute=self;
    commTableView.table.delegate=self;
    [commTableView setupData:dataArray index:47];
    [commTableView.table.tableHeaderView layoutIfNeeded];
    commTableView.table.tableHeaderView = topView;
    
    [self CreateBaseRefesh:commTableView type:ENT_RefreshFooter successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefesh:refreshView];
    }];
    [self.view addSubview:commTableView];
    [self beginRefesh:ENT_RefreshFooter];
    [self addPushViewWaitingView];
    
    
    commTableView.sd_layout.leftSpaceToView(self.view,0).topSpaceToView(self.view,0).widthIs(WindowWith).heightIs(WindowHeight -49);
    
    [self addTableHeardView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, 49)];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.bottom = WindowHeight;
    [self.view addSubview:bottomView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, 1)];
    lineView.backgroundColor = cLineColor;
    [bottomView addSubview:lineView];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(25, 4.5, WindowWith - 50, 40)];
    backView.layer.cornerRadius = 24;
    backView.layer.borderColor = cLineColor.CGColor;
    backView.layer.borderWidth = 1;
    [bottomView addSubview:backView];
    
    UIImage *image = Image(@"write_image.png");
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(11.5, 0, image.size.width, image.size.height)];
    imageView.centerY=backView.height/2.0;
    imageView.image = image;
    [backView addSubview:imageView];
    
    lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(imageView.right + 8, 0, 100, 20) textColor:cGrayLightColor textFont:sysFont(13)];
    lbl.text = @"回复";
    lbl.centerY = backView.height/2.0;
    [backView addSubview:lbl];
    
    UITapGestureRecognizer *commTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(comment:)];
    commTap.numberOfTapsRequired= 1;
    commTap.numberOfTouchesRequired= 1;
    [bottomView addGestureRecognizer:commTap];
    
    UITextField *txt=[[UITextField alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 0)];
    _pltxt=txt;
    [self.view addSubview:txt];
    _keyBoardView=[[InputKeyBoardView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight)  submit:^(NSString *str) {
        [weakSelf createComment:str];
    } back:^{
        [weakSelf resignKeyBoard];
    }];
    _keyBoardView.lbl.text = @"回复";
    _keyBoardView.txtView.placeholder = @"请输入您的回复内容";
    txt.inputAccessoryView =_keyBoardView;
    
    UIView *firstView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, 41)];
    firstView.backgroundColor = RGB(247, 248, 250);
    _firstView = firstView;
    firstView.hidden = YES;
    [self.view addSubview:firstView];
    firstView.sd_layout.leftSpaceToView(self.view,0).topSpaceToView(self.view,0).widthIs(WindowWith).heightIs(43);
    
    SMLabel *lbl2 = [SMLabel new];
    lbl2.text = @"网友评论";
    lbl2.textColor = cGreenColor;
    lbl2.font = sysFont(14);
    [firstView addSubview:lbl2];
    lbl2.sd_layout.leftSpaceToView(firstView,13).topSpaceToView(firstView,16).heightIs(20).autoHeightRatio(0);
    [lbl2 setSingleLineAutoResizeWithMaxWidth:100];
}
- (void)addTableHeardView
{
    [commTableView.table beginUpdates];
    [commTableView.table.tableHeaderView layoutIfNeeded];
    commTableView.table.tableHeaderView = _topView;
    [commTableView.table endUpdates];
}
- (void)comment:(UITapGestureRecognizer *)tap
{
    _keyBoardView.txtView.text = nil;
    [self becomeKeyBoard];
}
- (void)deleteQuestion
{
    [network deleteNoReplyQuestion:[self.model.reply_id intValue] success:^(NSDictionary *obj) {
        
        if ([self.delegate respondsToSelector:@selector(deleteNoReplyQuestion:indexPath:)]) {
            [self.delegate deleteNoReplyQuestion:self.model indexPath:self.indexPath];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSDictionary *obj2) {
        
    }];
}
-(void)becomeKeyBoard{
    
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    
    //    self.isReply=NO;
    [_pltxt becomeFirstResponder];
    [_keyBoardView.txtView becomeFirstResponder];
}
-(void)resignKeyBoard{
    [_keyBoardView.txtView resignFirstResponder];
    [_pltxt resignFirstResponder];
}
//点击头像
-(void)tapNameHead:(NSString *)userId{
    [self addWaitingView];
    [network selectUseerInfoForId:[userId intValue]
                          success:^(NSDictionary *obj) {
                              MTNearUserModel *mod=[[MTNearUserModel alloc]initWithDictionary:obj[@"content"] error:nil];
                              UserChildrenInfo *usermodel=[[UserChildrenInfo alloc]initWithModel:mod];
                              [network selectUserCloudInfoById:[USERMODEL.userID intValue]follow_id:[userId intValue]success:^(NSDictionary *obj) {
                                  [self removeWaitingView];
                                  MTOtherInfomationMainViewController *controller=[[MTOtherInfomationMainViewController alloc]initWithUserID:userId :NO dic:obj[@"content"]];
                                  controller.userMod=usermodel;
                                  controller.dic=obj[@"content"];
                                  [self pushViewController:controller];
                              } failure:^(NSDictionary *obj2) {
                                  
                              }];
                              
                              
                              
                          } failure:^(NSDictionary *obj2) {
                              
                          }];
    
    
}

-(void)createComment:(NSString *)content
{
    [network addAnswerComment:[self.model.infoModel.answer_id intValue] comment_content:content province:@"" success:^(NSDictionary *obj) {
        
        [self addSucessView:@"评论成功!" type:1];
        [self beginRefesh:ENT_RefreshFooter];
        
        self.model.infoModel.replayNum =  self.model.infoModel.replayNum + 1;
        [self.delegate disPlayAgree:self.model indexPath:self.indexPath];
    } failure:^(NSDictionary *obj2) {
        
    }];
}
- (void)agreeAnswer
{
    [network agreeAnswerWith:[self.model.infoModel.answer_id intValue] success:^(NSDictionary *obj) {
        self.model.infoModel.isClick = 1;
        self.model.infoModel.click_num = self.model.infoModel.click_num + 1;
        [self addSucessView:@"点赞成功" type:1];
        [self->_contentView setData:self.model];
        [self.delegate disPlayAgree:self.model indexPath:self.indexPath];
        
    } failure:^(NSDictionary *obj2) {
        
    }];
}
-(void)loadRefesh:(MJRefreshComponent *)refreshView{
    if (dataArray.count <= 0) {
        page=0;
    }

    NSString *userId;
    if (USERMODEL.userID) {
        userId = USERMODEL.userID;
    }else{
        userId = @"0";
    }
    [network loadAnswerCommentList:[self.answer_id intValue] user_id:[userId intValue] page:page num:10 success:^(NSDictionary *obj) {
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
            
            if (self->dataArray.count <= 0) {
                self->_lbl.hidden = YES;
            }
            [self removePushViewWaitingView];
            [self->commTableView.table.mj_footer endRefreshingWithNoMoreData];
            [self endRefresh];

            return;
            
        }
        self->_lbl.hidden = NO;
        [self->dataArray addObjectsFromArray:arr];
        [self->commTableView.table reloadData];
        [self endRefresh];
        
        [self removePushViewWaitingView];
    } failure:^(NSDictionary *obj2) {
        [self endRefresh];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self cellHeightForIndexPath:indexPath cellContentViewWidth:WindowWith tableView:commTableView.table];
}

-(void)BCtableViewCell:(IHTableViewCell *)cell action:(BCTableViewCellAction)action indexPath:(NSIndexPath *)indexPath attribute:(NSObject *)attribute
{
    AnswerCommentListModel *model = dataArray[indexPath.row];
    if (action == MTFavriteActionTableViewCell) {
        NSLog(@"点赞");
        if (!USERMODEL.isLogin) {
            [self prsentToLoginViewController];
            return ;
        }
        [network agreeCommentWith:[model.comment_id intValue] success:^(NSDictionary *obj) {
            model.isClick = 1;
            model.clickNum = model.clickNum + 1;
            [self addSucessView:@"点赞成功" type:1];
            NSArray *indexArray=[NSArray arrayWithObject:indexPath];
            [self->commTableView.table reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
        } failure:^(NSDictionary *obj2) {
            
        }];
    }else if ( action == MTHeadViewActionTableViewCell){
        [self tapNameHead:stringFormatInt(model.user_id)];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat y = scrollView.contentOffset.y;

    if (y>0) {
        //当滑动试图滑到最顶端是开始滑动表视图
        if (y >= _topView.height -43) {
            if (dataArray.count >0) {
                _firstView.hidden = NO;
            }
            
        }else {
            _firstView.hidden = YES;
        }
    }
}

@end
