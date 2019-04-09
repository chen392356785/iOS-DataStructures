//
//  MyCardListViewController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/12/20.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "MyCardListViewController.h"

#import "CardDetailViewController.h"

@implementation MyCarListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        [self createSubViews];
    }
    return self;
}
- (void) createSubViews {
    _bgImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth - kWidth(28), kWidth(103))];
    _bgImgV.centerX = iPhoneWidth/2.;
    [self.contentView addSubview:_bgImgV];
    _bgImgV.layer.cornerRadius = kWidth(6);
    _bgImgV.clipsToBounds = YES;
    _bgImgV.backgroundColor = kColor(@"#091435");
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(_bgImgV.width - kWidth(99), 0, 1, _bgImgV.height)];
    [_bgImgV addSubview:lineView];
    _lineView = lineView;
    [self drawDashLine:lineView lineLength:kWidth(6) lineSpacing:kWidth(4) lineColor:kColor(@"#FFFFFF")];
    
    _priceLab = [[UILabel alloc] initWithFrame:CGRectMake(_bgImgV.width - kWidth(33) - kWidth(30), kWidth(19), kWidth(30), kWidth(12))];
    _priceLab.text = @"价值";
    _priceLab.textAlignment = NSTextAlignmentRight;
    [_bgImgV addSubview:_priceLab];
    _priceLab.textColor = kColor(@"#FFFFFF");
    _priceLab.font = darkFont(font(12));
    
    _priceNumLab = [[UILabel alloc] initWithFrame:CGRectMake(_bgImgV.width - kWidth(23) - kWidth(50), _priceLab.bottom + kWidth(8), kWidth(50), kWidth(14))];
    _priceNumLab.textAlignment = NSTextAlignmentRight;
    [_bgImgV addSubview:_priceNumLab];
    _priceNumLab.textColor = kColor(@"#D90000");
    _priceNumLab.font = darkFont(font(14));
    _priceNumLab.adjustsFontSizeToFitWidth = YES;
    
    _button = [UIButton buttonWithType:UIButtonTypeSystem];
    _button.frame = CGRectMake(_bgImgV.width - kWidth(17) - kWidth(57), _priceNumLab.bottom + kWidth(11), kWidth(57), kWidth(17));
    _button.backgroundColor = kColor(@"#FFFFFF");
    [_button setTitle:@"去使用" forState:UIControlStateNormal];
    [_button setTitleColor:kColor(@"#262626") forState:UIControlStateNormal];
    [_bgImgV addSubview:_button];
    _button.layer.cornerRadius = _button.height/2;
    _button.titleLabel.font = sysFont(font(13));
    [_button addTarget:self action:@selector(goUseAction) forControlEvents:UIControlEventTouchUpInside];
    
    _timeLab = [[UILabel alloc] initWithFrame:CGRectMake(kWidth(19), _bgImgV.height - kWidth(14) - kWidth(12), lineView.left - kWidth(19), kWidth(12))];
    [_bgImgV addSubview:_timeLab];
    _timeLab.textColor = kColor(@"#FFFFFF");
    _timeLab.font = darkFont(font(14));
    _bgImgV.userInteractionEnabled = YES;
}
//去使用
- (void) goUseAction {
    if (self.goUseCarBlock) {
        self.goUseCarBlock();
    }
    NSLog(@"去使用");
}

/**
 ** lineView:       需要绘制成虚线的view
 ** lineLength:     虚线的宽度
 ** lineSpacing:    虚线的间距
 ** lineColor:      虚线的颜色
 **/
- (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(0, lineView.size.height/2)];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:lineView.size.width];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    //设置虚线绘制路径起点
    CGPathMoveToPoint(path, NULL, 0, 0);
    //设置虚线绘制路径终点
    CGPathAddLineToPoint(path, NULL, 0 , lineView.frame.size.height);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

