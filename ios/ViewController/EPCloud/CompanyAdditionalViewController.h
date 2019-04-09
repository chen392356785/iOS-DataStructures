//
//  CompanyAdditionalViewController.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/8/30.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"

@interface CompanyAdditionalViewController : SMBaseCustomViewController
@property (nonatomic,strong)MTCompanyModel *model;
@property(nonatomic,copy)DidSelectBtnBlock selectBlock;
@end
