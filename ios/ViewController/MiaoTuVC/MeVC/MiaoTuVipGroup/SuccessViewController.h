//
//  SuccessViewController.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/12/19.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "SMBaseViewController.h"

@interface SuccessViewController : SMBaseViewController

@property (nonatomic, copy) NSString *titleName;

- (void) setSucceStr:(NSString *)succStr andInfoStr:(NSString *) infoStr;
@end
