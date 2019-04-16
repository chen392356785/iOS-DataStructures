//
//  MTSupplySectionHeaderView.m
//  MiaoTuProject
//
//  Created by dzb on 2019/4/12.
//  Copyright © 2019 听花科技. All rights reserved.
//

#import "Masonry.h"
#import "UILabel+YVAdd.h"
#import "MTSupplyDetailsModel.h"
#import "MTSupplySectionHeaderView.h"

@interface MTSupplySectionHeaderView()

///agreeButton
@property (nonatomic,strong) UIButton *agreeButton;
///commentsLabel
@property (nonatomic,strong) UILabel *commentsLabel;
///agreeListLabel
@property (nonatomic,strong) UILabel *agreeListLabel;
///agreeImageView
@property (nonatomic,strong) UIImageView *agreeImageView;
///commentButton
@property (nonatomic,strong) UIButton *commentButton;

@end

@implementation MTSupplySectionHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
	if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
		
		self.contentView.backgroundColor = RGB(247.0f, 247.0f, 247.0f);
		UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f,UIScreen.mainScreen.bounds.size.width,47.0f)];
		whiteView.backgroundColor = [UIColor whiteColor];
		[self.contentView addSubview:whiteView];
	
		[self.contentView addSubview:self.commentsLabel];
		[self.contentView addSubview:self.agreeButton];
		[self.contentView addSubview:self.agreeImageView];
		[self.contentView addSubview:self.agreeListLabel];
		[self.contentView addSubview:self.commentButton];
		
		[self.commentsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.equalTo(self.contentView.mas_left).offset(14.0f);
			make.top.equalTo(self.contentView.mas_top).offset(16.0f);
			make.size.mas_equalTo(CGSizeMake(150.0f,16.0f));
		}];
		
		
		[self.agreeButton mas_makeConstraints:^(MASConstraintMaker *make) {
			make.centerY.equalTo(self.commentsLabel);
			make.right.equalTo(self.contentView.mas_right).offset(-14.0f);
			make.width.mas_greaterThanOrEqualTo(30.0f);
			make.height.mas_equalTo(16.0f);
		}];
		
		[self.commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
			make.centerY.equalTo(self.agreeButton);
			make.right.equalTo(self.agreeButton.mas_left).offset(-25.0f);
			make.size.mas_equalTo(CGSizeMake(20.0f, 20.0f));
		}];
		
		[self.agreeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.equalTo(self.commentsLabel);
			make.top.equalTo(self.commentsLabel.mas_bottom).offset(30.0f);
			make.size.mas_equalTo(CGSizeMake(16.0f, 15.0f));
		}];
		
		[self.agreeListLabel mas_makeConstraints:^(MASConstraintMaker *make) {
			make.top.equalTo(self.agreeImageView);
			make.left.equalTo(self.agreeImageView.mas_right).offset(6.0f);
			make.right.equalTo(self.contentView.mas_right).offset(-23.0f);
			make.height.mas_greaterThanOrEqualTo(20.0f);
			make.bottom.equalTo(self.contentView.mas_bottom).offset(-18.0f);
		}];
		
		self.commentsLabel.text = @"评论0";
		[self.agreeButton setTitle:@"0" forState:UIControlStateNormal];

		UIView *bottomLineView = [[UIView alloc] init];
		bottomLineView.backgroundColor =  [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
		[self.contentView addSubview:bottomLineView];
		[bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.bottom.equalTo(self.contentView);
			make.left.equalTo(self.contentView.mas_left).offset(14.0f);
			make.right.equalTo(self.contentView.mas_right).offset(-14.0f);
			make.height.mas_offset(1.0f);
		}];
		
	}
	return self;
}


