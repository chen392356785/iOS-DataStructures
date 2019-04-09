//
//  ClassroomModel.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/10/11.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "JSONModel.h"

//V3.0
@protocol subjectVoLisModel
@end
@interface subjectVoLisModel : JSONModel
@property (nonatomic, copy) NSString <Optional> * subUrl;
@property (nonatomic, copy) NSString <Optional> * subType;
@property (nonatomic, copy) NSString <Optional> * classUuid;
@property (nonatomic, copy) NSString <Optional> * jid;
@property (nonatomic, copy) NSString <Optional> * lastHmsTime;
@property (nonatomic, copy) NSString <Optional> * subUuid;
@property (nonatomic, copy) NSString <Optional> * flag;              //
@property (nonatomic, copy) NSString <Optional> * subName;
@property (nonatomic, copy) NSString <Optional> * subTime;
@property (nonatomic, copy) NSString <Optional> * subHmsTime;
@property (nonatomic, copy) NSString <Optional> * isSelect;    //选中
@property (nonatomic, copy) NSString <Optional> * numberStr;   //序号
@end

@interface ClassDetailModel : JSONModel
@property (nonatomic, copy) NSString <Optional> * updateNum;                     //更新了几集
@property (nonatomic, copy) NSString <Optional> * className;                     //标题
@property (nonatomic, copy) NSString <Optional> * islogin;                       //1已登录0token被顶掉了2未登录
@property (nonatomic, copy) NSString <Optional> * classNum;                      //总共几集
@property (nonatomic, copy) NSString <Optional> * intro;                         //简介
@property (nonatomic, copy) NSString <Optional> * vipUrl;                        //Vipurl
@property (nonatomic, strong) NSMutableArray <Optional,subjectVoLisModel> *subjectVoLis;
@property (nonatomic, strong) NSMutableArray <Optional> * contentImgList;       //详情图片集合

@end











@interface MyClassSourceListModel : JSONModel
@property (nonatomic, copy) NSString <Optional> * class_name;
@property (nonatomic, copy) NSString <Optional> * head_pic;
@property (nonatomic, copy) NSString <Optional> * class_type;
@property (nonatomic, copy) NSString <Optional> * class_uuid;
@property (nonatomic, copy) NSString <Optional> * last_hms_time;
@property (nonatomic, copy) NSString <Optional> * last_time;
@property (nonatomic, copy) NSString <Optional> * sub_hms_time;
@property (nonatomic, copy) NSString <Optional> * sub_time;
@property (nonatomic, copy) NSString <Optional> * sub_uuid;
@property (nonatomic, copy) NSString <Optional> * xuexi_status;

@property (nonatomic, copy) NSString <Optional> * class_jindu;
@property (nonatomic, copy) NSString <Optional> * class_num;
@property (nonatomic, copy) NSString <Optional> * is_update;
@property (nonatomic, copy) NSString <Optional> * kan_jindu;
@property (nonatomic, copy) NSString <Optional> * total_time;
@property (nonatomic, copy) NSString <Optional> * yigeng_num;
@property (nonatomic, copy) NSString <Optional> * yikan_time;
@property (nonatomic, copy) NSString <Optional> * jid;
@end


@interface ClassVedioListModel : JSONModel
@property (nonatomic, copy) NSString <Optional> * class_uuid;
@property (nonatomic, copy) NSString <Optional> * head_pic;
@property (nonatomic, copy) NSString <Optional> * jid;
@property (nonatomic, copy) NSString <Optional> * class_id;
@property (nonatomic, copy) NSString <Optional> * intro;
@property (nonatomic, copy) NSString <Optional> * is_look_out;
@property (nonatomic, copy) NSString <Optional> * is_test;
@property (nonatomic, copy) NSString <Optional> * last_hms_time;
@property (nonatomic, copy) NSString <Optional> * last_time;
@property (nonatomic, copy) NSString <Optional> * name;
@property (nonatomic, copy) NSString <Optional> * order_status;
@property (nonatomic, copy) NSString <Optional> * sub_hms_time;
@property (nonatomic, copy) NSString <Optional> * sub_name;
@property (nonatomic, copy) NSString <Optional> * sub_time;
@property (nonatomic, copy) NSString <Optional> * sub_type;
@property (nonatomic, copy) NSString <Optional> * sub_url;
@property (nonatomic, copy) NSString <Optional> * sub_uuid;
@property (nonatomic, copy) NSString <Optional> * test_time;
@property (nonatomic, copy) NSString <Optional> * total_money;
@property (nonatomic, copy) NSString <Optional> * userId;
@property (nonatomic, copy) NSString <Optional> * view_sum;
@property (nonatomic, copy) NSString <Optional> * xuexi_status;
@property (nonatomic, copy) NSString <Optional> * sign; //加密
@property (nonatomic, copy) NSString <Optional> * is_share_free; // 1  分享完后免费
@end











