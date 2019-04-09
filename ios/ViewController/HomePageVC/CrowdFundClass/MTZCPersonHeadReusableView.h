//
//  MTZCPersonHeadReusableView.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/6/24.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CrowdfundCountBlock)();
typedef void(^SupportCountBlock)();

@interface MTZCPersonHeadReusableView : UICollectionReusableView
@property (nonatomic, copy)CrowdfundCountBlock CrowdfundAction;
@property (nonatomic, copy)SupportCountBlock   SupportAction;


- (void) setCrowdFundCount:(NSString *)CowdFundCont andSupportCount:(NSString *)supportCount;
@end


typedef void(^showDetailBlock)(BOOL isShow);
@interface MTZCDetailReusableView : UICollectionReusableView

@property (nonatomic, copy)showDetailBlock isShowDetailblock;

- (void) setisShowDetail:(BOOL) isShow;
@end
