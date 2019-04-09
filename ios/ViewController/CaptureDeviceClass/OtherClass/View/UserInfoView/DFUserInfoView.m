//
//  DFUserInfoView.m
//  DF
//
//  Created by Tata on 2017/12/1.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFIconConstant.h"
#import "DFUserInfoView.h"

@interface DFUserInfoView ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DFUserInfoView

- (void)addSubviews {
    [super addSubviews];
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.tableView];
}

- (void)defineLayout {
    [super defineLayout];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationView.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom).with.offset(self.tableView.cas_marginBottom / TTUIScale());
    }];
    
}

- (void)creatViews {
    [super creatViews];
    
    self.navigationView.backButton.cas_styleClass = @"navigation_back";
    [self.navigationView.backButton setImage:kImage(BackArrowGreen) forState:UIControlStateNormal];
    
    self.navigationView.titleLabel.cas_styleClass = @"navigation_title";
    self.navigationView.lineView.cas_styleClass = @"navigation_line";
    
    self.tableView = [[UITableView alloc]init];
    self.tableView.cas_styleClass = (iPhoneHeight == kHeightX) ? @"userInfo_tableView_X" : @"userInfo_tableView";
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
