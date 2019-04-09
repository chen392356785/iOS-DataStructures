//
//  SelectAddressViewController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/4/1.
//  Copyright © 2019 听花科技. All rights reserved.
//

#import "SelectAddressViewController.h"
#import "AddresModel.h"
#import "AddAddressViewController.h"

@interface SelectAddressCell () {
    UIView *_bgView;
    UILabel *_titleLab;
    UILabel *_addLab;
    UILabel *_nameLab;
    
}
@property (nonatomic, strong) AddresModel *model;
@property (nonatomic, copy) DidSelectBlock selectBlock;

@end

@implementation SelectAddressCell

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
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(kWidth(17), kWidth(12), kWidth(343), kWidth(112))];
    [self.contentView addSubview:_bgView];
    _bgView.backgroundColor = kColor(@"#FFFFFF");
    _bgView.layer.shadowColor = [UIColor colorWithRed:97/255.0 green:97/255.0 blue:97/255.0 alpha:0.24].CGColor;
    _bgView.layer.shadowOffset = CGSizeMake(0,1);
    _bgView.layer.shadowOpacity = 1;
    _bgView.layer.shadowRadius = 4;
    _bgView.layer.cornerRadius = 7;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth(15), kWidth(23), kWidth(14), kWidth(14))];
    imageView.image = kImage(@"guoqiu_company");
    [_bgView addSubview:imageView];
    
    UILabel *labl1 = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right + kWidth(10), kWidth(12), _bgView.width - imageView.right - kWidth(20), kWidth(17))];
    labl1.text = @"杭州市袁四季春苗圃";
    labl1.font = sysFont(font(14));
    [_bgView addSubview:labl1];
    labl1.centerY = imageView.centerY;
    [labl1 sizeToFit];
    _titleLab= labl1;
    
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(imageView.left, imageView.bottom + kWidth(12), kWidth(14), kWidth(14))];
    imageView2.image = kImage(@"guoqiu_weiz");
    [_bgView addSubview:imageView2];
    
    UILabel *labl2 = [[UILabel alloc] initWithFrame:CGRectMake(imageView2.right + kWidth(10), kWidth(12), _bgView.width - imageView.right - kWidth(20), kWidth(17))];
    labl2.text = @"浙江省杭州市余杭区梦想小镇899号";
    labl2.font = sysFont(font(14));
    labl2.textColor = kColor(@"#575656");
    labl2.centerY = imageView2.centerY;
    [_bgView addSubview:labl2];
    _addLab = labl2;
    [labl2 sizeToFit];
    
    
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(imageView.left, imageView2.bottom + kWidth(12), kWidth(14), kWidth(14))];
    imageView3.image = kImage(@"guoqiu_user");
    [_bgView addSubview:imageView3];
    
    UILabel *labl3 = [[UILabel alloc] initWithFrame:CGRectMake(imageView3.right + kWidth(10), 0, kWidth(56), kWidth(27))];
    labl3.text = @"王女士";
    labl3.font = sysFont(font(14));
    labl3.centerY = imageView3.centerY;
    labl3.textColor = kColor(@"#575656");
    _nameLab = labl3;
    [_bgView addSubview:labl3];
    [labl2 sizeToFit];
}
- (void)setModel:(AddresModel *)model {
    _titleLab.text = model.companyName;
    _addLab.text = model.address;
    _nameLab.text = model.contacts;
    [self setupAutoHeightWithBottomView:_bgView bottomMargin:kWidth(7)];
}
@end


@interface SelectAddressViewController () <UITableViewDelegate,UITableViewDataSource> {
    NSMutableArray *DataArrary;
    UITableView *_tablebView;
    
    
}

@end


static NSString *SelectAddressCellId = @"SelectAddressCell";

@implementation SelectAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"公司/苗圃";
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(AddcompleteAction)];
    item1.tintColor = kColor(@"#333333");
    self.navigationItem.rightBarButtonItem = item1;
    
    [self addCreareTableView];
    
    [self getDataSource];
}
- (void) completeAction {
    
}
- (void) addCreareTableView {
    DataArrary = [[NSMutableArray alloc] init];
    
    _tablebView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight - KtopHeitht) style:UITableViewStylePlain];
    _tablebView.delegate = self;
    _tablebView.dataSource = self;
    _tablebView.separatorColor = [UIColor clearColor];
    [self.view addSubview:_tablebView];
    
}
- (void) AddGuigeAction {
    AddresModel *model = [[AddresModel alloc] init];
    [DataArrary addObject:model];
    [_tablebView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return DataArrary.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SelectAddressCell *CellModel = DataArrary[indexPath.row];
    CGFloat height = [tableView cellHeightForIndexPath:indexPath model:CellModel keyPath:@"model" cellClass:[SelectAddressCell class] contentViewWidth:iPhoneWidth];
    return height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SelectAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:SelectAddressCellId];
    if (!cell) {
        cell = [[SelectAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SelectAddressCellId];
    }
    AddresModel *model = DataArrary[indexPath.row];
    [cell setModel:model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void) AddcompleteAction {
    AddAddressViewController *addVc = [[AddAddressViewController alloc] init];
    WS(weakSelf);
    addVc.updataBlock = ^{
        [weakSelf getDataSource];
    };
    [self pushViewController:addVc];
    

}

- (void) getDataSource {
    NSDictionary *dict = @{
                           @"userId"   : USERMODEL.userID,
                           };
    [network httpGETRequestTagWithParameter:dict method:userCompanylistUrl tag:IH_init success:^(NSDictionary *obj) {
        [self removeWaitingView];
        NSArray *arr = obj[@"content"];

        for (NSDictionary *dic in arr) {
            AddresModel *model = [[AddresModel alloc] initWithDictionary:dic error:nil];
			[self->DataArrary addObject:model];
        }
		[self->_tablebView reloadData];
    } failure:^(NSDictionary *obj) {
        [self removeWaitingView];
    }];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AddresModel *model = DataArrary[indexPath.row];
    if (self.changeBlock) {
        self.changeBlock(model.companyName,model.jid);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
