//
//  GongQiuListTableViewCell.m
//  MiaoTuProject
//
//  Created by Mac on 16/4/14.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "CommentView.h"
//#import "GongQiuListTableViewCell.h"


@implementation GongQiuListTableViewCell
@synthesize model,collmodel;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(CollecgtionType)type isCollection:(BOOL)isCollection isMe:(BOOL)isMe{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat headHeigh=0;
        if (type==ENT_gongying  ||type==ENT_qiugou) {
            HeaderView *headView=[[HeaderView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 60)];
            _headView=headView;
            headView.selectBlock=^(NSInteger index){
                
                if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
                    if (isCollection) {
                        [self.delegate BCtableViewCell:self action:MTHeadViewActionTableViewCell indexPath:self.indexPath attribute:self->collmodel.supplyBuyInfo];
                    }else{
                        [self.delegate BCtableViewCell:self action:MTHeadViewActionTableViewCell indexPath:self.indexPath attribute:self->model];
                    }
                    
                    
                }
                
            };
            [self.contentView addSubview:headView];
            headHeigh=headView.bottom;
        }
        
        if (type==ENT_PerSonGongYing) {
            type=ENT_gongying;
        }else if (type==ENT_PerSonQiuGou){
            type=ENT_qiugou;
        }
        
        BuyListView *listView=[[BuyListView alloc]initWithFrame:CGRectMake(0, headHeigh, WindowWith, 459-60+240) type:type];
        _listView=listView;
        [self.contentView addSubview:listView];
        
        if (isCollection) {
            CancelView *cancelView=[[CancelView alloc]initWithFrame:CGRectMake(0, listView.bottom, WindowWith, 40)];
            _cancelView=cancelView;
            [cancelView.cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:cancelView];
        }
        else{
            CommentView *commentView=[[CommentView alloc]initWithFrame:CGRectMake(0, listView.bottom, WindowWith, 39) isMe:isMe];
            _commentView=commentView;
            commentView.selectBlock=^(BCTableViewCellAction action){
                if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
                    [self.delegate BCtableViewCell:self action:action indexPath:self.indexPath attribute:self->model];
                }
            };
            [self.contentView addSubview:commentView];
        }
        
        
    }
    return self;
}

-(void)setData:(CollecgtionType)type isHomePage:(BOOL)isHomePage{  //供应列表数据
    
    if (!isHomePage) {
        int type2 = 0;
        if (type==ENT_gongying) {
            
            type2=ENT_Supply;
        }else if (type==ENT_qiugou){
            type2=ENT_Buy;
        }
        [_headView setData:model.userChildrenInfo type:type2];
    }
    
    
    [_listView setData:model type:type];
    
    [_commentView setData:model];
    
    CGRect rect=_listView.frame;
    if (isHomePage) {
        rect.origin.y=0;
    }
    
    rect.size.height=[model.bodyHeigh floatValue];
    _listView.frame=rect;

    if (type==ENT_gongying||type==ENT_Preson||type==ENT_qiugou) {
        
        rect=_commentView.frame;
        rect.origin.y=_listView.bottom+17;
        _commentView.frame=rect;
        
    }
    
}


//
//-(void)setData:(CollecgtionType)type isHomePage:(BOOL)isHomePage Model:(MTSupplyAndBuyListModel *)Model{  //供应列表数据
//
//    if (!isHomePage) {
//        int type2 = 0;
//        if (type==ENT_gongying) {
//
//            type2=ENT_Supply;
//        }else if (type==ENT_qiugou){
//            type2=ENT_Buy;
//        }
//        [_headView setData:Model.userChildrenInfo type:type2];
//    }
//
//
//    [_listView setData:Model type:type];
//
//    [_commentView setData:Model];
//
//    CGRect rect=_listView.frame;
//    if (isHomePage) {
//        rect.origin.y=0;
//    }
//
//    rect.size.height=[Model.bodyHeigh floatValue];
//    _listView.frame=rect;
//
//    if (type==ENT_gongying||type==ENT_Preson||type==ENT_qiugou) {
//
//        rect=_commentView.frame;
//        rect.origin.y=_listView.bottom+17;
//        _commentView.frame=rect;
//
//    }
//
//}
//
//


//取消收藏
-(void)cancelClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
        if (self.type2==ENT_gongying) {
            [self.delegate BCtableViewCell:self action:MTcancelFavriteSupplyActionTableViewCell indexPath:self.indexPath attribute:collmodel.supplyBuyInfo];
        }else if (self.type2==ENT_qiugou){
             [self.delegate BCtableViewCell:self action:MTcancelFavriteBuyActionTableViewCell indexPath:self.indexPath attribute:collmodel.supplyBuyInfo];
        }
        
        
    }

}

//提供收藏数据
-(void)setCollectionData:(CollecgtionType)type{
    if (type==ENT_gongying  ||type==ENT_qiugou) {  //头像 部分
        int type2 = 0;
        if (type==ENT_gongying) {
            
            type2=ENT_Supply;
        } else if (type==ENT_qiugou){
            type2=ENT_Buy;
        }
        [_headView setData:collmodel.supplyBuyInfo.userChildrenInfo type:type2];
        
    }
    
    [_listView setData:collmodel.supplyBuyInfo type:type];
    
    [_commentView setData:collmodel.supplyBuyInfo];
    
    CGRect rect=_listView.frame;
    rect.size.height=[collmodel.supplyBuyInfo.bodyHeigh floatValue];
    _listView.frame=rect;
    
    [_cancelView setData:collmodel.collectionTime];
    rect=_cancelView.frame;
    rect.origin.y=_listView.bottom+17;
    _cancelView.frame=rect;

    
}

@end
