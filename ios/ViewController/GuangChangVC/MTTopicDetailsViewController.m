//
//  MTTopicDetailsViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/4/1.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTTopicDetailsViewController.h"
#import "MTOtherInfomationMainViewController.h"
//#import "IHBaseViewController.h"
#import "ChatViewController.h"
//#import "UINavigationBar+Awesome.h"
@interface MTTopicDetailsViewController ()<UITableViewDelegate,ChatViewControllerDelegate>
{
    MTBaseTableView *commTableView;
    NSMutableArray *dataArray;
    int page;
    SMLabel *_numberLbl;
    BottomView *_bottomView;
}

@end

@implementation MTTopicDetailsViewController

@synthesize model;

-(void)ZanTopic{
    [network getTopicAddLike:USERMODEL.userID topic_id:model.topic_id success:^(NSDictionary *obj) {
        
        [self addSucessView:@"点赞成功!" type:1];
        
    } failure:^(NSDictionary *obj2) {
        
    }];
}

-(void)becomeKeyBoard{
    self.isReply=NO;
    [_pltxt becomeFirstResponder];
    [_keyBoardView.txtView becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"话题正文"];
    [self setNavBarItem:self.model.hasCollection];
    agreeArr=[[NSMutableArray alloc]init]; //点赞头像列表
    dataArray=[[NSMutableArray alloc]init];
    [self creatTableView];
    __weak MTTopicDetailsViewController *weakSelf = self;
    BOOL isSelf=NO;
    if ([model.userChildrenInfo.user_id isEqualToString:USERMODEL.userID]) {
        isSelf=YES;
    }
    
    BottomView *bottomView=[[BottomView alloc]initWithisSelf:isSelf type:ENT_topic];
    _bottomView = bottomView;
    [bottomView setDataWithModel:self.model];
    bottomView.selectBlock=^(NSInteger index){
        
        if (!USERMODEL.isLogin) {
            [weakSelf prsentToLoginViewController];
            return ;
        }
        if (index==SelectCommentBlock) {
            [weakSelf becomeKeyBoard];
        }
        else if (index==SelectAgreeBlock ) {
            [weakSelf getAddAgreeNum];
        }
        else  if (index==SelectHiBlock) {
            [weakSelf setChat];
        }
        
    };
    [self.view addSubview:bottomView];
    
    UITextField *txt=[[UITextField alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 0)];
    _pltxt=txt;
    [self.view addSubview:txt];
    _keyBoardView=[[InputKeyBoardView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight)  submit:^(NSString *str) {
        [weakSelf createComment:str];
    } back:^{
        [weakSelf resignKeyBoard];
    }];
    txt.inputAccessoryView =_keyBoardView;
    
    if (self.isBeginComment) {
        [self performSelector:@selector(becomeKeyBoard) withObject:nil afterDelay:0.8];
    }
}

-(void)setChat{
    ChatViewController *vc=[[ChatViewController alloc]initWithChatter:model.userChildrenInfo.hx_user_name conversationType:eConversationTypeChat];
    vc.toUserID=stringFormatString(model.userChildrenInfo.user_id);
    vc.nickName=model.userChildrenInfo.nickname;
    vc.HeadimgUrl=[NSString stringWithFormat:@"%@%@",model.userChildrenInfo.heed_image_url,smallHeaderImage];
    vc.delelgate=self;
    [self pushViewController:vc];
}

-(void)resignKeyBoard{
    [_keyBoardView.txtView resignFirstResponder];
    [_pltxt resignFirstResponder];
}

-(void)createComment:(NSString *)content{
    
    int commentType=0;
    int replyComment_id=0;
    
    __weak typeof(self) weakSelf = self;
    int replyUserID=0;
    NSString *replyUserName;
    
    
    if (self.isReply) {
        commentType=1;
        CommentListModel *mod=[dataArray objectAtIndex:_selIndexPath.row];
        replyComment_id =mod.comment_id;
        replyUserID=[mod.userChildrenInfo.user_id intValue];
        replyUserName=mod.userChildrenInfo.nickname;
    }else{
        replyUserID=[model.userChildrenInfo.user_id intValue];
        replyUserName=model.userChildrenInfo.nickname;
    }
    
    
    [self addWaitingView];
    [network getAddTopicComment:[model.topic_id intValue]
                        user_id:[USERMODEL.userID intValue]
                  reply_user_id:replyUserID
                 reply_nickname:replyUserName
                  topic_comment:content
                   comment_type:commentType
         reply_topic_comment_id:replyComment_id
                        success:^(NSDictionary *obj) {
                            NSDictionary *dic=[obj objectForKey:@"content"];
                            NSDictionary *commentDic=[dic objectForKey:@"commentInfo"];
                            [weakSelf addComment:commentDic];
                            
                        }];
}

