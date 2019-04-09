//
//  DFUserCenterView.m
//  DF
//
//  Created by Tata on 2017/11/30.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFIconConstant.h"
#import "DFUserCenterView.h"
#import "DFUserPropertyCell.h"
#import "DFIdentifierConstant.h"

@interface DFUserCenterView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIVisualEffectView *effectView;
@property (nonatomic, strong) UIImageView *userHeaderIcon;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *userDescribeLabel;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *loginOutButton;

@end

@implementation DFUserCenterView

- (void)addSubviews {
    [self creatViews];
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.backgroundImageView];
    [self.backgroundImageView addSubview:self.userHeaderIcon];
    [self.backgroundImageView addSubview:self.userNameLabel];
    [self.backgroundImageView addSubview:self.userDescribeLabel];
    
    [self addSubview:self.tableView];
    [self addSubview:self.loginOutButton];
}

- (void)defineLayout {
    
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@(self.backgroundImageView.cas_sizeHeight));
    }];
    
    [self.userHeaderIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backgroundImageView.mas_top).with.offset(self.userHeaderIcon.cas_marginTop);
        make.centerX.equalTo(self.backgroundImageView.mas_centerX);
        make.width.equalTo(@(self.userHeaderIcon.cas_sizeWidth));
        make.height.equalTo(@(self.userHeaderIcon.cas_sizeHeight));
    }];
    
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userHeaderIcon.mas_bottom).with.offset(self.userNameLabel.cas_marginTop);
        make.left.equalTo(self.backgroundImageView.mas_left);
        make.right.equalTo(self.backgroundImageView.mas_right);
        make.height.equalTo(@(self.userNameLabel.cas_sizeHeight));
    }];
    
    [self.userDescribeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userNameLabel.mas_bottom).with.offset(self.userDescribeLabel.cas_marginTop);
        make.left.equalTo(self.backgroundImageView.mas_left);
        make.right.equalTo(self.backgroundImageView.mas_right);
        make.height.equalTo(@(self.userDescribeLabel.cas_sizeHeight));
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backgroundImageView.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.loginOutButton.mas_top);
    }];
    
    [self.loginOutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).with.offset(self.loginOutButton.cas_marginBottom / TTUIScale());
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@(self.loginOutButton.cas_sizeHeight));
    }];
}

- (void)creatViews {
    self.backgroundImageView = [[UIImageView alloc]init];
    self.backgroundImageView.cas_styleClass = (iPhoneHeight == kHeightX) ? @"userCenter_backgroundImageView_X" : @"userCenter_backgroundImageView";
    self.backgroundImageView.userInteractionEnabled = YES;
    self.backgroundImageView.clipsToBounds = YES;
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    self.effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    self.effectView.frame = CGRectMake(0, 0, 287.5 * TTUIScale(), (iPhoneHeight == kHeightX) ? 244 * TTUIScale() : 205 * TTUIScale());
    [self.backgroundImageView addSubview:self.effectView];
    
    self.userHeaderIcon = [[UIImageView alloc]init];
    self.userHeaderIcon.cas_styleClass = (iPhoneHeight == kHeightX) ? @"userCenter_userHeaderIcon_X" : @"userCenter_userHeaderIcon";
    self.userHeaderIcon.userInteractionEnabled = YES;
    self.userHeaderIcon.layer.masksToBounds = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(checkUserInfoAction)];
    [self.userHeaderIcon addGestureRecognizer:tap];
    
    self.userNameLabel = [[UILabel alloc]init];
    self.userNameLabel.cas_styleClass = @"userCenter_userNameLabel";
    
    self.userDescribeLabel = [[UILabel alloc]init];
    self.userDescribeLabel.cas_styleClass = @"userCenter_userDescribeLabel";
    
    self.tableView = [[UITableView alloc]init];
    self.tableView.cas_styleClass = @"userCenter_tableView";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[DFUserPropertyCell class] forCellReuseIdentifier:UserCenterPropertyIdentifier];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.loginOutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginOutButton.cas_styleClass = (iPhoneHeight == kHeightX) ? @"userCenter_loginOutButton_X" : @"userCenter_loginOutButton";
    [self.loginOutButton setTitle:DFLoginOutString() forState:UIControlStateNormal];
    [self.loginOutButton addTarget:self action:@selector(loginOutAction) forControlEvents:UIControlEventTouchUpInside];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DFUserPropertyCell *cell = [tableView dequeueReusableCellWithIdentifier:UserCenterPropertyIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.propertyIcon.image = kImage([self userPropertyIcon:indexPath.row]);
    cell.propertyTitleLabel.text = [self userProperty:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self goPraise];
            break;
        case 1:
            [self goToShit];
            break;
        case 2:
            [self allUsersDiscern];
            break;
        case 3:
            [self goAboutUS];
            break;
        default:
            break;
    }
}

#pragma mark --不吝好评---
- (void)goPraise {
    
    if ([self.delegate respondsToSelector:@selector(goToPraise)]) {
        
        [self.delegate goToPraise];
        
    }

}
#pragma mark --吐槽--
- (void)goToShit {
    if ([self.delegate respondsToSelector:@selector(addBadComment)]) {
        [self.delegate addBadComment];
    }
}
#pragma mark --大家来鉴定--
- (void)allUsersDiscern {
    if ([self.delegate respondsToSelector:@selector(allUsersDiscern)]) {
        [self.delegate allUsersDiscern];
    }
}

- (void)checkUserInfoAction {
    if ([self.delegate respondsToSelector:@selector(checkUserInfo)]) {
        [self.delegate checkUserInfo];
    }
}
#pragma mark --关于我们-
- (void)goAboutUS {
    
    if ([self.delegate respondsToSelector:@selector(goToAboutUS)]) {
        
        [self.delegate goToAboutUS];
    }
    
    
}

- (void)loginOutAction {
    if ([self.delegate respondsToSelector:@selector(loginOut)]) {
        [self.delegate loginOut];
    }
}

- (NSString *)userProperty:(NSInteger)index {
    NSArray *array = @[DFGoodAppraiseString(),DFBadAppraiseString(),DFDiscernListString(),DFAboutUsString()];
    return array[index];
}

- (NSString *)userPropertyIcon:(NSInteger)index {
    NSArray *array = @[GoodAppraiseIcon,BadAppraiseIcon,DiscernListIcon,AboutUsIcon];
    return array[index];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
