//
//  MTPartnerViewController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/1/22.
//  Copyright © 2019年 听花科技. All rights reserved.
//

#import "MTPartnerViewController.h"

@interface inputJsonModel : JSONModel
@property (nonatomic, copy) NSString <Optional> *isBiTian;      //1必填
@property (nonatomic, copy) NSString <Optional> *isLook;        //1显示
@property (nonatomic, copy) NSString <Optional> *name;          //1名字
@property (nonatomic, copy) NSString <Optional> *placeStr;      //提示输入
@property (nonatomic, copy) NSString <Optional> *key;           //
@property (nonatomic, copy) NSString <Optional> *valueStr;      //保存输入的内容
@end

@implementation inputJsonModel

@end








typedef void (^CancelButBut) ();

@interface JoinPartnerSuccesView : UIView{
    UILabel *TitleLabel;
    UIButton *SureBut;
}
@property(nonatomic,copy) CancelButBut CancelBlock;

- (void)setTitle:(NSString *)title;

@end

@implementation JoinPartnerSuccesView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = kWidth(7);
        [self addlayoutSubView];
    }
    return self;
}
- (void) addlayoutSubView {

    TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kWidth(22), kWidth(29), kWidth(232), kWidth(40))];
    TitleLabel.textAlignment = NSTextAlignmentCenter;
    TitleLabel.font = darkFont(font(17));
    TitleLabel.numberOfLines = 0;
    [self addSubview:TitleLabel];
    TitleLabel.textColor = kColor(@"#333333");
    
    
    SureBut = [UIButton buttonWithType:UIButtonTypeSystem];
    SureBut.frame = CGRectMake(0, TitleLabel.bottom + kWidth(36), kWidth(175), kWidth(27));
    SureBut.layer.cornerRadius = SureBut.height/2.;
    [SureBut setTitle:@"确定" forState:UIControlStateNormal];
    SureBut.backgroundColor = kColor(@"#05C1B0");
    [SureBut setTitleColor:kColor(@"#FFFFFF") forState:UIControlStateNormal];
    SureBut.titleLabel.font = boldFont(font(14));
    SureBut.centerX = self.width/2;
    [SureBut addTarget:self action:@selector(SureAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:SureBut];
}

- (void)setTitle:(NSString *)title{
    TitleLabel.text = title;
    [TitleLabel sizeToFit];
    TitleLabel.centerX = self.width/2;
    SureBut.origin = CGPointMake(SureBut.left, TitleLabel.bottom + kWidth(36));
}
- (void) SureAction {
    if (self.CancelBlock) {
        self.CancelBlock();
    }
}
@end







@interface PartnerViewCell () {
    UILabel *_infoLab;
}
@property (nonatomic, strong) inputJsonModel *model;
@end

@implementation PartnerViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createText];
        //  添加输入完成会回调通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanging:) name:UITextFieldTextDidChangeNotification object:self.textField];
        
    }
    return self;
}
- (void) createText{
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(kWidth(15), kWidth(16), iPhoneWidth - kWidth(30), kWidth(15))];
    _infoLab = lab;
    _infoLab.textColor = kColor(@"#333333");
    _infoLab.font = darkFont(font(14));
    [self.contentView addSubview:_infoLab];
    
    _textField = [[IHTextField alloc] initWithFrame:CGRectMake(kWidth(15), _infoLab.bottom + kWidth(10), iPhoneWidth - kWidth(30), kWidth(44))];
    _textField.layer.cornerRadius = kWidth(5);
    _textField.backgroundColor = kColor(@"#FFFFFF");
    [self.contentView addSubview:_textField];
    _textField.font = sysFont(font(14));
    _textField.layer.borderWidth = 1;
    _textField.layer.borderColor = kColor(@"#CCCCCC").CGColor;
}
- (void)setModel:(inputJsonModel *)model {
    if ([model.isBiTian isEqualToString:@"1"]) {
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:model.name];
        [attributedStr addAttribute:NSForegroundColorAttributeName value:kColor(@"#FF0000") range:NSMakeRange(model.name.length - 1, 1)];
        _infoLab.attributedText = attributedStr;
    }else {
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:model.name];
        [attributedStr addAttribute:NSForegroundColorAttributeName value:kColor(@"#FF0000") range:NSMakeRange(model.name.length, 0)];
        _infoLab.attributedText = attributedStr;
    }
   _textField.placeholder = [NSString stringWithFormat:@" %@",model.placeStr];
  [self setupAutoHeightWithBottomView:_textField bottomMargin:kWidth(8)];
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





@interface MTPartnerViewController () <UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate>{
    UITableView *_tableView;
    NSArray *array;
    NSArray *keyArr;    //保存时对应的key
    NSArray *infoArr;
    NSMutableArray *dataArr;
    
