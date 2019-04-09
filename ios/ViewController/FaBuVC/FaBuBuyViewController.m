//
//  FaBuBuyViewController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/3/29.
//  Copyright © 2019 听花科技. All rights reserved.
//

#import "FaBuBuyViewController.h"
#import "CuttomSelectPicHead.h"


//#import "ZLPhotoActionSheet.h"
#import "FabuBuyViewCell.h"

#import "SelectAddressViewController.h"
#import "AddSpecificationsController.h"

#import "SearchVarietiesController.h"   //品种
#import "InputFaBuBuyViewCell.h"


//#import "FabuBuyModel.h"

#import "MTSpecificationListView.h"

@interface FaBuBuyViewController () <MTSpecificationListViewDelegate,SelectPicDelegate,UITableViewDelegate,UITableViewDataSource>{
	CuttomSelectPicHead *headView;
	ZLPhotoActionSheet *actionSheet;
	NSMutableArray *imgsArr;
	NSMutableArray *TempImgsArr;
	BOOL isFirstAddPhoto;
	UITableView *_tableView;
	buyViewType currentType;
	UIView *topSegmentView;
	NSArray *topSegMentArr;
	NSString *companyname;      //公司苗圃名称
	NSString *companyId;        //公司苗圃id
	NSString *varieties;        //公司苗圃品种
	NSString *plantType;        //公司苗圃品种Id
	NSString *spec;             //规格
	NSString *money;            //价格
	NSString *Guigejson;        //归给
	
	NSArray *qiuGouArr;         //求购
	NSArray *TabArr;            //表单数据
	__block NSString *timeNum;          //求购时效
	FabuQiuGModel* qiugouModel;
	
	__weak InputFaBuBuyViewCell *_selectCell;
	MTSpecificationListView *_specView;
	
}

@end

@implementation FaBuBuyViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self dataInit];
	
	self.view.backgroundColor = cBgColor;
	if (self.type == ENT_Buy) {
		[self setTitle:@"发布求购"];
		qiugouModel = [[FabuQiuGModel alloc] init];
	} else {
		[self setTitle:@"发布供应"];
	}
	
	TempImgsArr = [[NSMutableArray alloc] init];
	imgsArr = [[NSMutableArray alloc] init];
	currentType = MTInformation;
	[self createTableView];
	
}

- (void) dataInit {
	companyname = @"";
	varieties = @"";
	spec = @"";
	companyId = @"";
	plantType = @"";
	money = @"";
	Guigejson = @"";
	topSegMentArr = @[@"基本信息",@"苗木形态",@"技术措施",@"风险控制"];
	
	qiuGouArr = @[@"公司/苗圃基本信息",@"苗木基本信息",@"苗木其他信息"];
	TabArr = @[@[@"公司/苗圃名称:"],@[@"*品种：",@"*数量:",@"规格：",@"单价：",@"高度（*/m）：",@"冠幅（*/m）：",@"分支点（*/m）："],@[@"紧急程度：",@"付款方式:",@"采苗区域：",@"用苗地点：",@"求购信息时效："]];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];   //监听键盘消失
}

- (void) keyboardWillHide {
	self.view.origin = CGPointMake(0, KtopHeitht);
}

