//
//  AppUserSettings.h
//  MinshengBank_Richness
//
//  Created by infohold mac1 on 11-11-17.
//  Copyright 2011 infohold. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef enum{
	keyType_NumberDefault,//默认的数字键盘，什么都没有
	keyType_IDNumber,//用户身份证
	keyType_AmountNumber,//用户金额的输入
	keyType_FinishDefault,//添加完成按钮，适合与数字键盘和非数字键盘
	keyType_NextDefault//添加下一个按钮，适合与数字键盘和非数字键盘
} KeyBoardType;




@interface AppUserModel : NSObject {
	NSString *userName;
    
    
    
}
@property(nonatomic,retain)NSString *userName;
@end



@interface AppUserSettings : NSObject {
	AppUserModel *User;
    
	BOOL hideDoneButton;
}

@property(nonatomic,retain) AppUserModel *User;

@property(assign) BOOL hideDoneButton;

//-(void)User:(AppUserModel *)user;

+(AppUserSettings *)usersettings;
+(UITextField *)CURRENTACTIVITYFIELD;
+(void)SETCURRENTACTIVITYFIELD:(UITextField *)field;
+(void)SETCURRENTACTIVITYTEXTVIEW:(UITextView *)textview;
+(void)SETCURRENTSEARCHBAR:(UISearchBar *)searchBar;
//+(void)REGISTERKEYBOARDEVENT;
+(void)KEYBOARDWILLSHOWDELAY:(NSNotification *)notification;
+(BOOL)ISSHOWKEYBOARD;

//+(void)SetCurrentActivityField:(UITextField *)field  KeyType:(KeyBoardType)KeyType;
//+(void)SetCurrentActivityField:(UITextField *)field  KeyType:(KeyBoardType)KeyType NextField:(UITextField *)NextField;

+(void)doneButton;

//+(void)setDoneButtonHidden:(BOOL)hidden;

@end
