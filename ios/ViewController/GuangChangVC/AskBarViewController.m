//
//  AskBarViewController.m
//  MiaoTuProject
//
//  Created by Zmh on 31/10/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "AskBarViewController.h"
#import "AskProblemDetailViewController.h"
//#import "UINavigationBar+Awesome.h"
#import "XHFriendlyLoadingView.h"
#import "InputKeyBoardView.h"
//#import "PTCommentInputView.h"
//#import "ShareSheetView.h"
#import "CustomView+AskBarSubViews.h"
#import "MTOtherInfomationMainViewController.h"
#define scale WindowWith/375.0

@interface AskBarViewController ()<UITableViewDelegate,UIScrollViewDelegate,AgreeAnswerDelegate>
{
    MTBaseTableView *commTableView;
    int page;//已回复数据
    int page2;//未回答数据
    NSMutableArray *replyDataArray;//已回复的数组
    NSArray *_dataArr;
    UIView *_topView;

    UIView *_barImageView;
    UIAsyncImageView *_topImage;
    UIAsyncImageView *_backImg;
    
    SMLabel *_titleBarLbl;//导航栏标题
    SMLabel *_titleLbl;
//    UIScrollView *_ScrollView;//滑动试图
    CGFloat _Alpha;//导航栏透明度
    
    AskBarDetailModel *_detailModel;
    int type;//最新1 最热2
    int netType;//已回复（最新，最热）1 未回复2
    
    UITextField *_pltxt;
    InputKeyBoardView *_keyBoardView;

    ReplyProblemListModel *_model;//点击回复时所在问题的数据模型
    AskQuestionNumView *_sectionView;
    AskQuestionNumView *_firstView;
    
//    UIImageView *_redImageView;//红点
    
    NSIndexPath *_indexPath;//选中忽略问题是的索引
    
}
@end