- (void) createTableView {

	[self addTopSegmentView];
    
    if (self.type == ENT_Buy) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight - KtopHeitht + KTabSpace) style:UITableViewStyleGrouped];
    }else {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight - KtopHeitht + KTabSpace) style:UITableViewStylePlain];
    }
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.backgroundColor = cBgColor;
    [self.view addSubview:_tableView];
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    headView = [[CuttomSelectPicHead alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, kWidth(138))];
    headView.delegage = self;
    _tableView.tableHeaderView = headView;
    [self setActionSheet];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, kWidth(45) + kWidth(66))];
    bottomView.backgroundColor = cLineColor;
    
    _tableView.tableFooterView = bottomView;
    UIButton *submitBut = [UIButton buttonWithType:UIButtonTypeSystem];
    submitBut.frame = CGRectMake(0, bottomView.height - kWidth(45),bottomView.width , kWidth(45));
    [bottomView addSubview:submitBut];
    submitBut.backgroundColor = kColor(@"#05C1B0");
    [submitBut setTitle:@"提交" forState:UIControlStateNormal];
    [submitBut setTitleColor:kColor(@"#FFFFFF") forState:UIControlStateNormal];
    submitBut.titleLabel.font = darkFont(font(17));
    [submitBut addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    
//=	[self addTopSegmentView];
	
//	if (self.type == ENT_Buy) {
//		_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight - KtopHeitht + KTabSpace) style:UITableViewStyleGrouped];
//	}else {
//		_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight - KtopHeitht + KTabSpace) style:UITableViewStylePlain];
//	}
//
//	_tableView.delegate = self;
//	_tableView.dataSource = self;
//	_tableView.separatorColor = [UIColor clearColor];
//	_tableView.backgroundColor = cBgColor;
//	[self.view addSubview:_tableView];
//	_tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
//
//	headView = [[CuttomSelectPicHead alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, kWidth(138))];
//	headView.delegage = self;
//	_tableView.tableHeaderView = headView;
//	[self setActionSheet];
//
//	UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, kWidth(45) + kWidth(66))];
//	bottomView.backgroundColor = [UIColor clearColor];
//
//	_tableView.tableFooterView = bottomView;
//	UIButton *submitBut = [UIButton buttonWithType:UIButtonTypeSystem];
//	submitBut.frame = CGRectMake(0, bottomView.height - kWidth(45),bottomView.width , kWidth(45));
//	[bottomView addSubview:submitBut];
//	submitBut.backgroundColor = kColor(@"#05C1B0");
//	[submitBut setTitle:@"提交" forState:UIControlStateNormal];
//	[submitBut setTitleColor:kColor(@"#FFFFFF") forState:UIControlStateNormal];
//	submitBut.titleLabel.font = darkFont(font(17));
//	[submitBut addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
//
//>>>>>>> 提交代码
}


-(void) addTopSegmentView {
	topSegmentView = [[UIView alloc] init];
	topSegmentView.frame = CGRectMake(0,0,iPhoneWidth,kWidth(46));
	topSegmentView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
	topSegmentView.layer.shadowColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0].CGColor;
	topSegmentView.layer.shadowOffset = CGSizeMake(0,1);
	topSegmentView.layer.shadowOpacity = 1;
	
	for (int i = 0; i < MTbuyViewTypeCount; i ++) {
		UILabel *Label = [[UILabel alloc] init];
		Label.frame = CGRectMake(i * (iPhoneWidth/MTbuyViewTypeCount),0,iPhoneWidth/MTbuyViewTypeCount,45.5);
		Label.textAlignment = NSTextAlignmentCenter;
		Label.text = topSegMentArr[i];
		[topSegmentView addSubview:Label];
		Label.tag = 200 + i;
		if (i == currentType) {
			Label.textColor = kColor(@"#FFFFFF");
			Label.font = sysFont(16);
			Label.backgroundColor = [UIColor colorWithRed:5/255.0 green:193/255.0 blue:176/255.0 alpha:1.0];
		}else {
			Label.textColor = kColor(@"#0E0E0E");
			Label.font = sysFont(14);
			Label.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
		}
		UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SegmentAction:)];
		Label.userInteractionEnabled = YES;
		[Label addGestureRecognizer:tag];
	}
}

-(void)SegmentAction:(UITapGestureRecognizer *)sender {
	UITapGestureRecognizer *tap = (UITapGestureRecognizer*)sender;
	UILabel *titleLab = (UILabel*)tap.view;
	NSInteger tag = titleLab.tag - 200;
	if (tag != currentType) {
		UILabel *currentLab = [topSegmentView viewWithTag:currentType+200];
		currentLab.textColor = kColor(@"#0E0E0E");
		currentLab.font = sysFont(14);
		currentLab.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
		
		titleLab.textColor = kColor(@"#FFFFFF");
		titleLab.font = sysFont(16);
		titleLab.backgroundColor = [UIColor colorWithRed:5/255.0 green:193/255.0 blue:176/255.0 alpha:1.0];
		currentType = tag;
		[self contentOffSetX:tag];
	}
}

