//
//  DFUpdateSignatureViewController.m
//  DF
//
//  Created by Tata on 2017/12/5.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFIconConstant.h"
#import "DFIdentifierConstant.h"
#import "DFUpdateSignatureViewController.h"
#import "TFPlaceHolderTextView.h"
//#import "NSString+Extension.h"

#define kMaxLength 32

@interface DFUpdateSignatureViewController ()<UITextViewDelegate>
/**文本输入*/
@property (nonatomic,weak) TFPlaceHolderTextView *textView;
// 确定按钮
@property (nonatomic, strong) UIButton *submitButton;
@property (nonatomic, strong) UILabel  *labelNum;

@end

@implementation DFUpdateSignatureViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpNav];
    [self setUpView];
}
#pragma mark --设置导航栏--
- (void)setUpNav
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(10, DFStatusHeight, 40, 40);
    [backButton setImage:kImage(BackArrowGreen) forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((iPhoneWidth - 200)/2, DFStatusHeight, 200, 40)];
    titleLabel.text = DFUpdateSignatureString();
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont fontWithName:PingFangLightFont() size:18 * TTUIScale()];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, DFNavigationBar - 0.5, iPhoneWidth, 0.5)];
    lineView.backgroundColor = THLineColor;
    [self.view addSubview:lineView];
}

/**
 *  初始化view
 */
- (void)setUpView
{
    TFPlaceHolderTextView * textView = [[TFPlaceHolderTextView alloc] init];
    self.textView = textView;
    textView.delegate           = self;
    textView.scrollEnabled      = NO;
    textView.layer.borderWidth  = 1.0;
    textView.layer.cornerRadius = 3.0;
    textView.layer.borderColor  = THBaseLightGray.CGColor;
    textView.backgroundColor    = [UIColor whiteColor];
    textView.placeholder = DFSignaturePlaceholderString();
    CGFloat leftMargin = 16;
    CGFloat textViewX = leftMargin;
    CGFloat textViewY = 20 + DFNavigationBar;
    CGFloat textViewW = iPhoneWidth - leftMargin *2;
    CGFloat textViewH = 165;
    textView.frame = CGRectMake(textViewX, textViewY, textViewW, textViewH);
    [self.view addSubview:textView];
    
    if (UserModel.Signature.length>0)
    {
        self.textView.text = UserModel.Signature;
    }
    
    //文字计数
    _labelNum = [[UILabel alloc]initWithFrame:CGRectMake(textView.width-40, textView.height-23, 39, 20)];
    _labelNum.textAlignment=NSTextAlignmentCenter;
    _labelNum.font = kLightFont(14);
    _labelNum.text = [NSString stringWithFormat:@"%d",kMaxLength];
    _labelNum.textColor = THBaseGray;
    _labelNum.backgroundColor = [UIColor clearColor];
    [textView addSubview:_labelNum];
    
    // 确定按钮
    CGFloat btnX = leftMargin;
    CGFloat btnY = CGRectGetMaxY(self.textView.frame) + 20;
    CGFloat btnW = iPhoneWidth - 2 * leftMargin;
    CGFloat btnH = 40;
    UIButton * submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.submitButton = submitButton;
    submitButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
    [submitButton setTitle:DFSureSubmitString() forState:UIControlStateNormal];
    submitButton.titleLabel.font = kLightFont(15);
    [submitButton addTarget:self action:@selector(confirmBtonAction:) forControlEvents:UIControlEventTouchUpInside];
    submitButton.userInteractionEnabled=NO;
    submitButton.backgroundColor=THBtnBackgroundColor;
    [self.submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitButton.layer.cornerRadius   = 2.0;
    submitButton.layer.masksToBounds  = YES;
    [self.view addSubview:submitButton];
}
#pragma mark --确定按钮点击--
- (void)confirmBtonAction:(UIButton *)button
{
    [self.view endEditing:YES];
    
    NSString * nameString = self.textView.text;
    if (nameString.length > 0)
    {
        // 判断输入的是否包含emoji表情
        BOOL isEmoji = [nameString isIncludingEmoji];
        if (isEmoji)
        {
            [DFTool showTips:DFEmojiLimitString()];
            return;
        }
        // 判断是否包含空格
        BOOL isContainEmpty = [NSString stringContainEmpty:nameString];
        if (isContainEmpty)
        {
            [DFTool showTips:DFSpaceLimitString()];
            return;
        }
        
        [DFTool addWaitingView:self.view];
        [HttpRequest postUpdateUserInfoWith:UserModel.Id nick:UserModel.Nick headImage:UserModel.HeadImage signature:nameString genderType:UserModel.GenderType success:^(NSDictionary *result)
         {
             [DFTool removeWaitingView:self.view];
             [DFTool showTips:DFSetSuccessString()];
             UserModel.Signature = nameString;
             NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
             [userDefault setObject:UserModel.Signature  forKey:@"Signature"];
             [userDefault synchronize];
             //发送刷新
             [[NSNotificationCenter defaultCenter] postNotificationName:UpdateUserInfoIdentifier object:nil];
             [self.navigationController popViewControllerAnimated:YES];
         } failure:^(NSError *error) {
             [DFTool removeWaitingView:self.view];
         }];
    }
    else
    {
        [DFTool alertMessage:DFLetterString() message:DFSetSignatureString()];
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    NSInteger textLength = [textView getInputLengthWithText:textView.text]/2;
    if (textLength > 0)
    {
        self.submitButton.userInteractionEnabled=YES;
        self.submitButton.backgroundColor = THBaseColor;
        [self.submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else
    {
        self.submitButton.userInteractionEnabled=NO;
        self.submitButton.backgroundColor=THBtnBackgroundColor;
        [self.submitButton setTitleColor:THBtnTitleColor forState:UIControlStateNormal];
    }
    
    if (textLength > kMaxLength)
    {
        if ([textView.text isEqualToString:@""])
        {
            return ;
        }
        [DFTool showTips:DFSignatureNumlimitString()];
        textView.text=[textView.text substringWithRange:NSMakeRange(0, kMaxLength)];
        return;
    }
    _labelNum.text=[NSString stringWithFormat:@"%ld",kMaxLength-textLength];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
