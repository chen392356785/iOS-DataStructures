//
//  AddAddressViewController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/4/2.
//  Copyright © 2019 听花科技. All rights reserved.
//

#import "AddAddressViewController.h"
#import "AddresModel.h"
#import "MOFSPickerManager.h"

typedef void (^inPutblock)(NSString *inputResult);

@interface AddAddressCell () {
    
}
@property (nonatomic, strong) UILabel *titlelable;
@property (nonatomic, strong) IHTextField *textField;
@property (nonatomic, strong) AddresModel *model;
@property (nonatomic, copy) inPutblock inputBlock;

@end

@implementation AddAddressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanging:) name:UITextFieldTextDidChangeNotification object:self.textField];
        
    }
    return self;
}

- (void) createView {
    UILabel *lneLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, 1)];
    [self.contentView addSubview:lneLab];
    lneLab.backgroundColor = kColor(@"#E2E2E2");
    UILabel *labl1 = [[UILabel alloc] initWithFrame:CGRectMake(kWidth(13) , 0, iPhoneWidth/3, kWidth(17))];
    labl1.text = @"杭州市袁四季春苗圃";
    labl1.font = sysFont(font(14));
    [self.contentView addSubview:labl1];
    labl1.centerY = kWidth(46)/2;
    _titlelable = labl1;
    [labl1 sizeToFit];
    _textField = [[IHTextField alloc] initWithFrame:CGRectMake(labl1.right + kWidth(20), 0, iPhoneWidth - labl1.right - kWidth(40), kWidth(22))];
    [self.contentView addSubview:_textField];
    _textField.font = sysFont(font(14));
    _textField.textAlignment = NSTextAlignmentRight;
    _textField.centerY = _titlelable.centerY;
}
- (void)layoutSubviews {
     [_titlelable sizeToFit];
    _textField.frame = CGRectMake(_titlelable.right + kWidth(20), 0, iPhoneWidth - _titlelable.right - kWidth(40), kWidth(22));
    _textField.centerY = _titlelable.centerY;
}
-(void)textFieldChanging:(id)sender{
    if (self.inputBlock) {
        self.inputBlock(self.textField.text);
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

@end



@interface AddAddressViewController () <UITableViewDelegate,UITableViewDataSource>{
    NSArray *DataArrary;
    UITableView *_tablebView;
    NSMutableArray *mArr;
    NSMutableDictionary *putDic;
}

@end

static NSString *AddAddressCellId = @"AddAddressCell";

@implementation AddAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"公司/苗圃";
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(AddcompleteInfoAction)];
    item1.tintColor = kColor(@"#333333");
    self.navigationItem.rightBarButtonItem = item1;
    [self addCreareTableView];
}
- (void) addCreareTableView {
    putDic = [[NSMutableDictionary alloc] init];
    DataArrary = @[@"苗圃名称：",@"苗圃地址：",@"详细地址：",@"苗圃面积（亩）：",@"联系人：",@"联系电话："];
    NSArray *key = @[@"companyName",@"companyAddress",@"address",@"companyArea",@"contacts",@"contactsMobile"];
    mArr = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < DataArrary.count; i ++) {
        NSDictionary *dic  = @{@"textvaluestr":@"",@"titleName":DataArrary[i],@"key":key[i]};
        AddresModel *model =  [[AddresModel alloc] initWithDictionary:dic error:nil];
        [mArr addObject:model];
    }
    _tablebView.backgroundColor = kColor(@"#FBFBFB");
    _tablebView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight - KtopHeitht) style:UITableViewStylePlain];
    _tablebView.delegate = self;
    _tablebView.dataSource = self;
    _tablebView.separatorColor = [UIColor clearColor];
    [self.view addSubview:_tablebView];
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, kWidth(27))];
    headView.backgroundColor = kColor(@"#FBFBFB");
    _tablebView.tableHeaderView = headView;
    _tablebView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tablebView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return DataArrary.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kWidth(46);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [NSString stringWithFormat:@"%@%ld",AddAddressCellId,indexPath.row];
    AddAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[AddAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    AddresModel *model = mArr[indexPath.row];
    cell.inputBlock = ^(NSString *inputResult) {
        model.textvaluestr = inputResult;
    };
    cell.titlelable.text = DataArrary[indexPath.row];
    if (indexPath.row == 1) {
//        cell.textField.hidden = YES;
        cell.detailTextLabel.font = sysFont(14);
        cell.detailTextLabel.textColor = kColor(@"#828282");
        cell.textField.placeholder = @"请选择 >";
        cell.textField.enabled = NO;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else {
        cell.textField.text = model.textvaluestr;
        cell.textField.placeholder = [NSString stringWithFormat:@"请输入%@",DataArrary[indexPath.row]];
    }
    if (indexPath.row == 5) {
        cell.textField.keyboardType = UIKeyboardTypePhonePad;
        cell.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        AddAddressCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        AddresModel *model = mArr[indexPath.row];
        [[MOFSPickerManager shareManger] showMOFSAddressPickerWithDefaultZipcode:@"450000-450900-450921" title:@"选择地址" cancelTitle:@"取消" commitTitle:@"确定" commitBlock:^(NSString * _Nullable address, NSString * _Nullable zipcode) {
            
                cell.textField.text = [address stringByReplacingOccurrencesOfString:@"-" withString:@""];
                model.textvaluestr = [address stringByReplacingOccurrencesOfString:@"-" withString:@""];;
                NSLog(@"%@", zipcode);
            } cancelBlock:^{

        }];
    }
}
- (void) AddcompleteInfoAction {
    [putDic removeAllObjects];
    for (int i = 0; i < mArr.count; i ++) {
        AddresModel *model = mArr[i];
        if ([model.key isEqualToString:@"companyName"] || [model.key isEqualToString:@"contacts"] || [model.key isEqualToString:@"contactsMobile"]) {
            if ([model.textvaluestr isEqualToString:@""]|| model.textvaluestr.length < 1) {
                [self showTextHUD:[NSString stringWithFormat:@"请输入%@",model.titleName]];
                return;
            }
        }
        [putDic setObject:model.textvaluestr forKey:model.key];
    }
    [putDic setObject:USERMODEL.userID forKey:@"userId"];
    NSLog(@"putDic === %@",putDic);
    [self addWaitingView];
    NSString * parameter  = [IHUtility getParameterString:putDic];
    NSString *url = [NSString stringWithFormat:@"%@?%@",userCompanyCompanyUrl,parameter];
    [network httpRequestWithParameter:nil method:url success:^(NSDictionary *dic) {
        [self removeWaitingView];
        [self.navigationController popViewControllerAnimated:YES];
        if (self.updataBlock) {
            self.updataBlock();
        }
    } failure:^(NSDictionary *dic) {
        [IHUtility addSucessView:@"添加失败" type:2];
        [self removeWaitingView];
    }];
}
@end
