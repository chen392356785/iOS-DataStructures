//
//  MTCommentTableViewCell.m
//  MiaoTuProject
//
//  Created by dzb on 2019/4/12.
//  Copyright © 2019 听花科技. All rights reserved.
//

#import "Masonry.h"
#import "UILabel+YVAdd.h"
#import "MTCommentListModel.h"
#import "MTCommentTableViewCell.h"
#import "NSAttributedString+YVText.h"

@implementation MTCommentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		self.contentView.backgroundColor = RGB(247.0f, 247.0f, 247.0f);
		[self.contentView addSubview:self.contentLabel];
		[self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
			make.top.equalTo(self.contentView.mas_top).offset(15.0f);
			make.left.equalTo(self.contentView.mas_left).offset(14.0f);
			make.right.equalTo(self.contentView.mas_right).offset(-14.0f);
			make.height.mas_greaterThanOrEqualTo(15.0f);
			make.bottom.equalTo(self.contentView.mas_bottom);
		}];
		UILongPressGestureRecognizer *tap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(tapCellAction:)];
		[self.contentView addGestureRecognizer:tap];
	}
	return self;
}

- (UILabel *)contentLabel {
	if (!_contentLabel) {
		_contentLabel = [[UILabel alloc] init];
		_contentLabel.numberOfLines = 0;
		_contentLabel.font = [UIFont systemFontOfSize:14.0f];
	}
	return _contentLabel;
}

- (void)setCommentModel:(MTCommentListModel *)commentModel {
	_commentModel = commentModel;
	
	NSArray *nameArray = @[];
	NSArray *userIdArray = @[];
	//评论详情
	if ([_commentModel.replyCommentId isEqualToString:@"0"]) {
		NSString *nickname = _commentModel.userChildrenInfo.nickname;
		NSString *content = _commentModel.commentCotent;
		NSString *totalString = [NSString stringWithFormat:@"%@: %@",nickname,content];
		NSAttributedString *string = [NSAttributedString ls_changeCorlorWithColor:RGB(0, 148.0f, 143.0f) TotalString:totalString SubStringArray:@[nickname]];
		self.contentLabel.attributedText = string;
		nameArray = @[nickname];
		userIdArray = @[@(_commentModel.userChildrenInfo.userId)];
	} else { ///评论回复
		NSString *nickname = _commentModel.userChildrenInfo.nickname;
		NSString *replyNickname = _commentModel.replyNickname;
		NSString *content = _commentModel.commentCotent;
		NSString *totalString = [NSString stringWithFormat:@"%@ 回复 %@: %@",nickname,replyNickname,content];
		NSAttributedString *string = [NSAttributedString ls_changeCorlorWithColor:RGB(0, 148.0f, 143.0f) TotalString:totalString SubStringArray:@[nickname,replyNickname]];
		self.contentLabel.attributedText = string;
		nameArray = @[nickname,replyNickname];
		userIdArray = @[@(_commentModel.userChildrenInfo.userId),@(_commentModel.replyUserId)];
	}
	
	__weak typeof(self)weakSelf = self;
	[self.contentLabel yb_addAttributeTapActionWithStrings:nameArray tapClicked:^(NSString * _Nonnull string, NSRange range, NSInteger index) {
		NSInteger userid = [[userIdArray objectAtIndex:index] integerValue];
		__strong typeof(weakSelf)strongSelf = weakSelf;
		if ([strongSelf.delegate respondsToSelector:@selector(commentCell:tapUserNickname:userId:)]) {
			[strongSelf.delegate commentCell:strongSelf tapUserNickname:string userId:userid];
		}
	}];
	
}

- (void) tapCellAction:(UITapGestureRecognizer *)tap {
	
	BOOL isSelfComment = USERMODEL.userID.integerValue == self.commentModel.userChildrenInfo.userId;
	if (tap.state == UIGestureRecognizerStateBegan && isSelfComment) {
		[self becomeFirstResponder];
		UIMenuItem * item1 = [[UIMenuItem alloc]initWithTitle:@"删除" action:@selector(deleteClick:)];
		UIMenuController *menuController = [UIMenuController sharedMenuController];
		if (menuController.isMenuVisible)return;
		menuController.menuItems = @[item1];
		[menuController setTargetRect:CGRectMake(self.contentView.frame.size.height*0.5f, self.contentView.frame.size.height*0.5f,self.contentView.frame.size.width,self.contentView.frame.size.height) inView:self.contentView];
		[menuController setMenuVisible:YES animated:YES];
	}
	
}

- (void) deleteClick:(UIMenuController *)item {
	if ([self.delegate respondsToSelector:@selector(commentCell:deleteComment:)]) {
		[self.delegate commentCell:self deleteComment:self.commentModel];
	}
}

#pragma mark - 对控件权限进行设置
/**
 *  设置label可以成为第一响应者
 *
 *  @注意：不是每个控件都有资格成为第一响应者
 */
- (BOOL)canBecomeFirstResponder
{
	return YES;
}
/**
 *  设置label能够执行那些具体操作
 *
 *  @param action 具体操作
 *
 *  @return YES:支持该操作
 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
	if(action == @selector(deleteClick:))
		return YES;
	else
		return NO;
}


@end



