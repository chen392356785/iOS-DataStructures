//
//  VotoDetailsViewController.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/7/21.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"

@protocol VoteSuccessDelegate <NSObject>

- (void)VoteSuccessDelagate:(VoteListModel *)model indexPath:(NSIndexPath *)indexPath;

@end

@interface VotoDetailsViewController : SMBaseViewController
{
    SMLabel *_number;
}

@property (nonatomic, strong) CNPPopupController *popupViewController;//弹出试图

@property (nonatomic,strong)VoteListModel *model;
@property (nonatomic,strong)ActivitiesListModel *activModel;
@property (nonatomic,copy)NSString *surplus;
@property(nonatomic,strong)id<VoteSuccessDelegate>delegate;
@property(nonatomic,strong)NSIndexPath *indexPath;

@end
