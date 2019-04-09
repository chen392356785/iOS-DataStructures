//
//  MTSearchView.h
//  MiaoTuProject
//
//  Created by tinghua on 2018/9/20.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TFFlowerSearchViewDelegate <NSObject>

@optional
- (void)flowerSearchViewWithText:(NSString *)searchText textField:(UITextField *)textField;

@optional
- (void)flowertextFieldCleartextField:(UITextField *)textField;

@optional
- (void)flowerChangeCharactersInRange:(NSString *)searchText textField:(UITextField *)textField;
@end

@interface MTHomeSearchView : UIView


/**代理*/
@property (nonatomic,assign) id<TFFlowerSearchViewDelegate>delegate;
/**搜索条*/
@property (nonatomic,strong,readonly) UITextField *searchTextField;
/**搜索内容*/
@property (nonatomic,copy) NSString *searchPlaceText;
/**设置右侧视图*/
@property (nonatomic,strong) UIImage *rightButtonImage;
/**语音按钮*/
@property (strong, nonatomic) UIButton *voiceButton;

@end
