//
//  CuttomSelectPicHead.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/3/29.
//  Copyright © 2019 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CuttomSelectPicCell : UICollectionViewCell
{
//    UIImageView *imgView;
//    UIButton *_btn;
}

@property(nonatomic,strong) UIButton *deleteBtn;
@property(nonatomic,strong) UIAsyncImageView *m_imgView;

@end



typedef void (^PicSelectItemBlock) (NSMutableArray * ImagArr);

@protocol SelectPicDelegate <NSObject>

@optional
- (void) showActionSheetPicSelectBlock:(PicSelectItemBlock)block;
- (void) remoePicSelectUpDataUIFrame:(CGRect )frame andImageArr:(NSMutableArray *)imgarray;

@end

@interface CuttomSelectPicHead : UIView

@property (nonatomic,weak) id <SelectPicDelegate> delegage;

@end


