//
//  AddWorkExpViewController.h
//  MiaoTuProject
//
//  Created by Zmh on 19/9/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"

@protocol AddExprienceDelegate <NSObject>

- (void)disPalyAddExprience:(NSString *)type;

@end

@interface AddWorkExpViewController : SMBaseCustomViewController

@property (nonatomic,copy) NSString *titleStr;
@property (nonatomic,strong) id<AddExprienceDelegate>delegate;
@property (nonatomic,strong) NSDictionary *infoDic;
@end
