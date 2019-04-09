//
//  MyMiaoBiTableViewCell.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/12/18.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "MyMiaoBiTableViewCell.h"

@implementation MyMiaoBiTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        [self createSubViews];
    }
    return self;
}
- (void) createSubViews {
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(kWidth(12), 0, iPhoneWidth - kWidth(24), kWidth(61))];
    _bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_bgView];
    
    UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(kWidth(14), 0, _bgView.width - kWidth(28), 1)];
    lineLab.backgroundColor = kColor(@"#E5E5E5");
    [_bgView addSubview:lineLab];
    
    _infoLab = [[UILabel alloc] initWithFrame:CGRectMake(kWidth(20), lineLab.bottom + kWidth(12), _bgView.width - kWidth(40), kWidth(13))];
    _infoLab.textColor = kColor(@"#333333");
    _infoLab.font = sysFont(font(14));
    [_bgView addSubview:_infoLab];
    
    _monthLab = [[UILabel alloc] initWithFrame:CGRectMake(_infoLab.left, _infoLab.bottom + kWidth(13), kWidth(80), kWidth(13))];
    _monthLab.textColor = kColor(@"#757575");
    _monthLab.font = sysFont(font(12));
    [_bgView addSubview:_monthLab];
    
    _addOrRLab = [[UILabel alloc] initWithFrame:CGRectMake(_bgView.width - kWidth(23) - kWidth(50), kWidth(13), kWidth(50), kWidth(13))];
    _addOrRLab.textColor = kColor(@"#FF3C0A");
    _addOrRLab.font = sysFont(font(16));
    _addOrRLab.centerY = _bgView.height/2.;
    _addOrRLab.textAlignment = NSTextAlignmentRight;
    [_bgView addSubview:_addOrRLab];
}

- (void)updatapointsRecordsModel:(pointsRecordsModel *)model {
    _infoLab.text = model.ruleName;
    _monthLab.text = model.createTime;
    _addOrRLab.text = model.addOrReduce;
    if ([model.addOrReduce integerValue] > 0) {
         _addOrRLab.textColor = kColor(@"#FFB400");
    }else {
        _addOrRLab.textColor = kColor(@"#FF3C0A");
    }
}
@end
