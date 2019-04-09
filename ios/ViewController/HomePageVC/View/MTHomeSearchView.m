//
//  MTSearchView.m
//  MiaoTuProject
//
//  Created by tinghua on 2018/9/20.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "MTHomeSearchView.h"

@interface MTHomeSearchView ()<UITextFieldDelegate>
/**搜索条*/
@property (nonatomic,strong) IHTextField *searchTextField;
//语音语义理解对象,带界面的识别对象
@property (nonatomic) BOOL isCanceled;
@property (nonatomic,strong)NSString * result;

@end

@implementation MTHomeSearchView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = cLineColor;
        self.alpha = 0.8;
        [self setupSubView];
    }
    return self;
}
- (void)setupSubView {
    WS(weakSelf);
    [self addSubview:self.searchTextField];
    [self.searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.top.equalTo(weakSelf.mas_top);
        make.right.equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(30);
        make.centerY.mas_equalTo(weakSelf);
    }];
}

- (UITextField *)searchTextField {
    
    if (!_searchTextField) {
        _searchTextField = [[IHTextField alloc] init];
        _searchTextField.placeholder = @"香樟";
        _searchTextField.delegate  = self;
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 28, 27)];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(8, 7, 15, 15)];
        imageView.centerY = leftView.centerY;
        imageView.image = Image(@"icon_sousuo");
        [leftView addSubview:imageView];
        _searchTextField.leftView = leftView;
        _searchTextField.leftViewMode = UITextFieldViewModeAlways;
        _searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _searchTextField.textColor =  [UIColor blackColor];
        _searchTextField.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
        _searchTextField.returnKeyType = UIReturnKeySearch;
    }
    return _searchTextField;
}

//设置清除按钮图标
- (void)setRightButtonImage:(UIImage *)rightButtonImage {
    
    if (rightButtonImage) {
        
        _rightButtonImage = rightButtonImage;
        
        UIButton *voiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [voiceButton setImage:rightButtonImage forState:UIControlStateNormal];
        self.voiceButton = voiceButton;
//        [voiceButton addTarget:self action:@selector(tapVoiceButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:voiceButton];
        
        //Autolayout
        voiceButton.translatesAutoresizingMaskIntoConstraints = NO;
        NSDictionary *views = NSDictionaryOfVariableBindings(voiceButton);
        //设置水平方向约束
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[voiceButton(21)]-|" options:NSLayoutFormatAlignAllRight | NSLayoutFormatAlignAllLeft metrics:nil views:views]];
        //设置高度约束
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[voiceButton(21)]" options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom metrics:nil views:views]];
        //设置垂直方向居中约束
        [self addConstraint:[NSLayoutConstraint constraintWithItem:voiceButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    }
}
- (CGSize)intrinsicContentSize {
    return UILayoutFittingExpandedSize;
}
#pragma mark --设置搜索内容-
- (void)setSearchPlaceText:(NSString *)searchPlaceText {
    
    _searchPlaceText = searchPlaceText;
    self.searchTextField.placeholder = searchPlaceText;
}

#pragma mark --UISearchBarDelegate---
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(flowerSearchViewWithText:textField:)]) {
        
        [self.delegate flowerSearchViewWithText:textField.text textField:textField];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
//    if (self.delegate && [self.delegate respondsToSelector:@selector(flowerSearchViewWithText:textField:)]) {
////        [self.delegate flowerSearchViewWithText:textField.text textField:textField];
//    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(flowerChangeCharactersInRange:textField:)]) {
        [self.delegate flowerChangeCharactersInRange:textField.text textField:textField];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(flowerSearchViewWithText:textField:)]) {
        [self.delegate flowerChangeCharactersInRange:textField.text textField:textField];
    }
    self.voiceButton.hidden = NO;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    if (self.delegate && [self.delegate respondsToSelector:@selector(flowertextFieldCleartextField:)]) {
        [self.delegate flowertextFieldCleartextField:textField];
    }
    return YES;
}

//监控文本变化
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *tem = [[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]componentsJoinedByString:@""];
    if (self.delegate && [self.delegate respondsToSelector:@selector(flowerSearchViewWithText:textField:)]) {
        NSString*text = [textField.text stringByReplacingCharactersInRange:range withString:string];
        [self.delegate flowerChangeCharactersInRange:text textField:textField];
    }
    
    if (![string isEqualToString:tem]) {
        return NO;
    }
    self.voiceButton.hidden = textField.text.length + (string.length - range.length) > 0;
    return YES;
}

@end
