//
//  MessageChatViewController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/2/25.
//  Copyright © 2019 听花科技. All rights reserved.
//

#import "MessageChatViewController.h"
#import "LayoutTextView.h"

@interface  MessageMeTabViewCell : UITableViewCell {
    UIAsyncImageView *_iconImageView;
    SMLabel *_messageLab;
    UIAsyncImageView *_bgView;
//    MessageContentModel *_model;
    
}
@property (nonatomic, strong) MessageContentModel *model;

@end

@implementation MessageMeTabViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSubViews];
    }
    return self;
}
- (void) createSubViews {
    _iconImageView = [[UIAsyncImageView alloc] initWithFrame:CGRectMake(kWidth(10), kWidth(10), kWidth(48), kWidth(48))];
    _iconImageView.layer.cornerRadius = _iconImageView.height/2.;
    [self.contentView addSubview:_iconImageView];
    
    _bgView = [[UIAsyncImageView alloc] initWithFrame:CGRectMake(_iconImageView.right + kWidth(6), _iconImageView.top, kWidth(271), _iconImageView.height)];
    [self.contentView addSubview:_bgView];
    _messageLab = [[SMLabel alloc] init];
    _messageLab.numberOfLines = 0;
    _messageLab.font = darkFont(16);
    _messageLab.size = CGSizeMake(kWidth(230), kWidth(18));
    [_bgView addSubview:_messageLab];
    _messageLab.textColor = kColor(@"#030303");
    
    [_messageLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_bgView.mas_top).mas_offset(15);
        make.left.mas_equalTo(self->_bgView.mas_left).mas_offset(15);
        make.right.mas_equalTo(self->_bgView.mas_right).mas_offset(-26);
        make.bottom.mas_equalTo(self->_bgView.mas_bottom).mas_offset(-15);
    }];
    
}
- (void)setModel:(MessageContentModel *)model {
    _model = model;
    [_iconImageView setImageAsyncWithURL:model.heedImageUrl placeholderImage:defalutHeadImage];
    _messageLab.text = model.messageContent;
    //    _messageLab.text = @"图中上面的是没做设置的，下面是做了设置的，可以看出效果很明显,需要注意的是，需要把图片添加到Assets中，创建对应的图片集合才能够生效，否则效果是不尽如人意的。图中上面的是没做设置的，下面是做了设置的，可以看出效果很明显,需要注意的是，需要把图片添加到Assets中，创建对应的图片集合才能够生效，否则效果是不尽如人意的。";
    
    UIImage *img;
    SMLabel *lab = [[SMLabel alloc] init];
    lab.numberOfLines = 0;
    lab.width = kWidth(230);
    lab.text = model.messageContent;
    lab.font = darkFont(16);
    [lab sizeToFit];
    _bgView.size = CGSizeMake(lab.width + 41, lab.height + 30);
    
    // 四个数值对应图片中距离上、左、下、右边界的不拉伸部分的范围宽度
    CGFloat Height = [IHUtility calculateRowHeight:_messageLab.text Width:_messageLab.width fontSize:16];
    CGFloat Width = [IHUtility calculateRowWidth:_messageLab.text Height:Height fontSize:16];
    _messageLab.size = CGSizeMake(Width, Height);
//    _bgView.size = CGSizeMake(Width + 41, Height + 30);
    
    img = [UIImage imageNamed:@"chat_me_receiver_bg"];
    _iconImageView.origin = CGPointMake(iPhoneWidth - kWidth(10) - _iconImageView.width, kWidth(10));
    _bgView.origin = CGPointMake(_iconImageView.left - kWidth(6) - _bgView.width ,_iconImageView.top);

    img = [img resizableImageWithCapInsets:UIEdgeInsetsMake(img.size.height/3*2, 26, 26, 26) resizingMode:UIImageResizingModeStretch];
    
    _bgView.image = img;
    [self setupAutoHeightWithBottomView:_bgView bottomMargin:kWidth(5)];
}

@end

@interface  MessageOtherTabViewCell : UITableViewCell {
    UIAsyncImageView *_iconImageView;
    SMLabel *_messageLab;
    UIAsyncImageView *_bgView;
//    MessageContentModel *_model;
    
}
@property (nonatomic, strong) MessageContentModel *model;

@end

