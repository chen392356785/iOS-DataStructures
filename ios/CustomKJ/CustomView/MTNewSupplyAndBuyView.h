//
//  MTNewSupplyAndBuyView.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/7/20.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "CustomView.h"
@class CommentAndLikeView;

@interface MTNewSupplyAndBuyView : CustomView
{
    SMLabel *_nickName;
    CommentAndLikeView *_commentAndLikeView;
    UIButton *_btn;
}


@end
