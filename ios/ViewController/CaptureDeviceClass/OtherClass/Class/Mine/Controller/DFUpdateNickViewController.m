//
//  DFUpdateNickViewController.m
//  DF
//
//  Created by Tata on 2017/12/5.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFIconConstant.h"
#import "DFIdentifierConstant.h"
#import "DFUpdateNickViewController.h"

#define kMaxLength 16
@interface DFUpdateNickViewController ()<UITextFieldDelegate>
{
    UILabel * tipLabel;
}
// 确定按钮
@property (nonatomic, strong) UIButton    *submitButton;
// 昵称输入框
@property (nonatomic,   weak) UITextField *nameTextField;

@end

@implementation DFUpdateNickViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpNav];
    // 初始化页面
    [self initViews];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChanged:) name:UITextFieldTextDidChangeNotification object:self.nameTextField];
}
#pragma mark --设置导航栏--
- (void)setUpNav {
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(10, DFStatusHeight, 40, 40);
    [backButton setImage:kImage(BackArrowGreen) forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((iPhoneWidth - 200)/2, DFStatusHeight, 200, 40)];
    titleLabel.text = DFUpdateNickString();
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont fontWithName:PingFangLightFont() size:18 * TTUIScale()];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, DFNavigationBar - 0.5, iPhoneWidth, 0.5)];
    lineView.backgroundColor = THLineColor;
    [self.view addSubview:lineView];
}

#pragma mark - 初始化页面
- (void)initViews
{
    // 输入框背景
    CGFloat margin = 16;
    
    // 输入框
    UITextField * nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(margin , DFNavigationBar+18 , iPhoneWidth - margin * 2, 45)];
    nameTextField.backgroundColor    = [UIColor whiteColor];
    nameTextField.borderStyle        = UITextBorderStyleNone;
    nameTextField.layer.borderWidth  = 1.0;
    nameTextField.layer.borderColor  = THBaseLightGray.CGColor;
    nameTextField.layer.cornerRadius = 3.0;
    nameTextField.returnKeyType   = UIReturnKeyDone;
    nameTextField.clearButtonMode = UITextFieldViewModeAlways;
    nameTextField.font            = kLightFont(14);
    nameTextField.textColor    = THTextColor;
    nameTextField.textAlignment=NSTextAlignmentLeft;
    nameTextField.delegate     = self;
    nameTextField.placeholder  = DFSetNickString();
    if (UserModel.Nick.length>0)
    {
        nameTextField.text=UserModel.Nick;
    }
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, nameTextField.height)];
    view.backgroundColor=[UIColor clearColor];
    nameTextField.leftView = view;
    nameTextField.leftViewMode = UITextFieldViewModeAlways;
    self.nameTextField = nameTextField;
    [self.view addSubview:nameTextField];
    
    // 提示文字
    tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameTextField.x, CGRectGetMaxY(nameTextField.frame) + 18, nameTextField.width, 13)];
    tipLabel.textColor = THColorFromRGB(0x7B7A87);
    tipLabel.font = kLightFont(12);
    tipLabel.text = [NSString stringWithFormat:@"限%d个字符",kMaxLength];
    [self.view addSubview:tipLabel];
    
    // 确定按钮
    CGFloat btnX = nameTextField.x;
    CGFloat btnY = CGRectGetMaxY(tipLabel.frame)+18;
    CGFloat btnW = iPhoneWidth - 2 * btnX;
    CGFloat btnH = 45;
    UIButton * submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
    [submitButton setTitle:DFSureSubmitString() forState:UIControlStateNormal];
    submitButton.titleLabel.font = kLightFont(16);
    [submitButton addTarget:self action:@selector(confirmButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    submitButton.layer.cornerRadius  = 3.0;
    submitButton.layer.masksToBounds = YES;
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitButton.backgroundColor       = THBtnBackgroundColor;
    submitButton.userInteractionEnabled= NO;
    self.submitButton = submitButton;
    [self.view addSubview:submitButton];
}

#pragma mark --确定按钮点击--
- (void)confirmButtonAction:(UIButton *)button
{
    [self.view endEditing:YES];
    NSString * nameString = _nameTextField.text;
    
    // 判断输入的是否包含emoji表情
    if ([nameString isIncludingEmoji])
    {
        [DFTool showTips:DFEmojiLimitString()];
        return;
    }
    
    // 判断是否包含空格
    if ([NSString stringContainEmpty:nameString])
    {
        [DFTool showTips:DFSpaceLimitString()];
        return;
    }
    
    // 判断是否包含特殊字符
    NSString    *regex = @"^[A-Za-z0-9\u4E00-\u9FA5_-]+$";
    NSPredicate *pred  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if(![pred evaluateWithObject:nameString])
    {
        [DFTool showTips:DFSpecialLimitString()];
        return;
    }
    
    [DFTool addWaitingView:self.view];
    [HttpRequest postUpdateUserInfoWith:UserModel.Id nick:nameString headImage:UserModel.HeadImage signature:UserModel.Signature genderType:UserModel.GenderType success:^(NSDictionary *result)
     {
         [DFTool removeWaitingView:self.view];
         [DFTool showTips:DFSetSuccessString()];
         //给模型赋值
         UserModel.Nick = self->_nameTextField.text;
         
         NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
         [userDefault setObject:UserModel.Nick forKey:@"Nick"];
         [userDefault synchronize];
         //发送刷新
         [[NSNotificationCenter defaultCenter] postNotificationName:UpdateUserInfoIdentifier object:nil];
         [self.navigationController popViewControllerAnimated:YES];
     } failure:^(NSError *error) {
         [DFTool removeWaitingView:self.view];
     }];
}

#pragma mark --让键盘退出响应--
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark --键盘的通知--
- (void)textViewDidChanged:(NSNotification *)notify
{
    UITextField * textField = (UITextField *)notify.object;
    NSString *toBeString = textField.text;
    NSString *lang = [textField.textInputMode primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"])
    {
        // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position)
        {
            if (toBeString.length > kMaxLength)
            {
                textField.text = [toBeString substringToIndex:kMaxLength];
                tipLabel.text  = DFNickNumLimitString();
                tipLabel.textColor=[UIColor redColor];
            }
            else
            {
                tipLabel.text = [NSString stringWithFormat:@"限%d个字符",kMaxLength];
                tipLabel.textColor = THColorFromRGB(0x7B7A87);
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{}
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else
    {
        if (toBeString.length > kMaxLength)
        {
            textField.text = [toBeString substringToIndex:kMaxLength];
            tipLabel.text  = DFNickNumLimitString();
            tipLabel.textColor=[UIColor redColor];
        }
        else
        {
            tipLabel.text = [NSString stringWithFormat:@"限%d个字符",kMaxLength];
            tipLabel.textColor = THColorFromRGB(0x7B7A87);
        }
    }
    
    if (self.nameTextField.text.length > 0)
    {
        self.submitButton.backgroundColor       = THBaseColor;
        [self.submitButton setTitleColor:THBtnSelectTitleColor forState:UIControlStateNormal];
        self.submitButton.userInteractionEnabled= YES;
    }
    else
    {
        self.submitButton.backgroundColor       = THBtnBackgroundColor;
        [self.submitButton setTitleColor:THBtnTitleColor forState:UIControlStateNormal];
        self.submitButton.userInteractionEnabled= NO;
    }
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
