//
//  NewsCell.h
//  MiaoTuProject
//
//  Created by XBL on 16/5/4.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTTableViewCell.h"

@interface NewsCell : MTTableViewCell

@end

@interface NewsCell1 : NewsCell
@property (nonatomic,strong)UIAsyncImageView * photo;
@property (nonatomic,strong)SMLabel * tittle;
@property (nonatomic,strong)SMLabel * source;
@property (nonatomic,strong)SMLabel * seeNum;
@property (nonatomic,strong)SMLabel * time;
@end

@interface NewsCell2 : NewsCell
@property (nonatomic,strong)UIAsyncImageView * photo;
@property (nonatomic,strong)SMLabel * tittle;
@property (nonatomic,strong)SMLabel * source;
@property (nonatomic,strong)SMLabel * seeNum;
@property (nonatomic,strong)SMLabel * time;
@property (nonatomic,strong)UIAsyncImageView * photo1;
@property (nonatomic,strong)UIAsyncImageView * photo2;
@end


@interface NewsCell3 : NewsCell
@property (nonatomic,strong)UIAsyncImageView * photo;
@property (nonatomic,strong)SMLabel * tittle;
@property (nonatomic,strong)SMLabel * source;
@property (nonatomic,strong)SMLabel * seeNum;
@property (nonatomic,strong)SMLabel * time;
@end