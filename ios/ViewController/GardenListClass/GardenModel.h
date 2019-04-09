//
//  GardenModel.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/11/20.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "JSONModel.h"
//回复内容
@interface gardenReplyCommentModel: JSONModel
@property (nonatomic, copy) NSString <Optional> *jid;
@property (nonatomic, copy) NSString <Optional> *gardenId;
@property (nonatomic, copy) NSString <Optional> *userId;
@property (nonatomic, copy) NSString <Optional> *comment;
@property (nonatomic, copy) NSString <Optional> *userName;
@property (nonatomic, copy) NSString <Optional> *userHeadPic;
@property (nonatomic, copy) NSString <Optional> *replyUserId;
@property (nonatomic, copy) NSString <Optional> *replyUserName;
@property (nonatomic, copy) NSString <Optional> *replyUserHead;
@property (nonatomic, copy) NSString <Optional> *commentOneId;
@end

@interface GardenCommentListModel : JSONModel
@property (nonatomic, copy) NSString <Optional> *jid;
@property (nonatomic, copy) NSString <Optional> *commentCount;
@property (nonatomic, copy) NSString <Optional> *commentCountString;
@property (nonatomic, copy) NSString <Optional> *gardenId;
@property (nonatomic, copy) NSString <Optional> *isReport;
@property (nonatomic, copy) NSString <Optional> *comment;
@property (nonatomic, copy) NSString <Optional> *replyUserId;
@property (nonatomic, copy) NSString <Optional> *userId;
@property (nonatomic, copy) NSString <Optional> *userName;
@property (nonatomic, copy) NSString <Optional> *reportUserIds;
@property (nonatomic, copy) NSString <Optional> *userHeadPic;
@property (nonatomic, copy) NSString <Optional> *replyUserName;
@property (nonatomic, copy) NSString <Optional> *replyUserHead;
@property (nonatomic, copy) NSString <Optional> *commentOneId;
@property (nonatomic, copy) NSString <Optional> *isDeleted;
@property (nonatomic, copy) NSString <Optional> *reportReason;
@property (nonatomic, copy) NSString <Optional> *createTime;
@property (nonatomic, copy) NSString <Optional> *updateTime;
@property (nonatomic, copy) NSDictionary <Optional> *tails;

@end






@interface gardenSearchModel : JSONModel
@property (nonatomic, copy) NSString <Optional> *paiming;
@property (nonatomic, copy) NSString <Optional> *gardenCompany;
@property (nonatomic, copy) NSString <Optional> *gardenId;
@property (nonatomic, copy) NSString <Optional> *gardenUuid;
@property (nonatomic, copy) NSString <Optional> *gardenListUuid;
@property (nonatomic, copy) NSString <Optional> *name;
@property (nonatomic, copy) NSString <Optional> *moreUrl;
@property (nonatomic, copy) NSString <Optional> *indexUrl;
@end





@protocol informationsModel
@end

@interface informationsModel : JSONModel
@property (nonatomic, copy) NSString <Optional> *infoId;
@property (nonatomic, copy) NSString <Optional> *infoTitle;
@property (nonatomic, copy) NSString <Optional> *infoSubTitle;
@property (nonatomic, copy) NSString <Optional> *infoContent;
@property (nonatomic, copy) NSString <Optional> *uploadtime;
@property (nonatomic, copy) NSString <Optional> *infoFrom;
@property (nonatomic, copy) NSString <Optional> *viewTotal;
@property (nonatomic, copy) NSString <Optional> *infomationUrl;
@property (nonatomic, copy) NSString <Optional> *infoUrl;
@property (nonatomic, copy) NSString <Optional> *imgType;
@end

@protocol ActivitiesModel
@end

@interface ActivitiesModel : JSONModel
@property (nonatomic, copy)   NSString <Optional> *activitiesId;
@property (nonatomic, copy)   NSString <Optional> *typeId;
@property (nonatomic, copy)   NSString <Optional> *userId;
@property (nonatomic, copy)   NSString <Optional> *activitiesTitile;
@property (nonatomic, copy)   NSString <Optional> *activitiesStarttime;
@property (nonatomic, copy)   NSString <Optional> *activitiesEndtime;
@property (nonatomic, copy)   NSString <Optional> *zmhPoster;
@property (nonatomic, copy)   NSString <Optional> *mtPoster;
@property (nonatomic, copy)   NSString <Optional> *activitiesPic;       //活动图片
@property (nonatomic, copy)   NSString <Optional> *userUpperLimitNum;
@property (nonatomic, copy)   NSString <Optional> *updateTime;
@property (nonatomic, copy)   NSString <Optional> *model;   //4活动  8众筹
@property (nonatomic, copy)   NSString <Optional> *activitiesExpirestarttime;   //活动报名开始时间
@property (nonatomic, copy)   NSString <Optional> *activitiesExpiretime;        //活动报名结束时间
@end


@protocol menuListModel
@end

@interface menuListModel : JSONModel
@property (nonatomic, copy)   NSString <Optional> *createTime;
@property (nonatomic, copy)   NSString <Optional> *jid;
@property (nonatomic, copy)   NSString <Optional> *isDeleted;
@property (nonatomic, copy)   NSString <Optional> *isJump;
@property (nonatomic, copy)   NSString <Optional> *isShow;
@property (nonatomic, copy)   NSString <Optional> *jumpUrl;
@property (nonatomic, copy)   NSString <Optional> *menuCode;
@property (nonatomic, copy)   NSString <Optional> *menuName;
@property (nonatomic, copy)   NSString <Optional> *menuPic;
@property (nonatomic, copy)   NSString <Optional> *sort;
@property (nonatomic, copy)   NSString <Optional> *updateTime;
@end

