//
//  AddAddressViewController.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/4/2.
//  Copyright © 2019 听花科技. All rights reserved.
//

#import "SMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddAddressCell : UITableViewCell

@end

@interface AddAddressViewController : SMBaseViewController

@property (nonatomic, copy) DidSelectBlock updataBlock;

@end

NS_ASSUME_NONNULL_END
