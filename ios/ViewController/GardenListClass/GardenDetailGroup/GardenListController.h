//
//  GardenListController.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/11/20.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "SMBaseViewController.h"
#import "GardenModel.h"


@interface GardenListHeadView : UIView
@property (nonatomic, copy) DidSelectBtnBlock CallPhoneItemBlock;  //呼叫
@property (nonatomic, copy) DidSelectBtnBlock SkrItemBlock;        //点赞
@property (nonatomic, copy) DidSelectBtnBlock messagItemBlock;     //回复
@property (nonatomic, copy) DidSelectBtnBlock bgViewItemBlock;     //cellItem
- (void) upSubviewData:(NSArray *)arr;
@end




@interface GardenListController : SMBaseViewController

@property (nonatomic, strong) gardenListsModel *model;      //榜单

@property (nonatomic, strong) CNPPopupController *popupViewController;//弹出试图

@end