@protocol yuanbangModel
@end

@interface yuanbangModel : JSONModel
@property (nonatomic, copy)   NSString <Optional> *createTime;
@property (nonatomic, copy)   NSString <Optional> *gardenAddress;
@property (nonatomic, copy)   NSString <Optional> *gardenArea;
@property (nonatomic, copy)   NSString <Optional> *gardenCompany;
@property (nonatomic, copy)   NSString <Optional> *gardenContent;
@property (nonatomic, copy)   NSString <Optional> *gardenId;
@property (nonatomic, copy)   NSString <Optional> *gardenLastSort;
@property (nonatomic, copy)   NSString <Optional> *gardenListName;
@property (nonatomic, copy)   NSString <Optional> *gardenListUuid;
@property (nonatomic, copy)   NSString <Optional> *gardenLogo;
@property (nonatomic, copy)   NSString <Optional> *gardenName;      //名字
@property (nonatomic, copy)   NSString <Optional> *gardenNum;
@property (nonatomic, copy)   NSString <Optional> *gardenPick;
@property (nonatomic, copy)   NSString <Optional> *gardenShare;
@property (nonatomic, copy)   NSString <Optional> *isClick;         //1点过
@property (nonatomic, copy)   NSString <Optional> * gardenSign;     //点赞
@property (nonatomic, copy)   NSString <Optional> * gardenSpec;
@property (nonatomic, copy)   NSString <Optional> * gardenSumScore;
@property (nonatomic, copy)   NSString <Optional> * gardenType;
@property (nonatomic, copy)   NSString <Optional> * gardenUuid;
@property (nonatomic, copy)   NSString <Optional> * huadong;
@property (nonatomic, copy)   NSString <Optional> * isExamine;
@property (nonatomic, copy)   NSString <Optional> * isShow;
@property (nonatomic, copy)   NSString <Optional> * mobile;
@property (nonatomic, copy)   NSString <Optional> * paiming;
@property (nonatomic, copy)   NSString <Optional> * source;
@property (nonatomic, copy)   NSString <Optional> * updateTime;
@property (nonatomic, copy)   NSString <Optional> * userId;
@property (nonatomic, copy)   NSString <Optional> * zhishu;
@property (nonatomic, copy)   NSString <Optional> * isSpec;
@property (nonatomic, copy)   NSString <Optional> * gardenSignString;         //点赞数
@property (nonatomic, copy)   NSString <Optional> * commentCountString;       //评论数
@property (nonatomic, copy)   NSString <Optional> * indexUrl;

@end


@protocol gardenListsModel
@end

@interface gardenListsModel : JSONModel
@property (nonatomic, copy)   NSString <Optional> * jid;
@property (nonatomic, copy)   NSString <Optional> * cateId;
@property (nonatomic, copy)   NSString <Optional> * listUuid;
@property (nonatomic, copy)   NSString <Optional> * name;
@property (nonatomic, copy)   NSString <Optional> * indexUrl;
@property (nonatomic, copy)   NSString <Optional> * picUrl;
@property (nonatomic, copy)   NSString <Optional> * bgUrl;
@property (nonatomic, copy)   NSString <Optional> * detailUrl;
@property (nonatomic, copy)   NSString <Optional> * isSpec;
@property (nonatomic, copy)   NSString <Optional> * sort;
@property (nonatomic, copy)   NSString <Optional> * isShow;
@property (nonatomic, copy)   NSString <Optional> * createTime;
@property (nonatomic, copy)   NSString <Optional> * updateTime;
@property (nonatomic, copy)   NSString <Optional> * posterUrl;
@property (nonatomic, copy)   NSString <Optional> * okUrl;
@property (nonatomic, strong) NSMutableArray <yuanbangModel,Optional> *gardenBangs;

@end

@protocol biaoqianModel
@end

@interface biaoqianModel : JSONModel
@property (nonatomic, copy)   NSString <Optional> *jid;
@property (nonatomic, copy)   NSString <Optional> *cateName;                         //横向切换榜单标签
@property (nonatomic, copy)   NSString <Optional> *createTime;
@property (nonatomic, strong) NSMutableArray <gardenListsModel,Optional> *gardenLists;  //榜单下的榜单
@end


@interface GardenModel : JSONModel
@property (nonatomic, copy) NSString <Optional> *okUrl;
@property (nonatomic, strong) NSMutableArray <biaoqianModel,Optional> *biaoqian;
@property (nonatomic, strong) NSMutableArray <yuanbangModel,Optional> *yuanbang;
@property (nonatomic, copy) NSString <Optional> *moreImg;


@property (nonatomic, copy) NSDictionary <Optional> *indexModel;  //

@property (nonatomic, strong) NSMutableArray <informationsModel,Optional> *informations;           //园榜红人故事

@property (nonatomic, strong) NSMutableArray <yuanbangModel,Optional> *theNewGardenBangList;       //最新入榜

@property (nonatomic, strong) NSMutableArray <ActivitiesModel,Optional> *launchActivities;         //线下活动
@property (nonatomic, strong) NSMutableArray <biaoqianModel,Optional> *gardenCategoryPojos;        //横向滚动榜单
@property (nonatomic, strong) NSMutableArray <menuListModel,Optional> *gardenMenus;                 //顶部申请如榜...

@end
