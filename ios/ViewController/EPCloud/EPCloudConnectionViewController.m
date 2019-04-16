//
//  EPCloudConnectionViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/7/12.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "EPCloudConnectionViewController.h"
#import "MTOtherInfomationMainViewController.h"
//#import "EditPersonInformationViewController.h"
#import "JionEPCloudViewController.h"
#import "CustomView+CustomCategory2.h"

@interface EPCloudConnectionViewController ()<UITableViewDelegate>
{
	MTBaseTableView *commTableView;
	MTBaseTableView *commTableView2;
	int page;
	NSMutableArray *dataArray;
//	NSIndexPath *_indexPath;
	
	
	AreaView *_areaV;
	MTLogisticsChooseView *_logisticsView;
	SearchView *_searchV;
	NSString *_provice;
//	NSString *_city;
	NSString *_scale;
//	NSString *_company_name;
//	int level;
//	int typeID;
	NSString *_tilte;
	int jobType;
	NSMutableDictionary *positionDic;
	NSMutableDictionary *titleDic;
	NSArray *_arr;
	NSString *_nickName;
	UIButton* _createBtn;
	UIView *_searchView;//搜索结果遮罩
	NSMutableArray *dataArray2;
	NSMutableArray *btnArray;//热门搜索或者附近的人
	NSArray *array;//附近的人
	
//	NSInteger btnIndex;//选择按钮的索引
	
}

@end

@implementation EPCloudConnectionViewController

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	// [self setRightButtonImage:Image(@"Search Icon.png") forState:UIControlStateNormal];
	//    if (dataArray.count!=0) {
	//        _nickName=@"";
	//        [self beginRefesh:ENT_RefreshHeader];
	//    }
	//
	if (![_nickName isEqualToString:@""]&&_nickName) {
		
		_searchV.textfiled.text=_nickName;
		_searchView.hidden=YES;
	}
	
	
	
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	[self setTitle:@"人脉"];
	
	// [self setRightButtonImage:Image(@"Search Icon.png") forState:UIControlStateNormal];
	_provice = @"";
//	_city = @"";
	jobType=0;
	_scale=@"desc";
//	_company_name = @"";
	_tilte=@"";
	_nickName=@"";
	positionDic=[[NSMutableDictionary alloc]init];
	titleDic=[[NSMutableDictionary alloc]init];
	
	
	[self creatTableView];
	
	
	
	
	__weak EPCloudConnectionViewController *weakSelf=self;
	
	
	SearchView *searchV = [[SearchView alloc] initWithFrame:CGRectMake(40, 0, WindowWith-40, 44)];
	searchV.textfiled.placeholder=@"请输入想找的人脉名";
	searchV.backgroundColor = [UIColor whiteColor];
	_searchV = searchV;
	searchV.selectBtnBlock=^(NSInteger index){
		if (index == SelectBackVC) {
			[weakSelf selectBack];
		}else if (index == SelectBtnBlock){
			[weakSelf selectBtn];
		}else if (index == openBlock){
			//开始编辑搜索框内容
			self->_searchView.hidden = NO;
			self->_searchV = searchV;
			//显示遮罩
			self->_searchView.hidden = NO;
			self->commTableView2.hidden=NO;
			NSArray *Arr2=[IHUtility getUserdefalutsList:kSearchHistory];
			
			[self->commTableView2 setupData:Arr2 index:45];
			if (Arr2.count==0) {
				self->commTableView2.hidden=YES;
			}
			
			
		}
	};
	//     self.navigationItem.titleView=searchV;
	[self.navigationController.navigationBar addSubview:searchV];
	
	UIButton* createBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
	createBtn.frame=CGRectMake(WindowWith/2-128/2, WindowHeight-60, 128, 38) ;
	[createBtn setTitle:@"+ 加入园林云" forState:UIControlStateNormal];
	_createBtn=createBtn;
	[createBtn setLayerMasksCornerRadius:20 BorderWidth:0.1 borderColor:cGreenColor];
	[createBtn setBackgroundColor:cGreenColor];
	createBtn.titleLabel.font=sysFont(15);
	[createBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	
	if (USERMODEL.auth_status!=2) {
		[self.view addSubview:createBtn];
	}
	
	
	[createBtn addTarget:self action:@selector(pushToVisitingCard) forControlEvents:UIControlEventTouchUpInside];
	
	dataArray2=[[NSMutableArray alloc]init];
	btnArray =[[NSMutableArray alloc]init];
	
	[network getQueryUserByList:2
							num:15
						   page:0
					   latitude:USERMODEL.latitude
					  longitude:USERMODEL.longitude
					   nickname:@""
						version:@"2"
						success:^(NSDictionary *obj) {
							
							NSArray *Arr=obj[@"content"];
							self->array = Arr;
							[self->btnArray removeAllObjects];
							for (MTNearUserModel *model in Arr) {
								[self->btnArray addObject:model.nickname];
							}
							//创建搜索历史和附近的人
							[self addSearchListView];
							
						} failure:^(NSDictionary *obj2) {
							
						}];
	
	
	
}

