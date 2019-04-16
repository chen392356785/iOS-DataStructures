//
//  GardenListDetailViewCell.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/1/3.
//  Copyright © 2019年 听花科技. All rights reserved.
//

#import "GardenListDetailViewCell.h"

@implementation GardenListDetailViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        [self creareSubview];
    }
    return self;
}
- (void) creareSubview {
    
}
- (void)setModel:(NSString *)model {
   
}

@end





@interface GardenListDetailInfoCell () {
    UILabel *companyLab;
    UIButton *phoneBut;
    UILabel *bangdanLab;
    UILabel *nameLab;
    UILabel *paimingLab;
    UILabel *phoneNumLab;
    yuanbangModel *_model;
}
@end
@implementation GardenListDetailInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        [self creareSubview];
    }
    return self;
}
- (void) creareSubview {
    companyLab = [[UILabel alloc] initWithFrame:CGRectMake(kWidth(15), kWidth(10), kWidth(100), kWidth(18))];
    companyLab.textColor = kColor(@"#030303");
    companyLab.font = [UIFont fontWithName:@"PingFangSC-Regular" size: font(12)];
    [self.contentView addSubview:companyLab];
    
    phoneBut = [UIButton buttonWithType:UIButtonTypeSystem];
    phoneBut.frame = CGRectMake(companyLab.right + kWidth(8), companyLab.top, kWidth(28), kWidth(18));
    phoneBut.centerY = companyLab.centerY;
    [phoneBut setBackgroundImage:kImage(@"garden_detail_tel") forState:UIControlStateNormal];
    [phoneBut addTarget:self action:@selector(PhoneTelAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:phoneBut];
    
    
    bangdanLab = [[UILabel alloc] initWithFrame:CGRectMake(companyLab.left + kWidth(25), companyLab.bottom + kWidth(10),(iPhoneWidth - kWidth(85))/2 + kWidth(45), kWidth(15))];
    bangdanLab.textColor = kColor(@"#030303");
    bangdanLab.font = [UIFont fontWithName:@"PingFangSC-Regular" size: font(10)];
    [self.contentView addSubview:bangdanLab];
    
    
    nameLab = [[UILabel alloc] initWithFrame:CGRectMake(bangdanLab.right + kWidth(10), bangdanLab.top , bangdanLab.width - kWidth(75), kWidth(15))];
    nameLab.textColor = kColor(@"#030303");
    nameLab.textAlignment = NSTextAlignmentRight;
    nameLab.font = [UIFont fontWithName:@"PingFangSC-Regular" size: font(10)];
    [self.contentView addSubview:nameLab];
    
    
    paimingLab = [[UILabel alloc] initWithFrame:CGRectMake(bangdanLab.left, bangdanLab.bottom + kWidth(5),bangdanLab.width - kWidth(75), kWidth(15))];
    paimingLab.textColor = kColor(@"#030303");
    paimingLab.font = [UIFont fontWithName:@"PingFangSC-Regular" size: font(10)];
    [self.contentView addSubview:paimingLab];
    
    phoneNumLab = [[UILabel alloc] initWithFrame:CGRectMake(paimingLab.right + kWidth(10), paimingLab.top,bangdanLab.width, kWidth(15))];
    phoneNumLab.textColor = kColor(@"#030303");
    phoneNumLab.textAlignment = NSTextAlignmentRight;
    phoneNumLab.font = [UIFont fontWithName:@"PingFangSC-Regular" size: font(10)];
    [self.contentView addSubview:phoneNumLab];
    
    UITapGestureRecognizer *phonetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(PhoneTelAction)];
    // 允许用户交互
    phoneNumLab.userInteractionEnabled = YES;
    [phoneNumLab addGestureRecognizer:phonetap];
}
- (void)setModel:(yuanbangModel *)model {
    _model = model;
    companyLab.text = model.gardenCompany;
    companyLab.numberOfLines = 1;
    [companyLab sizeToFit];
    phoneBut.frame = CGRectMake(companyLab.right + kWidth(8), companyLab.top, kWidth(13), kWidth(13));
    phoneBut.centerY = companyLab.centerY;
    
    bangdanLab.text = [NSString stringWithFormat:@"所在榜单：%@",model.gardenListName];
    nameLab.text = [NSString stringWithFormat:@"联系人：%@",model.gardenName];
    paimingLab.text = [NSString stringWithFormat:@"排名：第%@名",model.paiming];
    if (![model.mobile isEqualToString:@""]) {
        phoneNumLab.text = [NSString stringWithFormat:@"联系电话：%@",model.mobile];
    }else {
        phoneNumLab.text = [NSString stringWithFormat:@"联系电话：暂无联系方式"];
    }
    [self setupAutoHeightWithBottomView:phoneNumLab bottomMargin:kWidth(20)];
}
- (void) PhoneTelAction {
    if (![_model.mobile isEqualToString:@""]) {
        NSString *phoneString = [NSString stringWithFormat:@"tel:%@",_model.mobile];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:phoneString]]];
        [self.contentView addSubview:callWebview];
    }else
    {
        [IHUtility addSucessView:@"对方没有留下电话" type:1];
    }
}
@end






