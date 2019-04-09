//
//  inputView.h
//  textInput
//
//  Created by fangliguo on 2017/4/11.
//  Copyright © 2017年 fangliguo. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol inputViewDelegate

- (void)sendText:(NSString *)text;

@end

@interface inputView : UIView

@property (nonatomic, strong) UILabel *placeLabel;
@property (nonatomic, strong) UITextView *inputTextView;

@property (nonatomic, copy) DidSelectBlock tapBgViewBlock;
- (void)inputViewShow;
- (void)inputViewHiden;
@property (nonatomic, weak) id<inputViewDelegate>delegate;

@end
