//
//  MTSupplyDetailsViewController.m
//  MiaoTuProject
//
//  Created by dzb on 2019/4/11.
//  Copyright © 2019 听花科技. All rights reserved.
//

#import "ShareSheetView.h"
#import "InputKeyBoardView.h"
#import "MTCommentListModel.h"
#import "IHTextBaseTextField.h"
#import "MTSupplyDetailsModel.h"
#import "MTSupplyDetailHeader.h"
#import "MTCommentTableViewCell.h"
#import "MTSupplySectionHeaderView.h"
#import "MTSupplyDetailsViewController.h"
#import "MTOtherInfomationMainViewController.h"

@interface MTSupplyDetailsViewController () <UITableViewDelegate,UITableViewDataSource,MTCommentTableViewCellDelegate,MTSupplySectionHeaderViewDelegate> {
	NSInteger _pageNo;
	IHTextField *_pltxt;
	NSIndexPath *_selectIndexPath;
}

///tableView
@property (nonatomic,strong) UITableView *tableView;
///detailModel
@property (nonatomic,strong) MTSupplyDetailsModel *detailModel;
///headerView
@property (nonatomic,strong) MTSupplyDetailHeader *headerView;
///keyBoardView
@property (nonatomic,strong) InputKeyBoardView *keyBoardView;
///agreeList
@property (nonatomic,strong) NSMutableArray <NSMutableDictionary *> *agreeList;
///commentListArray
@property (nonatomic,strong) NSMutableArray <MTCommentListModel *> *commentListArray;

@end

@implementation MTSupplyDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self _setupTableView];
	[self _setupFooterView];
	[self _setupTextInputView];
	[self _requestSupplyDetails];
	[self _reqeustSupplyAgreeList];
	[self _requestSupplyCommentList];
}

- (UITableView *)tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
		_tableView.delegate = self;
		_tableView.dataSource = self;
		_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	}
	return _tableView;
}


- (NSMutableArray<MTCommentListModel *> *)commentListArray {
	if (!_commentListArray) {
		_commentListArray = [NSMutableArray array];
	}
	return _commentListArray;
}

- (MTSupplyDetailHeader *) _createTableViewHeaderView {
	MTSupplyDetailHeader *headerView = [[MTSupplyDetailHeader alloc] init];
	return headerView;
}

- (void) _setupTableView {
	
	self.title = @"供应详情";
	self->_pageNo = 0;
	[self setRightButtonImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
	[self.view addSubview:self.tableView];
	[self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0.0f, 0.0f,50.0f, 0.0f));
	}];
	[self _updateTableViewHeader];
	[self.tableView registerClass:[MTSupplySectionHeaderView class] forHeaderFooterViewReuseIdentifier:@"MTSupplySectionHeaderView"];
	self.tableView.estimatedSectionHeaderHeight = 118.0f;
	self.tableView.estimatedRowHeight = 44.0f;
	[self.tableView registerClass:[MTCommentTableViewCell class] forCellReuseIdentifier:@"MTCommentTableViewCell"];
	[self _addHeaderRefresh];
	
}

- (void) _updateTableViewHeader {
	CGFloat height = (self.detailModel.rowHeight != 0.0f) ? self.detailModel.rowHeight : 1100.0f;
	[self.tableView beginUpdates];
	self.headerView = [[MTSupplyDetailHeader alloc] initWithFrame:CGRectMake(0.0f, 0.0f,iPhoneWidth,height)];
	self.headerView.detailsModel = self.detailModel;
	self.tableView.tableHeaderView = self.headerView;
	[self.tableView endUpdates];
}

- (void) _setupTextInputView {
	
	IHTextField *txt = [[IHTextField alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 0)];
	_pltxt = txt;
	[self.view addSubview:txt];
	
	__weak typeof(self)weakSelf = self;
	_keyBoardView = [[InputKeyBoardView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight)  submit:^(NSString *str) {
		__strong typeof(weakSelf)strongSelf = weakSelf;
		[strongSelf createComment:str];
	} back:^{
		__strong typeof(weakSelf)strongSelf = weakSelf;
		[strongSelf resignKeyBoard];
	}];
	_keyBoardView.lbl.text = @"留言";
	txt.inputAccessoryView =_keyBoardView;
	
}

