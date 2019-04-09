//
//  ActivtyCrowdViewController.m
//  MiaoTuProject
//
//  Created by Zmh on 9/8/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "ActivtyCrowdViewController.h"
#import "orderStateView.h"
//#import "InputKeyBoardView.h"
#import "CrowdFundingViewController.h"
#import "PayMentMangers.h"
//#import "ActivityPaySuccessfulViewController.h"
#import "THNotificationCenter+C.h"

#define MAX_LIMIT_NUMS   150
@interface ActivtyCrowdViewController ()<UITextViewDelegate>
{
    IHTextField *_companyText;
    IHTextField *_jobText;
    IHTextField *_nameText;
    IHTextField *_phoneText;
    SMLabel *_numLbl;
    SMLabel *_sumlbl;
    SMLabel *_priceLbl;
    SMLabel *_totalLbl;
    SMLabel *_SettlementLbl;
    PlaceholderTextView *_textView;
}
@end

@implementation ActivtyCrowdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"众筹信息"];
    
    _BaseScrollView.backgroundColor = cLineColor;
    _BaseScrollView.frame = CGRectMake(0, 0, WindowWith, WindowHeight - 45);
    orderStateView *orderView = [[orderStateView alloc] initWithFrame:CGRectMake(0, 3, kScreenWidth, 100)];
    orderView.priceLbl.hidden = YES;
    [orderView setActivtiesData:self.model];
    [_BaseScrollView addSubview:orderView];
    
    UIView *infoView = [[UIView alloc] initWithFrame:CGRectMake(0, orderView.bottom + 5, WindowWith, 80)];
    infoView.backgroundColor = [UIColor whiteColor];
    [_BaseScrollView addSubview:infoView];
    
    SMLabel *lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(0, 18, 60, 20) textColor:RGB(44, 44, 46) textFont:sysFont(15)];
    lbl.centerX = WindowWith/2.0;
    lbl.text = @"名额";
    lbl.textAlignment = NSTextAlignmentCenter;
    [infoView addSubview:lbl];
    
    lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(0, lbl.bottom + 8, 30, 22) textColor:RGB(6, 193, 174) textFont:sysFont(15)];
    lbl.centerX = WindowWith/2.0;
    lbl.text = @"1";
    _numLbl = lbl;
    lbl.textAlignment = NSTextAlignmentCenter;
    [infoView addSubview:lbl];
    
    UIButton *reduceBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, lbl.top, 22, 22)];
    reduceBtn.right = lbl.left - 10;
    reduceBtn.layer.borderColor = RGB(177, 177, 182).CGColor;
    reduceBtn.layer.borderWidth =0.7;
    [reduceBtn setImage:Image(@"activ_reduceNum.png") forState:UIControlStateNormal];
    [reduceBtn addTarget:self action:@selector(reduceNum:) forControlEvents:UIControlEventTouchUpInside];
//    [infoView addSubview:reduceBtn];
    
    UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, lbl.top, 22, 22)];
    addBtn.left = lbl.right + 10;
    addBtn.layer.borderColor = RGB(177, 177, 182).CGColor;
    addBtn.layer.borderWidth =0.7;
    [addBtn setImage:Image(@"activ_addNum.png") forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addNum:) forControlEvents:UIControlEventTouchUpInside];
