//
//  AddSpecificationsController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/4/1.
//  Copyright © 2019 听花科技. All rights reserved.
//

#import "AddSpecificationsController.h"
#import "SpecifiModel.h"
#import "MTSpecificationListView.h"


@interface AddSpecifitionCell () {
    
}
@property (nonatomic, strong) IHTextField *guigeField;
@property (nonatomic, strong) IHTextField *moneyField;
@property (nonatomic, strong) UILabel *typeLab;
@property (nonatomic, strong) UIButton *typeBut;


@property (nonatomic, copy) DidSelectBlock selectBlock;
@end

@implementation AddSpecifitionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
        
    }
    return self;
}

- (void)layoutSubviews {
    
}
- (void) createView {
    UILabel *labl1 = [[UILabel alloc] initWithFrame:CGRectMake(kWidth(14), kWidth(12), kWidth(50), kWidth(17))];
    labl1.text = @"规格:";
    labl1.font = sysFont(font(14));
    [self.contentView addSubview:labl1];
    labl1.centerY = kWidth(65)/2;
    [labl1 sizeToFit];
    
    _guigeField = [[IHTextField alloc] initWithFrame:CGRectMake(labl1.right + kWidth(3), 0, kWidth(78), kWidth(27))];
    [self.contentView addSubview:_guigeField];
    _guigeField.layer.borderWidth = 1;
    _guigeField.layer.borderColor = kColor(@"#D5D5D5").CGColor;
    _guigeField.backgroundColor = kColor(@"#FAFAFA");
    _guigeField.centerY = labl1.centerY;
    _guigeField.font = sysFont(font(13));
    _guigeField.textAlignment = NSTextAlignmentCenter;
    _guigeField.placeholder = @"请输入规格";
    [self.contentView addSubview:_guigeField];
    _guigeField.keyboardType = UIKeyboardTypeDecimalPad;
    _guigeField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    UILabel *labl2 = [[UILabel alloc] initWithFrame:CGRectMake(_guigeField.right + kWidth(8), 0, kWidth(20), kWidth(17))];
    labl2.text = @":cm";
    labl2.font = sysFont(font(14));
    labl2.centerY = labl1.centerY - kWidth(2);
    [self.contentView addSubview:labl2];
    [labl2 sizeToFit];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(labl2.right + kWidth(20), 0, kWidth(56), 27);
    button.layer.borderWidth = 1;
    button.layer.borderColor = kColor(@"#05C1B0").CGColor;
    [self.contentView addSubview:button];
    [button setTitle:@"地径" forState:UIControlStateNormal];
    button.titleLabel.font = sysFont(14);
    [button setTitleColor:kColor(@"#252525") forState:UIControlStateNormal];
    button.centerY = labl1.centerY;
    _typeBut = button;
    
    UIImageView *selectImageView = [[UIImageView alloc] init];
    selectImageView.image = [UIImage imageNamed:@"specification_bottom"];
    [button addSubview:selectImageView];
    selectImageView.frame = CGRectMake(button.width - 13,button.height - 12, 13.0f,12.0f);
    
    
    _moneyField = [[IHTextField alloc] initWithFrame:CGRectMake(iPhoneWidth - kWidth(13) - kWidth(78), 0, kWidth(78), kWidth(27))];
    [self.contentView addSubview:_moneyField];
    _moneyField.layer.borderWidth = 1;
    _moneyField.layer.borderColor = kColor(@"#D5D5D5").CGColor;
    _moneyField.backgroundColor = kColor(@"#FAFAFA");
    _moneyField.font = sysFont(font(13));
    _moneyField.centerY = labl1.centerY;
    _moneyField.textAlignment = NSTextAlignmentCenter;
    _moneyField.placeholder = @"请输入单价";
    [self.contentView addSubview:_guigeField];
    _moneyField.keyboardType = UIKeyboardTypeDecimalPad;
    _moneyField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    UILabel *money = [[UILabel alloc] initWithFrame:CGRectMake(_moneyField.left - kWidth(9) - kWidth(10), 0, kWidth(10), kWidth(17))];
    money.text = @"￥";
    money.font = sysFont(font(14));
    money.centerY = _moneyField.centerY;
    [self.contentView addSubview:money];
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(labl1.left, kWidth(64), iPhoneWidth - labl1.left - kWidth(13), 1)];
    line.backgroundColor = kColor(@"#E2E2E2");
    [self.contentView addSubview:line];
}

@end




@interface AddSpecificationsController () <MTSpecificationListViewDelegate,UITableViewDelegate,UITableViewDataSource> {
    NSMutableArray *DataArrary;
    UITableView *_tablebView;
    NSMutableString *modelStr;
    __weak AddSpecifitionCell *_selectCell;
    MTSpecificationListView *_specView;
    
    NSMutableArray *guigeArr;
    NSMutableArray *moneyArr;
    
    CGFloat minGuige;
    CGFloat maxGuige;
    CGFloat minMoney;
    CGFloat maxMoney;
}
@end

static NSString *AddSpecifitionCellId = @"AddSpecifitionCell";


@implementation AddSpecificationsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"规格";
    
    guigeArr = [[NSMutableArray alloc] init];
    moneyArr = [[NSMutableArray alloc] init];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(EndCompleteAction)];
    item1.tintColor = kColor(@"#000000");
    self.navigationItem.rightBarButtonItem = item1;
    
    [self addCreareTableView];
}

