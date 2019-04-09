//
//  PageControlView.h
//  CCPageControl
//
//  Copyright © 2017年 cccc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PageControlViewDelegate <NSObject>

- (void)pageControlViewFinished;

@end

@interface PageControlView : UIView

//+(PageControlView *)instance;

- (instancetype)initWithFrame:(CGRect)frame andImageList:(NSArray *)arr;

//@property (strong, nonatomic) IBOutlet UICollectionView *collectionV;
//
//@property (strong, nonatomic) IBOutlet UIButton *btn;

/**代理*/
@property (nonatomic,assign) id<PageControlViewDelegate>delegate;

@end