//    [infoView addSubview:addBtn];
    
    lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(0, 18, 60, 20) textColor:RGB(44, 44, 46) textFont:sysFont(15)];
    lbl.centerX = WindowWith/2.0 - 110;
    lbl.text = @"金额";
    lbl.textAlignment = NSTextAlignmentCenter;
    [infoView addSubview:lbl];
    
    CGSize size = [IHUtility GetSizeByText:[NSString stringWithFormat:@"%@元",self.model.payment_amount] sizeOfFont:15 width:WindowWith/3.0];
    lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(0, lbl.bottom + 8, size.width, 22) textColor:RGB(6, 193, 174) textFont:sysFont(15)];
    lbl.centerX = WindowWith/2.0 - 110;
    lbl.text = [NSString stringWithFormat:@"%@元",self.model.payment_amount];
    lbl.textAlignment = NSTextAlignmentCenter;
    _priceLbl = lbl;
    [infoView addSubview:lbl];
    
    lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(0, 18, 45, 20) textColor:RGB(44, 44, 46) textFont:sysFont(15)];
    lbl.centerX = WindowWith/2.0 + 102.5;
    lbl.text = @"总金额";
    lbl.textAlignment = NSTextAlignmentCenter;
    [infoView addSubview:lbl];
    
    size = [IHUtility GetSizeByText:[NSString stringWithFormat:@"%.2f元",[self.model.payment_amount floatValue]] sizeOfFont:15 width:WindowWith/3.0];
    lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(0, lbl.bottom + 8, size.width, 22) textColor:RGB(6, 193, 174) textFont:sysFont(15)];
    lbl.centerX = WindowWith/2.0 + 102.5;
    lbl.text = [NSString stringWithFormat:@"%.2f元",[self.model.payment_amount floatValue]];
    _totalLbl = lbl;
    lbl.textAlignment = NSTextAlignmentCenter;
    [infoView addSubview:lbl];
    
    
    NSArray *infokey = [self.model.userinfoDic allKeys];
    NSMutableArray *arr = [NSMutableArray array];
    for (int j = 0; j<infokey.count; j++) {
        NSString *value = [NSString stringWithFormat:@"%@",[self.model.userinfoDic objectForKey:infokey[j]]];
        if ([value isEqualToString:@"1"]) {
            if ([infokey[j] isEqualToString:@"company"]) {
                [arr addObject:@"公司名称"];
            }else if ([infokey[j] isEqualToString:@"job"]){
                [arr addObject:@"职    位"];
            }else if ([infokey[j] isEqualToString:@"name"]){
                [arr addObject:@"姓    名"];
            }else if ([infokey[j] isEqualToString:@"mobile"]){
                [arr addObject:@"联系电话"];
            }
        }
    }
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, infoView.bottom + 5, WindowWith, arr.count * 45)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [_BaseScrollView addSubview:bottomView];
    for (int i =0; i<arr.count; i++) {
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 45*i, WindowWith, 45)];
        [bottomView addSubview:backView];
        
        SMLabel *label = [[SMLabel alloc] initWithFrameWith:CGRectMake(15, 20, 55, 22) textColor:RGB(132, 131, 136) textFont:sysFont(13)];
        label.text = arr[i];
        [backView addSubview:label];
        
        IHTextField *textFiled = [[IHTextField alloc] initWithFrame:CGRectMake(label.right + 8, label.top, WindowWith - label.right - 18, 22)];
        textFiled.delegate=self;
        textFiled.textColor = RGB(44, 44, 46);
        textFiled.font = sysFont(15);
        if ([arr[i] isEqualToString:@"公司名称"]) {
            textFiled.text = USERMODEL.companyName;
            _companyText = textFiled;
        }else if ([arr[i] isEqualToString:@"职    位"]){
            _jobText = textFiled;
        }else if ([arr[i] isEqualToString:@"姓    名"]){
            textFiled.text = USERMODEL.nickName;
            _nameText = textFiled;
        }else if ([arr[i] isEqualToString:@"联系电话"]){
            textFiled.text = USERMODEL.mobile;
            _phoneText = textFiled;
            //  _phoneText.delegate = self;
        }
        [backView addSubview:textFiled];
        
        UIView *linview = [[UIView alloc] initWithFrame:CGRectMake(textFiled.left, textFiled.bottom, textFiled.width, 0.5)];
        linview.backgroundColor = cLineColor;
        [backView addSubview:linview];
    }
    
    UIView *RemarksView = [[UIView alloc] initWithFrame:CGRectMake(0, bottomView.bottom, WindowWith, 220)];
    RemarksView.backgroundColor = [UIColor whiteColor];
    [_BaseScrollView addSubview:RemarksView];
    
    lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(16, 18, 30, 22) textColor:RGB(132, 131, 136) textFont:sysFont(15)];
    lbl.text = @"备注";
    [RemarksView addSubview:lbl];
    
