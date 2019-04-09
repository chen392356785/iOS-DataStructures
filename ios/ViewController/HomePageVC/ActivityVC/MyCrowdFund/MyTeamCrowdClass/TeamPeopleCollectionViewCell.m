//
//  TeamPeopleCollectionViewCell.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/8/21.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "TeamPeopleCollectionViewCell.h"

@interface TeamPeopleCollectionViewCell () {
    UIAsyncImageView *HeadImageView;
    UILabel *nameLabel;
    UILabel *PicLabel;
    
    UIView *pgView;
    UIView *progresView;
    UILabel *biliLabel;
    
    
}
@end

@implementation TeamPeopleCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self createSubViewLayout];
    }
    return self;
}
- (void) createSubViewLayout {
    HeadImageView = [[UIAsyncImageView alloc] initWithFrame:CGRectMake(kWidth(12), kWidth(10), kWidth(55), kWidth(55))];
    HeadImageView.backgroundColor = [UIColor redColor];
    [self addSubview:HeadImageView];
    HeadImageView.layer.cornerRadius = width(HeadImageView)/2.;
    
    nameLabel  = [[UILabel alloc] initWithFrame:CGRectMake(maxX(HeadImageView) + kWidth(5), minY(HeadImageView) + kWidth(10), iPhoneWidth - maxX(HeadImageView) - kWidth(130), kWidth(20))];
    [self addSubview:nameLabel];
    nameLabel.text = @"好好先生";
    nameLabel.font = sysFont(font(16));
    
    PicLabel = [[UILabel alloc] initWithFrame:CGRectMake(iPhoneWidth - kWidth(130), minY(nameLabel), kWidth(120), height(nameLabel))];
    [self addSubview:PicLabel];
    PicLabel.text = @"还差3元";
    PicLabel.font = sysFont(font(16));
    PicLabel.textAlignment = NSTextAlignmentRight;
    
    
    pgView = [[UIView alloc] initWithFrame:CGRectMake(minX(nameLabel), maxY(nameLabel) + kWidth(13), iPhoneWidth - minX(nameLabel) - kWidth(12), kWidth(6))];
    [self addSubview:pgView];
    pgView.layer.cornerRadius = height(pgView)/2.;
    pgView.backgroundColor =  kColor(@"#ffefee");
    
    progresView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width(pgView)/2, kWidth(6))];
    [pgView addSubview:progresView];
    progresView.layer.cornerRadius = height(progresView)/2.;
    progresView.clipsToBounds = YES;
    progresView.backgroundColor = kColor(@"#ff7567");
    
    biliLabel = [[UILabel alloc] initWithFrame:CGRectMake(maxX(progresView) - kWidth(50), 0, kWidth(50), kWidth(24))];
    biliLabel.text = @"50%";
    biliLabel.font = sysFont(font(13));
    biliLabel.backgroundColor = kColor(@"#ffa6a2");
    biliLabel.layer.cornerRadius = height(biliLabel)/2.;
    biliLabel.clipsToBounds = YES;
    biliLabel.textAlignment = NSTextAlignmentCenter;
    biliLabel.textColor = [UIColor whiteColor];
    biliLabel.centerY = progresView.centerY;
    biliLabel.layer.borderWidth = 3;
    biliLabel.layer.borderColor = kColor(@"#ffefee").CGColor;
    [pgView addSubview:biliLabel];
    
    UILabel *lineLabel = [[UILabel alloc]  initWithFrame:CGRectMake(0, height(self) - 2 , iPhoneWidth, 2)];
    lineLabel.backgroundColor = cLineColor;
    [self addSubview:lineLabel];
    
    
    
}
- (void)setTeamPeopleActioviesModel:(zcouListModelModel *)model {
     NSString *imagUrlStr = [NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,model.head_image];
     [HeadImageView setImageAsyncWithURL:imagUrlStr placeholderImage:Image(@"tx.png")];
    
    nameLabel.text = model.nickname;
     NSString *picLabStr = [NSString stringWithFormat:@"还差%.2f元", ([model.total_money floatValue] - [model.obtain_money floatValue])];
     NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:picLabStr];
     [attributedStr addAttribute:NSForegroundColorAttributeName value:kColor(@"#ff0000") range:NSMakeRange(2, picLabStr.length - 2)];
     PicLabel.attributedText = attributedStr;
    
    CGFloat progresNum = [model.obtain_money floatValue]*100. / [model.total_money floatValue];
//    CGFloat progresNum = (double)(arc4random() % 100) + 0;;
    progresView.size = CGSizeMake(progresNum/100. *width(pgView), kWidth(6));
    CGFloat biliMinX = maxX(progresView) - kWidth(50);
    if (biliMinX <= 0) {
        biliMinX = 0.0;
    }
    biliLabel.frame = CGRectMake(biliMinX, 0, kWidth(50), kWidth(24));
    biliLabel.centerY = progresView.centerY;
    biliLabel.text = [NSString stringWithFormat:@"%.1f%@",progresNum,@"%"];
    
}
@end
