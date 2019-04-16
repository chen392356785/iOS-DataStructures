//
//  IHTableViewCell.h
//  XFDesigners
//
//  Created by yaoyongping on 12-12-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@class IHTableViewCell;

typedef enum{

    MTHeadViewActionTableViewCell, //点击头像
    MTHeadViewActionTableViewCell2, //点击头像
    MTCommentActionTableViewCell,//点击评论
    MTAgreeActionTableViewCell,//点击点赞
    MTShareActionTableViewCell,//点击分享
    MTFavriteActionTableViewCell,//点击收藏
    MTEditActionTableViewCell,//点击编辑
    MTDeleteActionTableViewCell,//点击删除
    MTPhoneActionTableViewCell,//点击电话
    MTQiangDanActionTableViewCell,//点击抢单
    MTLianXiActionTableViewCell,//联系

    MTAppointActionTableViewCell,//点击预约
    MTcancelAgreeActionTableViewCell,//点击取消点赞
    MTcancelShareActionTableViewCell,//点击取消分享
    MTcancelFavriteActionTableViewCell,//点击取消收藏
    MTcancelFavriteTopicActionTableViewCell,//点击取消话题收藏
    MTcancelFavriteSupplyActionTableViewCell, //供应取消收藏
    MTcancelFavriteBuyActionTableViewCell, //求购取消收藏

    MTDetailActionTalbeViewCell, //进入详情

    MTActivityBMTableViewCell, //活动报名
    MTActivityBMZFTableViewCell,//报名费支付
    MTActivityBMYZFTableViewCell,//已支付
    MTActivityQXBMTableViewCell,//取消活动
    MTActivityShareActivTableViewCell,
    MTActivityCollectBMTableViewCell,//收藏活动


    MTActivityFollowBMTableViewCell,//关注
    MTActivityUpFollowBMTableViewCell,//取消关注
    MTActionClickUserURlTableViewCellAction,  //点击用户链接
    MTMLLinkPhoneCellAction,//点击用户电话
    MTActionClickUserNameTableViewCellAction, // 点击 用户昵称

    MYActionMiaoMuYunSelectCell, //cell点击

    MYActionHomePageZiXunTableViewAction, //首页资讯点击
    MYActionHomePageZhanlueQiyeTableViewAction, //首页战略企业
    MTActionHomePageXinPinZhongTableViewCellAction, //新品种
    MTActionHomePagePinZhongTableViewCellAciont, //品种点击
    MTActionHomePageQiYeTableViewCellAction, //首页企业点击
    MTActionHomePageRenMaiTableViewCellAction , // 首页 人脉点击
    MYActionSearchZhanlueQiyeTableViewAction, //首页搜索战略企业
    MTActionApplyChatGroupTableViewCell, //申请入群


}BCTableViewCellAction;

@protocol BCBaseTableViewCellDelegate<NSObject>

@optional
-(void)BCtableViewCell:(IHTableViewCell *)cell action:(BCTableViewCellAction)action indexPath:(NSIndexPath *)indexPath attribute:(NSObject *)attribute;

@end


@interface IHTableViewCell : UITableViewCell{
//    NSDictionary *_data;
}

@property(nonatomic)float cellHeight;
@property(nonatomic,strong)NSObject *attribute;
@property(nonatomic,weak) id<BCBaseTableViewCellDelegate>delegate;
@property(nonatomic,strong) NSIndexPath *indexPath;
//@property(nonatomic,assign)int tag;
//-(void)setData:(NSDictionary *)dic;
//-(NSDictionary *)data;

@end


@interface IHMemberCenterCell : IHTableViewCell{
    NSDictionary *_member;

@private
    UILabel *lblTitle;
//    UIImageView *icon;
}

-(void)setMember:(NSDictionary *)dic;

@end
