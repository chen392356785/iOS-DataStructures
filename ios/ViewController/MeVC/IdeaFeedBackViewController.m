//
//  IdeaFeedBackViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/4/1.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "IdeaFeedBackViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface IdeaFeedBackViewController ()<UITextFieldDelegate,UITextViewDelegate>
{
    PlaceholderTextView *_placeholderTextView;
    IHTextField *_textFiled;
    
}
@end

@implementation IdeaFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"意见反馈"];
    SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(20, 15, 100, 20) textColor:cGreenColor textFont:sysFont(14)];
    lbl.text=@"建议或问题";
    [self.view addSubview:lbl];
    
    _placeholderTextView =[[PlaceholderTextView alloc]initWithFrame:CGRectMake(lbl.left, lbl.bottom+5, WindowWith-lbl.left*2, 100)];
    _placeholderTextView.layer.borderColor= cLineColor.CGColor;
    _placeholderTextView.layer.borderWidth=1;
    [_placeholderTextView.layer setCornerRadius:5];
    _placeholderTextView.placeholder=@"请输入您的宝贵意见";
    _placeholderTextView.placeholderColor=RGB(180, 180, 185);
    _placeholderTextView.delegate=self;
    _placeholderTextView.placeholderFont=sysFont(14);
    [self.view addSubview:_placeholderTextView];

    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.left, _placeholderTextView.bottom+20, 100, 20) textColor:cGreenColor textFont:sysFont(14)];
    lbl.text=@"联系方式";
    [self.view addSubview:lbl];
    _textFiled=[[IHTextField alloc]initWithFrame:CGRectMake(lbl.left, lbl.bottom+5, _placeholderTextView.width, 35)];
    _textFiled.borderStyle=UITextBorderStyleRoundedRect;
    _textFiled.keyboardType=UIKeyboardTypeNumberPad;
    _textFiled.placeholder=@"请输入您的联系方式";
    _textFiled.delegate=self;
    [self.view addSubview:_textFiled];
    
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, _textFiled.bottom+20, WindowWith, WindowHeight-_textFiled.bottom)];
    lineView.backgroundColor=cLineColor;
    [self.view addSubview:lineView];
    
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame=CGRectMake(0, lineView.top+20, WindowWith-80, 40);
    btn.backgroundColor=cGreenColor;
    [btn setTintColor:[UIColor whiteColor]];
    [btn setTitle:@"提  交" forState:UIControlStateNormal];
    btn.titleLabel.font=sysFont(18.8);
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(submitClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.centerX=self.view.centerX;
    btn.layer.cornerRadius=21;
    
    
}

-(void)submitClick:(UIButton *)sender
{
//    if (![IHUtility checkPhoneValidate:_textFiled.text]) {
//        return;
//    }
    if ([self isEmpty:_placeholderTextView.text]) {
        [IHUtility addSucessView:@"请填入您的宝贵意见" type:1];
        return;
    }
    [self addWaitingView];
    [network getUserFeedBack:[USERMODEL.userID intValue] feed_back_content:_placeholderTextView.text phone:_textFiled.text success:^(NSDictionary *obj) {
        [self removeWaitingView];
        [IHUtility addSucessView:@"提交成功 感谢您的宝贵意见" type:1];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    
    
    
    
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@" "]) {
        return NO;
    }
    return YES;
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@" "]) {
        return NO;
    }

    return YES;
}



-(BOOL)isEmpty:(NSString *) str {
    
    if (!str) {
        return true;
    } else {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
