//
//  AskProblemDetailViewController.h
//  MiaoTuProject
//
//  Created by Zmh on 31/10/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"

@protocol AgreeAnswerDelegate <NSObject>
@optional

-(void)disPlayAgree:(ReplyProblemListModel *)model indexPath:(NSIndexPath *)indexPath;
- (void)deleteNoReplyQuestion:(ReplyProblemListModel *)model indexPath:(NSIndexPath *)indexPath;

@end

@interface AskProblemDetailViewController : SMBaseCustomViewController
@property (nonatomic,strong)ReplyProblemListModel *model;
@property (nonatomic,copy)NSString *answer_id;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,weak)id<AgreeAnswerDelegate>delegate;
@property (nonatomic,assign) CGFloat alpha;
@end
