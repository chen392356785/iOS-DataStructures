//
//  MeMainCollectionReusableView.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/12/11.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoDataModel.h"

@interface MeMainCollectionReusableView : UICollectionReusableView {
    UILabel *_titleLabel;
    UILabel *linLabel;
}
@property (nonatomic, strong) pointParamsModel *model;
@end
