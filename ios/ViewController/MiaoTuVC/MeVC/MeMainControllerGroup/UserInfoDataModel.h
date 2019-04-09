//
//  UserInfoDataModel.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/12/12.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "JSONModel.h"

@protocol itemListModel
@end

@interface itemListModel : JSONModel
@property (nonatomic, copy)   NSString <Optional> * jid;
@property (nonatomic, copy)   NSString <Optional> * menuPic;
@property (nonatomic, copy)   NSString <Optional> * isShow;
@property (nonatomic, copy)   NSString <Optional> * isDefault;
@property (nonatomic, copy)   NSString <Optional> * type;
@property (nonatomic, copy)   NSString <Optional> * menuName;
@property (nonatomic, copy)   NSString <Optional> * isDeleted;
@property (nonatomic, copy)   NSString <Optional> * createTime;
@property (nonatomic, copy)   NSString <Optional> * isJump;             //1 跳转到功能 2 跳转到链接' 0 不操作
@property (nonatomic, copy)   NSString <Optional> * jumpUrl;
@property (nonatomic, copy)   NSString <Optional> * menuCode;
@property (nonatomic, copy)   NSString <Optional> * sort;
@property (nonatomic, copy)   NSString <Optional> * updateTime;
@property (nonatomic, copy)   NSString <Optional> * numStr;
@end


@protocol CardListModel
@end
//卡券
@interface CardListModel : JSONModel
@property (nonatomic, copy)   NSString <Optional> * isUse;      //0未使用1使用2过期
@property (nonatomic, copy)   NSString <Optional> * cardUrl;    //二维码地址
@property (nonatomic, copy)   NSString <Optional> * putName;    //卡名字
@property (nonatomic, copy)   NSString <Optional> * dueTime;    //过期时间
@property (nonatomic, copy)   NSString <Optional> * price;      //价格
@property (nonatomic, copy)   NSString <Optional> * putPic;     //
@end

@interface CardContentModel : JSONModel
@property (nonatomic, copy)   NSString <Optional> * name;      //卡  劵
@property (nonatomic, strong) NSMutableArray <Optional,CardListModel> * list;    //卡券信息
@property (nonatomic, copy)   NSString <Optional> * codeStr;      //卡  劵 标识

@end


@protocol pointsAdvListModel
@end

@interface pointsAdvListModel : JSONModel
@property (nonatomic, copy)   NSString <Optional> * jid;
@property (nonatomic, copy)   NSString <Optional> * menuPic;
@property (nonatomic, copy)   NSString <Optional> * isShow;
@property (nonatomic, copy)   NSString <Optional> * isDefault;
@property (nonatomic, copy)   NSString <Optional> * type;
@property (nonatomic, copy)   NSString <Optional> * menuName;
@property (nonatomic, copy)   NSString <Optional> * isDeleted;
@property (nonatomic, copy)   NSString <Optional> * createTime;
@property (nonatomic, copy)   NSString <Optional> * isJump;             //1 跳转到功能 2 跳转到链接' 0 不操作
@property (nonatomic, copy)   NSString <Optional> * jumpUrl;
@property (nonatomic, copy)   NSString <Optional> * menuCode;
@property (nonatomic, copy)   NSString <Optional> * sort;
@property (nonatomic, copy)   NSString <Optional> * updateTime;
@property (nonatomic, copy)   NSString <Optional> * num;
@end


@protocol pointParamsModel
@end

@interface pointParamsModel : JSONModel
@property (nonatomic, copy)   NSString <Optional> *name;
@property (nonatomic, copy)   NSString <Optional> *sortType;                  //0 vip 会员轮播  //1 会员服务 2 常用工具  3 帮助中心
@property (nonatomic, strong) NSMutableArray <pointsAdvListModel,Optional> * pointsAdvList;         //会员服务类里面字段跟下面两个是不一样的
@property (nonatomic, strong) NSMutableArray <pointsAdvListModel,Optional> * pointsMenuList;        //常用工具跟帮助中心类里面字段是一样的
//@property (nonatomic, strong) NSMutableArray <pointsAdvListModel,Optional> * pointsTopList;        //头部字段是一样的
@end


@interface userInfoModel : JSONModel
@property (nonatomic, copy) NSString <Optional> * fansNum;          //粉丝数
@property (nonatomic, copy) NSString <Optional> * address;          //地址
@property (nonatomic, copy) NSString <Optional> * points;           //积分
@property (nonatomic, copy) NSString <Optional> * followNum;        //关注数
@property (nonatomic, copy) NSString <Optional> * isDue;            //1是会员0不是会员
@property (nonatomic, copy) NSString <Optional> * balance;          //余额
@property (nonatomic, copy) NSString <Optional> * nickname;         //昵称
@property (nonatomic, copy) NSString <Optional> * due_time;         //到期时间
@property (nonatomic, copy) NSString <Optional> * cardNum;          //卡券数量
@property (nonatomic, copy) NSString <Optional> * vipPrice;         //会员价格
@property (nonatomic, copy) NSString <Optional> * heed_image_url;   //头像
@property (nonatomic, copy) NSString <Optional> * isPartner;        //1为合伙人  0为未加入合伙人
@property (nonatomic, copy) NSString <Optional> * shareInviteCode;  //
@property (nonatomic, copy) NSString <Optional> * shareCode;        //邀请码
@property (nonatomic, copy) NSString <Optional> * messageNum;       //我的消息未读数
@end

@interface allUrlModel : JSONModel
@property (nonatomic, copy) NSString <Optional> * jiaruvip_Url;        //加入VIP 加入or续费
@property (nonatomic, copy) NSString <Optional> * myvip_Url;           //我的VIP
@property (nonatomic, copy) NSString <Optional> * zhuce_Url;           //注册
@property (nonatomic, copy) NSString <Optional> * getpointMoney_Url;   //获取苗币
@property (nonatomic, copy) NSString <Optional> * huiyuantequan_Url;   //会员特权
@property (nonatomic, copy) NSString <Optional> * sharehaoyou_Url;     //分享链接
@property (nonatomic, copy) NSString <Optional> * yaoqinghaoyou_Url;   //邀请好友界面链接
@property (nonatomic, copy) NSString <Optional> * toPartnerRules_Url;  //合伙人规则
@property (nonatomic, copy) NSString <Optional> * yearurl;             //加入年费
@end

@interface UserInfoDataModel : JSONModel
@property (nonatomic, strong) userInfoModel <Optional> * userInfo;      //个人信息
@property (nonatomic, strong) allUrlModel   <Optional> * allUrl;        //链接URL
@property (nonatomic, copy) NSString <Optional> * wx_code;              //微信客服
@property (nonatomic, strong) NSMutableArray <pointParamsModel,Optional> * pointParams;         //模块
@property (nonatomic, strong) NSMutableArray <itemListModel,Optional> * topHELPMenu;         //顶部Item

@end
