//
//  MTHomeSectionTitleView.h
//  MiaoTuProject
//
//  Created by 苏浩楠 on 2017/6/19.
//  Copyright © 2017年 xubin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTHomeSectionTitleView : UIView

/**数据*/
@property (nonatomic,strong) NSDictionary *dataDic;

@property (nonatomic,copy) DidSelectBlock HomeMoreBlock;

@end
