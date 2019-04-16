//
//  AppUserSettings.m
//  MinshengBank_Richness
//
//  Created by infohold mac1 on 11-11-17.
//  Copyright 2011 infohold. All rights reserved.
//

#import "JLUserSettings.h"

@implementation AppUserModel
@synthesize userName;



@end

@implementation AppUserSettings
@synthesize User, hideDoneButton;

static AppUserSettings *settings;
static UITextField *CURRENTACTIVITYTEXTFIELD=nil;
static UITextView *CURRENTACTIVITYTEXTVIEW=nil;
static UISearchBar *CURRENTACTIVITYSEARCHBAR=nil;
static BOOL ISSHOWKEYBOARD;
static KeyBoardType m_keyBoardType;
static UITextField *m_NextTextField;

//static CGSize kbSize;

+(AppUserSettings *)usersettings
{
    
    if (settings==nil)
    {
        settings=[[self alloc] init];
        settings.hideDoneButton = NO;
    }
    
	
	return settings;
}

//-(void)User:(AppUserModel *)user
//{
//	settings.User=user;
//}

+(UITextField *)CURRENTACTIVITYFIELD{
	return CURRENTACTIVITYTEXTFIELD;
}

+(UITextView *)CURRENTACTIVITYTEXTVIEW{
	return CURRENTACTIVITYTEXTVIEW;
}


+(UISearchBar *)CURRENTACTIVITYSEARCHBAR{
	return CURRENTACTIVITYSEARCHBAR;
}


+(void)SETCURRENTACTIVITYFIELD:(UITextField *)field{
	CURRENTACTIVITYTEXTFIELD=field;
    m_keyBoardType=keyType_NumberDefault;
    
    
    if ([AppUserSettings ISSHOWKEYBOARD]) {
		[AppUserSettings KEYBOARDWILLSHOWDELAY:nil];
	}
}

+(void)SETCURRENTACTIVITYTEXTVIEW:(UITextView *)textview{
	CURRENTACTIVITYTEXTVIEW=textview;
    
    if ([AppUserSettings ISSHOWKEYBOARD]) {
		[AppUserSettings KEYBOARDWILLSHOWDELAY:nil];
	}
}
+(void)SETCURRENTSEARCHBAR:(UISearchBar *)searchBar{
	CURRENTACTIVITYSEARCHBAR=searchBar;
	if ([AppUserSettings ISSHOWKEYBOARD]) {
		[AppUserSettings KEYBOARDWILLSHOWDELAY:nil];
	}
}

//+(void)SetCurrentActivityField:(UITextField *)field  KeyType:(KeyBoardType)KeyType
//{
//	m_keyBoardType = KeyType;
//	CURRENTACTIVITYTEXTFIELD=field;
//
//
//    //屏蔽输入金额键盘 lixj
//    if (m_keyBoardType == keyType_AmountNumber) {
//        m_keyBoardType = keyType_NumberDefault;
//        field.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
//    }
//    //屏蔽输入金额键盘 lixj
//
//
//    if ([AppUserSettings ISSHOWKEYBOARD]) {
//		[AppUserSettings KEYBOARDWILLSHOWDELAY:nil];
//	}
//
//}

//+(void)SetCurrentActivityField:(UITextField *)field  KeyType:(KeyBoardType)KeyType NextField:(UITextField *)NextField
//{
//	m_keyBoardType = KeyType;
//	CURRENTACTIVITYTEXTFIELD=field;
//	m_NextTextField = NextField;
//
//
//    //屏蔽输入金额键盘 lixj
//    if (m_keyBoardType == keyType_AmountNumber) {
//        m_keyBoardType = keyType_NumberDefault;
//        field.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
//    }
//    //屏蔽输入金额键盘 lixj
//
//
//    if ([AppUserSettings ISSHOWKEYBOARD]) {
//		[AppUserSettings KEYBOARDWILLSHOWDELAY:nil];
//	}
//}


+(BOOL)ISSHOWKEYBOARD{
	return ISSHOWKEYBOARD;
}

//+(void)REGISTERKEYBOARDEVENT{
//    
//    static bool firstRun = YES;
//    if (firstRun) {
//        firstRun = NO;
//        kbSize = CGSizeMake(320, 216);
//    }
//    
//	[[NSNotificationCenter defaultCenter] addObserver:self
//											 selector:@selector(KEYBOARDWILLSHOWDELAY:)
//												 name:UIKeyboardDidShowNotification
//											   object:nil];
//	[[NSNotificationCenter defaultCenter] addObserver:self
//											 selector:@selector(KEYBOARDHIDE:)
//												 name:UIKeyboardWillHideNotification
//											   object:nil];
//    
//    
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 5.0f)
//    {
//        
//		/*
//         [[NSNotificationCenter defaultCenter] addObserver:self
//         selector:@selector(KEYBOARDFRAMECHANGE:)
//         name:UIKeyboardWillChangeFrameNotification
//         object:nil];
//		 
//         */
//    }
//    
//}

