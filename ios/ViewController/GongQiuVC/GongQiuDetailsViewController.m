//
//  GongQiuDetailsViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/3/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "GongQiuDetailsViewController.h"
#import "MTOtherInfomationMainViewController.h"
//#import "InformationEditViewController.h"
#import "CreateBuyOrSupplyViewController.h"
#import "ChatViewController.h"
@interface GongQiuDetailsViewController()<HJCActionSheetDelegate,ChatViewControllerDelegate>
{
    MTBaseTableView *commTableView;
    int page;
    NSMutableArray *dataArray;
//    int _agreeNum;
    SMLabel *_numberLbl;
    BuyListView *_listView;
    UIView *_downView;
    UIView *_topView;
    
}
@end
@implementation GongQiuDetailsViewController

@synthesize model;


-(void)becomeKeyBoard{
    
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    
    self.isReply=NO;
    [_pltxt becomeFirstResponder];
    [_keyBoardView.txtView becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self setTitle:@"华盛顿棕"];
    
    agreeArr=[[NSMutableArray alloc]init];
    
    [self setTitle:model.varieties];
    __weak GongQiuDetailsViewController *weakSelf = self;
    
    [self creatTableView];
    BOOL isSelf=NO;
    if ([self.model.userChildrenInfo.user_id isEqualToString:USERMODEL.userID]) {
        isSelf=YES;
    }
    
    //
    BottomView *bottomView=[[BottomView alloc]initWithisSelf:isSelf type:ENT_qiugou];
    bottomView.selectBlock=^(NSInteger index){
        
        if (!USERMODEL.isLogin) {
            [weakSelf prsentToLoginViewController];
            return ;
        }
        
        if (index==SelectCommentBlock) {
            
            [weakSelf becomeKeyBoard];
        }else if (index==SelectTelphoneBlock) {
            NSLog(@"打电话");
            [weakSelf getPhoneweak];
        }else  if (index==SelectHiBlock) {
            NSLog(@"打招呼");
            [weakSelf setChat];
        }else if (index==SelectEditBlock) {
            NSLog(@"编辑");
            [weakSelf edit];
            
        }else if (index==SelectDeleteBlock) {
            NSLog(@"删除");
            [weakSelf deleteWeakSupplyBuy];
        }
        else  if (index==SelectStoreBlock) {
            NSLog(@"进商店");
            [weakSelf headWeak:weakSelf.model.userChildrenInfo];
            
        }
    };
    [self.view addSubview:bottomView];
    
    
    [self setRightButtonImage:Image(@"detail_jubao.png") forState:UIControlStateNormal];
    
    
    [self setNavBarItem:self.model.hasCollection];
    
    MTOppcenteView *oppcenteView=[[MTOppcenteView alloc]initWithOrgane:CGPointMake(30, WindowHeight-TFTabBarHeight-70) BtnType:ENT_pinglun];
    
    [self.view bringSubviewToFront:oppcenteView];
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        NSLog(@"第一次启动");
        [self.view addSubview:oppcenteView];
    }else{
        NSLog(@"已经不是第一次启动了");
        
    }
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
    
    if (self.type==ENT_Supply) {
        [network getSupplyCollections:[model.supply_id intValue] user_id:[USERMODEL.userID intValue] success:^(NSDictionary *obj) {
            [self addSucessView:@"收藏成功" type:1];
            UIImage *img=Image(@"activ_detailCollect.png");
            [self->searchBtn setImage:img forState:UIControlStateNormal];
            self->model.hasCollection=YES;
        }];
        
    }else
    {
        [network getBuyCollections:[model.want_buy_id intValue] user_id:[USERMODEL.userID intValue] success:^(NSDictionary *obj) {
            [self addSucessView:@"收藏成功" type:1];
            UIImage *img=Image(@"activ_detailCollect.png");
            [self->searchBtn setImage:img forState:UIControlStateNormal];
            self->model.hasCollection=YES;
        }];
        
    }
}


