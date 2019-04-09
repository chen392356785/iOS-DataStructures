//
//  SDTimeLineCellCommentView.m
//  GSD_WeiXin(wechat)
//
//  Created by gsd on 16/2/25.
//  Copyright © 2016年 GSD. All rights reserved.
//

/*
 
 *********************************************************************************
 *
 * GSD_WeiXin
 *
 * QQ交流群: 459274049
 * Email : gsdios@126.com
 * GitHub: https://github.com/gsdios/GSD_WeiXin
 * 新浪微博:GSD_iOS
 *
 * 此“高仿微信”用到了很高效方便的自动布局库SDAutoLayout（一行代码搞定自动布局）
 * SDAutoLayout地址：https://github.com/gsdios/SDAutoLayout
 * SDAutoLayout视频教程：http://www.letv.com/ptv/vplay/24038772.html
 * SDAutoLayout用法示例：https://github.com/gsdios/SDAutoLayout/blob/master/README.md
 *
 *********************************************************************************
 
 */
#import "SDTimeLineCell.h"
#import "SDTimeLineCellCommentView.h"
//#import "UIView+SDAutoLayout.h"
//#import "SDTimeLineCellModel.h"
//#import "MLLinkLabel.h"
@class SDCommentListCell;

@interface SDTimeLineCellCommentView () <MLLinkLabelDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}
@property (nonatomic, strong) NSArray *likeItemsArray;
@property (nonatomic, strong) NSMutableArray *commentItemsArray;

@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) MLLinkLabel *likeLabel;
@property (nonatomic, strong) UIView *likeLableBottomLine;

@property (nonatomic, strong) NSMutableArray *commentLabelsArray;



@end

@implementation SDTimeLineCellCommentView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setupViews];
    
        

    }
    return self;
}

- (void)setupViews
{
    _bgImageView = [UIImageView new];
    UIImage *bgImage = [[[UIImage imageNamed:@""] stretchableImageWithLeftCapWidth:40 topCapHeight:30] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _bgImageView.image = bgImage;
    _bgImageView.tintColor=SDColor(246, 247, 249, 1.0f);
    _bgImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:_bgImageView];
    
    _likeLabel = [MLLinkLabel new];
    _likeLabel.font = [UIFont systemFontOfSize:14];
//    _likeLabel.linkTextAttributes = @{NSForegroundColorAttributeName : RGB(6,193, 173)};
    _likeLabel.linkTextAttributes = @{NSForegroundColorAttributeName : kColor(@"#3cb5b1")};
    _likeLabel.isAttributedContent = YES;
      __weak typeof(self) weakSelf = self;
    
    _likeLabel.didClickLinkBlock=^(MLLink *link,NSString *linkText,MLLinkLabel *label){
        if (weakSelf.didClickUserNameBlock) {
            weakSelf.didClickUserNameBlock(link);
        }
        
    };
    [self addSubview:_likeLabel];
    
    _likeLableBottomLine = [UIView new];
    [self addSubview:_likeLableBottomLine];
    
    self.commentItemsArray=[[NSMutableArray alloc]init];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.width, 50) style:UITableViewStylePlain];
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.delegate=self;
     [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _tableView.scrollEnabled=NO;
    _tableView.dataSource=self;
    [_tableView registerClass:[SDCommentListCell class] forCellReuseIdentifier:@"SDCommentListCell"];
    
    [self addSubview:_tableView];
    
    
    
    
    
    _bgImageView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.commentItemsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SDTimeLineCellCommentItemModel *model=[self.commentItemsArray objectAtIndex:indexPath.row];
    SDCommentListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SDCommentListCell"];
     __weak typeof(self) weakSelf = self;
    cell.huifImageV.hidden = YES;
    if (indexPath.row == 0) {
        cell.huifImageV.hidden = NO;
    }
    cell.didClickUserNameBlock=^(MLLink *link){
        if (weakSelf.didClickUserNameBlock) {
            weakSelf.didClickUserNameBlock(link);
        }
    };
    cell.model=model;

    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
//       cell.contentView.userInteractionEnabled=YES;
//    [cell addGestureRecognizer: [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longTap:)]];
    
  
    return cell;
}

