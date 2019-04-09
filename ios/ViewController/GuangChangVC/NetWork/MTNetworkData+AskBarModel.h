//
//  MTNetworkData+AskBarModel.h
//  MiaoTuProject
//
//  Created by Zmh on 2/11/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTNetworkData.h"

@interface MTNetworkData (AskBarModel)
#pragma mark - 问吧详情
- (NSDictionary *)getAskBarDetailModel:(NSDictionary *)dic;

#pragma mark - 问吧详情问题列表
- (NSDictionary *)getReplyProblemList:(NSDictionary *)dic;

#pragma mark - 问吧评论列表
- (NSDictionary *)getAnswerCommentList:(NSDictionary *)dic;
@end