-(void)pushToVisitingCard{
	if (!USERMODEL.isLogin) {
		[self prsentToLoginViewController];
		return ;
	}
	
	JionEPCloudViewController *VC=[[JionEPCloudViewController alloc]init];
	
	[self pushViewController:VC];
	
	
}

-(void)backTopClick:(UIButton *)sender{
	[self scrollTopPoint:commTableView.table];
}



-(void)creatTableView
{
	
	//      [self setbackTopFrame:WindowHeight-60];
	NSArray *arr = @[@"区域",@"职位类别",@"头衔"];
	MTLogisticsChooseView *logisticsView=[[MTLogisticsChooseView alloc]initWithOrgane:CGPointMake(0, 0) array:arr];
	logisticsView.backgroundColor = [UIColor whiteColor];
	_logisticsView = logisticsView;
	[self.view addSubview:logisticsView];
	
	commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, logisticsView.bottom, WindowWith, WindowHeight - 43) tableviewStyle:UITableViewStylePlain];
	
	dataArray=[[NSMutableArray alloc]init];
	
	commTableView.attribute=self;
	commTableView.table.delegate=self;
	[commTableView setupData:dataArray index:33];
	commTableView.backgroundColor = cLineColor;
	
	__weak EPCloudConnectionViewController *weakSelf=self;
	
	[self CreateBaseRefesh:commTableView type:ENT_RefreshAll successRefesh:^(MJRefreshComponent *refreshView) {
		[weakSelf loadRefesh:refreshView];
	}];
	[self.view addSubview:commTableView];
	[self beginRefesh:ENT_RefreshHeader];
	
	NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
	
	NSMutableDictionary *dic2=[[NSMutableDictionary alloc]init];
	
	[network selectPublicDicInfo:1 success:^(NSDictionary *obj) {
		self->_arr=obj[@"content"];
		for (NSDictionary *dic in obj[@"content"]) {
			NSMutableArray *Arr=[[NSMutableArray alloc]init];
			NSArray *arr=dic[@"data"];
			for (NSDictionary *obj in arr) {
				[Arr addObject:obj[@"job_name"]];
				
			}
			
			[self->positionDic setObject:Arr forKey:dic[@"title"]];
			
			[dic1 setObject:self->positionDic forKey:@"position"];
			
		}
		
		
	} failure:^(NSDictionary *obj2) {
		
	}];
	
	
	[network selectPublicDicInfo:2 success:^(NSDictionary *obj) {
		
		for (NSDictionary *dic in obj[@"content"]) {
			NSMutableArray *Arr=[[NSMutableArray alloc]init];
			NSArray *arr=dic[@"data"];
			for (NSDictionary *obj in arr) {
				[Arr addObject:obj[@"title_name"]];
				
			}
			
			[self->titleDic setObject:Arr forKey:dic[@"title"]];
			
			[dic2 setObject:self->titleDic forKey:@"title"];
			
		}
		
		
		
	} failure:^(NSDictionary *obj2) {
		
	}];
	
	
	
	
	
	logisticsView.selectBtnBlock=^(NSInteger index,UIButton *btn){
		if (index==SelectStartBlock) {
			NSLog(@"start");
			NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"dataArea" ofType:@"plist"];
			NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
			[weakSelf addScreenView:dataDic grade:2 string:@"区域" sender:btn];
			
		}else if (index==SelectEntBlock){
			NSLog(@"end");
			[weakSelf addScreenView:dic1[@"position"] grade:1 string:@"职位类型" sender:btn];
			
			
		}else if (index==SelectTimeBlock){
			NSLog(@"time");
			
			[weakSelf addScreenView:dic2[@"title"] grade:1 string:@"头衔" sender:btn];
			
		}
	};
	
	
	
}

