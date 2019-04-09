//
//  MTNewSupplyAndBuyViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/7/20.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTNewSupplyAndBuyViewController.h"
#import "MTNewSupplyAndBuyDetailsViewController.h"
#import "MTOtherInfomationMainViewController.h"
#import "SDTimeLineCell.h"
#import "MJPopView.h"
//#import "SDTimeLineCellModel.h"
#import "PTCommentInputView.h"

//#import "GongQiuAgreeDelegate.h"
//#import "GongQiuCommentDelegate.h"

#import "YLWebViewController.h"
//#import "UITableView+SDAutoTableViewCellHeight.h"
//#import "UIView+SDAutoLayout.h"
#define kTimeLineTableViewCellId @"SDTimeLineCell"

#import "CreateBuyOrSupplyViewController.h"     //发布求购  供应
//#import "CreateBuyOrSupplyViewController.h"     //发布求购  供应

#import "FaBuBuyViewController.h"               //发布求购
#import "AddMiaoBiView.h"                       //增加苗途币数

#import "MiaoBiInfoViewController.h"            //加入VIP


@interface MTNewSupplyAndBuyViewController ()<UITableViewDelegate,UITableViewDataSource,SDTimeLineCellDelegate,HJCActionSheetDelegate,CommentDelegate,BCBaseTableViewCellDelegate,GongQiuAgreeDelegate,GongQiuCommentDelegate>
{
	MTBaseTableView *commTableView;
	int page;
	float lastContentOffset;
	int type ;
	UIButton *_createQGBtn;   //发布求购
	UIButton *_createGYBtn;   //发布供应
	UIView *joinVipBackgView; //
}

@property (nonatomic, strong) PTCommentInputView *inputView;;
@property (nonatomic, assign) BOOL isReplayingComment;
@property (nonatomic, strong) NSIndexPath *currentEditingIndexthPath;
@property (nonatomic, copy) NSString *commentToUser;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *dataArray;
@property(nonatomic,strong)SDTimeLineCellCommentItemModel *commod;

@end

@implementation MTNewSupplyAndBuyViewController

{
    CGFloat _lastScrollViewOffsetY;
    PTCommentInputView *_inputView;
    CGFloat _totalKeybordHeight;
    NSIndexPath *_currentEditingIndexthPath;
    NSIndexPath *_selIndexPath;
    NSString *_nickName;
    SearchView *_searchV;
    BOOL _delete;
    NSString *urlStr;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setHomeTabBarHidden:NO];
    
    if (USERMODEL.isDue == 0) {
        rightbutton.hidden = YES;
        leftbutton.hidden = YES;
        joinVipBackgView.hidden = NO;
    }else {
        joinVipBackgView.hidden = YES;
        rightbutton.hidden=NO;
        leftbutton.hidden=NO;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    lastContentOffset = scrollView.contentOffset.y;
    [_inputView.inputTextView resignFirstResponder];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
//  滚动列表隐藏底部tabbar
//    if (lastContentOffset < scrollView.contentOffset.y) {
//        [self setHomeTabBarHidden:YES];
//    }else{
//        [self setHomeTabBarHidden:NO];
//    }
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"供求大厅"];
    
    [self createOrAddSubView];
    
    [self.view setBackgroundColor:cBgColor];
    
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    [self getVipUrl];       //获取url
    
    joinVipBackgView = [self createBackgroundView];
    joinVipBackgView.hidden = YES;
    [self.view addSubview:joinVipBackgView];
    if (USERMODEL.isDue == 0) {
        rightbutton.hidden = YES;
        leftbutton.hidden = YES;
        joinVipBackgView.hidden = NO;
    }else {
        [self refreshTableViewLoading2:self.tableView data:self.dataArray dateType:kSupplyAndBuyUserDate];
        rightbutton.hidden=NO;
        leftbutton.hidden=NO;
    }
    
}

- (void) getVipUrl {
	
    NSDictionary *dict = @{
                           @"user_id" :  USERMODEL.userID
                           };
    [network httpRequestWithParameter:dict method:gongqiuInitUrl success:^(NSDictionary *obj) {
		
        NSDictionary *dict = obj[@"content"];
		if ([dict isKindOfClass:[NSDictionary class]]) {
			self->urlStr = dict[@"vipUrl"];
			USERMODEL.isDue = [dict[@"isVip"] intValue];
			if (USERMODEL.isDue == 0) {
				self->rightbutton.hidden = YES;
				self->leftbutton.hidden = YES;
				self->joinVipBackgView.hidden = NO;
			} else {
				self->joinVipBackgView.hidden = YES;
				self->rightbutton.hidden=NO;
				self->leftbutton.hidden=NO;
			}
		} else { ///请求结果失败情况下 处理
			self->rightbutton.hidden = YES;
			self->leftbutton.hidden = YES;
			self->joinVipBackgView.hidden = NO;
		}
		
    } failure:^(NSDictionary *obj) {
        
    }];
}

