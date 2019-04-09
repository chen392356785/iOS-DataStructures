//
//  ActivityViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/5/4.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "ActivityListViewController.h"
#import "ActivityDetailViewController.h"
#import "ActivRegistrationViewController.h"
#import "ActivPaymentViewController.h"
//#import "UINavigationBar+Awesome.h"
#import "ActivtiesVoteViewController.h"
#import "CrowdFundingViewController.h"
#import "PayMentMangers.h"
#import "THNotificationCenter+C.h"
#import "MJPopView.h"
#import "ActivesCrowdFundController.h"          //众筹界面

#import "WCQRCodeVC.h"                      //扫一扫
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface ActivityListViewController ()<UITableViewDelegate,UIAlertViewDelegate,GongQiuAgreeDelegate,CrowdSuccesssDelegate,CCAppDelegate_C>
{
	MTBaseTableView *commTableView;
	int page;
	NSMutableArray *dataArray;
	NSIndexPath *_indexPath;
	UIView *_lineVew;
	NSString * type_c;
	UIView *_topView;
	EmptyPromptView *_EPView;//没有活动的时候默认的提示
	NSString * huodongzhuangtai;
}
@property (nonatomic,copy) UITableView *tableView;
@property (nonatomic, strong) UIScrollView * bgScroll;

@property (nonatomic, strong) NSTimer *timer; //定时器
@property (nonatomic, weak) UIView *viewAnima; //Label的背景
@property (nonatomic, weak) UILabel *customLabel; //Label
@property (nonatomic, strong) UIImageView *imageView;


@end

@implementation ActivityListViewController