- (void)home:(id)sender {
	
	ShareSheetView  *shareView=[[ShareSheetView alloc]initWithShare];
	shareView.selectShareMenu=^(NSInteger index){
		NSString *sharUrl = [NSString stringWithFormat:@"%@%@%@&appkey=%@",shareURL,shareSupply,self.newsId,APP_KEY];
		NSString *imgUrl = @"";
		NSString *title;
		NSString *content;
		NSArray *arr=[network getJsonForString:self.detailModel.supplyUrl];
		if (arr.count>0) {
			MTPhotosModel *mod=[[MTPhotosModel alloc]initWithDic:arr[0]];
			imgUrl=mod.thumbUrl;
		}
		title = [NSString stringWithFormat:@"供应-%@",self.detailModel.varieties];
		content = [NSString stringWithFormat:@"单价:%f\n数量:%ld",self.detailModel.unitPrice,(long)self.detailModel.number];
		[IHUtility SharePingTai:title url:sharUrl imgUrl:imgUrl content:content PlatformType:index controller:self completion:nil];

	};
	[shareView show];

}

- (void) _setupFooterView {
	
	UIView *footerView = [[UIView alloc] init];
	footerView.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:footerView];
	[footerView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.bottom.left.equalTo(self.view);
		make.size.mas_equalTo(CGSizeMake(iPhoneWidth,50.0f));
	}];
	
	UIButton *telephoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
	telephoneButton.backgroundColor =  [UIColor colorWithRed:41.0f/255.0 green:218.0f/255.0 blue:162.0f/255.0 alpha:1.0];
	[telephoneButton addTarget:self action:@selector(telephoneButtonAction:) forControlEvents:UIControlEventTouchUpInside];
	telephoneButton.layer.cornerRadius = 20.0f;
	[telephoneButton setTitle:@"电话" forState:UIControlStateNormal];
	[telephoneButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
	telephoneButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
	[footerView addSubview:telephoneButton];
	[telephoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.center.equalTo(footerView);
		make.size.mas_equalTo(CGSizeMake(220.0f, 40.0f));
	}];
	
}


#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.commentListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	MTCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MTCommentTableViewCell"];
	cell.commentModel = [self.commentListArray objectAtIndex:indexPath.row];
	cell.delegate = self;
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return UITableViewAutomaticDimension;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	MTSupplySectionHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MTSupplySectionHeaderView"];
	headerView.detailsModel = self.detailModel;
	headerView.agreeList = self.agreeList;
	headerView.delegate = self;
	return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	MTCommentListModel *commentModel = [self.commentListArray objectAtIndex:indexPath.row];
	if (commentModel.userChildrenInfo.userId == USERMODEL.userID.integerValue) return;
	_selectIndexPath = indexPath;
	[self becomeKeyBoard];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	return 15.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
	UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"kHeaderFooterViewIdentifier"];
	if (footerView == nil) {
		footerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"kHeaderFooterViewIdentifier"];
		footerView.contentView.backgroundColor = RGB(247.0f, 247.0f, 247.0f);
	}
	return footerView;
}

#pragma mark - network

/**
 供应接口详情
 */
- (void) _requestSupplyDetails {
	
	[self addPushViewWaitingView];
	[network getQuerySupplyComment:self.newsId success:^(NSDictionary *obj) {
		[self removePushViewWaitingView];
		NSDictionary *dict = obj[@"content"];
		MTSupplyDetailsModel *detailsModel = [[MTSupplyDetailsModel alloc] initWithDictionary:dict];
		self.detailModel = detailsModel;
		[self _updateTableViewHeader];
		[self.tableView reloadData];
	} failure:^(NSDictionary *obj2) {
		[self removePushViewWaitingView];
	}];
    
}

/**
 评论列表
 */
