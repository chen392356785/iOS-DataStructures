//
//  SDTimeLineCell.m
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
 

const CGFloat contentLabelFontSize = 15;
CGFloat maxContentLabelHeight = 0; // 根据具体font而定

NSString *const kSDTimeLineCellOperationButtonClickedNotification = @"SDTimeLineCellOperationButtonClickedNotification";

@implementation SDTimeLineCell

{
    UIView *_bgView;
    UIAsyncImageView *_iconView;
    UIAsyncImageView *_VipiconView;
    SMLabel *_nameLable;
    SMLabel *_jobLable;
    SMLabel *_companylbl;
//    SMLabel *_contentLabel;
    
    SMLabel *_titlelbl;
    SMLabel *_pricelbl;
    SMLabel *_bzlbl;  //标注
    
    UIImageView *_typeImage;
    SDWeiXinPhotoContainerView *_picContainerView;
    UILabel *_timeLabel;
//    UIButton *_moreButton;
    UIButton *_operationButton;
    SDTimeLineCellCommentView *_commentView;
    UIView *_downView;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		[self setup];
	}
	return self;
}


- (void)setup
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveOperationButtonClickedNotification:) name:kSDTimeLineCellOperationButtonClickedNotification object:nil];
    
    self.contentView.backgroundColor=cBgColor;
    
    _bgView=[UIView new];
    _bgView.backgroundColor=[UIColor whiteColor];
    
    _iconView = [UIAsyncImageView new];
    _iconView.image=defalutHeadImage;
    _iconView.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headTap)];

    [_iconView addGestureRecognizer:tap];
    
    _VipiconView = [[UIAsyncImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth(16), kWidth(16))];
    _VipiconView.image = kImage(@"gongqiu_vip");
    
    
    _nameLable = [SMLabel new];
    _nameLable.font = sysFont(13);
    _nameLable.textColor = RGB(104, 124, 99);
    
    _jobLable = [SMLabel new];
    _jobLable.font = sysFont(13);
    _jobLable.textColor = RGB(104, 124, 99);
    
    _companylbl=[SMLabel new];
    _companylbl.font=sysFont(13);
//    _companylbl.text = @"公司阿斯蒂芬阿斯蒂芬0";
    _companylbl.textColor=RGB(81, 80, 84);
    
    _titlelbl=[SMLabel new];
    _titlelbl.font = sysFont(15);
//    _titlelbl.text=@"【供应】中国红樱花";
    _titlelbl.textColor=RGB(51.0f,51.0f,51.0f);
    
    _pricelbl=[SMLabel new];
    _pricelbl.font = sysFont(18);
//    _pricelbl.text=@"￥320";
    _pricelbl.textAlignment=NSTextAlignmentRight;
//    _pricelbl.textColor=RGB(6, 193, 174);
    _pricelbl.textColor = UIColor.redColor;
    
    _bzlbl=[SMLabel new];
	_bzlbl.numberOfLines = 1;
    _bzlbl.font = sysFont(13);
    _bzlbl.textColor = RGB(56.0f,56.0f,56.0f);
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = UIColor.whiteColor;
    
    UIImage *img=Image(@"GongQiu_gongying.png");
    _typeImage=[UIImageView new];
    _typeImage.image=img;
	_typeImage.hidden = YES;
//    _contentLabel = [SMLabel new];
//    _contentLabel.font = [UIFont systemFontOfSize:contentLabelFontSize];
//    _contentLabel.numberOfLines = 0;
//    if (maxContentLabelHeight == 0) {
//        maxContentLabelHeight = _contentLabel.font.lineHeight * 3;
//    }
    
