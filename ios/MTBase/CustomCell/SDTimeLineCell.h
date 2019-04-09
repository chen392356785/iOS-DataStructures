//
//  SDTimeLineCell.h
//  GSD_WeiXin(wechat)
//
//  Created by gsd on 16/2/25.
//  Copyright © 2016年 GSD. All rights reserved.
//

/*
 
 *********************************************************************************
 *
 * GSD_WeiXin
 *
 * QQ交流群: 459274049
 * Email : gsdios@126.com
 * GitHub: https://github.com/gsdios/GSD_WeiXin
 * 新浪微博:GSD_iOS
 *
 * 此“高仿微信”用到了很高效方便的自动布局库SDAutoLayout（一行代码搞定自动布局）
 * SDAutoLayout地址：https://github.com/gsdios/SDAutoLayout
 * SDAutoLayout视频教程：http://www.letv.com/ptv/vplay/24038772.html
 * SDAutoLayout用法示例：https://github.com/gsdios/SDAutoLayout/blob/master/README.md
 *
 *********************************************************************************
 
 */

#import <UIKit/UIKit.h>
#import "MLLinkLabel.h"
#import "SDTimeLineCellOperationMenu.h"
@protocol SDTimeLineCellDelegate <NSObject>

- (void)didClickLikeButtonInCell:(UITableViewCell *)cell;
- (void)didClickcCommentButtonInCell:(UITableViewCell *)cell;

@end

@class MTNewSupplyAndBuyListModel,SDTimeLineCellCommentItemModel;

@interface SDTimeLineCell : MTTableViewCell

@property (nonatomic, weak) id<SDTimeLineCellDelegate> Delegate1;

@property(nonatomic,copy)DidSelectheadImageBlock selectheadImageBlock;

@property (nonatomic, strong) MTNewSupplyAndBuyListModel *model;

//@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, copy) void (^moreButtonClickedBlock)(NSIndexPath *indexPath);

@property (nonatomic, copy) void (^didClickCommentLabelBlock)(SDTimeLineCellCommentItemModel *mod, CGRect rectInWindow, NSIndexPath *indexPath ,NSIndexPath *commIndexPath);
@property(nonatomic,strong)  SDTimeLineCellOperationMenu *operationMenu;

@end


@interface SDCommentListCell : MTTableViewCell
{
    MLLinkLabel *_label;
}
@property(nonatomic,strong)UIImageView *huifImageV;
@property(nonatomic,strong)SDTimeLineCellCommentItemModel *model;
 @property (nonatomic,copy) DidSelectUserName didClickUserNameBlock;
@end


@interface SDForJobCell : MTTableViewCell

@end





