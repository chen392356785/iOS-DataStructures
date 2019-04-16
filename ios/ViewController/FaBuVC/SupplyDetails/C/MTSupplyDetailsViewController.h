//
//  MTSupplyDetailsViewController.h
//  MiaoTuProject
//
//  Created by dzb on 2019/4/11.
//  Copyright © 2019 听花科技. All rights reserved.
//

#import "SMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

/**
 供应详情控制器
 */
@interface MTSupplyDetailsViewController : SMBaseViewController

@property(nonatomic,strong) NSString *newsId;
@property(nonatomic,strong) NSString *userId;

///commentTotal
@property (nonatomic,copy) NSString *commentTotal;
///hasClickLike
@property (nonatomic,copy) NSString *hasClickLike;
///hasCollection
@property (nonatomic,copy) NSString *hasCollection;

@end

NS_ASSUME_NONNULL_END
