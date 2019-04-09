//
//  SelectAddressViewController.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/4/1.
//  Copyright © 2019 听花科技. All rights reserved.
//

#import "SMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@interface SelectAddressCell : UITableViewCell

@end


@interface SelectAddressViewController : SMBaseViewController

@property (nonatomic, copy) DidSelectSurnBlock changeBlock;

@end

NS_ASSUME_NONNULL_END
