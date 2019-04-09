//
//  SkillNetworkConst.h
//  SkillExchange
//
//  Created by xu bin on 15/3/10.
//  Copyright (c) 2015年 xubin. All rights reserved.
//

typedef enum{
    IH_init, //初始化
    IH_User_Login,    //这个地方标识 某个接口返回的 数据，对应找到的接口。
    IH_sendRegisterSms, //获取验证码
    IH_addSupplyComment,//发布供求
    IH_Register,//用户注册
    IH_ValidateCode, //验证验证码
    IH_AddTopic, // 发布话题
    IH_AddSupply,//发布供应
    IH_AddActivties,//提交活动订单
    IH_AddCrowdActivties,//提交众筹活动订单
    IH_QuerySupplyList,//查询供应列表
    IH_AddBuy,//发布求购
    IH_AddSupplyClickLike,//供应点赞
    IH_QueryBuyList,//查询求购列表
    IH_QueryTopicList, // 查询 话题列表
    IH_QueryHotTopicList , //查询热门话题
    IH_CollectionSupply,//收藏供应
    IH_CollectionBuy,//收藏求购
    IH_CollectionTopic,//收藏话题
    IH_AddSupplyComment,//供应评论内容
    IH_AddBuyComment,//添加求购评论
    IH_AddTopicComment,//添加话题评论
    IH_AddActivtiesComment,//添加活动评论
    IH_AddNewsComment,//添加活动评论
    IH_DeleteSupply,//删除供应
     IH_DeleteBuy,//删除求购
    IH_QuerySupplyComment,//查询供应详情
    IH_QueryBuyComment,//查询求购详情
    IH_QueryTopicComment,//查询话题详情
    IH_UpdateSupply,//更新供应
    IH_UpdateBuy,//更新求购
    IH_QueryNearUser,//查询附近用户
    IH_QueryNewUser,//查询最新用户
    IH_UserComment,//查询用户评论
    IH_UpdateUserAdress,//用户更新地址
    IH_SelectUserCompanyName,//公司搜索
    IH_QueryUserList,//人脉
    IH_QuerySupplyCommentList, //查询 供应ID评论列表
    IH_QueryWantBuyCommentList, // 查询求购评论列表
    IH_ActivtiesCommentList,//查询活动评论列表
    IH_QueryTopicCommentList,//查询话题评论列表
    IH_QueryClickLikeListType,//查询点赞列表 根据type
    IH_UserInfoUpdate,//用户信息更新
    IH_QueryCollectionSupplyAndWantBuyList, //
    IH_GetMyCollectionSupplyList, //我收藏的 供应
    IH_GetMyCollectionBuyList,//我收藏的 求购
    IH_GetMyCollectionTopicList, //我收藏的话题
    
    IH_GetCommentMeList, //评论我的
    IH_GetSupplyDetailID,  //查看供应详情
    IH_GetBuyDetailID,  //查看求购详情
    IH_GetTopicDetailID,  //查看求购详情
    IH_SelectViewsList,//看过我的
    
    
    IH_Map,//地图标注
    
    IH_SelectUserInfoForId,//查看用户信息
    IH_WXlogin, //微信登陆
    IH_AddReport, //举报
    IH_ActivityList, //顶部活动图片列表
    IH_AllActivityList,//平台活动列表
    IH_UserActivityList,//我的活动列表
    IH_UserActivityDetail,//我的活动详情
    IH_UserNewsDetail,//资讯详情
    IH_UserImageNewsDetail,//图集资讯详情
    IH_NewsDetail,//广告资讯详情
    IH_NewsList,//行业资讯列表
    IH_NewsSearch,//资讯搜索结果
    IH_EPCloudList,//企业云列表
    IH_JobCompanyInfo,//招聘公司主页信息

    IH_EPConnectionList,//人脉列表

    IH_VoteList,//投票首页列表
    IH_VoteChartsList,//投票排行榜列表
    IH_VoteDetail,//投票个人详情
   
    IH_AddCrowOrderActivities,//发起众筹
    IH_selectCrowdDetailByCrowdId,//根据id查询众筹
    
    IH_SupplyAndBuy,//供求大厅
    
    IH_BindCompanyList,//绑定企业云列表
    IH_completeUserCloudInfoById,
    IH_EPCloudTrackList,//企业动态列表
    IH_EPCloudCommentList,//企业评论列表
    IH_UserEPCloudAuthInfo,//用户园林云信息绑定信息
    IH_GetThemeList, //获取主题列表
    IH_searchCompanyList,//搜索引擎公司信息
    IH_CompanyInfo,//公司信息

    IH_ThemeAndNewsList,//首页
    IH_TopicForId,//id获取话题

    IH_addBandBaiduChannelId,  //绑定百度推送
    IH_IdentForId,//身份标签

    IH_CloudInfo,//用户信息
    IH_fans,//粉丝列表
    IH_guanzhu,//关注列表
    IH_recommendConnection,//推荐人脉
    IH_recommendCompany,//推荐企业

    IH_invatedFriendsId,//邀请好友数统计
    IH_MTDic,//查询公共字典
    IH_selectRecruitList,//查询简历列表
     IH_selectRecruitListSearce,//搜索简历
     IH_SearchJobName,//搜索职位名称
    
    IH_PositionList,//职位列表
    IH_CompanyPositionList,//职位列表
    IH_PositionDetail,//职位详情
    IH_CurrculumDetail,//简历详情
    IH_ReceiveCurrculum,//收到的简历
    IH_ReleasePosition,//发布的工作
    

    IH_AskBarDetail,//问吧详情
    IH_replyProblemList,//已回复列表（最新，最热）
    IH_answerCommentList,//评论列表
    

    IH_MyQuestion,//发布的问题
    IH_Question,//问吧
 
    IH_MiaoMuYunList, //苗木云列表
 
    IH_NurseryDetailList,//苗木云详情列表
 
    IH_SeedCloudDetail,//苗木云详情
    
    IH_WeatherList,  //首页天气
    IH_WeatherDetail, //天气详情
    
    IH_MyNersery,//我发布的苗木云
    IH_deleteNersery,//删除苗木云

    IH_CouponList,//优惠卷列表

    IH_getQueryHomePageTypeList, //首页列表

    
 
    IH_ScoreHistory,//积分兑换记录
    IH_ScoreDetail,//积分兑换明细
    IH_GetAllChatRoomList, //获取聊天室列表
    IH_getAllChatGroupList,// 获取群组列表
    IH_getOwnerCarTime,//用车时间
    IH_FindCar,//找车
    IH_OwnerFaBu,//货主的发布
    IH_cheyuan,//车主车源
    
    IH_orderPay,//支付
    IH_PCLogin,//支付
    IH_Vediorefer,//来源课程详情

    
}IHFunctionTag;


