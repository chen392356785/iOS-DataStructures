//
//  MTNewSupplyAndBuyDetailsViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/7/20.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTNewSupplyAndBuyDetailsViewController.h"
#import "MTNewSupplyAndBuyDetailsView.h"
#import "MTOtherInfomationMainViewController.h"
#import "ChatViewController.h"
#import "CreateBuyOrSupplyViewController.h"
@class SDTimeLineCellCommentItemModel;
@interface MTNewSupplyAndBuyDetailsViewController ()<UITableViewDelegate,HJCActionSheetDelegate,ChatViewControllerDelegate>
{
    MTBaseTableView *commTableView;
    int page;
    NSMutableArray *dataArray;
    CustomAgreeView *_agreeView;
    NSMutableArray *agreeArr;
    CGFloat _height;
    int _clickLikeTotal;
    IHTextField *_pltxt;
    InputKeyBoardView *_keyBoardView;
    NSIndexPath *_selIndexPath;
    SMLabel *_numberLbl;
    SMLabel *_ZanNumLabel;
    int _commentTotal;
    UIView *_downView;
    UIView *_topView;
    MTSupplyAndBuyListModel *_model;
    MTNewSupplyAndBuyDetailsView *_topview;
    
    BOOL isAgree;
}
@end

@implementation MTNewSupplyAndBuyDetailsViewController
@synthesize model;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (self.type==ENT_Buy) {
        [self setTitle:@"求购详情"];
    }else
    {
        [self setTitle:@"供应详情"];
    }
    // Do any additional setup after loading the view.
    // [self addPushViewWaitingView];
    
    [self creatTableView];
    [self setbackTopFrame:WindowHeight-120];
    self.view.backgroundColor = cBgColor;
}

-(void)backTopClick:(UIButton *)sender{
    [self scrollTopPoint:commTableView.table];
    [self setHomeTabBarHidden:YES];
}

-(void)becomeKeyBoard{
    
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    
    self.isReply=NO;
    [_pltxt becomeFirstResponder];
    [_keyBoardView.txtView becomeFirstResponder];
    _keyBoardView.txtView.text = @"";
}

-(void)deleteWeakSupplyBuy{
    [IHUtility AlertMessage:@"" message:@"确定删除本条信息吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消" tag:12];
}

//编辑
-(void)edit{
    int collType;
    NSString *imgStr;
    if (self.type==ENT_Buy) {
        collType= ENT_qiugou;
        imgStr = _model.want_buy_url;
    }else if (self.type==ENT_Supply){
        imgStr = _model.supply_url;
        collType= ENT_gongying;
    }
    
    CreateBuyOrSupplyViewController *v=[[CreateBuyOrSupplyViewController alloc]init];
    v.selectEditBlock=^(MTSupplyAndBuyListModel *Model){
                        
        self->_topview.height=[self->_topview setDataWithmodel:Model];
        
        self->_agreeView.top = self->_topview.bottom;
        self->_downView.top = self->_agreeView.bottom;
        self->_topView.frame=CGRectMake(0, 0, WindowWith,self->_downView.bottom);
        
        if ([self.delegate respondsToSelector:@selector(GongQiuDeleteTableViewCell:indexPath: integer:)]) {
            [self.delegate GongQiuDeleteTableViewCell:Model indexPath:self.indexPath integer:2];
        }
    };
    
    if (self.type==ENT_Buy) {
        
        v.type=ENT_Buy;
        
    }else
    {
        v.type=ENT_Supply;
        
    }
    
    v.isEdit=YES;
    v.ifEdit=YES;
    v.model = _model;
    if (imgStr.length>0) {
        NSData *data =[imgStr dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *arr2 = [NSJSONSerialization JSONObjectWithData:data
                                                       options:NSJSONReadingMutableContainers
                                                         error:nil];
        NSMutableArray *imgArr=[[NSMutableArray alloc]initWithCapacity:arr2.count];
        for (id dic2 in arr2) {
            if ([dic2 isKindOfClass:[NSDictionary class]]) {
                MTPhotosModel *mod=[[MTPhotosModel alloc]initWithDic:dic2];
                [imgArr addObject:mod];
            }
        }
        v.model.imgArray=imgArr;
    }
    [self pushViewController:v];
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

-(void)getPhoneweak{
    
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    
    if (![_model.userChildrenInfo.mobile isEqualToString:@""]) {
        NSString *phoneString = [NSString stringWithFormat:@"tel:%@",_model.userChildrenInfo.mobile];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:phoneString]]];
        [self.view addSubview:callWebview];
    }else
    {
        [IHUtility addSucessView:@"对方没有留下电话" type:1];
    }
    
}
//进入聊天
-(void)setChat{
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    ChatViewController *vc=[[ChatViewController alloc]initWithChatter:_model.userChildrenInfo.hx_user_name conversationType:eConversationTypeChat];
    vc.nickName=_model.userChildrenInfo.nickname;
    vc.delelgate=self;
    vc.toUserID=stringFormatString(_model.userChildrenInfo.user_id);
    vc.HeadimgUrl=[NSString stringWithFormat:@"%@%@",_model.userChildrenInfo.heed_image_url,smallHeaderImage];
    
    [self pushViewController:vc];
}

