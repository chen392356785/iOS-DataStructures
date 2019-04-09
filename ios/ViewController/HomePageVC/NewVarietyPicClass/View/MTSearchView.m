//
//  MTSearchView.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/7/30.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "MTSearchView.h"

@interface MTSearchView () {
    IHTextField *_searTextFile;
    UIButton *SearBut;
    UIView *bgView;
}
@end

@implementation MTSearchView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        bgView = [[UIView alloc] initWithFrame:frame];
        [self addSubview:bgView];
        _searTextFile = [[IHTextField alloc] init];
        [bgView addSubview:_searTextFile];
        self.searBar = _searTextFile;
        
        SearBut = [UIButton buttonWithType:UIButtonTypeSystem];
        [SearBut setTitle:@"搜索" forState:UIControlStateNormal];
        [bgView addSubview:SearBut];
        
        [self setupUI];
    }
    return self;
}

- (CGSize)intrinsicContentSize {
    return UILayoutFittingExpandedSize;
}
- (void) setupUI{
    [_searTextFile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->bgView.mas_left).mas_offset(4);
        make.height.mas_offset(32);
        make.right.mas_equalTo(self->SearBut.mas_left).mas_offset(-10);
        make.centerY.mas_equalTo(self->bgView);
    }];
    _searTextFile.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)];
    _searTextFile.placeholder = @" 请输入内容";
    _searTextFile.font = sysFont(16);
    _searTextFile.textAlignment = NSTextAlignmentLeft;
    _searTextFile.backgroundColor = kColor(@"#ffffff");
    _searTextFile.layer.cornerRadius = 16;
    _searTextFile.clearButtonMode = UITextFieldViewModeWhileEditing;
    _searTextFile.returnKeyType = UIReturnKeySearch;
    self.searBar = _searTextFile;
    self.searBar.alpha = 0.5;
    
    [SearBut setTintColor:[UIColor whiteColor]];
    self.searBut = SearBut;
    [SearBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self->bgView).mas_offset(-15);
        make.height.mas_offset(36);
        make.centerY.mas_equalTo(self->_searTextFile);
    }];
    SearBut.titleLabel.font = sysFont(16);
    [SearBut addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
}
- (void) searchAction:(UIButton *)but {
    self.searchBlock();
}
@end