    UIView *_tabFooterView;
    UIView *_RadioButView;
    NSString *isKnowStr;
    NSMutableDictionary *InputDic;
}
@property (nonatomic, strong) PlaceholderTextView *CompanyInfoTextView;

@end

@implementation MTPartnerViewController


- (PlaceholderTextView *)CompanyInfoTextView {
    if (_CompanyInfoTextView == nil) {
        _CompanyInfoTextView = [[PlaceholderTextView alloc] initWithFrame:CGRectMake(kWidth(15), kWidth(10), iPhoneWidth - kWidth(30), kWidth(139))];
        _CompanyInfoTextView.backgroundColor = kColor(@"#FFFFFF");
        _CompanyInfoTextView.layer.cornerRadius = kWidth(5);
        _CompanyInfoTextView.delegate = self;
        _CompanyInfoTextView.placeholderColor = kColor(@"#838383");
        _CompanyInfoTextView.placeholderFont = sysFont(14);
        _CompanyInfoTextView.layer.borderWidth = 1;
        _CompanyInfoTextView.font = sysFont(14);
        _CompanyInfoTextView.layer.borderColor = kColor(@"#CCCCCC").CGColor;
        _CompanyInfoTextView.placeholder = @"请输入公司简介";
    }
    return _CompanyInfoTextView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"加入合伙人";
    [self createTableview];
    array = @[@"您的姓名*",@"联系电话*",@"公司名称*",@"所在地区*"];
    keyArr = @[@"partnerName",@"parterMobile",@"parterCompany",@"parterAddress"];
    infoArr = @[@"请输入您的姓名",@"请输入您的电话",@"请输入您的公司名称",@"请输入您的所在地区"];
    dataArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < array.count; i ++) {
        inputJsonModel *model = [[inputJsonModel alloc] init];
        model.key = keyArr[i];
        model.name = array[i];
        model.placeStr = infoArr[i];
        if(![array[i] containsString:@"*"]){
            model.isBiTian = @"0";
        }
        else{
            model.isBiTian = @"1";
        }
        [dataArr addObject:model];
    }
    
    
}

- (void) createTableview {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight - KtopHeitht - kWidth(50)) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    _tabFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, kWidth(254))];
    _tableView.tableFooterView = _tabFooterView;
    isKnowStr = @"1";
    [self addTabFooterSubView];
    
    InputDic = [[NSMutableDictionary alloc] init];
    
    UIButton *_submitBut = [UIButton buttonWithType:UIButtonTypeSystem];
    _submitBut.frame = CGRectMake(0,_tableView.bottom, iPhoneWidth, kWidth(50));
    _submitBut.backgroundColor = kColor(@"#05c1b0");
    [_submitBut setTitle:@"提交" forState:UIControlStateNormal];
    [_submitBut setTitleColor:kColor(@"#ffffff") forState:UIControlStateNormal];
    _submitBut.titleLabel.font = boldFont(17);
    [_submitBut addTarget:self action:@selector(submitJoinListInfoAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_submitBut];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return array.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [NSString stringWithFormat:@"PartnerViewCellIdentifier%ld",indexPath.row];
    PartnerViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    inputJsonModel *model = dataArr[indexPath.row];
    if (!cell) {
        cell = [[PartnerViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.inputBlock = ^(NSString *inputResult) {
        model.valueStr = inputResult;
    };
    if ([model.name containsString:@"联系方式"]||[model.name containsString:@"电话"]) {
        cell.textField.keyboardType = UIKeyboardTypePhonePad;
        cell.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    cell.model = model;
    cell.selectionStyle = UITableViewCellStyleDefault;
    [cell.textField setValue:[NSNumber numberWithInt:5] forKey:@"paddingLeft"];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    inputJsonModel *CellModel = dataArr[indexPath.row];
    CGFloat height = [_tableView cellHeightForIndexPath:indexPath model:CellModel keyPath:@"model" cellClass:[PartnerViewCell class] contentViewWidth:iPhoneWidth];
    return height;
}

- (void)addTabFooterSubView {
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(kWidth(15), kWidth(16), iPhoneWidth - kWidth(30), kWidth(15))];
    lab.textColor = kColor(@"#333333");
    lab.font = darkFont(font(14));
    [_tabFooterView addSubview:lab];
    NSString *str = @"是否了解苗途*";
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:str];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:kColor(@"#FF0000") range:NSMakeRange(str.length - 1, 1)];
    lab.attributedText = attributedStr;
    
    UIView *RadioButView = [[UIView alloc] initWithFrame:CGRectMake(lab.left, lab.bottom + kWidth(10), lab.width, kWidth(40))];
    _RadioButView = RadioButView;
    [_tabFooterView addSubview:RadioButView];
    CGFloat maxX = 2;
    NSArray *arr = @[@"是",@"否"];
    for (int i = 0; i<arr.count; i++) {
        UIImage *img = [Image(@"radio_normal") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *selectedImg = [Image(@"radio_select") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setImage:img forState:UIControlStateNormal];
        [btn setImage:selectedImg forState:UIControlStateSelected];
        btn.titleLabel.textAlignment = NSTextAlignmentLeft;
        btn.tag = 200 + i;
        if (i==0) {
            btn.selected = YES;
        }
        [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [RadioButView addSubview:btn];
        
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.text = arr[i];
        titleLab.textColor = kColor(@"#838383");
        titleLab.font = sysFont(font(14));
        [titleLab sizeToFit];
        
        btn.frame = CGRectMake(maxX, kWidth(5), kWidth(25) + titleLab.width, kWidth(16));
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, btn.width - kWidth(16));
        
        titleLab.origin = CGPointMake(btn.width - titleLab.width, 0);
        titleLab.height = btn.height;
        [btn addSubview:titleLab];
        maxX = btn.right + kWidth(30);
    
    }
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(kWidth(15), RadioButView.bottom + kWidth(15), iPhoneWidth - kWidth(30), kWidth(15))];
    lab2.textColor = kColor(@"#333333");
    lab2.font = darkFont(font(14));
    [_tabFooterView addSubview:lab2];
    NSString *str2 = @"公司简介";
    lab2.text = str2;
    
    self.CompanyInfoTextView.frame = CGRectMake(lab2.left, lab2.bottom + kWidth(10), iPhoneWidth - kWidth(30), kWidth(139));
    [_tabFooterView addSubview:self.CompanyInfoTextView];
}

- (void)buttonAction:(UIButton *)btn {
    btn.selected = YES;
    NSArray *views = _RadioButView.subviews;
    for (UIView *view in views) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            if (button != btn) {
                button.selected = NO;
            }
        }
    }
    if ([btn.titleLabel.text isEqualToString:@"是"]) {
        isKnowStr = @"1";
    }else{
        isKnowStr = @"0";
    }
}

