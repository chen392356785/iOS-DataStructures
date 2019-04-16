//
//  RoadInsturController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/9/1.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "RoadInsturController.h"
#import "ActivityListViewController.h"

@interface RoadtableViewCell : UITableViewCell {
    UIImageView *_imageView;
}
- (void) setimageUrl:(NSString *)urlStr;
@end

@implementation RoadtableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
    }
    return self;
}
- (void)layoutSubviews {
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.left.mas_equalTo(self);
    }];
}
- (void)setimageUrl:(NSString *)urlStr {
    [_imageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:DefaultImage_logo];
}
@end


@interface RoadInsturController () <UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
//    NSMutableArray *dataArr;
}

@end
static NSString *RoadtableViewCellID = @"RoadtableViewCellId";

@implementation RoadInsturController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = cBgColor;
    self.title = @"活动分类";
    [self createTableView];
}
- (void) createTableView {
//    dataArr = [[NSMutableArray alloc] init];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight - KtopHeitht - kWidth(50)) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0.;
    [self.view addSubview:_tableView];
    
    UIButton *bottomBut = [UIButton buttonWithType:UIButtonTypeSystem];
    bottomBut.frame = CGRectMake(0, _tableView.bottom, iPhoneWidth, kWidth(50));
    bottomBut.backgroundColor = kColor(@"#05c1b0");
    [bottomBut setTitle:@"选择赛事" forState:UIControlStateNormal];
    [bottomBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:bottomBut];
    bottomBut.titleLabel.font = boldFont(font(17));
    [bottomBut addTarget:self action:@selector(SelectShaishi) forControlEvents:UIControlEventTouchUpInside];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.imgList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.model.imgList.count-1) {
        return  iPhoneWidth/[self.model.pic_width floatValue]*[self.model.pic_height floatValue];
    }
    return  iPhoneWidth/[self.model.pic_width floatValue]*220;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RoadtableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RoadtableViewCellID];
    if (cell == nil) {
        cell = [[RoadtableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RoadtableViewCellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setimageUrl:self.model.imgList[indexPath.row]];
    return cell;
}
- (void) SelectShaishi {
    ActivityListViewController *actvitVC  = [[ActivityListViewController alloc] init];
    actvitVC.type = @"1";
    actvitVC.typeId = self.model.typeId;
    [self pushViewController:actvitVC];
}
@end
