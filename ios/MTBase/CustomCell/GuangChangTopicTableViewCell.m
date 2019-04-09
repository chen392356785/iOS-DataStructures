//
//  GuangChangTopicTableViewCell.m
//  MiaoTuProject
//
//  Created by Mac on 16/4/15.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "CommentView.h"
//#import "GuangChangTopicTableViewCell.h"

@implementation GuangChangTopicTableViewCell
@synthesize model,colmod;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(CollecgtionType)type isMe:(BOOL)isMe{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        int headViewHeigh=0;
        if (type==ENT_Collection || type==ENT_topic) {
            HeaderView *headView=[[HeaderView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 60)];
            _headView=headView;
            headView.selectBlock=^(NSInteger index){
                
                if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
                    if (type==ENT_Collection) {
                         [self.delegate BCtableViewCell:self action:MTHeadViewActionTableViewCell indexPath:self.indexPath attribute:self->colmod.topicInfo];
                    }else
                        [self.delegate BCtableViewCell:self action:MTHeadViewActionTableViewCell indexPath:self.indexPath attribute:self->model];
                }
            };
            
            [self.contentView addSubview:headView];
            headViewHeigh=headView.bottom;
        }
        
        
        TopicListView *topicView=[[TopicListView alloc]initWithFrame:CGRectMake(0, headViewHeigh, WindowWith, 420)];
        _topicView=topicView;
        [self.contentView addSubview:topicView];
        
        int downHeigh=0;
        
        if (type==ENT_Collection ) {
            
            CancelView *cancelView=[[CancelView alloc]initWithFrame:CGRectMake(0, topicView.bottom, WindowWith, 40) ];
            _cancelView=cancelView;
            [cancelView.cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:cancelView];
            
            downHeigh=cancelView.bottom;
        }else if (type==ENT_Preson||type==ENT_topic){
            
            
            if (isMe) {
                CommentView *commentView=[[CommentView alloc]initWithTopicBottomFrame:CGRectMake(0, topicView.bottom, WindowWith, 39)];
                _commentView=commentView;
                commentView.selectBlock=^(BCTableViewCellAction action){
                    if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
                        [self.delegate BCtableViewCell:self action:action indexPath:self.indexPath attribute:self->model];
                    }
                };
                [self.contentView addSubview:commentView];
                downHeigh=commentView.bottom;
                
            }else{
                TopicBottomView *topicBottomView=[[TopicBottomView alloc]initWithFrame:CGRectMake(0, topicView.bottom, WindowWith, 30)];
                _topicBottomView=topicBottomView;
                topicBottomView.selectBlock=^(BCTableViewCellAction action){
                    if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
                        [self.delegate BCtableViewCell:self action:action indexPath:self.indexPath attribute:self->model];
                    }
                };
                
                [self.contentView addSubview:topicBottomView];
                  downHeigh=topicBottomView.bottom;
            }
       
        }
        
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, downHeigh, WindowWith, 6)];
        _lineView=lineView;
        lineView.backgroundColor=cBgColor;
        [self.contentView addSubview:lineView];
        
    }
    return self;
}


-(void)cancelClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
        [self.delegate BCtableViewCell:self action:MTcancelFavriteTopicActionTableViewCell indexPath:self.indexPath attribute:colmod.topicInfo];
    }

}

-(void)setData:(CollecgtionType)type isMe:(BOOL)isMe{
    if (type==ENT_Collection || type==ENT_topic) {
        [_headView setData:model.userChildrenInfo type:ENT_Topic];
    }
    
    
    [_topicView setData:model];
    CGRect rect=_topicView.frame;
    if (type==ENT_Preson) {
        rect.origin.y=10;
    }else{
        rect.origin.y=_headView.bottom;
    }
    rect.size.height=[model.bodyHeigh floatValue];
    _topicView.frame=rect;
    
    
   
    
  
    
    if (isMe) {
        rect=_commentView.frame;
        rect.origin.y= _topicView.bottom;
        _commentView.frame=rect;
        
        rect=_lineView.frame;
        rect.origin.y=_commentView.bottom;
        _lineView.frame=rect;
    }else{
        rect=_topicBottomView.frame;
        rect.origin.y= _topicView.bottom;
        _topicBottomView.frame=rect;
         [_topicBottomView setData:model];
        
        rect=_lineView.frame;
        rect.origin.y=_topicBottomView.bottom+4;
        _lineView.frame=rect;
    }
    
   
   
}

-(void)setCollectionData:(CollecgtionType)type{
    [_headView setData:colmod.topicInfo.userChildrenInfo type:ENT_Topic];
    
    [_topicView setData:colmod.topicInfo];
    CGRect rect=_topicView.frame;
    
    rect.size.height=[colmod.topicInfo.bodyHeigh floatValue];
    _topicView.frame=rect;
    
    
    rect=_cancelView.frame;
    rect.origin.y= _topicView.bottom;
    _cancelView.frame=rect;
    
    [_cancelView setData:colmod.collectionTime];
    _lineView.hidden=YES;
    
}

@end


