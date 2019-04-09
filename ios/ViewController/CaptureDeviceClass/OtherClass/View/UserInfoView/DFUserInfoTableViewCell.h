//
//  DFUserInfoTableViewCell.h
//  DF
//
//  Created by 苏浩楠 on 2017/11/30.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "ClassyLiveLayout.h"

@interface DFUserInfoTableViewCell : SHPAbstractTableViewCell

/**标题*/
@property (nonatomic,readonly) UILabel *nameLab;
/**副标题*/
@property (nonatomic,readonly) UILabel *detailNameLab;

@end
