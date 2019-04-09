//
//  NewsCell.m
//  MiaoTuProject
//
//  Created by XBL on 16/5/4.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "NewsCell.h"

@implementation NewsCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

@implementation NewsCell1
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _photo=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(15, 10, 111, 80)];
        _photo.backgroundColor=[UIColor orangeColor];
        [self.contentView addSubview:_photo];
        
        _tittle=[[SMLabel alloc]initWithFrameWith:CGRectMake(136, 15, WindowWith-151, 40) textColor:RGB(108, 123, 138) textFont:[UIFont systemFontOfSize:15]];
        _tittle.numberOfLines=2;
        _tittle.text=@"首届植物极客朝圣之旅报名进行中";
        [self.contentView addSubview:_tittle];
        
        _source=[[SMLabel alloc]initWithFrameWith:CGRectMake(136, 70, 70,15) textColor:RGB(194, 206, 222) textFont:[UIFont systemFontOfSize:12]];
        _source.textAlignment=NSTextAlignmentLeft;
        _source.text=@"网易新闻";
        [self.contentView addSubview:_source];
        
        
        UIImageView * seeImage=[[UIImageView alloc]initWithFrame:CGRectMake(WindowWith-135, 72, 15, 10)];
        seeImage.image=[UIImage imageNamed:@"HomePage_see"];
        [self.contentView addSubview:seeImage];
        
        _seeNum=[[SMLabel alloc]initWithFrameWith:CGRectMake(WindowWith-115, 71, 40, 13) textColor:RGB(194, 206, 222) textFont:[UIFont systemFontOfSize:12]];
        _seeNum.text=@"10000";
        
        [self.contentView addSubview:_seeNum];
        
        _time=[[SMLabel alloc]initWithFrameWith:CGRectMake(WindowWith-70, 71, 55, 15) textColor:RGB(194, 206, 222) textFont:[UIFont systemFontOfSize:12]];
        _time.text=@"10分钟前";
        [self.contentView addSubview:_time];
        
        
        
    }
    return self;
    
}


@end




@implementation NewsCell2

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        _tittle=[[SMLabel alloc]initWithFrameWith:CGRectMake(15, 10, 225, 16) textColor:RGB(108, 123, 138) textFont:[UIFont systemFontOfSize:15]];
        
        _tittle.text=@"首届植物极客朝圣之旅报名进行中";
        [self.contentView addSubview:_tittle];
        
        
        UIImageView * seeImage=[[UIImageView alloc]initWithFrame:CGRectMake(WindowWith-75, 13, 15, 10)];
        seeImage.image=Image(@"HomePage_see.png");
        [self.contentView addSubview:seeImage];
        
        _seeNum=[[SMLabel alloc]initWithFrameWith:CGRectMake(WindowWith-55, 12, 40, 12) textColor:RGB(194, 206, 222) textFont:[UIFont systemFontOfSize:12]];
        _seeNum.text=@"10000";
        
        [self.contentView addSubview:_seeNum];
        
        
        
        
        _photo=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(15, 36, (WindowWith-50)/3.0, 75)];
        _photo.backgroundColor=[UIColor orangeColor];
        [self.contentView addSubview:_photo];
        
        
        _photo1=[[UIAsyncImageView alloc]initWithFrame:CGRectMake((WindowWith-50)/3.0+25, 36, (WindowWith-50)/3.0, 75)];
        _photo1.backgroundColor=[UIColor orangeColor];
        [self.contentView addSubview:_photo1];
        
        
        _photo2=[[UIAsyncImageView alloc]initWithFrame:CGRectMake((WindowWith-50)*2/3.0+35, 36, (WindowWith-50)/3.0, 75)];
        _photo2.backgroundColor=[UIColor orangeColor];
        [self.contentView addSubview:_photo2];
        
        
        
        
        _source=[[SMLabel alloc]initWithFrameWith:CGRectMake(15, 121, 70,12) textColor:RGB(194, 206, 222) textFont:[UIFont systemFontOfSize:12]];
      
        _source.text=@"网易新闻";
        [self.contentView addSubview:_source];
        
        
        
        
        
        _time=[[SMLabel alloc]initWithFrameWith:CGRectMake(WindowWith-75, 121, 55, 13) textColor:RGB(194, 206, 222) textFont:sysFont(12)];
        _time.text=@"10分钟前";
        [self.contentView addSubview:_time];
        
        
    }
    return self;
}

@end



@implementation NewsCell3

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
   self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _tittle=[[SMLabel alloc]initWithFrameWith:CGRectMake(15, 10, 225, 16) textColor:RGB(108, 123, 138) textFont:[UIFont systemFontOfSize:15]];
        
        _tittle.text=@"首届植物极客朝圣之旅报名进行中";
        [self.contentView addSubview:_tittle];
        
        
        UIImageView * seeImage=[[UIImageView alloc]initWithFrame:CGRectMake(WindowWith-75, 13, 15, 10)];
        seeImage.image=[UIImage imageNamed:@"HomePage_see"];
        [self.contentView addSubview:seeImage];
        
        _seeNum=[[SMLabel alloc]initWithFrameWith:CGRectMake(WindowWith-55, 12, 40, 12) textColor:RGB(194, 206, 222) textFont:[UIFont systemFontOfSize:12]];
        _seeNum.text=@"10000";
        
        [self.contentView addSubview:_seeNum];
        
        
        
        _photo=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(15, 36, WindowWith-30, 100)];
        _photo.backgroundColor=[UIColor orangeColor];
        [self.contentView addSubview:_photo];
        
        
        
        
        
        
        _source=[[SMLabel alloc]initWithFrameWith:CGRectMake(15, 146, WindowWith-30,32) textColor:RGB(160, 160, 160) textFont:[UIFont systemFontOfSize:13]];
        //_source.textAlignment=NSTextAlignmentLeft;
        _source.text=@"2014年8月16日-8月21日中苗会-论坛云贵2014园林企业家峰会在云南、贵州成功举办，掀起园林行业新思潮,羊圈科技，羊圈科技，羊圈科技";
        _source.numberOfLines=2;
        [self.contentView addSubview:_source];
        
        
        
        
        
        _time=[[SMLabel alloc]initWithFrameWith:CGRectMake(WindowWith-70, 186, 55, 12) textColor:RGB(194, 206, 222) textFont:[UIFont systemFontOfSize:12]];
        _time.text=@"10分钟前";
        [self.contentView addSubview:_time];
        
        
        
    }
    return self;
}

@end