-(void)collection
{
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    
    if (self.type==ENT_Supply) {
        [network getSupplyCollections:[_model.supply_id intValue] user_id:[USERMODEL.userID intValue] success:^(NSDictionary *obj) {
            [self addSucessView:@"收藏成功" type:1];
//            UIImage *img=Image(@"activ_detailCollect.png");
            [self->searchBtn setImage:Image(@"activ_detailCollect.png") forState:UIControlStateNormal];
            // model.hasCollection=[NSNumber numberWithInteger:1];
        }];
        
    }else
    {
        [network getBuyCollections:[_model.want_buy_id intValue] user_id:[USERMODEL.userID intValue] success:^(NSDictionary *obj) {
            [self addSucessView:@"收藏成功" type:1];
//            UIImage *img=Image(@"activ_detailCollect.png");
            [self->searchBtn setImage:Image(@"activ_detailCollect.png") forState:UIControlStateNormal];
//            [searchBtn setBackgroundImage:nil forState:UIControlStateSelected];
            // model.hasCollection=[NSNumber numberWithInteger:1];
        }];
        
    }
}

-(void)resignKeyBoard{
    [_keyBoardView.txtView resignFirstResponder];
    [_pltxt resignFirstResponder];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

//点赞
-(void)getAddAgreeNumisAgree:(BOOL)isagree{
    
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    
    //
    NSDictionary *dic=[IHUtility getUserDefalutsDicKey:kUserDefalutLoginInfo];
    UserChildrenInfo *model1=[[UserChildrenInfo alloc]initWithDic:dic];
    if (isagree) {
        //[_agreeView setAddNum:_clickLikeTotal++];
//        if (![agreeArr containsObject:model]) {
            [agreeArr addObject:model1];
//        }
        
        
        if ([self.delegate  respondsToSelector:@selector(displayAgree:cell:isAgree:)]){
            [self.delegate displayAgree:self.model cell:self.cell isAgree:YES];
        }
        
        
        
//        [_agreeView setData:agreeArr totalNum:stringFormatInt(_clickLikeTotal+1) hasClickLike:YES];
        NSMutableArray *tempArr = [[NSMutableArray alloc] init];
        for (UserChildrenInfo *model in agreeArr) {
            [tempArr addObject:model.nickname];
        }
        if (tempArr.count > 0) {
            NSString *string = [tempArr componentsJoinedByString:@"、"];   //为分隔符
            CGSize size=[IHUtility GetSizeByText:string sizeOfFont:13 width:iPhoneWidth - 30];
            _ZanNumLabel.size = CGSizeMake(iPhoneWidth - 30, size.height);
            _ZanNumLabel.text= string;
            _downView.origin = CGPointMake(0, _ZanNumLabel.bottom);
            _topView.size = CGSizeMake(iPhoneWidth, _downView.bottom);
            [commTableView.table reloadData];
        }
        
        [self addSucessView:@"点赞成功!" type:1];
    }else{
        //  [_agreeView setAddNum:_clickLikeTotal--];
        
        for(int i=0; i<agreeArr.count;i ++){
            UserChildrenInfo *obj=[agreeArr objectAtIndex:i];
            if ([obj.user_id isEqualToString:USERMODEL.userID]) {
                [agreeArr removeObjectAtIndex:i];
            }
        }
        
        //            for ( UserChildrenInfo *obj in agreeArr) {
        //                if ([obj.user_id isEqualToString:USERMODEL.userID]) {
        //                    [agreeArr removeObject:obj];
        //                }
        //            }
        //  [agreeArr removeObject:model1];
        
        if ([self.delegate  respondsToSelector:@selector(displayAgree:cell:isAgree:)]) {
            [self.delegate displayAgree:self.model cell:self.cell isAgree:NO];
        }
        
//        [_agreeView setData:agreeArr totalNum:stringFormatInt(_clickLikeTotal--) hasClickLike:NO];
        
        NSMutableArray *tempArr = [[NSMutableArray alloc] init];
        for (UserChildrenInfo *model in agreeArr) {
            [tempArr addObject:model.nickname];
        }
        if (tempArr.count > 0) {
            NSString *string = [tempArr componentsJoinedByString:@"、"];   //为分隔符
            CGSize size=[IHUtility GetSizeByText:string sizeOfFont:13 width:iPhoneWidth - 30];
            _ZanNumLabel.size = CGSizeMake(iPhoneWidth - 30, size.height);
            _ZanNumLabel.text= string;
            _downView.origin = CGPointMake(0, _ZanNumLabel.bottom);
            _topView.size = CGSizeMake(iPhoneWidth, _downView.bottom);
             [commTableView.table reloadData];
        }
        [self addSucessView:@"取消点赞成功!" type:1];
    }
}


-(void)setSupplyAndBuyBlock:(NSDictionary *)obj{
    MTSupplyAndBuyListModel *Model=[[MTSupplyAndBuyListModel alloc]initWithDictionary:obj[@"content"] error:nil];
    _model=Model;
    
    __weak typeof(self) weakSelf = self;
    [weakSelf creatBottomViewWith:Model];
    
    [weakSelf creatTableHighViewWithModel:Model];
    
    [self removePushViewWaitingView];
    [IHUtility ViewAnimateWith:commTableView];
}

-(void)creatTableView
{
    _height=0;
    
    __weak MTNewSupplyAndBuyDetailsViewController *weakSelf = self;
    
    dataArray=[[NSMutableArray alloc]init];
    
    NSString *userid;
    
    if (!USERMODEL.isLogin) {
        userid=@"0";
    }else{
        userid=USERMODEL.userID;
    }
    
    [self addPushViewWaitingView];
    if (self.type==ENT_Supply) {
        [network getSupplyDetailID:userid supply_id:self.newsId success:^(NSDictionary *obj) {
            [weakSelf setSupplyAndBuyBlock:obj];
            
        } failure:^(NSDictionary *obj2) {
            
        }];
        
    }else{
        
        [network getBuyDetailID:userid want_buy_id:self.newsId success:^(NSDictionary *obj) {
            
            [weakSelf setSupplyAndBuyBlock:obj];
            
        } failure:^(NSDictionary *obj2) {
            
        }];
    }
}

//底部的按钮
-(void)creatBottomViewWith:(MTSupplyAndBuyListModel *)Model{
    
    
    __weak MTNewSupplyAndBuyDetailsViewController *weakSelf = self;
    if (Model.hasCollection) {
        [weakSelf setNavBarItem:YES];
    }else{
        [weakSelf setNavBarItem:NO];
    }
    
    __weak MTSupplyAndBuyListModel *weakModel=_model;
    
    BOOL isSelf=NO;
    if ([Model.userChildrenInfo.user_id isEqualToString:USERMODEL.userID]) {
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
            weakSelf.isReply=NO;
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
            
            
            [weakSelf headWeak:weakModel.userChildrenInfo];
        }
    };
    [self.view addSubview:bottomView];
    
    agreeArr=[[NSMutableArray alloc]init];
}

