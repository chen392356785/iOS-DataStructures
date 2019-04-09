//
//  BadgeNumModel.m
//  TaSayProject
//
//  Created by Mac on 15/8/17.
//  Copyright (c) 2015年 xubin. All rights reserved.
//

#import "BadgeNumModel.h"

static BadgeNumModel *badge=nil;
@implementation BadgeNumModel

+(BadgeNumModel*)shareBadgeNumModel
{
    @synchronized(self){
        if (badge == nil) {
            badge = [[BadgeNumModel alloc] init];
            badge.headArr=[[NSMutableArray alloc]init];
        }
    }
    return badge;
}

-(int)getSumNum{
    int sum=BadgeMODEL.chatNum+BadgeMODEL.commentMeNum+BadgeMODEL.lookMeNum;
    
    return sum;
}

-(void)setBadgeForKey:(NSDictionary *)badgeDic{
    BadgeMODEL.commentMeNum=[badgeDic[@"badgeCommentMe"]intValue];
    BadgeMODEL.headArr=[badgeDic objectForKey:@"headArr"];
    BadgeMODEL.chatNum=[badgeDic[@"badgeChat"]intValue];
    BadgeMODEL.lookMeNum=[[badgeDic objectForKey:@"badgelookMe"]intValue];
    BadgeMODEL.forumAnswer=[badgeDic[@"forumAnswer"] intValue];
    BadgeMODEL.forumQuestion=[badgeDic[@"forumQuestion"] intValue];
}

//-(void)removeBadge{
//    BadgeMODEL.commentMeNum=0;
//    BadgeMODEL.chatNum=0;
//    BadgeMODEL.lookMeNum=0;
//    BadgeMODEL.forumAnswer=0;
//    BadgeMODEL.forumQuestion=0;
//}


@end
