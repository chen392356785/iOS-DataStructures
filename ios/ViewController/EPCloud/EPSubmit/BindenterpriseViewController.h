//
//  BindenterpriseViewController.h
//  MiaoTuProject
//
//  Created by Zmh on 15/7/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"

@protocol BindCompanygetID <NSObject>

@optional
- (void)disPalyBindCompany:(BindCompanyModel *)model;

@end

@interface BindenterpriseViewController : SMBaseViewController

@property (nonatomic,weak) id<BindCompanygetID> delegate;
@property(nonatomic,copy) DidSelectBtnBlock selectBtnBlock;

@end
