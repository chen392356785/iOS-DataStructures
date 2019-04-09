//
//  TeamCollectionViewCell.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/8/17.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "TeamCollectionViewCell.h"

@interface TeamCollectionViewCell () {
    UIAsyncImageView *IconImageView;
    UILabel *nameLabel;
    UILabel *TeamLabel;
    UILabel *contentLabel;
    UILabel *supLabel;
    UILabel *timeLabel;
    UILabel *picLabel;
}
@end

@implementation TeamCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self createLayoutSubView];
    }
    return self;
}
- (void) createLayoutSubView {
    IconImageView = [[UIAsyncImageView alloc] initWithFrame:CGRectMake(kWidth(10), kWidth(15), kWidth(65), kWidth(65))];
    IconImageView.layer.cornerRadius =width(IconImageView)/2.;
    IconImageView.image = Image(@"tx.png");
    [self addSubview:IconImageView];
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(maxX(IconImageView) + kWidth(8), minY(IconImageView), iPhoneWidth - maxX(IconImageView) - 30, 17)];
    nameLabel.text = @"花花";
    nameLabel.font = sysFont(font(17));
    [self addSubview:nameLabel];
    
    TeamLabel = [[UILabel alloc] initWithFrame:CGRectMake(minX(nameLabel), maxY(nameLabel) + kWidth(8), width(nameLabel), height(nameLabel))];
    TeamLabel.font = sysFont(font(17));
    TeamLabel.text = @"中国。梦之队";
    [self addSubview:TeamLabel];
    
    contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(minX(nameLabel), maxY(TeamLabel) + kWidth(5), width(nameLabel), height(nameLabel))];
    contentLabel.font = sysFont(font(15));
    contentLabel.text = @"世上并没有路，走的人多了就变成了路";
    contentLabel.textColor = kColor(@"#666666");
    [self addSubview:contentLabel];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, maxY(IconImageView) + kWidth(10), iPhoneWidth, 2)];
    [self addSubview:line];
    line.backgroundColor = cLineColor;
    
    supLabel = [[UILabel alloc] initWithFrame:CGRectMake(minX(IconImageView), maxY(line) + 5, iPhoneWidth - 2* minX(IconImageView), height(self) - maxY(line) - 27- 15)];
    supLabel.text = @"李世鑫、林劲、何冲、罗玉通、何冲、何超、秦凯、许国君、余隆基、孙知亦、张新华、林跃、周吕鑫、邱波、陈艾森 等支持了Ta";
    supLabel.numberOfLines = 3;
    [self addSubview:supLabel];
    supLabel.textColor = kColor(@"#666666");
    supLabel.font = sysFont(font(14));
    
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(minX(supLabel), maxY(supLabel)+ kWidth(10), iPhoneWidth/2 - 12, 17)];
    timeLabel.text = @"一个小时前";
    [self addSubview:timeLabel];
    timeLabel.font = sysFont(font(14));
    timeLabel.textColor = kColor(@"#666666");
    
    picLabel = [[UILabel alloc] initWithFrame:CGRectMake(maxX(timeLabel), minY(timeLabel), width(timeLabel), height(timeLabel))];
    picLabel.text = @"已筹 60000.00元";
    [self addSubview:picLabel];
    picLabel.textAlignment = NSTextAlignmentRight;
    picLabel.font = sysFont(font(14));
    
}
- (void)setTeamDaiyanRenActioviesModel:(zcouListModelModel *)model {
    NSString *imageUrlStr = [NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,model.head_image];
    [IconImageView setImageAsyncWithURL:imageUrlStr placeholderImage:Image(@"tx.png")];
    
    nameLabel.text = model.nickname;
    TeamLabel.text = model.team_name;
    contentLabel.text = model.talk;
    
    if ([model.zhongchouPeople isEqualToString:@""]) {
        supLabel.text = @"还没有人支持TA哦";
    }else {
        NSString *picStr = [NSString stringWithFormat:@"%@ %@",model.zhongchouPeople,@"支持了TA哦"];
//        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:picStr];
//        [attributedStr addAttribute:NSForegroundColorAttributeName value:kColor(@"#ff0000") range:NSMakeRange(0, model.zhongchouPeople.length)];
        supLabel.text = picStr;
        
    }
//    +(NSString *) compareCurrentTime:(NSString *) compareDateStr
    NSString *timeStr = [IHUtility compareCurrentTime:model.create_time];
//    NSLog(@"---------                 %@",timeStr);
    timeLabel.text = timeStr;
    
    NSString *picStr = [NSString stringWithFormat:@"已筹 %.@ 元",model.obtain_money];
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:picStr];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:kColor(@"#ff0000") range:NSMakeRange(3, model.obtain_money.length)];
    picLabel.attributedText = attributedStr;
}
@end
