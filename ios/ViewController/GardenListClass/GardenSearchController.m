//
//  GardenSearchController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/12/26.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "GardenSearchController.h"
#import "MTHomeSearchView.h"
#import "GardenListDetailViewController.h"
//#import "GardenModel.h"

@interface GardenSearchViewCell : UITableViewCell {
    UIAsyncImageView *_imageView;
    UILabel *_titleLabel;
//    UILabel *_nameLab;
    UILabel *_bangNameLab;
    UILabel *_paimingLab;
}
- (void) setGardenSearchModel:(yuanbangModel *)model;
@end


@implementation GardenSearchViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self createSubViews];
    }
    return self;
}
- (void) createSubViews {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(kWidth(55), kWidth(15), iPhoneWidth - kWidth(55)- kWidth(36), kWidth(80))];
    backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView];
    
    backView.layer.cornerRadius = kWidth(6);
    backView.layer.shadowColor = kColor(@"#05C1B0").CGColor;
    backView.layer.shadowOffset = CGSizeMake(0, 2);
    backView.layer.shadowOpacity = 0.2;
    backView.layer.shadowRadius = 10;
    
    _imageView = [[UIAsyncImageView alloc] initWithFrame:CGRectMake(kWidth(21), 0, kWidth(50), kWidth(50))];
    _imageView.centerY = backView.centerY;
    _imageView.centerX = backView.left;
    [self.contentView addSubview:_imageView];
    _imageView.layer.cornerRadius = kWidth(3);
    _imageView.transform = CGAffineTransformMakeRotation(M_PI_4);
    
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_imageView.width/2 +kWidth(10), kWidth(8), backView.width - _imageView.width/2 - kWidth(20) , kWidth(22))];
    _titleLabel.font = sysFont(14);
    _titleLabel.textColor = kColor(@"#4A4A4A");
    [backView addSubview:_titleLabel];
    
    _bangNameLab = [[UILabel alloc] initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom + kWidth(8), _titleLabel.width , kWidth(17))];
    _bangNameLab.font = sysFont(12);
    _bangNameLab.textColor = kColor(@"#9B9B9B");
    [backView addSubview:_bangNameLab];
    
    _paimingLab = [[UILabel alloc] initWithFrame:CGRectMake(_titleLabel.left, _bangNameLab.bottom + kWidth(3), _titleLabel.width , kWidth(17))];
    _paimingLab.font = sysFont(12);
    _paimingLab.textColor = kColor(@"#9B9B9B");
    [backView addSubview:_paimingLab];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth(32), kWidth(32))];
    imageView.image = [kImage(@"garden_right_img") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.contentView addSubview:imageView];
    imageView.centerY = backView.centerY;
    imageView.centerX = backView.right;
}

- (void) setGardenSearchModel:(yuanbangModel *)model {
    [_imageView setImageAsyncWithURL:model.indexUrl placeholderImage:DefaultImage_logo];
    _titleLabel.text = model.gardenCompany;
    _bangNameLab.text = [NSString stringWithFormat:@"所在榜单：%@",model.gardenListName];
    _paimingLab.text = [NSString stringWithFormat:@"排名：%@",model.paiming];
}
@end








@interface GardenSearchController () <TFFlowerSearchViewDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>{
    MTHomeSearchView *searchView;
    NSMutableArray *dataArr;
}
@property (nonatomic, strong)UITableView *tableView;
@end

static NSString *GardenSearchViewCellId = @"GardenSearchViewCell";

@implementation GardenSearchController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    leftbutton.hidden = YES;
    
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

    UIImage *bgImage1 = [UIImage imageWithColor:kColor(@"#05c1b0") size:CGSizeMake(iPhoneWidth, KtopHeitht)];
    UIImage *bgImage = [bgImage1 resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    [self.navigationController.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
    
}



- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [searchView.searchTextField resignFirstResponder];
    //设置全局状态栏字体颜色为黑色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    [self.navigationController.navigationBar setBackgroundImage:Image(@"") forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [searchView.searchTextField becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgaitonBar];
    [self createTableview];
    dataArr = [[NSMutableArray alloc] init];
    NSDictionary *dic = [IHUtility getUserDefalutDic:KGardenSearchDataDic];
    NSArray *arr = dic[@"content"];
    if (arr.count > 0) {
        for (NSDictionary * dic in arr) {
            yuanbangModel *model = [[yuanbangModel alloc] initWithDictionary:dic error:nil];
            [dataArr addObject:model];
        }
        return;
    }
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight - KtopHeitht) style:UITableViewStylePlain];
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _tableView;
}

