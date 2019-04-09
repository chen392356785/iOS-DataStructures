//
//  ActivtiesMapViewController.h
//  MiaoTuProject
//
//  Created by Zmh on 12/5/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"
@class MAPointAnnotation;

@interface ActivtiesMapViewController : SMBaseViewController
@property (nonatomic,assign)CLLocationCoordinate2D coordinate;
@property (nonatomic,copy) NSString *name;
@end
