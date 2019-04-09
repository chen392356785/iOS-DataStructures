//
//  MTDataSource.h
//  MiaoTuProject
//
//  Created by Mac on 16/3/10.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "IHDataSource.h"
#import "GongQiuListTableViewCell.h"
#import "GuangChangTopicTableViewCell.h"
#import "NewsListTableViewCell.h"
@interface MTDataSource : IHDataSource

@end

@interface MapUserListDataSource : MTDataSource

@end


@interface GongQiuListDataSource : MTDataSource
@property(nonatomic)CollecgtionType type;
@property(nonatomic)PersonType personType;
@end

 

@interface GongQiuDetailsListDataSource : MTDataSource

@end

@interface GuangChangTopicDataSource : MTDataSource
@property(nonatomic)CollecgtionType type;
@end


@interface MTContactDataSource : MTDataSource
@property(nonatomic)ContactType type;
@end

@interface CommentForMeListDataSource : MTDataSource

@end

@interface MapSearchListDataSource : MTDataSource

@end

@interface FindOutListDataSource : MTDataSource

@end


@interface ProvinceListDataSource : MTDataSource
 
@end

@interface CityListDataSource : MTDataSource

@end

@interface MTMyCollectionSupplyAndBuyDataSource : MTDataSource
@property(nonatomic)CollecgtionType type;
@end

@interface MTMyCollectionTopicDataSource : MTDataSource
@property(nonatomic)CollecgtionType type;
@end

@interface MTOtherChildSupplyBuyDataSource : MTDataSource //供求 主页列表
@property(nonatomic)CollecgtionType type;
@end

@interface MTOtherChildTopicListDataSource : MTDataSource
@property(nonatomic)BOOL isMe;
@end



@interface MTMeListDataSource : MTDataSource
@property(nonatomic)BOOL ifMe;
@end

#pragma mark 行业资讯
@interface MTNewsDataSource : MTDataSource
{
    MTTableViewCell *_cell;
}
@end

#pragma mark 推荐资讯

@interface MTRecommentDataSource : MTDataSource

@end
#pragma mark 活动列表
@interface MtActivityDataSource : MTDataSource

@property(nonatomic,copy)NSString *actvType;

@end


@interface MTIdentDataSource : MTDataSource

@end


#pragma mark  我的任务

@interface MTThemeListDataSource : MTDataSource
@end
@interface MyTaskDataSource : MTDataSource




@end


@interface MTlogisticsFindCarDataSource : MTDataSource

@end


@interface MTlogisticsFindGoodsDataSource : MTDataSource

@end

#pragma mark - 活动点赞列表

@interface MTActivtiesClikeDataSource : MTDataSource

@end



@interface MTNewTopicDataSource : MTDataSource

@end



@interface EPCloudConnectionDataSource : MTDataSource

@end




@interface HomePageDataSource : MTDataSource

@end

@interface EPCloudDataSource : MTDataSource

@end

@interface CompanyTrackDataSource : MTDataSource


@end

@interface EPCloudCumlativeDataSource : MTDataSource

@end

@interface EPCloudCommentListDataSource : MTDataSource

@end


//粉丝
@interface EPCloudFansDataSource : MTDataSource

@end



@interface InvitedFriendsDataSource : MTDataSource

@end


@interface BindCompanyListDataCell : MTDataSource

@end


//供求大厅
@interface MTNewSupplyAndBuyDataSoure : MTDataSource

@end


//排行榜
@interface MTChartsDataSource : MTDataSource

@end



//众筹
@interface CrowdFundingDataSource : MTDataSource

@end

@interface EPCloudCompanyDataSource : MTDataSource

@end



//招聘
@interface ZhaoPingDataSource : MTDataSource
@property(nonatomic,assign)MyJobType Mytype;
@end

@interface JobWantedDataSource : MTDataSource

@property(nonatomic)CollecgtionType type;

@end

//简历详情
@interface CurriculumVitaeDataSource :MTDataSource


@end


//发布的职位
@interface MyPositionDataSource : MTDataSource

@end



@interface ChoosePositionDataSource : MTDataSource
{
    NSDictionary *_dic;
}
@end



@interface SearchPositionDataSource : MTDataSource

@end


@interface NewECloudConnectionSearchDataSource : MTDataSource

@end

@interface QuestionDataSource : MTDataSource
@property(nonatomic,assign)NSInteger integer;//用来判断是否有未回复消息
@end


@interface AskBarContentDataSource : MTDataSource

@end
@interface QuestionCommentDataSource : MTDataSource

@property(nonatomic)PersonType type;
@end

@interface MyReleaseSupplyOrBuyDataSource : MTDataSource
@property(nonatomic)buyType type;
@end



@interface MyReleaseTopicDataSource : MTDataSource

@end


@interface MyReleaseQuestionDataSource : MTDataSource

@end


@interface NurseryDataSource : MTDataSource//苗木云列表

@end


@interface NewsSearchDataSource : MTDataSource//资讯搜索结果

@end


