//
//  BuyCellSubView.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/3/30.
//  Copyright © 2019 听花科技. All rights reserved.
//

#import "BuyCellSubView.h"
#import "InputFaBuBuyViewCell.h"

#import "MTSpecificationListView.h"

#import "ValuePickerView.h"     //类别选择

static NSString *BuyInfocellId = @"InputFaBuBuyViewCell";

@interface BuyCellSubView ()<MTSpecificationListViewDelegate> {
    UITableView *_tableView;
    __weak InputFaBuBuyViewCell *_selectCell;
    MTSpecificationListView *_specView;
}
@property (nonatomic, strong) ValuePickerView *TeampickerView;      //类别选择


@end

static  int tag = 0;

@implementation BuyCellSubView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self dataInit];
    }
    return self;
}
- (void) dataInit {
    _infoArr = @[@[@"*公司/苗圃名称:"],@[@"*主营品种：",@"*数量:",@"*培育方式:",@"*高度（*/m）：",@"*冠幅（*/m）：",@"*分支点（*/m）：",@"*规格：",@"*单价："]];
    
    _xingTaiArr = @[@"枝叶茂密程度：",@"有无明显主杆：",@"*种类：",@"造型：",@"栽培方式："];
    _technicalArr = @[@[@"土球起挖包扎技术及包扎材质：",@"*球土质：",@"保护措施："],@[@"直径（*/cm）：",@"厚度（*/cm）：",@"形状："]];
    _riskControloArr = @[@"*是否有病虫害：",@"育苗期是否做过收枝的修剪：",@"水肥：",@"装车、起吊技术：",@"苗圃内转运及道路方便程度："];
    _headTitleArr = @[@[@"公司/苗圃基本信息",@"苗木基本信息"],@[@"苗木产品形态"],@[@"苗木技术措施",@"土球尺寸"],@[@"苗木质量风险控制"]];
    self.TeampickerView = [[ValuePickerView alloc]init];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(CommitNotificationBuyFabuAction:) name:NotificationBuyFabuAction object:nil];
    
}


