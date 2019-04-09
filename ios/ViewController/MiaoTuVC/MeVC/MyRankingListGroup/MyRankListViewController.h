//
//  MyRankListViewController.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/12/18.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "SMBaseViewController.h"
#import "RankListModel.h"
@interface MyRankListTableViewCell : UITableViewCell {
    UIImageView *rightImgV;
    UILabel *NumLab;       //名次
    UILabel *nameLab;      //名字
    UILabel *fensLab;      //粉丝
    UILabel *miaoBLab;     //苗途币
}
- (void)updataRankListModel:(RankListModel *)model;
@end


@interface MyRankListViewController : SMBaseViewController

@property (nonatomic,copy) NSString *typeStr;
@end