-(void)getPhoneweak{
    
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    
    if (![self.model.userChildrenInfo.mobile isEqualToString:@""]) {
        NSString *phoneString = [NSString stringWithFormat:@"tel:%@",self.model.userChildrenInfo.mobile];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:phoneString]]];
        [self.view addSubview:callWebview];
    }else
    {
        [IHUtility addSucessView:@"对方没有留下电话" type:1];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag==12) {
        if (buttonIndex==0) {
            if (self.type==ENT_Supply) {
                [network getDeleteSupply:[self.model.supply_id intValue] success:^(NSDictionary *obj) {
					
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
					if ([self.delegate respondsToSelector:@selector(GongQiuDeleteTableViewCell:indexPath:)]) {
						[self.delegate GongQiuDeleteTableViewCell:self.model indexPath:self.indexPath integer:1];
					}
#pragma clang diagnostic pop
					
					
					
					
                    [self addSucessView:@"删除成功" type:1];
                    
                    self.selectDeleteBlock(self.model,self.indexPath);
                    [self back:nil];
                    
                }];
            }else
            {
                [network getDeleteBuy:[self.model.want_buy_id intValue] success:^(NSDictionary *obj) {
					
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
					if ([self.delegate respondsToSelector:@selector(GongQiuDeleteTableViewCell:indexPath:)]) {
						[self.delegate GongQiuDeleteTableViewCell:self.model indexPath:self.indexPath integer:1];
					}
#pragma clang diagnostic pop
					
                    [self addSucessView:@"删除成功" type:1];
                    self.selectDeleteBlock(self.model,self.indexPath);
                    [self back:nil];
                    
                }];
            }
        }
    }
}

-(void)deleteWeakSupplyBuy{
    [IHUtility AlertMessage:@"" message:@"确定删除本条信息吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消" tag:12];
}

-(void)edit{
    int collType = 0;
    if (self.type==ENT_Buy) {
        collType= ENT_qiugou;
    }else if (self.type==ENT_Supply){
        collType= ENT_gongying;
    }
    
    CreateBuyOrSupplyViewController *v=[[CreateBuyOrSupplyViewController alloc]init];
    v.selectEditBlock=^(MTSupplyAndBuyListModel *Model){
        
        [self->_listView setData:Model type:collType];
        self->_listView.height = [Model.cellHeigh doubleValue]-100;
        self->_agreeView.top = self->_listView.bottom;
        self->_downView.top = self->_agreeView.bottom;
        self->_topView.frame=CGRectMake(0, 0, WindowWith,self->_downView.bottom);
        self.model=Model;
        [self.delegate GongQiuDeleteTableViewCell:Model indexPath:self.indexPath integer:2];
    };
    
    v.type=self.type;
    v.isEdit=YES;
    v.ifEdit=YES;
    v.model=self.model;
    [self presentViewController:v];
}

