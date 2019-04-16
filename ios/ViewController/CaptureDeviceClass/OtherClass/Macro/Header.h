//
//  Header.h
//  THDiscernFlower
//
//  Created by Tata on 2017/11/20.
//  Copyright © 2017年 Tata. All rights reserved.
//

#ifndef Header_h
#define Header_h


#endif /* Header_h */

/*是否启用AppStore的Key,上线时候启用*/

//#define APPSTORE


//#define kTingHuaUrl  @"http://www.listenflower.com"
//友盟appkey
//#define UMengAppKey  @"5a1e6fc7a40fa30590000076"

//微博分享
//#define ShareSinaAppKey       @"463726348"
//#define ShareSinaAppSecret    @"05e91c0562ac4271fb8f7506996de37a"
//QQ分享
//#define ShareQQAppKey         @"iGRzDGtfIFRX4R8K"
//#define ShareQQAppID          @"1106546222"
//微信分享
//#define ShareWXAppID          @"wxc1a997f885e6cd65"
//#define ShareWXAppSecret      @"2bafbf820f955a59682390aa77b53971"

//云通讯()
#define CCPRestSDKAppId                     @"8a216da854ebfcf70154f04180df0441"
#define CCPRestSDKAccountSid                @"8a216da854e1a37a0154e1e6034700a9"
#define CCPRestSDKAccountToken              @"9fa6b4026ca84b9cb0462ab1333e4934"
#define CCPRestSDKModelId                   @"221587"

//测试账号密码
#define DFTestPhoneNumber      @"13718053697"
#define DFTestCodeNumber       @"123456"

#ifdef APPSTORE
    //线上地址
    #define RootUrl       @"https://recogflower.listenflower.com/api"
#else
    //测试地址
//    #define RootUrl       @"https://ca.tinghuaa.com/api"
    #define RootUrl       @"https://recogflower.listenflower.com/api"
#endif