//    UIView *linev = [[UIView alloc] initWithFrame:CGRectMake(16, lbl.bottom , WindowWith-32, 0.7)];
//    linev.backgroundColor = cLineColor;
//    [RemarksView addSubview:linev];
    
    PlaceholderTextView *textView = [[PlaceholderTextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lbl.frame)+10, 15, SCREEN_WIDTH-30-26-15, 130)];
    textView.placeholder = @"这里可以填写其他报名者的信息";
    textView.placeholderFont = sysFont(15);
    textView.font = sysFont(15);
    textView.delegate =  self;
    _textView = textView;
    [RemarksView addSubview:textView];
    
    UIView *v=[[UIView alloc] init];
    CGRect rect=v.frame;
    v.tag=1001;
    rect.size.height=41;
    [v setFrame:rect];
    v.backgroundColor=RGB(240, 240, 242);
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 1)];
    lineView.backgroundColor=RGB(193, 195, 198);
    [v addSubview:lineView];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    btn.titleLabel.font=boldFont(15);
    btn.frame=CGRectMake(WindowWith-56, 0, 56, 41);
    [btn addTarget:self action:@selector(hideKeyBoard:) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:btn];
    
    [textView setInputAccessoryView:v];
    
    UIView *linev = [[UIView alloc] initWithFrame:CGRectMake(16, textView.bottom , WindowWith-32, 0.7)];
    linev.backgroundColor = cLineColor;
    [RemarksView addSubview:linev];
    
    lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(0, linev.bottom, 22, 20) textColor:RGB(177, 177, 182) textFont:sysFont(12)];
    lbl.text = @"150";
    _sumlbl = lbl;
    lbl.right = WindowWith - 16;
    [RemarksView addSubview:lbl];
    
    _BaseScrollView.contentSize = CGSizeMake(WindowWith, RemarksView.bottom + 90);
    
    UIView *SettlementView = [[UIView alloc] initWithFrame:CGRectMake(0, WindowHeight - 45, WindowWith, 45)];
    SettlementView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:SettlementView];
    
    UIButton *referAlipayBtu = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 150 * WindowWith/375.0, 38)];
    referAlipayBtu.right = WindowWith - 17;
    referAlipayBtu.centerY = SettlementView.height/2.0;
    referAlipayBtu.backgroundColor = RGB(6, 193, 174);
    referAlipayBtu.layer.cornerRadius = 19.0;
    [referAlipayBtu setTitle:@"提交" forState:UIControlStateNormal];
    [referAlipayBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [referAlipayBtu addTarget:self action:@selector(referInfo:) forControlEvents:UIControlEventTouchUpInside];
    [SettlementView addSubview:referAlipayBtu];
    
    SMLabel *lbl2 = [[SMLabel alloc] initWithFrameWith:CGRectMake(45*WindowWith/375.0, 0, 40, 20) textColor:cBlackColor textFont:sysFont(17)];
    lbl2.text = @"合计:";
    lbl2.centerY = SettlementView.height/2.0;
    [SettlementView addSubview:lbl2];
    
    SMLabel *lbl3 = [[SMLabel alloc] initWithFrameWith:CGRectMake(lbl2.right, 0, referAlipayBtu.left - lbl2.right, 20) textColor:RGB(232, 121, 117) textFont:sysFont(17)];
    lbl3.text = [NSString stringWithFormat:@"¥%.2f",[self.model.payment_amount floatValue]];
    lbl3.centerY = SettlementView.height/2.0;
    _SettlementLbl = lbl3;
    [SettlementView addSubview:lbl3];
}

