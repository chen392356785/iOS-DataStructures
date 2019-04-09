//
//  MiaoTuMainViewController.h
//  MiaoTuProject
//
//  Created by Mac on 16/3/9.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"
//#import "CityChooseDelegate.h"
#import "MTLoginViewController.h"

@class MAPointAnnotation;


@interface MiaoTuMainViewController : SMBaseViewController<UITableViewDelegate,UIScrollViewDelegate>
{
    MTBaseTableView *_commTableView;
    UIScrollView *_scroll;
}

@property(nonatomic,strong)NSString *company_name;
@property(nonatomic,strong)NSString *city;
@property(nonatomic,strong)NSString *province;
@property(nonatomic,strong)NSArray *typeArray;

@end