- (void) createOrAddSubView {
    _nickName=@"";
    type=0;
    id array = [IHUtility getUserdefalutsList:kSupplyAndBuyDefaultUserList];
    
    if([array isKindOfClass:[NSArray class]]){
        for (NSDictionary *dic in array) {
            MTNewSupplyAndBuyListModel*model=[network getNewSupplyAndBuyModel:dic];
            [self.dataArray addObject:model];
        }
    }
    
    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,WindowWith , 6)];
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight - KtopHeitht) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.tableHeaderView=topView;
    self.tableView.backgroundColor=cBgColor;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.dataSource=self;
    [self.tableView registerClass:[SDTimeLineCell class] forCellReuseIdentifier:kTimeLineTableViewCellId];
    [self.view addSubview:self.tableView];
    
    self.tableView.mj_header = [MiaoTuHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRefreshData:)];
    self.tableView.mj_footer = [MiaoTuFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadRefreshData:)];
    
    //    [self refreshTableViewLoading2:self.tableView data:self.dataArray dateType:kSupplyAndBuyUserDate];
    
    //    [self setLeftButtonImage:Image(@"gq_shaixuan.png") forState:UIControlStateNormal];
    [self setLeftButtonImage:Image(@"shaixuan.png") forState:UIControlStateNormal];
    //    [leftbutton setTitle:@"筛选" forState:UIControlStateNormal];
    leftbutton.titleLabel.font=boldFont(14);
    [leftbutton setTitleColor:cGreenColor forState:UIControlStateNormal];
    leftbutton.frame=CGRectMake(0, 0, 60, 44);
    leftbutton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    rightbutton.hidden=NO;
    
    [self setRightButtonImage:[Image(@"h_sousuo.png") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self setupTextField];
    [self setbackTopFrame:backBtnY];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(noticitionAddSupplyAndBuy:) name:NotificationAddSupplyBuyTopic object:nil];   //发布成功以后直接填充数据
    
    [self createfabuBut];   //创建发布Button点击事件
    
}

#pragma mark - 添加发布供求求购事件
- (void) createfabuBut {
    UIButton* createBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    createBtn.frame=CGRectMake(WindowWith-kWidth(70), WindowHeight - 149 - KTabBarHeight, kWidth(54), kWidth(54)) ;
    [createBtn setTitle:@"发布\n求购" forState:UIControlStateNormal];
    createBtn.titleLabel.numberOfLines = 0;
    createBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [createBtn addTarget:self action:@selector(releaseGQAction:) forControlEvents:UIControlEventTouchUpInside];
    _createQGBtn=createBtn;
    [createBtn setLayerMasksCornerRadius:createBtn.height/2 BorderWidth:0.1 borderColor:cGreenColor];
    [createBtn setBackgroundColor:cGreenColor];
    createBtn.titleLabel.font=sysFont(14);
    [createBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:createBtn];
    
    createBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    createBtn.frame=CGRectMake(minX(_createQGBtn), maxY(_createQGBtn) + kWidth(15), width(_createQGBtn), height(_createQGBtn)) ;
    [createBtn setTitle:@"发布\n供应" forState:UIControlStateNormal];
    createBtn.titleLabel.numberOfLines = 0;
    createBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [createBtn addTarget:self action:@selector(releaseGQAction:) forControlEvents:UIControlEventTouchUpInside];
    _createGYBtn=createBtn;
    [createBtn setLayerMasksCornerRadius:createBtn.height/2 BorderWidth:0.1 borderColor:cGreenColor];
    [createBtn setBackgroundColor:cGreenColor];
    createBtn.titleLabel.font=sysFont(14);
    [createBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:createBtn];
}
//发布求购
- (void) releaseGQAction:(UIButton *)but {
    NSDictionary *dic=[IHUtility getUserDefalutsDicKey:kUserDefalutLoginInfo];
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    if ([dic[@"mobile"] isEqualToString:@""]) {
        [self showLoginViewWithType:ENT_Lagin];
        return;
    }
    WS(weakSelf);
    if (but == _createQGBtn) {
        DLog(@"发布求购");
        FaBuBuyViewController *v=[[FaBuBuyViewController alloc]init];
        v.type = ENT_Buy;
        [self presentViewController:v];
        v.updataTable = ^{
            [weakSelf.tableView.mj_header beginRefreshing];
        };
    }else {
        DLog(@"发布供应");
        FaBuBuyViewController *v = [[FaBuBuyViewController alloc]init];
        v.type = ENT_Supply;
        [self presentViewController:v];
        v.updataTable = ^{
            [weakSelf.tableView.mj_header beginRefreshing];
        };
//        CreateBuyOrSupplyViewController *v=[[CreateBuyOrSupplyViewController alloc]init];
//        v.type=ENT_Supply;
//        [self presentViewController:v];
    }
    
}


