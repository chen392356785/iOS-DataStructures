//
//  MyMessageListViewController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/2/22.
//  Copyright © 2019 听花科技. All rights reserved.
//

#import "MyMessageListViewController.h"
#import "MyMessageModel.h"
#import "MessageChatViewController.h"   //聊天

@interface  MessageListTabViewCell : UITableViewCell {
    UIAsyncImageView *_iconImageView;
    SMLabel *_nameLab;
    SMLabel *_timeLab;
    SMLabel *_messageLab;
    UIView  *_unreadView;
    UILabel *_lineLab;
    
}
@property (nonatomic, strong) MyMessageModel *model;

@property(nonatomic,copy) DidSelectBlock pinlunBlock;
@end

@implementation MessageListTabViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSubViews];
    }
    return self;
}
- (void) createSubViews {
    _iconImageView = [[UIAsyncImageView alloc] init];
    _iconImageView.frame = CGRectMake(kWidth(13), kWidth(10), kWidth(50), kWidth(50));
    _iconImageView.layer.cornerRadius = _iconImageView.height/2;
    [self.contentView addSubview:_iconImageView];
    
    _nameLab = [[SMLabel alloc] init];
    _nameLab.font = darkFont(font(16));
    _nameLab.textColor = kColor(@"#040404");
    _nameLab.frame = CGRectMake(_iconImageView.right + kWidth(15), _iconImageView.top + kWidth(4), iPhoneWidth - _iconImageView.right - kWidth(20) - kWidth(50), kWidth(16));
    [self.contentView addSubview:_nameLab];
    
    
    _timeLab = [[SMLabel alloc] init];
    _timeLab.font = sysFont(font(13));
    _timeLab.textColor = kColor(@"#7B7B7B");
    _timeLab.frame = CGRectMake(iPhoneWidth - kWidth(12) - kWidth(50), _nameLab.top,  kWidth(50), _nameLab.height);
    _timeLab.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_timeLab];
    _timeLab.adjustsFontSizeToFitWidth = YES;
    
    
    _messageLab = [[SMLabel alloc] init];
    _messageLab.frame = CGRectMake(_nameLab.left, _nameLab.bottom + kWidth(12), iPhoneWidth - _nameLab.left - kWidth(20), kWidth(16));
    _messageLab.font = sysFont(font(14));
    _messageLab.textColor = kColor(@"#7B7B7B");
    [self.contentView addSubview:_messageLab];
    
    _unreadView = [[UIView alloc] initWithFrame:CGRectMake(_timeLab.right - kWidth(8), 0, kWidth(8), kWidth(8))];
    _unreadView.backgroundColor = kColor(@"#E50500");
    _unreadView.layer.cornerRadius = _unreadView.height/2;
    _unreadView.centerY = _messageLab.centerY;
    [self.contentView addSubview:_unreadView];
    _unreadView.hidden = YES;
    
    _lineLab = [[UILabel alloc] initWithFrame:CGRectMake(_nameLab.left, _iconImageView.bottom + kWidth(10), iPhoneWidth - _nameLab.left, 1)];
    _lineLab.backgroundColor = kColor(@"#E7E7E7");
    [self.contentView addSubview:_lineLab];
}
- (void)setModel:(MyMessageModel *)model {
    _nameLab.text = model.nickname;
    NSString *timeStr = [IHUtility compareCurrentTime:model.sendTime];
    _timeLab.text = timeStr;
    _messageLab.text = model.messageContent;
    if ([model.look isEqualToString:@"0"]) {
        _unreadView.hidden = NO;
    }else {
        _unreadView.hidden = YES;
    }
    NSString *imageUrl;
    if (![model.heedImageUrl hasPrefix:@"http"]) {
        imageUrl = [NSString stringWithFormat:@"%@/%@",ConfigManager.ImageUrl,model.heedImageUrl];
    }else {
        imageUrl = model.heedImageUrl;
    }
    [_iconImageView setImageAsyncWithURL:imageUrl placeholderImage:defalutHeadImage];
    [self setupAutoHeightWithBottomView:_lineLab bottomMargin:kWidth(1)];
}

@end



@interface MyMessageListViewController () <UITableViewDelegate,UITableViewDataSource> {
    NSMutableArray *dataArr;
    NSString *topImgUrl;
    UITableView *_tableView;
    NSInteger page;
    EmptyPromptView *_EPView;//没有搜索内容时候默认的提示
}

@end

static NSString *MessageListTabViewCellId = @"MessageListTabViewCell";

@implementation MyMessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息列表";
    dataArr = [[NSMutableArray alloc] init];
    [self createTableView];
}



