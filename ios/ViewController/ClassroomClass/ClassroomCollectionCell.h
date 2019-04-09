//
//  ClassroomCollectionCell.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/10/11.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassroomModel.h"
#import "SDCycleScrollView.h"
#import "MTHomeSearchView.h"    //搜索

@interface ClassroomCollectionCell : UICollectionViewCell {
    UIImageView *_imageView;
    UILabel *_titleLabel;
    UILabel * _conLabel;
}
- (void) setDataClassListModel:(studyBannerListModel*)model;

@end


typedef void (^DidSelectBackBut) ();
typedef void (^DidSelectSearchVTapBut) ();

@interface ClassroomHeadViewCell : UICollectionViewCell {
    UIImageView *_bgimageView;
    UIImageView *_bgimageView2;
    UIImageView *BgAdview;
    
    UIButton *leftbutton;
    MTHomeSearchView *searchTextfiled;
    
}
@property(nonatomic,strong) SDCycleScrollView *DicView;
@property(nonatomic,copy) DidSelectBackBut backBlock;
@property(nonatomic,copy) DidSelectSearchVTapBut searchBlock;

- (void) setUpSubViewSourde;

@end



@interface ClassroomClassTitleViewCell : UICollectionViewCell {
    UIImageView *_imageView;
    UILabel *_titleLabel;
}
- (void) setImageName:(NSString *)imagStr andTitleStr:(NSString *)title;
@end
