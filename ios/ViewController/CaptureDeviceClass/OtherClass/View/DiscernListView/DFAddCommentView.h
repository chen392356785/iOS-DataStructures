//
//  DFAddCommentView.h
//  DF
//
//  Created by Tata on 2017/12/6.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "ClassyLiveLayout.h"

@protocol DFAddCommentViewDelegate <NSObject>

- (void)confirmComment;

- (void)cancleComment;

@end

@interface DFAddCommentView : SHPAbstractView

@property (nonatomic, weak) id <DFAddCommentViewDelegate> delegate;

@property (nonatomic, readonly) UITextView *textView;

@end
