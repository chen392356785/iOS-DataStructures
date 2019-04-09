//
//  MeMainCollectionViewCell.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/12/11.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoDataModel.h"
#import "HeadBannerView.h"

@interface MeMainCollectionViewCell : UICollectionViewCell

@end


@interface MeMainHeadCollectionViewCell : UICollectionViewCell {
    UIAsyncImageView *_headerImageView;
    SMLabel *_nickNameLbl;
    SMLabel *_isVipLbl;
    SMLabel *_VipTypeLbl;
    SMLabel *_AccountNumLbl;      //余额
    SMLabel *_kaquanNumLbl;       //卡券
    SMLabel *_MiaoBipNumLbl;      //苗途币
    SMLabel *_fensiNumLbl;        //粉丝
    SMLabel *_guanzhuNumLbl;      //关注
    UIButton *_settingBut;     //设置
    
}
@property (nonatomic, strong) userInfoModel *model;
@property (nonatomic, copy) DidSelectBlock UserEditBlock;               //编辑
@property (nonatomic, copy) DidSelectBlock JoinVipBlock;                //加入vip Or 续费
@property (nonatomic, copy) DidSelectBtnBlock UserItemBlock;            //卡卷 - 苗途币 - 粉丝 - 关注
@property (nonatomic, copy) DidSelectBlock SettingBlock;                //设置
@property (nonatomic, strong) UserInfoDataModel *Umodel;
@property (nonatomic, copy) DidSelectBlock duihuanBlock;                //兑换
@end




@interface MeMainVipCollectionViewCell : UICollectionViewCell {
    UIScrollView *_bgScrollView;
}
@property (nonatomic, strong) pointParamsModel *model;
@property (nonatomic, copy) DidSelectheadImageBlock VipItemBlock;

@end

typedef void (^DidSelectModelBlock) (pointsAdvListModel *pModel);

@interface MeMainLunboCollectionViewCell : UICollectionViewCell {
   HeadBannerView *_scrollView;
    NSMutableArray *_imgsArr;
    NSMutableArray *_modelArr;
}
@property (nonatomic, strong) pointParamsModel *model;
//@property (nonatomic, copy) DidSelectheadImageBlock ItemBlock;
@property (nonatomic, copy) DidSelectModelBlock ItemBlock;
@property (strong ,nonatomic) NSArray *imageArray;

@end


@interface MeMainToolCollectionViewCell : UICollectionViewCell {
     UIAsyncImageView *_iconImageView;
     SMLabel *_titleLbl;
}
@property(nonatomic,strong)CornerView *BadgeView;   //角标

@property (nonatomic, strong) pointsAdvListModel *model;
@end


@interface ZHCollectionCell : UICollectionViewCell
@property (strong ,nonatomic) UIImageView * imageView;
-(void)addDataSourceToCell:(NSString*)imageName;
@end