+(void)KEYBOARDHIDE:(NSNotification *)notification{
	ISSHOWKEYBOARD=NO;
    m_keyBoardType=keyType_NumberDefault;
	[AppUserSettings SETCURRENTACTIVITYFIELD:nil];
	[AppUserSettings SETCURRENTACTIVITYTEXTVIEW:nil];
	[AppUserSettings SETCURRENTSEARCHBAR:nil];
}

//+(void)KEYBOARDFRAMECHANGE:(NSNotification *)notification
//{
//    NSDictionary* info = [notification userInfo];
//    kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
//
//    //NSLog(@"\n change kbSize: w = %f, h = %f", kbSize.width, kbSize.height);
//}

/*
 显示键盘
 */
+(void)KEYBOARDWILLSHOWDELAY:(NSNotification *)notification{
    
	ISSHOWKEYBOARD=YES;
	UIView *foundKeyboard = nil;
    
    UIWindow *keyboardWindow = nil;
    
    
    //NSLog(@"\n show kbSize: w =%f, h=%f", kbSize.width, kbSize.height);
    
    for (UIWindow *testWindow in [[UIApplication sharedApplication] windows])
    {
        if (![[testWindow class] isEqual:[UIWindow class]])
        {
            keyboardWindow = testWindow;
            break;
        }
    }
    if (!keyboardWindow) return;
    for (UIView *possibleKeyboard in [keyboardWindow subviews])
    {
		NSLog([possibleKeyboard description],nil);
		
        //iOS3
        if ([[possibleKeyboard description] hasPrefix:@"<UIKeyboard"])
        {
            foundKeyboard = possibleKeyboard;
            break;
        }
        else
        {
            if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0f)
            {
                // iOS 4 sticks the UIKeyboard inside a UIPeripheralHostView.
                if ([[possibleKeyboard description] hasPrefix:@"<UIPeripheralHostView"])
                {
                    //for test
                    NSArray* array = [possibleKeyboard subviews];
                    for (UIView* view in array)
                    {
                        if ([[view description] hasPrefix:@"<UIKeyboard"])
                        {
                            foundKeyboard = view;
                            break;
                        }
                        
                        if(foundKeyboard)
                        {
                            break;
                        }
                    }
                }
            }
            else
            {
                // iOS 4 sticks the UIKeyboard inside a UIPeripheralHostView.
                if ([[possibleKeyboard description] hasPrefix:@"<UIPeripheralHostView"])
                {
//                    possibleKeyboard = [[possibleKeyboard subviews] objectAtIndex:0];
                }
                
                if ([[possibleKeyboard description] hasPrefix:@"<UIKeyboard"])
                {
                    //NSLog([possibleKeyboard description],nil);
                    foundKeyboard = possibleKeyboard;
                    break;
                }
            }
        }
    }
	
	for(UIView *m_view in [foundKeyboard subviews])
	{
		int m_tag = (int)m_view.tag;
		if (m_tag==100||m_tag==101)
		{
			//删除数字键盘情况下添加的自定义键盘
			[m_view removeFromSuperview];
		}
	}
	
	//添加返回按钮
	//UIView *donebuttonVIew=[[foundKeyboard superview] viewWithTag:101];
    //	if ([AppUserSettings usersettings].hideDoneButton == NO)
    //    {
    //		UIButton *doneButton = [[UIButton alloc] initWithFrame:CGRectMake(290, -22, 24,22)];;
    //		doneButton.frame = CGRectMake(6, -22, 24,22);
    //		doneButton.adjustsImageWhenHighlighted = NO;
    //		doneButton.tag = 101;
    //		[doneButton setBackgroundImage:[UIImage imageNamed:@"jianpan.png"] forState:UIControlStateNormal];
    //		[doneButton setBackgroundImage:[UIImage imageNamed:@"jianpan_action.png"] forState:UIControlStateHighlighted];
    //		[doneButton addTarget:self action:@selector(doneButton) forControlEvents:UIControlEventTouchUpInside];
    //		[[foundKeyboard superview] addSubview:doneButton];
    //        [doneButton release];
    //	}
	
	if (foundKeyboard && m_keyBoardType==keyType_NumberDefault)
    {
		//全数字键盘
		
	}
	else if (foundKeyboard &&m_keyBoardType==keyType_IDNumber)
	{
		//为身份证定制的键盘
		//添加一个X按钮
        // create custom button
        UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
		
		doneButton.frame = CGRectMake(0, 163, 105, 55);
        doneButton.adjustsImageWhenHighlighted = NO;
		doneButton.tag = 100;
		
        [doneButton setBackgroundImage:[UIImage imageNamed:@"jianpan1.png"] forState:UIControlStateNormal];
        [doneButton setBackgroundImage:[UIImage imageNamed:@"jianpan2.png"] forState:UIControlStateHighlighted];
		
		[doneButton setTitle:@"X" forState:UIControlStateNormal];
		UIFont *m_font = boldFont(20);
		doneButton.titleLabel.font = m_font;
		[doneButton setTitleColor:[UIColor colorWithRed:81/255.0 green:88/255.0 blue:104/255.0 alpha:1] forState:UIControlStateNormal];
		[doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [doneButton addTarget:self action:@selector(ADDCharButton_X) forControlEvents:UIControlEventTouchUpInside];
		
		[foundKeyboard addSubview:doneButton];
	}
	else if(foundKeyboard&&m_keyBoardType==keyType_AmountNumber)
	{
		//为金额定制的键盘
		//添加一个点按钮
        // create custom button
        UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
		
		doneButton.frame = CGRectMake(0, 163, 105, 55);
        doneButton.adjustsImageWhenHighlighted = NO;
		doneButton.tag = 100;
		
        [doneButton setBackgroundImage:[UIImage imageNamed:@"jianpan1.png"] forState:UIControlStateNormal];
        [doneButton setBackgroundImage:[UIImage imageNamed:@"jianpan2.png"] forState:UIControlStateHighlighted];
		
		[doneButton setTitle:@"." forState:UIControlStateNormal];
		UIFont *m_font = boldFont(20);
		doneButton.titleLabel.font = m_font;
		[doneButton setTitleColor:[UIColor colorWithRed:81/255.0 green:88/255.0 blue:104/255.0 alpha:1] forState:UIControlStateNormal];
		[doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [doneButton addTarget:self action:@selector(ADDCharButton_point) forControlEvents:UIControlEventTouchUpInside];
		
		[foundKeyboard addSubview:doneButton];
	}
	else if(foundKeyboard&&m_keyBoardType==keyType_FinishDefault)
	{
		//非数字键盘的
		//自定义 完成 按钮
		if (CURRENTACTIVITYTEXTFIELD.keyboardType==UIKeyboardTypeNumberPad)
		{
			//数字键盘的完成
			UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
			
			doneButton.frame = CGRectMake(0, 163, 105, 55);
			doneButton.adjustsImageWhenHighlighted = NO;
			doneButton.tag = 100;
			
			[doneButton setBackgroundImage:[UIImage imageNamed:@"jianpan1.png"] forState:UIControlStateNormal];
			[doneButton setBackgroundImage:[UIImage imageNamed:@"jianpan2.png"] forState:UIControlStateHighlighted];
			
			[doneButton setTitle:@"完成" forState:UIControlStateNormal];
			UIFont *m_font = boldFont(20);
			doneButton.titleLabel.font = m_font;
			[doneButton setTitleColor:[UIColor colorWithRed:81/255.0 green:88/255.0 blue:104/255.0 alpha:1] forState:UIControlStateNormal];
			[doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
			[doneButton addTarget:self action:@selector(doneButton) forControlEvents:UIControlEventTouchUpInside];
			
			[foundKeyboard addSubview:doneButton];
		}
		else
		{
			UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
			
			doneButton.frame = CGRectMake(243, 174, 74, 38);
			doneButton.adjustsImageWhenHighlighted = NO;
			doneButton.tag = 100;
			
			[doneButton setBackgroundImage:[UIImage imageNamed:@"jianpan1_Full.png"] forState:UIControlStateNormal];
			[doneButton setBackgroundImage:[UIImage imageNamed:@"jianpan2_Full.png"] forState:UIControlStateHighlighted];
			
			[doneButton setTitle:@"完成" forState:UIControlStateNormal];
			UIFont *m_font = boldFont(20);
			doneButton.titleLabel.font = m_font;
			[doneButton setTitleColor:[UIColor colorWithRed:81/255.0 green:88/255.0 blue:104/255.0 alpha:1] forState:UIControlStateHighlighted];
			[doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
			[doneButton addTarget:self action:@selector(doneButton) forControlEvents:UIControlEventTouchUpInside];
			
			[foundKeyboard addSubview:doneButton];
		}
	}
    //去掉下一项按钮
    //	else if(foundKeyboard&&m_keyBoardType==keyType_NextDefault)
    //	{
    //		//非数字键盘的
    //		//自定义完成按钮
    //		if (CURRENTACTIVITYTEXTFIELD.keyboardType==UIKeyboardTypeNumberPad)
    //		{
    //			//数字键盘的下一个
    //			UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //
    //
    //			doneButton.frame = CGRectMake(0, kbSize.height-56, 105, 55);
    //
    //
    //			doneButton.adjustsImageWhenHighlighted = NO;
    //			doneButton.tag = 100;
    //
    //			[doneButton setBackgroundImage:[UIImage imageNamed:@"jianpan1.png"] forState:UIControlStateNormal];
    //			[doneButton setBackgroundImage:[UIImage imageNamed:@"jianpan2.png"] forState:UIControlStateHighlighted];
    //
    //			[doneButton setTitle:@"下一项" forState:UIControlStateNormal];
    //			UIFont *m_font = [UIFont boldSystemFontOfSize:20.0];
    //			doneButton.titleLabel.font = m_font;
    //			[doneButton setTitleColor:[UIColor colorWithRed:81/255.0 green:88/255.0 blue:104/255.0 alpha:1] forState:UIControlStateNormal];
    //			[doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    //			[doneButton addTarget:self action:@selector(AddNextButton) forControlEvents:UIControlEventTouchUpInside];
    //
    //			[foundKeyboard addSubview:doneButton];
    //		}
    //		else
    //		{
    //			//非数字键盘的下一个
    //			UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //
    //			doneButton.frame = CGRectMake(243, kbSize.height-43, 74, 38);
    //			doneButton.adjustsImageWhenHighlighted = NO;
    //			doneButton.tag = 100;
    //
    //			[doneButton setBackgroundImage:[UIImage imageNamed:@"jianpan1_Full.png"] forState:UIControlStateNormal];
    //			[doneButton setBackgroundImage:[UIImage imageNamed:@"jianpan2_Full.png"] forState:UIControlStateHighlighted];
    //
    //			[doneButton setTitle:@"下一项" forState:UIControlStateNormal];
    //			UIFont *m_font = [UIFont boldSystemFontOfSize:20.0];
    //			doneButton.titleLabel.font = m_font;
    //			[doneButton setTitleColor:[UIColor colorWithRed:81/255.0 green:88/255.0 blue:104/255.0 alpha:1] forState:UIControlStateHighlighted];
    //			[doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //			[doneButton addTarget:self action:@selector(AddNextButton) forControlEvents:UIControlEventTouchUpInside];
    //
    //			[foundKeyboard addSubview:doneButton];
    //		}
    //
    //	}
	else
	{
		//其他的操作
		/*
		 如果没有任何参数的传入，那么，仅仅会在键盘上面添加一个返回的按钮
		 */
        
	}
    
}

+(void)doneButton
{
	if ([AppUserSettings CURRENTACTIVITYFIELD]!=nil)
	{
		[[AppUserSettings CURRENTACTIVITYFIELD] resignFirstResponder];
        [AppUserSettings SETCURRENTACTIVITYFIELD:nil];
		return;
	}
    
    if ([AppUserSettings CURRENTACTIVITYTEXTVIEW]!=nil ) {
        [[AppUserSettings CURRENTACTIVITYTEXTVIEW] resignFirstResponder];
        [AppUserSettings SETCURRENTACTIVITYTEXTVIEW:nil];
		return;
    }
	if ([AppUserSettings CURRENTACTIVITYSEARCHBAR]!=nil) {
		[[AppUserSettings CURRENTACTIVITYSEARCHBAR] resignFirstResponder];
		[AppUserSettings SETCURRENTSEARCHBAR:nil];
		return;
	}
}

//
//+(void)setDoneButtonHidden:(BOOL)hidden
//{
//    [AppUserSettings usersettings].hideDoneButton = hidden;
//}
//

+(void)ADDCharButton_X
{
	NSString *m_textFeildStr =CURRENTACTIVITYTEXTFIELD.text;
	m_textFeildStr = [m_textFeildStr stringByAppendingString:@"X"];
	CURRENTACTIVITYTEXTFIELD.text = m_textFeildStr;
}

+(void)ADDCharButton_point
{
	NSString *m_textFeildStr =CURRENTACTIVITYTEXTFIELD.text;
	m_textFeildStr = [m_textFeildStr stringByAppendingString:@"."];
	CURRENTACTIVITYTEXTFIELD.text = m_textFeildStr;
}
//
//+(void)AddNextButton
//{
//	if (m_NextTextField!=nil)
//	{
//		[m_NextTextField becomeFirstResponder];
//	}
//}
//


@end
