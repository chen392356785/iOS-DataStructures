//
//  MTBaseCollectionViewCell.h
//  MiaoTuProject
//
//  Created by Mac on 16/3/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTModel.h"

@interface MTBaseCollectionViewCell : UICollectionViewCell

@end

@interface CreateBSCollectionViewCell : MTBaseCollectionViewCell
{
//    UIImageView *imgView;
//    UIButton *_btn;
}

@property(nonatomic,strong)UIButton *deleteBtn;
@property(nonatomic,strong)UIAsyncImageView *m_imgView;


@end





@interface ConnectionsCollectionViewCell : MTBaseCollectionViewCell

@end


@interface ActivityVoteCollectionViewCell : MTBaseCollectionViewCell
{
    UIAsyncImageView *_heardImg;
    SMLabel *_nameLbl;
    SMLabel *_voteNumLbl;
    SMLabel *_infoLbl;
    SMLabel *_contentLbl;

    
}
@property(nonatomic,copy)DidSelectBtnBlock selectBtnBlock;

- (void)setCollectionViewData:(VoteListModel *)model;
@end

@interface EPCloudCompanyCollectionView : MTBaseCollectionViewCell
{
    UIAsyncImageView *_companyImg;
    SMLabel *_nameLbl;
}
@property(nonatomic,copy)DidSelectBtnBlock selectBlock;
@property(nonatomic)EPType type;
- (id)initWithFrame:(CGRect)frame;
- (void)setCollectionViewCompanyData:(EPCloudListModel *)model;//企业云加载数据
@end

@interface EPCloudConnectionCollectionView : MTBaseCollectionViewCell
{
    UIAsyncImageView *_companyImg;
    SMLabel *_nameLbl;
}
@property(nonatomic)EPType type;
@property(nonatomic,copy)DidSelectBtnBlock selectBlock;
- (id)initWithFrame:(CGRect)frame;
- (void)setCollectionViewConnectionData:(MTConnectionModel *)model;//人脉云加载数据

@end


//苗木云 item
@interface ECloudMiaoMuYunCollectionView : MTBaseCollectionViewCell
@property(nonatomic,copy)DidSelectBtnBlock selectBlock;
- (id)initWithFrame:(CGRect)frame;
@property(strong,nonatomic)UILabel *titleLab;
@property(nonatomic,strong)UIAsyncImageView *imgView;
@end

//苗木云 头部
@interface CloudMiaoMuYunHeaderView :UICollectionReusableView
@property(nonatomic,strong)UIButton *btn;
@property(nonatomic,strong)UIImageView *imageView;
//添加一个lable用于显示内容
@property(strong,nonatomic)UILabel *titleLab;
@property(nonatomic,strong)UIAsyncImageView *imgView;
@property(nonatomic,copy)DidSelectBtnBlock selectBlock;
@end

@interface WeatherCityCollectionView : MTBaseCollectionViewCell
{
    SMLabel *_cityLbl;
    UIAsyncImageView *_weatherImg;
    SMLabel *_highLbl;
    SMLabel *_downLbl;
    SMLabel *_weatherLbl;
}
@property (nonatomic ,strong)UIButton *delegteBtn;
@property (nonatomic ,strong)UIButton *addBtn;
- (void)setWeatherData:(NSDictionary *)dic;
@end
