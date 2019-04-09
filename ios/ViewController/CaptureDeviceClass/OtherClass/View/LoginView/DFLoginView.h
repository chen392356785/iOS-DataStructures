//
//  DFLoginView.h
//  DF
//
//  Created by Tata on 2017/12/4.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFBaseView.h"

@interface DFLoginView : DFBaseView

@property (nonatomic, readonly) UIButton *wechatButton;
@property (nonatomic, readonly) UITextField *phoneTextField;
@property (nonatomic, readonly) UIButton *sendCodeButton;
@property (nonatomic, readonly) UITextField *codeTextField;
@property (nonatomic, readonly) UIButton *voiceButton;
@property (nonatomic, readonly) UIButton *loginButton;

@end
