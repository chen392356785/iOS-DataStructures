//
//  GardenNewViewController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/1/4.
//  Copyright © 2019年 听花科技. All rights reserved.
//

#import "GardenNewViewController.h"
#import "GardenModel.h"
#import "GardenListController.h"


@interface GardenzuixinViewCell : UITableViewCell {
    UIView *backView;
    UIAsyncImageView *_imageView;
    UILabel *_titleLabel;
//    UILabel *_nameLab;
    UILabel *lineLab;
    
    UIView *subBgView;
}
- (void) setGardenSearchModel:(gardenListsModel *)model andIndex:(NSInteger )index;
@end


@implementation GardenzuixinViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        [self createSubViews];
    }
    return self;
}
- (void) createSubViews {
    backView = [[UIView alloc] initWithFrame:CGRectMake(kWidth(20), kWidth(0), iPhoneWidth - kWidth(40), kWidth(101))];
    backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView];

    _imageView = [[UIAsyncImageView alloc] initWithFrame:CGRectMake(kWidth(10), kWidth(20), kWidth(72), kWidth(72))];
    _imageView.centerY = backView.centerY;
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    [backView addSubview:_imageView];
  
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_imageView.right +kWidth(10), _imageView.top, backView.width - _imageView.right - kWidth(20) , kWidth(22))];
    _titleLabel.font = darkFont(16);
    _titleLabel.textColor = kColor(@"#05C1B0");
    [backView addSubview:_titleLabel];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(_imageView.left, backView.height - 1, backView.width - kWidth(20), 1)];
    line.backgroundColor = kColor(@"#05C1B0");
    lineLab = line;
    [backView addSubview:line];
    
    subBgView = [[UIView alloc] initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom + kWidth(3), _titleLabel.width, lineLab.bottom - _titleLabel.bottom - kWidth(3))];
    [backView addSubview:subBgView];
}

- (void) setGardenSearchModel:(gardenListsModel *)model andIndex:(NSInteger)index {
    UIColor *textColor;
    if (index == 0) {
        backView.frame = CGRectMake(kWidth(10), kWidth(0), iPhoneWidth - kWidth(20), kWidth(101));
        backView.layer.cornerRadius = kWidth(6);
        backView.backgroundColor = kColor(@"#05C1B0");
        _titleLabel.textColor = kColor(@"#FFFFFF");
        textColor = kColor(@"#FFFFFF");
    }else {
        backView.frame = CGRectMake(kWidth(20), kWidth(0), iPhoneWidth - kWidth(40), kWidth(101));
        backView.layer.cornerRadius = kWidth(0);
        backView.backgroundColor = [UIColor whiteColor];
        _titleLabel.textColor = kColor(@"#05C1B0");
        textColor = kColor(@"#05C1B0");
    }
    _imageView.origin = CGPointMake(kWidth(10), kWidth(20));
    _imageView.centerY = backView.centerY;
    [_imageView setImageAsyncWithURL:model.indexUrl placeholderImage:DefaultImage_logo];
    _titleLabel.text = model.name;
    subBgView.origin = CGPointMake(_titleLabel.left, _titleLabel.bottom + kWidth(3));
    [subBgView removeAllSubviews];
    int i = 0;
    for (yuanbangModel *BangModel in model.gardenBangs) {
        UILabel *gardLab = [[UILabel alloc] initWithFrame:CGRectMake(0, kWidth(16) * i, subBgView.width , kWidth(14))];
        gardLab.text = [NSString stringWithFormat:@"%d.%@",i+1,BangModel.gardenCompany];
        gardLab.font = darkFont(font(11));
        gardLab.textColor = textColor;
        gardLab.adjustsFontSizeToFitWidth = YES;
        if (i < 3) {
            [subBgView addSubview:gardLab];
        }
        i ++;
    }
}
@end







@interface GardenNewViewController () <UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *dataArr;
    UIView *footSubView;
}
@property (nonatomic, strong)UITableView *tableView;
@end


static NSString *GardenzuixinViewCellId = @"GardenzuixinViewCell";

@implementation GardenNewViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    keyboardManager.shouldResignOnTouchOutside = NO;
    keyboardManager.keyboardDistanceFromTextField = kWidth(30);

    [leftbutton setImage:kImage(@"icon_fh_b") forState:UIControlStateNormal];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    leftbutton.frame=CGRectMake(0, 0, 20, 44);
    leftbutton.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 10);
    
    UIImage *bgImage1 = [UIImage imageWithColor:kColor(@"#05c1b0") size:CGSizeMake(iPhoneWidth, KtopHeitht)];
    UIImage *bgImage = [bgImage1 resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    [self.navigationController.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    keyboardManager.shouldResignOnTouchOutside = YES;
    
    //设置全局状态栏字体颜色为黑色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    leftbutton.frame = CGRectMake(0, 0, 44, 44);
    [self.navigationController.navigationBar setBackgroundImage:Image(@"") forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.titleStr) {
        [self setTitle:self.titleStr andTitleColor:kColor(@"#ffffff")];
    }
    dataArr = [[NSMutableArray alloc] init];
    [self createTableview];
    [self getNewListData];
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight - KtopHeitht) style:UITableViewStylePlain];
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.backgroundColor = kColor(@"#CDF3EF");
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _tableView;
}

- (void) createTableview {
    [self.view addSubview:self.tableView];
    
    UIView *HeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, kWidth(20))];
    HeadView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = HeadView;
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, kWidth(30))];
    footView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = footView;
    UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(kWidth(20), 0, iPhoneWidth - kWidth(40), kWidth(14))];
    footSubView = subView;
    footSubView.backgroundColor = [UIColor clearColor];
    [footView addSubview:subView];
}
#pragma - mark tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kWidth(101);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GardenzuixinViewCell *cell = [tableView dequeueReusableCellWithIdentifier:GardenzuixinViewCellId];
    if (cell == nil) {
        cell =  [[GardenzuixinViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:GardenzuixinViewCellId];
    }
    gardenListsModel *model = dataArr[indexPath.row];
    [cell setGardenSearchModel:model andIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellStyleDefault;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GardenListController *bangListVc = [[GardenListController alloc] init];
    bangListVc.model = dataArr[indexPath.row];
    [self pushViewController:bangListVc];
}

- (void) getNewListData {
    [self addWaitingView];
    NSDictionary *dict = @{
                           @"gardenListUuid"  :   @"",
                           };
    [network httpRequestWithParameter:dict method:GardenzuixinDataUrl success:^(NSDictionary *obj) {
        [self removeWaitingView];
        NSArray *arr = obj[@"content"];
        [self->dataArr removeAllObjects];
        if (arr.count < 1) {
            return ;
        }
        self->footSubView.backgroundColor = [UIColor whiteColor];
        for (int i = 0; i < arr.count; i ++) {
            NSDictionary *obj = arr[i];
            gardenListsModel *model = [[gardenListsModel alloc] initWithDictionary:obj error:nil];
            [self->dataArr addObject:model];
        }
        [self->_tableView reloadData];
    } failure:^(NSDictionary * obj) {
        [self removeWaitingView];
    }];
}



@end
