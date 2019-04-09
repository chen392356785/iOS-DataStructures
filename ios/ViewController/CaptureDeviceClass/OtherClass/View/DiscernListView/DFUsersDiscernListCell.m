//
//  DFUsersDiscernListCell.m
//  DF
//
//  Created by Tata on 2017/11/30.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFUsersDiscernListCell.h"
#import "DFDiscernListModel.h"
#import "DFCommentView.h"
#import "DFCommentModel.h"
#import "DFIconConstant.h"

@interface DFUsersDiscernListCell ()

@property (nonatomic, strong) UIImageView *flowerImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *userView;
@property (nonatomic, strong) UIImageView *userIcon;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UIButton *commentButton;

@property (nonatomic, strong) NSMutableArray *commentHeightArray;

@end

@implementation DFUsersDiscernListCell

- (NSMutableArray *)commentHeightArray {
    if (_commentHeightArray == nil) {
        _commentHeightArray = [NSMutableArray array];
    }
    return _commentHeightArray;
}

- (void)addSubviews {
    [self creatViews];
    self.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.flowerImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.userView];
    [self.userView addSubview:self.userIcon];
    [self.userView addSubview:self.userNameLabel];
    [self.userView addSubview:self.commentButton];
    
}

- (void)defineLayout {
    [self.flowerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@(self.flowerImageView.cas_sizeHeight));
    }];
    
    [self.userView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@(self.userView.cas_sizeHeight));
    }];
    
    [self.userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userView.mas_left).with.offset(self.userIcon.cas_marginLeft);
        make.centerY.equalTo(self.userView.mas_centerY);
        make.width.equalTo(@(self.userIcon.cas_sizeWidth));
        make.height.equalTo(@(self.userIcon.cas_sizeHeight));
    }];
    
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userIcon.mas_right).with.offset(self.userNameLabel.cas_marginLeft);
        make.centerY.equalTo(self.userView.mas_centerY);
        make.right.equalTo(self.commentButton.mas_left).with.offset(self.userNameLabel.cas_marginRight);
        make.height.equalTo(@(self.userNameLabel.cas_sizeHeight));
    }];
    
    [self.commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.userView.mas_right).with.offset(self.commentButton.cas_marginRight);
        make.centerY.equalTo(self.userView.mas_centerY);
        make.width.equalTo(@(self.commentButton.cas_sizeWidth));
        make.height.equalTo(@(self.commentButton.cas_sizeHeight));
    }];
}

- (void)creatViews {
    self.flowerImageView = [[UIImageView alloc]init];
    self.flowerImageView.cas_styleClass = @"discernCell_flowerImageView";
    self.flowerImageView.clipsToBounds = YES;
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.cas_styleClass = @"discernCell_titleLabel";
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    
    self.userView = [[UIView alloc]init];
    self.userView.cas_styleClass = @"discernCell_userView";
    
    self.userIcon = [[UIImageView alloc]init];
    self.userIcon.cas_styleClass = @"discernCell_userIcon";
    
    self.userNameLabel = [[UILabel alloc]init];
    self.userNameLabel.cas_styleClass = @"discernCell_userNameLabel";
    
    self.commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.commentButton.hitTestEdgeInsets = UIEdgeInsetsMake(-10, -10, -10, -10);
    self.commentButton.cas_styleClass = @"discernCell_commentButton";
    [self.commentButton addTarget:self action:@selector(commentAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.commentButton setImage:kImage(CommentIcon) forState:UIControlStateNormal];
  
}

- (void)commentAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(addComment:)]) {
        [self.delegate addComment:sender];
    }
}

- (void)setListModel:(DFDiscernListModel *)listModel {
    if (!listModel) {
        return;
    }
    _listModel = listModel;
    [self.commentHeightArray removeAllObjects];
    
    [self.flowerImageView setImageWithURL:[NSURL URLWithString:listModel.ImagePath] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.userNameLabel.text = listModel.NickName;
    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:self.listModel.HeadImage] placeholderImage:kImage(UserIcon)];
    self.userIcon.layer.masksToBounds = YES;
    
    self.titleLabel.text = listModel.Title;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.flowerImageView.mas_bottom).with.offset(self.titleLabel.cas_marginTop);
        make.left.equalTo(self.mas_left).with.offset(self.titleLabel.cas_marginLeft);
        make.right.equalTo(self.mas_right).with.offset(self.titleLabel.cas_marginRight);
        make.height.equalTo(@([self titleHeightWithString:listModel.Title]));
    }];
    
    NSMutableArray *subviews = [self.contentView.subviews mutableCopy];
    for (UIView *view in subviews) {
        if ([view isKindOfClass:[DFCommentView class]]) {
            [view removeFromSuperview];
        }
    }
    
    for (int i = 0; i < listModel.CommentList.count; i ++) {
        DFCommentModel *commentModel = listModel.CommentList[i];
        NSString *contentString = [NSString stringWithFormat:@"%@：%@",commentModel.NickName,commentModel.Content];
        CGFloat height = [self heightWithString:contentString];
        [self.commentHeightArray addObject:@(height)];
    }
    
    CGFloat topHeight = 220 * TTUIScale() + [self titleHeightWithString:listModel.Title];
    for (int i = 0; i < listModel.CommentList.count; i ++) {
        DFCommentView *commentView = [[DFCommentView alloc]initWithFrame:CGRectMake(0, topHeight , self.width, [self.commentHeightArray[i] floatValue])];
        topHeight = topHeight + [self.commentHeightArray[i] floatValue];
        DFCommentModel *commentModel = listModel.CommentList[i];
        commentView.commentModel = commentModel;
        [self.contentView addSubview:commentView];
    }
    
}

- (CGFloat)heightWithString:(NSString *)string {
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Regular" size:11 * TTUIScale()];
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    CGFloat height = [string boundingRectWithSize:CGSizeMake((iPhoneWidth - 20 * TTUIScale() - 5)/2 - 10 * TTUIScale(), 200) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.height;
    return height + 3;
}

- (CGFloat)titleHeightWithString:(NSString *)string {
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Regular" size:12 * TTUIScale()];
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    CGFloat height = [string boundingRectWithSize:CGSizeMake((iPhoneWidth - 20 * TTUIScale() - 5)/2 - 10 * TTUIScale(), 200) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.height;
    return height + 2;
}



@end
