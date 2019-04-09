//
//  GardenMoreListController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/1/5.
//  Copyright © 2019年 听花科技. All rights reserved.
//

#import "GardenMoreListController.h"
#import "GardenListController.h"


@interface GardenMoreViewCell : UITableViewCell {
    UIView *backView;
    UIAsyncImageView *_imageView;
    UILabel *_titleLabel;
    UILabel *_nameLab;
    UILabel *lineLab;
    
    UIView *subBgView;
}
- (void) setGardenSearchModel:(gardenListsModel *)model;
@end


@implementation GardenMoreViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        [self createSubViews];
    }
    return self;
}
- (void) createSubViews {
    backView = [[UIView alloc] initWithFrame:CGRectMake(kWidth(10), kWidth(0), iPhoneWidth - kWidth(20), kWidth(101))];
    backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView];
    
    backView.layer.cornerRadius = kWidth(6);
    backView.layer.shadowColor = kColor(@"#05C1B0").CGColor;
    backView.layer.shadowOffset = CGSizeMake(0, 2);
    backView.layer.shadowOpacity = 0.2;
    backView.layer.shadowRadius = 10;
    
    _imageView = [[UIAsyncImageView alloc] initWithFrame:CGRectMake(backView.width - kWidth(10) - kWidth(72), kWidth(10), kWidth(72), kWidth(72))];
    _imageView.centerY = backView.centerY;
    [backView addSubview:_imageView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake( kWidth(10), _imageView.top, _imageView.left - kWidth(20) , kWidth(22))];
    _titleLabel.font = darkFont(16);
    _titleLabel.textColor = kColor(@"#4A4A4A");
    [backView addSubview:_titleLabel];
    
    subBgView = [[UIView alloc] initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom + kWidth(3), _titleLabel.width, backView.height - _titleLabel.bottom - kWidth(5))];
    [backView addSubview:subBgView];
}

- (void) setGardenSearchModel:(gardenListsModel *)model {
    UIColor *textColor = kColor(@"#9B9B9B");
    [_imageView setImageAsyncWithURL:model.indexUrl placeholderImage:DefaultImage_logo];
    _titleLabel.text = model.name;
    [subBgView removeAllSubviews];
    int i = 0;
    for (yuanbangModel *BangModel in model.gardenBangs) {
        UILabel *gardLab = [[UILabel alloc] initWithFrame:CGRectMake(kWidth(3), kWidth(16) * i, subBgView.width , kWidth(14))];
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




@interface GardenMoreListController () <UITableViewDelegate,UITableViewDataSource> {
    NSMutableArray *dataArr;
    EmptyPromptView *_EPView;
}
@property (nonatomic, strong)UITableView *tableView;
@end

static NSString *GardenMoreViewCellId = @"GardenMoreViewCell";

@implementation GardenMoreListController

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
        _tableView.backgroundColor = kColor(@"#FFFFFF");
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _tableView;
}

- (void) createTableview {
    [self.view addSubview:self.tableView];
    NSString *context = @"暂无相关榜单哦~";
    EmptyPromptView *EPView  = [[EmptyPromptView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.size.width, self.tableView.size.height) context:context];
    EPView.hidden = YES;
    _EPView = EPView;
    [self.tableView addSubview:EPView];
}
#pragma - mark tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return dataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kWidth(101);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kWidth(10);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GardenMoreViewCell *cell = [tableView dequeueReusableCellWithIdentifier:GardenMoreViewCellId];
    if (cell == nil) {
        cell =  [[GardenMoreViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:GardenMoreViewCellId];
    }
    gardenListsModel *model = dataArr[indexPath.section];
    [cell setGardenSearchModel:model];
    cell.selectionStyle = UITableViewCellStyleDefault;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GardenListController *bangListVc = [[GardenListController alloc] init];
    bangListVc.model = dataArr[indexPath.section];
    [self pushViewController:bangListVc];
}

- (void) getNewListData {
    [self addWaitingView];
    NSDictionary *dict = @{
                           @"cateId"  :   self.model.jid,
                           };
    [network httpRequestWithParameter:dict method:GardenMoreDataUrl success:^(NSDictionary *obj) {
        [self removeWaitingView];
        NSArray *arr = obj[@"content"];
		[self->dataArr removeAllObjects];
        if (arr.count < 1) {
			self->_EPView.hidden = NO;
            return ;
        }
        for (int i = 0; i < arr.count; i ++) {
            NSDictionary *obj = arr[i];
            gardenListsModel *model = [[gardenListsModel alloc] initWithDictionary:obj error:nil];
			[self->dataArr addObject:model];
        }
		[self->_tableView reloadData];
		self->_EPView.hidden = YES;
    } failure:^(NSDictionary * obj) {
        [self removeWaitingView];
    }];
}


@end
