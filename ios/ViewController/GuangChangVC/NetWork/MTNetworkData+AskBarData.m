//
//  MTNetworkData+AskBarData.m
//  MiaoTuProject
//
//  Created by Zmh on 2/11/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTNetworkData+AskBarData.h"

@implementation MTNetworkData (AskBarData)

#pragma mark - 问吧详情
- (void)getAskBarDetailWithID:(int)form_id
                      success:(void (^)(NSDictionary *obj))success
                      failure:(void (^)(NSDictionary *obj2))failure
{
//    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:stringFormatInt(form_id),@"forum_topic_id",
//                                            nil];
    [self httpRequestTagWithParameter:nil method:[NSString stringWithFormat:@"Forum/selectForumTopicDetail/%d",form_id] tag:IH_AskBarDetail success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
}


#pragma mark - 已回复列表（最新与最热）
- (void)loadReplyProblemList:(int)type
              forum_topic_id:(int)forum_topic_id
                     user_id:(int)user_id
                        page:(int)page
                         num:(int)num
                     success:(void (^)(NSDictionary *obj))success
                     failure:(void (^)(NSDictionary *obj2))failure
{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                    stringFormatInt(forum_topic_id),@"forum_topic_id",stringFormatInt(type),@"type",
                        stringFormatInt(user_id),@"user_id",
                        stringFormatInt(page),@"page",
                        stringFormatInt(num),@"num",
                        nil];
    
    [self httpRequestTagWithParameter:dic2 method:@"Forum/questionWithAnswer" tag:IH_replyProblemList success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
}

#pragma mark - 未回复列表
- (void)loadNoReplyProblemList:(int)forum_topic_id
                          page:(int)page
                           num:(int)num
                       success:(void (^)(NSDictionary *obj))success
                       failure:(void (^)(NSDictionary *obj2))failure
{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                    stringFormatInt(forum_topic_id),@"forum_topic_id",
                        stringFormatInt(page),@"page",
                        stringFormatInt(num),@"num",
                        nil];
    
    [self httpRequestTagWithParameter:dic2 method:@"Forum/questionWithOutAnswerList" tag:IH_replyProblemList success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
}

#pragma mark - 评论列表
- (void)loadAnswerCommentList:(int)answer_id
                      user_id:(int)user_id
                          page:(int)page
                           num:(int)num
                       success:(void (^)(NSDictionary *obj))success
                       failure:(void (^)(NSDictionary *obj2))failure
{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(answer_id),@"question_id",
                        stringFormatInt(user_id),@"user_id",
                        stringFormatInt(page),@"page",
                        stringFormatInt(num),@"num",
                        nil];
    
    [self httpRequestTagWithParameter:dic2 method:@"Forum/answerCommentList" tag:IH_answerCommentList success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
}

#pragma mark - 发布问题
- (void)sendProblemWith:(int)forum_topic_id
                         title:(NSString *)title
                      success:(void (^)(NSDictionary *obj))success
                      failure:(void (^)(NSDictionary *obj2))failure
{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(forum_topic_id),@"forum_topic_id",
                        USERMODEL.userID,@"user_id",
                        title,@"title",
                        @"0",@"id",
                        nil];
    
    [self httpRequestWithParameter:dic2 method:@"Forum/addForumQuestion" success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
}

#pragma mark - 针对回复点赞
- (void)agreeAnswerWith:(int)answer_id
                success:(void (^)(NSDictionary *obj))success
                failure:(void (^)(NSDictionary *obj2))failure
{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(answer_id),@"answer_id",
                        USERMODEL.userID,@"user_id",
                        nil];
    
    [self httpRequestWithParameter:dic2 method:@"Forum/addAnswerClickLike" success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
}

#pragma mark - 针对网友评论点赞
- (void)agreeCommentWith:(int)comment_id
                success:(void (^)(NSDictionary *obj))success
                failure:(void (^)(NSDictionary *obj2))failure
{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(comment_id),@"comment_id",
                        USERMODEL.userID,@"user_id",
                        nil];
    
    [self httpRequestWithParameter:dic2 method:@"Forum/addCommentClickLike" success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
}

#pragma mark - 发布评论
- (void)addAnswerComment:(int)forum_answer_id
                   comment_content:(NSString *)comment_content
                province:(NSString *)province
                success:(void (^)(NSDictionary *obj))success
                failure:(void (^)(NSDictionary *obj2))failure
{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(forum_answer_id),@"forum_answer_id",
                        USERMODEL.userID,@"user_id",
                        comment_content,@"comment_content",
                        province,@"province",
                        @"0",@"id",
                        nil];
    
    [self httpRequestWithParameter:dic2 method:@"Forum/addForumAnswerComment" success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
}

#pragma mark - 忽略问题
- (void)ignoreQuestionWithID:(int)question_id
                      success:(void (^)(NSDictionary *obj))success
                      failure:(void (^)(NSDictionary *obj2))failure
{
    
    [self httpRequestWithParameter:nil method:[NSString stringWithFormat:@"Forum/ignoreQuestion/%d",question_id] success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
}

#pragma mark - 回复问题
- (void)replyQuestionWith:(int)question_id
         answer_content:(NSString *)answer_content
                forum_topic_id:(int)forum_topic_id
                 success:(void (^)(NSDictionary *obj))success
                 failure:(void (^)(NSDictionary *obj2))failure
{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        stringFormatInt(forum_topic_id),@"forum_topic_id",
                        USERMODEL.userID,@"user_id",
                        answer_content,@"answer_content",
                        stringFormatInt(question_id),@"question_id",
                        @"0",@"id",
                        nil];
    
    [self httpRequestWithParameter:dic2 method:@"Forum/replyQuestion" success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
}

#pragma mark -删除未恢复的问题
- (void)deleteNoReplyQuestion:(int)question_id
                      success:(void (^)(NSDictionary *obj))success
                      failure:(void (^)(NSDictionary *obj2))failure
{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        USERMODEL.userID,@"user_id",
                        stringFormatInt(question_id),@"question_id",
                        nil];
    
    [self httpRequestWithParameter:dic2 method:@"Forum/deleteQuestionById" success:^(NSDictionary * dic) {
        success(dic);
    } failure:^(NSDictionary * dic) {
        failure(dic);
    }];
}
@end