- (void)home:(id)sender
{
	__weak EPCloudConnectionViewController *weakSelf=self;
	
	SearchView *searchV = [[SearchView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, 44)];
	// searchV.backgroundColor = self.navigationController.navigationBar.backgroundColor;
	searchV.textfiled.placeholder=@"请输入想找的人脉名";
	
	//    __weak SearchView *searchSelf = searchV;
	searchV.selectBtnBlock = ^(NSInteger index){
		if (index == SelectBackVC) {
			[weakSelf selectBack];
		}else if (index == SelectBtnBlock){
			[weakSelf selectBtn];
		}else if (index == openBlock){
			//开始编辑搜索框内容
			self->_searchView.hidden = NO;
		}
		
	};
	
	//[self.navigationController.navigationBar addSubview:searchV];
	[searchV.textfiled becomeFirstResponder];
	
}
//点击取消
-(void)selectBack{
	__weak EPCloudConnectionViewController *weakSelf=self;
	__weak SearchView *searchSelf = _searchV;
	if (_nickName.length > 0) {
		_nickName = @"";
		searchSelf.textfiled.text=@"";
		//刷新列表
		[weakSelf beginRefesh:ENT_RefreshHeader];
	}
	//隐藏搜索遮罩
	_searchView.hidden = YES;
	[dataArray2 removeAllObjects];
	[searchSelf.textfiled resignFirstResponder];
	
	//rightbutton.hidden = NO;
	//[self back:nil];
	
}
//点击搜索
-(void)selectBtn{
	__weak EPCloudConnectionViewController *weakSelf=self;
	__weak SearchView *searchSelf = _searchV;
	
	_nickName = searchSelf.textfiled.text;
	_searchView.hidden = YES;
	//刷新列表
	[weakSelf beginRefesh:ENT_RefreshHeader];
	[weakSelf SaveSearchHistory:_nickName];
}



- (void)SaveSearchHistory:(NSString *)searchText
{
	
	NSArray *Arr=[IHUtility getUserdefalutsList:kSearchHistory];
	
	NSMutableArray *arr=[[NSMutableArray alloc]initWithArray:Arr];
	for (NSString *str in Arr) {
		if ([str isEqualToString:searchText]) {
			[arr removeObject:str];
		}
	}
	[arr addObject:searchText];
	[IHUtility saveUserDefaluts:arr key:kSearchHistory];
	
	commTableView2.hidden=NO;
	
	
	[commTableView2 setupData:arr index:45];
	
	
}




- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	[_searchV removeFromSuperview];
	
	//隐藏遮罩
	_searchView.hidden = YES;
	[dataArray2 removeAllObjects];
	
}


