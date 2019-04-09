//
//  MTNetworkData+AskBarData.h
//  MiaoTuProject
//
//  Created by Zmh on 2/11/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTNetworkData.h"

@interface MTNetworkData (AskBarData)
#pragma mark - 问吧详情
- (void)getAskBarDetailWithID:(int)form_id
                      success:(void (^)(NSDictionary *obj))success
                      failure:(void (^)(NSDictionary *obj2))failure;




#pragma mark - 已回复列表（最新与最热）
- (void)loadReplyProblemList:(int)type
              forum_topic_id:(int)forum_topic_id
                     user_id:(int)user_id
                        page:(int)page
                         num:(int)num
                     success:(void (^)(NSDictionary *obj))success
                     failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark - 未回复列表
- (void)loadNoReplyProblemList:(int)forum_topic_id
                        page:(int)page
                         num:(int)num
                     success:(void (^)(NSDictionary *obj))success
                     failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark - 评论列表
- (void)loadAnswerCommentList:(int)answer_id
                      user_id:(int)user_id
                         page:(int)page
                          num:(int)num
                      success:(void (^)(NSDictionary *obj))success
                      failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark - 发布问题
- (void)sendProblemWith:(int)forum_topic_id
                  title:(NSString *)title
                success:(void (^)(NSDictionary *obj))success
                failure:(void (^)(NSDictionary *obj2))failure;


#pragma mark - 针对回复点赞
- (void)agreeAnswerWith:(int)answer_id
                success:(void (^)(NSDictionary *obj))success
                failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark - 针对网友评论点赞
- (void)agreeCommentWith:(int)comment_id
                 success:(void (^)(NSDictionary *obj))success
                 failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark - 发布评论
- (void)addAnswerComment:(int)forum_answer_id
         comment_content:(NSString *)comment_content
                province:(NSString *)province
                 success:(void (^)(NSDictionary *obj))success
                 failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark - 忽略问题
- (void)ignoreQuestionWithID:(int)question_id
                     success:(void (^)(NSDictionary *obj))success
                     failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark - 回复问题
- (void)replyQuestionWith:(int)question_id
           answer_content:(NSString *)answer_content
           forum_topic_id:(int)forum_topic_id
                  success:(void (^)(NSDictionary *obj))success
                  failure:(void (^)(NSDictionary *obj2))failure;

#pragma mark -删除未恢复的问题
- (void)deleteNoReplyQuestion:(int)question_id
                      success:(void (^)(NSDictionary *obj))success
                      failure:(void (^)(NSDictionary *obj2))failure;
@end
