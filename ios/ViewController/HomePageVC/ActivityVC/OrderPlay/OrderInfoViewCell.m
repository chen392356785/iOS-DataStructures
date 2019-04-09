//
//  OrderInfoViewCell.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/6/27.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "OrderInfoViewCell.h"

@interface OrderInfoViewCell () {
    UILabel *titleLabel;
    
}
@end

@implementation OrderInfoViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        titleLabel = [[UILabel alloc] init];
//        titleLabel.textColor = kColor(@"333333");
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = sysFont(font(17));
        titleLabel.text = @"姓  名";
        [self.contentView addSubview:titleLabel];
        
        self.textFied = [[IHTextField alloc] init];
        self.textFied.font = sysFont(font(17));
        self.textFied.textColor = kColor(@"333333");
        [self.contentView addSubview:self.textFied];
        [self createlayoutSubviews];
    }
    return self;
}
- (void)createlayoutSubviews {
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).mas_offset(kWidth(16));
        make.left.mas_equalTo(self.contentView).mas_offset(kWidth(14));
        make.width.mas_offset(kWidth(85));
        make.height.mas_offset(kHeight(17));
    }];
    [self.textFied mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).mas_offset(kWidth(16));
        make.left.mas_equalTo(self->titleLabel.mas_right).mas_offset(kWidth(10));
        make.right.mas_equalTo(self.contentView).mas_offset(kWidth(-12));
        make.height.mas_offset(kHeight(17));
    }];
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = kColor(@"#999999");
    [self.contentView addSubview:lineLabel];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_textFied.mas_bottom).mas_offset(kWidth(3));
        make.left.mas_equalTo(self->_textFied.mas_left);
        make.height.mas_offset(0.5);
        make.width.mas_equalTo(self->_textFied);
    }];
}
-(void)setTitleContent:(NSString *)text
{
    titleLabel.text = [NSString stringWithFormat:@"%@:",text];
    titleLabel.font = sysFont(16);
    if ([text containsString:@"*"]) {
        NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:titleLabel.text];
        [attriStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
        titleLabel.attributedText = attriStr;
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
