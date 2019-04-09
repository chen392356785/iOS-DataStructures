//
//  MTNetworkData+ForModel.h
//  MiaoTuProject
//
//  Created by Mac on 16/4/1.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTNetworkData.h"
@class MTNewSupplyAndBuyListModel;
@interface MTNetworkData (ForModel)
-(NSArray *)getJsonForString:(NSString *)str; //字符串转 数组
-(NSDictionary *)getJsonDicForString:(NSString *)str;//字符串转字典
-(NSDictionary *)parseGetLogin:(NSDictionary*)dic;

-(NSDictionary *)parseGetTopicList:(NSDictionary*)dic page:(int)page  tag:(int)tag;

-(NSDictionary*)getQuerySupplyList:(NSDictionary *)dic; // 供应列表
-(NSDictionary *)getQueryBuyList:(NSDictionary *)dic; //求购列表
-(NSDictionary*)getSupplyAndBuyList:(NSDictionary *)dic type:(int)type page:(int)page; //供求 合并
-(NSDictionary *)parseGetSupplyCommentList:(NSDictionary*)dic; //获取评论列表
-(NSDictionary *)parseGetNearUserList:(NSDictionary*)dic;//附近的人列表
-(NSDictionary *)getQueryCompanyList:(NSDictionary *)dic;//查询公司

-(NSDictionary *)getQueryFindOutList:(NSDictionary *)dic;//看过我的
-(NSDictionary *)getQueryClickLikeList:(NSDictionary *)dic; //查询点赞列表

-(NSDictionary *)getCollectionSupplyAndWantBuyList:(NSDictionary *)dic type:(int)type; // 我收藏的 供应和求购
//读取收藏 话题
-(NSDictionary *)getCollectionTopicList:(NSDictionary *)dic;
-(NSDictionary *)getCommentMeList:(NSDictionary *)dic;  // 评论我的
-(NSDictionary *)parseGetContactList:(NSDictionary *)dic;//人脉
-(MTSupplyAndBuyListModel *)getSupplyAndBuyForDic:(NSDictionary *)dic type:(int)type;
-(MTTopicListModel *)getTopicModelForDic:(NSDictionary *)itemDic;

-(NSDictionary *)getFans:(NSDictionary *)dic;//粉丝列表
-(NSDictionary *)getConnection:(NSDictionary *)dic;//人脉列表
- (NSDictionary *)getNewsList:(NSDictionary *)dic;//行业资讯
-(NSDictionary *)getSupplyAndBuyList:(NSDictionary *)dic  page:(int)page;//供求大厅
-(MTNewSupplyAndBuyListModel *)getNewSupplyAndBuyModel:(NSDictionary *)dic; // 供求数据转成模型
-(NSDictionary *)getThemeAndInformation:(NSDictionary *)dic;

-(NSDictionary *)getTopicForId:(NSDictionary *)dic;
-(NSDictionary *)getActivityList:(NSDictionary *)dic tag:(int)tag; //获取活动列表

- (NSDictionary *)getaddActivties:(NSDictionary *)Dic tag:(int)tag;//提交活动

-(NSDictionary *)GetThemeList:(NSDictionary *)dic page:(int)page; //获取 主题列表信息
-(ThemeListModel*)parseThemeList:(NSDictionary *)dic;
- (NSDictionary *)getNewsDetailContent:(NSDictionary *)dic;//获取资讯详情
- (NSDictionary *)getImageNewsDetailContent:(NSDictionary *)dic;//获取图集资讯详情

- (NSDictionary *)getPushNewsDetailContent:(NSDictionary *)dic;//广告资讯详情
- (NSDictionary *)getEPCloudlistData:(NSDictionary *)dic;//企业云列表
- (NSDictionary *)getCompanyTrackData:(NSDictionary *)dic;//企业动态列表
- (NSDictionary *)getCompanyCommentListData:(NSDictionary *)dic;//企业云评论列表
- (NSDictionary *)getinvatedFriendsList:(NSDictionary *)dic;//邀请好友统计

- (NSDictionary *)getBindCompanyListData:(NSDictionary *)dic;//绑定企业列表

- (NSDictionary *)getVoteListData:(NSDictionary *)dic;//投票活动首页

- (NSDictionary *)getVoteChartisListData:(NSDictionary *)dic;//投票排行榜


- (NSDictionary *)getVoteDetailtData:(NSDictionary *)dic;//投票个人详情

-(MTNewSupplyAndBuyListModel *)getNewSupplyAndBuyForOld:(MTSupplyAndBuyListModel*)model type:(int)type;  //旧模型转新模型
- (NSDictionary *)getAddCrowdOrderData:(NSDictionary *)dic;//众筹订单
- (NSDictionary *)getEPCloudUserInfoData:(NSDictionary *)dic;//获取用户加入园林云的信息

- (NSDictionary *)searchCompanyList:(NSDictionary *)dic;//搜索公司全称
- (NSDictionary *)CompanyInfoWith:(NSDictionary *)dic;//搜索得到的公司信息

-(NSDictionary *)searchJianliList:(NSDictionary *)dic;//简历列表

-(NSDictionary *)searchJianliListJobName:(NSDictionary *)dic;//搜索简历

-(NSDictionary *)recommendConnection:(NSDictionary *)dic;//推荐人脉

-(NSDictionary *)recommendCompany:(NSDictionary *)dic;//推荐企业

-(NSDictionary *)selectMyQuestionByUserId:(NSDictionary *)dic;//我发布的问题


-(NSDictionary *)selectNurseryDetailListByPage:(NSDictionary *)dic;//苗木云列表

@end
