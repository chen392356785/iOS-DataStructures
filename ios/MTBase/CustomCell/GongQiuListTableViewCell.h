//
//  GongQiuListTableViewCell.h
//  MiaoTuProject
//
//  Created by Mac on 16/4/14.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTTableViewCell.h"


@class CommentView;
@class MTSupplyAndBuyListModel;
@class MyCollectionSupplyAndBuyModel;
@class CancelView;
@interface GongQiuListTableViewCell : MTTableViewCell
{
    HeaderView *_headView;
    BuyListView *_listView;
    CommentView *_commentView;
//    PersonType _psersonType;
    CancelView* _cancelView;
}
@property(nonatomic,strong)MTSupplyAndBuyListModel *model;
@property(nonatomic,strong)MyCollectionSupplyAndBuyModel *collmodel;  //收藏模型
@property(nonatomic)CollecgtionType type2;

//-(void)setData:(CollecgtionType)type isHomePage:(BOOL)isHomePage Model:(MTSupplyAndBuyListModel *)Model;
-(void)setData:(CollecgtionType)type isHomePage:(BOOL)isHomePage; //是否是主页，主页不带头部
-(void)setCollectionData:(CollecgtionType)type;  //给收藏模型放数据
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(CollecgtionType)type isCollection:(BOOL)isCollection isMe:(BOOL)isMe;

@end
