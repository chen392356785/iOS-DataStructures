//
//  MessageViewCell.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/1/3.
//  Copyright © 2019年 听花科技. All rights reserved.
//

#import "MessageViewCell.h"
#import "CopyAbleLabel.h"
#import "GardenCommentCell.h"


@interface MessageViewCell ()<UITableViewDataSource, UITableViewDelegate> {
//    GardenCommentListModel *_model;
    NSMutableArray *dataArray;
    UILabel *linLab;
    UIView *_footView;
}
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIAsyncImageView *headImageView;
@property (nonatomic, strong) UILabel *timeLab;;
@property (nonatomic, strong) CopyAbleLabel *descLabel;
@property (nonatomic, strong) UIButton *pinglunBut;
@property (nonatomic, strong) UIButton *reportBut;
@property (nonatomic, strong) UIButton *DeleBut;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *footNumLab;




@end
static NSString *GardenCommentCellId  = @"GardenCommentCell";

@implementation MessageViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        [self creareSubview];
    }
    return self;
}
- (void) creareSubview {
    self.headImageView = [[UIAsyncImageView alloc] init];
    self.headImageView.backgroundColor = [UIColor whiteColor];
    self.headImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kWidth(10));
        make.left.top.mas_equalTo(kWidth(20));
        make.width.height.mas_equalTo(kWidth(32));
    }];
    self.headImageView.layer.cornerRadius = kWidth(16);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pinlunButAction)];
    // 允许用户交互
    self.headImageView.userInteractionEnabled = YES;
    [self.headImageView addGestureRecognizer:tap];
    
    // nameLabel
    self.nameLabel = [UILabel new];
    [self.contentView addSubview:self.nameLabel];
    self.nameLabel.textColor = kColor(@"#4A4A4A");
    self.nameLabel.numberOfLines = 0;
    self.nameLabel.font = sysFont(font(12));
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImageView.mas_right).offset(kWidth(10));
        make.top.mas_equalTo(self.headImageView);
        make.right.mas_equalTo(kWidth(95));
    }];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pinlunButAction)];
    // 允许用户交互
    self.nameLabel.userInteractionEnabled = YES;
    [self.nameLabel addGestureRecognizer:tap1];
    
    
    self.timeLab = [UILabel new];
    [self.contentView addSubview:self.timeLab];
    self.timeLab.textColor = kColor(@"#9B9B9B");
    self.timeLab.numberOfLines = 0;
    self.timeLab.font = sysFont(font(10));
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_offset(2);
        make.right.mas_equalTo(self.nameLabel);
    }];
    
    //评论内容
    self.descLabel = [CopyAbleLabel new];
    UITapGestureRecognizer *tapText = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapText:)];
    [self.descLabel addGestureRecognizer:tapText];
    [self.contentView addSubview:self.descLabel];
    self.descLabel.lineBreakMode = NSLineBreakByCharWrapping;
    self.descLabel.numberOfLines = 0;
    self.descLabel.textColor = kColor(@"#4A4A4A");
    self.descLabel.font = sysFont(font(10));
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel);
        make.right.mas_equalTo(self.contentView).mas_offset(-kWidth(20));
        make.top.mas_equalTo(self.timeLab.mas_bottom).offset(kWidth(10));
