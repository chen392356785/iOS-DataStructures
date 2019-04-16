//
//  MTNewSupplyAndBuyDetailsViewController.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/7/20.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"
#import "InputKeyBoardView.h"
#import "GongQiuCommentDelegate.h"
#import "GongQiuAgreeDelegate.h"
@class SDTimeLineCell;
@interface MTNewSupplyAndBuyDetailsViewController : SMBaseViewController<GongQiuAgreeDelegate,GongQiuCommentDelegate>
@property(nonatomic)buyType type;
@property(nonatomic,strong) NSString *newsId;
@property(nonatomic,strong) NSString *userId;
@property(nonatomic,strong) MTNewSupplyAndBuyListModel *model;
@property(nonatomic,weak) id<GongQiuAgreeDelegate>delegate;
@property(nonatomic,weak) id<GongQiuCommentDelegate>commentDelegate;
@property(nonatomic,strong) NSIndexPath *indexPath;
@property(nonatomic,copy) DidSelectDeleteBlock selectDeleteBlock;
@property(nonatomic)BOOL isReply; //是否是回复
@property(nonatomic)BOOL isBeginComment; //是否开始评论
@property(nonatomic,strong) SDTimeLineCell *cell;
//@property(nonatomic)BOOL hasCollection;//是否已收藏

@end