//进苗圃
-(void)getAgreeHeadNetWork:(NSInteger)index{
    UserChildrenInfo *mod=[agreeArr objectAtIndex:index];
    [self headWeak:mod];
}

-(void)headWeak:(UserChildrenInfo *)mod{
    NSLog(@"点击头像");
    __weak MTNewSupplyAndBuyDetailsViewController *weakSelf = self;
    [IHUtility addWaitingView];
    [network selectUserCloudInfoById:[USERMODEL.userID intValue]follow_id:[mod.user_id intValue]success:^(NSDictionary *obj) {
        [IHUtility removeWaitingView];
        MTOtherInfomationMainViewController *controller=[[MTOtherInfomationMainViewController alloc]initWithUserID:mod.user_id :NO dic:obj[@"content"]];
        controller.userMod=mod;
        controller.dic=obj[@"content"];
        [weakSelf pushViewController:controller];
    } failure:^(NSDictionary *obj2) {
        
    }];
}

//实例化表头
-(void)creatTableHighViewWithModel:(MTSupplyAndBuyListModel *)Model{
    UIView *topView=[[UIView alloc]init];
    MTNewSupplyAndBuyDetailsView *topview=[[MTNewSupplyAndBuyDetailsView alloc]init];
    _topview=topview;
    _height=[topview setDataWithmodel:Model];
    topview.frame=CGRectMake(0, 0, WindowWith, _height);
    
    __weak MTNewSupplyAndBuyDetailsViewController *weakSelf = self;
    
    topview.selectBtnBlock=^(NSInteger index){
        [weakSelf headWeak:Model.userChildrenInfo];
    };
    CustomAgreeView *agreeView=[[CustomAgreeView alloc]initWithFrame:CGRectMake(0, topview.bottom + 5, WindowWith, 38)];
    _agreeView=agreeView;
    [agreeView setSubViewData:Model];
    agreeView.liuyanBlock = ^{
        
    };
    agreeView.AgreeBlock = ^(BOOL IsAgree){
        if (IsAgree == YES){
            // isAgree=YES;
            [weakSelf getAddAgreeNumisAgree:YES];
        }else{
            //isAgree=NO;
            [weakSelf getAddAgreeNumisAgree:NO];
        }
    };
    agreeView.liuyanBlock = ^{
         [self liuyangAction];
    };
    
//    agreeView.selectBlock=^(NSInteger index){
//        else{
//            [weakSelf getAgreeHeadNetWork:index];
//        }
//    };
        
    [topView addSubview:topview];
    [topView addSubview:agreeView];
    
    
    
    UIAsyncImageView *zanimageV = [[UIAsyncImageView alloc] initWithFrame:CGRectMake(15, agreeView.bottom + 8, 15, 15)];
    zanimageV.image = Image(@"zan");
    [topView addSubview:zanimageV];
    NSString *string = @"暂无点赞";
    CGSize size1=[IHUtility GetSizeByText:string sizeOfFont:14 width:iPhoneWidth - maxX(zanimageV) - 15];
    SMLabel *zanlbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(zanimageV.right + 5,agreeView.bottom + 8, iPhoneWidth - maxX(zanimageV) - 15, size1.height) textColor:cBlackColor textFont:sysFont(13)];
    zanlbl.text= string;
    zanlbl.numberOfLines = 0;
    _ZanNumLabel = zanlbl;
    [topView addSubview:zanlbl];
    
    [self creatAgreeView:Model];
    
    UIView *downView=[[UIView alloc]initWithFrame:CGRectMake(0, zanlbl.bottom, WindowWith, 37)];
    downView.backgroundColor=[UIColor whiteColor];
    _downView = downView;
    
    
    UIAsyncImageView *pinlimageV = [[UIAsyncImageView alloc] initWithFrame:CGRectMake(15, 12, 15, 15)];
    pinlimageV.image = Image(@"xpinglun");
    [downView addSubview:pinlimageV];
    CGSize size=[IHUtility GetSizeByText:@"全部评论/" sizeOfFont:13 width:100];
    SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(pinlimageV.right + 5,minY(pinlimageV), size.width, 15) textColor:cBlackColor textFont:sysFont(13)];
    lbl.text=@"全部评论/";
    [downView addSubview:lbl];
    
    SMLabel *numberLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.right, lbl.top, size.width, height(lbl)) textColor:cBlackColor textFont:sysFont(13)];
    _numberLbl=numberLbl;
    _commentTotal=Model.commentTotal;
    numberLbl.text=stringFormatInt(_commentTotal);
    [downView addSubview:numberLbl];
    
    UIView *lineView2=[[UIView alloc]initWithFrame:CGRectMake(0, 36, 100, 1)];
    lineView2.backgroundColor=RGBA(85, 201, 196, 1);
    [downView addSubview:lineView2];
    [topView addSubview:downView];
    _topView = topView;
    topView.frame=CGRectMake(0, 0, WindowWith,downView.bottom);
    
    topView.backgroundColor = [UIColor whiteColor];
    
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight - 45 ) tableviewStyle:UITableViewStylePlain];
    commTableView.table.delegate=self;
    commTableView.attribute=self;
    [commTableView setupData:dataArray index:3];
    commTableView.table.tableHeaderView=topView;
    
    commTableView.alpha=0;
    
    [self.view addSubview:commTableView];
    
    [weakSelf CreateBaseRefesh:commTableView type:ENT_RefreshFooter successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefesh:refreshView];
    }];
    [self beginRefesh:ENT_RefreshFooter];
    
    
    IHTextField *txt=[[IHTextField alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 0)];
    _pltxt=txt;
    [self.view addSubview:txt];
    
    _keyBoardView=[[InputKeyBoardView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight)  submit:^(NSString *str) {
        [weakSelf createComment:str];
    } back:^{
        [weakSelf resignKeyBoard];
    }];
    _keyBoardView.lbl.text = @"留言";
    txt.inputAccessoryView =_keyBoardView;
    
    if (self.isBeginComment) {
        [weakSelf performSelector:@selector(becomeKeyBoard) withObject:nil afterDelay:0.8];
    }
}
#pragma mark - 评论
- (void)liuyangAction{
    [_pltxt becomeFirstResponder];
    [_keyBoardView.txtView becomeFirstResponder];
    _keyBoardView.txtView.text = @"";
    self.isReply=NO;
    if (_keyBoardView.txtView.text.length==0) {
        _keyBoardView.txtView.placeholder=@"";
    }
}
//点赞列表
-(void)creatAgreeView:(MTSupplyAndBuyListModel *)Model{
    
    int type2=1;
    NSString *business_id=self.newsId;
    if (self.type==ENT_Buy) {
        type2=3;
    }
    
    [network getQueryClickLikeListType:type2 business_id:business_id num:10 page:0 success:^(NSDictionary *obj) {
        NSArray *arr=[obj objectForKey:@"content"];
        
        [self->agreeArr addObjectsFromArray:arr];
        BOOL hasClickLike=YES;
        if (!Model.hasClickLike) {
            hasClickLike=NO;
        }
        self->_clickLikeTotal=Model.clickLikeTotal;
        NSMutableArray *tempArr = [[NSMutableArray alloc] init];
        for (UserChildrenInfo *model in self->agreeArr) {
            [tempArr addObject:model.nickname];
        }
        if (tempArr.count > 0) {
            NSString *string = [tempArr componentsJoinedByString:@"、"];   //为分隔符
            CGSize size=[IHUtility GetSizeByText:string sizeOfFont:13 width:iPhoneWidth - 30];
            self->_ZanNumLabel.size = CGSizeMake(iPhoneWidth - 30, size.height);
            self->_ZanNumLabel.text= string;
            self->_downView.origin = CGPointMake(0,self->_ZanNumLabel.bottom);
            self->_topView.size = CGSizeMake(iPhoneWidth,self->_downView.bottom);
        }
//        [_agreeView setData:arr totalNum:[NSString stringWithFormat:@"%ld",(long)_clickLikeTotal] hasClickLike:hasClickLike];
        
        
    } failure:^(NSDictionary *obj2) {
        
    }];
}