//        make.height.offset(kWidth(18));
    }];
    
    self.reportBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.reportBut addTarget:self action:@selector(reportButAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.reportBut];
    [self.reportBut setBackgroundImage:kImage(@"garden_jubao") forState:UIControlStateNormal];
    [self.reportBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).mas_offset(-kWidth(20));
        make.top.mas_equalTo(self.nameLabel.mas_top);
        make.width.height.offset(kWidth(18));
    }];
    
    self.pinglunBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.pinglunBut addTarget:self action:@selector(pinlunButAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.pinglunBut];
    [self.pinglunBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.reportBut.mas_left).mas_offset(-kWidth(10));
        make.top.mas_equalTo(self.reportBut.mas_top);
        make.width.height.offset(kWidth(18));
    }];
   [self.pinglunBut setBackgroundImage:kImage(@"garden_liuyan") forState:UIControlStateNormal];

    self.DeleBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.DeleBut addTarget:self action:@selector(DeleButAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.DeleBut];
    [self.DeleBut setTitle:@"删除" forState:UIControlStateNormal];
    [self.DeleBut setTitleColor:kColor(@"#9B9B9B") forState:UIControlStateNormal];
    self.DeleBut.titleLabel.font = sysFont(font(12));
    [self.DeleBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.pinglunBut.mas_left).mas_offset(-kWidth(10));
        make.top.mas_equalTo(self.reportBut.mas_top);
        make.width.offset(kWidth(24));
        make.height.offset(kWidth(18));
    }];
    
    
    CGRect rect = CGRectMake(self.nameLabel.left, self.descLabel.bottom + kWidth(8), iPhoneWidth - kWidth(20) - _tableView.left, kWidth(1));
    self.tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    self.tableView.scrollEnabled = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.contentView addSubview:self.tableView];
    self.tableView.userInteractionEnabled = YES;
    _tableView.estimatedRowHeight = 0;
    self.tableView.backgroundView.userInteractionEnabled = YES;
    
    UIView *TabfootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, kWidth(18))];
    UILabel *mlineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1, TabfootView.height)];
    mlineLab.backgroundColor = kColor(@"#05C1B0");
    [TabfootView addSubview:mlineLab];
    
    self.footNumLab = [[UILabel alloc] initWithFrame:CGRectMake(linLab.right + 4, 0, TabfootView.width, TabfootView.height)];
    self.footNumLab.textColor = kColor(@"#05C1B0");
    _footNumLab.font = sysFont(font(10));
    [TabfootView addSubview:_footNumLab];
    _footView = TabfootView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    dataArray = [[NSMutableArray alloc] init];
    [self layoutIfNeeded];
    linLab = [[UILabel alloc] initWithFrame:CGRectMake(self.tableView.left, self.tableView.bottom + kWidth(10), self.tableView.width, 1)];
    linLab.backgroundColor =kColor(@"#05C1B0");
    [self.contentView addSubview:linLab];
}
- (void)setModel:(GardenCommentListModel *)model {
    if ([model.userId isEqualToString:USERMODEL.userID]) {
        self.DeleBut.hidden = NO;
        self.pinglunBut.hidden = YES;
        self.reportBut.hidden = YES;
        [self.DeleBut mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.reportBut.mas_right);
            make.top.mas_equalTo(self.reportBut.mas_top);
            make.width.offset(kWidth(24));
            make.height.offset(kWidth(18));
        }];
    }else {
        self.DeleBut.hidden = YES;
        self.pinglunBut.hidden = NO;
        self.reportBut.hidden = NO;
        [self.DeleBut mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.pinglunBut.mas_left).mas_offset(-kWidth(10));
            make.top.mas_equalTo(self.reportBut.mas_top);
            make.width.offset(kWidth(24));
            make.height.offset(kWidth(18));
        }];
    }
    self.nameLabel.text = model.userName;
    self.timeLab.text = model.createTime;
    self.descLabel.text = model.comment;
    [self layoutIfNeeded];
    [self.descLabel sizeToFit];
    
 
    [self.headImageView setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,model.userHeadPic] placeholderImage:EPDefaultImage_logo];
    [self layoutIfNeeded];
    [dataArray removeAllObjects];
    
    NSDictionary *dict = model.tails;
    NSArray *arr = dict[@"gardenReplyComment"];
    for (NSDictionary *obj in arr) {
        gardenReplyCommentModel *model = [[gardenReplyCommentModel alloc] initWithDictionary:obj error:nil];
        [dataArray addObject:model];
    }
    
    if (dataArray.count > 2) {
        _tableView.tableFooterView = _footView;
        _footNumLab.text = [NSString stringWithFormat:@"共%ld条回复",dataArray.count];
    }else {
        _tableView.tableFooterView = nil;
    }
    [_tableView reloadData];
    
    CGFloat tableHeight = _tableView.contentSize.height;
    self.tableView.frame = CGRectMake(self.nameLabel.left, self.descLabel.bottom + kWidth(10), iPhoneWidth - kWidth(20) - self.nameLabel.left, tableHeight);
    linLab.frame = CGRectMake(self.tableView.left, self.tableView.bottom + kWidth(5), self.tableView.width, 1);
    [self setupAutoHeightWithBottomView:linLab bottomMargin:kWidth(5)];
    self.lineLab = linLab;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GardenCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:GardenCommentCellId];
    if (!cell) {
        cell = [[GardenCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GardenCommentCellId];
    }
    cell.model = dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    gardenReplyCommentModel *model = dataArray[indexPath.row];
    CGFloat height = [_tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[GardenCommentCell class] contentViewWidth:iPhoneWidth];
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    gardenReplyCommentModel *model = dataArray[indexPath.row];
    if (![model.replyUserId isEqualToString:USERMODEL.userID]) {
        if (self.huifuOhterBlock) {
            self.huifuOhterBlock(indexPath.row);
        }
    }
}

//copy
-(void)tapText:(UITapGestureRecognizer *)tap{
    if (self.TapTextBlock) {
        UILabel *descLabel = (UILabel *)tap.view;
        self.TapTextBlock(descLabel);
    }
}
#pragma - mark 举报
-(void)reportButAction:(UIButton *)sender{
    if (self.jubaoBlock) {
        self.jubaoBlock();
    }
//    NSLog(@"--举报---");
}
#pragma - mark 评论
-(void)pinlunButAction{
    if (self.huifuBlock) {
        self.huifuBlock();
    }
//    NSLog(@"--评论---");
}
#pragma - mark 删除
-(void)DeleButAction:(UIButton *)sender{
    if (self.deleBlock) {
        self.deleBlock();
    }
}
@end