- (void)updataCardModel:(CardListModel *)model andCodeType:(NSString *)code {
    if ([model.isUse isEqualToString:@"0"]) {
        if ([code isEqualToString:@"ka"]) {
            [_button setTitle:@"去试用" forState:UIControlStateNormal];
        }else {
            [_button setTitle:@"去使用" forState:UIControlStateNormal];
        }
        _button.userInteractionEnabled = YES;
    }else {
        _button.userInteractionEnabled = NO;
        if ([model.isUse isEqualToString:@"1"]) {
            [_button setTitle:@"已使用" forState:UIControlStateNormal];
        }else {
             [_button setTitle:@"已失效" forState:UIControlStateNormal];
        }
    }
    _timeLab.text = [NSString stringWithFormat:@"于%@到期",model.dueTime];
    NSURL *url = [NSURL URLWithString:model.putPic];
    [_bgImgV sd_setImageWithURL:url placeholderImage:kImage(@"")];
    _priceNumLab.text = [NSString stringWithFormat:@"￥ %@",model.price];
    
    if ([code isEqualToString:@"ka"]) {
        _lineView.hidden = YES;
        _timeLab.hidden = YES;
        _priceLab.hidden = YES;
        _priceNumLab.hidden = YES;
        _button.origin = CGPointMake(kWidth(18), _button.top);
    }else {
        _lineView.hidden = NO;
        _timeLab.hidden = NO;
        _priceNumLab.hidden = NO;
        _priceLab.hidden = NO;
        _button.origin = CGPointMake(_bgImgV.width - kWidth(17) - kWidth(57), _button.top);
    }
}
@end






@interface MyCardListViewController () <UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *dataArr;
    UITableView *_tableView;
    UIView *_headView;
    IHTextField *_inputCodeTf;
    
    UIView *_NoDataView;
}

@end

static NSString * MyCarListTableViewCellID = @"MyCarListTableViewCell";

@implementation MyCardListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColor(@"#F2F2F2");
    dataArr = [[NSMutableArray alloc] init];
    [self createTableview];
}
- (void) createTableview {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight - 41 - KtopHeitht ) style: UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:_tableView];
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, kWidth(78))];
    [self addTabHeadViewSubviews];
    if ([self.typeStr isEqualToString:@"0"]) {
        _tableView.tableHeaderView = _headView;
    }
    [self CreateTableViewRefesh:_tableView type:ENT_RefreshHeader successRefesh:^(MJRefreshComponent *refreshView) {
        [self loadRefeshData];
    }];
    [_tableView.mj_header beginRefreshing];
    
    UIView *NoDataView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth(138), kWidth(138) + kWidth(40))];
    _NoDataView = NoDataView;
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, NoDataView.width, kWidth(138))];
    imageV.image = kImage(@"img_mykq");
    [NoDataView addSubview:imageV];
    UILabel *titLab = [[UILabel alloc] initWithFrame:CGRectMake(0, imageV.bottom + kWidth(18), imageV.width, kWidth(22))];
    titLab.text = @"你还没有卡券哦~";
    titLab.textAlignment = NSTextAlignmentCenter;
    titLab.textColor = kColor(@"#4A4A4A");
    titLab.font = darkFont(14);
    [NoDataView addSubview:titLab];
    _NoDataView.hidden = YES;
    _NoDataView.centerX = iPhoneWidth/2;
    _NoDataView.centerY = iPhoneHeight/2. - KtopHeitht - _headView.height;
    [_tableView addSubview:_NoDataView];
    
}