@implementation AskBarViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNavBarItem:NO];
    searchBtn.hidden = YES;

    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    //如果页面已经存在 pop回当前页面时重新设置导航栏的透明度
    UIImageView *barView = self.navigationController.navigationBar.subviews.firstObject;
    
    UIView *view = [[UIView alloc] initWithFrame:barView.bounds];
    view.backgroundColor = RGBA(247, 248, 250, _Alpha);
    _barImageView = view;
    //导航栏标题
    SMLabel *titleLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(0, 0, WindowWith-120, 15) textColor:cBlackColor textFont:sysFont(16)];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    _titleBarLbl = titleLbl;
    titleLbl.hidden = YES;
    _titleBarLbl.text = self.Title;
    [view addSubview:titleLbl];
    [barView addSubview:view];
    titleLbl.sd_layout.centerXIs(view.width/2.0).centerYIs((view.height -20)/2.0 + 20);
    if (_Alpha>0.5) {
        titleLbl.hidden = NO;
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    UIImage *image = [IHUtility imageWithColor:RGB(247 , 248, 250) andSize:CGSizeMake(_deviceSize.width, 64)];
    
    [self.navigationController.navigationBar setBackgroundImage:image
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = nil;
    
    UIImageView *barView = self.navigationController.navigationBar.subviews.firstObject;
    [barView removeAllSubviews];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    type = 0;
    netType = 1;
    
    
    [self reloadWaitingView];
    
}
#pragma mark网络断开 从新链接
-(void)reloadWaitingView{
    //加载试图
    [self addPushViewWaitingView];
    _HUD.top = -64;
    _HUD.height = WindowHeight + 64;
    
    [network getAskBarDetailWithID:[self.form_id intValue] success:^(NSDictionary *obj) {
        [self removePushViewWaitingView];
        self->_detailModel = obj[@"content"];
         [[NSNotificationCenter defaultCenter]postNotificationName:NotificationSeeQuestion object:nil];
        [self GeartTableView];
       
    } failure:^(NSDictionary *obj2) {
        [self removePushViewWaitingView];
        XHFriendlyLoadingView *v=(XHFriendlyLoadingView*)[self.view viewWithTag:8172];
        [v showReloadViewWithText:reloadText];
    }];
    
}

- (void)GeartTableView
{
    __weak AskBarViewController *weakSelf=self;

    CGFloat height;
    if ([USERMODEL.userID intValue] == _detailModel.user_id) {
        height = kScreenHeight;
    }else {
        height = kScreenHeight - 49;
    }

    UIView *topView = [UIView new];
    topView.backgroundColor = [UIColor whiteColor];
    _topView = topView;
    topView.sd_layout.leftSpaceToView(0,0).topSpaceToView(0,0).widthIs(WindowWith);
    
    UIAsyncImageView *topImage = [[UIAsyncImageView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, 180*scale)];
    [topImage setImageAsyncWithURL:_detailModel.detailed_pic placeholderImage:DefaultImage_logo];
    _topImage = topImage;
    [topView addSubview:topImage];
    
    UIAsyncImageView *backImg = [UIAsyncImageView new];
    [backImg setBackgroundColor:[UIColor colorWithPatternImage:Image(@"back_Image.png")]];
    _backImg = backImg;
    [topImage addSubview:backImg];
    backImg.sd_layout.leftSpaceToView(topImage,0).topSpaceToView(topImage,0).bottomSpaceToView(topImage,0).widthIs(WindowWith);
    
    //顶部图片标题
    SMLabel *titleLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(0, 0, WindowWith-60, 20) textColor:[UIColor whiteColor] textFont:boldFont(16)];
    titleLbl.numberOfLines = 0;
    titleLbl.textAlignment = NSTextAlignmentCenter;
    _titleLbl = titleLbl;
    titleLbl.text =_detailModel.Description;
    [topImage addSubview:titleLbl];
    titleLbl.sd_layout.centerXEqualToView(topImage).centerYEqualToView(topImage).autoHeightRatio(0);
    
    //版主介绍
    ModeratorIntroducedView *introducedView = [ModeratorIntroducedView new];
    introducedView.selectBtnBlock = ^(NSInteger index){
        if (index == SelectheadImageBlock) {
            //点击版主头像
            [weakSelf tapNameHead:stringFormatInt(self->_detailModel.user_id)];
        }else{
            [weakSelf addTableHeardView];
        }
    };
    [topView addSubview:introducedView];
    [introducedView setDataWith:_detailModel];
    introducedView.sd_layout.leftSpaceToView(topView,0).topSpaceToView(topImage,0).widthIs(WindowWith);
    

    AskQuestionNumView *sectionView = [AskQuestionNumView new];
    [sectionView setData:_detailModel];
    _sectionView = sectionView;
    [sectionView.btn1 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [sectionView.btn2 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:sectionView];
    sectionView.sd_layout.leftSpaceToView(topView,0).topSpaceToView(introducedView,0).widthIs(WindowWith).heightIs(43);
    
    [topView setupAutoHeightWithBottomView:sectionView bottomMargin:0];
    
    commTableView=[MTBaseTableView new];
    replyDataArray=[[NSMutableArray alloc]init];

    commTableView.attribute=self;
    commTableView.table.delegate=self;
    [commTableView setupData:replyDataArray index:48];
    [commTableView.table.tableHeaderView layoutIfNeeded];
    commTableView.table.tableHeaderView = topView;
    
    [self CreateBaseRefesh:commTableView type:ENT_RefreshFooter successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefesh:refreshView];
    }];
    [self.view addSubview:commTableView];

    commTableView.sd_layout.leftSpaceToView(self.view,0).topSpaceToView(self.view,-64).widthIs(WindowWith).heightIs(height);
    
    [self addTableHeardView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, 49)];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.bottom = WindowHeight;
    if ([USERMODEL.userID intValue] != _detailModel.user_id) {
        [self.view addSubview:bottomView];
    }
    //加载试图
    [self addPushViewWaitingView];
    _HUD.top = -64;
    _HUD.height = WindowHeight + 64;
    
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
    
    SMLabel *lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(imageView.right + 8, 0, 100, 20) textColor:cGrayLightColor textFont:sysFont(13)];
    lbl.text = @"请输入你的问题";
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
        //需要区分是回复还是提问
        [weakSelf keyBoardBlockWith:str];
    } back:^{
        [weakSelf resignKeyBoard];
    }];
    _keyBoardView.lbl.text = @"提问题";
    _keyBoardView.txtView.placeholder = @"请输入您的问题";
    txt.inputAccessoryView =_keyBoardView;
    
    AskQuestionNumView *firstView = [AskQuestionNumView new];
    [firstView setData:_detailModel];
    firstView.backgroundColor = [UIColor whiteColor];
    firstView.hidden = YES;
    _firstView = firstView;
    [firstView.btn1 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [firstView.btn2 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:firstView];
    firstView.sd_layout.leftSpaceToView(self.view,0).topSpaceToView(self.view,0).widthIs(WindowWith).heightIs(43);
    

    //判断如果是版主进来直接显示未回答的问题
    if ([USERMODEL.userID intValue] == _detailModel.user_id) {
        [self buttonAction:sectionView.btn2];
    }else{
         [self beginRefesh:ENT_RefreshFooter];
    }
    
    
}
- (void)addTableHeardView
{
    [commTableView.table beginUpdates];
    [commTableView.table.tableHeaderView layoutIfNeeded];
    commTableView.table.tableHeaderView = _topView;
    [commTableView.table endUpdates];
}

