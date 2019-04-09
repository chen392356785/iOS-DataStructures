//
//  MTActionCollectionViewCell.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/6/22.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTActionCollectionViewCell : UICollectionViewCell

@end

//活动价格说明
@interface MTActionContionTitleCell : UICollectionViewCell
-  (void) setTitle:(NSString *)title andPic:(NSString *)picStr;
@end

//活动人数说明
@interface MTActionSignUpPersonCell : UICollectionViewCell
- (void) setLimitTitle:(NSString *)limtTitle andNumber:(NSString *) numStr;
@end

//活动详情描述
@interface MTActionDetailDescribeCell :UICollectionViewCell

- (void) setConternImag:(NSString *)imageStr;
@end