- (void) addCreareTableView {
    DataArrary = [[NSMutableArray alloc] init];
    _tablebView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight - KtopHeitht) style:UITableViewStylePlain];
    _tablebView.delegate = self;
    _tablebView.dataSource = self;
    _tablebView.separatorColor = [UIColor clearColor];
    _tablebView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:_tablebView];
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, kWidth(150))];
    footView.backgroundColor = [UIColor clearColor];
    _tablebView.tableFooterView = footView;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setBackgroundImage:kImage(@"add_addres") forState:UIControlStateNormal];
    button.frame = CGRectMake(0, kWidth(21), kWidth(28), kWidth(28));
    [footView addSubview:button];
    button.centerX = footView.width/2;
    UILabel *infoLab = [[UILabel alloc] initWithFrame:CGRectMake(0, button.bottom + kWidth(10), iPhoneWidth, kWidth(17))];
    infoLab.text = @"添加规格";
    [footView addSubview:infoLab];
    infoLab.textColor = kColor(@"#555555");
    infoLab.textAlignment = NSTextAlignmentCenter;
    infoLab.font = sysFont(font(13));
    [button addTarget:self action:@selector(AddGuigeAction) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void) AddGuigeAction {
    SpecifiModel *model = [[SpecifiModel alloc] init];
    [DataArrary addObject:model];
    [_tablebView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return DataArrary.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kWidth(65);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddSpecifitionCell *cell = [tableView dequeueReusableCellWithIdentifier:AddSpecifitionCellId];
    if (!cell) {
        cell = [[AddSpecifitionCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:AddSpecifitionCellId];
    }
   cell.selectionStyle = UITableViewCellSelectionStyleNone;
   [cell.typeBut addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void) buttonAction:(UIButton *)btn {
    
    _selectCell = (AddSpecifitionCell *)btn.superview.superview;
    CGRect rect = [btn convertRect:btn.frame toView:_tablebView];
    CGFloat viewX = CGRectGetMinX(btn.frame);
    CGFloat viewY = CGRectGetMinY(rect) - 21.0f; //默认在按钮下方展示
    CGFloat viewW = CGRectGetWidth(rect);
    NSArray *dataArray = @[@"地径",@"胸径",@"米径"];
    CGFloat viewH = dataArray.count *rect.size.height;
    //防止视图超出屏幕
    if (viewY + viewH > _tablebView.frame.size.height) {
        viewY =  CGRectGetMinY(rect) - viewH + 10.0f;
    }
    
    if (_specView) {
        [_specView removeFromSuperview];
        _specView = nil;
    }
    //规格视图
    MTSpecificationListView *specView = [[MTSpecificationListView alloc] initWithFrame:CGRectMake(viewX,viewY,viewW,viewH) titleArray:dataArray];
    specView.delegate = self;
    [_tablebView addSubview:specView];
    _specView = specView;
    
}
- (void) specificationListView:(MTSpecificationListView *_Nullable)specificationView
          didSelectItemAtIndex:(NSInteger)index
                     withTitle:(NSString *_Nullable)title {
    [_selectCell.typeBut setTitle:title forState:UIControlStateNormal];
}

//完成
- (void) EndCompleteAction {
    modelStr = [[NSMutableString alloc] init];
    [guigeArr removeAllObjects];
    [moneyArr removeAllObjects];
    for (int i = 0; i < DataArrary.count ; i ++) {
        AddSpecifitionCell *cell = [_tablebView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        SpecifiModel *model = DataArrary[i];
        model.specifications = cell.guigeField.text;
        model.speciType = cell.typeBut.titleLabel.text;
        model.moneyStr = cell.moneyField.text;
        NSString *str = [model toJSONString];
        [modelStr appendFormat:@"%@",str];
        CGFloat guige = [cell.guigeField.text floatValue];
        CGFloat money = [cell.moneyField.text floatValue];
        [guigeArr addObject:[NSNumber numberWithFloat:guige]];
        [moneyArr addObject:[NSNumber numberWithFloat:money]];
    }
    maxGuige = [[guigeArr valueForKeyPath:@"@max.floatValue"] floatValue];
    minGuige = [[guigeArr valueForKeyPath:@"@min.floatValue"] floatValue];
    
    maxMoney = [[moneyArr valueForKeyPath:@"@max.floatValue"] floatValue];
    minMoney = [[moneyArr valueForKeyPath:@"@min.floatValue"] floatValue];
    NSString *GuigeScope;
    NSString *moneyScope;
    if(minGuige == maxGuige){
       GuigeScope = [NSString stringWithFormat:@"0.0 cm-%.1f cm",maxGuige];
    }else{
       GuigeScope =  [NSString stringWithFormat:@"%.1f cm-%.1f cm",minGuige,maxGuige];
    }
    if (minMoney == maxMoney ) {
       moneyScope = [NSString stringWithFormat:@"0.0元-%.1f元",maxMoney];
    }else {
       moneyScope = [NSString stringWithFormat:@"%.1f元-%.1f元",minMoney,maxMoney];
    }
    NSString *json = [NSString stringWithFormat:@"[%@]",modelStr];
    if (self.SpacifiBlock) {
        self.SpacifiBlock(GuigeScope, moneyScope, json);
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
@end
