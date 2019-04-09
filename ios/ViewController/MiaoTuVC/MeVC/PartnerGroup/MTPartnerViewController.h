//
//  MTPartnerViewController.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/1/22.
//  Copyright © 2019年 听花科技. All rights reserved.
//

#import "SMBaseViewController.h"
typedef void (^inPutblock)(NSString *inputResult);

@interface MTPartnerViewController : SMBaseViewController

@property (nonatomic, strong) CNPPopupController *popupViewController;//弹出试图

@end

@interface PartnerViewCell : UITableViewCell

@property (nonatomic, copy) inPutblock inputBlock;
@property (nonatomic, strong) IHTextField *textField;

@end
