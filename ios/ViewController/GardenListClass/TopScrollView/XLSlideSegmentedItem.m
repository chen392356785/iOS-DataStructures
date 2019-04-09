//
//  XLSlideSegmentItem.m
//  SlideSwitchTest
//
//  Created by MengXianLiang on 2017/4/28.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import "XLSlideSegmentedItem.h"

@implementation XLSlideSegmentedItem

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    _textLabel = [[UILabel alloc] init];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_textLabel];
    _lineLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_lineLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _textLabel.frame = self.bounds;
    _lineLabel.frame = CGRectMake(0, self.height - 1.5, _textLabel.width - kWidth(10), 1.5);
    _lineLabel.centerX = _textLabel.centerX;
}

@end
