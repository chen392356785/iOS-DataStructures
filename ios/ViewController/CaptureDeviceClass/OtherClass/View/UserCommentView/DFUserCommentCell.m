//
//  DFUserCommentCell.m
//  DF
//
//  Created by Tata on 2017/11/30.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFIconConstant.h"
#import "DFUserCommentCell.h"
#import "DFCommentModel.h"

@interface DFUserCommentCell ()

@property (nonatomic, strong) UIImageView *userIcon;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation DFUserCommentCell

- (void)addSubviews {
    [self creatViews];
    
    [self.contentView addSubview:self.userIcon];
    [self.contentView addSubview:self.userNameLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.lineView];
    
}

- (void)defineLayout {
    [self.userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).with.offset(self.userIcon.cas_marginLeft);
        make.width.equalTo(@(self.userIcon.cas_sizeWidth));
        make.height.equalTo(@(self.userIcon.cas_sizeHeight));
    }];
    
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userIcon.mas_right).with.offset(self.userNameLabel.cas_marginLeft);
        make.right.equalTo(self.timeLabel.mas_left);
        make.top.equalTo(self.mas_top).with.offset(self.userNameLabel.cas_marginTop);
        make.height.equalTo(@(self.userNameLabel.cas_sizeHeight));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(self.timeLabel.cas_sizeWidth));
        make.right.equalTo(self.mas_right).with.offset(self.timeLabel.cas_marginRight);
        make.centerY.equalTo(self.userNameLabel.mas_centerY);
        make.height.equalTo(@(self.timeLabel.cas_sizeHeight));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).with.offset(self.lineView.cas_marginBottom);
        make.right.equalTo(self.mas_right);
        make.left.equalTo(self.userNameLabel.mas_left);
        make.height.equalTo(@(self.lineView.cas_sizeHeight));
    }];
}

- (void)creatViews {
    self.userIcon = [[UIImageView alloc]init];
    self.userIcon.cas_styleClass = @"userComment_userIcon";
    self.userIcon.layer.masksToBounds = YES;
    
    self.userNameLabel = [[UILabel alloc]init];
    self.userNameLabel.cas_styleClass = @"userComment_userNameLabel";
    
    self.timeLabel = [[UILabel alloc]init];
    self.timeLabel.cas_styleClass = @"userComment_timeLabel";
    
    self.contentLabel = [[UILabel alloc]init];
    self.contentLabel.cas_styleClass = @"userComment_contentLabel";
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    
    self.lineView = [[UIView alloc]init];
    self.lineView.cas_styleClass = @"userComment_lineView";
    
}

- (void)setCommentModel:(DFCommentModel *)commentModel {
    if (!commentModel) {
        return;
    }
    _commentModel = commentModel;
    
    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:commentModel.HeadImage] placeholderImage:kImage(UserIcon)];
    
    self.userNameLabel.text = commentModel.NickName;
    
    self.timeLabel.text = commentModel.TimeStr;
    
    self.contentLabel.text = commentModel.Content;
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userIcon.mas_right).with.offset(self.contentLabel.cas_marginLeft);
        make.right.equalTo(self.mas_right).with.offset(self.contentLabel.cas_marginRight);
        make.bottom.equalTo(self.mas_bottom).with.offset(self.contentLabel.cas_marginBottom);
        make.height.equalTo(@([self heightWithString:commentModel.Content]));
    }];
}

- (CGFloat)heightWithString:(NSString *)string {
    UIFont *font = [UIFont fontWithName:PingFangRegularFont() size:14 * TTUIScale()];
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    CGFloat height = [string boundingRectWithSize:CGSizeMake(iPhoneWidth - 80 * TTUIScale(), 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.height;
    return height + 2;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