-(void)setChat{
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    ChatViewController *vc=[[ChatViewController alloc]initWithChatter:model.userChildrenInfo.hx_user_name conversationType:eConversationTypeChat];
    vc.nickName=model.userChildrenInfo.nickname;
    vc.delelgate=self;
    vc.toUserID=stringFormatString(model.userChildrenInfo.user_id);
    vc.HeadimgUrl=[NSString stringWithFormat:@"%@%@",model.userChildrenInfo.heed_image_url,smallHeaderImage];
    
    [self pushViewController:vc];
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

-(void)getAgreeHeadNetWork:(NSInteger)index{
    UserChildrenInfo *mod=[agreeArr objectAtIndex:index];
    [self headWeak:mod];
}

-(void)getAddAgreeNum{
    
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    
    if (self.type==ENT_Supply) {
        [network getAddSupplyClickLike:[USERMODEL.userID intValue]supply_id:[model.supply_id intValue] type:0  success:^(NSDictionary *obj) {
			[self->_agreeView setAddNum:self.model.clickLikeTotal +1];
            NSDictionary *dic=[IHUtility getUserDefalutsDicKey:kUserDefalutLoginInfo];
            UserChildrenInfo *model=[[UserChildrenInfo alloc]initWithDic:dic];
			[self->agreeArr addObject:model];
            self.model.clickLikeTotal++;
			[self->_agreeView setData:self->agreeArr totalNum:stringFormatInt(self.model.clickLikeTotal) hasClickLike:self.model.hasClickLike];
            [self addSucessView:@"点赞成功!" type:1];
            [self.delegate disPlayAgree:self.model indexPath:self.indexPath];
        }];
    }else if (self.type==ENT_Buy){
        [network getAddWantBuyClickLike:[USERMODEL.userID intValue]want_buy_id:[model.want_buy_id intValue] type:0  success:^(NSDictionary *obj) {
			[self->_agreeView setAddNum:self.model.clickLikeTotal +1];
            NSDictionary *dic=[IHUtility getUserDefalutsDicKey:kUserDefalutLoginInfo];
            UserChildrenInfo *model=[[UserChildrenInfo alloc]initWithDic:dic];
			[self->agreeArr addObject:model];
            self.model.clickLikeTotal++;
			[self->_agreeView setData:self->agreeArr totalNum:stringFormatInt( self.model.clickLikeTotal) hasClickLike:self.model.hasClickLike];
            [self addSucessView:@"点赞成功!" type:1];
            [self.delegate disPlayAgree:self.model indexPath:self.indexPath];
        }];
    }
}

-(void)creatTableView
{
    UIView *topView=[[UIView alloc]init];
    __weak GongQiuDetailsViewController *weakSelf = self;
    
    dataArray=[[NSMutableArray alloc]init];
    
    
    HeaderView *headView=[[HeaderView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 60)];
    [headView setData:model.userChildrenInfo type:self.type];
    __weak  MTSupplyAndBuyListModel *MTmodel = model;
    headView.selectBlock=^(NSInteger index){
        if (index==SelectheadImageBlock) {
            [weakSelf headWeak:MTmodel.userChildrenInfo];
        }
    };
    [topView addSubview:headView];
    
	int collType = 0;
	switch (self.type) {
		case ENT_Buy:
			collType= ENT_qiugou;
			break;
	    case ENT_Supply:
			collType= ENT_gongying;
			break;
		default:
			break;
	}
	
    BuyListView *listView=[[BuyListView alloc]initWithFrame:CGRectMake(0, headView.height, WindowWith, [model.cellHeigh doubleValue]-100) type:collType];
    [listView setData:model type:collType];
    _listView=listView;
    
    [topView addSubview:listView];
    
    AgreeView *agreeView=[[AgreeView alloc]initWithFrame:CGRectMake(0, listView.bottom, WindowWith, 55)  number:stringFormatInt(model.clickLikeTotal)];
    _agreeView=agreeView;
    agreeView.selectBlock=^(NSInteger index){
        
        if (index==agreeBlock){
            [weakSelf getAddAgreeNum];
        }else{
            [weakSelf getAgreeHeadNetWork:index];
        }
        
    };
    [topView addSubview:agreeView];
    
    
    MTOppcenteView *oppcenteView=[[MTOppcenteView alloc]initWithOrgane:CGPointMake(WindowWith-220, agreeView.top-90)  BtnType:ENT_DianZan];
    
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch4"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch4"];
        NSLog(@"第一次启动");
        [topView bringSubviewToFront:oppcenteView];
        [topView addSubview:oppcenteView];
    }else{
        NSLog(@"已经不是第一次启动了");
        
    }
    
    int type2=1;
    NSString *business_id=model.supply_id;
    if (self.type==ENT_Buy) {
        type2=3;
        business_id=model.want_buy_id;
    }
    
    [network getQueryClickLikeListType:type2 business_id:business_id num:10 page:0 success:^(NSDictionary *obj) {
        NSArray *arr=[obj objectForKey:@"content"];
        [self->agreeArr addObjectsFromArray:arr];
        
        [agreeView setData:arr totalNum:stringFormatInt(self->model.clickLikeTotal) hasClickLike:self.model.hasClickLike];
    } failure:^(NSDictionary *obj2) {
    }];
    
    UIView *downView=[[UIView alloc]initWithFrame:CGRectMake(0, agreeView.bottom, WindowWith, 37)];
    downView.backgroundColor=[UIColor whiteColor];
    _downView = downView;
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
    _topView = topView;
    topView.frame=CGRectMake(0, 0, WindowWith,downView.bottom);
    
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight-40) tableviewStyle:UITableViewStylePlain];
    commTableView.table.delegate=self;
    commTableView.attribute=self;
    [commTableView setupData:dataArray index:3];
    commTableView.table.tableHeaderView=topView;
    [self.view addSubview:commTableView];
    
    [self CreateBaseRefesh:commTableView type:ENT_RefreshFooter successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefesh:refreshView];
    }];
    [self beginRefesh:ENT_RefreshFooter];
    
    
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
-(void)resignKeyBoard{
    [_keyBoardView.txtView resignFirstResponder];
    [_pltxt resignFirstResponder];
}