- (void)addScreenView:(NSDictionary *)dic grade:(int)grade string:(NSString *)str sender:(UIButton *)sender
{
	__weak EPCloudConnectionViewController *weakSelf=self;
	
	if (sender.selected) {
		
		if (_areaV) {
			[_areaV removeFromSuperview];
		}
		AreaView *areaV = [[AreaView alloc] initWithFrame:CGRectMake(0, -(WindowHeight- _logisticsView.bottom), WindowWith, WindowHeight- _logisticsView.bottom) dataDic:dic grade:grade];
		_areaV=areaV;
		areaV.backgroundColor = RGBA(0, 0, 0, 0);
		areaV.selectBtnBlock=^(NSInteger index){
			
		};
		areaV.selectBlock = ^(NSString *provice,NSString *city){
			sender.selected = NO;
			if (grade == 1) {
				if (city.length > 0) {
					[sender setTitle:city forState:UIControlStateNormal];
					[sender setTitleColor:cGreenColor forState:UIControlStateNormal];
				}else
				{
					if (city) {
						[sender setTitle:str forState:UIControlStateNormal];
						[sender setTitleColor:cGrayLightColor forState:UIControlStateNormal];
					}
				}
			}else{
				if (provice.length > 0) {
					[sender setTitle:provice forState:UIControlStateNormal];
					[sender setTitleColor:cGreenColor forState:UIControlStateNormal];
				}else
				{
					if (provice) {
						[sender setTitle:str forState:UIControlStateNormal];
						[sender setTitleColor:cGrayLightColor forState:UIControlStateNormal];
					}
					
				}
			}
			CGSize size = [IHUtility GetSizeByText:sender.titleLabel.text sizeOfFont:13 width:(WindowWith-36)/4.0];
			sender.imageEdgeInsets=UIEdgeInsetsMake(0, size.width+3, 0, -size.width);
			sender.titleEdgeInsets=UIEdgeInsetsMake(0, -sender.imageView.frame.size.width, 0, sender.imageView.frame.size.width+3);
			
			if ([str isEqualToString:@"区域"]) {
				self->_provice =  provice;
//				self->_city = city;
				
			}else if ([str isEqualToString:@"职位类型"]){
				
				
				
				
				for (NSDictionary *obj in self->_arr) {
					
					for (NSDictionary *dic in obj[@"data"]) {
						if ([city isEqualToString:dic[@"job_name"]]) {
							self->jobType=[dic[@"job_id"] intValue];
						}else if ([city isEqualToString:@""]){
							self->jobType=0;
						}
					}
				}
				
				
				
				
			}else if ([str isEqualToString:@"头衔"]){
				
				
				
				if (!city) {
					self->_tilte = @"";
				}else{
					self->_tilte = city;
				}
				
			}
			
			
			
			
			if (city!=nil) {
				
				//刷新列表
				[weakSelf beginRefesh:ENT_RefreshHeader];
			}
		};
		[self.view addSubview:areaV];
		[UIView animateWithDuration:.5 animations:^{
			areaV.top = self->_logisticsView.bottom;
		}completion:^(BOOL finished) {
			[UIView animateWithDuration:.2 animations:^{
				areaV.backgroundColor = RGBA(0, 0, 0, 0.1);
			}];
		}];
		
	}else{
		[UIView animateWithDuration:.2 animations:^{
			self->_areaV.backgroundColor = RGBA(0, 0, 0, 0);
		}completion:^(BOOL finished) {
			[UIView animateWithDuration:.5 animations:^{
				self->_areaV.top = -(WindowHeight- self->_logisticsView.bottom);
			}completion:^(BOOL finished) {
				[self->_areaV removeFromSuperview];
			}];
		}];
	}
	
	
	
}

- (void)addSearchListView{
	__weak EPCloudConnectionViewController *weakSelf=self;
	dataArray2 =[[NSMutableArray alloc]init];
	_searchView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight)];
	_searchView.backgroundColor=[UIColor whiteColor];
	_searchView.hidden=YES;
	[self.view addSubview:_searchView];
	
	ButtonTypesetView *HotSearchView = [[ButtonTypesetView alloc] initWithFrame:CGRectMake(0, 15, WindowWith, 100) dataArr:btnArray title:@"附近的人"];
	HotSearchView.selectBlock = ^(NSInteger index){
		[weakSelf creatSearch:index];
	};
	
	[_searchView addSubview:HotSearchView];
	
	
	
	UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(12, HotSearchView.bottom, WindowWith-24, 1)];
	lineView.backgroundColor=cLineColor;
	[_searchView addSubview:lineView];
	
	
	
	commTableView2=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, lineView.bottom+10, WindowWith, WindowHeight - lineView.bottom-10) tableviewStyle:UITableViewStylePlain];
	commTableView2.attribute=self;
	commTableView2.table.delegate=self;
	NSArray *Arr2=[IHUtility getUserdefalutsList:kSearchHistory];
	[commTableView2 setupData:Arr2 index:45];
	if (Arr2.count==0) {
		commTableView2.hidden=YES;
	}
	
	[_searchView addSubview:commTableView2];
	
	
	
	
	
	
	
}


