//
//  BadgeNumModel.h
//  TaSayProject
//
//  Created by Mac on 15/8/17.
//  Copyright (c) 2015年 xubin. All rights reserved.
//

#import <Foundation/Foundation.h>
#define BadgeMODEL [BadgeNumModel shareBadgeNumModel]

@interface BadgeNumModel : NSObject

@property(nonatomic)int lookMeNum; //查看我的
@property(nonatomic)int commentMeNum ; //评论我的
@property(nonatomic)int chatNum; //聊天
@property(nonatomic)int curriculumNum;//简历数
@property(nonatomic)int forumAnswer;//收到回复
@property(nonatomic)int forumQuestion;//未回复问题
@property(nonatomic,strong)NSMutableArray *headArr;

+(BadgeNumModel*)shareBadgeNumModel;

-(void)setBadgeForKey:(NSDictionary *)badgeDic;
-(int)getSumNum;
//-(void)removeBadge;
@end
