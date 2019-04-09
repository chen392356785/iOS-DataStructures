//
//  THRectMacro.h
//  Owner
//
//  Created by Neely on 2018/3/23.
//

#ifndef THRectMacro
#define THRectMacro


// App Frame
#define Application_Frame [[UIScreen mainScreen] applicationFrame]

// App Frame Height&Width
#define App_Frame_Height [[UIScreen mainScreen] applicationFrame].size.height
#define App_Frame_Width [[UIScreen mainScreen] applicationFrame].size.width

// MainScreen Height&Width
#define Main_Screen_Height SCREEN_HEIGHT
#define Main_Screen_Width SCREEN_WIDTH

//是否是粪叉
#define KIsiPhoneX ([[UIApplication sharedApplication] statusBarFrame].size.height > 20? YES:NO)
//#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

// 系统控件默认高度
#define kPTStatusBarHeight (20.f)
#define kTopBarHeight (44.f)
#define kBottomBarHeight (49.f)

//距离底部space
#define kBottomSapce KIsiPhoneX ? (34.f) : (10.f)
#define kBottomNoSapce KIsiPhoneX ? (34.f) : (0.f)
#define kNavigationHeight KIsiPhoneX ? (88.f) : (64.f)
#define kTabbarHeight KIsiPhoneX ? (83.f) : (49.f)

//左间距
#define kLeftMagin (10.f)


// View 坐标(x,y)和宽高(width,height)
#define X(v) (v).frame.origin.x
#define Y(v) (v).frame.origin.y
#define WIDTH(v) (v).frame.size.width
#define HEIGHT(v) (v).frame.size.height

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))


#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)


//xmcell
#define DEFAULT_MAINVIEW_ROW_SPAN   10

//tableViewSection Height
#define TABLE_SECTION_HEIGHT 10

#endif