-(BOOL)canBecomeFirstResponder{
    return YES;
}

//重载UItableViewDelegate中得方法，长按Cell的时候，系统会调用该方法，确定是否显示出UIMenuController
- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//当上面方法返回YES时，系统调用该方法确定UIMenuController显示哪些选项
- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath  withSender:(id)sender {
     if(action == @selector(copy:)){
        
        
        return YES;
        
    }
    
   
    else if(action == @selector(select:)){
        
        return NO;
        
    }
    
    else if(action == @selector(selectAll:)){
        
        
        return NO;    
        
    }    else  {     
        
        return [super canPerformAction:action withSender:sender];    
        
    }
}

//系统调用该方法确定点击按钮后的相关响应操作
- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    if (action == @selector(copy:)) {
        SDTimeLineCellCommentItemModel *model = self.commentItemsArray[indexPath.row];
        if(model.comment_cotent.length>0)
        [UIPasteboard generalPasteboard].string = model.comment_cotent;
    } 
}

//由于willDisplayCell是异步调用的，所以在上面的block里面不能即时更新UI，最好使用GCD通过主线程加上你的代码：

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.didClickCommentLabelBlock) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
        UITableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
        CGRect rect = [cell.superview convertRect:cell.frame toView:window];
        
        SDTimeLineCellCommentItemModel *model = self.commentItemsArray[indexPath.row];
        self.didClickCommentLabelBlock(model, rect,indexPath);
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
    
     SDTimeLineCellCommentItemModel *model = self.commentItemsArray[indexPath.row];
    
    NSMutableAttributedString *str= [self generateAttributedStringWithCommentItemModel:model];
    
    CGSize size=[IHUtility GetSizeByText:[str string] sizeOfFont:14 width:WindowWith-50];
    return size.height;
}


- (void)setLikeItemsArray:(NSArray *)likeItemsArray
{
    _likeItemsArray = likeItemsArray;
    
    if (likeItemsArray.count==0) {
         _likeLabel.attributedText = nil;
        return;
    }
    
    NSTextAttachment *attach = [NSTextAttachment new];
    UIImage *img=[UIImage imageNamed:@"zan"];
//    UIImage *img=[UIImage imageNamed:@"gq_like"];
    attach.image =img;
    attach.bounds = CGRectMake(0, -2, img.size.width, img.size.height);
    NSAttributedString *likeIcon = [NSAttributedString attributedStringWithAttachment:attach];

    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:likeIcon];
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"  "]];
    for (int i = 0; i < likeItemsArray.count; i++) {
        SDTimeLineCellLikeItemModel *model = likeItemsArray[i];
        if (i > 0) {
            NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:@"、"];
            [attString addAttribute:NSForegroundColorAttributeName value:kColor(@"#3cb5b1") range:NSMakeRange(0, 1)];
            [attributedText appendAttributedString:attString];
        }
        if (!model.attributedContent) {
            model.attributedContent = [self generateAttributedStringWithLikeItemModel:model];
        }
        [attributedText appendAttributedString:model.attributedContent];
    }
    
    _likeLabel.attributedText = [attributedText copy];
}

- (NSMutableArray *)commentLabelsArray
{
    if (!_commentLabelsArray) {
        _commentLabelsArray = [NSMutableArray new];
    }
    return _commentLabelsArray;
}

