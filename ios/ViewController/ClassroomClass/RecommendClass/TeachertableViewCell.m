//
//  TeachertableViewCell.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/10/16.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "TeachertableViewCell.h"

@implementation TeachertableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        [self creareSubview];
    }
    return self;
}
- (void) creareSubview {
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(kWidth(25), kWidth(66), iPhoneWidth - kWidth(50), kWidth(184))];
    _bgView.layer.cornerRadius = kWidth(10);
    _bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_bgView];
    
    _headImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth(77), kWidth(77))];
    _headImage.layer.cornerRadius = _headImage.width/2.;
    _headImage.clipsToBounds = YES;
    _headImage.layer.borderWidth = kWidth(3);
    _headImage.layer.borderColor = kColor(@"#fee7ab").CGColor;
    [self.contentView addSubview:_headImage];
    _headImage.centerX = _bgView.centerX;
    _headImage.centerY = minY(_bgView);
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kWidth(38.5) + kWidth(11), kWidth(90), kWidth(24))];
    _nameLabel.layer.cornerRadius = _nameLabel.height/2.;
    _nameLabel.clipsToBounds = YES;
    _nameLabel.backgroundColor = kColor(@"#29daa2");
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.text = @"张萌萌";
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.centerX = _bgView.width/2.;
    _nameLabel.font = boldFont(font(18));
    [_bgView addSubview:_nameLabel];
    
    _contLabel = [[UILabel alloc] init];
    _contLabel.centerX = _nameLabel.centerX;
    _contLabel.font = sysFont(font(14));
    _contLabel.numberOfLines = 0;
//    _contLabel.textColor = kColor(@"#1b1b1b");
    _contLabel.textAlignment = NSTextAlignmentCenter;
    [_bgView addSubview:_contLabel];
}
- (void)setModel:(TearchListModel *)model {
    [_headImage sd_setImageWithURL:[NSURL URLWithString:model.headPic] placeholderImage:DefaultImage_logo];
    _nameLabel.text = model.name;
//    _contLabel.text = model.intro;
    
    _contLabel.size = CGSizeMake( width(_bgView) - kWidth(24), 0);
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:model.intro];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [model.intro length])];
    paragraphStyle.alignment = NSTextAlignmentCenter;       // 对齐方式，
    _contLabel.attributedText = attributedString;
    [_contLabel sizeToFit];
    
//    CGFloat textHeight = [IHUtility calculateRowHeight:model.intro Width: width(_bgView) - kWidth(24) fontSize:font(14)] + 10;
    
    if (_contLabel.size.height <= kWidth(28)) {
        _contLabel.frame = CGRectMake(kWidth(12), maxY(_nameLabel) + kWidth(14), width(_bgView) - kWidth(24), height(_bgView) - maxY(_nameLabel) - kWidth(28));
    }else {
        _contLabel.frame = CGRectMake(kWidth(12), maxY(_nameLabel) + kWidth(14), width(_bgView) - kWidth(24), _contLabel.size.height);
        _bgView.size = CGSizeMake(iPhoneWidth - kWidth(50), _contLabel.bottom + kWidth(12));
    }
    [self setupAutoHeightWithBottomView:_bgView bottomMargin:kWidth(12)];
}
@end





@implementation TeacherClasstListViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        [self createlayoutSubview];
    }
    return self;
}
- (void) createlayoutSubview {
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    UIAsyncImageView *imageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(kWidth(10), kWidth(19), kWidth(153), kWidth(104))];
    _topImageView = imageView;
    _topImageView.image = DefaultImage_logo;
    _topImageView.layer.cornerRadius = kWidth(7);
    [self.contentView addSubview:imageView];
    
    SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(maxX(_topImageView) + kWidth(14) , minY(_topImageView) + kWidth(5), iPhoneWidth - maxX(_topImageView) - kWidth(28), kWidth(35)) textColor:cBlackColor textFont:boldFont(14)];
    lbl.textAlignment = NSTextAlignmentLeft;
    lbl.numberOfLines = 2;
    lbl.text=@"花卉苗木电商学院金牌讲师花卉苗木电商学院金牌讲师";
    _titileLabel = lbl;
    [self.contentView addSubview:lbl];
    
    SMLabel *label1 = [[SMLabel alloc] initWithFrame:CGRectMake(minX(_titileLabel), _titileLabel.bottom + kWidth(5) , width(_titileLabel), maxY(_topImageView) - maxY(_titileLabel) - kWidth(28))];
    label1.textColor = kColor(@"#8c8c8c");
    label1.verticalAlignment = VerticalAlignmentTop;
    label1.numberOfLines = 0;
    label1.text = @"1贾珍 | 电商行业白手 贾珍 | 电商行业白手 贾珍 | 电商行业白手";
    label1.font = sysFont(12);
    label1.textAlignment = NSTextAlignmentLeft;
    _infoLabel = label1;
    [self.contentView addSubview:label1];
    
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(minX(_titileLabel) , _infoLabel.bottom + kWidth(5),  width(_titileLabel), kWidth(25)) textColor:RGB(255, 0, 0) textFont:sysFont(14)];
    lbl.text=@"￥120";
    _priceLabel.font = sysFont(14);
    _priceLabel = lbl;
//    [self.contentView addSubview:lbl];
    
    _signUpLabel = [[UILabel alloc]initWithFrame:CGRectMake(maxX(_titileLabel) - kWidth(90) , _priceLabel.top,  kWidth(90), kWidth(25))];
    _signUpLabel.text=@"去报名";
    _signUpLabel.font = sysFont(13);
    _signUpLabel.layer.cornerRadius = 3;
    _signUpLabel.layer.borderWidth = 1;
    _signUpLabel.layer.borderColor = cLineColor.CGColor;
    _signUpLabel.textAlignment = NSTextAlignmentCenter;
//    [self.contentView addSubview:_signUpLabel];
    
    UILabel *linelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , iPhoneWidth , 1)];
    linelabel.backgroundColor = cLineColor;
    _lineLabel = linelabel;
    [self.contentView addSubview:_lineLabel];
}
- (void) setTearchClassListModel:(studyBannerListModel *)model {
    [_topImageView setImageAsyncWithURL:model.headPic placeholderImage:DefaultImage_logo];
    _titileLabel.text = model.className;
    _infoLabel.text = model.classIntro;
    if ([model.totalMoney floatValue] <= 0.0) {
        _priceLabel.text = @"免费";
    }else {
        _priceLabel.text = [NSString stringWithFormat:@"￥ %@",model.totalMoney];
    }
    
}
@end
