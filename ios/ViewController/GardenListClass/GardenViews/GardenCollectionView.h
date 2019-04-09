//
//  GardenCollectionView.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/12/22.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GardenModel.h"
typedef void (^DidSelectgardenListsModelBlock) (gardenListsModel *model);

typedef void (^DidSelectgardenOfflineModelBlock) (ActivitiesModel *model);   //园榜线下活动

@interface GardenCollectionView : UICollectionView

@property (nonatomic, copy)NSString *bgMoreImg;     //更多背景图

@property (nonatomic, copy) NSString *type;     //1 横向滚动榜单 2 园榜线下活动
@property (nonatomic ,copy) DidSelectBtnBlock seleckBack;

@property (nonatomic ,copy) DidSelectBlock seleckMoreBack;


@property (nonatomic ,copy) DidSelectgardenListsModelBlock cellSelkBack;
@property (nonatomic ,copy) DidSelectgardenOfflineModelBlock ActivitySelkBack;
- (void) updataCollection:(NSArray *) arr;

- (void) updataActionCollection:(NSArray *) arr;
@end
