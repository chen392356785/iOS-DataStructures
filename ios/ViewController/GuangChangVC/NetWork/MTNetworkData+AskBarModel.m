//
//  MTNetworkData+AskBarModel.m
//  MiaoTuProject
//
//  Created by Zmh on 2/11/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTNetworkData+AskBarModel.h"

@implementation MTNetworkData (AskBarModel)

#pragma mark - 问吧详情
- (NSDictionary *)getAskBarDetailModel:(NSDictionary *)dic
{
    NSDictionary* Dic = [dic objectForKey:@"content"];

    AskBarDetailModel *model = [[AskBarDetailModel alloc] initWithDictionary:Dic error:nil];
    model.form_id = [NSString stringWithFormat:@"%@",Dic[@"id"]];
    model.Description = [NSString stringWithFormat:@"%@",Dic[@"description"]];
    model.heed_image_url=[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,model.heed_image_url];
    model.show_pic = [NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,model.show_pic];
    model.detailed_pic = [NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,model.detailed_pic];
    
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:model forKey:@"content"];
    
    return dic2;

}

#pragma mark - 问吧详情问题列表
- (NSDictionary *)getReplyProblemList:(NSDictionary *)dic
{
    NSArray *Arr = dic[@"content"];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSDictionary *Dic in Arr) {
        ReplyProblemListModel *model = [[ReplyProblemListModel alloc] initWithDictionary:Dic error:nil];
        model.reply_id = [NSString stringWithFormat:@"%@",Dic[@"id"]];
        model.heed_image_url=[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,model.heed_image_url];
        
        //回复详情数据
        AnswerInfoModel *infoModel = [[AnswerInfoModel alloc] initWithDictionary:Dic[@"answerInfo"] error:nil];
        infoModel.answer_id = [NSString stringWithFormat:@"%@",Dic[@"answerInfo"][@"id"]];
        infoModel.heed_image_url=[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,infoModel.heed_image_url];
        model.infoModel = infoModel;
        
        [array addObject:model];
    }
    
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:array forKey:@"content"];
    
    return dic2;
}

#pragma mark - 问吧评论列表
- (NSDictionary *)getAnswerCommentList:(NSDictionary *)dic
{
    NSArray *Arr = dic[@"content"][@"comment"];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSDictionary *Dic in Arr) {
        AnswerCommentListModel *model = [[AnswerCommentListModel alloc] initWithDictionary:Dic error:nil];
        model.comment_id = [NSString stringWithFormat:@"%@",Dic[@"id"]];
        model.heed_image_url=[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,model.heed_image_url];
        [array addObject:model];
    }
    //问题数据
    NSDictionary *Dic = dic[@"content"][@"question"];
    ReplyProblemListModel *listModel = [[ReplyProblemListModel alloc] initWithDictionary:Dic error:nil];
    listModel.reply_id = [NSString stringWithFormat:@"%@",Dic[@"id"]];
    listModel.heed_image_url=[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,listModel.heed_image_url];
    
    NSDictionary *Dic2 = dic[@"content"][@"answer"];
    //回复详情数据
    AnswerInfoModel *infoModel = [[AnswerInfoModel alloc] initWithDictionary:Dic2 error:nil];
    infoModel.answer_id = [NSString stringWithFormat:@"%@",Dic2[@"id"]];
    infoModel.heed_image_url=[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,infoModel.heed_image_url];
    listModel.infoModel = infoModel;
    
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:array forKey:@"content"];
    [dic2 setObject:listModel forKey:@"question"];
    
    return dic2;
}
@end