-(void)loadRefesh:(MJRefreshComponent *)refreshView{
    if (refreshView==commTableView.table.mj_header) {
        page=0;
    }
    
    if (self.type==ENT_Supply) {
        
        [network getQuerySupplyCommentList:page maxResults:pageNum supplyID:model.supply_id success:^(NSDictionary *obj) {
            if (refreshView==self->commTableView.table.mj_header) {
                [self->dataArray removeAllObjects];
                self->page = 0;
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
        
        
    }else if(self.type==ENT_Buy){
        
        [network getQueryWantBuyCommentList:page maxResults:10 want_buy_id:model.want_buy_id success:^(NSDictionary *obj) {
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
    }
    
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
    self.model.commentTotal++;
    _keyBoardView.txtView.text=@"";
    [self.commentDelegate disPlayComment:(SDTimeLineCellCommentItemModel*)self.model indexPath:self.indexPath isAdd:YES];
}

-(void)createComment:(NSString *)content{
    
    
    int commentType=0;
    int replyComment_id=0;
    int replyUserID=0;
	int supply_comment_id = 0;
    NSString *replyUserName;
    if (self.isReply) {
        commentType=1;
        CommentListModel *mod=[dataArray objectAtIndex:_selIndexPath.row];
        replyComment_id =mod.comment_id;
		supply_comment_id = mod.comment_id;
        replyUserID=[mod.userChildrenInfo.user_id intValue];
        replyUserName=mod.userChildrenInfo.nickname;
    }else{
        replyUserID=[model.userChildrenInfo.user_id intValue];
        replyUserName=model.userChildrenInfo.nickname;
    }
    __weak typeof(self) weakSelf = self;
    
    [self addWaitingView];
    
    if (self.type==ENT_Supply) {
        [network getAddSupplyComment:[model.supply_id intValue]
                             user_id:[USERMODEL.userID intValue]
                       reply_user_id:replyUserID
				   supply_comment_id:supply_comment_id
                      reply_nickname:replyUserName
                      supply_comment:content
                        comment_type:commentType
             reply_supply_comment_id:replyComment_id
                             success:^(NSDictionary *obj) {
                                 NSDictionary *dic=[obj objectForKey:@"content"];
                                 NSDictionary *commentDic=[dic objectForKey:@"commentInfo"];
                                 [weakSelf addComment:commentDic];
                             }];
        
    }
    else if (self.type==ENT_Buy){
        
        [network getAddWantBuyComment:[model.want_buy_id intValue]
                              user_id:[USERMODEL.userID intValue]
                        reply_user_id:replyUserID
                       reply_nickname:replyUserName
                       supply_comment:content
                         comment_type:commentType reply_supply_comment_id:replyComment_id success:^(NSDictionary *obj) {
                             NSDictionary *dic=[obj objectForKey:@"content"];
                             NSDictionary *commentDic=[dic objectForKey:@"commentInfo"];
                             [weakSelf addComment:commentDic];
                         }];
    }
}



#pragma mark cell分支点击事件
-(void)BCtableViewCell:(IHTableViewCell *)cell action:(BCTableViewCellAction)action indexPath:(NSIndexPath *)indexPath attribute:(NSObject *)attribute{
    if (action==MTHeadViewActionTableViewCell) {
        NSLog(@"点击头像");
        UserChildrenInfo *mod=(UserChildrenInfo*)attribute;
        [network selectUserCloudInfoById:[USERMODEL.userID intValue]follow_id:[mod.user_id intValue]success:^(NSDictionary *obj) {
            
            MTOtherInfomationMainViewController *controller=[[MTOtherInfomationMainViewController alloc]initWithUserID:mod.user_id :NO dic:obj[@"content"]];
            controller.userMod=mod;
            controller.dic=obj[@"content"];
            [self pushViewController:controller];
        } failure:^(NSDictionary *obj2) {
            
        }];
    }
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
    
    if (actionSheet.tag==11){
        
        if (buttonIndex==2) {
            [self shareView:self.type object:model vc:self];
        }else if (buttonIndex==3){
            HJCActionSheet *sheet = [[HJCActionSheet alloc] initWithDelegate:self CancelTitle:@"取消" title:@"举报" OtherTitles:@"垃圾营销",@"淫秽色情",@"不实信息",@"敏感信息",@"抄袭内容",@"骚扰我",@"虚假中奖", nil];
            sheet.tag=33;
            [sheet show];
        }
        
        
    }else if (actionSheet.tag==33){
        
        NSArray *arr=[ConfigManager getReportArray];
        NSString *str=[arr objectAtIndex:buttonIndex-2];
        
        [self addWaitingView];
        
        if (self.type==ENT_Supply) {
            [network getAddReport:USERMODEL.userID report_content:str report_type:@"1" business_id:model.supply_id success:^(NSDictionary *obj) {
                
                [self addSucessView:@"举报成功!" type:1];
                
            } failure:^(NSDictionary *obj2) {
                
            }];
            
        }else
        {
            [network getAddReport:USERMODEL.userID report_content:str report_type:@"3" business_id:model.want_buy_id success:^(NSDictionary *obj) {
                
                [self addSucessView:@"举报成功!" type:1];
                
            } failure:^(NSDictionary *obj2) {
                
            }];
        }
    }
    
    if (actionSheet.tag==22){
        
        
        if (buttonIndex==1) {
            
            if (self.type==ENT_Supply) {
                CommentListModel *mod1=[dataArray objectAtIndex:_selIndexPath.row];
                [self addWaitingView];
                [network getDeleteSupplyCommentID:mod1.comment_id userID:USERMODEL.userID success:^(NSDictionary *obj) {
                    [self addSucessView:@"删除成功!" type:1];
					self->_numberLbl.text=stringFormatInt([self->_numberLbl.text intValue]-1);
                    [self->dataArray removeObjectAtIndex:self->_selIndexPath.row];
                    [self->commTableView.table deleteRowsAtIndexPaths:[NSArray arrayWithObject:self->_selIndexPath] withRowAnimation:UITableViewRowAnimationFade];
                    self.model.commentTotal--;
                    [self.commentDelegate disPlayComment:(SDTimeLineCellCommentItemModel*)self.model indexPath:self.indexPath isAdd:NO];
                    
                }];
            }else if (self.type==ENT_Buy){
                CommentListModel *mod1=[dataArray objectAtIndex:_selIndexPath.row];
                [self addWaitingView];
                [network getDeleteBuyCommentID:mod1.comment_id userID:USERMODEL.userID success:^(NSDictionary *obj) {
					[self addSucessView:@"删除成功!" type:1];
					self->_numberLbl.text=stringFormatInt([self->_numberLbl.text intValue]-1);
					[self->dataArray removeObjectAtIndex:self->_selIndexPath.row];
					[self->commTableView.table deleteRowsAtIndexPaths:[NSArray arrayWithObject:self->_selIndexPath] withRowAnimation:UITableViewRowAnimationFade];
					self.model.commentTotal--;
					[self.commentDelegate disPlayComment:(SDTimeLineCellCommentItemModel*)self.model indexPath:self.indexPath isAdd:NO];
                }];
                
            }
        }
    }
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
