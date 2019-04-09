//
//  GongQiuDetailsViewController.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/3/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"
#import "InputKeyBoardView.h"
#import "GongQiuCommentDelegate.h"
#import "GongQiuAgreeDelegate.h"
@interface GongQiuDetailsViewController : SMBaseViewController<UITableViewDelegate,GongQiuAgreeDelegate,GongQiuCommentDelegate>
{
    UITextField *_pltxt;
    InputKeyBoardView *_keyBoardView;
    NSIndexPath *_selIndexPath;
    AgreeView *_agreeView;
    NSMutableArray *agreeArr;
}
@property(nonatomic)BOOL isReply; //是否是回复
@property(nonatomic)BOOL isBeginComment; //是否开始评论
@property(nonatomic,strong)MTSupplyAndBuyListModel *model;
@property(nonatomic,weak)id<GongQiuAgreeDelegate>delegate;
@property(nonatomic,weak)id<GongQiuCommentDelegate>commentDelegate;
@property(nonatomic)buyType type;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,copy)DidSelectDeleteBlock selectDeleteBlock;
@end