- (void) contentOffSetX:(NSInteger ) index {
	NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
	FabuBuyViewCell * cell = [_tableView cellForRowAtIndexPath:indexPath];
	[cell setScrollViewContOffX:index];
	[UIView animateWithDuration:0.3 animations:^{
		self->_tableView.contentOffset = CGPointZero;
	}];
}
- (void) setTopSegMent:(NSInteger ) index {
	if (index != currentType) {
		UILabel *titleLab = [topSegmentView viewWithTag:index +200];
		titleLab.textColor = kColor(@"#FFFFFF");
		titleLab.font = sysFont(16);
		titleLab.backgroundColor = [UIColor colorWithRed:5/255.0 green:193/255.0 blue:176/255.0 alpha:1.0];
		
		UILabel *currentLab = [topSegmentView viewWithTag:currentType +200];
		currentLab.textColor = kColor(@"#0E0E0E");
		currentLab.font = sysFont(14);
		currentLab.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
		currentType = index;
		[UIView animateWithDuration:0.3 animations:^{
			self->_tableView.contentOffset = CGPointMake(0, 0);
		}];
	}
}

- (void) setActionSheet {
	actionSheet = [[ZLPhotoActionSheet alloc] init];
	actionSheet.hidden = YES;
	//设置照片最大选择数
	actionSheet.maxSelectCount = 6;
	//设置照片最大预览数
	actionSheet.maxPreviewCount = 20;
}
-(void)back:(id)sender{
	if (self.presentingViewController) {
		//判断1
		[self dismissViewControllerAnimated:YES completion:nil];
	} else if ([self.navigationController respondsToSelector:@selector(popViewControllerAnimated:)]) {
		//判断2
		[self.navigationController popViewControllerAnimated:YES];
	}
}

#pragma mark - 选择添加图片代理
- (void)showActionSheetPicSelectBlock:(PicSelectItemBlock)block {
	[actionSheet showWithSender:self animate:YES completion:^(NSArray<UIImage *> * _Nonnull selectPhotos) {
		for (int i=0; i<selectPhotos.count; i++) {
			UIImage *img2 = [selectPhotos objectAtIndex:i];
			if (!self->isFirstAddPhoto) {
				[self->imgsArr removeAllObjects];
				[self->imgsArr addObject:img2];
				self->isFirstAddPhoto=YES;
			}else{
				[self->imgsArr addObject:img2];
			}
		}
		if (self->imgsArr.count>=6) {
			NSMutableArray *arr2=[[NSMutableArray alloc]init];
			for (int i=0; i<6; i++) {
				[arr2 addObject:[self->imgsArr objectAtIndex:i]];
			}
			[self->imgsArr removeAllObjects];
			[self->imgsArr addObjectsFromArray:arr2];
		}
		block(self->imgsArr);
	}];
	
}
- (void)remoePicSelectUpDataUIFrame:(CGRect)frame andImageArr:(NSMutableArray *)imgarray {
	headView.frame = frame;
	[TempImgsArr removeAllObjects];
	TempImgsArr = imgarray;
	[_tableView reloadData];
}

