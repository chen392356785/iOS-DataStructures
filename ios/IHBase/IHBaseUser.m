//
//  IHBaseUser.m
//  IHBaseProject
//
//  Created by yaoyongping on 13-1-7.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "IHBaseUser.h"
static IHBaseUser *user=nil;

@implementation IHBaseUser

+(IHBaseUser*)shareUserModel
{
	@synchronized(self){
		if (user == nil) {
			user = [[IHBaseUser alloc] init];
		}
	}
    return user;
}

-(void)setUserInfo:(NSDictionary *)dic{
    
    self.userID = stringFormatString(dic[@"user_id"]);
    self.token = dic[@"authorization"];
    self.userHeadImge40 = [NSString stringWithFormat:@"%@%@%@",ConfigManager.ImageUrl, dic[@"heed_image_url"],smallHeaderImage];
    self.userHeadImge80=[NSString stringWithFormat:@"%@%@%@",ConfigManager.ImageUrl, dic[@"heed_image_url"],smallHeaderImage];
    self.userHeadImge=[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,dic[@"heed_image_url"]];
    self.hxPassword=dic[@"hx_password"];
    self.hxUserName=[dic[@"hx_user_name"] lowercaseString];
    self.nickName=dic[@"nickname"];
    self.sex=[dic[@"sexy"]intValue];
    self.userName=dic[@"user_name"];
    self.hyTypeID=[dic[@"i_type_id"]intValue];
    self.isLogin=YES;
    self.identity_key=[[dic objectForKey:@"identity_key"]intValue];
    self.map_callout=[dic[@"map_callout"]intValue];
    self.user_authentication=[dic[@"user_authentication"] intValue];
    self.mobile=dic[@"mobile"];
    self.auth_status = [dic[@"auth_status"] intValue];
    self.userHeadImgPath = [NSString stringWithFormat:@"%@", dic[@"heed_image_url"]];
    self.isDue = [dic[@"isDue"] intValue];
    
}


-(void)removeUserModel{
	USERMODEL.userID = @"";
	USERMODEL.token = @"";
	USERMODEL.sex = 0;
	USERMODEL.userHeadImge = @"";
	USERMODEL.userHeadImge40 = @"";
	USERMODEL.userHeadImge80 = @"";
	USERMODEL.hxPassword = @"";
	USERMODEL.nickName = @"";
	USERMODEL.userID = @"";
	USERMODEL.user_authentication = 0;
	USERMODEL.hyTypeID = 0;
	USERMODEL.isLogin = NO;
	USERMODEL.identity_key = 1;
	USERMODEL.mobile = @"";
	USERMODEL.auth_status = 0;
	USERMODEL.isDue = 0;
	NSUserDefaults *userDefaluts = [NSUserDefaults standardUserDefaults];
	[userDefaluts removeObjectForKey:kUserDefalutLoginInfo];
	[userDefaluts removeObjectForKey:@"DFID"];      //退出识花
	[userDefaluts removeObjectForKey:KUserInfoDataDic];
	[userDefaluts synchronize];
    
}



@end