-(void)addComment:(NSDictionary *)commentDic{
    CommentListModel *mod=[[CommentListModel alloc]initWithDictionary:commentDic error:nil];
    CGSize size=[IHUtility GetSizeByText:mod.comment_cotent sizeOfFont:15 width:WindowWith-75];
    mod.cellHeigh=[NSNumber numberWithFloat:48+size.height];
    [dataArray insertObject:mod atIndex:0];
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
    [commTableView.table insertRowsAtIndexPaths:[NSArray arrayWithObject:path] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self addSucessView:@"评论成功" type:1];
    _numberLbl.text=stringFormatInt([_numberLbl.text intValue]+1);
    self.model.commentTotal ++;
    [self.delegate disPlayTopicComment:self.model indexPath:self.indexPath];
    _keyBoardView.txtView.text=@"";
}

-(void)headWeak:(UserChildrenInfo *)mod{
    NSLog(@"点击头像");
    
    [network selectUserCloudInfoById:[USERMODEL.userID intValue]follow_id:[mod.user_id intValue]success:^(NSDictionary *obj) {
        
        MTOtherInfomationMainViewController *controller=[[MTOtherInfomationMainViewController alloc]initWithUserID:mod.user_id :NO dic:obj[@"content"]];
        controller.userMod=mod;
        controller.dic=obj[@"content"];
        [self pushViewController:controller];
    } failure:^(NSDictionary *obj2) {
        
    }];
}

-(void)getAddAgreeNum{
    
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    
    [network getTopicAddLike:USERMODEL.userID topic_id:self.model.topic_id success:^(NSDictionary *obj) {
		[self->_agreeView setAddNum:self.model.clickLikeTotal +1];
        NSDictionary *dic=[IHUtility getUserDefalutsDicKey:kUserDefalutLoginInfo];
        UserChildrenInfo *infoModel=[[UserChildrenInfo alloc]initWithDic:dic];
        [self->agreeArr addObject:infoModel];
        [self addSucessView:@"点赞成功!" type:1];
        self.model.clickLikeTotal++;
        self.model.hasClickLike = YES;
        [self->_agreeView setData:self->agreeArr totalNum:stringFormatInt(self.model.clickLikeTotal) hasClickLike:self.model.hasClickLike];
        [self.delegate disPlayTopicAgree:self.model indexPath:self.indexPath];
        [self->_bottomView setDataWithModel:self.model];
    } failure:^(NSDictionary *obj2) {
        
    }];
}

