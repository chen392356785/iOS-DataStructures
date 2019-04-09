//
//  ActivityView.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/5/4.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "CustomView.h"

@interface ActivityView : CustomView
{
    UIAsyncImageView *_topImageView;
    SMLabel *_addressLabel;
    SMLabel *_timeLabel;
    SMLabel *_titileLabel;
    SMLabel *_priceLabel;
    
}
@property (nonatomic,strong)UIButton *signBtu;
//- (void)setActivitiesData:(ActivitiesListModel *)model;

@end
