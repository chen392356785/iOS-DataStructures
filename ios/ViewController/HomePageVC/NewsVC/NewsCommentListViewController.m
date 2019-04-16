//
//  NewsCommentListViewController.m
//  MiaoTuProject
//
//  Created by Zmh on 28/6/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "InputKeyBoardView.h"
#import "CustomView+CustomCategory2.h"
#import "NewsCommentListViewController.h"
#import "MTOtherInfomationMainViewController.h"

@interface NewsCommentListViewController ()<UITableViewDelegate,HJCActionSheetDelegate>
{
    MTBaseTableView *commTableView;//评论列表
    int page;
    NSMutableArray *dataArray;
//    UIView *_topView;
//    UIView *_downView;
    UITextField *_pltxt;
    InputKeyBoardView *_keyBoardView;
    SMLabel *_numberLbl;
    NSIndexPath *_selIndexPath;
}
@end

@implementation NewsCommentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"评论列表"];
    dataArray = [[NSMutableArray alloc] init];
    [self GreatTableView];
    
}
- (void)GreatTableView
{
    __weak NewsCommentListViewController *weakSelf = self;
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth,37)];
//    _topView = topView;
	
    UIView *downView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 37)];
    downView.backgroundColor=[UIColor whiteColor];
//    _downView = downView;
    
    UIImage *img = Image(@"comment_select.png");
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(12, 0, img.size.width, img.size.height)];
    imageV.image = img;
    imageV.centerY = downView.height/2.0;
    [downView addSubview:imageV];
    CGSize size=[IHUtility GetSizeByText:@"所有评论" sizeOfFont:15 width:100];
    SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageV.right + 6.5,0, size.width, 36) textColor:RGBA(135, 134, 140, 1) textFont:sysFont(15)];
    lbl.text=@"所有评论";
    [downView addSubview:lbl];
    
    SMLabel *numberLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.right+5, lbl.top, size.width, 36) textColor:RGBA(135, 134, 140, 1) textFont:sysFont(15)];
    numberLbl.text=stringFormatInt(self.infoModel.commentTotal);
    _numberLbl = numberLbl;
    [downView addSubview:numberLbl];
    [topView addSubview:downView];
    
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight - 40) tableviewStyle:UITableViewStylePlain];
    commTableView.attribute=self;
    commTableView.table.tableHeaderView=topView;
    [commTableView setupData:dataArray index:3];
    commTableView.table.delegate=self;
    [self.view addSubview:commTableView];
    
    
    [self CreateBaseRefesh:commTableView type:ENT_RefreshFooter successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefesh:refreshView];
    }];
    [self beginRefesh:ENT_RefreshFooter];
    
    NewsBottomView *bottomView =[[NewsBottomView alloc] initWithFrame:CGRectMake(0, WindowHeight - 40, WindowWith, 40)];
    bottomView.textfield.enabled = NO;
    [self.view addSubview:bottomView];
    
    UITapGestureRecognizer *commTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(commentNews)];
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
    txt.inputAccessoryView =_keyBoardView;
}

-(void)loadRefesh:(MJRefreshComponent *)refreshView
{
    if (refreshView==commTableView.table.mj_header) {
        page=0;
    }
    [network getNewsCommentList:page maxResults:10 info_id:[NSString stringWithFormat:@"%d",self.infoModel.info_id] success:^(NSDictionary *obj) {
        
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
            return ;
        }
        
		[self->dataArray addObjectsFromArray:arr];
		[self->commTableView.table reloadData];
        [self endRefresh];
    } failure:^(NSDictionary *obj2) {
        [self endRefresh];
    }];
    
    [self removeWaitingView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)commentNews
{
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

-(void)createComment:(NSString *)content{
    
    int commentType=0;
    int replyComment_id=0;
    int replyUserID=0;
    NSString *replyUserName;
    if (self.isReply) {
        commentType=1;
        CommentListModel *mod=[dataArray objectAtIndex:_selIndexPath.row];
        replyComment_id =mod.comment_id;
        replyUserID=[mod.userChildrenInfo.user_id intValue];
        replyUserName=mod.userChildrenInfo.nickname;
    }else{
        //        replyUserID=[self.model.userChildrenInfo.user_id intValue];
        //        replyUserName=self.model.userChildrenInfo.nickname;
    }
    __weak typeof(self) weakSelf = self;
    
    [self addWaitingView];
    
    [network getAddNewsComment:self.infoModel.info_id user_id:[USERMODEL.userID intValue] reply_user_id:replyUserID reply_nickname:replyUserName info_comment:content comment_type:commentType reply_info_comment_id:replyComment_id success:^(NSDictionary *obj) {
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
    _numberLbl.text = [NSString stringWithFormat:@"%d",[_numberLbl.text intValue] + 1];
    self.infoModel.commentTotal = [_numberLbl.text intValue];
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
    [commTableView.table insertRowsAtIndexPaths:[NSArray arrayWithObject:path] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self addSucessView:@"评论成功" type:1];
    _keyBoardView.txtView.text=@"";
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat f;
    
    CommentListModel *model=[dataArray objectAtIndex:indexPath.row];
    f=[model.cellHeigh floatValue];
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

-(void)BCtableViewCell:(IHTableViewCell *)cell action:(BCTableViewCellAction)action indexPath:(NSIndexPath *)indexPath attribute:(NSObject *)attribute{
    if (action==MTHeadViewActionTableViewCell) {
        NSLog(@"点击头像");
        UserChildrenInfo *mod = (UserChildrenInfo *)attribute;
        [self headWeak:mod];
    }
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

- (void)actionSheet:(HJCActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    if (buttonIndex==1) {
        
        CommentListModel *mod1=[dataArray objectAtIndex:_selIndexPath.row];
        [self addWaitingView];
        [network getDeleteNewsCommentID:mod1.comment_id userID:USERMODEL.userID success:^(NSDictionary *obj) {
            [self addSucessView:@"删除成功!" type:1];
			[self->dataArray removeObjectAtIndex:self->_selIndexPath.row];
            //[commTableView.table deleteRowsAtIndexPaths:[NSArray arrayWithObject:_selIndexPath] withRowAnimation:UITableViewRowAnimationFade];
			[self->commTableView.table reloadData];
			self->_numberLbl.text = [NSString stringWithFormat:@"%d",[self->_numberLbl.text intValue] - 1];
			self.infoModel.commentTotal = [self->_numberLbl.text intValue];
        }];
    }
}

@end
