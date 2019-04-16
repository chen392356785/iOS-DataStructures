//
//  MTSupplySectionHeaderView.h
//  MiaoTuProject
//
//  Created by dzb on 2019/4/12.
//  Copyright © 2019 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MTSupplyDetailsModel;
@protocol MTSupplySectionHeaderViewDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface MTSupplySectionHeaderView : UITableViewHeaderFooterView

///detailsModel
@property (nonatomic,strong) MTSupplyDetailsModel *detailsModel;
///agreeList
@property (nonatomic,strong) NSArray <NSDictionary *> *agreeList;
///delegate
@property (nonatomic,weak) id<MTSupplySectionHeaderViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END

@protocol MTSupplySectionHeaderViewDelegate <NSObject>

@optional

/**
 tap nickname action
 */
- (void) supplySectionHeaderView:(MTSupplySectionHeaderView *_Nullable)headerView
		   tapUserNicknameAction:(NSString *_Nullable)nickname
						  userid:(NSInteger)userid;

/**
 点赞按钮点击事件
 */
- (void) supplySectionHeaderView:(MTSupplySectionHeaderView *_Nullable)headerView agreeButtonAction:(BOOL)isLike;


/**
 评论按钮点击事件
 */
- (void) supplySectionHeaderViewTapCommentAction:(MTSupplySectionHeaderView *_Nullable)headerView;


@end
