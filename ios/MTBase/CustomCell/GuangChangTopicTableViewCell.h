//
//  GuangChangTopicTableViewCell.h
//  MiaoTuProject
//
//  Created by Mac on 16/4/15.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTTableViewCell.h"


@class MTTopicListModel;
@class TopicListView;
@class  TopicBottomView;
@class MyCollectionTopicModel;
@interface GuangChangTopicTableViewCell : MTTableViewCell
{
    HeaderView *_headView;
    TopicListView *_topicView;
    TopicBottomView *_topicBottomView;
    UIView *_lineView;
    CancelView *_cancelView;
    CommentView *_commentView;
}
@property(nonatomic,strong)MTTopicListModel *model;
@property(nonatomic,strong)MyCollectionTopicModel*colmod;

-(void)setCollectionData:(CollecgtionType)type;
-(void)setData:(CollecgtionType)type isMe:(BOOL)isMe;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(CollecgtionType)type  isMe:(BOOL)isMe;
@end