- (void) createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight - KtopHeitht) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = kColor(@"#EDEEF3");
    _tableView.separatorColor = [UIColor clearColor];
    WS(weakSelf);
    [self addBaseTableViewRefesh:_tableView type:ENT_RefreshAll successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefesh:refreshView];
    }];
   [_tableView.mj_header beginRefreshing];

    _EPView = [[EmptyPromptView alloc] initWithFrame:_tableView.frame context:@"暂无消息哦~"];
    _EPView.imagNameStr = @"nores";
    _EPView.hidden = NO;
    _EPView.centerY = self.view.centerY;
    [_tableView addSubview:_EPView];
    
}
-(void)loadRefesh:(MJRefreshComponent *)refreshView{
    if (refreshView == _tableView.mj_header) {
        page=0;
    }
    
    NSDictionary *paramter = @{
                               @"receiveId": USERMODEL.userID,
                               @"pageSize" : @"15",
                               @"pageNum"  : stringFormatInt(page),
                               };
    [network httpRequestWithParameter:paramter method:messageListUrl success:^(NSDictionary *dic) {
        self->_EPView.hidden = YES;
        NSArray *arr= dic[@"content"];
        if (refreshView == self->_tableView.mj_header) {
            [self->_tableView.mj_header endRefreshing];
            [self->dataArr removeAllObjects];
            self->page = 0;
            if (arr.count == 0) {
                [self->_tableView reloadData];
            }
        }
        if (arr.count > 0) {
            self->page++;
            if (arr.count < 3) {
                [self->_tableView.mj_footer endRefreshingWithNoMoreData];
            }else {
                [self->_tableView.mj_footer endRefreshing];
            }
        }else {
            //如果返回的数据为0 判断原先数组的数量来决定默认提示的显示与影藏
            if (self->dataArr.count == 0 ) {
                self->_EPView.hidden = NO;
            }else{
                self->_EPView.hidden = YES;
            }
            [self->_tableView.mj_footer endRefreshing];
            [self endRefresh];
            return ;
        }
        for (NSDictionary *tempDic in arr) {
            MyMessageModel *model = [[MyMessageModel alloc] initWithDictionary:tempDic error:nil];
            if (refreshView == self->_tableView.mj_footer && self->page <= 1) {
            }else {
                [self->dataArr addObject:model];
            }
        }
        [self->_tableView reloadData];
        if (self->dataArr.count == 0 ) {
            self->_EPView.hidden = NO;
        }else{
            self->_EPView.hidden = YES;
        }
        //        [_tableView.mj_footer endRefreshingWithNoMoreData];
        [self endRefresh];
    } failure:^(NSDictionary *dic) {
        [self->_tableView.mj_footer endRefreshingWithNoMoreData];
        [self endRefresh];
    }];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageListTabViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MessageListTabViewCellId];
    if (!cell) {
        cell = [[MessageListTabViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MessageListTabViewCellId];
    }
    cell.selectionStyle = UITableViewCellStyleDefault;
    MyMessageModel *model = dataArr[indexPath.row];
    cell.model = model;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyMessageModel *model = dataArr[indexPath.row];
    CGFloat height = [_tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[MessageListTabViewCell class] contentViewWidth:iPhoneWidth];
    return height;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MyMessageModel *model = dataArr[indexPath.row];
    MessageChatViewController *chatVc = [[MessageChatViewController alloc] init];
    chatVc.model = model;
    [self pushViewController:chatVc];
//    if ([model.look isEqualToString:@"0"]) {
//        [self changeStateMessageModel:model andIndex:indexPath];
//    }
    chatVc.reloadData = ^{
        [self->_tableView.mj_header beginRefreshing];
    };
}
//改为已读状态
- (void) changeStateMessageModel:(MyMessageModel *)model andIndex:(NSIndexPath *)index{
    NSDictionary *paramter = @{
                               @"receiveId": USERMODEL.userID,
                               @"id"       : model.jid
                               };
    [network httpRequestWithParameter:paramter method:messageStateUrl success:^(NSDictionary *dic) {
        model.look = @"1";
		[self->_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index,nil] withRowAnimation:UITableViewRowAnimationNone];

    } failure:^(NSDictionary *dic) {
        [self removeWaitingView];
    }];
}
//侧滑允许编辑cell
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete ;
}
//解决iOS8.0不能左滑添加多个标签
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deletTableviewIndex:indexPath];
    }
}
// 修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
- (void) deletTableviewIndex:(NSIndexPath *) indexPath{
    MyMessageModel *model = dataArr[indexPath.row];
    [dataArr removeObjectAtIndex:indexPath.row];
    [_tableView reloadData];
    NSString *idsStr = [NSString stringWithFormat:@"%@",model.jid];
    NSDictionary *paramter = @{
                               @"ids"    : idsStr,
                               @"userId" : USERMODEL.userID,
                               };
    [network httpRequestWithParameter:paramter method:delMessageUrl success:^(NSDictionary *dic) {
       
    } failure:^(NSDictionary *dic) {
        
    }];

}

@end
