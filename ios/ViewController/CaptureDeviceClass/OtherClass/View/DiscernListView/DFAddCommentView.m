//
//  DFAddCommentView.m
//  DF
//
//  Created by Tata on 2017/12/6.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFAddCommentView.h"

@interface DFAddCommentView ()<UITextViewDelegate>

@property (nonatomic, strong) UIView *tooView;
@property (nonatomic, strong) UIButton *cancleButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *confirmButton;

@property (nonatomic, strong) UITextView *textView;

@end

@implementation DFAddCommentView

- (void)addSubviews {
    [self creatViews];
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.tooView];
    [self.tooView addSubview:self.cancleButton];
    [self.tooView addSubview:self.titleLabel];
    [self.tooView addSubview:self.titleLabel];
    [self.tooView addSubview:self.confirmButton];
    
    [self addSubview:self.textView];
}

- (void)defineLayout {
    [self.tooView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@(self.tooView.cas_sizeHeight));
    }];
    
    [self.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tooView.mas_top);
        make.left.equalTo(self.tooView.mas_left);
        make.width.equalTo(@(self.cancleButton.cas_sizeWidth));
        make.bottom.equalTo(self.tooView.mas_bottom);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.tooView.mas_centerX);
        make.centerY.equalTo(self.tooView.mas_centerY);
        make.width.equalTo(@(self.titleLabel.cas_sizeWidth));
        make.height.equalTo(@(self.titleLabel.cas_sizeHeight));
    }];
    
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tooView.mas_top);
        make.right.equalTo(self.tooView.mas_right);
        make.width.equalTo(@(self.confirmButton.cas_sizeWidth));
        make.bottom.equalTo(self.tooView.mas_bottom);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tooView.mas_bottom).with.offset(self.textView.cas_marginTop);
        make.left.equalTo(self.mas_left).with.offset(self.textView.cas_marginLeft);
        make.right.equalTo(self.mas_right).with.offset(self.textView.cas_marginRight);
        make.bottom.equalTo(self.mas_bottom).with.offset(self.textView.cas_marginBottom);
    }];
}

- (void)creatViews {
    self.tooView = [[UIView alloc]init];
    self.tooView.cas_styleClass = @"addComment_toolView";
    
    self.cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancleButton.cas_styleClass = @"addComment_cancleButton";
    [self.cancleButton setTitle:DFCancleString() forState:UIControlStateNormal];
    [self.cancleButton setTitleColor:THTitleColor5 forState:UIControlStateNormal];
    [self.cancleButton addTarget:self action:@selector(cancleAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.cas_styleClass = @"addComment_titleLabel";
    self.titleLabel.text = DFCommentString();
    
    self.confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.confirmButton.cas_styleClass = @"addComment_confirmButton";
    [self.confirmButton setTitle:DFSureString() forState:UIControlStateNormal];
    [self.confirmButton setTitleColor:THBaseColor forState:UIControlStateNormal];
    [self.confirmButton addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.textView = [[UITextView alloc]init];
    self.textView.cas_styleClass = @"addComment_textView";
//    self.textView.layer.masksToBounds = YES;
    [self.textView addPlaceHolder:DFSimpleString()];
    self.textView.delegate = self;
    
}

- (void)cancleAction {
    if ([self.delegate respondsToSelector:@selector(cancleComment)]) {
        [self.delegate cancleComment];
    }
}

- (void)confirmAction {
    if ([self.delegate respondsToSelector:@selector(confirmComment)]) {
        [self.delegate confirmComment];
    }
}

#pragma mark TextViewDeleagte
- (void)textViewDidBeginEditing:(UITextView *)textView {
    textView.placeHolderTextView.hidden = NO;
}

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 200) {
        textView.text = [textView.text substringToIndex:200];
    }
    if ([textView.text isEqualToString:@""]) {
        textView.placeHolderTextView.hidden = NO;
    }else {
        textView.placeHolderTextView.hidden = YES;
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