- (void) _requestSupplyCommentList {
	
	[network getQuerySupplyCommentList:(int)self->_pageNo maxResults:10 supplyID:self.newsId success:^(NSDictionary *obj) {
		[self _endHeaderRefresh];
		NSArray *array = obj[@"content"];
		NSMutableArray *temp = [NSMutableArray array];
		NSMutableArray <NSIndexPath *> *indexPaths = [NSMutableArray array];
		for (int i = 0; i<array.count; i++) {
			NSDictionary *dic = [array objectAtIndex:i];
			MTCommentListModel *commentModel = [[MTCommentListModel alloc] initWithDictionary:dic];
			[temp addObject:commentModel];
			NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.commentListArray.count-1 inSection:0];
			[indexPaths addObject:indexPath];
		}
		if (self->_pageNo == 0) {
			self.commentListArray = temp;
			[self.tableView reloadData];
		} else {
			[self.commentListArray addObjectsFromArray:temp];
			[self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
		}
		
	} failure:^(NSDictionary *obj2) {
		[self _endHeaderRefresh];
	}];

}

/**
 详情点赞数量
 */
- (void) _reqeustSupplyAgreeList {
	
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	params[@"model"] = @"1";
	params[@"business_id"] = self.newsId;
	params[@"num"] = @"10";
	params[@"page"] = @"0";
	[network httpRequestWithParameter:params method:@"openModel/selectClickLikeUserByBusinessId" success:^(id responseObject) {
		NSArray *agreeList = responseObject[@"content"];
		if ([agreeList isKindOfClass:[NSArray class]]) {
			self.agreeList = [agreeList mutableCopy];
		} else {
			self.agreeList = [NSMutableArray array];
		}
		[self.tableView reloadData];
	} failure:^(id data) {
		
	}];
	
}

#pragma mark - MTCommentTableViewCellDelegate

/**
 点击了评论上用户名昵称 跳转到个人中心
 */
- (void) commentCell:(MTCommentTableViewCell *_Nullable)cell
	 tapUserNickname:(NSString *_Nullable)nickname
			  userId:(NSInteger)userId {
	
	[self addWaitingView];
	[network selectUseerInfoForId:userId
						  success:^(NSDictionary *obj) {
							  MTNearUserModel *mod = [[MTNearUserModel alloc]initWithDictionary:obj[@"content"] error:nil];
							  UserChildrenInfo *usermodel=[[UserChildrenInfo alloc]initWithModel:mod];
							  [network selectUserCloudInfoById:[USERMODEL.userID intValue]follow_id:[usermodel.user_id intValue]success:^(NSDictionary *obj) {
								  [self removeWaitingView];
								  MTOtherInfomationMainViewController *controller = [[MTOtherInfomationMainViewController alloc]initWithUserID:usermodel.user_id :NO dic:obj[@"content"]];
								  controller.userMod = usermodel;
								  controller.dic = obj[@"content"];
								  [self pushViewController:controller];
							  } failure:^(NSDictionary *obj2) {
								  
							  }];
						  } failure:^(NSDictionary *obj2) {
							  
						  }];

}


/**
 删除评论或者回复
 */