- (UIButton *)agreeButton {
	if (!_agreeButton) {
		_agreeButton  = [UIButton buttonWithType:UIButtonTypeCustom];
		[_agreeButton setTitleColor:RGB(53.0f, 53.0f, 53.0f) forState:UIControlStateNormal];
		_agreeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
		_agreeButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
		UIImageView *agreeImageView = [[UIImageView alloc] init];
		agreeImageView.tag = 100;
		agreeImageView.frame = CGRectMake(0.0f,0.0f, 16.0f, 16.0f);
		agreeImageView.image = [UIImage imageNamed:@"comments_agree"];
		[_agreeButton addSubview:agreeImageView];
		[_agreeButton addTarget:self action:@selector(agreeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
	}
	return _agreeButton;
}

- (UILabel *)commentsLabel {
	if (!_commentsLabel) {
		_commentsLabel = [[UILabel alloc] init];
		_commentsLabel.textColor = [UIColor colorWithRed:53/255.0 green:53/255.0 blue:53/255.0 alpha:1.0];
		_commentsLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size: 16];
	}
	return _commentsLabel;
}

- (UILabel *)agreeListLabel {
	if (!_agreeListLabel) {
		UILabel *label = [[UILabel alloc] init];
		label.numberOfLines = 0;
		label.textColor = [UIColor colorWithRed:0/255.0 green:148/255.0 blue:143/255.0 alpha:1.0];
		label.font = [UIFont fontWithName:@"PingFang-SC-Bold" size: 14];
		_agreeListLabel = label;
	}
	return _agreeListLabel;
}

- (UIImageView *)agreeImageView {
	if (!_agreeImageView) {
		_agreeImageView = [[UIImageView alloc] init];
		_agreeImageView.image = [UIImage imageNamed:@"comments_agree"];
	}
	return _agreeImageView;
}

- (UIButton *)commentButton {
	if (!_commentButton) {
		_commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[_commentButton setImage:[UIImage imageNamed:@"comment_button_image"] forState:UIControlStateNormal];
		[_commentButton addTarget:self action:@selector(commentButtonAction:) forControlEvents:UIControlEventTouchUpInside];
	}
	return _commentButton;
}

- (void)setDetailsModel:(MTSupplyDetailsModel *)detailsModel {
	_detailsModel = detailsModel;
	self.commentsLabel.text = [NSString stringWithFormat:@"评论%zd",_detailsModel.commentTotal];
	if (_detailsModel.hasClickLike) { //isLike
		UIImage *image = [UIImage imageNamed:@"comments_agree"];
		UIImageView *imageView = [self.agreeButton viewWithTag:100];
		imageView.image = self.agreeImageView.image = image;
	} else {
		UIImage *image = [UIImage imageNamed:@"comments_unagree"];
		UIImageView *imageView = [self.agreeButton viewWithTag:100];
		imageView.image = self.agreeImageView.image = image;
	}
	
	if (_detailsModel.clickLikeTotal == 0) {
		self.agreeImageView.hidden = YES;
		[self.agreeButton setTitle:@"" forState:UIControlStateNormal];
	} else {
		self.agreeImageView.hidden = NO;
		[self.agreeButton setTitle:[NSString stringWithFormat:@"%zd",_detailsModel.clickLikeTotal] forState:UIControlStateNormal];
	}
}

- (void)setAgreeList:(NSArray<NSDictionary *> *)agreeList {
	_agreeList = [agreeList copy];
	NSArray *nicknameArr = [_agreeList valueForKey:@"nickname"];
	NSArray *useridArray = [_agreeList valueForKey:@"user_id"];
	self.agreeListLabel.text = [nicknameArr componentsJoinedByString:@"、"];
	__weak typeof(self)weakSelf = self;
	[self.agreeListLabel yb_addAttributeTapActionWithStrings:nicknameArr tapClicked:^(NSString * _Nonnull string, NSRange range, NSInteger index) {
		__strong typeof(weakSelf)strongSelf = weakSelf;
		NSInteger userid = [[useridArray objectAtIndex:index] integerValue];
		if ([strongSelf.delegate respondsToSelector:@selector(supplySectionHeaderView:tapUserNicknameAction:userid:)]) {
			[strongSelf.delegate supplySectionHeaderView:strongSelf tapUserNicknameAction:string userid:userid];
		}
	}];
	
}

- (void) agreeButtonAction:(UIButton *)button {
	NSInteger likeCount = self.detailsModel.clickLikeTotal;
	button.selected = !button.selected;
	BOOL isAgree = !self.detailsModel.hasClickLike;
	if (isAgree) {
		likeCount++;
		UIImage *image = [UIImage imageNamed:@"comments_agree"];
		UIImageView *imageView = [self.agreeButton viewWithTag:100];
		imageView.image = self.agreeImageView.image = image;
		self.detailsModel.hasClickLike = YES;
	} else {
		likeCount--;
		UIImage *image = [UIImage imageNamed:@"comments_unagree"];
		UIImageView *imageView = [self.agreeButton viewWithTag:100];
		imageView.image = self.agreeImageView.image = image;
		self.detailsModel.hasClickLike = NO;
	}
	_detailsModel.clickLikeTotal = likeCount;
	if (_detailsModel.clickLikeTotal == 0) {
		[self.agreeButton setTitle:@"" forState:UIControlStateNormal];
	} else {
		[self.agreeButton setTitle:[NSString stringWithFormat:@"%zd",_detailsModel.clickLikeTotal] forState:UIControlStateNormal];
	}
	if ([self.delegate respondsToSelector:@selector(supplySectionHeaderView:agreeButtonAction:)]) {
		[self.delegate supplySectionHeaderView:self agreeButtonAction:isAgree];
	}
}

/**
 评论按钮点击事件
 */
- (void) commentButtonAction:(UIButton *)button {
	if ([self.delegate respondsToSelector:@selector(supplySectionHeaderViewTapCommentAction:)]) {
		[self.delegate supplySectionHeaderViewTapCommentAction:self];
	}
}

@end
