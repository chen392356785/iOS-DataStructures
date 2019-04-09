//
//  InputKeyBoardView.m
//  MiaoTuProject
//
//  Created by Mac on 16/4/12.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "InputKeyBoardView.h"
#define MAX_LIMIT_NUMS   150
@implementation InputKeyBoardView

-(id)initWithFrame:(CGRect)frame submit:(void (^)(NSString *str))submit back:(void(^)(void))back {
    self = [super initWithFrame:frame];
    if (self) {
        self.selectBlock=submit;
        self.backBlock=back;
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(0, 0, WindowWith, WindowHeight);
        btn.backgroundColor=RGBA(0, 0, 0, 0.2);
        btn.alpha=0;
        _bgBtn=btn;
        [btn addTarget:self action:@selector(hideView) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 116 - TFXHomeHeight, WindowWith, 116)];
        customView.backgroundColor = [UIColor whiteColor];
        [self addSubview:customView];
        
        UIButton *btn2=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn2.frame=CGRectMake(0, 0, 50, 36);
        btn2.tag=13;
        [btn2 setTitle:@"取消" forState:UIControlStateNormal];
        [btn2 setTitleColor:[IHUtility colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [btn2 addTarget:self action:@selector(hideView) forControlEvents:UIControlEventTouchUpInside];
        btn2.titleLabel.font=sysFont(13);
        [customView addSubview:btn2];
        
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, 0, WindowWith, 36) textColor:cBlackColor textFont:sysFont(15)];
        lbl.textAlignment=NSTextAlignmentCenter;
        lbl.text=@"评论";
        self.lbl = lbl;
        [customView addSubview:lbl];
        
        UIButton* btn3=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn3.frame=CGRectMake(WindowWith-50, 0, 50, 36);
        btn3.tag=22;
        [btn3 setTitle:@"发送" forState:UIControlStateNormal];
        [btn3 setTitleColor:[IHUtility colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [btn3 addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
        btn3.titleLabel.font=sysFont(13);
        self.button = btn3;
        [customView addSubview:btn3];
        
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(12, btn3.bottom, WindowWith-24, 1)];
        lineView.backgroundColor=cLineColor;
        [customView addSubview:lineView];
        
        self.txtView=[[PlaceholderTextView alloc]initWithFrame:CGRectMake(8, lineView.bottom, WindowWith-16, 53)];
        self.txtView.placeholderFont=sysFont(17);
        self.txtView.delegate=self;
      
        self.txtView.returnKeyType=UIReturnKeyDone;
        self.txtView.placeholder=@"在这里吐槽一下吧";
        self.txtView.font=sysFont(17);
        [customView addSubview:self.txtView];;
        
        lineView=[[UIView alloc]initWithFrame:CGRectMake(12, self.txtView.bottom+2, WindowWith-24, 1)];
        lineView.backgroundColor=cLineColor;
        [customView addSubview:lineView];
        
        _sumlbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, lineView.bottom , WindowWith-12, 23) textColor: [IHUtility colorWithHexString:@"#bbbbbb"] textFont:sysFont(13)];
        _sumlbl.textAlignment=NSTextAlignmentRight;
        
        _sumlbl.text=stringFormatInt(MAX_LIMIT_NUMS);
        [customView addSubview:_sumlbl];
  
    }
    return self;
}

-(void)delayMethod{
    [UIView animateWithDuration:0.5 animations:^{
        self->_bgBtn.alpha=1;
    }];
}

-(void)hideView{
     
    
    [UIView animateWithDuration:0.3 animations:^{
         self->_bgBtn.alpha=0;
    } completion:^(BOOL finished) {
        [self.txtView resignFirstResponder];
        self.backBlock();
    }];
   
    
}


-(void)submit:(UIButton *)sender{
    if (_txtView.text.length==0) {
        [self hideView];
        return;
    }
    
    if (_txtView.text.length>150) {
        [IHUtility addSucessView:@"评论字数不能超过150哦" type:2];
        return;
    }
     [self hideView];
    self.selectBlock(_txtView.text);
   
    
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView.text.length==0) {
        _sumlbl.text=stringFormatInt(MAX_LIMIT_NUMS);
    }
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
     [self performSelector:@selector(delayMethod) withObject:nil afterDelay:0.3f];
    
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
    textView.contentOffset = CGPointMake(0, iPhoneHeight);
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
