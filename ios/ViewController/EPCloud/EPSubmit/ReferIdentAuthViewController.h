//
//  ReferIdentAuthViewController.h
//  MiaoTuProject
//
//  Created by Zmh on 30/8/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"

@interface ReferIdentAuthViewController : SMBaseCustomViewController
@property (nonatomic,strong)UIImage *image;
@property (nonatomic,copy)NSString *typeText;
@property (nonatomic,copy)NSString *auth_id;
//@property (nonatomic,copy)NSString *type;//判断是从我的进入还是园林云进入
@end