//评论列表
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
        replyUserID=[_model.userChildrenInfo.user_id intValue];
        replyUserName=_model.userChildrenInfo.nickname;
    }
    __weak typeof(self) weakSelf = self;
    
    [self addWaitingView];
    
    if (self.type==ENT_Supply) {
        
        [network getAddSupplyComment:[self.newsId intValue]
                             user_id:[USERMODEL.userID intValue]
                       reply_user_id:replyUserID
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
        
        [network getAddWantBuyComment:[self.newsId intValue]
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

//添加评论
-(void)addComment:(NSDictionary *)commentDic{
    CommentListModel *mod=[[CommentListModel alloc]initWithDictionary:commentDic error:nil];
    CGSize size=[IHUtility GetSizeByText:mod.comment_cotent sizeOfFont:15 width:WindowWith-75];
    mod.cellHeigh=[NSNumber numberWithFloat:48+size.height];
    [dataArray insertObject:mod atIndex:0];
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
    [commTableView.table insertRowsAtIndexPaths:[NSArray arrayWithObject:path] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self addSucessView:@"评论成功" type:1];
    _numberLbl.text=stringFormatInt([_numberLbl.text intValue]+1);
    
    _keyBoardView.txtView.text=@"";
    SDTimeLineCellCommentItemModel *Model=[[SDTimeLineCellCommentItemModel alloc]initWith:mod];
    
    
    if ([self.commentDelegate respondsToSelector:@selector(disPlayComment:indexPath: isAdd:)]) {
        [self.commentDelegate disPlayComment:Model indexPath:self.indexPath isAdd:YES];
    }
}

-(void)loadRefesh:(MJRefreshComponent *)refreshView{
    if (refreshView==commTableView.table.mj_header) {
        page=0;
    }
    
    if (self.type==ENT_Supply) {
        
        [network getQuerySupplyCommentList:page maxResults:pageNum supplyID:self.newsId success:^(NSDictionary *obj) {
            //
            
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
        
    }else if(self.type==ENT_Buy){
        
        [network getQueryWantBuyCommentList:page maxResults:10 want_buy_id:self.newsId success:^(NSDictionary *obj) {
            [IHUtility ViewAnimateWith:self->commTableView];
            
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

#pragma mark cell分支点击事件
-(void)BCtableViewCell:(IHTableViewCell *)cell action:(BCTableViewCellAction)action indexPath:(NSIndexPath *)indexPath attribute:(NSObject *)attribute{
    if (action==MTHeadViewActionTableViewCell) {
        NSLog(@"点击头像");
        UserChildrenInfo *mod=(UserChildrenInfo*)attribute;
        [self addWaitingView];
        [network selectUserCloudInfoById:[USERMODEL.userID intValue]follow_id:[mod.user_id intValue]success:^(NSDictionary *obj) {
            [self removeWaitingView];
            MTOtherInfomationMainViewController *controller=[[MTOtherInfomationMainViewController alloc]initWithUserID:mod.user_id :NO dic:obj[@"content"]];
            controller.userMod=mod;
            controller.dic=obj[@"content"];
            [self pushViewController:controller];
        } failure:^(NSDictionary *obj2) {
            
        }];
    }
}

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
        _keyBoardView.txtView.text = @"";
        self.isReply=YES;
        if (_keyBoardView.txtView.text.length==0) {
            _keyBoardView.txtView.placeholder=[NSString stringWithFormat:@"回复%@",mod1.userChildrenInfo.nickname];
        }else{
            _keyBoardView.txtView.placeholder=@"";
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag==12) {
        if (buttonIndex==0) {
            if (self.type==ENT_Supply) {
                [network getDeleteSupply:[self.newsId intValue] success:^(NSDictionary *obj) {
                    
                    if ([self.delegate respondsToSelector:@selector(GongQiuDeleteTableViewCell:indexPath: integer:)]) {
                        [self.delegate GongQiuDeleteTableViewCell:self->_model indexPath:self.indexPath integer:1];
                    }
                    
                    [self addSucessView:@"删除成功" type:1];
                    
                    // self.selectDeleteBlock(self.model,self.indexPath);
                    [self back:nil];
                }];
            }else
            {
                [network getDeleteBuy:[self.newsId intValue] success:^(NSDictionary *obj) {
                    
                    if ([self.delegate respondsToSelector:@selector(GongQiuDeleteTableViewCell:indexPath: integer:)]) {
                        [self.delegate GongQiuDeleteTableViewCell:self->_model indexPath:self.indexPath integer:1];
                    }
                    [self addSucessView:@"删除成功" type:1];
                    // self.selectDeleteBlock(_model,self.indexPath);
                    [self back:nil];
                    
                }];
            }
        }
    }
}

- (void)actionSheet:(HJCActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (actionSheet.tag==11){
        
        if (buttonIndex==2) {
            if (self.type==ENT_Supply) {
                [self shareView:ENT_Supply object:_model vc:self];
            }else if(self.type==ENT_Buy){
                [self shareView:ENT_Buy object:_model vc:self];
            }
            
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
            [network getAddReport:USERMODEL.userID report_content:str report_type:@"1" business_id:self.newsId success:^(NSDictionary *obj) {
                
                [self addSucessView:@"举报成功!" type:1];
                
            } failure:^(NSDictionary *obj2) {
                
            }];
            
        }else
        {
            [network getAddReport:USERMODEL.userID report_content:str report_type:@"3" business_id:self.newsId success:^(NSDictionary *obj) {
                
                [self addSucessView:@"举报成功!" type:1];
                
            } failure:^(NSDictionary *obj2) {
                
            }];
        }
    }
    
    if (actionSheet.tag==22){
        
        
        if (buttonIndex==1) {
            
            if (self.type==ENT_Supply) {
                CommentListModel *mod1=[dataArray objectAtIndex:_selIndexPath.row];
                _numberLbl.text=stringFormatInt([_numberLbl.text intValue]-1);
                [dataArray removeObjectAtIndex:_selIndexPath.row];
                [commTableView.table deleteRowsAtIndexPaths:[NSArray arrayWithObject:_selIndexPath] withRowAnimation:UITableViewRowAnimationFade];
                _commentTotal--;
                SDTimeLineCellCommentItemModel *Model=[[SDTimeLineCellCommentItemModel alloc]initWith:mod1];
                
                
                if ([self.commentDelegate respondsToSelector:@selector(disPlayComment:indexPath: isAdd:)]) {
                    [self.commentDelegate disPlayComment:Model indexPath:self.indexPath isAdd:NO];
                }
                
            }else if (self.type==ENT_Buy){
                CommentListModel *mod1=[dataArray objectAtIndex:_selIndexPath.row];
                
                _numberLbl.text=stringFormatInt([_numberLbl.text intValue]-1);
                [dataArray removeObjectAtIndex:_selIndexPath.row];
                [commTableView.table deleteRowsAtIndexPaths:[NSArray arrayWithObject:_selIndexPath] withRowAnimation:UITableViewRowAnimationFade];
                _commentTotal--;
                SDTimeLineCellCommentItemModel *Model=[[SDTimeLineCellCommentItemModel alloc]initWith:mod1];
                
                if ([self.commentDelegate respondsToSelector:@selector(disPlayComment:indexPath: isAdd:)]) {
                    [self.commentDelegate disPlayComment:Model indexPath:self.indexPath isAdd:NO];
                }
            }
        }
    }
}

#pragma mark - ChatViewControllerDelegate

// 根据环信id得到要显示头像路径，如果返回nil，则显示默认头像
- (NSString *)avatarWithChatter:(NSString *)chatter{
    NSString *str=[NSString stringWithFormat:@"%@%@",_model.userChildrenInfo.heed_image_url,smallHeaderImage];
    NSString *userID=[_model.userChildrenInfo.hx_user_name lowercaseString];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