-(void)noticitionAddSupplyAndBuy:(NSNotification *)notificaiton{  //发布成功，马上更新列表
    
    NSDictionary *dic=[notificaiton object];
    int type2=[dic[@"type"]intValue];
    NSDictionary *contentDic=[dic objectForKey:@"content"];
    if (type2==1) { //供应
        
        MTSupplyAndBuyListModel *mod=[network getSupplyAndBuyForDic:contentDic type:IH_QuerySupplyList];
        //[dataArray insertObject:mod atIndex:0];
        MTNewSupplyAndBuyListModel *model=[network getNewSupplyAndBuyForOld:mod type:1];
        [self.dataArray insertObject:model atIndex:0];
        
        [self.tableView reloadData];
        
    }else if (type2==2) {
        MTSupplyAndBuyListModel *mod=[network getSupplyAndBuyForDic:contentDic type:IH_QueryBuyList];
        // [self.dataArray insertObject:mod atIndex:0];
        MTNewSupplyAndBuyListModel *model=[network getNewSupplyAndBuyForOld:mod type:2];
        [self.dataArray insertObject:model atIndex:0];
        [self.tableView reloadData];
        
    }
    
    NSString *numStr = [dic objectForKey:@"errorContent"];
    if (numStr != nil) {
//        [self popAddMiaoBiNumViewNumMiaoB:numStr];
    }
}


#pragma mark - 弹出发布成功
- (void) popAddMiaoBiNumViewNumMiaoB:(NSString *)numStr {       //榜单分类
    AddMiaoBiView * MiaoBiView = [[AddMiaoBiView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight)];
    [MiaoBiView setAddNumMiaoBi:numStr];
    [self showPopupWithStyle:CNPPopupStyleCentered popupView:MiaoBiView];
    WS(weakSelf);
    MiaoBiView.cancelBack = ^{
        [weakSelf dismissPopupController];
    };
}
#pragma mark - 界面弹出框
- (void)showPopupWithStyle:(CNPPopupStyle)popupStyle popupView:(UIView *)popupView {
    self.popupViewController = [[CNPPopupController alloc] initWithContents:@[popupView]];
    self.popupViewController.theme = [CNPPopupTheme defaultTheme:popupView.frame.size.width];
    self.popupViewController.theme.popupStyle = popupStyle;
    self.popupViewController.theme.presentationStyle = CNPPopupPresentationStyleFadeIn;
    [self.popupViewController presentPopupControllerAnimated:YES];
}
- (void)dismissPopupController {
    [self.popupViewController dismissPopupControllerAnimated:YES];
}


-(void)home:(id)sender {
    
    SearchView *searchV = [[SearchView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, 44)];
    //  searchV.backgroundColor = self.navigationController.navigationBar.backgroundColor;
    _searchV = searchV;
    searchV.textfiled.placeholder=@"请输入品种名";
    __weak SearchView *searchSelf = searchV;
    searchV.selectBtnBlock = ^(NSInteger index){
        if (index == SelectBackVC) {
            if (self->_nickName.length > 0) {
                self->_nickName = @"";
                //刷新列表
                [self.tableView.mj_header beginRefreshing];
            }
            
            [searchSelf removeFromSuperview];
            self->rightbutton.hidden = NO;
            
        }else if (index == SelectBtnBlock){
            self->_nickName = searchSelf.textfiled.text;
            //刷新列表
            [self.tableView.mj_header beginRefreshing];
        }
        
    };
    [searchV.textfiled becomeFirstResponder];
    [self.navigationController.navigationBar addSubview:searchV];
    rightbutton.hidden = YES;
    
}

-(void)back:(UIButton*)sender{
    
    MJPopView *popView=[[MJPopView alloc]initWithOrgin:sender.bottom+KStatusBarHeight - 20 + 8 x:9 arr:@[@"全部",@"只看供应",@"只看求购",@"我关注的"] i:4 img:Image(@"popbg.png")];
    
    popView.selectBlock=^(NSInteger index){
        self->type=(int)index;
        
        if (index==3) {
            if (!USERMODEL.isLogin) {
                [self prsentToLoginViewController];
                return ;
            }
        }
        
        [self.tableView.mj_header beginRefreshing];
    };
    [self.view addSubview:popView];
}