-(void)creatSearch:(NSInteger)index{
	__weak EPCloudConnectionViewController *weakSelf=self;
//	btnIndex = index;
	
	MTNearUserModel *model=array[index];
	[weakSelf addWaitingView];
	[network selectUseerInfoForId:[model.user_id intValue]
						  success:^(NSDictionary *obj) {
							  
							  
							  UserChildrenInfo *usermodel=[[UserChildrenInfo alloc]initWithModel:model];
							  [network selectUserCloudInfoById:[USERMODEL.userID intValue]follow_id:[model.user_id intValue]success:^(NSDictionary *obj) {
								  [weakSelf removeWaitingView];
								  MTOtherInfomationMainViewController *controller=[[MTOtherInfomationMainViewController alloc]initWithUserID:model.user_id :NO dic:obj[@"content"]];
								  controller.userMod=usermodel;
								  controller.dic=obj[@"content"];
								  [weakSelf pushViewController:controller];
							  } failure:^(NSDictionary *obj2) {
								  
							  }];
							  
							  
							  
						  } failure:^(NSDictionary *obj2) {
							  
						  }];
	
	
	
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
	[network selectUserInfoCloudListtWithProvice:[ConfigManager returnString:_provice]
											City:[ConfigManager returnString:_tilte]
											Area:@""
										   title:_tilte
										job_type:jobType
										 user_id:[USERMODEL.userID intValue]
										nickname:_nickName
											page:page
											 num:10
										   order:_scale
										 success:^(NSDictionary *obj) {
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




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (tableView == commTableView2.table) {
		return 40;
	}
	return 0.421*WindowWith;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	
	if (tableView == commTableView2.table) {
		NSArray *Arr=[IHUtility getUserdefalutsList:kSearchHistory];
		_nickName = Arr[indexPath.row];
		[_searchV.textfiled resignFirstResponder];
		_searchV.textfiled.text = _nickName;
		_searchView.hidden = YES;
		
		//刷新列表
		[self beginRefesh:ENT_RefreshHeader];
		
		
		
	}else{
		MTConnectionModel *model=dataArray[indexPath.row];
		[self addWaitingView];
		[network selectUseerInfoForId:[model.user_id intValue]
							  success:^(NSDictionary *obj) {
								  MTNearUserModel *mod=[[MTNearUserModel alloc]initWithDictionary:obj[@"content"] error:nil];
								  UserChildrenInfo *usermodel=[[UserChildrenInfo alloc]initWithModel:mod];
								  [network selectUserCloudInfoById:[USERMODEL.userID intValue]follow_id:[model.user_id intValue]success:^(NSDictionary *obj) {
									  [self removeWaitingView];
									  MTOtherInfomationMainViewController *controller=[[MTOtherInfomationMainViewController alloc]initWithUserID:model.user_id :NO dic:obj[@"content"]];
									  controller.delegate=self;
									  controller.userMod=usermodel;
									  controller.dic=obj[@"content"];
									  controller.indexPath=indexPath;
									  [self pushViewController:controller];
								  } failure:^(NSDictionary *obj2) {
									  
								  }];
								  
								  
								  
							  } failure:^(NSDictionary *obj2) {
								  
							  }];
		
	}
	
	
	
	
}



-(void)BCtableViewCell:(IHTableViewCell *)cell action:(BCTableViewCellAction)action indexPath:(NSIndexPath *)indexPath attribute:(NSObject *)attribute{
	
	MTConnectionModel *model=dataArray[indexPath.row];
	if (action==MTActivityFollowBMTableViewCell) {
		
		if (!USERMODEL.isLogin) {
			[self prsentToLoginViewController];
			return ;
		}
		
		
		[self addWaitingView];
		[network followUser:[USERMODEL.userID intValue]follow_id:[model.user_id intValue]type:@"0" success:^(NSDictionary *obj) {
			[self removeWaitingView];
			[self addSucessView:@"关注成功" type:1];
			NSDictionary *Dic=[IHUtility getUserDefalutDic:KFansDefalutInfo];
			NSMutableDictionary *fansDic=[[NSMutableDictionary alloc]initWithDictionary:Dic];
			[fansDic setValue:[NSString stringWithFormat:@"%ld",[ fansDic[@"followNum"] integerValue]+1] forKey:@"followNum"];
			
			[IHUtility setUserDefaultDic:fansDic key:KFansDefalutInfo];
		} failure:^(NSDictionary *obj2) {
			
		}];
		
		
	}else if (action==MTActivityUpFollowBMTableViewCell){
		if (!USERMODEL.isLogin) {
			[self prsentToLoginViewController];
			return ;
		}
		
		
		[self addWaitingView];
		[network followUser:[USERMODEL.userID intValue]follow_id:[model.user_id intValue]type:@"1" success:^(NSDictionary *obj) {
			[self removeWaitingView];
			[self addSucessView:@"取消关注成功" type:1];
			NSDictionary *Dic=[IHUtility getUserDefalutDic:KFansDefalutInfo];
			NSMutableDictionary *fansDic=[[NSMutableDictionary alloc]initWithDictionary:Dic];
			[fansDic setValue:[NSString stringWithFormat:@"%ld",[ fansDic[@"followNum"] integerValue]-1] forKey:@"followNum"];
			
			[IHUtility setUserDefaultDic:fansDic key:KFansDefalutInfo];
		} failure:^(NSDictionary *obj2) {
			
		}];
		
	}
}


-(void)disPlayFollwer:(BOOL)isFollwer :(NSIndexPath *)indexPath{
	
	EPCloudConnectionTableViewCell *cell=(EPCloudConnectionTableViewCell *)[commTableView.table cellForRowAtIndexPath:indexPath];
	if (isFollwer) {
		cell.view.btn.selected=YES;
		[ cell.view.btn setImage:Image(@"EP_yes") forState:UIControlStateNormal];
		[ cell.view.btn setTitle:@"已关注" forState:UIControlStateNormal];
		cell.view.btn.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
	}else{
		
		cell.view.btn.selected=NO;
		[cell.view.btn setImage:nil forState:UIControlStateNormal];
		[cell.view.btn setTitle:@"+  关注" forState:UIControlStateNormal];
		
	}
	
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	
	[_searchV endEditing:YES];
	
	CGFloat y=scrollView.contentOffset.y;
	
	if (y<=0) {
		[UIView animateWithDuration:0.5f animations:^{
			self->_createBtn.alpha=1;
		} completion:^(BOOL finished) {
		}];
	}else{
		[UIView animateWithDuration:0.5f animations:^{
			self->_createBtn.alpha=0;
		} completion:^(BOOL finished) {
		}];
	}
	if (y>_boundHeihgt) {
		[UIView animateWithDuration:0.5f animations:^{
			self->backTopbutton.alpha=1;
			[self.view bringSubviewToFront:self->backTopbutton];
		} completion:^(BOOL finished) {
		}];
	}else{
		[UIView animateWithDuration:0.5f animations:^{
			self->backTopbutton.alpha=0;
			
			// [self.view bringSubviewToFront:backTopbutton];
		} completion:^(BOOL finished) {
		}];
	}
	
	
}

- (void)scrollViewDidEndDecelerating:(MTBaseTableView *)scrollView
{
	[UIView animateWithDuration:0.5 animations:^{
		self->_createBtn.alpha=1;
	}];
	
}

#pragma mark - 外观代理
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	
	if (tableView == commTableView2.table) {
		UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 52)];
		view.backgroundColor=[UIColor whiteColor];
		
		
		
		SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(15 , 5, 60, 14) textColor:cBlackColor textFont:sysFont(14)];
		lbl.text=@"搜索历史";
		[view addSubview:lbl];
		
		
		
		return view;
	}
	return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
	if (tableView == commTableView2.table) {
		UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 52)];
		view.backgroundColor=[UIColor whiteColor];
		view.userInteractionEnabled=YES;
		UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clean)];
		[view addGestureRecognizer:tap];
		
		SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(15 , 10, 100, 14) textColor:cBlackColor textFont:sysFont(14)];
		lbl.text=@"清除历史记录";
		lbl.centerX=self.view.centerX;
		[view addSubview:lbl];
		return view;
	}
	return nil;
	
}
-(void)clean{
	commTableView2.hidden=YES;
	[IHUtility saveUserDefaluts:@[] key:kSearchHistory];
}





//段头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	if (tableView == commTableView2.table) {
		return 30;
	}
	return 0;
	
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	
	if (tableView == commTableView2.table) {
		return 30;
	}
	return 0;
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