//提交
- (void)submitJoinListInfoAction {
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return;
    }
    [InputDic removeAllObjects];
    for (int i = 0; i < dataArr.count; i ++) {
        //        JoinGardenListCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        inputJsonModel *model = dataArr[i];
        if ([model.isBiTian isEqualToString:@"1"]) {
            if (model.valueStr.length <= 0) {
                [self showTextHUD:[NSString stringWithFormat:@"%@",model.placeStr]];
                return;
            }
        }
        [InputDic setObject:model.valueStr forKey:model.key];
    }
    [InputDic setObject:self.CompanyInfoTextView.text forKey:@"parterCompanyContent"]; //公司简介
    [InputDic setObject:isKnowStr forKey:@"isKnow"];        //是否了解
    [InputDic setObject:USERMODEL.userID forKey:@"userId"]; //
    NSLog(@"InputDic == %@",InputDic);

    [self sendNewGardenListInfo];
}
- (void) sendNewGardenListInfo {
    [self addWaitingView];
    [network httpRequestWithParameter:InputDic method:JoinPartnerUrl success:^(NSDictionary *dic) {
        [self removeWaitingView];
        [self popJoinGardenListSuccess];
    } failure:^(NSDictionary *dic) {
        [self removeWaitingView];
    }];
}
#pragma mark - Pop
- (void) popJoinGardenListSuccess {
    JoinPartnerSuccesView * gardPopView = [[JoinPartnerSuccesView alloc] initWithFrame:CGRectMake(0, 0, kWidth(275), kWidth(158))];
    [gardPopView setTitle:@"您的申请已收到\n客服小姐姐24小时内会联系您"];
    [self showPopupWithStyle:CNPPopupStyleCentered popupView:gardPopView];
    __weak typeof (self) weekSelf = self;
    gardPopView.CancelBlock = ^{
        [weekSelf dismissPopupController];
        [weekSelf.navigationController popViewControllerAnimated:YES];
    };
}
#pragma mark - 界面弹出框
- (void)showPopupWithStyle:(CNPPopupStyle)popupStyle popupView:(UIView *)popupView {
    self.popupViewController = [[CNPPopupController alloc] initWithContents:@[popupView]];
    self.popupViewController.theme = [CNPPopupTheme defaultTheme:popupView.frame.size.width];
    self.popupViewController.theme.popupStyle = popupStyle;
    self.popupViewController.theme.presentationStyle = CNPPopupPresentationStyleFadeIn;
    [self.popupViewController presentPopupControllerAnimated:YES];
}
- (void)dismissPopupController {
    [self.popupViewController dismissPopupControllerAnimated:YES];
}
@end