- (void) addTabHeadViewSubviews {
    _headView.backgroundColor = kColor(@"#F2F2F2");
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(kWidth(12), kWidth(14), iPhoneWidth - kWidth(24), kWidth(50))];
    bgView.backgroundColor = kColor(@"#FFFFFF");
    bgView.layer.cornerRadius = 8;
    [_headView addSubview:bgView];
    
    IHTextField *inputCodeTf = [[IHTextField alloc] initWithFrame:CGRectMake(5, 0, bgView.width - kWidth(70), kWidth(30))];
    inputCodeTf.placeholder = @"输入兑换码";
    inputCodeTf.autocapitalizationType = UITextAutocapitalizationTypeNone;
    inputCodeTf.autocorrectionType = UITextAutocorrectionTypeNo;
    _inputCodeTf = inputCodeTf;
    [bgView addSubview:inputCodeTf];
    inputCodeTf.centerY = bgView.height/2.;
    
    UIButton *duihuanBut = [UIButton buttonWithType:UIButtonTypeSystem];
    duihuanBut.frame = CGRectMake(bgView.width - kWidth(60), 0, kWidth(50), kWidth(30));
    [duihuanBut setBackgroundColor:kColor(@"#05C1B0")];
    duihuanBut.layer.cornerRadius = kWidth(4);
    duihuanBut.centerY = inputCodeTf.centerY;
    [bgView addSubview:duihuanBut];
    [duihuanBut setTitle:@"兑换" forState:UIControlStateNormal];
    [duihuanBut setTitleColor:kColor(@"#FFFFFF") forState:UIControlStateNormal];
    duihuanBut.titleLabel.font = darkFont(font(14));
    [duihuanBut addTarget:self action:@selector(duihuanAction) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void) duihuanAction {
    if (_inputCodeTf.text.length <= 0) {
        return;
    }
    [_inputCodeTf resignFirstResponder];
    NSLog(@"兑换码 == %@",_inputCodeTf.text);
    NSString *userID = @"";
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return;
    }
    userID = USERMODEL.userID;
    NSDictionary *dic = @{
                          @"userId"     : userID,
                          @"cardCode"   : _inputCodeTf.text,
                          };
    [network httpRequestWithParameter:dic method:bindCardeUrl success:^(NSDictionary *obj) {
        [IHUtility addSucessView:@"兑换成功" type:1];
//        [_tableView.mj_header beginRefreshing];
    } failure:^(NSDictionary * obj) {
       
    }];
}

- (void) loadRefeshData {
    NSString *userID = @"";
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return;
    }
    userID = USERMODEL.userID;
    NSDictionary *dic = @{
                          @"user_id"     : userID,
                          @"type"        : self.typeStr,
                          };
    [network httpRequestWithParameter:dic method:myCardUrl success:^(NSDictionary *obj) {
        [self->_tableView.mj_header endRefreshing];
        NSArray *arr = obj[@"content"];
        [self->dataArr removeAllObjects];
        if (arr.count > 0) {
            for (NSDictionary *dic in arr) {
                CardContentModel *model = [[CardContentModel alloc] initWithDictionary:dic error:nil];
                [self->dataArr addObject:model];
            }
        }
        if (self->dataArr.count > 0) {
            self->_NoDataView.hidden = YES;
        }else {
            self->_NoDataView.hidden = NO;
        }
        [self->_tableView reloadData];
    } failure:^(NSDictionary * obj) {
        [self->_tableView.mj_header endRefreshing];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CardContentModel *model = dataArr[section];
    return model.list.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CardContentModel *model = dataArr[section];
    if (model.list.count > 0) {
        return kWidth(60);
    }else {
        return kWidth(0.);
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] init];
    [headView removeAllSubviews];
    
    CardContentModel *model = dataArr[section];
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth(16), kWidth(21), kWidth(24), kWidth(24))];
    if ([model.codeStr isEqualToString:@"ka"]) {
        imageV.image = kImage(@"icon_ka");
    }else {
        imageV.image = kImage(@"icon _quan");
    }
    [headView addSubview:imageV];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(imageV.right + kWidth(12), kWidth(21), kWidth(200), kWidth(24))];
    titleLab.text = model.name;
    titleLab.font = darkFont(font(18));
    titleLab.textColor = kColor(@"#333333");
    [headView addSubview:titleLab];
    return headView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kWidth(115);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CardContentModel *model = dataArr[indexPath.section];
    MyCarListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyCarListTableViewCellID];
    if (cell == nil) {
        cell = [[MyCarListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyCarListTableViewCellID];
    }
    [cell updataCardModel:model.list[indexPath.row] andCodeType:model.codeStr];
    cell.selectionStyle = UITableViewCellStyleDefault;
    WS(weakSelf);
    cell.goUseCarBlock = ^{
        if ([model.codeStr isEqualToString:@"ka"]) {
            
            [weakSelf exchangeCard:model.list[indexPath.row]];
        }else {
            CardDetailViewController *detailVc = [[CardDetailViewController alloc] init];
            detailVc.reloadBlock = ^{
                [self->_tableView.mj_header beginRefreshing];
            };
            detailVc.model = model.list[indexPath.row];
            [weakSelf pushViewController:detailVc];
        }
    };
    return cell;
}
- (void)exchangeCard:(CardListModel *) model {
    NSLog(@"卡包 -- 试用卡 = %@",model);
   
}
@end