- (void)setIndex:(NSInteger)index {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStyleGrouped];
    [self addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorColor = [UIColor clearColor];
    tableView.tag = index;
    _tableView = tableView;
    tableView.scrollEnabled = NO;
}
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
        NSArray *arr = _technicalArr[section];
        return arr.count;
    }else {
        return _riskControloArr.count;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kWidth(47);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    InputFaBuBuyViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BuyInfocellId];
    if (cell == nil) {
        cell = [[InputFaBuBuyViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:BuyInfocellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    cell.detailTextLabel.font = sysFont(14);
    cell.detailTextLabel.textColor = kColor(@"#828282");
    cell.userInteractionEnabled = YES;
    cell.numberView.hidden = YES;
    WS(weakSelf);
    if (tableView.tag == 0) {
        NSArray *arr = _infoArr[indexPath.section];
        cell.titleStr = arr[indexPath.row];
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                cell.textField.hidden = YES;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.detailTextLabel.text = @"请选择名称";
                cell.detailTextLabel.textColor = kColor(@"#828282");
            }
        }else {
            if (indexPath.section == 1) {
                if (indexPath.row == 0 ) {
                    cell.detailTextLabel.text = @"请选择品种";
                    cell.textField.hidden = YES;
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }
                if (indexPath.row == 1) {
                    cell.textField.hidden = YES;
                    cell.numberView.hidden = NO;
                    cell.unitBut.hidden = NO;
                    self.fabumodel.number = @"1";
                    cell.numberView.resultNumber = ^(NSString *number) {
                        weakSelf.fabumodel.number = [NSString stringWithFormat:@"%ld",[number integerValue]];
                    };
                    if (cell.unitBut.titleLabel.text.length < 1) {
                        [cell.unitBut setTitle:@"株" forState:UIControlStateNormal];
                        weakSelf.fabumodel.unit = @"株";
                    }
                    [cell.unitBut addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
                    
                }else {
                    cell.numberView.hidden = YES;
                    cell.unitBut.hidden = YES;
                }
                if (indexPath.row == 2) {
                    cell.textField.hidden = YES;
                    NSArray *arr = @[@"籽播苗",@"扦插苗",@"嫁接苗",@"移栽苗"];
                    cell.emergencyArr = arr;
                    self.fabumodel.raiseMethod = arr[0];
                    cell.SegmentSelbloack = ^(NSInteger index) {
                        weakSelf.fabumodel.raiseMethod = arr[index];
                    };
                }
                if (indexPath.row == 3) {
                    cell.textField.keyboardType = UIKeyboardTypeDecimalPad;
                    cell.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
                    cell.inputBlock = ^(NSString *inputResult) {
                        weakSelf.fabumodel.height = inputResult;
                    };
                }
                if (indexPath.row == 4) {
                    cell.textField.keyboardType = UIKeyboardTypeDecimalPad;
                    cell.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
                    cell.inputBlock = ^(NSString *inputResult) {
                        weakSelf.fabumodel.crownWidth = inputResult;
                    };
                }
                if (indexPath.row == 5) {
                    cell.textField.keyboardType = UIKeyboardTypeDecimalPad;
                    cell.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
                    cell.inputBlock = ^(NSString *inputResult) {
                        weakSelf.fabumodel.windPoint = inputResult;
                    };
                }
                if (indexPath.row == 6) {
                    cell.textField.hidden = YES;
                    cell.detailTextLabel.text = @"请选择规格";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }
                if (indexPath.row == 7) {
                   cell.textField.hidden = YES;
                   cell.detailTextLabel.text = @"请选择单价";
                   cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }
            }
            
        }
        
    }else if(tableView.tag == 1) {
        cell.textField.hidden = YES;
        if (indexPath.row == 0) {
            cell.fabuCuttView.lefttStr = @"疏";
            cell.fabuCuttView.rightStr = @"密";
            cell.fabuCuttView.isRightSelect = YES;
            cell.fabuCuttView.hidden = NO;
            self.fabumodel.density = @"密";
            cell.inputBlock = ^(NSString *str1) {
                weakSelf.fabumodel.density = str1;
            };
        }
        if (indexPath.row == 1) {
            cell.systemSwitch.hidden = NO;
            self.fabumodel.hasTrunk = @"有";
            cell.inputBlock = ^(NSString *str1) {
                weakSelf.fabumodel.hasTrunk = str1;
            };
        }else {
            cell.systemSwitch.hidden = YES;
        }
        if (indexPath.row == 2) {
            cell.fabuCuttView.lefttStr = @"独杆";
            cell.fabuCuttView.rightStr = @"丛生";
            cell.fabuCuttView.isRightSelect = NO;
            cell.fabuCuttView.hidden = NO;
            self.fabumodel.type = @"独杆";
            cell.inputBlock = ^(NSString *str1) {
                weakSelf.fabumodel.type = str1;
            };
        }
        if (indexPath.row == 3 ) {
            cell.detailTextLabel.text = @"选择造型";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (indexPath.row == 4) {
            cell.detailTextLabel.text = @"请选择栽培方式";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.titleStr = _xingTaiArr[indexPath.row];
    }else if(tableView.tag == 2) {
        NSArray *arr = _technicalArr[indexPath.section];
        cell.titleStr = arr[indexPath.row];
        if (indexPath.section == 0) {
            cell.textField.hidden = YES;
            if (indexPath.row == 0) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.detailTextLabel.text = @"请选择";
            }
            if (indexPath.row == 1) {
                NSArray *arr = @[@"黄土",@"沙土",@"红土",@"黑土"];
                cell.emergencyArr = arr;
                self.fabumodel.soilBall = arr[0];
                cell.SegmentSelbloack = ^(NSInteger index) {
                    weakSelf.fabumodel.soilBall = arr[index];
                };
            }
            if (indexPath.row == 2) {
                NSArray *arr = @[@"树干缠亚麻",@"收支",@"修剪",@"去叶"];
                 cell.payTypeArr = arr;
                 self.fabumodel.safeguard = arr[0];
                cell.segmentedControl.apportionsSegmentWidthsByContent = YES;
                cell.SegmentSelbloack = ^(NSInteger index) {
                    weakSelf.fabumodel.safeguard = arr[index];
                };
            }else {
                cell.segmentedControl.apportionsSegmentWidthsByContent = NO;
            }
        }
       
        if (indexPath.section == 1) {
            if (indexPath.row == 2) {
                cell.fabuCuttView.lefttStr = @"锥形";
                cell.fabuCuttView.rightStr = @"苹果包";
                cell.fabuCuttView.isRightSelect = NO;
                cell.fabuCuttView.hidden = NO;
                cell.textField.hidden = YES;
                self.fabumodel.soilBallShape = @"锥形";
                cell.inputBlock = ^(NSString *str1) {
                    weakSelf.fabumodel.soilBallShape = str1;
                };
                
            }
            if (indexPath.row == 1) {
                cell.textField.placeholder = @"请输入厚度";
                cell.textField.textAlignment = NSTextAlignmentRight;
                cell.textField.keyboardType = UIKeyboardTypeDecimalPad;
                cell.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
                cell.inputBlock = ^(NSString *inputResult) {
                    weakSelf.fabumodel.soilThickness = inputResult;
                };
            }
            if (indexPath.row == 0) {
                cell.textField.keyboardType = UIKeyboardTypeDecimalPad;
                cell.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
                cell.inputBlock = ^(NSString *inputResult) {
                    weakSelf.fabumodel.soilBallSize = inputResult;
                };
            }
        }
    }else {
        cell.titleStr = _riskControloArr[indexPath.row];
        cell.textField.hidden = YES;
        if (indexPath.row == 0) {
            NSArray *arr = @[@"无",@"一般",@"严重"];
            cell.emergencyArr = arr;
            self.fabumodel.insectPest = arr[0];
            cell.SegmentSelbloack = ^(NSInteger index) {
                weakSelf.fabumodel.insectPest = arr[index];
            };
        }
        if (indexPath.row == 1) {
            cell.systemSwitch.hidden = NO;
            cell.systemSwitch.on = NO;
            self.fabumodel.trim = @"否";
            cell.inputBlock = ^(NSString *str1) {
                if ([str1 isEqualToString:@"有"]) {
                    weakSelf.fabumodel.trim = @"是";
                }else {
                    weakSelf.fabumodel.trim = @"否";
                }
                
            };
        }else {
            cell.systemSwitch.hidden = YES;
        }
        if (indexPath.row == 2) {
            cell.fabuCuttView.lefttStr = @"一般";
            cell.fabuCuttView.rightStr = @"充足";
            cell.fabuCuttView.isRightSelect = YES;
            cell.fabuCuttView.hidden = NO;
            
            self.fabumodel.waterFertilizer = @"充足";
            cell.inputBlock = ^(NSString *str1) {
                weakSelf.fabumodel.waterFertilizer = str1;
            };
        }
        if (indexPath.row == 3) {
            cell.fabuCuttView.lefttStr = @"一般水平";
            cell.fabuCuttView.rightStr = @"技术过硬";
            cell.fabuCuttView.isRightSelect = YES;
            cell.fabuCuttView.hidden = NO;
            if (self.fabumodel.loadLift == nil) {
                self.fabumodel.loadLift = @"技术过硬";
            }
            cell.inputBlock = ^(NSString *str1) {
                weakSelf.fabumodel.loadLift = str1;
            };
        }
        if (indexPath.row == 4) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = @"请选择";
        }
        
    }
    return cell;
}


//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *view = [[UIView alloc] init];
//    view.backgroundColor = kColor(@"#FBFBFB");
//    [view removeAllSubviews];
//    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(kWidth(13), kWidth(30), iPhoneWidth - kWidth(26), kWidth(16))];
//    title.textColor = kColor(@"#ABABAB");
//    title.font = sysFont(font(14));
//    [view addSubview:title];
//    NSInteger tag = tableView.tag;
//    NSArray *arr = _headTitleArr[tag];
//    title.text = arr[section];
//    return nil;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return kWidth(57);
//}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    return view;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WS(weakSelf);
    InputFaBuBuyViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if (tableView.tag == 0) {       //基本信息
        if (indexPath.section == 0 && indexPath.row == 0) {
            if (weakSelf.selectCompanyNameBlock) {
                weakSelf.selectCompanyNameBlock(cell.detailTextLabel);
            }
            NSLog(@"请选择名称");
        }
        if (indexPath.section == 1 && indexPath.row == 0) {
            if (weakSelf.selectPinZBlock) {
                weakSelf.selectPinZBlock(cell.detailTextLabel);
            }
        }
        if (indexPath.section == 1 && indexPath.row == 7) {
            if (weakSelf.selectMoneyBlock) {
                weakSelf.selectMoneyBlock(cell.detailTextLabel);
            }
            NSLog(@"请选择单价");
        }
        if (indexPath.section == 1 && indexPath.row == 6) {
            if (weakSelf.selectGuigeBlock) {
                weakSelf.selectGuigeBlock(cell.detailTextLabel);
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

//提交
-(void)CommitNotificationBuyFabuAction:(NSNotification *)notification {

    //NSDictionary *dic=[notification object];
    tag ++;
    if (tag == 4) {
        [self commitTableViewData];
        tag = 0;
    }
}
- (void) commitTableViewData {
    if (self.commmitselectBlock) {
        self.commmitselectBlock();
    }

}


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
- (void) specificationListView:(MTSpecificationListView *_Nullable)specificationView
          didSelectItemAtIndex:(NSInteger)index
                     withTitle:(NSString *_Nullable)title {
    [_selectCell.unitBut setTitle:title forState:UIControlStateNormal];
    self.fabumodel.unit = title;
}


@end