-(void)loadRefreshData:(MJRefreshComponent *)refreshView{
    
    if (refreshView==self.tableView.mj_header) {
        page=0;
    }
    [network selectSupplyAndWantByList:_nickName page:page num:20 operator_type:type success:^
     (NSDictionary *obj) {
         
         NSArray *arr=obj[@"content"];
         if (refreshView==self.tableView.mj_header) {
             [self.dataArray removeAllObjects];
             
             if (arr.count==0) {
                 [self.dataArray addObjectsFromArray:arr];
                 [self.tableView reloadData];
             }
             
         }
         
         if (arr.count>0) {
             self->page++;
             if (arr.count<pageNum) {
                 [self.tableView.mj_footer endRefreshingWithNoMoreData];
             }
         }else{
             [self.tableView.mj_footer endRefreshingWithNoMoreData];
             [self endRefresh];
             return ;
         }
         
         [self.dataArray addObjectsFromArray:arr];
         [self.tableView reloadData];
         [self endRefresh];
         
     } failure:^(NSDictionary *obj2) {
         [self endRefresh];
     }];
    
}

-(void)endRefresh{
    if([self.tableView.mj_header isRefreshing])
    {
        [self.tableView.mj_header endRefreshing];
    }else if ([self.tableView.mj_footer isRefreshing]){
        [self.tableView.mj_footer endRefreshing];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_inputView.inputTextView resignFirstResponder];
    [_searchV removeFromSuperview];
}