//    _moreButton = [UIButton new];
//    [_moreButton setTitle:@"全文" forState:UIControlStateNormal];
//    [_moreButton setTitleColor:TimeLineCellHighlightedColor forState:UIControlStateNormal];
//    [_moreButton addTarget:self action:@selector(moreButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//    _moreButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    _operationButton = [UIButton new];
    [_operationButton setImage:[UIImage imageNamed:@"da_pinglun"] forState:UIControlStateNormal];
    [_operationButton addTarget:self action:@selector(operationButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    _picContainerView = [SDWeiXinPhotoContainerView new];
  
    __weak typeof(self) weakSelf = self;
    
    _commentView = [SDTimeLineCellCommentView new];
    [_commentView setDidClickCommentLabelBlock:^(SDTimeLineCellCommentItemModel *mod, CGRect rectInWindow,NSIndexPath *indexPath) {
        if (weakSelf.didClickCommentLabelBlock) {
            weakSelf.didClickCommentLabelBlock(mod, rectInWindow, weakSelf.indexPath,indexPath);
        }
    }];
    _commentView.didClickUserNameBlock=^(MLLink *link){
        if ([weakSelf.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
            
            
            if (link.linkType==MLLinkTypePhoneNumber) {
                if ([weakSelf.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
                    [weakSelf.delegate BCtableViewCell:weakSelf action:MTMLLinkPhoneCellAction indexPath:weakSelf.indexPath attribute:link.linkValue];
                }
            }else if (link.linkType==MLLinkTypeURL){
                
                
                if ([weakSelf.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
                    [weakSelf.delegate BCtableViewCell:weakSelf action:MTActionClickUserURlTableViewCellAction indexPath:weakSelf.indexPath attribute:link.linkValue];
                }
                
            }else if (link.linkType==MLLinkTypeOther){
                if ([weakSelf.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
                     [weakSelf.delegate BCtableViewCell:weakSelf action:MTActionClickUserNameTableViewCellAction indexPath:weakSelf.indexPath attribute:link.linkValue];
                }
                
               
            }
            
            
            
        }
    };
	
    //发布时间
    _timeLabel = [UILabel new];
    _timeLabel.font = sysFont(13);
    _timeLabel.textColor = RGB(115.0f,115.0f,115.0f);

    self.operationMenu = [SDTimeLineCellOperationMenu new];
    
    [ self.operationMenu setLikeButtonClickedOperation:^{
        if ([weakSelf.Delegate1 respondsToSelector:@selector(didClickLikeButtonInCell:)]) {
            [weakSelf.Delegate1 didClickLikeButtonInCell:weakSelf];
        }
    }];
    [ self.operationMenu setCommentButtonClickedOperation:^{
        if ([weakSelf.Delegate1 respondsToSelector:@selector(didClickcCommentButtonInCell:)]) {
            [weakSelf.Delegate1 didClickcCommentButtonInCell:weakSelf];
        }
    }];
    
    _downView=[UIView new];
    _downView.backgroundColor=cBgColor;
    
    
    
    [self.contentView addSubview:_bgView];
    
    NSArray *views = @[_iconView, _nameLable,_jobLable,_companylbl, _picContainerView, _titlelbl,_pricelbl,_bzlbl,lineView,_typeImage , _timeLabel, _operationButton, _operationMenu, _commentView,_downView];
    
    [_bgView sd_addSubviews:views];
    
    UIView *contentView = self.contentView;
    CGFloat margin = 10;
    
    _iconView.sd_cornerRadiusFromWidthRatio = @(0.5);
    _iconView.sd_layout
    .leftSpaceToView(_bgView, 12)
    .topSpaceToView(_bgView, 12)
    .widthIs(40)
    .heightIs(40);
    
    
    
    _nameLable.sd_layout
    .leftSpaceToView(_iconView, 7.5)
    .topSpaceToView(_bgView,14)
    .heightIs(16);
//    .rightSpaceToView(_bgView,78);
    [_nameLable setSingleLineAutoResizeWithMaxWidth:200];
    
    _jobLable.sd_layout
    .leftSpaceToView(_nameLable, 7.5)
    .topSpaceToView(_bgView,14)
    .heightIs(16)
    .rightSpaceToView(_bgView,8);
    
    _companylbl.sd_layout
    .leftEqualToView(_nameLable)
    .topSpaceToView(_nameLable,5.5)
    .heightIs(13)
    .rightSpaceToView(_bgView,78);
    
//    _contentLabel.sd_layout
//    .leftEqualToView(_nameLable)
//    .topSpaceToView(_nameLable, margin)
//    .rightSpaceToView(_bgView, margin)
//    .autoHeightRatio(0);
    
    // morebutton的高度在setmodel里面设置
//    _moreButton.sd_layout
//    .leftEqualToView(_contentLabel)
//    .topSpaceToView(_contentLabel, 0)
//    .widthIs(30);
    
    
    _picContainerView.sd_layout
    .leftEqualToView(_iconView); // 已经在内部实现宽度和高度自适应所以不需要再设置宽度高度，top值是具体有无图片在setModel方法中设置
    
    _titlelbl.sd_layout
    .topSpaceToView(_picContainerView, margin)
    .leftSpaceToView(_bgView, 2)
    .heightIs(17);
    [_titlelbl setSingleLineAutoResizeWithMaxWidth:200];
    
    _pricelbl.sd_layout
    .topSpaceToView(_titlelbl , 7.5)
    .leftSpaceToView(_bgView, margin)
    .rightSpaceToView(_bgView,margin)
    .heightIs(18);
    _pricelbl.textAlignment = NSTextAlignmentLeft;
    
    _bzlbl.sd_layout
    .leftEqualToView(_iconView)
    .topSpaceToView(_pricelbl,7.5)
    .rightSpaceToView(_bgView,margin)
    .autoHeightRatio(0);
    
    
    
    lineView.sd_layout
    .leftEqualToView(_bgView)
    .rightEqualToView(_bgView)
    .topSpaceToView(_bzlbl,7.5)
    .heightIs(35);
    
    _typeImage.sd_layout
    .xIs(WindowWith-img.size.width-8)
    .topSpaceToView(_nameLable,-8)
    .widthIs(img.size.width)
    .heightIs(img.size.height);
    
    _timeLabel.sd_layout
    .leftEqualToView(_iconView)
    .topSpaceToView(_bzlbl, 18)
    .heightIs(15);
    [_timeLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    _operationButton.sd_layout
    .rightSpaceToView(_bgView, 5)
    .centerYEqualToView(_timeLabel)
    .heightIs(35)
    .widthIs(35);
    
    _commentView.sd_layout
    .leftEqualToView(_iconView)
    .rightSpaceToView(_bgView, margin)
    .topSpaceToView(_timeLabel, margin); // 已经在内部实现高度自适应所以不需要再设置高度
    
    _operationMenu.sd_layout
    .rightSpaceToView(_operationButton, 0)
    .heightIs(36)
    .centerYEqualToView(_operationButton)
    .widthIs(0);
    
    _downView.sd_layout
  
    .leftSpaceToView(_bgView,0)
    .rightSpaceToView(_bgView,0)
    .heightIs(10);
    
    
    _bgView.sd_layout
    .leftSpaceToView(contentView,6)
    .rightSpaceToView(contentView,6)
    .topEqualToView(contentView)
    ;
    
    
    _VipiconView.origin = CGPointMake(_iconView.right, _iconView.bottom);
    [_bgView addSubview:_VipiconView];
     _VipiconView.hidden = YES;
}

-(void)headTap{
    
    if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
        
        [self.delegate BCtableViewCell:self action:MTHeadViewActionTableViewCell indexPath:self.indexPath attribute:nil];
        
        
    }

    
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setModel:(MTNewSupplyAndBuyListModel *)model
{
    _model = model;
    
    [_commentView setupWithLikeItemsArray:model.clickUserInfos commentItemsArray:model.commentInfos];
    NSString *position=model.userInfo.position;
    if ([position isEqualToString:@"(null)"]) {
        position =@"";
    }
    
    _companylbl.text=[NSString stringWithFormat:@"%@|%@ %@",model.userInfo.company_province,model.userInfo.company_name,position];
    if (model.userInfo.company_province.length <= 0) {
        _companylbl.text = [_companylbl.text stringByReplacingOccurrencesOfString:@"|" withString:@""];
    }
  
    _nameLable.text = model.userInfo.nickname;
    
    if ([_model.isVip isEqualToString:@"1"]) {
        _nameLable.textColor = kColor(@"#F25900");
        _VipiconView.hidden = NO;
    }else {
         _VipiconView.hidden = YES;
         _nameLable.textColor = RGB(104, 124, 99);
    }
    
    
    if (model.userInfo.title.length > 0) {
        _jobLable.text = [NSString stringWithFormat:@"#%@",model.userInfo.title];
    } else {
        _jobLable.text = @"";
    }

 
    _picContainerView.picPathStringsArray = model.imgArray;
    [_iconView setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@",model.userInfo.heed_image_url,smallHeaderImage] placeholderImage:defalutHeadImage];
    
    if ([model.type intValue] == 1) { //供应
        _titlelbl.text = [NSString stringWithFormat:@"  %@",model.varieties];
//        UIImage *img = Image(@"GongQiu_gongying.png");
//        _typeImage.image = img;
        _pricelbl.text = [NSString stringWithFormat:@"￥%@/株",model.unit_price];
        _pricelbl.hidden = NO;
        _pricelbl.sd_layout
        .heightIs(18);
        
    }else if([model.type intValue] == 2){
		_titlelbl.text = [NSString stringWithFormat:@"  %@",model.varieties];
//		UIImage *img = Image(@"GongQiu_qiugou.png");
//		_typeImage.image = img;
		_pricelbl.hidden = YES;
		_pricelbl.sd_layout
		.heightIs(0);
    }
    
    NSString *timeStr = [IHUtility compareCurrentTimeString:model.uploadtime];
    _timeLabel.text = [NSString stringWithFormat:@" %@",timeStr];
    NSMutableArray *bqArray=[self getLabelViewList:[model.rod_diameter floatValue]
											  spec:[model.spec floatValue]
                                     crown_width_s:[model.crown_width_s floatValue]
                                     crown_width_e:[model.crown_width_e floatValue]
                                          height_s:[model.height_s floatValue]
                                          height_e:[model.height_e floatValue]
                                      branch_point:[model.branch_point floatValue]
                                            number:[model.number intValue]];
 
    
    NSString *_str = [bqArray componentsJoinedByString:@"  "];
    _bzlbl.text = _str;
    
    
    
    /*
    if (model.shouldShowMoreButton) { // 如果文字高度超过60
        _moreButton.sd_layout.heightIs(20);
        _moreButton.hidden = NO;
        if (model.isOpening) { // 如果需要展开
            _contentLabel.sd_layout.maxHeightIs(MAXFLOAT);
            [_moreButton setTitle:@"收起" forState:UIControlStateNormal];
        } else {
            _contentLabel.sd_layout.maxHeightIs(maxContentLabelHeight);
            [_moreButton setTitle:@"全文" forState:UIControlStateNormal];
        }
    } else {
        _moreButton.sd_layout.heightIs(0);
        _moreButton.hidden = YES;
    }
     */
    
   [_operationMenu setLike:[model.clickStatus boolValue]];
    
    CGFloat picContainerTopMargin = 0;
    if (model.imgArray.count) {
        picContainerTopMargin = 10;
    }
    _picContainerView.sd_layout.topSpaceToView(_iconView, picContainerTopMargin);
    
    UIView *bottomView;
    
    if (!model.commentInfos.count && !model.clickUserInfos.count) {
        bottomView = _timeLabel;
    } else {
        bottomView = _commentView;
    }
    _downView.sd_layout.topSpaceToView(bottomView,10);
    
    [_bgView setupAutoHeightWithBottomView:_downView bottomMargin:0];
    [self setupAutoHeightWithBottomView:_bgView bottomMargin:0];
    
     
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    if (_operationMenu.isShowing) {
        _operationMenu.show = NO;
    }
}

#pragma mark - private actions

//- (void)moreButtonClicked
//{
//    if (self.moreButtonClickedBlock) {
//        self.moreButtonClickedBlock(self.indexPath);
//    }
//}

- (void)operationButtonClicked
{
    [self postOperationButtonClickedNotification];
     self.operationMenu.show = !_operationMenu.isShowing;
}

- (void)receiveOperationButtonClickedNotification:(NSNotification *)notification
{
    UIButton *btn = [notification object];
    
    if (btn != _operationButton &&  self.operationMenu.isShowing) {
        _operationMenu.show = NO;
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self postOperationButtonClickedNotification];
    if ( self.operationMenu.isShowing) {
         self.operationMenu.show = NO;
    }
}

- (void)postOperationButtonClickedNotification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kSDTimeLineCellOperationButtonClickedNotification object:_operationButton];
}

-(NSMutableArray *)getLabelViewList:(CGFloat)rod_diameter
							   spec:(CGFloat)spec
                      crown_width_s:(CGFloat)crown_width_s
                      crown_width_e:(CGFloat)crown_width_e
                           height_s:(CGFloat)height_s
                           height_e:(CGFloat)height_e
                       branch_point:(CGFloat)branch_point
                             number:(int)number
{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
	//规格
	[arr addObject:[NSString stringWithFormat:@"规格: %.1f",spec]];
	//数量
    if (number > 0) {
		NSString *str = [NSString stringWithFormat:@"数量: %d株",number];
        [arr addObject:str];
    }
	//高度
	if (height_s>0 && height_e>0) {
		NSString *str=[NSString stringWithFormat:@"高度: %.1f-%.1fcm",height_s,height_e];
		[arr addObject:str];
	}else if (height_s>0 || height_e>0){
		if (height_s>0) {
			NSString *str=[NSString stringWithFormat:@"高度: %.1fcm",height_s];
			[arr addObject:str];
		}else{
			NSString *str=[NSString stringWithFormat:@"高度: %.1fcm",height_e];
			[arr addObject:str];
		}
	}
	
	if (crown_width_s>0 && crown_width_e>0) {
		NSString *str=[NSString stringWithFormat:@"冠幅: %.1f-%.1fcm",crown_width_s,crown_width_e];
		[arr addObject:str];
	}else if (crown_width_s>0 || crown_width_e>0){
		if (crown_width_s>0) {
			NSString *str=[NSString stringWithFormat:@"冠幅: %.1fcm",crown_width_s];
			[arr addObject:str];
		}else{
			NSString *str=[NSString stringWithFormat:@"冠幅: %.1fcm",crown_width_e];
			[arr addObject:str];
		}
	}
	
    if (rod_diameter > 0) {
        NSString *str=[NSString stringWithFormat:@"#杆径%.1fcm",rod_diameter];
        [arr addObject:str];
    }
	
    if (branch_point>0) {
        NSString *str=[NSString stringWithFormat:@"#分枝点%.1fcm",branch_point];
        [arr addObject:str];
    }
	
    return arr;
}


@end

@implementation SDCommentListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
         self.contentView.backgroundColor=[UIColor clearColor];
        self.backgroundColor=[UIColor clearColor];
//        UIColor *highLightColor = RGB(104, 124, 99);
        UIColor *highLightColor = kColor(@"#3cb5b1");
        UIImage *img=[UIImage imageNamed:@"xpinglun"];
        self.huifImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, img.size.width, img.size.height)];
        self.huifImageV.image = img;
        [self.contentView addSubview:self.huifImageV];
        
        MLLinkLabel *label = [MLLinkLabel new];
        
        
        label.linkTextAttributes = @{NSForegroundColorAttributeName : highLightColor};
        label.font = sysFont(14);
        _label=label;
        __weak typeof(self) weakSelf = self;
        
        label.didClickLinkBlock=^(MLLink *link,NSString *linkText,MLLinkLabel *label){
            if (weakSelf.didClickUserNameBlock) {
                weakSelf.didClickUserNameBlock(link);
            }
        };
		
        [self.contentView addSubview:label];

        label.sd_layout
        .leftSpaceToView(self.huifImageV, 7.5)
        .topEqualToView (self.contentView)
        .rightEqualToView(self.contentView)
        .autoHeightRatio(0);
     
        self.selectionStyle = UITableViewCellSelectionStyleGray;

    }
    return self;
}

- (NSMutableAttributedString *)generateAttributedStringWithCommentItemModel:(SDTimeLineCellCommentItemModel *)model
{
    NSString *text = model.nickname;
    if ([model.comment_type intValue]==1) {
        text = [text stringByAppendingString:[NSString stringWithFormat:@" 回复 %@", model.reply_nickname]];
    }
    text = [text stringByAppendingString:[NSString stringWithFormat:@"：%@", model.comment_cotent]];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:text];
//    [attString setAttributes:@{NSLinkAttributeName : model.user_id} range:[text rangeOfString:model.nickname]];
    [attString setAttributes:@{NSLinkAttributeName : model.user_id} range:[text rangeOfString:model.nickname]];
    if ([model.comment_type intValue]==1) {
        [attString setAttributes:@{NSLinkAttributeName : model.reply_user_id} range:[text rangeOfString:model.reply_nickname]];
    }
    return attString;
}

-(void)setModel:(SDTimeLineCellCommentItemModel *)model{
    _model=model;
     _label.attributedText = [self generateAttributedStringWithCommentItemModel:model];
}
 

@end

@implementation SDForJobCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor=[UIColor clearColor];
        self.backgroundColor=[UIColor clearColor];
          
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
    return self;
}



@end



