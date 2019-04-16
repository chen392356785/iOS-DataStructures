//
//  MTCommentTableViewCell.h
//  MiaoTuProject
//
//  Created by dzb on 2019/4/12.
//  Copyright © 2019 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MTCommentTableViewCellDelegate;
@class MTCommentListModel;

@interface MTCommentTableViewCell : UITableViewCell

///contentLabel
@property (nonatomic,strong) UILabel *contentLabel;
///commentModel
@property (nonatomic,strong) MTCommentListModel *commentModel;
///delegate
@property (nonatomic,weak) id <MTCommentTableViewCellDelegate> delegate;


@end

NS_ASSUME_NONNULL_END


@protocol MTCommentTableViewCellDelegate <NSObject>

@optional

/**
 点击了评论上用户名昵称 跳转到个人中心
 */
- (void) commentCell:(MTCommentTableViewCell *_Nullable)cell
	 tapUserNickname:(NSString *_Nullable)nickname
			  userId:(NSInteger )userId;

/**
 删除评论或者回复
 */
- (void) commentCell:(MTCommentTableViewCell *_Nullable)cell
	   deleteComment:(MTCommentListModel *_Nullable)commentModel;

@end

