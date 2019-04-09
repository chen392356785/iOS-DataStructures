//
//  GongQiuTableListViewController.h
//  MiaoTuProject
//
//  Created by Mac on 16/3/15.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"
#import "GongQiuAgreeDelegate.h"
#import "GongQiuCommentDelegate.h"
@interface GongQiuTableListViewController : SMBaseViewController<GongQiuAgreeDelegate,GongQiuCommentDelegate>{
    NSIndexPath *_selIndexPath;
}

@property(nonatomic) buyType type;
@property(nonatomic,strong) NSString *city;
//-(void)addSupplyAndBuy:(MTSupplyAndBuyListModel *)mod;

@end