- (void) createTableview {
    [self.view addSubview:self.tableView];
}

#pragma - mark 设置导航栏
- (void) setNavgaitonBar {
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = kWidth(1);
    leftbutton.frame = CGRectMake(0, 0, 0, 44);
    leftbutton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    leftbutton.hidden = YES;
    
    UIButton *leftBut = [UIButton buttonWithType:UIButtonTypeCustom];
    //修改标题和标题颜色
    leftBut.frame=CGRectMake(0, 0, 0, 44);
    
    
    UIView *leftCustomView = [[UIView alloc] initWithFrame:leftBut.frame];
    [leftCustomView addSubview: leftBut];
    UIBarButtonItem * leftButtonItem =[[UIBarButtonItem alloc] initWithCustomView: leftCustomView];
    self.navigationItem.leftBarButtonItems = @[leftButtonItem];
    
    searchView = [[MTHomeSearchView alloc] initWithFrame:CGRectMake(kWidth(20), 0,iPhoneWidth - kWidth(50) ,34)];
    searchView.layer.borderWidth = 0.0;
    searchView.layer.cornerRadius = 6;
    searchView.clipsToBounds = YES;
    searchView.delegate = self;
    searchView.backgroundColor = kColor(@"#f1f4f7");
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"输入企业名称开始搜索" attributes:@{NSForegroundColorAttributeName:kColor(@"#999999"),
                                        NSFontAttributeName:searchView.searchTextField.font
                                        }];
    searchView.searchTextField.attributedPlaceholder = attrString;
    self.navigationItem.titleView = searchView;
    searchView.searchTextField.textColor = [UIColor blackColor];
    searchView.searchTextField.text = @"";
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //修改标题和标题颜色
    cancleBtn.frame=CGRectMake(0, 0, 34, 44);
    UIBarButtonItem *rightSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    rightSpacer.width = kWidth(16);
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancleBtn.titleLabel.font = darkFont(15);
    [cancleBtn setTitleColor:kColor(@"#FFFFFF") forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancleAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *cancleItem = [[UIBarButtonItem alloc] initWithCustomView:cancleBtn];
    self.navigationItem.rightBarButtonItems = @[cancleItem,rightSpacer];
}

#pragma - mark tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kWidth(110);
}
- (void) cancleAction {
    [searchView.searchTextField resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GardenSearchViewCell *cell = [tableView dequeueReusableCellWithIdentifier:GardenSearchViewCellId];
    if (cell == nil) {
        cell =  [[GardenSearchViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:GardenSearchViewCellId];
    }
    yuanbangModel *model = dataArr[indexPath.row];
    [cell setGardenSearchModel:model];
    cell.selectionStyle = UITableViewCellStyleDefault;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"选中了第 ==== %ld 个",indexPath.row);
    [searchView.searchTextField resignFirstResponder];
    yuanbangModel *model = dataArr[indexPath.row];
    GardenListDetailViewController *DeailVc = [[GardenListDetailViewController alloc] init];
    DeailVc.model = model;
    [self pushViewController:DeailVc];
}

#pragma - mark TFFlowerSearchViewDelegate 搜索
- (void)flowerSearchViewWithText:(NSString *)searchText textField:(UITextField *)textField{
    NSLog(@"搜索代理 ==== %@",textField.text);
    [searchView.searchTextField resignFirstResponder];
    [self getSearchText:textField.text];
}
- (void)flowertextFieldCleartextField:(UITextField *)textField {
    [searchView.searchTextField resignFirstResponder];
    [self getSearchText:@""];
}
- (void) getSearchText:(NSString *)text {
    [searchView.searchTextField resignFirstResponder];
    [self addWaitingView];
    NSDictionary *dict = @{
                           @"gardenCompany"   : text,
                           @"deviceNumber"    : [[UIDevice currentDevice] identifierForVendor].UUIDString,       //UUID
                           };
    [network httpRequestWithParameter:dict method:GardenSearchDataUrl success:^(NSDictionary *obj) {
        [self removeWaitingView];
        NSArray *arr = obj[@"content"];
		[self->dataArr removeAllObjects];
        for (NSDictionary * dic in arr) {
            yuanbangModel *model = [[yuanbangModel alloc] initWithDictionary:dic error:nil];
			[self->dataArr addObject:model];
        }
        if (text.length <= 0) {
            [IHUtility setUserDefaultDic:obj key:KGardenSearchDataDic];
        }
		[self->_tableView reloadData];
    } failure:^(NSDictionary * obj) {
        [self removeWaitingView];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
