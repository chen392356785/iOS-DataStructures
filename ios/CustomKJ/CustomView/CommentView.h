//
//  CommentView.h
//  MiaoTuProject
//
//  Created by Mac on 16/4/15.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomView.h"
@class MTSupplyAndBuyListModel;
@interface CommentView : CustomView
{
//    BOOL _share;
//    BOOL _agree;
//    BOOL _favrite;
    UIButton *_likeBtn;
    UIButton *_zanBtn;
    SMLabel *_timelbl;
//    UIImageView *_timeImage;
    UIButton *_commentBtn;
    
}
- (instancetype)initWithFrame:(CGRect)frame isMe:(BOOL)isMe;
-(void)setData:(MTSupplyAndBuyListModel *)mod;
- (instancetype)initWithTopicBottomFrame:(CGRect)frame;
@property (nonatomic,copy) DidSelectCommentButtonBlock selectBlock;

@end
