//
//  HomeSearchCollectionViewCell.h
//  MiaoTuProject
//
//  Created by tinghua on 2018/9/21.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomSearchModel.h"
@interface HomeSearchCollectionViewCell : UITableViewCell

@end

@interface YuanLinSearchViewCell : UITableViewCell {
    EPImageView *_epImageView;
    SMLabel *_titleLbl;
    SMLabel *_personLbl;
    SMLabel *_telphoneLbl;
    SMLabel *_adressLbl;
//    UIView *_lineView1;
}
- (void) setHomeSearchCellModel:(HomSearchModel *)Model;
@end

@interface QiYeSearchViewCell : IHTableViewCell
@property(nonatomic,strong)NSMutableArray *ItemArray;
//- (void) setHomeSearchCellModel:(HomSearchModel *)Model;
@end

@interface RenMaiSearchViewCell : UITableViewCell {
    UIAsyncImageView *iconView;
    SMLabel *nameLabel;
    SMLabel *conLabel;
}

- (void) setHomeSearchCellModel:(HomSearchModel *)Model;
@end
