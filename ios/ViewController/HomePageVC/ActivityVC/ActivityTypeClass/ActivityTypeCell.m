//
//  ActivityTypeCell.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/9/1.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "ActivityTypeCell.h"

@interface ActivityTypeCell () {
    UIAsyncImageView *imageView;
    SMLabel *titleLabel;
    SMLabel *conLabel;
    UIButton *introducBut;
    UIButton *RightBut;
}

@end

@implementation ActivityTypeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUp];
    }
    return self;
}
- (void) setUp {
    imageView = [[UIAsyncImageView alloc] initWithFrame:CGRectMake(kWidth(12), kWidth(17), kWidth(134), kWidth(90))];
    imageView.layer.cornerRadius = 5;
    [self.contentView addSubview:imageView];
    
    titleLabel = [[SMLabel alloc] initWithFrame:CGRectMake(maxX(imageView) + 10, minY(imageView), iPhoneWidth - maxX(imageView) - 20, kWidth(17))];
    titleLabel.text = @"中苗会第一戈壁挑战";
    titleLabel.font = boldFont(font(17));
    [self.contentView addSubview:titleLabel];
    
    conLabel = [[SMLabel alloc] initWithFrame:CGRectMake(minX(titleLabel), maxY(titleLabel) + kWidth(14), width(titleLabel), kWidth(14))];
    conLabel.text = @"5 场赛事，3场未开始";
    conLabel.textColor = [UIColor redColor];
    conLabel.font = boldFont(font(14));
    [self.contentView addSubview:conLabel];
    
    introducBut = [UIButton buttonWithType:UIButtonTypeSystem];
    introducBut.frame = CGRectMake(minX(titleLabel), maxY(conLabel) + kWidth(15), width(titleLabel)/2 - kWidth(7), kWidth(28));
    [introducBut setTitle:@"路线介绍" forState:UIControlStateNormal];
    introducBut.backgroundColor = kColor(@"#52d0a8");
    [introducBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    introducBut.titleLabel.font = boldFont(14);
    introducBut.layer.cornerRadius = height(introducBut)/2.;
    [introducBut addTarget:self action:@selector(introducButAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:introducBut];
    
    RightBut = [UIButton buttonWithType:UIButtonTypeSystem];
    RightBut.frame = CGRectMake(maxX(introducBut) + kWidth(7), maxY(conLabel) + kWidth(15), width(introducBut), kWidth(28));
    [RightBut setTitle:@"选择活动" forState:UIControlStateNormal];
    RightBut.backgroundColor = kColor(@"#37c6b9");
    RightBut.layer.cornerRadius = height(introducBut)/2.;
    [RightBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    RightBut.titleLabel.font = boldFont(14);
    [RightBut addTarget:self action:@selector(RightButAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:RightBut];
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, 1)];
    line.backgroundColor = cLineColor;
    [self.contentView addSubview:line];
}

- (void)setActivityTypeCellDate:(ActivityTypeModel *)model {
     [imageView setImageAsyncWithURL:model.typePic placeholderImage:DefaultImage_logo];
     titleLabel.text = model.tyeName;
     NSMutableString *mStr = [[NSMutableString alloc] init];
    if ([model.zhongactivitiesCount intValue] > 0) {
        [mStr appendString:model.zhongactivitiesCount];
         [mStr appendString:@" 场进行中、 "];
    }
    if ([model.weiactivitiesCount intValue] > 0) {
        [mStr appendString:model.weiactivitiesCount];
        [mStr appendString:@" 未开始"];
        
    }
    if (mStr.length <= 0) {
        [mStr appendString:@"暂无活动"];
        RightBut.userInteractionEnabled = NO;
        introducBut.userInteractionEnabled = NO;
        RightBut.backgroundColor = [UIColor grayColor];
        introducBut.backgroundColor = [UIColor grayColor];
        RightBut.alpha = 0.6;
        introducBut.alpha = 0.6;
    }else {
        RightBut.userInteractionEnabled = YES;
        introducBut.userInteractionEnabled = YES;
        RightBut.backgroundColor = kColor(@"#37c6b9");
        introducBut.backgroundColor = kColor(@"#52d0a8");
        RightBut.alpha = 1;
        introducBut.alpha = 1;
    }
     conLabel.text = mStr;
}

- (void) introducButAction:(UIButton *)but {
    self.luxianContenBlock();
}
- (void) RightButAction:(UIButton *)but {
    self.selectActivityBlock();
}

@end