- (void)dealloc
{
    
    [_inputView.inputTextView removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupTextField
{
    _inputView = [[PTCommentInputView alloc]initWithFrame:CGRectMake(0, WindowHeight, WindowWith, 35)];
    _inputView.delegate=self;
    [self.view addSubview:_inputView];
    
    [_inputView.inputTextView becomeFirstResponder];
    [_inputView.inputTextView resignFirstResponder];
}

-(void)backTopClick:(UIButton *)sender{
    [self scrollTopPoint:self.tableView];
    [self setHomeTabBarHidden:NO];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath2
{
    SDTimeLineCell *cell = [tableView dequeueReusableCellWithIdentifier:kTimeLineTableViewCellId];
    cell.indexPath = indexPath2;
    cell.delegate=self;
    __weak typeof(self) weakSelf = self;
    if (!cell.moreButtonClickedBlock) {
        [cell setMoreButtonClickedBlock:^(NSIndexPath *indexPath) {
            //  MTNewSupplyAndBuyListModel *model = weakSelf.dataArray[indexPath.row];
            //  model.isOpening = !model.isOpening;
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }];
        
        [cell setDidClickCommentLabelBlock:^(SDTimeLineCellCommentItemModel *mod, CGRect rectInWindow, NSIndexPath *indexPath,NSIndexPath *commIndexPath) {
            
            if (!USERMODEL.isLogin) {
                [weakSelf prsentToLoginViewController];
                return ;
            }
            
            weakSelf.currentEditingIndexthPath = commIndexPath;  //评论列表
            
            weakSelf.commod=mod;
            
            weakSelf.commentToUser = mod.nickname;
            self->_selIndexPath=indexPath;     //当前某行
            if ([mod.user_id isEqualToString:USERMODEL.userID]) {
                [weakSelf showDeleteView];
                return ;
            }
            weakSelf.isReplayingComment = YES;
            weakSelf.inputView.inputTextView.placeholder = [NSString stringWithFormat:@"  回复：%@", mod.nickname];
            
            [weakSelf.inputView.inputTextView becomeFirstResponder];
            
            [weakSelf adjustTableViewToFitKeyboardWithRect:rectInWindow];
        }];
        
        cell.Delegate1 = self;
    }
    
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    [cell useCellFrameCacheWithIndexPath:indexPath2 tableView:tableView];
    
    ///////////////////////////////////////////////////////////////////////
    
    cell.model = self.dataArray[indexPath2.row];
    return cell;
}

#pragma mark 删除自己发的评论
-(void)showDeleteView {
    
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    
    [_inputView.inputTextView resignFirstResponder];
    HJCActionSheet *sheet = [[HJCActionSheet alloc] initWithDelegate:self CancelTitle:@"取消" OtherTitles:@"删除这条评论", nil];
    // 2.显示出来
    [sheet show];
}

//删除评论
-(void)deleteComment:(MTNewSupplyAndBuyListModel *)model  comMod:(SDTimeLineCellCommentItemModel *)comMod{
    
    // SDTimeLineCellCommentItemModel *comMod=[model.commentInfos objectAtIndex:_currentEditingIndexthPath.row];
    if (comMod.comment_id.length!=0) {
        if ([model.type intValue]==1) {  //删除供应 评论
            [network getDeleteSupplyCommentID:[comMod.comment_id intValue] userID:USERMODEL.userID success:^(NSDictionary *obj) {
                
            }];
        }else if ([model.type intValue] ==2){
            [network getDeleteBuyCommentID:[comMod.comment_id intValue] userID:USERMODEL.userID success:^(NSDictionary *obj) {
                
            }];
        }
    }
    
    NSMutableArray *temp = [NSMutableArray new];
    [temp addObjectsFromArray:model.commentInfos];
    if (_delete) {
        [temp removeObject:comMod];
    }else
    {
        for (NSInteger i=0; i<temp.count; i++) {
            SDTimeLineCellCommentItemModel *obj=temp[i];
            if ([obj.comment_id isEqualToString:comMod.comment_id]) {
                [temp removeObject:obj];
            }
        }
    }
    model.commentInfos = [temp copy];
}

- (void)actionSheet:(HJCActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    MTNewSupplyAndBuyListModel *model = self.dataArray[_selIndexPath.row];
    
    
    SDTimeLineCellCommentItemModel *comMod=[model.commentInfos objectAtIndex:_currentEditingIndexthPath.row];
    
    _delete=YES;
    
    
    [self deleteComment:model comMod:comMod];
    
    [self.tableView reloadRowsAtIndexPaths:@[_selIndexPath] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)headwork:(MTNewSupplyAndBuyListModel *)model
{
    [self addWaitingView];
    [network selectUseerInfoForId:[model.userInfo.user_id intValue]
                          success:^(NSDictionary *obj) {
                              MTNearUserModel *mod=[[MTNearUserModel alloc]initWithDictionary:obj[@"content"] error:nil];
                              UserChildrenInfo *usermodel=[[UserChildrenInfo alloc]initWithModel:mod];
                              [network selectUserCloudInfoById:[USERMODEL.userID intValue]follow_id:[usermodel.user_id intValue]success:^(NSDictionary *obj) {
                                  [self removeWaitingView];
                                  MTOtherInfomationMainViewController *controller=[[MTOtherInfomationMainViewController alloc]initWithUserID:usermodel.user_id :NO dic:obj[@"content"]];
                                  controller.userMod=usermodel;
                                  controller.dic=obj[@"content"];
                                  [self pushViewController:controller];
                              } failure:^(NSDictionary *obj2) {
                                  
                              }];
                          } failure:^(NSDictionary *obj2) {
                              
                          }];
}

-(void) BCtableViewCell:(IHTableViewCell *)cell action:(BCTableViewCellAction)action indexPath:(NSIndexPath *)indexPath attribute:(NSObject *)attribute {
    
    MTNewSupplyAndBuyListModel *model=_dataArray[indexPath.row];
    if (action==MTHeadViewActionTableViewCell) {
        NSLog(@"%@",model);
        [self headwork:model];
    }else if (action==MTActionClickUserNameTableViewCellAction){
        NSString *UserID=(NSString *)attribute;
        NSLog(@"userID=%@",UserID);
        [self tapNameHead:UserID];
        
    }else if (action==MTActionClickUserURlTableViewCellAction){
        NSString *url=(NSString *)attribute;
        YLWebViewController *controller=[[YLWebViewController alloc]init];
        controller.type=1;
        controller.mUrl=[NSURL URLWithString:url];
        [self pushViewController:controller];
    }else if (action==MTMLLinkPhoneCellAction){
        NSString *url=(NSString *)attribute;
        NSString *phoneString = [NSString stringWithFormat:@"tel:%@",url];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:phoneString]]];
        [self.view addSubview:callWebview];
    }
}

-(void)tapNameHead:(NSString *)userId {
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_inputView.inputTextView resignFirstResponder];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([_inputView.inputTextView resignFirstResponder]) {
        [_inputView.inputTextView resignFirstResponder];
        return;
    }
    
    //    SDTimeLineCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    //
    //    if (cell.operationMenu.show==YES){
    //        cell.operationMenu.show=NO;
    //        return;
    //    }
    
    MTNewSupplyAndBuyListModel *model=_dataArray[indexPath.row];
    MTNewSupplyAndBuyDetailsViewController *vc=[[MTNewSupplyAndBuyDetailsViewController alloc]init];
    
    _selIndexPath=indexPath;
    SDTimeLineCell *cell=[self.tableView cellForRowAtIndexPath:indexPath];
    vc.selectDeleteBlock=^(MTSupplyAndBuyListModel *model ,NSIndexPath *indexPath){
        
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
        
    };
    
    if ([model.type isEqualToString:@"1"]) {
        vc.type=ENT_Supply;
    }else if ([model.type isEqualToString:@"2"]){
        vc.type=ENT_Buy;
    }
    vc.newsId=model.news_id;
    vc.userId=model.userInfo.user_id;
    vc.model=model;
    vc.cell=cell;
    vc.indexPath=indexPath;
    vc.commentDelegate=self;
    vc.delegate=self;
    [self pushViewController:vc];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
    id model = self.dataArray[indexPath.row];
    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[SDTimeLineCell class] contentViewWidth:[self cellContentViewWith]];
}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}

#pragma mark - SDTimeLineCellDelegate

- (void)didClickcCommentButtonInCell:(UITableViewCell *)cell
{
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    
    _inputView.inputTextView.placeholder=@"请输入评论内容";
    [_inputView.inputTextView becomeFirstResponder];
    _selIndexPath = [self.tableView indexPathForCell:cell];
    self.isReplayingComment=NO;
    [self adjustTableViewToFitKeyboard];
    
}

