//
//  InfoHoldNetWorkData+SkillExchangeNetWorkData.m
//  SkillExchange
//
//  Created by xu bin on 15/3/10.
//  Copyright (c) 2015年 xubin. All rights reserved.
//

#import "InfoHoldNetWorkData+MiaoTuNetWorkData.h"

@implementation InfoHoldNetWorkData (MiaoTuNetWorkData)

-(void)getlogin:(NSString *)Account password:(NSString *)password{
    
    self.tag=IH_User_Login;
   
    
    NSDictionary* paramDic = [NSDictionary dictionaryWithObjectsAndKeys:
                             Account,@"account",
                              password,@"password",
                              nil];
    [self httpRequestWithParameter:paramDic method:@"user/login"];
}

@end