-(void)creatTableView
{
    UIView *topView=[[UIView alloc]init];
    __weak MTTopicDetailsViewController *weakSelf = self;
    
    HeaderView *headView=[[HeaderView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 60)];
    [headView setData:model.userChildrenInfo type:ENT_Topic];
    __weak MTTopicListModel *TopModel = model;
    headView.selectBlock=^(NSInteger index){
        if (index==SelectheadImageBlock) {
            [weakSelf headWeak:TopModel.userChildrenInfo];
            
        }
    };
    [topView addSubview:headView];
    
    TopicListView *listView=[[TopicListView alloc]initWithFrame:CGRectMake(0, headView.height, WindowWith, [model.bodyHeigh floatValue])];
    [listView setData:model];
    [topView addSubview:listView];
    
    
    AgreeView *agreeView=[[AgreeView alloc]initWithFrame:CGRectMake(0, listView.bottom, WindowWith, 55)  number:stringFormatInt(self.model.clickLikeTotal) ];
    _agreeView=agreeView;
    __weak AgreeView *agreeSelf = agreeView;
    agreeView.selectBlock=^(NSInteger index){
        
        
        if (index==agreeBlock){
            [weakSelf getAddAgreeNum];
        }else if (index == cancelagreeBlock){
            if (self.model.hasClickLike) {
                [weakSelf addSucessView:@"该活动已点赞" type:2];
                agreeSelf.agreeBtn.selected = YES;
            }
        }else{
            [weakSelf getAgreeHeadNetWork:index];
        }
        
    };
    [topView addSubview:agreeView];
    
    
    [network getQueryClickLikeListType:2 business_id:self.model.topic_id num:10 page:0 success:^(NSDictionary *obj) {
        NSArray *arr=[obj objectForKey:@"content"];
        [self->agreeArr addObjectsFromArray:arr];
        [agreeView setData:arr totalNum:stringFormatInt(self.model.clickLikeTotal) hasClickLike:self.model.hasClickLike];
    } failure:^(NSDictionary *obj2) {
    }];
    
    
    UIView *downView=[[UIView alloc]initWithFrame:CGRectMake(0, agreeView.bottom, WindowWith, 37)];
    downView.backgroundColor=[UIColor whiteColor];
    CGSize size=[IHUtility GetSizeByText:@"评  论" sizeOfFont:15 width:100];
    SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(WindowWith*0.053,0, size.width, 36) textColor:RGBA(85, 201, 196, 1) textFont:sysFont(15)];
    lbl.text=@"评  论";
    [downView addSubview:lbl];
    
    SMLabel *numberLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.right+5, lbl.top, size.width, 36) textColor:RGBA(85, 201, 196, 1) textFont:sysFont(15)];
    _numberLbl=numberLbl;
    numberLbl.text=stringFormatInt(model.commentTotal);
    [downView addSubview:numberLbl];
    
    UIView *lineView2=[[UIView alloc]initWithFrame:CGRectMake(0, 36, 100, 1)];
    lineView2.backgroundColor=RGBA(85, 201, 196, 1);
    [downView addSubview:lineView2];
    [topView addSubview:downView];
    topView.frame=CGRectMake(0, 0, WindowWith,downView.bottom);
    
    
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight-40) tableviewStyle:UITableViewStylePlain];
    commTableView.attribute=self;
    
    commTableView.table.tableHeaderView=topView;
    [commTableView setupData:dataArray index:3];
    commTableView.table.delegate=self;
    [self.view addSubview:commTableView];
    
    [self CreateBaseRefesh:commTableView type:ENT_RefreshFooter successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefresh:refreshView];
    }];
    [self beginRefesh:ENT_RefreshFooter];
}

-(void)loadRefresh:(MJRefreshComponent *)refreshView{
    if (refreshView==commTableView.table.mj_header) {
        page=0;
    }
    [network getQueryTopicCommentList:page maxResults:pageNum topicID:model.topic_id success:^(NSDictionary *obj) {
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
        [self endRefresh];
        
    } failure:^(NSDictionary *obj2) {
        [self endRefresh];
    }];
}


-(void)getAgreeHeadNetWork:(NSInteger)index{
    UserChildrenInfo *mod=[agreeArr objectAtIndex:index];
    [self headWeak:mod];
    
}

-(void)share
{
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    
    HJCActionSheet *sheet = [[HJCActionSheet alloc] initWithDelegate:self CancelTitle:@"取消" title:nil OtherTitles:@"分享",@"举报", nil];
    sheet.tag=11;
    [sheet show];
   
}

-(void)collection
{
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    
    [network getTopicCollection:[model.topic_id intValue] user_id:[USERMODEL.userID intValue] success:^(NSDictionary *obj) {
        [self addSucessView:@"收藏成功" type:1];
        UIImage *img=Image(@"activ_detailCollect.png");
        [self->searchBtn setBackgroundImage:img forState:UIControlStateNormal];
        self->model.hasCollection=YES;
    }];
}


