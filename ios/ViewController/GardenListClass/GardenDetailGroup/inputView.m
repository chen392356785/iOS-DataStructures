//
//  inputView.m
//  textInput
//
//  Created by fangliguo on 2017/4/11.
//  Copyright © 2017年 fangliguo. All rights reserved.
//

#import "inputView.h"

@interface inputView()<UITextViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIView *inputView;

@property (nonatomic, assign) CGFloat keyboldH;
@property (nonatomic, strong) UIButton *sendBut;
@end

@implementation inputView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor colorWithRed:0.13 green:0.13 blue:0.13 alpha:0.30];
        self.backgroundColor = [UIColor clearColor];
        //使用NSNotificationCenter 鍵盤出現時
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShown:)
                                                     name:UIKeyboardWillShowNotification object:nil];
        //使用NSNotificationCenter 鍵盤隐藏時
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillBeHidden:)
                                                     name:UIKeyboardWillHideNotification object:nil];
        
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];

        [self createView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
    }
    return self;
}
- (void)createView{
    self.inputView = [[UIView alloc] initWithFrame:CGRectMake(0, iPhoneHeight - kWidth(120) , iPhoneWidth, kWidth(120))];
    [self addSubview:self.inputView];
    self.inputView.backgroundColor = kColor(@"#FFFFFF");
    
    self.inputTextView = [[UITextView alloc] initWithFrame:CGRectMake(kWidth(17), kWidth(10), iPhoneWidth - kWidth(34), self.inputView.height - kWidth(45))];
    self.inputTextView.delegate = self;
    self.inputTextView.returnKeyType = UIReturnKeySend;
    self.inputTextView.layer.masksToBounds = YES;
    self.inputTextView.font = sysFont(13);
    self.inputTextView.backgroundColor = kColor(@"#FFFFFF");
    self.inputTextView.textColor = [UIColor blackColor];
    [self.inputView addSubview:self.inputTextView];
    self.inputTextView.scrollEnabled = YES;
    
    self.placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(6, 10, 200, 10)];
//    self.placeLabel.text = @"最多可输入300字";
    self.placeLabel.text = @"评论@";
    self.placeLabel.textColor = [UIColor lightGrayColor];
    [self.inputTextView addSubview:self.placeLabel];
    self.placeLabel.font = sysFont(13);
    self.placeLabel.userInteractionEnabled = NO;
    self.placeLabel.hidden = NO;
    
    
    self.sendBut = [UIButton buttonWithType:UIButtonTypeSystem];
    self.sendBut.frame = CGRectMake(self.inputView.width - kWidth(35), self.inputTextView.bottom, kWidth(20), kWidth(20));
    [self.sendBut setImage:[kImage(@"send_img") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self.sendBut addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
    [self.inputView addSubview:self.sendBut];
    self.userInteractionEnabled = YES;
    self.inputView.userInteractionEnabled = YES;

}
//这个函数的最后一个参数text代表你每次输入的的那个字，所以：
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    NSLog(@"-----%@",text);
    if ([text isEqualToString:@""]) {
        //表示删除字符
    }
    
    if ([text isEqualToString:@"\n"]){
        if (self.inputTextView.text.length>0) {
            [self.delegate sendText:self.inputTextView.text];
        }
        return NO;
    }else{
        NSString *new = [textView.text stringByReplacingCharactersInRange:range withString:text];
        if(new.length > 300){
            if (![text isEqualToString:@""]) {
                return NO;
            }
        }
        return YES;
    }
}

- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length == 0) {
        self.placeLabel.hidden = NO;
    }else{
        self.placeLabel.hidden = YES;
    }
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if (textView.text.length == 0) {
        self.placeLabel.hidden = NO;
    }else{
        self.placeLabel.hidden = YES;
    }
    return YES;
}

- (void)keyboardChangeFrame:(NSNotification *)notifi{
    CGRect keyboardFrame = [notifi.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    float duration = [notifi.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:duration animations:^{
//        self.origin = CGPointMake(0, keyboardFrame.origin.y - self.height + 20);
        self.inputView.origin = CGPointMake(0, keyboardFrame.origin.y - KTabSpace);
    }];
}

- (void) sendAction {
    if (self.inputTextView.text.length>0) {
        [self.delegate sendText:self.inputTextView.text];
    }
}
//实现当键盘出现的时候计算键盘的高度大小。用于输入框显示位置
- (void)keyboardWillShown:(NSNotification*)aNotification{
  
}

//当键盘隐藏的时候
- (void)keyboardWillBeHidden:(NSNotification*)aNotification{
    [UIView animateWithDuration:1 animations:^{
//        self.origin = CGPointMake(0, iPhoneHeight);
        self.inputView.origin = CGPointMake(0, iPhoneHeight - kWidth(120));
    }];
}

- (void)inputViewShow{
    [self.inputTextView becomeFirstResponder];
    
}
- (void)inputViewHiden{
    [self.inputTextView resignFirstResponder];
}
- (void)tapAction{
    [self inputViewHiden];
    if (self.tapBgViewBlock) {
        self.tapBgViewBlock();
    }
    return;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (touch.view == self.inputView) {
        if (touch.view == self.sendBut) {
            return YES;
        }
        return NO;
    }else{
        return YES;
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