#define scrollText @"如需申请发布活动请访问苗途官网:www.miaoto.net"

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[MobClick beginLogPageView:@"活动列表"];
	//    [self beginRefesh:ENT_RefreshHeader];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	[MobClick endLogPageView:@"活动列表"];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = cBgColor;
	self.automaticallyAdjustsScrollViewInsets = NO;
	[[THNotificationCenter singleton]addDeletegate:self];
	
	// Do any additional setup after loading the view.
	if ([self.type isEqualToString:@"1"]) {
		// [self setTitle:@"活动列表"];
		self.title = @"活动列表";
	}else {
		[self setTitle:@"我参与的活动"];
	}
	
	[self creatTableView];
	
	//如果为我的活动列表  支付成功会发送通知
	if ([self.type isEqualToString:@"2"]) {
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccess:) name:@"paySuccess" object:nil];
	}
}
-(void)SelectType:(UIButton*)sender{
	
	MJPopView *popView=[[MJPopView alloc]initWithOrgin:sender.bottom+KStatusBarHeight - 20 + 8 x:iPhoneWidth - 110 arr:@[@"全部",@"进行中",@"未开始",@"已截止"] i:4 img:Image(@"img_sx.png")];
	
	popView.selectBlock=^(NSInteger index){
		if (index == 0) {
			self->huodongzhuangtai = @"";
		}else if (index == 1) {
			self->huodongzhuangtai = @"3";
		}else if (index == 2) {
			self->huodongzhuangtai = @"2";
		}else {
			self->huodongzhuangtai = @"1";
		}
		int selectedIndx = self.bgScroll.contentOffset.x/WindowWith;
		self->commTableView = [self.bgScroll viewWithTag:selectedIndx+100];
		[self->commTableView.table.mj_header beginRefreshing];
	};
	[self.view addSubview:popView];
}
-(void)creatTableView
{
	//    [self addClildView];
	
	huodongzhuangtai = @"";
	/*
	 UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, maxY(self.viewAnima), WindowWith, 49)];
	 topView.backgroundColor = [UIColor whiteColor];
	 _topView = topView;
	 UIView *lineVew = [[UIView alloc] initWithFrame:CGRectMake(0, 48, WindowWith/4., 1)];
	 lineVew.backgroundColor = RGB(6, 183, 174);
	 _lineVew = lineVew;
	 [topView addSubview:lineVew];
	 NSArray *arr = @[@"全部",@"活动",@"众筹",@"投票"];
	 for (int i =0; i<arr.count; i++) {
	 UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(WindowWith/arr.count*i, 0, WindowWith/arr.count, 48)];
	 [button setTitle:arr[i] forState:UIControlStateNormal];
	 [button setTitleColor:cBlackColor forState:UIControlStateNormal];
	 [button setTitleColor:RGB(6, 193, 174) forState:UIControlStateSelected];
	 button.titleLabel.font = sysFont(16);
	 [button addTarget:self action:@selector(activtyType:) forControlEvents:UIControlEventTouchUpInside];
	 if (i==0) {
	 button.selected = YES;
	 _lineVew.centerX = button.center.x;
	 }
	 button.tag = 10+i;
	 [topView addSubview:button];
	 }
	 [self.view addSubview:topView];
	 self.bgScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, topView.bottom, WindowWith, WindowHeight-49 - 39)];
	 self.bgScroll.contentSize = CGSizeMake(WindowWith*arr.count, 0);
	 //*/
	self.bgScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight - 39)];
	self.bgScroll.contentSize = CGSizeMake(WindowWith, 0);
	self.bgScroll.delegate = self;
	self.bgScroll.pagingEnabled = YES;
	self.bgScroll.showsHorizontalScrollIndicator = NO;
	[self.view addSubview:self.bgScroll];
	self.bgScroll.bounces = NO;
	page = 1;
	type_c = @"";
	dataArray = [[NSMutableArray alloc]init];
	//    for (int i= 0 ; i < arr.count ; i ++) {
	for (int i= 0 ; i < 1 ; i ++) {
		MTBaseTableView * commTableView1 = [[MTBaseTableView alloc]initWithFrame:CGRectMake(i * WindowWith, 0, WindowWith, height(self.bgScroll)) tableviewStyle:UITableViewStylePlain];
		commTableView1.attribute=self;
		commTableView1.table.backgroundColor = cLineColor;
		commTableView1.table.delegate=self;
		commTableView1.actvType = self.type;
		commTableView1.tag = 100 + i;
		[commTableView1 setupData:dataArray index:18];
		
		[self.bgScroll addSubview:commTableView1];
		
	}
	
	//    if (![self.type isEqualToString:@"1"]) {
	
	//        commTableView.frame = CGRectMake(0, 49, WindowWith, WindowHeight-49);
	//    }
	
	commTableView = [self.bgScroll viewWithTag:100];
	[self CreateBaseRefesh:commTableView type:ENT_RefreshAll successRefesh:^(MJRefreshComponent *refreshView) {
		[self loadRefesh:refreshView];
	}];
	NSString *context;
	context = @"别急,一大半活动正快马赶来~";
	
	EmptyPromptView *EPView  = [[EmptyPromptView alloc] initWithFrame:commTableView.table.frame context:context];
	EPView.hidden = YES;
	_EPView = EPView;
	[commTableView.table addSubview:EPView];
	
	[commTableView.table.mj_header beginRefreshing];
	//    [self beginRefesh:ENT_RefreshHeader];
	
	//    [self setRightNavigationItm];
	/*
	 [self setRightButtonImage:Image(@"shaixuan.png") forState:UIControlStateNormal];
	 [rightbutton setTitleColor:cGreenColor forState:UIControlStateNormal];
	 rightbutton.frame=CGRectMake(iPhoneWidth - 60, 0, 44, 44);
	 rightbutton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
	 [rightbutton addTarget:self action:@selector(SelectType:) forControlEvents:UIControlEventTouchUpInside];
	 //*/
	
}
#pragma mark - 扫一扫
- (void)setRightNavigationItm {
	UIImage *ScanImg=Image(@"icon_sys");
	UIButton *ScanGRBtn=[UIButton buttonWithType:UIButtonTypeCustom];
	ScanGRBtn.frame=CGRectMake(0, 0, 60, 44);
	[ScanGRBtn addTarget:self action:@selector(ScanGRCode) forControlEvents:UIControlEventTouchUpInside];
	[ScanGRBtn setImage:ScanImg forState:UIControlStateNormal];
	[ScanGRBtn setTitle:@"扫一扫" forState:UIControlStateNormal];
	[ScanGRBtn setTitleColor:kColor(@"#333333") forState:UIControlStateNormal];
	ScanGRBtn.titleLabel.font = sysFont(11);
	//调整图片和文字上下显示
	ScanGRBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
	ScanGRBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//使图片和文字垂直居中显示
	[ScanGRBtn setTitleEdgeInsets:UIEdgeInsetsMake(ScanGRBtn.imageView.frame.size.height +3 ,-ScanGRBtn.imageView.frame.size.width+15, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
	[ScanGRBtn setImageEdgeInsets:UIEdgeInsetsMake(-ScanGRBtn.imageView.frame.size.height+5, 15,0.0, -ScanGRBtn.titleLabel.bounds.size.width)];
	UIBarButtonItem *barBtn=[[UIBarButtonItem alloc]initWithCustomView:ScanGRBtn];
	self.navigationItem.rightBarButtonItems = @[barBtn];
}
#pragma mark - 扫一扫
- (void) ScanGRCode {
	WCQRCodeVC *WCVC = [[WCQRCodeVC alloc] init];
	if (!USERMODEL.isLogin) {
		//登录
		[self prsentToLoginViewController];
		return;
	}
	[self QRCodeScanVC:WCVC];
}
- (void)QRCodeScanVC:(UIViewController *)scanVC {
	AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
	if (device) {
		AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
		switch (status) {
			case AVAuthorizationStatusNotDetermined: {
				[AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
					if (granted) {
						dispatch_sync(dispatch_get_main_queue(), ^{
							
							[self pushViewController:scanVC];
						});
						NSLog(@"用户第一次同意了访问相机权限 - - %@", [NSThread currentThread]);
					} else {
						NSLog(@"用户第一次拒绝了访问相机权限 - - %@", [NSThread currentThread]);
					}
				}];
				break;
			}
			case AVAuthorizationStatusAuthorized: {
				[self pushViewController:scanVC];
				break;
			}
			case AVAuthorizationStatusDenied: {
				UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请去-> [设置 - 隐私 - 相机 - 苗途] 打开访问开关" preferredStyle:(UIAlertControllerStyleAlert)];
				UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
					ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
					if (author ==kCLAuthorizationStatusRestricted || author ==kCLAuthorizationStatusDenied){
						//无权限 引导去开启
						NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
						if ([[UIApplication sharedApplication] canOpenURL:url]) {
							//如果点击打开的话，需要记录当前的状态，从设置回到应用的时候会用到
							[[UIApplication sharedApplication] openURL:url];
						}
					}
				}];
				
				[alertC addAction:alertA];
				[self presentViewController:alertC animated:YES completion:nil];
				break;
			}
			case AVAuthorizationStatusRestricted: {
				NSLog(@"因为系统原因, 无法访问相册");
				break;
			}
				
			default:
				break;
		}
		return;
	}
	
	UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"未检测到您的摄像头" preferredStyle:(UIAlertControllerStyleAlert)];
	UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
		
	}];
	
	[alertC addAction:alertA];
	[self presentViewController:alertC animated:YES completion:nil];
}
#pragma mark -