- (void)didClickLikeButtonInCell:(UITableViewCell *)cell
{
    
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    MTNewSupplyAndBuyListModel *model = self.dataArray[index.row];
    NSMutableArray *temp = [NSMutableArray arrayWithArray:model.clickUserInfos];
    BOOL isliked=YES;
    if ([model.clickStatus integerValue]==0) {
        isliked=NO;
    }
    
    if (!isliked) {
        
        SDTimeLineCellLikeItemModel *likeModel = [SDTimeLineCellLikeItemModel new];
        likeModel.nickname = USERMODEL.nickName;
        likeModel.user_id = USERMODEL.userID;
        [temp addObject:likeModel];
        model.clickStatus = [NSNumber numberWithBool:YES];
        model.clickUserInfos = [temp copy];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
            if ([model.type intValue]==1) { //供应
                [network getAddSupplyClickLike:[USERMODEL.userID intValue] supply_id:[model.news_id intValue] type:0 success:^(NSDictionary *obj) {
                }];
            }else if ([model.type intValue]==2) { //供应
                [network getAddWantBuyClickLike:[USERMODEL.userID intValue] want_buy_id:[model.news_id intValue] type:0 success:^(NSDictionary *obj) {
//                    NSDictionary *dict = obj[@"content"];
//                    NSLog(@"%@ -------- %@",obj[@"errorContent"],dict[@"experience_msg"]);
                }];
            }
        });
        
    }else {
        
        SDTimeLineCellLikeItemModel *tempLikeModel = nil;
        for (SDTimeLineCellLikeItemModel *likeModel in model.clickUserInfos) {
            if ([likeModel.user_id isEqualToString:USERMODEL.userID]) {
                tempLikeModel = likeModel;
                break;
            }
        }
        [temp removeObject:tempLikeModel];
        model.clickStatus = [NSNumber numberWithBool:NO];
        
        model.clickUserInfos = [temp copy];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
            if ([model.type intValue]==1) { //供应
                [network getAddSupplyClickLike:[USERMODEL.userID intValue] supply_id:[model.news_id intValue] type:1 success:^(NSDictionary *obj) {
                }];
            }else if ([model.type intValue]==2) { //求购
                [network getAddWantBuyClickLike:[USERMODEL.userID intValue] want_buy_id:[model.news_id intValue] type:1 success:^(NSDictionary *obj) {
                }];
            }
        });
    }
}

- (void)adjustTableViewToFitKeyboard
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:_selIndexPath];
    CGRect rect = [cell.superview convertRect:cell.frame toView:window];
    [self adjustTableViewToFitKeyboardWithRect:rect];
}

- (void)adjustTableViewToFitKeyboardWithRect:(CGRect)rect
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGFloat delta = CGRectGetMaxY(rect) - (window.bounds.size.height - _totalKeybordHeight);
    
    CGPoint offset = self.tableView.contentOffset;
    offset.y += delta;
    if (offset.y < 0) {
        offset.y = 0;
    }
    [self.tableView setContentOffset:offset animated:YES];
}

// 点赞代理
-(void)displayAgree:(MTNewSupplyAndBuyListModel *)model cell:(SDTimeLineCell *)cell isAgree:(BOOL)isAgree
{
    if (isAgree) {
        SDTimeLineCell *cell=[self.tableView cellForRowAtIndexPath:_selIndexPath];
        MTNewSupplyAndBuyListModel *model = self.dataArray[_selIndexPath.row];
        model.clickStatus=[NSNumber numberWithInt:0];
        [self didClickLikeButtonInCell:cell];
    }else{
        SDTimeLineCell *cell=[self.tableView cellForRowAtIndexPath:_selIndexPath];
        
        MTNewSupplyAndBuyListModel *model = self.dataArray[_selIndexPath.row];
        model.clickStatus=[NSNumber numberWithInt:1];
        [self didClickLikeButtonInCell:cell];
    }
}

