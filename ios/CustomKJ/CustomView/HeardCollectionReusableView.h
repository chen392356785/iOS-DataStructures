//
//  HeardCollectionReusableView.h
//  MiaoTuProject
//
//  Created by Zmh on 22/7/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeardCollectionReusableView : UICollectionReusableView
{
    ActivityVoteTopView *topView;
}
@property(nonatomic,copy)DidSelectBtnBlock selectBtnBlock;
- (void)setTopData:(NSString *)title time:(NSString *)time totlNum:(NSString *)totleNum imgUrl:(NSString *)url;
@end
