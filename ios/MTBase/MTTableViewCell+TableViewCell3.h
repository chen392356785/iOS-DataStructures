//
//  MTTableViewCell+TableViewCell3.h
//  MiaoTuProject
//
//  Created by 徐斌 on 2016/12/5.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTTableViewCell.h"
@class HomeInformationModel,HomeVarietiesModel,HomeCompanyModel,HomeContactsModel,ScoreHistoryModel,ScoreDetailModel;
@interface MTTableViewCell (TableViewCell3)

@end


//热门资讯
@interface HotInformationTableViewCell : IHTableViewCell
{
    UIScrollView *_scroll;
}
@property(nonatomic,strong)NSMutableArray *ItemArray;

@end

//中苗会战略合作企业
@interface ZhanLueQiYeTableViewCell : IHTableViewCell
{
    UIScrollView *_scroll;
}
@property(nonatomic,strong)NSMutableArray *ItemArray;

@end

//新品种图库
@interface HotXinPinZhongTableViewCell : IHTableViewCell{
    UIScrollView *_scroll;
}
@property(nonatomic,strong)NSMutableArray *ItemArray;

@end

//热门品种
@interface HotVarietiesTableViewCell  : IHTableViewCell
@property(nonatomic,strong)NSMutableArray *ItemArray;

@end

//热门企业
@interface HotCompanyTableViewCell : IHTableViewCell
@property(nonatomic,strong)NSMutableArray *ItemArray;

@end
//热门人脉
@interface HotContactsTableViewCell : IHTableViewCell
@property(nonatomic,strong)NSMutableArray *ItemArray;
 
@end

//兑换记录
@interface ScoreHistoryCell : MTTableViewCell
{
    SMLabel *_orderNumLbl;
    SMLabel *_stateLbl;
    UIAsyncImageView *_imageView;
    SMLabel *_timeLbl;
    
    SMLabel *_typeLbl;
    SMLabel *_nameLbl;
    SMLabel *_priceLbl;
    SMLabel *_numLbl;
    SMLabel *_contentLbl;
}

- (void)setHistory:(ScoreHistoryModel *)model;
@end

//积分使用情况cell
@interface ScoreConvertCell : MTTableViewCell
{
    SMLabel *_lbl;
    SMLabel *_timeLbl;
    SMLabel *_numLbl;
    
}
- (void)setDetail:(ScoreDetailModel *)model;
@end

//找车
@class FindCarModel;
@interface FindCarTableViewCell : MTTableViewCell
{
    SMLabel *_discLbl;
    SMLabel *_chufaLbl;
    SMLabel *_mudiLbl;
    UIImageView *_toImageView;
    SMLabel *_cityLbl;
    UIAsyncImageView *_headImageView;
    SMLabel *_nameLbl;
    SMLabel *_yaoqiuLbl;
    SMLabel *_timeLbl;
    UIButton *_lianxiBtn;
    UIButton *_phoneBtn;
}
-(void)setDataWithModel:(FindCarModel *)model;
@end

@class OwnerFaBuModel;
@interface LogisyicsMyFaBuTableViewCell : MTTableViewCell
{
    SMLabel *_discLbl;
    SMLabel *_chufaLbl;
    SMLabel *_mudiLbl;
    UIImageView *_toImageView;
    SMLabel *_cityLbl;
    UIAsyncImageView *_headImageView;
    SMLabel *_nameLbl;
    SMLabel *_yaoqiuLbl;
    SMLabel *_typeLbl;
    SMLabel *_timeLbl;
    SMLabel *_carTimeLbl;
    UIButton *_editBtn;
    UIButton *_deleteBtn;
    UIView *_lineView;
}
-(void)setDataWith:(OwnerFaBuModel *)model;
@end
@class CheYuanModel;
@interface DriverCheYuanTableViewCell : MTTableViewCell
{
    SMLabel *_discLbl;
    SMLabel *_chufaLbl;
    SMLabel *_mudiLbl;
    UIImageView *_toImageView;
    SMLabel *_cityLbl;
    SMLabel *_typeLbl;
    SMLabel *_timeLbl;
}
-(void)setDataWith:(CheYuanModel *)model;
@end

@interface DriverRenZhengTableViewCell : MTTableViewCell
{
    UIImageView *_imageView;
    SMLabel *_name;
    SMLabel *_lbl;
}
-(void)setDataWith:(NSDictionary *)dic;
@end





