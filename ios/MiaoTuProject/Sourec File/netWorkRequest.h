//
//  netWorkRequest.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/5/28.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#ifndef netWorkRequest_h
#define netWorkRequest_h

#define SafelyCallBlock(block,...) \

#define JoinCharGroupUrl         @"openModel/insertChatGroupInfo"                 //加入圈子
#define ExitCharGroupUrl         @"openModel/daleteChatGroupInfo"                 //退出圈子
#define registAndLoingUrl        @"registerAndLogin/registWXUser"                 //微信注册接口
#define MyActivitiesorListUrl    @"Activities/selecOrderActivitiesforUserId"      //我的活动,众筹列表
#define ProductCodeUrl           @"wechat/getWxaCode"                             //生成二维码
#define selectCrowdByIdUrl       @"CrowdActivity/selectCrowdById"                 //众筹订单查看详情
#define selectActivitiesdUrl     @"CrowdActivity/selectActivities"                //活动列表详情
#define NewVarietyPicUrl         @"nurseryNew/selectAllNurseryNewType"            //首页接口
#define NewddNurserynewUrl       @"nurseryNew/toAddNurserynew"                    //获取手机号码及发布品种类型
#define NewDetailMoreUrl         @"nurseryNew/selectAllNurseryNewDetailByType"    //更多
#define NewVarietySearUrl        @"nurseryNew/selectAllNurseryNewDetailByType"    //搜索
#define NewAddNurseryUrl         @"nurseryNew/toAddNurserynew"                    //发布新品种获取电话号及品种
#define NewaddNewDetailUrl       @"nurseryNew/addNurseryNewDetail"                //发布新品种发布
#define SupperHuihuiUrl          @"CrowdActivity/saveHuifu"                       //支持列表回复
#define SupportHideCrowUrl       @"CrowdActivity/hideCrowdRecord"                 //隐藏支持人
#define GetPhoneNumUrl           @"nurseryNew/toAddNursery"                       //获取联系人电话
#define ActivityTypeUrl          @"Activities/selectActivitiesType"               //活动/众筹分类
#define SendTemplateUrl          @"wechat/sendTemplate"                           //发送微信模板
#define HomeSearchUrl            @"openModel/selectAll"                           //首页搜索接口
#define MyNurseryUrl             @"nurseryNew/selectMyNurseryDetailList"          //我发布的新品种图库
#define ActivityShareUrl         @"wechat/getActCode"                             //活动分享  get请求
#define VoteActiviShareUrl       @"wechat/getVoteProjectCode"                     //活动投票分享  get请求
#define ClassroomStudyUrl        @"v3/study/index"                                //课堂首页接口  get
#define ClassroomTeacherUrl      @"study/teacher/selectTeacherList"               //推荐讲师
#define selectClassLisUrl        @"study/class/selectClassListByTeacherId"        //讲师课堂列表
#define selectClassDetailUrl     @"v3/study/detail"                               //查询课堂详情  get
#define selectClassSearchlUrl    @"study/class/selectClassListByTeacherId"        //课堂搜索
#define addTeacherUrl            @"study/teacher/addTeacher"                      //添加讲师
#define ClassSourceShareUrl      @"wechat/getClassCode"                           //课程分享  get请求
#define submitClassSourceUrl     @"study/order/saveOrder"                         //课堂生成订单接口
#define newsubmitClassSourceUrl  @"study/order/appOrder"                          //加密课堂生成订单接口
#define selectSubjectListUrl     @"study/subject/selectSubjectList"               //根据课堂uuid查出课程列表
#define selectVideSubjecttUrl    @"study/subject/selectSubjectById"               //根据课堂uuid查出课程详情
#define StudyShareBackUrl        @"study/subject/shareBack"                       //分享成功之后回调免费

#define saveSubjectTimeUrl       @"study/subject/saveSubjectRecord"               //观看视频/音频后保存观看时间
#define mySubjectOrderUrl        @"study/order/selectOrder"                       //我的订购

#define GardenSourceUrl          @"garden/index"                                 //园榜首页 搜索 我的园榜 首 页点击标签 V2.9.16 以后废弃
#define GardenBangdanListUrl     @"garden/three/bangdanList"                     //园榜投票
#define GardenListDetailUrl      @"garden/three/detailApp"                       //园榜详情接口 

#define GardenLikeUrl            @"garden/clickLike"                              //园榜投票
#define GardenpingluneUrl        @"garden/three/dealComment"                      //评论
#define GardenDelepingluneUrl    @"garden/three/dealComment"                      //删除评论

#define GardenDetailUrl          @"garden/detail"                                 //园榜详情接口
#define GardenSharelUrl          @"wechat/getGardenCode"                          //园榜分享接口
#define GardenDetailSharelUrl    @"wechat/getGardenComCode"                       //园榜企业详情分享接口
#define JoinGardenListUrl        @"garden/three/saveGarden"                       //加入榜单V2.9.16+
#define shareLikeUrl             @"garden/shareLike"                              //分享加一
#define getJoinGardenListUrl     @"garden/three/toAddGarden"                      //加入榜单列表所需填写参数

#define GardenHomeUrl            @"garden/three/index"                            //园榜首页  V2.9.17
#define GardenSearchDataUrl      @"garden/three/select"                           //园榜搜索
#define GardenzuixinDataUrl      @"garden/three/zuixin"                           //园榜最新榜单
#define GardenMoreDataUrl        @"garden/three/moreByCateId"                     //园榜分类下的更多

#define getUserinfoDataUrl       @"points/index"                                  //个人中心
#define getUserMiaoBiinfoUrl     @"points/myPoints"                               //我的苗途币
#define getpointsListUrl         @"points/pointsList"                             //排行榜
#define shareAddPointUrl         @"openModel/shareAddPoint"                       //1.1 苗木云、企业云、人脉云、资讯、供应、求购分享回调
#define JoinVipOrderUrl          @"points/vipOrder"                              //加入会员
#define myCardUrl                @"points/myCard"                                //我的卡券
#define JoinPartnerUrl           @"partner/savePartner"                          //加入合伙人
#define bindCardeUrl             @"partner/bindCard"                             //兑换卡券
#define partnerCodeUrl           @"partner/bind"                                 //绑定邀请码
#define partnerListUrl           @"partner/fridenList"                           //合伙人列表
#define sendMessageUrl           @"message/sendMessage"                          //消息回复
#define messageListUrl           @"message/messageList"                          //消息列表
#define messageStateUrl          @"message/lookMessage"                          //改变消息未读状态
#define messageDetailUrl         @"message/messageDetail"                        //消息内容列表
#define delMessageUrl            @"message/delMessage"                           //消息删除
#define gongqiuInitUrl           @"openModel/getVipUrl"                          //判断是否为VIP get加入VIP链接
#define supplyBuyNuseryUrl       @"supplyAndBuy/nurseryType"                     //获取品种类型
#define userCompanylistUrl       @"userCompany/list"                             //获取公司/苗圃列表
#define userCompanyCompanyUrl    @"userCompany/company"                          //公司苗圃新增加
#define supplyAndBuyUpplyUrl     @"supplyAndBuy/supply"                          //发布供应
#define supplyAndBuyWantBuyUrl     @"supplyAndBuy/wantBuy"                          //发布供应
#endif /* netWorkRequest_h */