- (void)setupWithLikeItemsArray:(NSArray *)likeItemsArray commentItemsArray:(NSArray *)commentItemsArray
{
    self.likeItemsArray = likeItemsArray;
    [self.commentItemsArray removeAllObjects];
    [self.commentItemsArray addObjectsFromArray: commentItemsArray];
 
    
    if (!commentItemsArray.count && !likeItemsArray.count) {
        self.fixedWidth = @(0); // 如果没有评论或者点赞，设置commentview的固定宽度为0（设置了fixedWith的控件将不再在自动布局过程中调整宽度）
        self.fixedHeight = @(0); // 如果没有评论或者点赞，设置commentview的固定高度为0（设置了fixedHeight的控件将不再在自动布局过程中调整高度）
        return;
    } else {
        self.fixedHeight = nil; // 取消固定宽度约束
        self.fixedWidth = nil; // 取消固定高度约束
    }
    
    CGFloat margin = 5;
    
    UIView *lastTopView = nil;
    
    if (likeItemsArray.count) {
        _likeLabel.sd_resetLayout
        .leftSpaceToView(self, margin)
        .rightSpaceToView(self, margin)
        .topSpaceToView(lastTopView, 10)
        .autoHeightRatio(0);
         lastTopView = _likeLabel;
        
    } else {
        _likeLabel.attributedText = nil;
        _likeLabel.sd_resetLayout
        .widthIs(WindowWith)
        .heightIs(0);
       
    }
    
    
    if (self.commentItemsArray.count && self.likeItemsArray.count) {
        _likeLableBottomLine.sd_resetLayout
        .leftSpaceToView(self, 0)
        .rightSpaceToView(self, 0)
        .heightIs(1)
        .topSpaceToView(lastTopView, 3);
        
        lastTopView = _likeLableBottomLine;
    } else {
        _likeLableBottomLine.sd_resetLayout.heightIs(0);
    }
    [_tableView reloadData];
    
    
    CGFloat tabHeigh=0;
    for (int i=0; i<self.commentItemsArray.count; i++) {
        SDTimeLineCellCommentItemModel *mod=[self.commentItemsArray objectAtIndex:i];
        NSMutableAttributedString *str= [self generateAttributedStringWithCommentItemModel:mod];
        
        CGSize size=[IHUtility GetSizeByText:[str string] sizeOfFont:14 width:WindowWith-50];
        
        
        tabHeigh=size.height +tabHeigh;
    }
    
     CGFloat topMargin = (likeItemsArray.count == 0 &&tabHeigh >0) ? 10 : 0;
    
   
    _tableView.sd_layout
    .leftSpaceToView(self, 5)
    .rightSpaceToView(self, 5)
    .topSpaceToView(lastTopView, topMargin)
    .heightIs(tabHeigh)
    ;
   
    [self setupAutoHeightWithBottomView:_tableView bottomMargin:6];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}



- (NSMutableAttributedString *)generateAttributedStringWithCommentItemModel:(SDTimeLineCellCommentItemModel *)model
{
    NSString *text = model.nickname;
    if ([model.comment_type intValue]==1) {
        text = [text stringByAppendingString:[NSString stringWithFormat:@"回复%@", model.reply_nickname]];
    }
    text = [text stringByAppendingString:[NSString stringWithFormat:@"：%@", model.comment_cotent]];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:text];
    [attString setAttributes:@{NSLinkAttributeName : model.user_id} range:[text rangeOfString:model.nickname]];
    if ([model.comment_type intValue]==1) {
        [attString setAttributes:@{NSLinkAttributeName : model.reply_user_id} range:[text rangeOfString:model.reply_nickname]];
    }
    return attString;
}

- (NSMutableAttributedString *)generateAttributedStringWithLikeItemModel:(SDTimeLineCellLikeItemModel *)model
{
    NSString *text = model.nickname;
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:text];
    UIColor *highLightColor = [UIColor blueColor];
    [attString setAttributes:@{NSForegroundColorAttributeName : highLightColor, NSLinkAttributeName : model.user_id} range:[text rangeOfString:model.nickname]];
    
    return attString;
}


#pragma mark - MLLinkLabelDelegate

- (void)didClickLink:(MLLink *)link linkText:(NSString *)linkText linkLabel:(MLLinkLabel *)linkLabel
{
    NSLog(@"%@", link.linkValue);
}

@end
