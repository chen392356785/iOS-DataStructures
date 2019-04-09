//
//  DFDiscernTypeListView.m
//  DF
//
//  Created by Tata on 2017/11/30.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFDiscernTypeListView.h"

@interface DFDiscernTypeListView ()

@property (nonatomic, strong) UIButton *allFlowerButton;
@property (nonatomic, strong) UIView *firstLineView;
@property (nonatomic, strong) UIButton *myPublishButton;
@property (nonatomic, strong) UIView *secondLineView;
@property (nonatomic, strong) UIButton *myDiscernButton;

@end

@implementation DFDiscernTypeListView

- (void)addSubviews {
    [self creatViews];
    self.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0];
    self.layer.shadowColor = THShadowColor.CGColor;
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = THLineColor.CGColor;
    self.layer.borderWidth = 0.5;
    
    [self addSubview:self.allFlowerButton];
    [self addSubview:self.firstLineView];
    [self addSubview:self.myPublishButton];
    [self addSubview:self.secondLineView];
    [self addSubview:self.myDiscernButton];
    
}

- (void)defineLayout {
    
    [self.allFlowerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_offset(height(self)/3);
    }];
    
    [self.firstLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.allFlowerButton.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@(self.firstLineView.cas_sizeHeight));
    }];
    
    [self.myPublishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstLineView.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_offset(height(self)/3);
    }];
    
    [self.secondLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.myPublishButton.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@(self.secondLineView.cas_sizeHeight));
    }];
    
    [self.myDiscernButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondLineView.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_offset(height(self)/3);
    }];
}

- (void)creatViews {
    
    self.allFlowerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.allFlowerButton.cas_styleClass = @"usersDiscern_allFlowerButton";
    [self.allFlowerButton setTitle:@"全  部" forState:UIControlStateNormal];
    [self.allFlowerButton setTitleColor:THTitleColor3 forState:UIControlStateNormal];
    self.allFlowerButton.tag = 100;
    [self.allFlowerButton addTarget:self action:@selector(selectTypeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.firstLineView = [[UIView alloc]init];
    self.firstLineView.cas_styleClass = @"usersDiscern_firstLineView";
    
    self.myPublishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.myPublishButton.cas_styleClass = @"usersDiscern_allFlowerButton";
    [self.myPublishButton setTitle:DFMyPublishString() forState:UIControlStateNormal];
    [self.myPublishButton setTitleColor:THTitleColor3 forState:UIControlStateNormal];
    self.myPublishButton.tag = 101;
    [self.myPublishButton addTarget:self action:@selector(selectTypeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.secondLineView = [[UIView alloc]init];
    self.secondLineView.cas_styleClass = @"usersDiscern_firstLineView";
    
    self.myDiscernButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.myDiscernButton.cas_styleClass = @"usersDiscern_allFlowerButton";
    [self.myDiscernButton setTitle:DFMyDiscernString() forState:UIControlStateNormal];
    [self.myDiscernButton setTitleColor:THTitleColor3 forState:UIControlStateNormal];
    self.myDiscernButton.tag = 102;
    [self.myDiscernButton addTarget:self action:@selector(selectTypeAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)selectTypeAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(selectDiscernTypeWith:)]) {
        [self.delegate selectDiscernTypeWith:sender.tag - 100];
    }
}

- (void)setCurrentSource:(NSInteger)currentSource {
    switch (currentSource) {
        case 0:
            [self.allFlowerButton setTitleColor:THBaseColor forState:UIControlStateNormal];
            [self.myPublishButton setTitleColor:THTitleColor3 forState:UIControlStateNormal];
            [self.myDiscernButton setTitleColor:THTitleColor3 forState:UIControlStateNormal];
            break;
        case 1:
            [self.allFlowerButton setTitleColor:THTitleColor3 forState:UIControlStateNormal];
            [self.myPublishButton setTitleColor:THBaseColor forState:UIControlStateNormal];
            [self.myDiscernButton setTitleColor:THTitleColor3 forState:UIControlStateNormal];
            break;
        case 2:
            [self.allFlowerButton setTitleColor:THTitleColor3 forState:UIControlStateNormal];
            [self.myPublishButton setTitleColor:THTitleColor3 forState:UIControlStateNormal];
            [self.myDiscernButton setTitleColor:THBaseColor forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
