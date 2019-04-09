//
//  TeamSupperCollectionViewCell.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/8/21.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "TeamSupperCollectionViewCell.h"

@interface TeamSupperCollectionViewCell () {
    UIAsyncImageView *HeadImageView;
    UILabel *nameLabel;
    UILabel *PicLabel;
    UILabel *declarationLabel;
    UILabel *timeLabel;
    
    UIButton *huiFBut;
    
    UIImageView *bgView;
    UILabel *huifNameLabel;
    SMLabel *huifLabel;
    
    UILabel *lineLabel;
    
    UIView *maskView;
    
}
@end


@implementation TeamSupperCollectionViewCell

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
    
    nameLabel  = [[UILabel alloc] initWithFrame:CGRectMake(maxX(HeadImageView) + kWidth(5), minY(HeadImageView) , iPhoneWidth - maxX(HeadImageView) - kWidth(130), kWidth(20))];
    [self addSubview:nameLabel];
    nameLabel.text = @"好好先生";
    nameLabel.font = sysFont(font(16));
    
    PicLabel = [[UILabel alloc] initWithFrame:CGRectMake(iPhoneWidth - kWidth(120), minY(nameLabel), kWidth(110), height(nameLabel))];
    [self addSubview:PicLabel];
    PicLabel.text = @"还差3元";
    PicLabel.font = sysFont(font(16));
    PicLabel.textAlignment = NSTextAlignmentRight;
    
    declarationLabel = [[UILabel alloc] initWithFrame:CGRectMake(minX(nameLabel), maxY(nameLabel) + kWidth(5), maxX(PicLabel) - minX(nameLabel), kWidth(15))];
    [self addSubview:declarationLabel];
    declarationLabel.font = sysFont(font(15));
     declarationLabel.text = @"还没有宣言哦！";
    declarationLabel.textColor = kColor(@"#333333");
    
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(minX(declarationLabel), maxY(declarationLabel) + kWidth(4), width(declarationLabel) - kWidth(80), height(declarationLabel))];
    [self addSubview:timeLabel];
    timeLabel.font = sysFont(font(13));
    timeLabel.textColor = kColor(@"#666666");
    
    huiFBut = [UIButton buttonWithType:UIButtonTypeSystem];
    huiFBut.frame = CGRectMake(iPhoneWidth - 70, minY(timeLabel), kWidth(60), height(timeLabel));
    [huiFBut setTitle:@"回复他" forState:UIControlStateNormal];
    [huiFBut setTitleColor:kColor(@"#7e7e7e") forState:UIControlStateNormal];
    
    [huiFBut addTarget:self action:@selector(huifuAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:huiFBut];
    
    //3+12+15+8
    bgView = [[UIImageView alloc] initWithFrame:CGRectMake(minX(timeLabel), maxY(timeLabel) + 3, width(declarationLabel), 60)];
    UIImage *bgImage = Image(@"huifu");
     UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 50);
    bgImage = [bgImage resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    bgView.image = bgImage;
    [self addSubview:bgView];
       
    huifNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kWidth(8), kWidth(15), width(bgView) - kWidth(16), kWidth(15))];
    [bgView addSubview:huifNameLabel];
    huifNameLabel.text = @"小明";
    huifNameLabel.font = sysFont(font(12));
    huifNameLabel.textColor = [UIColor redColor];
    
    huifLabel = [[SMLabel alloc] initWithFrame:CGRectMake(minX(huifNameLabel), maxY(huifNameLabel) + kWidth(2), width(huifNameLabel), 15)];     //12+55+5+10+16
    [bgView addSubview:huifLabel];
    huifLabel.numberOfLines = 0;
//    huifLabel.verticalAlignment = VerticalAlignmentTop;
    huifLabel.text = @"回复内容：";
    huifLabel.font = sysFont(font(12));
    lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, height(self) - 1, iPhoneWidth, 1)];
    lineLabel.backgroundColor = cLineColor;
    [self addSubview:lineLabel];
    
    maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, height(self) -1)];
    [self addSubview:maskView];
    maskView.backgroundColor = [UIColor grayColor];
    maskView.alpha = 0.6;
    UILabel *maskLabel = [[UILabel alloc] initWithFrame:maskView.frame];
    [maskView addSubview:maskLabel];
    maskView.hidden = YES;
    maskLabel.numberOfLines = 2;
    maskLabel.textColor = [UIColor whiteColor];
    maskLabel.textAlignment = NSTextAlignmentCenter;
    maskLabel.text = @"已隐藏\n本条消息仅对自己可见";
    maskLabel.font = [UIFont fontWithName:@"Arial-BoldMT"size:font(18)];
}

- (void)setTeamSupperActioviesModel:(zcouListModelModel *)model {
    NSString *imagUrlStr = [NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,model.head_image];
    [HeadImageView setImageAsyncWithURL:imagUrlStr placeholderImage:Image(@"tx.png")];
    
    nameLabel.text = model.nickname;
    NSString *picLabStr = [NSString stringWithFormat:@"付款%@元", model.pay_amount];
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:picLabStr];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:kColor(@"#ff0000") range:NSMakeRange(2, picLabStr.length - 2)];
    PicLabel.attributedText = attributedStr;
    if (![model.message isEqualToString:@""]) {
        declarationLabel.text = model.message;
    }
    huiFBut.tag = self.tag;
    NSString *timeStr = [IHUtility compareCurrentTime:model.create_time];
    timeLabel.text = timeStr;
    if ([model.huifu isEqualToString:@""] || model.huifu == nil) {
        bgView.hidden = YES;
        huiFBut.hidden = NO;
    }else {
        bgView.hidden = NO;
        huiFBut.hidden = YES;
        huifNameLabel.text = model.huifu_name;
        CGFloat textHeight = [IHUtility calculateRowHeight:model.huifu Width:width(huifNameLabel) fontSize:font(12)];
        huifLabel.size = CGSizeMake(width(huifNameLabel), kWidth(textHeight));
        bgView.size = CGSizeMake(width(declarationLabel), maxY(huifLabel) + kWidth(8));
        huifLabel.text = model.huifu;
        
    }
    lineLabel.frame = CGRectMake(0, height(self) - 1, iPhoneWidth, 1);
    if ([model.is_hide isEqualToString:@"1"]) {
        maskView.hidden = NO;
    }else {
        maskView.hidden = YES;
    }
}
- (void) huifuAction:(UIButton *)but {
    self.huifuAction(but.tag);
}
@end
