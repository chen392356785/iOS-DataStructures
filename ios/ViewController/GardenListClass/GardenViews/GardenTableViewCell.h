//
//  GardenTableViewCell.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/12/22.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GardenCollectionView.h"

#import "GardenModel.h"


@interface GardenTableViewCell : UITableViewCell

@end

//横向滚动榜单
@interface GardenScrlistViewCell : UITableViewCell

@property (nonatomic, copy)NSString *bgMoreImg;

@property (nonatomic, copy) DidSelectTopViewBlock moreBlock;
@property (nonatomic ,copy) DidSelectgardenListsModelBlock cellSelkBack;

@property (nonatomic, copy) DidSelectTopViewBlock isShowBlock;      //1 为显示单排  2 为显示双排

- (void) updataSlideSegmentArray:(NSMutableArray *)arr;

//- (void) updatacollectionContentoffX:(NSInteger )tag;       //榜单分类滚动到指定分区
@end


//线下活动
@interface GardenOfflineTabCell : UITableViewCell
@property (nonatomic ,copy) DidSelectgardenOfflineModelBlock ActivitySelkBack;
- (void) updataSlideSegmentArray:(NSMutableArray *)arr;
@end



//园榜红人故事
@interface GardenRedsStoryTabCell : UITableViewCell {
    UIView *bgView;
    UIAsyncImageView *leftImg;
    UILabel *titleLab;
    SMLabel *conLab;
    UILabel *timeLab;
}
@property(nonatomic, strong)informationsModel *model;
@end





//轮播 向上滚动轮播
@interface GardenMarqueeTabCell : UITableViewCell {
}

@property (nonatomic, strong) NSTimer *timer; //定时器
@property (nonatomic, copy) DidSelectBtnBlock marqueSelectBlock;
- (void) updataTableDataArray:(NSMutableArray *)arr;
@end

//轮播滚动cell
@interface MarqueeTabCell : UITableViewCell {
}

@end
