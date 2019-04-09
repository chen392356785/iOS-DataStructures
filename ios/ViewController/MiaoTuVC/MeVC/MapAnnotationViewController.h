//
//  MapAnnotationViewController.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/3/28.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"
#import "EditInformationDelegate.h"
@protocol MapAnnotationDelegate<NSObject>

@optional
-(void)MapAnnotationDelegateSubmit:(int)index;

@end

@interface MapAnnotationViewController : SMBaseCustomViewController<EditInformationDelegate>
@property(nonatomic,weak) id<MapAnnotationDelegate>delegate;
@end
