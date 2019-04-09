//
//  DFUserCommentView.h
//  DF
//
//  Created by Tata on 2017/11/30.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "DFBaseView.h"

@interface DFUserCommentView : DFBaseView

@property (nonatomic, readonly) UITableView *tableView;

@property (nonatomic, readonly) UIView *commentView;
@property (nonatomic, readonly) UITextField *textField;
@property (nonatomic, readonly) UIButton *sendButton;

@end
