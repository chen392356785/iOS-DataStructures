//
//  MTTopicDetailsViewController.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/4/1.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"
#import "InputKeyBoardView.h"

@protocol MTTopicAgreeDelegate <NSObject>

@optional
- (void)disPlayTopicAgree:(MTTopicListModel *)model indexPath:(NSIndexPath *)indexPath;

//添加评论
- (void)disPlayTopicComment:(MTTopicListModel *)model indexPath:(NSIndexPath *)indexPath;
@end

@interface MTTopicDetailsViewController : SMBaseViewController<HJCActionSheetDelegate,MTTopicAgreeDelegate>{
    UITextField *_pltxt;
    InputKeyBoardView *_keyBoardView;
     NSIndexPath *_selIndexPath;
    AgreeView *_agreeView;
    NSMutableArray *agreeArr;
}
@property(nonatomic)BOOL isBeginComment; //是否开始评论
@property(nonatomic)BOOL isReply; //是否是回复 
@property(nonatomic,strong)MTTopicListModel *model;
@property(nonatomic,weak)id<MTTopicAgreeDelegate>delegate;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property (nonatomic,copy)NSString *topicTitle;
@property (nonatomic,copy)NSString *subTitle;
@property (nonatomic,copy)NSString *topicType;
@end
