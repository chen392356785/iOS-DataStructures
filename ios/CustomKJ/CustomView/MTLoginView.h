//
//  MTLoginView.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/4/5.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTLoginView : UIView<UITextViewDelegate,UITextFieldDelegate>
{
    
}
@property(nonatomic,copy)DidSelectYZMBlock selectYZMBlock;
@property(nonatomic,copy)DidSelectSurnBlock selectSurnBlock;
@property(nonatomic,strong) UIButton *loginBtn;
-(void)showLoginView:(LaginType)type;
-(void)hideView;
- (instancetype)initWithFrame:(CGRect)frame :(LaginType)type;

@end
