//
//  CrowdFundingViewController.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/8/8.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"
#import "BCBaseResp.h"

typedef void (^PayWithBlocks)(NSString *price, NSString *orderNo, NSString *type, NSString*subject,NSString*crowId, SMBaseViewController *vc);

@protocol CrowdSuccesssDelegate <NSObject>

- (void)crowdSuccessIndexPath:(NSIndexPath *)indexPath;

@end

@interface CrowdFundingViewController : SMBaseViewController
@property (nonatomic,strong)CrowdOrderModel *model;
@property (nonatomic,copy)NSString *crowdID;//众筹id(我的活动跳转用到)
@property (nonatomic,copy)NSString *Type;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,copy)DidSelectBtnBlock selectBtnBlock;
@property (strong, nonatomic) BCBaseResp *orderList;
@property (nonatomic,strong) id<CrowdSuccesssDelegate>delgate;

@property (nonatomic,copy)NSString *payType;
@property (nonatomic, copy) PayWithBlocks payBlock;

@end
