//
//  GardenCommentCell.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/1/3.
//  Copyright © 2019年 听花科技. All rights reserved.
//

#import "GardenCommentCell.h"

//评论回复列表cell
@interface GardenCommentCell () {
	UILabel *conLabel;
	UILabel *_lineLab;
}
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation GardenCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        [self creareSubview];
    }
    return self;
}
- (void) creareSubview {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // contentLabel
    self.contentLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.contentLabel];
    self.contentLabel.backgroundColor  = [UIColor clearColor];
    self.contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.font = sysFont(font(10));
    self.contentLabel.textColor = kColor(@"#4A4A4A");
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(4);
        make.right.mas_equalTo(self.contentView).mas_offset(-2);
        make.top.mas_equalTo(self.contentView).offset(3.0);//cell上部距离为3.0个间隙
//        make.height.mas_offset(font(10));
    }];
    
    UILabel *lineLab = [[UILabel alloc] init];
    [self.contentView addSubview:lineLab];
    lineLab.backgroundColor = kColor(@"#05C1B0");
    [lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView);
        make.width.mas_offset(1);
    }];
    _lineLab = lineLab;
}
- (void)setModel:(gardenReplyCommentModel *)model {
    NSString *str = nil;
    if (![model.replyUserName isEqualToString:@""]) {
        str= [NSString stringWithFormat:@"%@回复%@：%@",
            model.replyUserName, model.userName, model.comment];
    }else {
        str= [NSString stringWithFormat:@"%@：%@",
            model.userName, model.comment];
    }
    self.contentLabel.height = 15;
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle *muStyle = [[NSMutableParagraphStyle alloc] init];
    
    muStyle.lineSpacing = 3.0;//设置行间距离
    [text addAttribute:NSParagraphStyleAttributeName value:muStyle range:NSMakeRange(0, text.length)];
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:font(10)],
                                 NSParagraphStyleAttributeName:muStyle
                                 };
    [text addAttributes:attributes range:NSMakeRange(0, str.length)];
    
    [text addAttribute:NSForegroundColorAttributeName
                 value:kColor(@"#05C1B0")
                 range:NSMakeRange(0, model.replyUserName.length)];
    [text addAttribute:NSForegroundColorAttributeName
                 value:kColor(@"#05C1B0")
                 range:NSMakeRange(model.replyUserName.length + 2, model.userName.length)];
    self.contentLabel.attributedText = text;
    
    [self layoutIfNeeded];
    [self.contentLabel sizeToFit];
    self.contentLabel.backgroundColor = [UIColor whiteColor];
    [self layoutIfNeeded];
    NSLog(@"===== %lf",self.contentLabel.height);
    CGFloat bottomSpace;
    if (self.contentLabel.height > 15) {
        bottomSpace = kWidth(13);
    }else {
        bottomSpace = 0.5;
    }
    [self setupAutoHeightWithBottomView:self.contentLabel bottomMargin:bottomSpace];
}

@end
