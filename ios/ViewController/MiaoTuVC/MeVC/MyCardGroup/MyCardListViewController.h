//
//  MyCardListViewController.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/12/20.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "SMBaseViewController.h"
#import "UserInfoDataModel.h"

@interface MyCarListTableViewCell : UITableViewCell {
    UIImageView *_bgImgV;
    UILabel *_priceLab;
    UILabel *_priceNumLab;
    UIButton *_button;
    UILabel *_timeLab;
    UIView *_lineView;
}
@property (nonatomic, copy) DidSelectBlock goUseCarBlock;  //去使用
- (void) updataCardModel:(CardListModel *)model andCodeType:(NSString *)code;
@end




@interface MyCardListViewController : SMBaseViewController

@property (nonatomic,copy) NSString *typeStr; //0  未使用  1 已使用  2已失效
@end
