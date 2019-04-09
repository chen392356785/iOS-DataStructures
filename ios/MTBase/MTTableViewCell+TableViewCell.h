//
//  MTTableViewCell+TableViewCell.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/5/25.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTTableViewCell.h"

@interface MTTableViewCell (TableViewCell)

@end


@interface LogisticsFindCarTableViewCell : MTTableViewCell
@property (nonatomic,copy) DidSelectheadImageBlock selectBlock;

@end



@interface LogisticsFindGoodsTableViewCell : MTTableViewCell
@property (nonatomic,copy) DidSelectheadImageBlock selectBlock;

@end


@class ThemeListModel;
@interface MTNewTopicListTableViewCell : MTTableViewCell
{
    UIImageView *_imageView;
    SMLabel *_seeLbl;
    SMLabel *_plLbl;
}
@property (nonatomic, strong) SMLabel *nameLabel;
@property (nonatomic, strong) SMLabel *detailLabel;
-(void)setData:(ThemeListModel *)model;
@end




@class MTTopicListModel;
@class NewsListModel;
@interface HomePageTableViewCell : MTTableViewCell
{
    UIAsyncImageView *_imageView;
    SMLabel *_titleLbl;
    SMLabel *_messLbl;
    SMLabel *_userLbl;
    UIImageView *_ImageView;
}
//-(void)setDataWithTopicModel:(HomePageTopicModel *)model;
-(void)setDataWithNewsModel:(NewsListModel *)model;
@end




@interface HomePageHotTopicTableViewCell : MTTableViewCell
{
    UIAsyncImageView *_imageView;
    SMLabel *_titleLbl;
    SMLabel *_messLbl;
    SMLabel *_userLbl;
}
-(void)setDataWithIndepath:(NSIndexPath *)indexpath TopicModel:(HomePageTopicModel *)model;
@end

#import "EDStarRating.h"
@interface EPCloudTableViewCell : MTTableViewCell<EDStarRatingProtocol>
{
    EDStarRating *_ratingImage;
    UIAsyncImageView *_heardImg;
    UIAsyncImageView *_companyImg;
    SMLabel *_companyLbl;
    SMLabel *_companyInfo;
    SMLabel *_companyType;
}
- (void)setlistModel:(EPCloudListModel *)model;
@end

@interface companyTrackCell : MTTableViewCell
{
    UIAsyncImageView *_heardImg;
    SMLabel *_userLbl;
    SMLabel *_contentLbl;
    SMLabel *_priceLbl;
    SMLabel *_needLbl;
}

- (void)setTrackData:(CompanyTrackModel *)model;
@end

@interface EPCloudCumlativeTableViewCell : MTTableViewCell
{
    UIImageView *_imageView;
    UIImageView *_ToimageView;
    UIImageView *_RightimageView;
    SMLabel *_lbl;
    
}
-(void)setDataWithArr:(NSDictionary *)dic;

@end

@interface EPCloudCommentListCell : MTTableViewCell<EDStarRatingProtocol>
{
    EDStarRating *_ratingImage;
    UIAsyncImageView *_companyImg;
    SMLabel *_userlabel;
    SMLabel *_contentlbl;
    SMLabel *_timeLbl;
    UIView *_lineView;
}
- (void)setDate:(companyListModel *)model;
@end

@interface FriendCell : MTTableViewCell
{
    UIAsyncImageView *_imageView;
    SMLabel *_namelbl;
    SMLabel *_timelbl;
    SMLabel *_moneylbl;
    SMLabel *_statelbl;
    SMLabel *_phonelbl;
}
- (void)setData:(InvatedFriendslistModel *)model;
@end


@interface BindCompanyListCell : MTTableViewCell<EDStarRatingProtocol>
{
    EDStarRating *_ratingImage;
    UIAsyncImageView *_heardImg;
    UIAsyncImageView *_companyImg;
    SMLabel *_companyLbl;
    SMLabel *_companyInfo;
    SMLabel *_companyType;
}
- (void)setlistModel:(BindCompanyModel *)model;
@end

@class MTConnectionModel;
@class ConnectionsView;


@interface EPCloudConnectionTableViewCell : MTTableViewCell
{
    ConnectionsView *_view;
}
@property(nonatomic,strong)ConnectionsView *view;

-(void)setDataWithModel:(MTConnectionModel *)model;
@end


@class MTFansModel;
@interface EPCloudFansTableViewCell : MTTableViewCell
{
    UIAsyncImageView *_imageView;
    UIAsyncImageView *_VipimageView;
    SMLabel *_nickname;
    UIButton *_btn;
    SMLabel *_title;
}
-(void)setDataWith;
@property(nonatomic,strong)MTFansModel *model;
@end




@interface MTChartsTableViewCell : MTTableViewCell
{
    UIImageView *_imageView;
    SMLabel *_number;
    UIAsyncImageView *_headImageView;
    SMLabel *_namelbl;
    SMLabel *_voteNumlbl;
    SMLabel *_inforlbl;
    SMLabel *_ratiolbl;
    
}

-(void)setDataWith:(NSIndexPath *)indexPath model:(VoteListModel *)model;
@end


//众筹
@interface CrowdFundingTableViewCell : MTTableViewCell
{
    UIAsyncImageView *_headImageView;
    SMLabel *_namelbl;
    SMLabel *_priceLbl;
    SMLabel *_messageLbl;
    SMLabel *_timeLbl;
    UIImageView *_imageView;

}
@property(nonatomic,copy)DidSelectBtnBlock selectBtnBlock;
-(void)setDataWith:(CrowdListModel *)model;
@end