@implementation MessageOtherTabViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSubViews];
    }
    return self;
}
- (void) createSubViews {
    _iconImageView = [[UIAsyncImageView alloc] initWithFrame:CGRectMake(kWidth(10), kWidth(10), kWidth(48), kWidth(48))];
    _iconImageView.layer.cornerRadius = _iconImageView.height/2.;
    [self.contentView addSubview:_iconImageView];
    
    _bgView = [[UIAsyncImageView alloc] initWithFrame:CGRectMake(_iconImageView.right + kWidth(6), _iconImageView.top, kWidth(271), _iconImageView.height)];
    [self.contentView addSubview:_bgView];
    _messageLab = [[SMLabel alloc] init];
    _messageLab.numberOfLines = 0;
    _messageLab.font = darkFont(16);
    _messageLab.size = CGSizeMake(kWidth(230), kWidth(18));
    [_bgView addSubview:_messageLab];
    _messageLab.textColor = kColor(@"#030303");
    
    [_messageLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_bgView.mas_top).mas_offset(15);
        make.left.mas_equalTo(self->_bgView.mas_left).mas_offset(26);
        make.right.mas_equalTo(self->_bgView.mas_right).mas_offset(-15);
        make.bottom.mas_equalTo(self->_bgView.mas_bottom).mas_offset(-15);
    }];
    
}
- (void)setModel:(MessageContentModel *)model {
    _model = model;
    [_iconImageView setImageAsyncWithURL:model.heedImageUrl placeholderImage:defalutHeadImage];
    _messageLab.text = model.messageContent;
//    _messageLab.text = @"图中上面的是没做设置的，下面是做了设置的，可以看出效果很明显,需要注意的是，需要把图片添加到Assets中，创建对应的图片集合才能够生效，否则效果是不尽如人意的。图中上面的是没做设置的，下面是做了设置的，可以看出效果很明显,需要注意的是，需要把图片添加到Assets中，创建对应的图片集合才能够生效，否则效果是不尽如人意的。";
    
    UIImage *img;
    SMLabel *lab = [[SMLabel alloc] init];
    lab.numberOfLines = 0;
    lab.width = kWidth(230);
    lab.text = model.messageContent;
    lab.font = darkFont(16);
    [lab sizeToFit];
    _bgView.size = CGSizeMake(lab.width + 41, lab.height + 30);
    
// 四个数值对应图片中距离上、左、下、右边界的不拉伸部分的范围宽度
     CGFloat Height = [IHUtility calculateRowHeight:_messageLab.text Width:_messageLab.width fontSize:16];
     CGFloat Width = [IHUtility calculateRowWidth:_messageLab.text Height:Height fontSize:16];
    _messageLab.size = CGSizeMake(Width, Height);
//    _bgView.size = CGSizeMake(Width + 41, Height + 30);
    
    img = [UIImage imageNamed:@"chat_receiver_bg"];
    _bgView.origin = CGPointMake(_iconImageView.right + kWidth(6),_iconImageView.top);
    _iconImageView.origin = CGPointMake(kWidth(10), kWidth(10));
    
    img = [img resizableImageWithCapInsets:UIEdgeInsetsMake(26, 26, 26, 26) resizingMode:UIImageResizingModeStretch];
    _bgView.image = img;
    if (_bgView.bottom < _iconImageView.bottom) {
        [self setupAutoHeightWithBottomView:_iconImageView bottomMargin:kWidth(10)];
    }else {
        [self setupAutoHeightWithBottomView:_bgView bottomMargin:kWidth(5)];
    }
    
}

@end


@interface MessageChatViewController () <UITableViewDelegate,UITableViewDataSource> {
    UITableView *_tableView;
    NSMutableArray *dataArr;
    NSString *Sendstatu;    //1发送过消息
    NSInteger page;
//    NSMutableArray *tempArr;
}

@end

static NSString *identifierStr  = @"MessageOtherTabViewCellId";
static NSString *identifierStr1 = @"MessageMeTabViewCellId";

@implementation MessageChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.PartModel != nil) {
        self.title = self.PartModel.partnerName;
    }else {
        self.title = self.model.nickname;
    }
    
    page = 0;
    self.view.backgroundColor = cBgColor;
    [self createBottomView];
    [self dataInit];
    Sendstatu = @"0";
    
}
- (void)back:(id)sender {
    if ([Sendstatu isEqualToString:@"1"]) {
        if (self.reloadData) {
            self.reloadData();
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void) dataInit {
    dataArr = [[NSMutableArray alloc] init];
//    tempArr = [[NSMutableArray alloc] init];
    WS(weakSelf);
    [self addBaseTableViewRefesh:_tableView type:ENT_RefreshHeader successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefesh:refreshView];
    }];
    [_tableView.mj_header beginRefreshing];
    
//    for (MessageContentModel *model in self.model.tails.message) {
//        [dataArr addObject:model];
//    }
//    [_tableView reloadData];
}