@interface GardenListDetailSkrCell () {
    UILabel *infoLab;
    UIButton *skrBut;
    UILabel *skrNumLab;
    yuanbangModel *_model;
}
@end
@implementation GardenListDetailSkrCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        [self creareSubview];
    }
    return self;
}
- (void) creareSubview {
    infoLab = [[UILabel alloc] initWithFrame:CGRectMake(0, kWidth(20), iPhoneWidth, kWidth(14))];
    infoLab.textColor = kColor(@"#575757");
    infoLab.font = [UIFont fontWithName:@"PingFangSC-Regular" size: font(10)];
    infoLab.text = @"喜欢就点个赞吧";
    infoLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:infoLab];
    
     
    skrBut = [UIButton buttonWithType:UIButtonTypeSystem];
    skrBut.frame = CGRectMake(0, infoLab.bottom + kWidth(10), kWidth(60), kWidth(24));
    skrBut.centerX = infoLab.centerX;
    [skrBut setBackgroundImage:kImage(@"skr_normal") forState:UIControlStateNormal];
    [skrBut addTarget:self action:@selector(skrButAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:skrBut];
    
    skrNumLab = [[UILabel alloc] initWithFrame:CGRectMake(0, skrBut.bottom + kWidth(10), iPhoneWidth, kWidth(14))];
    skrNumLab.textColor = kColor(@"#575757");
    skrNumLab.font = [UIFont fontWithName:@"PingFangSC-Regular" size: font(10)];
    skrNumLab.text = @"";
    skrNumLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:skrNumLab];
}
- (void)setModel:(yuanbangModel *)model {
    _model = model;
    if ([model.isClick isEqualToString:@"1"]) {
        skrBut.userInteractionEnabled = NO;
        [skrBut setImage:[kImage(@"skr_hig") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }else {
        skrBut.userInteractionEnabled = YES;
        [skrBut setImage:[kImage(@"skr_normal") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }
    skrNumLab.text = [NSString stringWithFormat:@"已有%@人点赞",model.gardenSignString];
    [self setupAutoHeightWithBottomView:skrNumLab bottomMargin:kWidth(20)];
}
- (void) skrButAction {
    if (![_model.isClick isEqualToString:@"1"]) {
        if (self.skrBlock) {
            self.skrBlock();
        }
    }
}
@end



@interface GardenListcompanydescribeCell () <UITextViewDelegate>{
//    UILabel *conLabel;
//    yuanbangModel *_model;
    UITextView * _contentLabel;
}
@end
@implementation GardenListcompanydescribeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        [self creareSubview];
    }
    return self;
}
- (void) creareSubview {
    
    UITextView * contentLbl = [[UITextView alloc]initWithFrame:CGRectMake(kWidth(10), 0, iPhoneWidth - kWidth(20), kWidth(40))];
    contentLbl.font = [UIFont systemFontOfSize:font(14)];
    contentLbl.scrollEnabled = NO;
    contentLbl.delegate=self;
    _contentLabel = contentLbl;
    contentLbl.dataDetectorTypes = UIDataDetectorTypeLink;
    if(_IOS7){
        contentLbl.selectable = YES;//用法：决定UITextView 中文本是否可以相应用户的触摸，主要指：1、文本中URL是否可以被点击；2、UIMenuItem是否可以响应
    }
    //   contentLbl.delegate=self;
    contentLbl.backgroundColor=[UIColor clearColor];
    [contentLbl setEditable:NO];
    contentLbl.textColor = cBlackColor;
    [self.contentView addSubview:contentLbl];
    
/*
    conLabel = [[UILabel alloc] initWithFrame:CGRectMake(kWidth(15), kWidth(10), iPhoneWidth - kWidth(20), kWidth(40))];
    conLabel.textColor = kColor(@"#030303");
    conLabel.numberOfLines = 0;
    conLabel.font = [UIFont systemFontOfSize:font(12)];
    [self.contentView addSubview:conLabel];
//*/
    
}


- (void)setModel:(yuanbangModel *)model {
    NSString *contextStr;
    char context1 = [model.gardenContent characterAtIndex:0];
    char context2 = [model.gardenContent characterAtIndex:model.gardenContent.length-1];
    if (model.gardenContent.length > 0) {
        if ( context1 == '<' && context2 == '>') {
            contextStr = [NSString stringWithFormat:@"%@",model.gardenContent];
        }else {
           contextStr = [NSString stringWithFormat:@"<p>%@</p>",model.gardenContent];
        }
    }
/*
    if ([model.gardenContent rangeOfString:@"<"].location == NSNotFound && [model.gardenContent rangeOfString:@">"].location == NSNotFound) {
        contextStr = [NSString stringWithFormat:@"<p>%@</p>",model.gardenContent];
    }else {
        contextStr = [NSString stringWithFormat:@"%@",model.gardenContent];
    }
 */
    [self setcontentText:contextStr];
    CGFloat height =   [_contentLabel.attributedText boundingRectWithSize:CGSizeMake(_contentLabel.width - kWidth(10), CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
    _contentLabel.height = height + kWidth(5);
    [self setupAutoHeightWithBottomView:_contentLabel bottomMargin:kWidth(0.1)];
/*
    conLabel.text = model.gardenContent;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;// 字体的行间距
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:font(12)],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    conLabel.attributedText = [[NSAttributedString alloc] initWithString:conLabel.text attributes:attributes];
    [conLabel sizeToFit];
    [self setupAutoHeightWithBottomView:conLabel bottomMargin:kWidth(20)];
 */
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    NSString *urlstr = [URL absoluteString];
    // 响应以下前缀或域名的网址链接
    if ( [urlstr hasPrefix:@"http://"] || [urlstr hasPrefix:@"https://"] || [urlstr hasPrefix:@"www."]|| [urlstr hasPrefix:@".com"]|| [urlstr hasPrefix:@".cn"]) {
        //        self.selectUrlBlock(urlstr);
        [self webViewUrl:[NSURL URLWithString:urlstr]];
        return NO;
    };
    return YES; // let the system open this URL
}
-(void)setcontentText:(NSString *)text
{
    NSDictionary *options = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType};
    
    NSString *HurlStr = [NSString stringWithFormat:@"<head><style>img{width:%f !important;height:auto}</style></head>%@",iPhoneWidth - kWidth(40),text];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithData:[HurlStr dataUsingEncoding:NSUnicodeStringEncoding] options:options documentAttributes:nil error:nil];
    [attrString addAttribute:NSFontAttributeName value:sysFont(font(14)) range:NSMakeRange(0,attrString.length)];
    
    _contentLabel.attributedText = attrString;
    
}
-(void)webViewUrl:(NSURL *)url{
    /*
    YLWebViewController *controller=[[YLWebViewController alloc]init];
    controller.type=1;
    controller.mUrl=url;
    [self pushViewController:controller];
     */
}

@end