//  详情 删除 添加评论代理
-(void)disPlayComment:(SDTimeLineCellCommentItemModel *)model indexPath:(NSIndexPath *)indexPath isAdd:(BOOL)isAdd
{
    MTNewSupplyAndBuyListModel *Model = self.dataArray[indexPath.row];
    
    if (isAdd) {
        [self creatCommentViewSupplyModel:Model CommentItemModel:model];
    }else{
        _delete=NO;
        [self deleteComment:Model comMod:model];
    }
    
    NSArray *indexArray=[NSArray arrayWithObject:_selIndexPath];
    [self.tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
}

//更新供求列表
-(void)GongQiuDeleteTableViewCell:(MTSupplyAndBuyListModel *)model indexPath:(NSIndexPath *)indexPath integer:(NSInteger)integer
{
    if (integer==1) {
        [_dataArray removeObjectAtIndex:_selIndexPath.row];
        [self.tableView reloadData];
    }else if (integer==2){
        MTNewSupplyAndBuyListModel *Model = self.dataArray[indexPath.row];
        
        Model.crown_width_e=[NSString stringWithFormat:@"%f",model.crown_width_e];
        Model.crown_width_s=[NSString stringWithFormat:@"%f",model.crown_width_s];
        Model.varieties=model.varieties;
        Model.height_e=[NSString stringWithFormat:@"%f",model.height_e];
        Model.height_s=[NSString stringWithFormat:@"%f",model.height_s];
        Model.rod_diameter=[NSString stringWithFormat:@"%f",model.rod_diameter];
        if (model.supply_id) {
            Model.news_id=model.supply_id;
        }else if (model.want_buy_id){
            Model.news_id=model.want_buy_id;
        }
        Model.number=model.number;
        Model.unit_price=model.unit_price;
        Model.selling_point=model.selling_point;
        Model.branch_point=[NSString stringWithFormat:@"%f",model.branch_point];
        Model.uploadtime=model.uploadtime;
        
        [_dataArray replaceObjectAtIndex:indexPath.row withObject:Model];
        
        NSArray *indexArray=[NSArray arrayWithObject:indexPath];
        [self.tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
    }
}

//添加评论
-(void)creatCommentViewSupplyModel:(MTNewSupplyAndBuyListModel *)SupplyModel CommentItemModel:(SDTimeLineCellCommentItemModel *)commentItemModel{
    
    NSMutableArray *temp = [NSMutableArray new];
    [temp addObjectsFromArray:SupplyModel.commentInfos];
    
    //    commentItemModel.nickname = USERMODEL.nickName;
    //   // commentItemModel.comment_cotent = textField.text;
    //    commentItemModel.user_id = USERMODEL.userID;
    [temp addObject:commentItemModel];
    
    SupplyModel.commentInfos = [temp copy];
    // [self.tableView reloadRowsAtIndexPaths:@[_currentEditingIndexthPath] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - CommentViewDelegate 点击发送

-(void)didSendText:(UITextView *)textField text:(NSString *)text
{
    if (textField.text.length) {
        [_inputView.inputTextView resignFirstResponder];
        
        MTNewSupplyAndBuyListModel *model = self.dataArray[_selIndexPath.row];
        NSMutableArray *temp = [NSMutableArray new];
        [temp addObjectsFromArray:model.commentInfos];
        
        SDTimeLineCellCommentItemModel *commentItemModel = [SDTimeLineCellCommentItemModel new];
        commentItemModel.nickname = USERMODEL.nickName;
        commentItemModel.comment_cotent = textField.text;
        commentItemModel.user_id = USERMODEL.userID;
        [temp addObject:commentItemModel];
        
        int commentType=0;
        int replyComment_id=0;
        int replyUserID=0;
        NSString *replyUserName;
        if (self.isReplayingComment) {
            commentType=1;
            
            commentItemModel.comment_type=@"1";
            commentItemModel.reply_nickname=self.commod.nickname;
            commentItemModel.reply_user_id=self.commod.user_id;
            
            replyComment_id =[self.commod.comment_id intValue];
            replyUserID=[self.commod.user_id intValue];
            replyUserName=self.commod.nickname;
        }else{
            commentItemModel.comment_type=@"0";
            
            replyUserID=0;
            replyUserName=@"";
        }
        
        
        model.commentInfos = [temp copy];
        [self.tableView reloadRowsAtIndexPaths:@[_selIndexPath] withRowAnimation:UITableViewRowAnimationNone];
        
        if ([model.type intValue]==1) {  //供应
            [network getAddSupplyComment:[model.news_id intValue]
                                 user_id:[USERMODEL.userID intValue]
                           reply_user_id:replyUserID
                          reply_nickname:replyUserName
                          supply_comment:textField.text
                            comment_type:commentType
                 reply_supply_comment_id:replyComment_id
                                 success:^(NSDictionary *obj) {
                                     
                                     /* ***************数据本地创建成功以后，给附上新的commentID      */
                                     [self setNewCommentIDForModel:obj];
                                 }];
            
        }
        else if ([model.type intValue]==2){
            
            [network getAddWantBuyComment:[model.news_id intValue]
                                  user_id:[USERMODEL.userID intValue]
                            reply_user_id:replyUserID
                           reply_nickname:replyUserName
                           supply_comment:textField.text
                             comment_type:commentType
                  reply_supply_comment_id:replyComment_id success:^(NSDictionary *obj) {
                      [self setNewCommentIDForModel:obj];
                  }];
        }
        _inputView.inputTextView.text = @"";
    }
}

/* ***************数据本地创建成功以后，给附上新的commentID      */
-(void)setNewCommentIDForModel:(NSDictionary *)dic{
    NSDictionary *commentDic=[dic objectForKey:@"content"];
    MTNewSupplyAndBuyListModel *model = self.dataArray[_selIndexPath.row];
    NSDictionary *commentInfo=[commentDic objectForKey:@"commentInfo"];
    
    SDTimeLineCellCommentItemModel *commentItemModel = [model.commentInfos lastObject];
    
    commentItemModel.comment_id=stringFormatString([commentInfo objectForKey:@"comment_id"]) ;
    [self.tableView reloadRowsAtIndexPaths:@[_selIndexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)keyboardNotification:(NSNotification *)notification
{
    //    BOOL isThisKey=[[notification object]boolValue];
    //
    //    if (!isThisKey) {
    //        return;
    //    }
    //
    
    if (!_inputView.isEdit) {
        return;
    }
    
    NSDictionary *dict = notification.userInfo;
    CGRect rect = [dict[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
    CGFloat h=WindowHeight-rect.size.height-_inputView.inputTextView.height;
    
    CGRect textFieldRect = CGRectMake(0, h, rect.size.width, _inputView.inputTextView.height);
    if (rect.origin.y == [UIScreen mainScreen].bounds.size.height) {
        textFieldRect = rect;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        self->_inputView.frame = textFieldRect;
    }];
    
    CGFloat h1 = rect.size.height + _inputView.inputTextView.height;
    if (_totalKeybordHeight != h1) {
        _totalKeybordHeight = h1;
        [self adjustTableViewToFitKeyboard];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat y=scrollView.contentOffset.y;
    if (y<=0) {
        [UIView animateWithDuration:0.5f animations:^{
            self->_createQGBtn.alpha=1;
            self->_createGYBtn.alpha=1;
        } completion:^(BOOL finished) {
        }];
    }else{
        [UIView animateWithDuration:0.5f animations:^{
            self->_createQGBtn.alpha=0;
            self->_createGYBtn.alpha=0;
        } completion:^(BOOL finished) {
        }];
    }
}

- (void)scrollViewDidEndDecelerating:(MTBaseTableView *)scrollView {
    [UIView animateWithDuration:0.5 animations:^{
        self->_createQGBtn.alpha=1;
        self->_createGYBtn.alpha=1;
    }];
}

#define mark - 开通VIP

- (UIView *) createBackgroundView {
    UIView *view = [[UIView alloc] initWithFrame:self.view.frame];
    view.backgroundColor = kColor(@"#FFFFFF");
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, kWidth(115), kWidth(140), kWidth(140))];
    imageView.image = kImage(@"gongqiu_top_Img");
    imageView.centerX = view.width/2;
    [view addSubview:imageView];
    
    UILabel *infoLab = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.bottom + kWidth(24), kWidth(300), kWidth(55))];
    infoLab.numberOfLines = 0;
    [view addSubview:infoLab];
    infoLab.textAlignment = NSTextAlignmentCenter;
    infoLab.font = darkFont(14);
    infoLab.centerX = imageView.centerX;
    infoLab.textColor = kColor(@"#4A4A4A");
    infoLab.text = @"抱歉，您不是VIP会员，暂无权限使用此功能！可购买VIP会员月卡享30天会员特权";
    [infoLab sizeToFit];
    
    UIButton *VipBut = [UIButton buttonWithType:UIButtonTypeSystem];
    VipBut.frame = CGRectMake(0, infoLab.bottom + kWidth(34), infoLab.width, kWidth(45));
    VipBut.backgroundColor = kColor(@"#05C1B0");
    VipBut.titleLabel.font = darkFont(font(16));
    VipBut.centerX = infoLab.centerX;
    [view addSubview:VipBut];
    VipBut.layer.cornerRadius = VipBut.height/2;
    [VipBut setTitleColor:kColor(@"#FFFFFF") forState:UIControlStateNormal];
    [VipBut setTitle:@"立即开通" forState:UIControlStateNormal];
    [VipBut addTarget:self action:@selector(joinVipAction) forControlEvents:UIControlEventTouchUpInside];
    return view;
}
- (void) joinVipAction {
    if (urlStr == nil || urlStr.length < 1) {
        [self getVipUrl];
        return;
    }
    MiaoBiInfoViewController *VipVc = [[MiaoBiInfoViewController alloc] init];
    [VipVc setTitle:@"加入VIP" andTitleColor:kColor(@"#393838")];
    VipVc.type = 1;
    VipVc.mUrl=[NSURL URLWithString:urlStr];
    [self pushViewController:VipVc];
    WS(weakSelf);
    VipVc.paySuccesrefreshBlack = ^{
        [weakSelf refreshTableViewLoading2:weakSelf.tableView data:weakSelf.dataArray dateType:kSupplyAndBuyUserDate];
    };
   
}
@end