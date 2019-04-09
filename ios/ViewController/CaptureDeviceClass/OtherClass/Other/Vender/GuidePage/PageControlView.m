//
//  PageControlView.m
//  CCPageControl
//
//  Copyright © 2017年 cccc. All rights reserved.
//

#import "PageControlView.h"
#import "PageControlCollectionViewCell.h"

#define kAfterDelayTime 0.3 //最后按钮显示的延迟时间
static NSString *reuseIdentifier = @"PageControlCollectionViewCell";
@interface PageControlView()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UIScrollViewDelegate
>
/***/
@property (nonatomic,weak) UICollectionView *mCollectionView;
///**立即体验按钮*/
//@property (nonatomic,weak) UIButton *experienceBtn;
/**图片数组*/
@property (strong , nonatomic) NSArray *imageArr;

@end

@implementation PageControlView


- (instancetype)initWithFrame:(CGRect)frame andImageList:(NSArray *)arr{
    
    self = [super initWithFrame:frame];
    if (self) {
        // 设置默认值
        self.frame = frame;
        self.backgroundColor = [UIColor brownColor];
        
        self.imageArr = arr;
                
        [self setViews];
        
    }
    return self;
}
#pragma init
- (void)setViews
{
    UICollectionViewFlowLayout *myFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    myFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    myFlowLayout.itemSize = self.frame.size;
    myFlowLayout.minimumLineSpacing = 0;
    myFlowLayout.minimumInteritemSpacing = 0;
    UICollectionView *mCollectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:myFlowLayout];
    self.mCollectionView = mCollectionView;
    mCollectionView.delegate = self;
    mCollectionView.dataSource = self;
    mCollectionView.pagingEnabled = YES;
    mCollectionView.showsHorizontalScrollIndicator = NO;
    mCollectionView.bounces = NO;
    mCollectionView.showsVerticalScrollIndicator = NO;
    mCollectionView.showsHorizontalScrollIndicator = NO;
    [mCollectionView registerClass:[PageControlCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self addSubview:mCollectionView];
    
}


#pragma mark --按钮点击处理--
-(void)removeViewBtn:(UIButton *)sender
{
    [self removeFromSuperview];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(pageControlViewFinished)]) {
        
        [self.delegate pageControlViewFinished];
    }
}

#pragma mark - UICollectionView
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.imageArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PageControlCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.imageStr = self.imageArr[indexPath.item];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.frame.size.width, collectionView.frame.size.height);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    if (self.imageArr.count > 0) {
        
        if (indexPath.item == self.imageArr.count - 1) {
            
            [self removeFromSuperview];
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(pageControlViewFinished)]) {
                
                [self.delegate pageControlViewFinished];
            }
        }
    }

}

//#pragma mark - UIScrollView
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
//{
//    if ((scrollView.contentOffset.x/self.frame.size.width) == self.imageArr.count - 1){
//        
//        
//        self.experienceBtn.hidden = NO;
//    }
//    else
//    {
//        self.experienceBtn.hidden=YES;
//    }
//}

@end
