//
//  OtherUserChildSupplyAndBuyListVC.h
//  MiaoTuProject
//
//  Created by Mac on 16/4/15.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"
#import "ARSegmentControllerDelegate.h"

@interface OtherUserChildSupplyAndBuyListVC : SMBaseViewController<ARSegmentControllerDelegate>
{
    MTSupplyAndBuyListModel *_selModel;
    NSIndexPath *_selIndexPath;
}
@property(nonatomic,assign)buyType type;
@property(nonatomic,strong)NSString *userID;
@property(nonatomic)BOOL isMe;
@property(nonatomic,copy)DidSelectBtnBlock selectBtnBlock;
@end