-(void)loadRefesh:(MJRefreshComponent *)refreshView{
    NSString *jid = @"0";
    NSString *sendId = @"";
    if (self.PartModel != nil) {
        sendId = self.PartModel.userId;
    }else {
        jid = self.model.jid;
        sendId = self.model.tails.userId;
    }
    int sendNum = [sendId intValue];
    NSDictionary *paramter = @{
                               @"receiveId": USERMODEL.userID,
                               @"pageSize" : @"15",
                               @"pageNum"  : stringFormatInt(page),
//                               @"id"       : jid,
                               @"sendId"   : @(sendNum),
                               };
    [network httpRequestWithParameter:paramter method:messageDetailUrl success:^(NSDictionary *dic) {
        NSArray *arr= dic[@"content"];
        if (arr.count <= 0) {
            [self->_tableView.mj_header endRefreshing];
            return ;
        }
        
        for (int i = 0; i < arr.count; i ++) {
            NSDictionary *tempDic = arr[i];
            MessageContentModel *model = [[MessageContentModel alloc] initWithDictionary:tempDic error:nil];
            [self->dataArr insertObject:model atIndex:0];
        }
        [self->_tableView reloadData];
        if (self->page == 0) {
            [self performSelector:@selector(delayMethod) withObject:nil/*可传任意类型参数*/ afterDelay:0.5];
        }
        self->page++;
        [self->_tableView.mj_header endRefreshing];
        [self endRefresh];
    } failure:^(NSDictionary *dic) {
        [self->_tableView.mj_header endRefreshing];
        [self endRefresh];
    }];
    
}
- (void) delayMethod {
    if (_tableView.contentSize.height > _tableView.height) {
        _tableView.contentOffset = CGPointMake(0, _tableView.contentSize.height - _tableView.height + kWidth(20));
    }
    
}

- (void) createBottomView {
    CGFloat layoutTextHeight = 40 + KTabSpace;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight - KtopHeitht - layoutTextHeight) style:UITableViewStylePlain];
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    LayoutTextView *layoutTextView = [[LayoutTextView alloc] initWithFrame:CGRectMake(0, iPhoneHeight - layoutTextHeight  - KtopHeitht, iPhoneWidth, layoutTextHeight)];
    layoutTextView.placeholder = @"你好";
    [self.view addSubview:layoutTextView];
    WS(weakSelf);
    [layoutTextView setSendBlock:^(UITextView *textView) {
        NSLog(@"发送 -- %@",textView.text);
        [weakSelf sendText:textView.text];
//        _infoLable.text = textView.text;
    }];
}

- (void) sendText:(NSString *)text{
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return;
    }
    [self addWaitingView];
    NSString *receiveId = @"";
    if (self.PartModel != nil) {
        receiveId = self.PartModel.userId;
    }else {
        receiveId = self.model.tails.userId;
        
    }
    NSDictionary *paramter = @{
                               @"messageContent" : text,
                               @"parentId"       : @"1",
                               @"receiveId"      : receiveId,
                               @"sendId"         : USERMODEL.userID,
                               };
    [network httpRequestWithParameter:paramter method:sendMessageUrl success:^(NSDictionary *dic) {
        [self removeWaitingView];
        MessageContentModel *ListModel = [[MessageContentModel alloc] init];
        ListModel.messageContent = text;
        ListModel.isMe = @"1";
        NSDictionary * dict=[IHUtility getUserDefalutsDicKey:kUserDefalutLoginInfo];
        NSString *headImg = [NSString stringWithFormat:@"%@%@%@",ConfigManager.ImageUrl,dict[@"heed_image_url"],smallHeaderImage];
        ListModel.heedImageUrl = headImg;
        [self->dataArr addObject:ListModel];
        [self->_tableView reloadData];
        self->Sendstatu = @"1";
         [self performSelector:@selector(delayMethod) withObject:nil/*可传任意类型参数*/ afterDelay:0.5];
    } failure:^(NSDictionary *dic) {
        [self removeWaitingView];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageContentModel *ListModel = dataArr[indexPath.row];
    CGFloat height = [_tableView cellHeightForIndexPath:indexPath model:ListModel keyPath:@"model" cellClass:[MessageOtherTabViewCell class] contentViewWidth:iPhoneWidth];
    return height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSString *identifierStr = [NSString stringWithFormat:@"cellId%ld",indexPath.row];
//    MessageOtherTabViewCell *cell = [[MessageOtherTabViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierStr];
    MessageContentModel *model = dataArr[indexPath.row];
    if ([model.isMe isEqualToString:@"0"]) {
        MessageOtherTabViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierStr];
        if (!cell) {
            cell = [[MessageOtherTabViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierStr];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = model;
        return cell;
    }else {
        MessageMeTabViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierStr1];
        if (!cell) {
            cell = [[MessageMeTabViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierStr1];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = model;
        return cell;
    }
}


@end
