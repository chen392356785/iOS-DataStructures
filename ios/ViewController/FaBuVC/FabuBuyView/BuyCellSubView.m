//
//  BuyCellSubView.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/3/30.
//  Copyright © 2019 听花科技. All rights reserved.
//

#import "FabuCuttom.h"
#import "BuyCellSubView.h"
#import "NumberCalculate.h"
#import "ValuePickerView.h" //类别选择
#import "InputFaBuBuyViewCell.h"
#import "MTSpecificationListView.h"


static NSString *BuyInfocellId = @"InputFaBuBuyViewCell";

@interface BuyCellSubView ()<MTSpecificationListViewDelegate,UITextViewDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource> {
	__weak InputFaBuBuyViewCell *_selectCell;
	MTSpecificationListView *_specView;
//	__weak UITextView *_textView;
	FabuBuyModel *_fabumodel;
}

@property (nonatomic, strong) ValuePickerView *TeampickerView;      //类别选择
///tableView
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation BuyCellSubView

@dynamic fabumodel;

- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		[self dataInit];
	}
	return self;
}

- (void) dataInit { //基本信息数据源
	_infoArr = @[@[@"*公司/苗圃名称:",@"*品种：",@"*数量:",@"高度（*/cm）：",@"冠幅（*/cm）：",@"分支点（*/cm）：",@"规格：",@"单价："],@[@"备注："]];
	_xingTaiArr = @[@"枝叶茂密程度：",@"有无明显主杆：",@"种类：",@"造型：",@"栽培方式："];
	_technicalArr = @[@"土球起挖包扎技术及包扎材质：",@"土球土质：",@"培育方式",@"保护措施：",@"直径（*/cm）：",@"厚度（*/cm）：",@"形状："];
	_riskControloArr = @[@"是否有病虫害：",@"育苗期是否做过收枝的修剪：",@"水肥：",@"装车、起吊技术：",@"苗圃内转运及道路方便程度："];
	_headTitleArr = @[@[@"公司/苗圃基本信息",@"备注:"],@[@"苗木产品形态"],@[@"苗木技术措施"],@[@"苗木质量风险控制"]];
	self.TeampickerView = [[ValuePickerView alloc]init];
	[self addSubview:self.tableView];
	[self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self);
	}];
}

- (FabuBuyModel *)fabumodel {
	if (!_fabumodel) {
		_fabumodel = [[FabuBuyModel alloc] init];
	}
	return _fabumodel;
}

- (void)setFabumodel:(FabuBuyModel *)fabumodel {
	_fabumodel = fabumodel;
}

- (UITableView *) tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStyleGrouped];
		_tableView.dataSource = self;
		_tableView.delegate = self;
		_tableView.backgroundColor = RGB(251.0f, 251.0f, 251.0f);
		_tableView.separatorColor = [UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1.0];
		_tableView.separatorInset = UIEdgeInsetsMake(0.0f,12.0f, 0.0f,12.0f);
		_tableView.scrollEnabled = NO;
	}
	return _tableView;
}

- (void)setIndex:(NSInteger)index {
	_index = _tableView.tag = index;
}

/**
 更新数据
 */