- (void)keyBoardBlockWith:(NSString *)str
{
    if ([_keyBoardView.lbl.text isEqualToString:@"提问题"]) {
        [self createQuestion:str];
    }else if ([_keyBoardView.lbl.text isEqualToString:@"回复"]){
        [self answerQuestionWith:_model content:str];
    }
    
}
- (void)comment:(UITapGestureRecognizer *)tap
{
    _keyBoardView.txtView.text = nil;
    [self becomeKeyBoard];

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
-(void)createQuestion:(NSString *)content
{
    //提交问题
    [network sendProblemWith:[_detailModel.form_id intValue] title:content success:^(NSDictionary *obj) {
        [self addSucessView:@"问题提交成功" type:1];
        self->_detailModel.questionNum = self->_detailModel.questionNum + 1;
        self->_sectionView.askNumLbl.text = [NSString stringWithFormat:@"%d人提问",self->_detailModel.questionNum];
        [self->_sectionView.askNumLbl setSingleLineAutoResizeWithMaxWidth:100];
        
        self->_firstView.askNumLbl.text = [NSString stringWithFormat:@"%d人提问",self->_detailModel.questionNum];
        [self->_firstView.askNumLbl setSingleLineAutoResizeWithMaxWidth:100];

    } failure:^(NSDictionary *obj2) {
        
    }];
}

- (void)share
{
    [self shareView:ENT_questions object:_detailModel vc:self];
}
- (void)buttonAction:(UIButton *)button
{
    if (button.selected) {
        return;
    }
    button.selected = YES;

    if (button.tag == 101) {
        _sectionView.btn1.selected = YES;
        _sectionView.btn2.selected = NO;

        _firstView.btn1.selected = YES;
        _firstView.btn2.selected = NO;
    }else{
        _sectionView.btn1.selected = NO;
        _sectionView.btn2.selected = YES;
        
        _firstView.btn1.selected = NO;
        _firstView.btn2.selected = YES;
        
    }
    //区分最新与最热
    if ([button.titleLabel.text isEqualToString:@"最新"]) {
        type = 1;
    }else if ([button.titleLabel.text isEqualToString:@"最热"]){
        type = 2;
    }else{
        type = 0;
    }
    
    NSArray *arr = _dataArr;
    NSArray *arr2 = [NSArray arrayWithArray:replyDataArray];
     _dataArr = arr2;
    [replyDataArray removeAllObjects];
    [replyDataArray addObjectsFromArray: arr];
    //区分未回复的 与 已回复
    if ([button.titleLabel.text isEqualToString:@"未回答"]) {
        netType = 2;
        
        commTableView.personType = ENT_Self;
        [commTableView setupData:replyDataArray index:47];
    }else {
        netType = 1;
        [commTableView setupData:replyDataArray index:48];
    }
    
    if (replyDataArray.count<= 0) {
        _firstView.hidden = YES;
        [self beginRefesh:ENT_RefreshFooter];
    }else{
        [commTableView.table reloadData];
    }
}
-(void)loadRefesh:(MJRefreshComponent *)refreshView{
    if (netType == 1) {

        if (replyDataArray.count <= 0) {
            page = 0;
        }
        [network loadReplyProblemList:type forum_topic_id:[_detailModel.form_id intValue] user_id:[USERMODEL.userID intValue] page:page num:10 success:^(NSDictionary *obj) {
            NSArray *arr=obj[@"content"];
            
            if (refreshView==self->commTableView.table.mj_header) {
                
                [self->replyDataArray removeAllObjects];
                self->page=0;
                if (arr.count==0) {
                    [self->replyDataArray addObjectsFromArray:arr];
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
                [self removePushViewWaitingView];
            
                return;
            }
            
            [self->replyDataArray addObjectsFromArray:arr];
            [self->commTableView.table reloadData];
            [self endRefresh];
            [self removePushViewWaitingView];
           
        } failure:^(NSDictionary *obj2) {
            [self endRefresh];
            [self removePushViewWaitingView];
        
        }];
    }else {
        if (replyDataArray.count <= 0) {
            page2 = 0;
        }
        [network loadNoReplyProblemList:[_detailModel.form_id intValue] page:page2 num:10 success:^(NSDictionary *obj) {
            NSArray *arr=obj[@"content"];
            
            if (refreshView==self->commTableView.table.mj_header) {
                
                [self->replyDataArray removeAllObjects];
                self->page2=0;
                if (arr.count==0) {
                    [self->replyDataArray addObjectsFromArray:arr];
                    [self->commTableView.table reloadData];
                }
                
                [self->commTableView.table.mj_footer resetNoMoreData];
            }
            
            if (arr.count>0) {
                self->page2++;
                if (arr.count<pageNum) {
                    [self->commTableView.table.mj_footer endRefreshingWithNoMoreData];
                }
            }else{
                
                [self->commTableView.table.mj_footer endRefreshingWithNoMoreData];
                [self endRefresh];
                [self removePushViewWaitingView];
                return;
            }
            
            [self->replyDataArray addObjectsFromArray:arr];
            [self->commTableView.table reloadData];
            [self endRefresh];
            [self removePushViewWaitingView];
        } failure:^(NSDictionary *obj2) {
            [self endRefresh];
            [self removePushViewWaitingView];
        }];
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
 - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [self cellHeightForIndexPath:indexPath cellContentViewWidth:WindowWith tableView:commTableView.table];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    ReplyProblemListModel *model = replyDataArray[indexPath.row];;
    
    AskProblemDetailViewController *vc = [[AskProblemDetailViewController alloc] init];
    vc.model = model;
    vc.indexPath= indexPath;
    vc.answer_id = stringFormatInt(model.infoModel.question_id);
    vc.delegate = self;
    vc.alpha =_Alpha;
    if (model.infoModel) {
        [self pushViewController:vc];
    }
    
}
-(void)BCtableViewCell:(IHTableViewCell *)cell action:(BCTableViewCellAction)action indexPath:(NSIndexPath *)indexPath attribute:(NSObject *)attribute
{

    ReplyProblemListModel *model= replyDataArray[indexPath.row];;
    
    if (action == MTAgreeActionTableViewCell) {
        NSLog(@"点赞");
        if (!USERMODEL.isLogin) {
            [self prsentToLoginViewController];
            return ;
        }
        [network agreeAnswerWith:[model.infoModel.answer_id intValue] success:^(NSDictionary *obj) {
            model.infoModel.isClick = 1;
            model.infoModel.click_num = model.infoModel.click_num + 1;
            [self addSucessView:@"点赞成功" type:1];
            NSArray *indexArray=[NSArray arrayWithObject:indexPath];
            [self->commTableView.table reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
        } failure:^(NSDictionary *obj2) {
            
        }];
        
    }else if (action == MTCommentActionTableViewCell){
        NSLog(@"评论");
        AskProblemDetailViewController *vc = [[AskProblemDetailViewController alloc] init];
        vc.model = model;
        vc.indexPath= indexPath;
        vc.answer_id = stringFormatInt(model.infoModel.question_id);
        vc.delegate = self;
        vc.alpha =_Alpha;
        [self pushViewController:vc];
    }else if (action == MTShareActionTableViewCell){
        NSLog(@"分享");
        //问题分享
        [self shareView:ENT_Answer object:model vc:self];
        
    }else if (action == MTFavriteActionTableViewCell){
        NSLog(@"未回复搭的点赞");
    }else if (action ==MTActivityFollowBMTableViewCell ){
        NSLog(@"回复");
        
        [self becomeKeyBoard];
        _keyBoardView.lbl.text = @"回复";
        _keyBoardView.txtView.placeholder = @"请输入回复内容";
        _model = model;
        
    }else if (action == MTDeleteActionTableViewCell){
        NSLog(@"忽略");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确认忽略该问题" message:@"" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:@"确定", nil];
        [alert show];
        _model = model;
        _indexPath = indexPath;
    }else if (action == MTHeadViewActionTableViewCell){
        //提问人头像
        [self tapNameHead:stringFormatInt(model.user_id)];
    }else if (action == MTHeadViewActionTableViewCell2){
        //提问人头像
        [self tapNameHead:stringFormatInt(model.infoModel.user_id)];
    }
}
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
//回复详情点赞yu评论回调
- (void)disPlayAgree:(ReplyProblemListModel *)model indexPath:(NSIndexPath *)indexPath
{
    [replyDataArray replaceObjectAtIndex:indexPath.row withObject:model];
    NSArray *indexArray=[NSArray arrayWithObject:indexPath];
    [commTableView.table reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
}
//删除问题回调
- (void)deleteNoReplyQuestion:(ReplyProblemListModel *)model indexPath:(NSIndexPath *)indexPath
{
    [replyDataArray removeObjectAtIndex:indexPath.row];
    [commTableView.table reloadData];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //取消活动报名
    if (buttonIndex == 1) {
      
        [network ignoreQuestionWithID:[_model.reply_id intValue] success:^(NSDictionary *obj) {
            [self addSucessView:@"问题已忽略!" type:1];
            self->_detailModel.questionNum = self->_detailModel.questionNum - 1;
            self->_sectionView.askNumLbl.text = [NSString stringWithFormat:@"%d人提问",self->_detailModel.questionNum];
            [self->_sectionView.askNumLbl setSingleLineAutoResizeWithMaxWidth:100];
            
            self->_firstView.askNumLbl.text = [NSString stringWithFormat:@"%d人提问",self->_detailModel.questionNum];
            [self->_firstView.askNumLbl setSingleLineAutoResizeWithMaxWidth:100];
            
            [self->replyDataArray removeObjectAtIndex:self->_indexPath.row];
            [self->commTableView.table reloadData];
            
        } failure:^(NSDictionary *obj2) {
            
        }];
        

    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)answerQuestionWith:(ReplyProblemListModel *)model content:(NSString *)content
{
    [network replyQuestionWith:[model.reply_id intValue] answer_content:content forum_topic_id:[_detailModel.form_id intValue] success:^(NSDictionary *obj) {
        ReplyProblemListModel *mod = [[ReplyProblemListModel alloc] initWithDictionary:obj[@"content"] error:nil];
        mod.reply_id = [NSString stringWithFormat:@"%@",obj[@"cotent"][@"id"]];
        mod.heed_image_url=[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,mod.heed_image_url];
        
        //回复详情数据
        AnswerInfoModel *infoModel = [[AnswerInfoModel alloc] initWithDictionary:obj[@"content"][@"answerInfo"] error:nil];
        infoModel.answer_id = [NSString stringWithFormat:@"%@",obj[@"content"][@"answerInfo"][@"id"]];
        infoModel.heed_image_url=[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,infoModel.heed_image_url];
        mod.infoModel = infoModel;
        
        if (self->_dataArr.count >0) {
            NSMutableArray *array = [NSMutableArray arrayWithArray:self->_dataArr];
            [array insertObject:mod atIndex:0];
            NSArray *arr = [NSArray arrayWithArray:array];
            self->_dataArr = arr;
        }
        [self addSucessView:@"回复成功!" type:1];
        [self->replyDataArray removeObject:model];
        [self->commTableView.table reloadData];
        
        self->_detailModel.answerNum = self->_detailModel.answerNum + 1;
        self->_sectionView.replyNumLbl.text = [NSString stringWithFormat:@"%d回复",self->_detailModel.answerNum];
        [self->_sectionView.replyNumLbl setSingleLineAutoResizeWithMaxWidth:100];
        
        self->_firstView.replyNumLbl.text = [NSString stringWithFormat:@"%d回复",self->_detailModel.answerNum];
        [self->_firstView.replyNumLbl setSingleLineAutoResizeWithMaxWidth:100];
        
        
    } failure:^(NSDictionary *obj2) {
        
    }];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

        CGFloat y = scrollView.contentOffset.y;
    
        //改变导航栏透明度
        CGFloat alpha = y / _topImage.height;
        _Alpha = alpha;
        _barImageView.backgroundColor = RGBA(247, 248, 250, alpha);
        if (alpha > 0.5) {
            _titleBarLbl.hidden = NO;
        }else {
            _titleBarLbl.hidden = YES;
            if (alpha<=0 ) {
                _barImageView.backgroundColor = [UIColor clearColor];
            }
        }
    
        if (y>0) {
            //设置图片的大小位置
            _topImage.height = 180*scale;
            _topImage.top = 0;
            if (y >= _topView.height -43 - 64) {
                if (replyDataArray.count>0) {
                    _firstView.hidden = NO;
                }
            }else {
               _firstView.hidden = YES;
            }
        }else {
            //设置图片的大小位置
            _topImage.height = 180*scale + fabs(y);
            _topImage.top = y;
        }
        _titleLbl.centerX = _topImage.width/2.0;
        _titleLbl.centerY = _topImage.height/2.0;
}

@end
