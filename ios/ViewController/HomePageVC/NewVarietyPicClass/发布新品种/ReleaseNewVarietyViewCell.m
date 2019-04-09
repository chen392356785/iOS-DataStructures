//
//  ReleaseNewVarietyViewCell.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/7/31.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "ReleaseNewVarietyViewCell.h"

@interface ReleaseNewVarietyViewCell()

@end

@implementation ReleaseNewVarietyViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createText];
    }
    return self;
}
- (void) createText{
    _textField = [[IHTextField alloc] initWithFrame:CGRectMake(kWidth(12), 10, iPhoneWidth - kWidth(24), kWidth(30))];
    [self.contentView addSubview:_textField];
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, height(self.contentView) - 1, iPhoneWidth, 1)];
    line.backgroundColor = cLineColor;
    [self.contentView addSubview:line];
    self.lineLabel = line;
    _textField.font = sysFont(font(15));
}
@end





@interface ReleaseNewVarietyTypeCell () {
    UILabel *titleLabel;
     UIAsyncImageView *_ContImageView;
}
@end

@implementation ReleaseNewVarietyTypeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createText];
    }
    return self;
}
- (void) createText{
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kWidth(12), 15, iPhoneWidth - kWidth(80), 20)];
    titleLabel.font = sysFont(font(17));
    titleLabel.centerY= self.centerY;
    [self.contentView addSubview:titleLabel];
    
    _ContImageView = [[UIAsyncImageView alloc] initWithFrame:CGRectMake(iPhoneWidth - 40, 12, 20, 20)];
    _ContImageView.centerY= self.centerY;
    [self.contentView addSubview:_ContImageView];
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, height(self.contentView) - 1, iPhoneWidth, 1)];
    line.backgroundColor = cLineColor;
    [self.contentView addSubview:line];
}
- (void)setTitle:(NSString *)title andImageStr:(NSString *)imgStr {
    titleLabel.text = title;
    _ContImageView.image = Image(imgStr);
}
@end










