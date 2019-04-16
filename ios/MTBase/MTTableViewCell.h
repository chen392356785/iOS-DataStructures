//
//  MTTableViewCell.h
//  MiaoTuProject
//
//  Created by Mac on 16/3/10.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "IHTableViewCell.h"
@class HeaderView;
@class BuyListView;
@interface MTTableViewCell : IHTableViewCell

@end

@class MTNearUserModel;
@interface MapUserListTableViewCell : MTTableViewCell
{
	UIImageView *_idImageView;
	UIAsyncImageView *_headView;
	SMLabel *_lbl;
	SMLabel *_lbl1;
	UIButton *_companyBtn;
	UIButton *_distanceBtn;
	UIButton *_certifyBtn;
}

@property(nonatomic,strong)MTNearUserModel *model;
-(void)setData:(NSIndexPath *)indexPath;

@end


 


@class HeadButton;
@class CommentListModel;
@interface GongQiuDetailsListTableViewCell : MTTableViewCell
{
//    UIImageView *_idImageView;
    HeadButton *_headBtn;
    SMLabel *_nicknamelbl;
    SMLabel *_contentlbl;
    SMLabel *_timelbl;
}
-(void)setData;
@property(nonatomic,strong)CommentListModel *model;
@end


@class MTNearUserModel;
@class MTContactView;
@class BQView;
@interface MTContactTableViewCell : MTTableViewCell
{
 
    UIImageView *_logoImageView;
    UIAsyncImageView *_headImgView;
    SMLabel *_nickNameLbl;
    UIImageView *_sexImageView;
    SMLabel *_companyLbl;
    SMLabel *_positionLbl;
    SMLabel *_typeLbl;
//    UIImageView *_typeImageView;
    SMLabel *_lbl;
//    NSString *_str;
//    HeadButton *_headBtn;
    UIImageView *_imageView;
//    UIImageView *_bkImageView;
//    CGFloat _x;
//    UIImageView *_imageview;
    BQView *_bqView;

}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(ContactType)type;
@property(nonatomic,strong)MTNearUserModel *model;
-(void)setDataWithType:(ContactType)type;
@end

@interface MTCollectionTableViewCell : MTTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(CollecgtionType)type;
@end

@class MTCommentMeModel;
@interface CommentForMeListTableViewCell : MTTableViewCell
{
    HeadButton *_headView;
    SMLabel *_timelbl;
    SMLabel *_namelbl;
    UIImageView *_sexImage;
    SMLabel *_contentlbl;
    UIView *_contenView;
    
    UIAsyncImageView *_imgView;
    SMLabel *_titlelbl;
    UIImageView *_typeImage;
    UIView *_downView;
    SMLabel *_mecomentlbl;
    UIView *_lineView;
//    UIImageView *_idImageView;
    
}
-(void)setData;
@property(nonatomic,strong)MTCommentMeModel *model;

@end

@class UserChildrenInfo;
@interface MapSearchListTableViewCell : MTTableViewCell
{
//    UIImage *_adressImg;
//    SMLabel *_lbl;
//    UIImageView *_adressImageView;
//     UIImageView *_idImageView;
    

    UIImageView *_idImageView;
    UIAsyncImageView *_headView;
    SMLabel *_lbl;
    SMLabel *_lbl1;
    UIButton *_companyBtn;
    UIButton *_distanceBtn;
    UIButton *_certifyBtn;
}
//@property(nonatomic,strong)UserChildrenInfo *model;
//-(void)setData;
-(void)setData:(UserChildrenInfo *)model;
@end
@class UserChildrenInfo;
@interface FindOutListTableViewCell : MTTableViewCell
{   SMLabel *_timeLbl;
    HeadButton *_headView;
    SMLabel *_nickNameLbl;
    SMLabel *_adressLbl;
//    UIImageView *_adressImageView;
//    UIImageView *_sexImageView;
//    UIImageView *_idImageView;
    UIImageView *_imageView;
}
@property(nonatomic,strong)UserChildrenInfo *model;
-(void)setData:(UserChildrenInfo *)model;
@end

@class ProvinceModel;
@interface ProvinceListTableViewCell : MTTableViewCell
@property(nonatomic,strong)SMLabel *lbl;
-(void)fillCellWithModel:(ProvinceModel *)model;
@end

@class SectionModel;
@interface CityListTableViewCell : MTTableViewCell
@property(nonatomic,strong)SMLabel *lbl;
-(void)fillCellWithModel:(SectionModel *)model :(NSIndexPath *)indexPath;
@end




@class CornerView;

@interface MTMeListTableViewCell: MTTableViewCell
{
    UIImageView *_typeImageView;
    SMLabel *_lbl;
    SMLabel *_valuelbl;
}
@property(nonatomic,strong)CornerView *numView;
@property(nonatomic,strong) UIImageView *typeImageView;
-(void)setDataWithDic:(NSDictionary *)dic;
@end



#pragma mark 活动列表
@class ActivitiesListModel;
@class ActivityView;
@interface ActivityTableViewCell : MTTableViewCell
{
//    ActivityView *_activityView;
    UIAsyncImageView *_topImageView;
//    UIAsyncImageView *_endImageView;
//    UIAsyncImageView *_stateImgView;
    SMLabel *_zhuangtaiLabel;
    UIView *_zhuangtaiView;
    SMLabel *_addressLabel;
    UILabel *_timeLabel;
    SMLabel *_titileLabel;
    SMLabel *_priceLabel;
    SMLabel *_endTime;
//    SMLabel *_collectLabel;
    UILabel *_lineLabel;
    UIButton *_cancleBtu;
//    UIImageView *_timeImageView;
//    UIButton *_shareImageView;
    UIImageView *_adressImageView;
//    UIView *_lineView;
//    UIView *_lineView2;
//    UIView *_blackView;
    UIView *_backV;
    SMLabel *_totalMoney;
    SMLabel *_obtainMoney;
    
}
@property (nonatomic,strong)UIButton *signBtu;
@property (nonatomic,strong)UIButton *collectBtu;
@property (nonatomic,strong)UIButton *lookBtu;
@property(nonatomic,strong)ActivitiesListModel *mod;
@property (nonatomic,strong)NSString *ActvType;         //1为活动列表，2为我的活动列表
- (void)setDataWithModel:(ActivitiesListModel *)mod;
@end



#pragma mark 身份列表
@interface MTIdentTableViewCell :MTTableViewCell
{
    UIAsyncImageView *_headerImgView;
    UIAsyncImageView *_ImgView;
    SMLabel *_nickNameLbl;
    SMLabel *_titleLbl;
    SMLabel *_advantageLbl;
    UIButton *_btn;
}
-(void)setDataWithDic:(NSDictionary *)dic;
-(void)btnhide;
@property(nonatomic,copy)DidSelectBtnBlock selectBtnBlock;
@end


#pragma mark 我的任务信息

@protocol BtnClick <NSObject>

- (void)goTask:(id)sender;

@end

@interface MyTaskTableViewCell : MTTableViewCell
{
    SMLabel * _tittle;
    UIButton * _gradeBtn;
    
}
@property (nonatomic,strong)UIButton * finishBtn;
@property(nonatomic,weak) id<BtnClick,BCBaseTableViewCellDelegate>delegate;
- (void)setDataWithDic:(NSDictionary *)dic withInfoDic:(NSDictionary *)dic2;
@end

@interface ActivitiesClikeCell : MTTableViewCell
{
    HeadButton *_heardView;
    SMLabel *_nicknamelbl;
    UserChildrenInfo *_model;
}

- (void)setUserInfo:(UserChildrenInfo *)model;
@end