#pragma mark - 添加滚动文字
- (void) addClildView {
	UIView *viewAnima = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, 35)];
	viewAnima.backgroundColor = kColor(@"#fffeec");
	self.viewAnima = viewAnima;
	self.viewAnima.clipsToBounds = YES; //剪掉超出view范围部分
	
	self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth(16), 0, 15, 15)];
	self.imageView.image = Image(@"tongz");
	self.imageView.centerY = self.viewAnima.centerY;
	[self.viewAnima addSubview:self.imageView];
	
	UIView *customBgView = [[UIView alloc] initWithFrame:CGRectMake(maxX(self.imageView) + 5, 0, iPhoneWidth - maxY(self.imageView) - 3, height(self.viewAnima))];
	customBgView.clipsToBounds = YES;
	
	[self.viewAnima addSubview:customBgView];
	CGSize size = [scrollText boundingRectWithSize:CGSizeMake(iPhoneWidth,300) options:0 attributes:@{NSFontAttributeName : sysFont(15.0f)} context:NULL].size;
	//CGSize size = [scrollText sizeWithFont:sysFont(15)];
	UILabel *customLabel = [[UILabel alloc]initWithFrame:CGRectMake( iPhoneWidth/2 - 50., 0, size.width, 20)];
	customLabel.font = sysFont(15);
	customLabel.text = scrollText;
	customLabel.centerY = self.viewAnima.centerY;
	customLabel.textColor = kColor(@"#ff7225");
	self.customLabel = customLabel;
	
	[self.view addSubview:viewAnima];
	[customBgView addSubview:customLabel];
	[self setTimer];
}
- (void)setTimer {
	self.timer = [NSTimer scheduledTimerWithTimeInterval:0.015 target:self selector:@selector(changePos) userInfo:nil repeats:YES];
	[[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)changePos {
	
	CGPoint cenPos = self.customLabel.center;
	if (cenPos.x < - (width(self.customLabel)/2) + maxY(self.imageView)) {
		
		CGFloat distance = self.customLabel.frame.size.width/2;
		self.customLabel.centerX = self.viewAnima.frame.size.width+distance;
	} else {
		self.customLabel.centerX = cenPos.x-.5;
	}
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (dataArray.count > 0 && indexPath.row < dataArray.count) {
		ActivitiesListModel *model = [dataArray objectAtIndex:indexPath.row];
		return [model.cellHeigh floatValue];
	}else {
		return 0.001;
	}
	
}

-(void)home:(id)sender
{
	//    NSString *phoneString = [NSString stringWithFormat:@"tel:400-077-9991"];
	//    UIWebView * callWebview = [[UIWebView alloc] init];
	//    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:phoneString]]];
	//    [self.view addSubview:callWebview];
}

#pragma mark cell分支点击事件
-(void)BCtableViewCell:(IHTableViewCell *)cell action:(BCTableViewCellAction)action indexPath:(NSIndexPath *)indexPath attribute:(NSObject *)attribute{
	ActivitiesListModel *mod=[dataArray objectAtIndex:indexPath.row];
	
	if (action==MTActivityBMTableViewCell) {
		//点击立即报名
		ActivRegistrationViewController *activRegistrationVC = [[ActivRegistrationViewController alloc] init];
		activRegistrationVC.model = mod;
		activRegistrationVC.type = self.type;
		activRegistrationVC.indexPath = indexPath;
		[self pushViewController:activRegistrationVC];
		
	}else if (action == MTActivityBMZFTableViewCell){
		//点击立即支付
		[self payWith:mod indexPath:indexPath];
		
	}else if(action == MTActivityQXBMTableViewCell){
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"是否取消报名该活动" message:@"" delegate:self cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
		self.orderId = mod.a_order_id;
		_indexPath = indexPath;
		[alert show];
		
	}else if (action == MTActivityBMYZFTableViewCell){
		
		ActivityPaySuccessfulViewController *vc=[[ActivityPaySuccessfulViewController alloc]init];
		vc.model = mod;
		vc.indexPath = indexPath;
		[self pushViewController:vc];
	}else if (action == MTActivityShareActivTableViewCell){
		
		//活动列表分享
		if (!USERMODEL.isLogin) {
			[self prsentToLoginViewController];
			return ;
		}
		if ([IHUtility overtime:mod.curtime inputDate:mod.activities_expiretime]) {
			[self addSucessView:@"该活动已过期" type:2];
		}else {
			
			[self shareView:ENT_Activties object:mod vc:self];
		}
		
	}else if (action == MTActivityCollectBMTableViewCell){
		
		//活动收藏
		
		if (!USERMODEL.isLogin) {
			[self prsentToLoginViewController];
			return ;
		}
		
		[network getAddActivtiesClickLike:[USERMODEL.userID intValue] activities_id:[mod.activities_id intValue]  success:^(NSDictionary *obj) {
			mod.hasClickLike = @"1";
			mod.clickLikeTotal = [NSString stringWithFormat:@"%d",[mod.clickLikeTotal intValue] + 1];
			[self addSucessView:@"点赞成功" type:1];
			NSArray *indexArray=[NSArray arrayWithObject:indexPath];
			[self->commTableView.table reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
		}];
	}
}

- (void)payWith:(ActivitiesListModel *)model indexPath:(NSIndexPath *)indexPath{
	ActivPaymentViewController *paymentVC = [[ActivPaymentViewController alloc] init];
	paymentVC.model = model;
	paymentVC.indexPath = indexPath;
	paymentVC.orderType = self.type;
	
	PayMentMangers *paymentManager = [[PayMentMangers alloc]init];
	paymentVC.payBlock = ^(NSString *price, NSString *orderNo, NSString *type, NSString *subject, SMBaseViewController *vc) {
		[paymentManager payment:orderNo orderPrice:price type:type subject:subject activitieID:model.activities_id parentVC:vc resultBlock:^(BOOL isPaySuccess, NSString *msg) {
			if (isPaySuccess) {
				[self pushToPaySuccessfulVC:model indexPath:indexPath];
			}
		}];
	};
	[self pushViewController:paymentVC];
}

- (void)pushToPaySuccessfulVC:(ActivitiesListModel *)model indexPath:(NSIndexPath *)indexPath{
	ActivityPaySuccessfulViewController *vc=[[ActivityPaySuccessfulViewController alloc]init];
	vc.indexPath = indexPath;
	vc.model = model;
	[self pushViewController:vc];
	[[NSNotificationCenter defaultCenter]postNotificationName:@"paySuccess" object:indexPath];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	ActivitiesListModel *model = [dataArray objectAtIndex:indexPath.row];
	
	if ([model.model isEqualToString:@"7"]){
		//投票活动
		ActivtiesVoteViewController *vc = [[ActivtiesVoteViewController alloc] init];
		vc.model = model;
		vc.indexPath = indexPath;
		[self pushViewController:vc];
	}else if ([model.model isEqualToString:@"8"]){
		
		//众筹活动  type 1为活动列表进入详情  2 为我的活动列表进入众筹页
		if ([self.type isEqualToString:@"1"]) {
			ActivesCrowdFundController *CFVc = [[ActivesCrowdFundController alloc] init];
			CFVc.model = model;
			CFVc.indexPath = indexPath;
			CFVc.type = self.type;
			[self pushViewController:CFVc];
			
			/*  原V2.9.8众筹
			 ActivityDetailViewController *vc=[[ActivityDetailViewController alloc]init];
			 vc.model = model;
			 vc.indexPath = indexPath;
			 vc.type = self.type;
			 [self pushViewController:vc];
			 //*/
		}else {
			CrowdFundingViewController *vc = [[CrowdFundingViewController alloc] init];
			vc.crowdID = model.crowd_id;
			vc.Type = self.type;
			vc.delgate = self;
			vc.indexPath = indexPath;
			[self pushViewController:vc];
		}
	}else{
		
		ActivesCrowdFundController *vc=[[ActivesCrowdFundController alloc]init];
		vc.model = model;
		vc.indexPath = indexPath;
		vc.type = self.type;
		[self pushViewController:vc];
		
	}
}

-(void)backTopClick:(UIButton *)sender{
	[self scrollTopPoint:commTableView.table];
}
//切换活动类型
- (void)activtyType:(UIButton *)button
{
	if (button.selected == YES) {
		return;
	}
	button.selected = YES;
	for (int i = 0; i<4; i++) {
		UIButton *btn = [_topView viewWithTag:i+10];
		if (btn.tag != button.tag) {
			btn.selected= NO;
		}
	}
	self.bgScroll.contentOffset = CGPointMake((button.tag - 10)*WindowWith, 0);
	if (_EPView) {
		[_EPView removeFromSuperview];
	}
	_lineVew.centerX = button.center.x;
	
	NSString *str = @"别急,一大半活动正快马赶来~";
	huodongzhuangtai = @"";
	
	if ([button.titleLabel.text isEqualToString:@"全部"]) {
		type_c = @"";
	}
	if ([button.titleLabel.text isEqualToString:@"活动"]) {
		type_c = @"4";
	}else if ([button.titleLabel.text isEqualToString:@"众筹"]){
		type_c = @"8";
	}
	else if ([button.titleLabel.text isEqualToString:@"投票"]){
		type_c = @"7";
	}
	
	commTableView = [self.bgScroll viewWithTag:100 + button.tag - 10];
	_EPView = [[EmptyPromptView alloc] initWithFrame:commTableView.table.frame context:str];
	_EPView.hidden = YES;
	
	[commTableView.table addSubview:_EPView];
	[self CreateBaseRefesh:commTableView type:ENT_RefreshAll successRefesh:^(MJRefreshComponent *refreshView) {
		[self loadRefesh:refreshView];
	}];
	commTableView.table.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
	[commTableView.table.mj_header beginRefreshing];
	
}
-(void)loadRefesh:(MJRefreshComponent *)refreshView{
	
	int selectedIndx = self.bgScroll.contentOffset.x/WindowWith;
	commTableView = [self.bgScroll viewWithTag:selectedIndx+100];
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
	if ([self.type isEqualToString:@"1"]) {
		//活动列表
		if (self.typeId == nil) {
			self.typeId = @"";
		}
		NSDictionary *dic = @{
							  @"user_id"          :userID,
							  @"page"             : stringFormatInt(page),
							  @"num"              : @"10",
							  @"huodongzhuangtai" :huodongzhuangtai,
							  //                              @"type_id"           :self.typeId,      //分类
							  @"model"             : type_c,
							  };
		//        [self showWaitingHUD:@"加载中..."];
		[network getAllActivityList:dic success:^(NSDictionary *obj) {
			NSArray *arr=obj[@"content"];
			[self HUDHidden];
			
			if (refreshView == self->commTableView.table.mj_header) {
				
				[self->dataArray removeAllObjects];
				self->page=0;
				if (arr.count==0) {
					[self->dataArray addObjectsFromArray:arr];
					NSLog(@"111111111111111");
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
				//如果返回的数据为0 判断原先数组的数量来决定默认提示的显示与影藏
				if (self->dataArray.count == 0) {
					
					self->_EPView.hidden = NO;
				}else{
					self->_EPView.hidden = YES;
				}
				[self->commTableView.table.mj_footer endRefreshingWithNoMoreData];
				//                [self endRefresh];
				[self->commBaseTableView.table.mj_header endRefreshing];
				return;
			}
			
			[self->dataArray addObjectsFromArray:arr];
			[self->commTableView.table reloadData];
			if (self->dataArray.count == 0) {
				
				self->_EPView.hidden = NO;
			}else{
				self->_EPView.hidden = YES;
			}
			[self endRefresh];
		} failure:^(NSDictionary *obj2) {
			[self HUDHidden];
			[self endRefresh];
		}];
	}else {
		//我的活动列表
		[network getUserActivityList:[USERMODEL.userID intValue] page:page model:type_c num:10 success:^(NSDictionary *obj) {
			NSArray *arr=obj[@"content"];
			
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
				//如果返回的数据为0 判断原先数组的数量来决定默认提示的显示与影藏
				if (self->dataArray.count == 0) {
					
					self->_EPView.hidden = NO;
				}else{
					self->_EPView.hidden = YES;
				}
				[self->commTableView.table.mj_footer endRefreshingWithNoMoreData];
				[self endRefresh];
				return;
			}
			
			[self->dataArray addObjectsFromArray:arr];
			
			[self->commTableView.table reloadData];
			
			if (self->dataArray.count == 0) {
				
				self->_EPView.hidden = NO;
			}else{
				self->_EPView.hidden = YES;
			}
			[self endRefresh];
			
		} failure:^(NSDictionary *obj2) {
			
			[self endRefresh];
		}];
	}
	
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	//取消活动报名
	if (buttonIndex == 0) {
		[network cancleActivtiesOrder:self.orderId success:^(NSDictionary *obj) {
			
			ActivitiesListModel *mod=[self->dataArray objectAtIndex:self->_indexPath.row];
			mod.order_status = @"3";
			NSArray *indexArray=[NSArray arrayWithObject:self->_indexPath];
			[self->commTableView.table reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
		}];
	}
}
//支付成功之后的回调
- (void)paySuccess:(NSNotification *)notfication
{
	NSIndexPath *indexPath = notfication.object;
	ActivitiesListModel *mod=[dataArray objectAtIndex:indexPath.row];
	mod.order_status = @"1";
	
	NSArray *indexArray=[NSArray arrayWithObject:indexPath];
	[commTableView.table reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
	
}
//收藏活动的回调
-(void)disPlayActivtCollect:(ActivitiesListModel *)model indexPath:(NSIndexPath *)indexPath
{
	
	//    ActivitiesListModel *mod=[dataArray objectAtIndex:indexPath.row];
	NSArray *indexArray=[NSArray arrayWithObject:indexPath];
	[commTableView.table reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
}
//众筹成功的回调
#pragma mark -- CCAppDelegate_C
- (void)onCrowdSuccess:(NSIndexPath *)indexPath{
	[self crowdOnSuccessWith:indexPath];
}

#pragma mark -- CrowdSuccesssDelegate
- (void)crowdSuccessIndexPath:(NSIndexPath *)indexPath
{
	[self crowdOnSuccessWith:indexPath];
}

-(void)crowdOnSuccessWith:(NSIndexPath *)indexPath{
	ActivitiesListModel *mod=[dataArray objectAtIndex:indexPath.row];
	if ([self.type isEqualToString:@"2"]) {
		mod.crowd_status = @"1";
		mod.obtain_money = mod.total_money;
	}
	NSArray *indexArray=[NSArray arrayWithObject:indexPath];
	[commTableView.table reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark -- scrollviewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	[self endRefresh];
	
	if (scrollView == self.bgScroll) {
		NSInteger selectedIndx = scrollView.contentOffset.x/WindowWith;
		UIButton *button =  [_topView viewWithTag:selectedIndx+10];
		button.tag = selectedIndx + 10;
		if (button.selected == YES) {
			return;
		}
		button.selected = YES;
		for (int i = 0; i<4; i++) {
			UIButton *btn = [_topView viewWithTag:i+10];
			if (btn.tag != button.tag) {
				btn.selected= NO;
			}
		}
		if (selectedIndx == 0) {
			type_c = @"";
		}else if (selectedIndx == 1) {
			type_c = @"4";
		}else if (selectedIndx == 2) {
			type_c = @"8";
		}else {
			type_c = @"7";
		}
		if (_EPView) {
			[_EPView removeFromSuperview];
		}
		_lineVew.centerX = button.center.x;
		
		NSString *str = @"别急,一大半活动正快马赶来~";
		huodongzhuangtai = @"";
		if ([button.titleLabel.text isEqualToString:@"全部"]) {
			type_c = @"";
		}else if ([button.titleLabel.text isEqualToString:@"活动"]) {
			type_c = @"4";
		}else if ([button.titleLabel.text isEqualToString:@"众筹"]){
			type_c = @"8";
		}
		else if ([button.titleLabel.text isEqualToString:@"投票"]){
			type_c = @"7";
		}
		commTableView = [self.bgScroll viewWithTag:100 + button.tag - 10];
		
		_EPView = [[EmptyPromptView alloc] initWithFrame:commTableView.table.frame context:str];
		_EPView.hidden = YES;
		
		[commTableView.table addSubview:_EPView];
		
		[self CreateBaseRefesh:commTableView type:ENT_RefreshAll successRefesh:^(MJRefreshComponent *refreshView) {
			[self loadRefesh:refreshView];
		}];
		commTableView.table.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
		[commTableView.table.mj_header beginRefreshing];
	}
}

-(void)dealloc
{
	if ([self.type isEqualToString:@"2"]) {
		[[NSNotificationCenter defaultCenter] removeObserver:self name:@"paySuccess" object:nil];
	}
	[[THNotificationCenter singleton]removeDeletegate:self];
}

@end