- (void) reloadData {
	[self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	NSInteger tag = tableView.tag;
	NSArray *arr = _headTitleArr[tag];
	return arr.count;
	
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (tableView.tag == 0) {
		NSArray *arr = _infoArr[section];
		return arr.count;
	}else if (tableView.tag == 1){
		return _xingTaiArr.count;
	}else if (tableView.tag == 2){
		return _technicalArr.count;
	}else {
		return _riskControloArr.count;
	}
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (tableView.tag == 0) {
		if (indexPath.section == 0) {
			return kWidth(48.0f);
		} else {
			return kWidth(145.0f);
		}
	}
	return kWidth(47);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	InputFaBuBuyViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BuyInfocellId];
	if (cell == nil) {
		cell = [[InputFaBuBuyViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:BuyInfocellId];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cell.contentView.backgroundColor = [UIColor whiteColor];
		cell.detailTextLabel.font = sysFont(13);
		cell.textField.delegate = self;
		cell.detailTextLabel.textColor = kColor(@"#828282");
	}
	
	WS(weakSelf);
	if (tableView.tag == 0) {
		
		NSArray *arr = _infoArr[indexPath.section];
		cell.titleStr = arr[indexPath.row];
		if (indexPath.section == 0) { ///基本信息
			
			cell.numberView.hidden = indexPath.row != 2;
			cell.unitBut.hidden = indexPath.row != 2;
			
			if (indexPath.row == 0) { ///公司名称
				cell.textField.hidden = YES;
				cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
				if ([self.fabumodel.companyname isEqualToString:@""]) {
					cell.detailTextLabel.text = @"请选择名称";
				} else {
					cell.detailTextLabel.text = self.fabumodel.companyname;
				}
			} else if (indexPath.row == 1 ) { //品种
				cell.textField.text = self.fabumodel.varieties;
				cell.textField.placeholder = @"请输入品种";
				[cell setInputBlock:^(NSString *str1) {
					weakSelf.fabumodel.varieties = str1;
				}];
				cell.accessoryType = UITableViewCellAccessoryNone;
			} else if (indexPath.row == 2) { //数量
				cell.textField.hidden = YES;
				cell.numberView.baseNum = self.fabumodel.number;
				[cell.unitBut setTitle:self.fabumodel.unit forState:UIControlStateNormal];
				cell.numberView.resultNumber = ^(NSString *number) {
					weakSelf.fabumodel.number = [NSString stringWithFormat:@"%ld",[number integerValue]];
				};
				[cell.unitBut addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
				
			} else if (indexPath.row == 3) { ///高度
				cell.textField.keyboardType = UIKeyboardTypeDecimalPad;
				cell.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
				cell.textField.text = self.fabumodel.height;
				cell.inputBlock = ^(NSString *inputResult) {
					weakSelf.fabumodel.height = inputResult;
				};
			} else if (indexPath.row == 4) { //冠幅
				cell.textField.keyboardType = UIKeyboardTypeDecimalPad;
				cell.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
				cell.textField.text = self.fabumodel.crownWidth;
				cell.inputBlock = ^(NSString *inputResult) {
					weakSelf.fabumodel.crownWidth = inputResult;
				};
			} else if (indexPath.row == 5) { //支点
				cell.textField.keyboardType = UIKeyboardTypeDecimalPad;
				cell.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
				cell.textField.text = self.fabumodel.windPoint;
				cell.inputBlock = ^(NSString *inputResult) {
					weakSelf.fabumodel.windPoint = inputResult;
				};
			} else if (indexPath.row == 6) { ///规格输入框
				cell.accessoryType = UITableViewCellAccessoryNone;
				cell.textField.keyboardType = UIKeyboardTypeNumberPad;
				cell.textField.placeholder = @"请输入规格";

				//设置 textField 右侧视图
				UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f,190.0f, 30.0f)];
				cell.textField.rightView = v;
				cell.textField.rightViewMode = UITextFieldViewModeAlways;
				cell.textField.text = self.fabumodel.spec;
				NSArray *arr = @[@"胸径",@"米径",@"地径"];
				cell.emergencyArr = arr;
				cell.segmentControlIndex = [arr indexOfObject:self.fabumodel.raiseMethod];
				cell.SegmentSelbloack = ^(NSInteger index) {
					weakSelf.fabumodel.raiseMethod = arr[index];
				};
				
			} else if (indexPath.row == 7) { //单价输入框
				cell.textField.text = self.fabumodel.univalent;
				cell.textField.keyboardType = UIKeyboardTypeDecimalPad;
				cell.textField.placeholder = @"请输入单价";
				cell.inputBlock = ^(NSString *str1) {
					weakSelf.fabumodel.univalent = str1;
				};
				cell.accessoryType = UITableViewCellAccessoryNone;
			}
		} else { //备注信息
			cell.textField.hidden = YES;
			UITextView *textView = [cell.contentView viewWithTag:1000];
			if (textView == nil) {
				textView = [[UITextView alloc] initWithFrame:CGRectMake(12.0f,40.0f,iPhoneWidth-24.0f,kWidth(90.0f))];
				textView.delegate = self;
				[cell.contentView addSubview:textView];
				UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
				doneButton.backgroundColor = UIColor.whiteColor;
				[doneButton addTarget:textView action:@selector(resignFirstResponder) forControlEvents:UIControlEventTouchUpInside];
				doneButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
				doneButton.frame = CGRectMake(0.0f, 0.0f, iPhoneWidth, 30.0f);
				[doneButton setTitle:@"完成" forState:UIControlStateNormal];
				[doneButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
				textView.inputAccessoryView = doneButton;
			}
			textView.text = self.fabumodel.remark;
		}
		
	} else if(tableView.tag == 1) { ///苗木形态
		cell.textField.hidden = YES;
		if (indexPath.row == 0) { //枝叶茂密程度
		
			cell.fabuCuttView.hidden = NO;
			cell.fabuCuttView.lefttStr = @"疏";
			cell.fabuCuttView.rightStr = @"密";
			if ([self.fabumodel.density isEqualToString:@"疏"]) {
				cell.fabuCuttView.isRightSelect = NO;
			} else {
				cell.fabuCuttView.isRightSelect = YES;
			}
			cell.inputBlock = ^(NSString *str1) {
				weakSelf.fabumodel.density = str1;
			};
		} else if (indexPath.row == 1) { //有无明显主杆
			cell.systemSwitch.hidden = (indexPath.row != 1);
			[cell.systemSwitch setOn:[self.fabumodel.hasTrunk isEqualToString:@"有"] animated:YES];
			cell.inputBlock = ^(NSString *str1) {
				weakSelf.fabumodel.hasTrunk = str1;
			};
		} else if (indexPath.row == 2) { ///种类
			cell.fabuCuttView.lefttStr = @"独杆";
			cell.fabuCuttView.rightStr = @"丛生";
			cell.fabuCuttView.isRightSelect = [self.fabumodel.type isEqualToString:@"丛生"];
			cell.fabuCuttView.hidden = NO;
			cell.inputBlock = ^(NSString *str1) {
				weakSelf.fabumodel.type = str1;
			};
		} else if (indexPath.row == 3 ) { //造型
			cell.detailTextLabel.text = self.fabumodel.model;
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		} else if (indexPath.row == 4) { //栽培方式
			cell.detailTextLabel.text = self.fabumodel.culturalMethod;
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		}
		cell.titleStr = _xingTaiArr[indexPath.row];
	} else if(tableView.tag == 2) { //技术措施
		
		cell.titleStr = _technicalArr[indexPath.row];
		cell.textField.hidden = !(indexPath.row == 4 || indexPath.row == 5);
		if (indexPath.row == 0) { //土球起挖包扎技术及包扎材质
			cell.detailTextLabel.text = self.fabumodel.soilBallDress;
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			cell.detailTextLabel.text = self.fabumodel.soilBallDress;
		} else if (indexPath.row == 1) { ///土球土质
			NSArray *arr = @[@"黄土",@"沙土",@"红土",@"黑土"];
			cell.emergencyArr = arr;
			cell.segmentControlIndex = [arr indexOfObject:self.fabumodel.soilBall];
			cell.SegmentSelbloack = ^(NSInteger index) {
				weakSelf.fabumodel.soilBall = arr[index];
			};
		} else if (indexPath.row ==  2) { //培育方式
			cell.textField.hidden = YES;
			NSArray *arr = @[@"籽播苗",@"扦插苗",@"嫁接苗",@"移栽苗"];
			cell.emergencyArr = arr;
			cell.segmentControlIndex = [arr indexOfObject:self.fabumodel.raiseMethod];
			cell.SegmentSelbloack = ^(NSInteger index) {
				weakSelf.fabumodel.raiseMethod = arr[index];
			};
		} else if (indexPath.row == 3) { //保护措施
			cell.textField.hidden = YES;
			NSArray *arr = @[@"树干缠亚麻",@"收支",@"修剪",@"去叶"];
			cell.payTypeArr = arr;
			cell.segmentControlIndex = [arr indexOfObject:self.fabumodel.safeguard];
			cell.SegmentSelbloack = ^(NSInteger index) {
				weakSelf.fabumodel.safeguard = arr[index];
			};
		} else if (indexPath.row == 4) { //直径
			cell.textField.text = @"50cm";
			cell.textField.text = self.fabumodel.soilBallSize;
			cell.textField.keyboardType = UIKeyboardTypeDecimalPad;
			cell.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
			cell.inputBlock = ^(NSString *inputResult) {
				weakSelf.fabumodel.soilBallSize = inputResult;
			};
		} else if (indexPath.row == 5) { //厚度
			cell.textField.placeholder = @"请输入厚度";
			cell.textField.text = self.fabumodel.soilThickness;
			cell.textField.textAlignment = NSTextAlignmentRight;
			cell.textField.keyboardType = UIKeyboardTypeDecimalPad;
			cell.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
			cell.inputBlock = ^(NSString *inputResult) {
				weakSelf.fabumodel.soilThickness = inputResult;
			};
		} else { //形状
			cell.fabuCuttView.hidden = NO;
			cell.fabuCuttView.lefttStr = @"锥形";
			cell.fabuCuttView.rightStr = @"苹果包";
			cell.fabuCuttView.isRightSelect = [self.fabumodel.soilBallShape isEqualToString:@"苹果包"];
			cell.inputBlock = ^(NSString *str1) {
				weakSelf.fabumodel.soilBallShape = str1;
			};
		}
		
	} else { ///风险控制
		cell.titleStr = _riskControloArr[indexPath.row];
		cell.textField.hidden = YES;
		if (indexPath.row == 0) { //是否有病虫害
			NSArray *arr = @[@"无",@"一般",@"严重"];
			cell.emergencyArr = arr;
			cell.segmentControlIndex = [arr indexOfObject:self.fabumodel.insectPest];
			cell.SegmentSelbloack = ^(NSInteger index) {
				weakSelf.fabumodel.insectPest = arr[index];
			};
		} else if (indexPath.row == 1) { ///育苗期是否做过收枝的修剪
			cell.systemSwitch.hidden = (indexPath.row != 1);
			[cell.systemSwitch setOn:[self.fabumodel.trim isEqualToString:@"是"] animated:YES];
			cell.inputBlock = ^(NSString *str1) {
				if ([str1 isEqualToString:@"有"]) {
					weakSelf.fabumodel.trim = @"是";
				} else {
					weakSelf.fabumodel.trim = @"否";
				}
			};
		} else if (indexPath.row == 2) { // 水肥
			cell.fabuCuttView.lefttStr = @"一般";
			cell.fabuCuttView.rightStr = @"充足";
			cell.fabuCuttView.isRightSelect = [self.fabumodel.waterFertilizer isEqualToString:@"充足"];
			cell.fabuCuttView.hidden = NO;
			cell.inputBlock = ^(NSString *str1) {
				weakSelf.fabumodel.waterFertilizer = str1;
			};
		} else if (indexPath.row == 3) { //装车吊装技术
			cell.fabuCuttView.hidden = NO;
			cell.fabuCuttView.lefttStr = @"一般水平";
			cell.fabuCuttView.rightStr = @"技术过硬";
			cell.fabuCuttView.isRightSelect = [self.fabumodel.loadLift isEqualToString:@"技术过硬"];
			cell.inputBlock = ^(NSString *str1) {
				weakSelf.fabumodel.loadLift = str1;
			};
		} else if (indexPath.row == 4) { //苗圃内转运道路方便程度
			cell.detailTextLabel.text = self.fabumodel.roadWay;
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		}
		
	}
	return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 16.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	return 0.001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
	return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	WS(weakSelf);
	InputFaBuBuyViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
	if (tableView.tag == 0) {       //基本信息
		if (indexPath.section == 0 && indexPath.row == 0) {
			if (weakSelf.selectCompanyNameBlock) {
				weakSelf.selectCompanyNameBlock(cell.detailTextLabel);
			}
		}
	}else if (tableView.tag == 1) { //苗木形态
		if (indexPath.row == 3) {
			NSLog(@"请选择造型");
			weakSelf.TeampickerView.dataSource =  @[@"塔形",@"卵形",@"伞形"];
			weakSelf.TeampickerView.pickerTitle = @"选择造型";
			weakSelf.TeampickerView.defaultStr =  @"卵形/2";
			weakSelf.TeampickerView.valueDidSelect = ^(NSString *value){
				NSArray * stateArr = [value componentsSeparatedByString:@"/"];
				NSString *str = stateArr[0];
				cell.detailTextLabel.text = str;
				weakSelf.fabumodel.model = str;
			};
			[_TeampickerView show];
		}
		if (indexPath.row == 4) {
			NSLog(@"请选择栽培方式");
			weakSelf.TeampickerView.dataSource = @[@"圃地苗",@"容器苗",@"移栽苗",@"山地苗",@"野生苗"];
			weakSelf.TeampickerView.pickerTitle = @"选择栽培方式";
			weakSelf.TeampickerView.defaultStr = @"容器苗/2";
			weakSelf.TeampickerView.valueDidSelect = ^(NSString *value){
				NSArray * stateArr = [value componentsSeparatedByString:@"/"];
				NSString *str = stateArr[0];
				cell.detailTextLabel.text = str;
				weakSelf.fabumodel.culturalMethod = str;
			};
			[_TeampickerView show];
		}
	}else if (tableView.tag == 2) { // 技术措施
		if (indexPath.section == 0 && indexPath.row == 0) {
			NSLog(@"请选择包扎材质");
			weakSelf.TeampickerView.dataSource = @[@"草绳",@"麻布",@"遮阴网",@"铁丝",@"尼龙绳",@"其他：裸根"];
			weakSelf.TeampickerView.pickerTitle = @"选择包扎材质";
			weakSelf.TeampickerView.defaultStr = @"草绳/2";
			weakSelf.TeampickerView.valueDidSelect = ^(NSString *value){
				NSArray * stateArr = [value componentsSeparatedByString:@"/"];
				NSString *str = stateArr[0];
				cell.detailTextLabel.text = str;
				weakSelf.fabumodel.soilBallDress = str;
			};
			[_TeampickerView show];
		}
	}else if (tableView.tag == 3) { // 风险控制
		if ( indexPath.row == 4) {
			weakSelf.TeampickerView.dataSource = @[@"车辆限13.5米车",@"车辆限9.6米车",@"车辆限9.6米车以下",@"其他：17.5米挂车"];
			weakSelf.TeampickerView.pickerTitle = @"请选择";
			weakSelf.TeampickerView.defaultStr = @"车辆限9.6米车/2";
			weakSelf.TeampickerView.valueDidSelect = ^(NSString *value) {
				NSArray * stateArr = [value componentsSeparatedByString:@"/"];
				NSString *str = stateArr[0];
				cell.detailTextLabel.text = str;
				weakSelf.fabumodel.roadWay = str;
			};
			[_TeampickerView show];
		}
	}
}

/**
 选择数量
 */
- (void) buttonAction:(UIButton *)btn {
	_selectCell = (InputFaBuBuyViewCell *)btn.superview.superview;
	CGRect rect = [btn convertRect:btn.frame toView:_tableView];
	CGFloat viewX = CGRectGetMinX(btn.frame);
	CGFloat viewY = CGRectGetMinY(rect) -21.0f; //默认在按钮下方展示
	CGFloat viewW = CGRectGetWidth(rect);
	NSArray *dataArray = @[@"株",@"袋",@"盆",@"捆",@"芽",@"㎡"];
	CGFloat viewH = dataArray.count *rect.size.height;
	//防止视图超出屏幕
	if (viewY + viewH > _tableView.frame.size.height) {
		viewY =  CGRectGetMinY(rect) - viewH + 10.0f;
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

#pragma mark - MTSpecificationListViewDelegate

- (void) specificationListView:(MTSpecificationListView *_Nullable)specificationView
		  didSelectItemAtIndex:(NSInteger)index
					 withTitle:(NSString *_Nullable)title {
	[_selectCell.unitBut setTitle:title forState:UIControlStateNormal];
	self.fabumodel.unit = title;
}

#pragma mark - UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
	_tableView.scrollEnabled = YES;
	return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
	_tableView.scrollEnabled = NO;
	self.fabumodel.remark = textView.text;
	return YES;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	_tableView.scrollEnabled = YES;
	return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
	_tableView.scrollEnabled = NO;
	return YES;
}


/**
 获取请求参数
 */
- (NSDictionary *) getReqeustParamsWithTag:(NSInteger)tag {
	
	return @{};
}


@end