#pragma mark - TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	if (self.type == ENT_Buy) {
		return qiuGouArr.count;
	}else {
		return 1;
	}
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (self.type == ENT_Buy) {
		NSArray *arr = TabArr[section];
		return arr.count;
	}else {
		return 1;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (self.type == ENT_Buy) { //求购
		NSString *identifier = [NSString stringWithFormat:@"InputFaBuBuyellIdentifier%ld",indexPath.row];
		InputFaBuBuyViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
		if (cell == nil) {
			cell = [[InputFaBuBuyViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
		}
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cell.backgroundColor = [UIColor whiteColor];
		cell.detailTextLabel.font = sysFont(14);
		cell.detailTextLabel.textColor = kColor(@"#828282");
		cell.userInteractionEnabled = YES;
		NSArray *arr = TabArr[indexPath.section];
		cell.titleStr = arr[indexPath.row];
		cell.numberView.hidden = YES;
		if (indexPath.section == 0) {
			if (indexPath.row == 0) {
				cell.textField.hidden = YES;
				cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
				
				if (cell.detailTextLabel.text.length < 1) {
					cell.detailTextLabel.text = @"请选择名称";
				}
				cell.detailTextLabel.textColor = kColor(@"#828282");
			}
		}else if (indexPath.section == 1) {
			if (indexPath.row == 0 ) {
				if (cell.detailTextLabel.text.length < 1) {
					cell.detailTextLabel.text = @"请选择品种";
				}
				cell.textField.hidden = YES;
				cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			}
			if (indexPath.row == 1) {
				cell.textField.hidden = YES;
				cell.numberView.hidden = NO;
				cell.unitBut.hidden = NO;
				if (qiugouModel.number == nil) {
					qiugouModel.number = @"1";
				}
				cell.numberView.resultNumber = ^(NSString *number) {
					
					self->qiugouModel.number = [NSString stringWithFormat:@"%ld",[number integerValue]];
				};
				if (cell.unitBut.titleLabel.text.length < 1) {
					[cell.unitBut setTitle:@"株" forState:UIControlStateNormal];
					qiugouModel.unit = @"株";
				}
				cell.unitBut.tag = 100;
				[cell.unitBut addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
				
			}else {
				cell.numberView.hidden = YES;
				cell.unitBut.hidden = YES;
			}
			if (indexPath.row == 2) {
				if (cell.detailTextLabel.text.length < 1) {
					cell.detailTextLabel.text = @"请选择规格";
				}
				
				cell.textField.hidden = YES;
				cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			}
			if (indexPath.row == 3) {
				if (cell.detailTextLabel.text.length < 1) {
					cell.detailTextLabel.text = @"请选择单价";
				}
				cell.textField.hidden = YES;
				cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
				
			}
			if (indexPath.row == 4) {
				cell.textField.keyboardType = UIKeyboardTypeDecimalPad;
				cell.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
				cell.inputBlock = ^(NSString *inputResult) {
					self->qiugouModel.height = inputResult;
				};
			}
			if (indexPath.row == 5) {
				cell.textField.keyboardType = UIKeyboardTypeDecimalPad;
				cell.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
				cell.inputBlock = ^(NSString *inputResult) {
					
					self->qiugouModel.crownWidth = inputResult;
				};
				
			}
			if (indexPath.row == 6) {
				cell.textField.keyboardType = UIKeyboardTypeDecimalPad;
				cell.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
				cell.inputBlock = ^(NSString *inputResult) {
					
					self->qiugouModel.windPoint = inputResult;
				};
				
			}
		}else {
			if (indexPath.row == 4) {
				cell.unitBut.hidden = NO;
				cell.DetaiLab.text = @"请输入时效";
				
				if (cell.unitBut.titleLabel.text.length < 1) {
					[cell.unitBut setTitle:@"天" forState:UIControlStateNormal];
					qiugouModel.timeunit = @"天";
				}
				cell.unitBut.tag = 101;
				[cell.unitBut addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
				
				cell.textField.width = cell.textField.width - kWidth(70);
				cell.textField.placeholder = @"请输入时效";
				cell.textField.keyboardType = UIKeyboardTypeDecimalPad;
				cell.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
				cell.inputBlock = ^(NSString *inputResult) {
					
					self->timeNum = inputResult;
				};
			}else {
				cell.DetaiLab.hidden = YES;
				cell.unitBut.hidden = YES;
			}
			if (indexPath.row == 0) {
				NSArray *arr = @[@"询价",@"立即采购",@"近期采购"];
				cell.emergencyArr = arr;
				if (qiugouModel.urgencyLevelId == nil) {
					qiugouModel.urgencyLevelId = stringFormatInt(0);
				}
				cell.SegmentSelbloack = ^(NSInteger index) {
					
					self->qiugouModel.urgencyLevelId = stringFormatInt(index);
				};
				
			}
			if (indexPath.row == 1) {
				NSArray *arr = @[@"无",@"上车付款",@"货到付款",@"账期"];
				cell.emergencyArr = arr;
				if (qiugouModel.paymentMethodsDictionaryId == nil) {
					qiugouModel.paymentMethodsDictionaryId = stringFormatInt(0);
				}
				cell.SegmentSelbloack = ^(NSInteger index) {
					self->qiugouModel.paymentMethodsDictionaryId = stringFormatInt(index);
				};
				
			}
			if (indexPath.row == 0 || indexPath.row == 1) {
				cell.textField.hidden = YES;
			}
			if (indexPath.row == 2) {
				cell.textField.placeholder = @"请输入菜苗区域";
				cell.textField.keyboardType = UIKeyboardTypeDecimalPad;
				cell.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
				cell.inputBlock = ^(NSString *inputResult) {
					self->qiugouModel.miningArea = inputResult;
				};
			}
			if (indexPath.row == 3) {
				cell.textField.placeholder = @"请输入用苗地点";
				cell.inputBlock = ^(NSString *inputResult) {
					
					self->qiugouModel.useMiningArea = inputResult;
				};
			}
		}
		return cell;
	} else {
		//供应的 cell
		static NSString *cellId = @"tableviewCellId";
		FabuBuyViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
		if (cell == nil) {
			cell = [[FabuBuyViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
		}
		cell.backgroundColor = cBgColor;
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		WS(weakSelf);
		///滑动视图事件
		cell.ContOffXBlock = ^(NSInteger index) {
			[weakSelf setTopSegMent:index];
		};
		///基本信息
		cell.selectGuigeBlock = ^(UILabel *lab) {
			[weakSelf pushAddressViewControl:lab];
		};
		///选择价格
		cell.selectMoneyBlock = ^(UILabel *lab) {
			[weakSelf pushMoneyViewControl:lab];
		};
		cell.selectCompanyNameBlock = ^(UILabel *lab) {
			[weakSelf pushAddNameController:lab];
		};
		cell.selectPinZhongBlock = ^(UILabel *lab) {
			[weakSelf selectSearchVarietiesController:lab];
		};
		cell.selectcommitModelBlock = ^(FabuBuyModel *model) {
			[weakSelf subSmitGongyinModel:model];
		};
		return cell;
	}
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	if (self.type == ENT_Buy) {
		UIView *view = [[UIView alloc] init];
		view.backgroundColor = kColor(@"#FBFBFB");
		[view removeAllSubviews];
		UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(kWidth(13), kWidth(30), iPhoneWidth - kWidth(26), kWidth(16))];
		title.textColor = kColor(@"#ABABAB");
		title.font = sysFont(font(14));
		[view addSubview:title];
		NSInteger tag = tableView.tag;
		title.text = qiuGouArr[tag];
		return view;
	} else {
		return topSegmentView;
	}
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	if (self.type == ENT_Buy) {
		return kWidth(57);
	}else {
		return kWidth(46);
	}
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (self.type == ENT_Buy) {
		return kWidth(47);
	}else {
		if (currentType == MTInformation) {
			return kWidth(650);
		} else if (currentType == MTMorphology) {
			return kWidth(372);
		} else if (currentType == MTTechnicalMeasures) {
			return kWidth(490);
		} else if (currentType == MTRiskControl) {
			return kWidth(420);
		}else {
			return iPhoneHeight - KStatusBarHeight;
		}
	}
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	return 0.1;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
	UIView *view = [[UIView alloc] init];
	return view;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (self.type == ENT_Buy) {
		AddSpecifitionCell *cell = [tableView cellForRowAtIndexPath:indexPath];
		if (indexPath.section == 0 && indexPath.row == 0) {
			[self pushAddNameController:cell.detailTextLabel];
		}else if (indexPath.section == 1 && indexPath.row == 0) {
			[self selectSearchVarietiesController:cell.detailTextLabel];
		}else if (indexPath.section == 1 && indexPath.row == 2) {
			[self pushAddressViewControl:cell.detailTextLabel];
		}else if (indexPath.section == 1 && indexPath.row == 3) {
			[self pushMoneyViewControl:cell.detailTextLabel];
		}
	}
}
//选择规格
- (void) pushAddressViewControl:(UILabel *)lab{
	AddSpecificationsController *AddressVc = [[AddSpecificationsController alloc] init];
	//    SelectAddressViewController *AddressVc = [[SelectAddressViewController alloc] init];
	WS(weakSelf);
	AddressVc.SpacifiBlock = ^(NSString * _Nonnull guigeiStr, NSString * _Nonnull moneyStr, NSString * _Nonnull jsonStr) {
		lab.text = guigeiStr;
		
		self->spec = guigeiStr;
		self->Guigejson = jsonStr;
	};
	[weakSelf pushViewController:AddressVc];
}
//选择金钱
- (void) pushMoneyViewControl:(UILabel *)lab{
	AddSpecificationsController *AddressVc = [[AddSpecificationsController alloc] init];
	WS(weakSelf);
	AddressVc.SpacifiBlock = ^(NSString * _Nonnull guigeiStr, NSString * _Nonnull moneyStr, NSString * _Nonnull jsonStr) {
		lab.text = moneyStr;
		
		self->money = moneyStr;
	};
	[weakSelf pushViewController:AddressVc];
}

//选择苗圃
- (void) pushAddNameController:(UILabel *)lab{
	SelectAddressViewController *AddressVc = [[SelectAddressViewController alloc] init];
	WS(weakSelf);
	[weakSelf pushViewController:AddressVc];
	AddressVc.changeBlock = ^(NSString *str1, NSString *str2) {
		lab.text = str1;
		self->companyname = str1;
		self->companyId = str2;
	};
}
//选择品种
- (void) selectSearchVarietiesController:(UILabel *)lab {
	SearchVarietiesController *vc = [[SearchVarietiesController alloc] init];
	WS(weakSelf);
	[weakSelf pushViewController:vc];
	vc.changeBlock = ^(NSDictionary *dic) {
		lab.text = dic[@"nurseryTypeName"];
		self->varieties = dic[@"nurseryTypeName"];
		self->plantType = dic[@"nurseryTypeId"];
	};
}

- (void) submitAction {
	if (TempImgsArr.count < 1) {
		[IHUtility addSucessView:@"请选择选择图片" type:2];
		return;
	}
	if (self.type == ENT_Buy) {
		[self fabuQiugou];
	}else {
		[self fabuGongying];
	}
	NSLog(@"提交");
}

- (void) fabuGongying {
	if ([companyname isEqualToString:@""]) {
		[IHUtility addSucessView:@"请选择苗圃名称" type:2];
		return;
	}
	if ([varieties isEqualToString:@""]) {
		[IHUtility addSucessView:@"请选择品种" type:2];
		return;
	}
	if ([spec isEqualToString:@""]) {
		[IHUtility addSucessView:@"请选择规格" type:2];
		return;
	}
	if ([money isEqualToString:@""]) {
		[IHUtility addSucessView:@"请选择单价" type:2];
		return;
	}
	
	[[NSNotificationCenter defaultCenter]postNotificationName:NotificationBuyFabuAction object:nil];
}


- (void) fabuQiugou {
	if ([varieties isEqualToString:@""]) {
		[IHUtility addSucessView:@"请选择品种" type:2];
		return;
	}
	if (TempImgsArr.count>0) {
		[self addWaitingView];
		[AliyunUpload uploadImage:TempImgsArr FileDirectory:ENT_fileImageBody success:^(NSString *obj) {
			self->qiugouModel.wantBuyUrl = obj;
			self->qiugouModel.varieties = self->varieties;
			self->qiugouModel.plantType = self->plantType;
			self->qiugouModel.companyName = self->companyname;
			self->qiugouModel.companyId = self->companyId;
			self->qiugouModel.spec = self->spec;
			self->qiugouModel.univalent = self->money;
			self->qiugouModel.specJson = self->Guigejson;
			self->qiugouModel.userId = USERMODEL.userID;
			if (self->qiugouModel.infoActive != nil) {
				self->qiugouModel.infoActive = [NSString stringWithFormat:@"%@%@",self->timeNum,self->qiugouModel.timeunit];
			}
			NSDictionary *dict = [self->qiugouModel toDictionary];
			NSString * parameter  = [IHUtility getParameterString:dict];
			NSLog(@"dict == %@",dict);
			NSString *url = [NSString stringWithFormat:@"%@?%@",supplyAndBuyWantBuyUrl,parameter];
			[network httpRequestWithParameter:nil method:url success:^(NSDictionary *obj) {
				NSLog(@"%@",obj);
				[IHUtility addSucessView:@"发布成功" type:1];
				if (self.updataTable) {
					self.updataTable();
				}
				[self backAction];
			} failure:^(NSDictionary *obj) {
				[IHUtility addSucessView:@"发布失败,请重试" type:2];
			}];
		}];
	}
	
	
}

//提交供应
- (void) subSmitGongyinModel:(FabuBuyModel *)model {
	
	
	if (TempImgsArr.count>0) {
		[self addWaitingView];
		[AliyunUpload uploadImage:TempImgsArr FileDirectory:ENT_fileImageBody success:^(NSString *obj) {
			model.supplyurl = [NSString stringWithFormat:@"%@",obj];
			//            <<<<<<< HEAD
			//            model.spec = spec;
			//            model.specJson = Guigejson;
			//            model.univalent = money;
			//            model.companyId = companyId;
			//            model.companyname = companyname;
			//            model.varieties = varieties;
			//            model.plantType = plantType;
			//            =======
			model.spec = self->spec;
			model.specJson = self->Guigejson;
			model.univalent = self->money;
			model.companyId = self->companyId;
			model.companyname = self->companyname;
			model.varieties = self->varieties;
			model.plantType = self->companyId;
			model.userId = USERMODEL.userID;
			NSDictionary *dict = [model toDictionary];
			NSString * parameter  = [IHUtility getParameterString:dict];
			NSLog(@"dict ==%@",dict);
			NSString *url = [NSString stringWithFormat:@"%@?%@",supplyAndBuyUpplyUrl,parameter];
			[network httpRequestWithParameter:nil method:url success:^(NSDictionary *obj) {
				NSLog(@"%@",obj);
				[IHUtility addSucessView:@"发布成功" type:1];
				if (self.updataTable) {
					self.updataTable();
				}
				[self backAction];
			} failure:^(NSDictionary *obj) {
				[IHUtility addSucessView:@"发布失败,请重试" type:2];
			}];
		}];
	}
}




- (void) buttonAction:(UIButton *)btn {
	_selectCell = (InputFaBuBuyViewCell *)btn.superview.superview;
	CGRect rect = [btn convertRect:btn.frame toView:_tableView];
	CGFloat viewX = CGRectGetMinX(btn.frame);
	CGFloat viewY = CGRectGetMinY(rect) -21.0f; //默认在按钮下方展示
	
	CGFloat viewW = CGRectGetWidth(rect);
	NSArray *dataArray;
	if (btn.tag == 100) {
		dataArray = @[@"株",@"袋",@"盆",@"捆",@"芽",@"㎡"];
	}else {
		dataArray = @[@"天",@"周",@"月"];
	}
	CGFloat viewH = dataArray.count *rect.size.height;
	//防止视图超出屏幕
	if (viewY + viewH > _tableView.frame.size.height) {
		viewY =  CGRectGetMinY(rect) - viewH + 10.0f;
	}
	
	if (btn.tag == 101) {
		viewY = viewY + 6;
	}
	
	if (_specView) {
		[_specView removeFromSuperview];
		_specView = nil;
	}
	//规格视图
	MTSpecificationListView *specView = [[MTSpecificationListView alloc] initWithFrame:CGRectMake(viewX,viewY,viewW,viewH) titleArray:dataArray];
	specView.delegate = self;
	[_tableView addSubview:specView];
	_specView = specView;
	
}
- (void) specificationListView:(MTSpecificationListView *_Nullable)specificationView
		  didSelectItemAtIndex:(NSInteger)index
					 withTitle:(NSString *_Nullable)title {
	[_selectCell.unitBut setTitle:title forState:UIControlStateNormal];
	if (_selectCell.unitBut.tag == 100) {
		qiugouModel.unit = title;
	}else {
		
		qiugouModel.timeunit = title;
	}
	
}


-(void)backAction{
	if (self.presentingViewController) {
		//判断1
		[self dismissViewControllerAnimated:YES completion:nil];
	} else if ([self.navigationController respondsToSelector:@selector(popViewControllerAnimated:)]) {
		//判断2
		[self.navigationController popViewControllerAnimated:YES];
	}
}



@end