//减少名额数量
- (void)reduceNum:(UIButton *)button
{
    if ([_numLbl.text intValue]<= 1) {
        return;
    }
    _numLbl.text = [NSString stringWithFormat:@"%d",[_numLbl.text intValue] - 1];
    _totalLbl.text = [NSString stringWithFormat:@"%.2f元",[_numLbl.text intValue] * [_priceLbl.text floatValue]];
    CGSize size = [IHUtility GetSizeByText:_totalLbl.text sizeOfFont:15 width:WindowWith/3.0];
    _totalLbl.width = size.width;
    
    _SettlementLbl.text = [NSString stringWithFormat:@"¥%.2f",[_numLbl.text intValue] * [_priceLbl.text floatValue]];
}
- (void)addNum:(UIButton *)button
{
    _numLbl.text = [NSString stringWithFormat:@"%d",[_numLbl.text intValue] + 1];
    _totalLbl.text = [NSString stringWithFormat:@"%.2f元",[_numLbl.text intValue] * [_priceLbl.text floatValue]];
    
    CGSize size = [IHUtility GetSizeByText:_totalLbl.text sizeOfFont:15 width:WindowWith/3.0];
    _totalLbl.width = size.width;
    
    _SettlementLbl.text = [NSString stringWithFormat:@"¥%.2f",[_numLbl.text intValue] * [_priceLbl.text floatValue]];
}

- (void)referInfo:(UIButton *)button
{
    
    if (_nameText !=nil) {
        if (_nameText.text.length <= 0) {
            [self addSucessView:@"请输入联系人" type:2];
            return;
        }
    }
    
    if (_jobText !=nil) {
        if (_jobText.text.length <= 0) {
            [self addSucessView:@"请输入职位" type:2];
            return;
        }
    }
    if (_companyText != nil) {
        if (_companyText.text.length <= 0) {
            [self addSucessView:@"请输入公司名称" type:2];
            return;
        }
    }
    
    if (_phoneText != nil) {
        if (_phoneText.text.length < 11) {
            [self addSucessView:@"请输入联系电话" type:2];
            return;
        }
    }
    
    NSString *remarkText;
    if ([_textView.text isEqualToString:@"这里可以填写其他报名者的信息"]) {
        remarkText = @"";
    }else {
        remarkText = _textView.text;
    }
    NSString *context = @"开始众筹将生成订单，并跳转至支付（众筹）页面，您可在我的活动中查看详情。";
    NSArray *Arr = @[@"返回修改",@"开始众筹"];
    BombBoxView *boxView  = [[BombBoxView alloc] initWithFrame:self.view.window.bounds context:context title:@"确认订单" buttonArr:Arr];
    boxView.selectBlock = ^(NSInteger index){
        //支付
        [self referAlipay:remarkText];
    };
    boxView.alpha = 0;
    [self.view.window addSubview:boxView];
    [UIView animateWithDuration:1 animations:^{
        boxView.alpha = 1;
    }];
}
- (void)referAlipay:(NSString *)remarkText
{
    [self addWaitingView];
    
    [network getActivtyCrowdOrder:USERMODEL.userID activities_id:self.model.activities_id order_num:_numLbl.text contacts_people:_nameText.text contacts_phone:_phoneText.text job:_jobText.text company_name:_companyText.text email:@"" remark:remarkText success:^(NSDictionary *obj) {
        [self removeWaitingView];
        CrowdOrderModel *model = obj[@"content"];
        CrowdFundingViewController *vc = [[CrowdFundingViewController alloc] init];
        vc.model = model;
        PayMentMangers *paymentManager = [[PayMentMangers alloc]init];
        vc.payBlock = ^(NSString *price, NSString *orderNo, NSString *type, NSString *subject,NSString*crowId, SMBaseViewController *vc) {
            [paymentManager payment:orderNo orderPrice:price type:type subject:subject crowID:crowId activitieID:model.selectActivitiesListInfo.activities_id parentVC:vc resultBlock:^(BOOL isPaySuccess, NSString *msg) {
                if (isPaySuccess) {
                    [[THNotificationCenter singleton]notifiyCrowdSuccess:self.indexPath];
                }
            }];
        };
        [self pushViewController:vc];
    } failure:^(NSDictionary *obj2) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _phoneText && range.location>=11) {
        return NO;
    }
    return YES;
}

- (void)hideKeyBoard:(UIButton *)btn
{
    [_textView resignFirstResponder];
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView.text.length==0) {
        _sumlbl.text=stringFormatInt(MAX_LIMIT_NUMS);
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        
        if (textView.text.length>150) {
            [IHUtility addSucessView:@"评论字数不能超过150哦" type:2];
            return NO;
        }
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

@end
