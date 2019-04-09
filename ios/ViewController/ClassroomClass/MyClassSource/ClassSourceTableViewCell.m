//
//  ClassSourceTableViewCell.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/10/29.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "ClassSourceTableViewCell.h"


@interface ClassSourceTableViewCell () {
    UIImageView *_iconImageV;
    SMLabel *_titleLabel;
    UILabel *_timeLabel;
    UILabel *_typeLabel;
    UILabel *_lastLabel;
}

@end

@implementation ClassSourceTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self creareSubview];
    }
    return self;
}
- (void) creareSubview {
    _iconImageV = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth(12), kWidth(22), kWidth(116), kWidth(78))];
    _iconImageV.layer.cornerRadius = 5;
    _iconImageV.clipsToBounds = YES;
    [self.contentView addSubview:_iconImageV];
    
    
    _titleLabel = [[SMLabel alloc] initWithFrame:CGRectMake(_iconImageV.right  + kWidth(12), _iconImageV.top, iPhoneWidth - _iconImageV.right - kWidth(24), _iconImageV.height/2 - 5)];
    _titleLabel.numberOfLines = 2;
    _titleLabel.verticalAlignment = VerticalAlignmentTop;
    _titleLabel.font = sysFont(14);
    _titleLabel.text = @"恒大帝景“甜心萌鬼，趣玩万圣”节日主题活动在大家的欢声笑语中落下帷幕了。";
    _titleLabel.textColor = kColor(@"#000000");
    [self.contentView addSubview:_titleLabel];
    
    _timeLabel =  [[UILabel alloc] initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom + 5 , kWidth(111), _titleLabel.height/2)];
    _timeLabel.font = sysFont(12);
    _timeLabel.textColor = kColor(@"#8c8c8c");
//    _timeLabel.text = @"已更新";
    [self.contentView addSubview:_timeLabel];
    
    _lastLabel = [[UILabel alloc] initWithFrame:CGRectMake(iPhoneWidth - kWidth(24) - kWidth(130), _timeLabel.top , kWidth(130), height(_timeLabel))];
    _lastLabel.font = sysFont(12);
    _lastLabel.textAlignment = NSTextAlignmentRight;
    _lastLabel.textColor = kColor(@"#8c8c8c");
//    _lastLabel.text = @"03:23";
    [self.contentView addSubview:_lastLabel];
    
    _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_titleLabel.left, _timeLabel.bottom + 5 , kWidth(111), height(_timeLabel))];
    _typeLabel.font = sysFont(12);
//    _typeLabel.text = @"已更新3/5节";
    [self.contentView addSubview:_typeLabel];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0.5, iPhoneWidth, 1)];
    line.backgroundColor = cLineColor;
    [self.contentView addSubview:line];
}
- (void)setDataWith:(MyClassSourceListModel *)Model isHistort:(BOOL) isHistory {
    _titleLabel.text = Model.class_name;
    [_iconImageV sd_setImageWithURL:[NSURL URLWithString:Model.head_pic] placeholderImage:DefaultImage_logo];
    if (isHistory == YES) {
        _timeLabel.text = [NSString stringWithFormat:@"时长：%@",Model.sub_hms_time];
        _lastLabel.text = [NSString stringWithFormat:@"上次学到:%@",Model.last_hms_time];
        if ([Model.xuexi_status isEqualToString:@"1"]) {
            _typeLabel.text = @"已完成";
            _typeLabel.textColor = kColor(@"#32c243");
        }else {
            _typeLabel.text = @"继续学习";
            _typeLabel.textColor = kColor(@"#df2121");
        }
    }else {
        _timeLabel.frame = CGRectMake(_titleLabel.left, _titleLabel.bottom + 5, _titleLabel.width, _timeLabel.height/2+5);
        _typeLabel.frame =CGRectMake(_titleLabel.left, _timeLabel.bottom + 8, _typeLabel.width, _typeLabel.height);
        _lastLabel.frame = CGRectMake(_typeLabel.right, _typeLabel.top , _titleLabel.width - _typeLabel.width, _typeLabel.height);
        if ([Model.is_update isEqualToString:@"1"]) {   //已更新
            if ([Model.kan_jindu intValue] < 100) {
                if ([Model.yigeng_num intValue] == [Model.class_num intValue]) {
                    
                    _timeLabel.text = @"已全部更新,赶紧去学习吧！";
                    _timeLabel.textColor = kColor(@"#df2121");
                }else {
                    _timeLabel.text = @"课程有更新,赶紧去学习吧!";
                    _timeLabel.textColor = kColor(@"#df2121");
                }
            }else {
                _timeLabel.text = @"最新课程您已全部学习完!";
                _timeLabel.textColor = kColor(@"#32c243");
            }
        }else { //未更新
            if ([Model.kan_jindu intValue] < 100) {
//                _timeLabel.text = @"已全部更新您还有未学习课程赶紧去学习吧！";
                _timeLabel.text = @"您还有未学习课程赶紧去学习吧！";
                _timeLabel.textColor = kColor(@"#df2121");
            }else {
                if ([Model.yigeng_num intValue] == [Model.class_num intValue]) {
                    _timeLabel.text = @"全部课程已学习完！";
                    _timeLabel.textColor = kColor(@"#32c243");
                   
                }else {
                    _timeLabel.text = @"最新课程您已全部学完！";
                    _timeLabel.textColor = kColor(@"#32c243");
                }
                
            }
        }
        _typeLabel.text = [NSString stringWithFormat:@"%@",Model.class_jindu];
        _lastLabel.text = [NSString stringWithFormat:@"已完成 %@%@",Model.kan_jindu,@"%"];
        
    }
}

@end
