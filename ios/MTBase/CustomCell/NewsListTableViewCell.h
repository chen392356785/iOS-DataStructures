//
//  NewsCell.h
//  MiaoTuProject
//
//  Created by XBL on 16/5/4.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTTableViewCell.h"
@class NewsListModel;
@interface NewsListTableViewCell : MTTableViewCell

@end
//NewsCell
@interface NewsCell1 : NewsListTableViewCell
{
    UIAsyncImageView * _photo;
    SMLabel * _tittle;
    SMLabel * _source;
    UIButton * _seeNum;
    UIButton *_commentNum;
    SMLabel * _time;
    UIImageView *_imageView;
     UIView *_lineView;
    SMLabel *_lbl;
}
- (void)setData:(NewsListModel *)model;
@end

@interface NewsCell2 : NewsListTableViewCell
{
    UIAsyncImageView * _photo;
    SMLabel * _tittle;
    SMLabel * _source;
    UIButton * _seeNum;
    SMLabel * _time;
    UIAsyncImageView * _photo1;
    UIAsyncImageView * _photo2;
     UIImageView *_imageView;
     UIView *_lineView;
     SMLabel *_lbl;
}
- (void)setData:(NewsListModel *)model;
@end


@interface NewsCell3 : NewsListTableViewCell
{
    UIAsyncImageView * _photo;
    SMLabel * _tittle;
    SMLabel * _source;
    UIButton * _seeNum;
    SMLabel * _time;
      UIImageView *_imageView;
     UIView *_lineView;
     SMLabel *_lbl;
}
- (void)setData:(NewsListModel *)model;

@end


@interface NewsCell4 : NewsListTableViewCell
{
   
    SMLabel * _tittle;
    SMLabel * _source;
    UIButton * _seeNum;
    UIButton *_commentNum;
    SMLabel * _time;
      UIImageView *_imageView;
     UIView *_lineView;
     SMLabel *_lbl;
}
- (void)setData:(NewsListModel *)model;

@end

@interface NewsCell5 : NewsListTableViewCell
{
    
    SMLabel * _tittle;
    SMLabel * _source;
    UIButton * _seeNum;
    UIButton *_commentNum;
    SMLabel * _time;
    UIAsyncImageView * _photo;
      UIImageView *_imageView;
    UIView *_lineView;
    UIImageView *_playImgView;
     SMLabel *_lbl;
}
- (void)setData:(NewsListModel *)model;

@end