@protocol studyBannerListModel
@end
@interface studyBannerListModel : JSONModel
@property (nonatomic, copy) NSString <Optional> * bannerPic;
@property (nonatomic, copy) NSString <Optional> * banner_tiao;      //为1时banner点击时可以跳转
@property (nonatomic, copy) NSString <Optional> * cautionMoney;     //线下课堂保证金
@property (nonatomic, copy) NSString <Optional> * classIntro;
@property (nonatomic, copy) NSString <Optional> * className;
@property (nonatomic, copy) NSString <Optional> * class_type;       //'0 只视频课堂  1只音频课堂'
@property (nonatomic, copy) NSString <Optional> * classNum;         //课程节数
@property (nonatomic, copy) NSString <Optional> * classUuid;
@property (nonatomic, copy) NSString <Optional> * contentListPic;
@property (nonatomic, copy) NSString <Optional> * contentPic;
@property (nonatomic, copy) NSString <Optional> * createTime;
@property (nonatomic, copy) NSString <Optional> * headPic;
@property (nonatomic, copy) NSString <Optional> * jid;
@property (nonatomic, copy) NSString <Optional> * isBanner;
@property (nonatomic, copy) NSString <Optional> * isCaution;        //'是否需要保证金  0 不需要 1需要',
@property (nonatomic, copy) NSString <Optional> * isDeleted;
@property (nonatomic, copy) NSString <Optional> * isIndex;
@property (nonatomic, copy) NSString <Optional> * isSignUp;         //大于0代表已经报名，小于1代表没报名
@property (nonatomic, copy) NSString <Optional> * keKan;            //大于0代表里面有可以试看的视频
@property (nonatomic, copy) NSString <Optional> * keTing;           //大于0代表里面有可以试听的视频
@property (nonatomic, copy) NSString <Optional> * isTop;
@property (nonatomic, copy) NSString <Optional> * lableCodes;
@property (nonatomic, copy) NSString <Optional> * picHeight;
@property (nonatomic, copy) NSString <Optional> * picWidth;
@property (nonatomic, copy) NSString <Optional> * posterPic;
@property (nonatomic, copy) NSString <Optional> * sort;
@property (nonatomic, copy) NSString <Optional> * totalMoney;           //全额付款总金额
@property (nonatomic, copy) NSString <Optional> * updateTime;

@property (nonatomic, copy) NSString <Optional> * sub_uuid;     // 上次观看课堂
@end

@protocol keywordListModel
@end
@interface keywordListModel : JSONModel
@property (nonatomic, copy) NSString <Optional> * createTime;
@property (nonatomic, copy) NSString <Optional> * deleted;
@property (nonatomic, copy) NSString <Optional> * keywordId;
@property (nonatomic, copy) NSString <Optional> * keywordName;
@property (nonatomic, copy) NSString <Optional> * sort;
@property (nonatomic, copy) NSString <Optional> * updateTime;
@end


@protocol configClientItemListModel
@end
@interface configClientItemListModel : JSONModel
@property (nonatomic, copy) NSString <Optional> * jid;
@property (nonatomic, copy) NSString <Optional> * itemCode;
@property (nonatomic, copy) NSString <Optional> * itemIcon;
@property (nonatomic, copy) NSString <Optional> * itemName;
@property (nonatomic, copy) NSString <Optional> * status;
@end




@protocol studyLableListModel
@end
@interface studyLableListModel : JSONModel
@property (nonatomic, strong) NSMutableArray <Optional,studyBannerListModel> *classList;
@property (nonatomic, copy) NSString <Optional> * createTime;
@property (nonatomic, copy) NSString <Optional> * jid;
@property (nonatomic, copy) NSString <Optional> * isIndex;
@property (nonatomic, copy) NSString <Optional> * lableCode;
@property (nonatomic, copy) NSString <Optional> * lableName;
@property (nonatomic, copy) NSString <Optional> * sort;
@property (nonatomic, copy) NSString <Optional> * updateTime;
@end


@interface TearchListModel : JSONModel
@property (nonatomic, strong) NSMutableArray <Optional,studyBannerListModel> *classList;
@property (nonatomic, copy) NSString <Optional> * createTime;
@property (nonatomic, copy) NSString <Optional> * headPic;
@property (nonatomic, copy) NSString <Optional> * intro;
@property (nonatomic, copy) NSString <Optional> * isShow;
@property (nonatomic, copy) NSString <Optional> * name;
@property (nonatomic, copy) NSString <Optional> * sort;
@property (nonatomic, copy) NSString <Optional> * teacherId;
@property (nonatomic, copy) NSString <Optional> * updateTime;
@end

@interface ClassroomModel : JSONModel
@property (nonatomic, strong) NSString <Optional> *keyWord;
@property (nonatomic, strong) NSMutableArray <Optional,keywordListModel> *keywordList;
@property (nonatomic, strong) NSMutableArray <Optional,studyBannerListModel> *studyBannerList;
@property (nonatomic, strong) NSMutableArray <Optional,studyLableListModel> *studyLableList;
@property (nonatomic, strong) NSMutableArray <Optional,configClientItemListModel> *configClientItemList;
@property (nonatomic, strong) NSString <Optional> *lineItemSum;
@end