- (void) commentCell:(MTCommentTableViewCell *)cell deleteComment:(MTCommentListModel *)commentModel {
	[self addWaitingView];
	[network getDeleteSupplyCommentID:(int)commentModel.commentId userID:USERMODEL.userID success:^(NSDictionary *obj) {
		[self removeWaitingView];
		NSInteger errorNo = [[obj objectForKey:@"errorNo"] integerValue];
		if (errorNo == 0) {
			NSInteger row = [self.commentListArray indexOfObject:commentModel];
			[self.commentListArray removeObject:commentModel];
			[self.tableView beginUpdates];
			[self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
			[self.tableView endUpdates];
		}
	}];
}


#pragma mark - MTSupplySectionHeaderViewDelegate

/**
 tap nickname action
 */
- (void) supplySectionHeaderView:(MTSupplySectionHeaderView *_Nullable)headerView
		   tapUserNicknameAction:(NSString *_Nullable)nickname
						  userid:(NSInteger)userid {
	[self commentCell:nil tapUserNickname:nickname userId:userid];
}

/**
 按钮点赞
 */
- (void)supplySectionHeaderView:(MTSupplySectionHeaderView *)headerView agreeButtonAction:(BOOL)isLike {
	
	[network getAddSupplyClickLike:[USERMODEL.userID intValue] supply_id:[self.newsId intValue] type:!isLike success:^(NSDictionary *obj) {
		NSInteger errorNo = [[obj objectForKey:@"errorNo"] integerValue];
		if (errorNo == 0) {
			[self _reqeustSupplyAgreeList];
		}
	}];
	
}


/**
 评论点击事件
 */
- (void)supplySectionHeaderViewTapCommentAction:(MTSupplySectionHeaderView *)headerView {
	[self becomeKeyBoard];
}

#pragma mark - 评论相关操作

/**
 隐藏键盘输入
 */
- (void) resignKeyBoard {
	[_keyBoardView.txtView resignFirstResponder];
	[_pltxt resignFirstResponder];
}

-(void)becomeKeyBoard {
	if (!USERMODEL.isLogin) {
		[self prsentToLoginViewController];
		return ;
	}
	[_pltxt becomeFirstResponder];
	[_keyBoardView.txtView becomeFirstResponder];
	_keyBoardView.txtView.text = @"";
}

//评论列表
-(void)createComment:(NSString *)content {
	
	[self addWaitingView];
	int replyUserId = 0;
	int supply_comment_id = 0;
	int comment_type = 0;
	int reply_supply_comment_id = 0;
	NSString *nickname = nil;
	BOOL isReply = _selectIndexPath;
	if (isReply) { //回复评论
		MTCommentListModel *commentModel = [self.commentListArray objectAtIndex:_selectIndexPath.row];
		comment_type = 1;
		replyUserId = (int)commentModel.userChildrenInfo.userId;
		nickname = commentModel.userChildrenInfo.nickname;
		reply_supply_comment_id = (int)commentModel.commentId;
		_selectIndexPath = nil;
	} else { //评论详情
		replyUserId = (int)self.detailModel.userChildrenInfo.userId;
		nickname = self.detailModel.userChildrenInfo.nickname;
	}
	
	[network getAddSupplyComment:[self.newsId intValue]
						 user_id:[USERMODEL.userID intValue]
				   reply_user_id:(int)replyUserId
			   supply_comment_id:supply_comment_id
				  reply_nickname:nickname
				  supply_comment:content
					comment_type:comment_type
		 reply_supply_comment_id:reply_supply_comment_id
						 success:^(NSDictionary *obj) {
							 [self removeWaitingView];
							 NSInteger errorNo = [[obj objectForKey:@"errorNo"] integerValue];
							 if (errorNo == 0) {
								 NSDictionary *commentInfo = obj[@"content"][@"commentInfo"];
								 MTCommentListModel *commentModel = [[MTCommentListModel alloc] initWithDictionary:commentInfo];
								 [self.commentListArray insertObject:commentModel atIndex:0];
								 [self.tableView beginUpdates];
								 [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
								 [self.tableView endUpdates];
							 }
						 }];
	

}

/**
 拨打电话
 */
- (void) telephoneButtonAction:(UIButton *)button {
	if (self.detailModel.userChildrenInfo.userId == USERMODEL.userID.integerValue) {
		[IHUtility addSucessView:@"你不能跟自己打电话" type:3];
		return;
	}
	NSURL *telUrl = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.detailModel.userChildrenInfo.mobile]];
	[[UIApplication sharedApplication] openURL:telUrl];
}

- (void) _addHeaderRefresh {
	__weak typeof(self)weakSelf = self;
	self.tableView.mj_header = [MiaoTuHeader headerWithRefreshingBlock:^{
		__strong typeof(weakSelf)strongSelf = weakSelf;
		strongSelf->_pageNo = 0;
		[strongSelf _requestSupplyCommentList];
	}];
	self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
		__strong typeof(weakSelf)strongSelf = weakSelf;
		strongSelf->_pageNo += 1;
		[strongSelf _requestSupplyCommentList];
	}];
}

- (void) _endHeaderRefresh {
	[self.tableView.mj_header endRefreshing];
	[self.tableView.mj_footer endRefreshing];
}

@end
