//
//  DFDiscernDetailView.h
//  DF
//
//  Created by Tata on 2017/12/1.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFBaseView.h"

@interface DFDiscernDetailView : DFBaseView

@property (nonatomic, readonly) UIWebView *webView;

@property (nonatomic, readonly) UIView *toolView;
@property (nonatomic, readonly) UIButton *confirmButton;
@property (nonatomic, readonly) UIButton *shareButton;

@end
