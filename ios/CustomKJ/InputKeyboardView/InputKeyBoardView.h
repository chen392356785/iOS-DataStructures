//
//  InputKeyBoardView.h
//  MiaoTuProject
//
//  Created by Mac on 16/4/12.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^DidSubmitBlock) (NSString *str);
typedef void (^DidBackBlock) (void);
@interface InputKeyBoardView : UIView<UITextViewDelegate>{
    SMLabel *_sumlbl;
    UIButton *_bgBtn;
}
@property (nonatomic,copy) DidSubmitBlock selectBlock;
@property(nonatomic,copy)DidBackBlock backBlock;
@property(nonatomic,strong)    PlaceholderTextView * txtView;
@property (nonatomic,strong)SMLabel *lbl;
@property (nonatomic,strong)UIButton *button;
    
-(id)initWithFrame:(CGRect)frame submit:(void (^)(NSString *str))submit back:(void(^)(void))back ;

@end
