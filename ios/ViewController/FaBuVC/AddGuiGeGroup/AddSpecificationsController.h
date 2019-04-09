//
//  AddSpecificationsController.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/4/1.
//  Copyright © 2019 听花科技. All rights reserved.
//

#import "SMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^DidSelectspecificaBlock)(NSString *guigeiStr,NSString *moneyStr,NSString *jsonStr);

@interface AddSpecifitionCell : UITableViewCell

@end


@interface AddSpecificationsController : SMBaseViewController

@property (nonatomic, copy) DidSelectspecificaBlock SpacifiBlock;

@end

NS_ASSUME_NONNULL_END
