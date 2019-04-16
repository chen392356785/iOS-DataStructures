//
//  SearchVarietiesController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/4/2.
//  Copyright © 2019 听花科技. All rights reserved.
//

#import "SearchVarietiesController.h"
#import "MTHomeSearchView.h"

@interface SearchVarietiesCell : UITableViewCell {
    UIAsyncImageView *_imageView;
    UILabel *_titleLabel;
}
- (void) setDict:(NSDictionary *)dic;
@end


@implementation SearchVarietiesCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self createSubViews];
    }
    return self;
}
- (void) createSubViews {
    _imageView = [[UIAsyncImageView alloc] initWithFrame:CGRectMake(kWidth(24), 0, kWidth(25), kWidth(25))];
    _imageView.centerY = kWidth(47)/2;
    [self.contentView addSubview:_imageView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_imageView.right +kWidth(19), 0, iPhoneWidth - _imageView.right - kWidth(40) , _imageView.height)];
    _titleLabel.font = sysFont(14);
    _titleLabel.textColor = kColor(@"#282828");
    _titleLabel.centerY = _imageView.centerY;
    [self.contentView addSubview:_titleLabel];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(_imageView.left, kWidth(46), _titleLabel.right - _imageView.left, 1)];
    line.backgroundColor = cLineColor;
    [self.contentView addSubview:line];
}

- (void)setDict:(NSDictionary *)dic {
    NSString *url = [NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,dic[@"nurseryIndexImage"]];
    [_imageView setImageAsyncWithURL:url placeholderImage:DefaultImage_logo];
    _titleLabel.text = dic[@"nurseryTypeName"];
}

@end


@interface SearchVarietiesController ()<TFFlowerSearchViewDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>{
    MTHomeSearchView *searchTextfiled;
    NSMutableArray *dataArr;
//    UITextField *_textField;
}
@property (nonatomic, strong)UITableView *tableView;

@end

@implementation SearchVarietiesController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    [leftbutton setImage:kImage(@"icon_fh_b") forState:UIControlStateNormal];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    leftbutton.frame=CGRectMake(0, 0, 20, 44);
    leftbutton.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 10);

    UIImage *bgImage1 = [UIImage imageWithColor:kColor(@"#F8F8F8") size:CGSizeMake(iPhoneWidth, KtopHeitht)];
    UIImage *bgImage = [bgImage1 resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    [self.navigationController.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //设置全局状态栏字体颜色为黑色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    leftbutton.frame = CGRectMake(0, 0, 44, 44);
    [self.navigationController.navigationBar setBackgroundImage:Image(@"") forBarMetrics:UIBarMetricsDefault];
    
}
#pragma - mark 设置导航栏
- (void) setNavigationBar {
    leftbutton.frame=CGRectMake(0, 0, 20, 44);
    leftbutton.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 10);
    
    self.navigationItem.rightBarButtonItem = nil;
   
    searchTextfiled = [[MTHomeSearchView alloc] initWithFrame:CGRectMake(0, 5, iPhoneWidth,34)];
    searchTextfiled.layer.borderWidth = 0.0;
    searchTextfiled.backgroundColor = kColor(@"#ffffff");
    searchTextfiled.searchTextField.backgroundColor =  kColor(@"#E6E6E6");
    searchTextfiled.delegate = self;
    [searchTextfiled.searchTextField setValue:kColor(@"#83847f") forKeyPath:@"_placeholderLabel.textColor"];
    searchTextfiled.searchTextField.placeholder = @"请输入品种名称";
    self.navigationItem.titleView = searchTextfiled;
    
    
}
- (void) searchAction {
    [self getSearchText:searchTextfiled.searchTextField.text];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    [self createTableview];
    [self getSearchText:@""];
    dataArr = [[NSMutableArray alloc] init];
  
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
#pragma - mark tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kWidth(47);
}
- (void) cancleAction {
    [searchTextfiled.searchTextField resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchVarietiesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell =  [[SearchVarietiesCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellID"];
    }
    cell.selectionStyle = UITableViewCellStyleDefault;
    NSDictionary *dict = dataArr[indexPath.row];
    [cell setDict:dict];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = dataArr[indexPath.row];
    if (self.changeBlock) {
        self.changeBlock(dict);
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

#pragma - mark TFFlowerSearchViewDelegate 搜索
- (void)flowerSearchViewWithText:(NSString *)searchText textField:(UITextField *)textField{
    NSLog(@"搜索代理 ==== %@",textField.text);
    [searchTextfiled.searchTextField resignFirstResponder];
    [self getSearchText:textField.text];
}
- (void)flowertextFieldCleartextField:(UITextField *)textField {
    [searchTextfiled.searchTextField resignFirstResponder];
    [self getSearchText:@""];
}
- (void)flowerChangeCharactersInRange:(NSString *)searchText textField:(UITextField *)textField{
    [self getSearchText:searchText];
}


- (void) getSearchText:(NSString *)text {
    NSDictionary *dict = @{
                           @"nurseryTypeName"   : text,
                           };
    [network httpGETRequestTagWithParameter:dict method:supplyBuyNuseryUrl tag:IH_init success:^(NSDictionary *obj) {
        [self removeWaitingView];
        NSArray *arr = obj[@"content"];
		[self->dataArr removeAllObjects];
        for (NSDictionary * dic in arr) {
			[self->dataArr addObject:dic];
        }
		[self->_tableView reloadData];
    } failure:^(NSDictionary *obj) {
        [self removeWaitingView];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