#pragma mark tableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommentListModel *model=[dataArray objectAtIndex:indexPath.row];
    CGFloat f=[model.cellHeigh floatValue];
    return f;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!USERMODEL.isLogin) {
        
        [self prsentToLoginViewController];
        return;
        
    }
    
    CommentListModel *mod1=[dataArray objectAtIndex:indexPath.row];
    _selIndexPath=indexPath;
    if ([mod1.userChildrenInfo.user_id isEqualToString:USERMODEL.userID]) {
        HJCActionSheet *sheet = [[HJCActionSheet alloc] initWithDelegate:self CancelTitle:@"取消" OtherTitles:@"删除", nil];
        sheet.tag=22; //删除
        [sheet show];
    }else {
        [_pltxt becomeFirstResponder];
        [_keyBoardView.txtView becomeFirstResponder];
        self.isReply=YES;
        if (_keyBoardView.txtView.text.length==0) {
            _keyBoardView.txtView.placeholder=[NSString stringWithFormat:@"回复%@",mod1.userChildrenInfo.nickname];
        }else{
            _keyBoardView.txtView.placeholder=@"";
        }
    }
}

- (void)actionSheet:(HJCActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (actionSheet.tag==22){
        if (buttonIndex==1) {
            CommentListModel *mod1=[dataArray objectAtIndex:_selIndexPath.row];
            [self addWaitingView];
            [network getDeleteTopicCommentID:mod1.comment_id userID:USERMODEL.userID success:^(NSDictionary *obj) {
                [self addSucessView:@"删除成功!" type:1];
                self->_numberLbl.text=stringFormatInt([self->_numberLbl.text intValue]-1);
                [self->dataArray removeObjectAtIndex:self->_selIndexPath.row];
                // [commTableView.table reloadData];
                [self->commTableView.table deleteRowsAtIndexPaths:[NSArray arrayWithObject:self->_selIndexPath] withRowAnimation:UITableViewRowAnimationFade];
                self.model.commentTotal --;
                [self.delegate disPlayTopicComment:self.model indexPath:self.indexPath];
            }];
            
            //   [network deleteCommentID:mod1.commentID];
        }
    }else if (actionSheet.tag==11){
        
        if (buttonIndex==2) {
            [self shareView:ENT_Topic object:model vc:self];
        }else if (buttonIndex==3){
            HJCActionSheet *sheet = [[HJCActionSheet alloc] initWithDelegate:self CancelTitle:@"取消" title:@"举报" OtherTitles:@"垃圾营销",@"淫秽色情",@"不实信息",@"敏感信息",@"抄袭内容",@"骚扰我",@"虚假中奖", nil];
            sheet.tag=33;
            [sheet show];
        }
        
        
    }else if (actionSheet.tag==33){
        
        NSArray *arr=[ConfigManager getReportArray];
        NSString *str=[arr objectAtIndex:buttonIndex-2];
        
        [self addWaitingView];
        [network getAddReport:USERMODEL.userID report_content:str report_type:@"2" business_id:model.topic_id success:^(NSDictionary *obj) {
            
            [self addSucessView:@"举报成功!" type:1];
            
        } failure:^(NSDictionary *obj2) {
            
        }];
    }
}

#pragma mark cell分支点击事件
-(void)BCtableViewCell:(IHTableViewCell *)cell action:(BCTableViewCellAction)action indexPath:(NSIndexPath *)indexPath attribute:(NSObject *)attribute{
    if (action==MTHeadViewActionTableViewCell) {
        NSLog(@"点击头像");
        
        UserChildrenInfo *mod = (UserChildrenInfo *)attribute;
        [network selectUserCloudInfoById:[USERMODEL.userID intValue]follow_id:[mod.user_id intValue]success:^(NSDictionary *obj) {
            MTOtherInfomationMainViewController *controller=[[MTOtherInfomationMainViewController alloc]initWithUserID:mod.user_id :NO dic:obj[@"content"]];
            controller.userMod=mod;
            controller.dic=obj[@"content"];
            [self pushViewController:controller];
        } failure:^(NSDictionary *obj2) {
            
        }];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ChatViewControllerDelegate

// 根据环信id得到要显示头像路径，如果返回nil，则显示默认头像
- (NSString *)avatarWithChatter:(NSString *)chatter{
    NSString *str=[NSString stringWithFormat:@"%@%@",model.userChildrenInfo.heed_image_url,smallHeaderImage];
    NSString *userID=[model.userChildrenInfo.hx_user_name lowercaseString];
    
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
