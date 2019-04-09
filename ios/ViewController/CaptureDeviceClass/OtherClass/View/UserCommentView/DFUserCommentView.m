//
//  DFUserCommentView.m
//  DF
//
//  Created by Tata on 2017/11/30.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFIconConstant.h"
#import "DFUserCommentView.h"

@interface DFUserCommentView ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *commentView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *sendButton;

@end

@implementation DFUserCommentView

- (void)addSubviews {
    [super addSubviews];
    self.backgroundColor = [UIColor whiteColor];
    
    [self insertSubview:self.tableView atIndex:0];
    [self addSubview:self.commentView];
    [self.commentView addSubview:self.textField];
    [self.commentView addSubview:self.sendButton];
}

- (void)defineLayout {
    [super defineLayout];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(self.tableView.cas_marginTop);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.commentView.mas_top);
    }];
    
    [self.commentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).with.offset(self.commentView.cas_marginBottom / TTUIScale());
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@(self.commentView.cas_sizeHeight));
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.commentView.mas_top);
        make.left.equalTo(self.commentView.mas_left);
        make.right.equalTo(self.sendButton.mas_left);
        make.bottom.equalTo(self.commentView.mas_bottom);
    }];
    
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.commentView.mas_right);
        make.top.equalTo(self.commentView.mas_top);
        make.bottom.equalTo(self.commentView.mas_bottom);
        make.width.equalTo(@(self.sendButton.cas_sizeWidth));
    }];
}

- (void)creatViews {
    [super creatViews];
    
    [self.navigationView.backButton setImage:kImage(BackArrowWhite) forState:UIControlStateNormal];
    [self.navigationView.backButton setImage:kImage(BackArrowWhite) forState:UIControlStateHighlighted];
    self.navigationView.backButton.cas_styleClass = @"navigation_back";
    self.navigationView.lineView.cas_styleClass = @"navigation_line_clear";
    
    self.tableView = [[UITableView alloc]init];
    self.tableView.cas_styleClass = @"userComment_tableView";
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    
    self.commentView = [[UIView alloc]init];
    self.commentView.cas_styleClass = (iPhoneHeight == kHeightX) ? @"userComment_commentView_X" : @"userComment_commentView";
    
    self.textField = [[UITextField alloc]init];
    self.textField.cas_styleClass = @"userComment_textField";
    self.textField.placeholder = DFSimpleString();
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 50)];
    self.textField.leftView = leftView;
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    self.textField.returnKeyType = UIReturnKeyDone;
    
    self.sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendButton.cas_styleClass = @"userComment_sendButton";
    [self.sendButton setTitle:DFSendString() forState:UIControlStateNormal];
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
