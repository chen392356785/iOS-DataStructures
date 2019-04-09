//
//  EditPersonInformationViewController.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/3/24.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"
#import "EditInformationDelegate.h"
#import "BindenterpriseViewController.h"
@interface EditPersonInformationViewController : SMBaseCustomViewController<EditInformationDelegate,BindCompanygetID>
@property(nonatomic)PersonInformationType type;
@end
