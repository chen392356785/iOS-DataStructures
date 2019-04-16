//
//  SDTimeLineCellModel.h
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

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class SDTimeLineCellLikeItemModel, SDTimeLineCellCommentItemModel;

@protocol SDTimeLineCellLikeItemModel
@end
@protocol SDTimeLineCellCommentItemModel
@end

@interface SDTimeLineCellModel : NSObject

@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *msgContent;
@property (nonatomic, strong) NSArray *picNamesArray;

@property (nonatomic, assign, getter = isLiked) BOOL liked;

@property (nonatomic, strong) NSArray<SDTimeLineCellLikeItemModel *> *likeItemsArray;
@property (nonatomic, strong) NSArray<SDTimeLineCellCommentItemModel *> *commentItemsArray;

@property (nonatomic, assign) BOOL isOpening;

@property (nonatomic, assign, readonly) BOOL shouldShowMoreButton;


@end



@interface MTNewSupplyAndBuyListModel : JSONModel

///spec
@property (nonatomic,copy) NSString <Optional> *spec;
@property(nonatomic,strong,nullable)UserChildrenInfo <Optional>*userInfo;
@property (nonatomic ,strong,nullable) NSString<Optional> *position;

@property (nonatomic ,strong,nullable) NSString<Optional> *isVip;

@property (nonatomic ,strong,nullable) NSString<Optional> *crown_width_e;//冠幅

@property (nonatomic ,strong,nullable) NSString<Optional> *heed_image_url;

@property (nonatomic ,strong,nullable) NSString<Optional> *user_id;

@property (nonatomic ,strong,nullable) NSString<Optional> *nickname;

@property (nonatomic ,strong,nullable) NSString<Optional> *company_name;

@property (nonatomic ,strong,nullable) NSString<Optional> *company_province;

@property (nonatomic ,strong,nullable) NSString<Optional> *varieties;//品种名

@property (nonatomic ,strong,nullable) NSString<Optional> *height_s;//高度  、、开始

@property (nonatomic ,strong,nullable) NSString<Optional> *rod_diameter;//杆径

@property (nonatomic ,strong,nullable) NSString<Optional> *type;// 1供求   2求购

@property (nonatomic ,strong,nullable) NSString<Optional> *news_id;

@property (nonatomic ,strong,nullable) NSString<Optional> *number;

@property (nonatomic ,strong,nullable) NSString<Optional> *height_e;//高度  、、结束

@property (nonatomic ,strong,nullable) NSMutableArray<SDTimeLineCellLikeItemModel> *clickUserInfos;

@property (nonatomic ,strong,nullable) NSString<Optional> *unit_price;//单价

@property (nonatomic ,strong,nullable) NSString<Optional> *crown_width_s;

@property (nonatomic ,strong,nullable) NSString<Optional> *selling_point;//描述

@property (nonatomic ,strong,nullable) NSString<Optional> *urls;

@property (nonatomic ,strong,nullable) NSArray<SDTimeLineCellCommentItemModel> *commentInfos;

@property (nonatomic ,strong,nullable) NSString<Optional> *branch_point;//分枝点

@property (nonatomic ,strong,nullable) NSString<Optional> *uploadtime;

@property(nonatomic,strong,nullable)NSArray <Optional>*imgArray; // 数组图片

@property (nonatomic, strong,nullable) NSNumber <Optional>*  clickStatus;

@property (nonatomic, strong,nullable) NSNumber <Optional>* hasCollection;



@end



@interface SDTimeLineCellLikeItemModel : JSONModel

@property (nonatomic, strong,nullable) NSString<Optional>  *nickname;
@property (nonatomic, strong,nullable) NSString<Optional>  *user_id;

@property (nonatomic, strong,nullable) NSAttributedString<Optional>  *attributedContent;

@end


@interface SDTimeLineCellCommentItemModel : JSONModel

@property (nonatomic, strong,nullable) NSString *comment_cotent;

@property (nonatomic, strong,nullable) NSString<Optional> *nickname;
@property (nonatomic, strong,nullable) NSString<Optional> *comment_id;
@property(nonatomic,  strong,nullable)    NSString<Optional> *user_id;
@property (nonatomic, strong,nullable) NSString<Optional> *reply_nickname;
@property (nonatomic, strong,nullable) NSString<Optional> *reply_user_id;
@property (nonatomic, strong,nullable)  NSString<Optional> *comment_type;  //0主动回复 1 回复别人
@property (nonatomic, strong,nullable) NSAttributedString<Optional> *attributedContent;
-(id)initWith:(CommentListModel *)model;
@end

NS_ASSUME_NONNULL_END

