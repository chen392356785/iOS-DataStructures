//
//  AdvantageViewController.m
//  MiaoTuProject
//
//  Created by Zmh on 14/9/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "AdvantageViewController.h"
#define MAX_LIMIT_NUMS   150

@interface AdvantageViewController ()<UITextViewDelegate>
{
    PlaceholderTextView *_txtView;
    SMLabel *_sumlbl;
}
@end

@implementation AdvantageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = cLineColor;
    [self setTitle:@"我的优势"];
    
    
    SMLabel *lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(18, 10, WindowWith - 36, 19) textColor:cBlackColor textFont:sysFont(13)];
    lbl.backgroundColor =  [UIColor clearColor];
    lbl.text = @"我的优势";
    [self.view addSubview:lbl];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, lbl.bottom + 8, WindowWith, 265)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    PlaceholderTextView *textView = [[PlaceholderTextView alloc] initWithFrame:CGRectMake(12, 0, WindowWith -24, 225)];
    textView.placeholderFont=sysFont(14);
    textView.font = sysFont(14);
    textView.delegate=self;
    _txtView = textView;
    textView.placeholder = @"请填写您的优势…";
    textView.placeholderColor = cGrayLightColor;
    [view addSubview:textView];
    if (self.content.length > 0) {
        textView.text = self.content;
        textView.placeholderLbl.hidden= YES;
    }
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, textView.bottom + 5, WindowWith, 1)];
    lineView.backgroundColor = cLineColor;
    [view addSubview:lineView];
    
    SMLabel *sumlbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, lineView.bottom , WindowWith-12, 23) textColor: [IHUtility colorWithHexString:@"#bbbbbb"] textFont:sysFont(13)];
    sumlbl.textAlignment=NSTextAlignmentRight;
    _sumlbl = sumlbl;
    sumlbl.text=stringFormatInt(MAX_LIMIT_NUMS);
    [view addSubview:sumlbl];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(18, view.bottom + 35, WindowWith - 36, 38)];
    [btn setTitle:@"保  存" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 20.0;
    btn.backgroundColor = cGreenColor;
    btn.titleLabel.font = sysFont(15);
    [btn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)submit:(UIButton *)sender{
    if (_txtView.text.length==0) {
        [IHUtility addSucessView:@"未填写优势" type:2];
        return;
    }
    
    if (_txtView.text.length>150) {
        [IHUtility addSucessView:@"评论字数不能超过150哦" type:2];
        return;
    }
    
    [self.delegate disPalyAdvantageContent:_txtView.text];
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView.text.length==0) {
        _sumlbl.text=stringFormatInt(MAX_LIMIT_NUMS);
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        
        [self submit:nil];
        return YES;
    }
    
    if (text.length==0) {
        return YES;
    }
    
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    //获取高亮部分内容
    //NSString * selectedtext = [textView textInRange:selectedRange];
    
    //如果有高亮且当前字数开始位置小于最大限制时允许输入
    if (selectedRange && pos) {
        NSInteger startOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.start];
        NSInteger endOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.end];
        NSRange offsetRange = NSMakeRange(startOffset, endOffset - startOffset);
        
        if (offsetRange.location < MAX_LIMIT_NUMS) {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    NSInteger caninputlen = MAX_LIMIT_NUMS - comcatstr.length;
    
    if (caninputlen >= 0)
    {
        return YES;
    }
    else
    {
        NSInteger len = text.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        
        if (rg.length > 0)
        {
            NSString *s = @"";
            //判断是否只普通的字符或asc码(对于中文和表情返回NO)
            BOOL asc = [text canBeConvertedToEncoding:NSASCIIStringEncoding];
            if (asc) {
                s = [text substringWithRange:rg];//因为是ascii码直接取就可以了不会错
            }
            else
            {
                __block NSInteger idx = 0;
                __block NSString  *trimString = @"";//截取出的字串
                //使用字符串遍历，这个方法能准确知道每个emoji是占一个unicode还是两个
                [text enumerateSubstringsInRange:NSMakeRange(0, [text length])
                                         options:NSStringEnumerationByComposedCharacterSequences
                                      usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                                          
                                          if (idx >= rg.length) {
                                              *stop = YES; //取出所需要就break，提高效率
                                              return ;
                                          }
                                          
                                          trimString = [trimString stringByAppendingString:substring];
                                          
                                          idx++;
                                      }];
                
                s = trimString;
            }
            //rang是指从当前光标处进行替换处理(注意如果执行此句后面返回的是YES会触发didchange事件)
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
            //既然是超出部分截取了，哪一定是最大限制了。
            _sumlbl.text = [NSString stringWithFormat:@"%d",0];
        }
        return NO;
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    
    //如果在变化中是高亮部分在变，就不要计算字符了
    if (selectedRange && pos) {
        return;
    }
    
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    
    if (existTextNum > MAX_LIMIT_NUMS)
    {
        //截取到最大位置的字符(由于超出截部分在should时被处理了所在这里这了提高效率不再判断)
        NSString *s = [nsTextContent substringToIndex:MAX_LIMIT_NUMS];
        
        [textView setText:s];
    }
    
    //不让显示负数 口口日
    _sumlbl.text = [NSString stringWithFormat:@"%ld",MAX(0,MAX_LIMIT_NUMS - existTextNum)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
