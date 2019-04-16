//
//  NewsCell.m
//  MiaoTuProject
//
//  Created by XBL on 16/5/4.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "NewsListTableViewCell.h"

@implementation NewsListTableViewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
//一张小图
@implementation NewsCell1
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIAsyncImageView * photo=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(12, 13, WindowWith*0.25, WindowWith*0.186)];
       // photo.backgroundColor=[UIColor orangeColor];
        _photo=photo;
        [self.contentView addSubview:photo];
        
        SMLabel * tittle=[[SMLabel alloc]initWithFrameWith:CGRectMake(12+photo.right, photo.top+3, WindowWith-151, 40) textColor:RGB(44, 44, 46) textFont:sysFont(15)];
        tittle.numberOfLines=2;
        tittle.text=@"首届植物极客朝圣之旅报名进行中";
    
        _tittle=tittle;
        [self.contentView addSubview:tittle];
        
        SMLabel * source=[[SMLabel alloc]initWithFrameWith:CGRectMake(tittle.left, _photo.bottom-12, 70,12) textColor:cGrayLightColor textFont:sysFont(12)];
        source.textAlignment=NSTextAlignmentLeft;
        source.text=@"网易新闻";
        _source=source;
        [self.contentView addSubview:source];
        
        

        
        UIButton * seeNum=[UIButton buttonWithType:UIButtonTypeCustom];
        seeNum.frame=CGRectMake(WindowWith-115, WindowWith*0.21-7, 40, 12);
        [seeNum setTitle:@"10000" forState:UIControlStateNormal];
        [seeNum setTitleColor:cGrayLightColor forState:UIControlStateNormal];
        [seeNum setImage:Image(@"see.png") forState:UIControlStateNormal];
        seeNum.titleLabel.font=sysFont(12);
        [seeNum setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        _seeNum=seeNum;
        
        [self.contentView addSubview:seeNum];
        
        
      
        
        SMLabel * time=[[SMLabel alloc]initWithFrameWith:CGRectMake(seeNum.right+10, seeNum.top, 55, 13) textColor:cGrayLightColor textFont:sysFont(12)];
        time.text=@"10分钟前";
        time.textAlignment=NSTextAlignmentRight;
        _time=time;
        [self.contentView addSubview:time];
        
      
        
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(_photo.right+12, _photo.top+5, 30, 14) textColor:cBlackColor textFont:sysFont(13)];
        _lbl=lbl;
        lbl.hidden=YES;
        lbl.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:lbl];
        
        UIView * line=[[UIView alloc]initWithFrame:CGRectMake(0,  0, WindowWith, 1)];
        line.backgroundColor=cLineColor;
        [self.contentView addSubview:line];
        
        
    }
    return self;
    
}

- (void)setData:(NewsListModel *)model
{
    if (![model.label_color isEqualToString:@""]&&![model.label_name isEqualToString:@""]) {
        _lbl.hidden=NO;
        _lbl.backgroundColor=[IHUtility colorWithRGBString:model.label_color alph:0.2];
        _lbl.alpha=0.5;
        _lbl.textColor=[IHUtility colorWithRGBString:model.label_color alph:1];
    }else{
        _lbl.hidden=YES;
        _lbl.alpha=0;
    }
  

    _lbl.text=model.label_name;
       NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"       %@",model.info_title]];
    if ([model.label_name isEqualToString:@""]) {
        attrString=[[NSMutableAttributedString alloc] initWithString:model.info_title];
    }
    
    
    [attrString addAttribute:NSFontAttributeName value: sysFont(15) range:NSMakeRange(0,attrString.length)];
    
   
    
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:4];//调整行间距
    [attrString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attrString length])];
    [attrString addAttribute:NSForegroundColorAttributeName value:RGB(44, 44, 46) range:NSMakeRange(0,attrString.length)];
    _tittle.attributedText=attrString;

    //CGSize size=[IHUtility GetSizeByText:model.info_title boldOfFont:15 width:WindowWith-_photo.right-24];
    
    CGSize size=[_tittle sizeThatFits:CGSizeMake(WindowWith-_photo.right-24, CGFLOAT_MAX)];
    
    _tittle.frame=CGRectMake(12+_photo.right, _photo.top, size.width, size.height);
   
    
   
    _source.text=model.info_from;
    
    
    CGSize size1=[IHUtility GetSizeByText:[IHUtility FormatMonthAndDayByString:model.uploadtime] sizeOfFont:12 width:WindowWith-_seeNum.right+10];
    _source.frame=CGRectMake(25+WindowWith*0.25, WindowWith*0.21-7, WindowWith-12-_seeNum.left,12);
    
    _time.text=[IHUtility FormatMonthAndDayByString:model.uploadtime];
    _time.frame=CGRectMake(WindowWith-12-size1.width, _source.top, size1.width, 12);
    
    
    CGSize size2=[IHUtility GetSizeByText:[NSString stringWithFormat:@"%d",model.view_Total] sizeOfFont:12 width:40];
   UIImage * img=Image(@"see.png");

    [_seeNum setTitle:[NSString stringWithFormat:@"%d",model.view_Total]  forState:UIControlStateNormal];
    _seeNum.frame=CGRectMake(_time.left-12-(img.size.width+5+size2.width), _time.top, img.size.width+5+size2.width, img.size.height);
    
    
    
   

    
 
    
    
  
    
    MTPhotosModel * photo=model.imgArray[0];
    NSLog(@"====  %@",photo.imgUrl);
   [_photo setImageAsyncWithURL:photo.imgUrl placeholderImage:DefaultImage_logo];
    
    
    
}

@end



//三张图
@implementation NewsCell2

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
         SMLabel * tittle=[[SMLabel alloc]initWithFrameWith:CGRectMake(12, 12, WindowWith-24, 15) textColor:RGB(108, 123, 138) textFont:sysFont(15)];
        tittle.numberOfLines=0;
        tittle.text=@"首届植物极客朝圣之旅报名进行中";
        _tittle=tittle;
        [self.contentView addSubview:tittle];
        
        
        
        
        
        
        
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(12, 16, 30, 14) textColor:cBlackColor textFont:sysFont(13)];
        _lbl=lbl;
        lbl.hidden=YES;
         lbl.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:lbl];

      
        
        
        UIAsyncImageView * photo=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(12, _tittle.bottom+8.5, (WindowWith-48)/3.0, (WindowWith-48)*0.23)];
        _photo=photo;
        [self.contentView addSubview:photo];
        
        
        UIAsyncImageView * photo1=[[UIAsyncImageView alloc]initWithFrame:CGRectMake((WindowWith-48)/3.0+25,  _tittle.bottom+8.5, (WindowWith-48)/3.0, (WindowWith-48)*0.23)];
        _photo1=photo1;
        [self.contentView addSubview:photo1];
        
        UIAsyncImageView * photo2=[[UIAsyncImageView alloc]initWithFrame:CGRectMake((WindowWith-48)*2/3.0+35,  _tittle.bottom+8.5, (WindowWith-48)/3.0, (WindowWith-48)*0.23)];
        _photo2=photo2;
        [self.contentView addSubview:photo2];

        SMLabel * source=[[SMLabel alloc]initWithFrameWith:CGRectMake(15, _photo.bottom+12,150,12) textColor:cGrayLightColor textFont:sysFont(12)];
        source.textAlignment=NSTextAlignmentLeft;
        source.text=@"网易新闻";
        _source=source;
        [self.contentView addSubview:source];
        
     
        
        UIButton * seeNum=[UIButton buttonWithType:UIButtonTypeCustom];
        seeNum.frame=CGRectMake(WindowWith-115, _photo.bottom+12, 40, 12);
        [seeNum setTitle:@"10000" forState:UIControlStateNormal];
        [seeNum setTitleColor:cGrayLightColor forState:UIControlStateNormal];
        [seeNum setImage:Image(@"see.png") forState:UIControlStateNormal];
        seeNum.titleLabel.font=sysFont(12);
        [seeNum setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        _seeNum=seeNum;
        
        [self.contentView addSubview:seeNum];

        
        
        SMLabel * time=[[SMLabel alloc]initWithFrameWith:CGRectMake(WindowWith-70, _photo.bottom+12, 58, 13) textColor:cGrayLightColor textFont:sysFont(12)];
        time.text=@"10分钟前";
        time.textAlignment=NSTextAlignmentRight;
        _time=time;
        [self.contentView addSubview:time];
        
        
        
        UIView * line=[[UIView alloc]initWithFrame:CGRectMake(0,  0, WindowWith, 1)];
        line.backgroundColor=cLineColor;
        [self.contentView addSubview:line];
        
        
    }
    return self;
}


- (void)setData:(NewsListModel *)model
{
    
    UIImage *img=Image(@"dj.png");
  
    if (![model.label_color isEqualToString:@""]&&![model.label_name isEqualToString:@""]) {
        _lbl.hidden=NO;
        _lbl.backgroundColor=[IHUtility colorWithRGBString:model.label_color alph:0.2];
        _lbl.alpha=0.5;
        _lbl.textColor=[IHUtility colorWithRGBString:model.label_color alph:1];
    }else{
        _lbl.hidden=YES;
        _lbl.alpha=0;
    }

    _lbl.text=model.label_name;
    
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"       %@",model.info_title]];
    if ([model.label_name isEqualToString:@""]) {
        attrString=[[NSMutableAttributedString alloc] initWithString:model.info_title];
    }


    [attrString addAttribute:NSFontAttributeName value: sysFont(15) range:NSMakeRange(0,attrString.length)];
  
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:4];//调整行间距
    if (WindowWith==414) {
        [paragraphStyle setLineSpacing:3];//调整行间距
    }
    [attrString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attrString length])];
    [attrString addAttribute:NSForegroundColorAttributeName value:RGB(44, 44, 46) range:NSMakeRange(0,attrString.length)];
    _tittle.attributedText=attrString;
    
    CGSize size=[_tittle sizeThatFits:CGSizeMake(WindowWith-24, CGFLOAT_MAX)];
    _tittle.frame=CGRectMake(12, 12, size.width, size.height);

    
   
   
    
    _photo.origin=CGPointMake(12, _tittle.bottom+8.5);
    _photo1.origin=CGPointMake((WindowWith-48)/3.0+25,  _tittle.bottom+8.5);
     _photo2.origin=CGPointMake((WindowWith-48)*2/3.0+35,  _tittle.bottom+8.5);
    NSMutableArray * object=[[NSMutableArray alloc]initWithObjects:_photo,_photo1,_photo2, nil];
    
    if (model.img_type==3) {
        
        
        if (model.imgModels.count>3) {
            
            for (int i=0; i<3; i++) {
                
                NewsImageModel *mod=model.imgModels[i];
                [object[i] setImageAsyncWithURL: mod.img_path placeholderImage:DefaultImage_logo];
            }

        }else
        {
            for (int i=0; i<model.imgModels.count; i++) {
                
                NewsImageModel *mod=model.imgModels[i];
                [object[i] setImageAsyncWithURL: mod.img_path placeholderImage:DefaultImage_logo];
            }

            
        }

        
        

    }else if (model.img_type==2){
   
        NSArray *arr=[network getJsonForString:model.info_url];
        
        if (arr.count>3) {
            
            for (NSInteger i=0; i<3; i++) {
                NSDictionary *obj=arr[i];
                MTPhotosModel *mod=[[MTPhotosModel alloc]initWithUrlDic:obj];
                [object[i] setImageAsyncWithURL: mod.imgUrl placeholderImage:DefaultImage_logo];
            }

        }else
        {
            for (NSInteger i=0; i<arr.count; i++) {
                NSDictionary *obj=arr[i];
                MTPhotosModel *mod=[[MTPhotosModel alloc]initWithUrlDic:obj];
                [object[i] setImageAsyncWithURL: mod.imgUrl placeholderImage:DefaultImage_logo];
            }

            
        }
        
           }
    
    
    
    _source.text=model.info_from;
    
    
    
    CGSize size1=[IHUtility GetSizeByText:[IHUtility FormatMonthAndDayByString:model.uploadtime] sizeOfFont:12 width:55];
    
    _time.text=[IHUtility FormatMonthAndDayByString:model.uploadtime];
  
     _time.frame=CGRectMake(WindowWith-12-size1.width, _photo1.bottom+12, size1.width, 12);
    
    
    CGSize size2=[IHUtility GetSizeByText:[NSString stringWithFormat:@"%d",model.view_Total] sizeOfFont:12 width:40];
    img=Image(@"see.png");
      _source.frame=CGRectMake(12, _photo.bottom+12,WindowWith-size1.width-65-size2.width,12);
    
    [_seeNum setTitle:[NSString stringWithFormat:@"%d",model.view_Total]  forState:UIControlStateNormal];
    _seeNum.frame=CGRectMake(_time.left-12-(img.size.width+5+size2.width), _source.top, img.size.width+5+size2.width, img.size.height);
 
}


@end


//一张图
@implementation NewsCell3

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
   self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(12, 15, 30, 14) textColor:cBlackColor textFont:sysFont(13)];
         lbl.textAlignment=NSTextAlignmentCenter;
        _lbl=lbl;
        lbl.hidden=YES;
        [self.contentView addSubview:lbl];

        
        SMLabel * tittle=[[SMLabel alloc]initWithFrameWith:CGRectMake(12, 12, WindowWith-30, 16) textColor:cBlackColor textFont:sysFont(15)];
        
        tittle.text=@"首届植物极客朝圣之旅报名进行中";
        tittle.numberOfLines=0;
        _tittle=tittle;
        [self.contentView addSubview:tittle];
        
        
     
        
        
        UIButton * seeNum=[UIButton buttonWithType:UIButtonTypeCustom];
        seeNum.frame=CGRectMake(WindowWith-115, (WindowWith-24)*0.29+88, 40, 12);
        [seeNum setTitle:@"10000" forState:UIControlStateNormal];
        [seeNum setTitleColor:cGrayLightColor forState:UIControlStateNormal];
        [seeNum setImage:Image(@"see.png") forState:UIControlStateNormal];
        seeNum.titleLabel.font=sysFont(12);
        [seeNum setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        _seeNum=seeNum;
        
        [self.contentView addSubview:seeNum];
       
       UIAsyncImageView * photo=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(12, _tittle.bottom+11, WindowWith-24, (WindowWith-24)*0.32)];

        _photo=photo;
        _photo.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:photo];
        
        
    
        
        
        SMLabel * source=[[SMLabel alloc]initWithFrameWith:CGRectMake(15, _photo.bottom+12,150,12) textColor:cGrayLightColor textFont:sysFont(12)];
        source.textAlignment=NSTextAlignmentLeft;
        source.text=@"网易新闻";
        _source=source;
        [self.contentView addSubview:source];

        
        
        
        SMLabel *time=[[SMLabel alloc]initWithFrameWith:CGRectMake(WindowWith-70, (WindowWith-24)*0.29+88, 55, 12) textColor:cGrayLightColor textFont:sysFont(12)];
        time.text=@"10分钟前";
        time.textAlignment=NSTextAlignmentRight;
        _time=time;
        [self.contentView addSubview:time];
        
        
        
        UIView * line=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 1)];
        line.backgroundColor=cLineColor;
//        _lineView=line;
        [self.contentView addSubview:line];
        
        
    }
    return self;
}
- (void)setData:(NewsListModel *)model
{
    UIImage *img=Image(@"dj.png");
    if (![model.label_color isEqualToString:@""]&&![model.label_name isEqualToString:@""]) {
        _lbl.hidden=NO;
        _lbl.backgroundColor=[IHUtility colorWithRGBString:model.label_color alph:0.2];
        _lbl.alpha=0.5;
        _lbl.textColor=[IHUtility colorWithRGBString:model.label_color alph:1];
    }else{
          _lbl.alpha=0;
        _lbl.hidden=YES;
    }

    _lbl.text=model.label_name;
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"       %@",model.info_title]];

    if ([model.label_name isEqualToString:@""]) {
        attrString=[[NSMutableAttributedString alloc] initWithString:model.info_title];
    }

    [attrString addAttribute:NSFontAttributeName value: sysFont(15) range:NSMakeRange(0,attrString.length)];
    
   
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:4];//调整行间距
    [attrString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attrString length])];
    [attrString addAttribute:NSForegroundColorAttributeName value:RGB(44, 44, 46) range:NSMakeRange(0,attrString.length)];
    _tittle.attributedText=attrString;
    
    CGSize size=[_tittle sizeThatFits:CGSizeMake(WindowWith-24, CGFLOAT_MAX)];
    _tittle.frame=CGRectMake(12, 12, size.width, size.height);
    
      NSLog(@"%d~~~~%f",model.img_type,size.height);
    
    MTPhotosModel * photo=model.imgArray[0];
    
    [_photo setImageAsyncWithURL:photo.imgUrl placeholderImage:DefaultImage_logo];
    _photo.origin=CGPointMake(12, _tittle.bottom+12);

    
    CGSize size1=[IHUtility GetSizeByText:[IHUtility FormatMonthAndDayByString:model.uploadtime] sizeOfFont:12 width:55];
    
    
    
    _time.text=[IHUtility FormatMonthAndDayByString:model.uploadtime];
   _time.frame=CGRectMake(WindowWith-12-size1.width, _photo.bottom+12, size1.width, 12);
  
    
    CGSize size2=[IHUtility GetSizeByText:[NSString stringWithFormat:@"%d",model.view_Total] sizeOfFont:12 width:40];
   img=Image(@"see.png");
    
    _source.text=model.info_from;
    
    _source.frame=CGRectMake(12, _photo.bottom+12,WindowWith-size1.width-65-size2.width,12);
    
    [_seeNum setTitle:[NSString stringWithFormat:@"%d",model.view_Total]  forState:UIControlStateNormal];
    _seeNum.frame=CGRectMake(_time.left-12-( img.size.width+5+size2.width), _time.top, img.size.width+5+size2.width, img.size.height);
;
  
}

@end

//没图
@implementation NewsCell4
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
   
        
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(12, 15, 30, 14) textColor:cBlackColor textFont:sysFont(13)];
        _lbl=lbl;
        lbl.hidden=YES;
         lbl.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:lbl];

        
        SMLabel * tittle=[[SMLabel alloc]initWithFrameWith:CGRectMake(12,12, WindowWith-24, 40) textColor:RGB(44, 44, 46) textFont:sysFont(15)];
        tittle.numberOfLines=2;
        tittle.text=@"首届植物极客朝圣之旅报名进行中";
        
        _tittle=tittle;
        [self.contentView addSubview:tittle];
        
        SMLabel * source=[[SMLabel alloc]initWithFrameWith:CGRectMake(tittle.left, WindowWith*0.21-7, 70,12) textColor:cGrayLightColor textFont:sysFont(12)];
        source.textAlignment=NSTextAlignmentLeft;
        source.text=@"网易新闻";
        _source=source;
        [self.contentView addSubview:source];
        
        
        
        
        UIButton * seeNum=[UIButton buttonWithType:UIButtonTypeCustom];
        seeNum.frame=CGRectMake(WindowWith-115, WindowWith*0.21-7, 40, 12);
        [seeNum setTitle:@"10000" forState:UIControlStateNormal];
        [seeNum setTitleColor:cGrayLightColor forState:UIControlStateNormal];
        [seeNum setImage:Image(@"see.png") forState:UIControlStateNormal];
        seeNum.titleLabel.font=sysFont(12);
        [seeNum setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        _seeNum=seeNum;
        
        [self.contentView addSubview:seeNum];
        
        
        
        SMLabel *time=[[SMLabel alloc]initWithFrameWith:CGRectMake(WindowWith-70, (WindowWith-24)*0.29+88, 55, 12) textColor:cGrayLightColor textFont:sysFont(12)];
        time.text=@"10分钟前";
        time.textAlignment=NSTextAlignmentRight;
        _time=time;
        [self.contentView addSubview:time];

        
        
        UIView * line=[[UIView alloc]initWithFrame:CGRectMake(0,  0, WindowWith, 1)];
        line.backgroundColor=cLineColor;
//        _lineView=line;
        [self.contentView addSubview:line];
        
        
    }
    return self;
    
}

- (void)setData:(NewsListModel *)model
{
    UIImage *img=Image(@"dj.png");
    if (![model.label_color isEqualToString:@""]&&![model.label_name isEqualToString:@""]) {
        _lbl.backgroundColor=[IHUtility colorWithRGBString:model.label_color alph:0.2];
        _lbl.alpha=0.5;
        _lbl.textColor=[IHUtility colorWithRGBString:model.label_color alph:1];
        _lbl.hidden=NO;
    }else{
        _lbl.hidden=YES;
        _lbl.alpha=0;
    }
    _lbl.text=model.label_name;
    
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"       %@",model.info_title]];

    if ([model.label_name isEqualToString:@""]) {
        attrString=[[NSMutableAttributedString alloc] initWithString:model.info_title];
    }

    [attrString addAttribute:NSFontAttributeName value: sysFont(15) range:NSMakeRange(0,attrString.length)];
    
  
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:4];//调整行间距
    [attrString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attrString length])];
    [attrString addAttribute:NSForegroundColorAttributeName value:RGB(44, 44, 46) range:NSMakeRange(0,attrString.length)];
    _tittle.attributedText=attrString;
    
    CGSize size=[_tittle sizeThatFits:CGSizeMake(WindowWith-24, CGFLOAT_MAX)];
    _tittle.frame=CGRectMake(12, 12, size.width, size.height);
    
    
    CGSize size1=[IHUtility GetSizeByText:[IHUtility FormatMonthAndDayByString:model.uploadtime] sizeOfFont:12 width:55];
    
    
    
    _time.text=[IHUtility FormatMonthAndDayByString:model.uploadtime];
    
    _time.frame=CGRectMake(WindowWith-12-size1.width, _tittle.bottom+12, size1.width, 12);
    
    
    
    
    CGSize size2=[IHUtility GetSizeByText:[NSString stringWithFormat:@"%d",model.view_Total] sizeOfFont:12 width:40];
  img=Image(@"see.png");
    _source.text=model.info_from;
    
    _source.frame=CGRectMake(12, _tittle.bottom+12,WindowWith-size1.width-65-size2.width,12);
    
    [_seeNum setTitle:[NSString stringWithFormat:@"%d",model.view_Total]  forState:UIControlStateNormal];
    _seeNum.frame=CGRectMake(_time.left-12-(img.size.width+5+size2.width), _time.top, img.size.width+5+size2.width, img.size.height);
    ;
   

    
    
    
    
   
    
  
    
    
}



@end




//视频
@implementation NewsCell5

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        UIImage *img=Image(@"tj.png");
       
       
        
        
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(12, 14, 30, 14) textColor:cBlackColor textFont:sysFont(13)];
        _lbl=lbl;
        _lbl.hidden=YES;
         lbl.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:lbl];

        
        SMLabel * tittle=[[SMLabel alloc]initWithFrameWith:CGRectMake(12, 12, WindowWith-30, 16) textColor:cBlackColor textFont:sysFont(15)];
        
        tittle.text=@"首届植物极客朝圣之旅报名进行中";
        tittle.numberOfLines=0;
        _tittle=tittle;
        [self.contentView addSubview:tittle];
        
        
        
        
        
        UIButton * seeNum=[UIButton buttonWithType:UIButtonTypeCustom];
        seeNum.frame=CGRectMake(WindowWith-115, (WindowWith-24)*0.29+88, 40, 12);
        [seeNum setTitle:@"10000" forState:UIControlStateNormal];
        [seeNum setTitleColor:cGrayLightColor forState:UIControlStateNormal];
        [seeNum setImage:Image(@"see.png") forState:UIControlStateNormal];
        seeNum.titleLabel.font=sysFont(12);
        [seeNum setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        _seeNum=seeNum;
        
        [self.contentView addSubview:seeNum];
        
        UIAsyncImageView * photo=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(12, _tittle.bottom+11, WindowWith-24, (WindowWith-24)*0.55)];
        
        _photo=photo;
        [self.contentView addSubview:photo];
        
        img=Image(@"play.png");
      UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
        imageView.image=img;
        _playImgView=imageView;
        [self.contentView addSubview:imageView];
        
        
        SMLabel * source=[[SMLabel alloc]initWithFrameWith:CGRectMake(15, _photo.bottom+12,150,12) textColor:cGrayLightColor textFont:sysFont(12)];
        source.textAlignment=NSTextAlignmentLeft;
        source.text=@"网易新闻";
        _source=source;
        [self.contentView addSubview:source];
        
        
        
        
        SMLabel *time=[[SMLabel alloc]initWithFrameWith:CGRectMake(WindowWith-70, (WindowWith-24)*0.29+88, 55, 12) textColor:cGrayLightColor textFont:sysFont(12)];
        time.text=@"10分钟前";
        time.textAlignment=NSTextAlignmentRight;
        _time=time;
        [self.contentView addSubview:time];
        
        
        
        UIView * line=[[UIView alloc]initWithFrame:CGRectMake(0,  0, WindowWith, 1)];
        line.backgroundColor=cLineColor;
//        _lineView=line;
        [self.contentView addSubview:line];
        
        
    }
    return self;
}
- (void)setData:(NewsListModel *)model
{
    UIImage *img=Image(@"dj.png");
    if (![model.label_color isEqualToString:@""] &&![model.label_name isEqualToString:@""]) {
        _lbl.backgroundColor=[IHUtility colorWithRGBString:model.label_color alph:0.2];
        _lbl.alpha=0.5;
        _lbl.hidden=NO;
        _lbl.textColor=[IHUtility colorWithRGBString:model.label_color alph:1];
    }else{
        _lbl.hidden=YES;
        _lbl.alpha=0;
    }

    _lbl.text=model.label_name;
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"       %@",model.info_title]];

    if ([model.label_name isEqualToString:@""]) {
        attrString=[[NSMutableAttributedString alloc] initWithString:model.info_title];
    }

    [attrString addAttribute:NSFontAttributeName value: sysFont(15) range:NSMakeRange(0,attrString.length)];
    if (WindowWith==320) {
        [attrString addAttribute:NSFontAttributeName value: sysFont(13) range:NSMakeRange(0,attrString.length)];
    }
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:4];//调整行间距
    [attrString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attrString length])];
    [attrString addAttribute:NSForegroundColorAttributeName value:RGB(44, 44, 46) range:NSMakeRange(0,attrString.length)];
    _tittle.attributedText=attrString;
    
    CGSize size=[_tittle sizeThatFits:CGSizeMake(WindowWith-24, CGFLOAT_MAX)];
    _tittle.frame=CGRectMake(12, 10, size.width, size.height);
    
    
    
    
    MTPhotosModel * photo=model.imgArray[0];
    
    [_photo setImageAsyncWithURL:photo.imgUrl placeholderImage:DefaultImage_logo];
    _photo.origin=CGPointMake(12, _tittle.bottom+12);
    _playImgView.center=_photo.center;

    
    CGSize size1=[IHUtility GetSizeByText:[IHUtility FormatMonthAndDayByString:model.uploadtime] sizeOfFont:12 width:55];
    
    
    
    _time.text=[IHUtility FormatMonthAndDayByString:model.uploadtime];
    
     _time.frame=CGRectMake(WindowWith-12-size1.width, _photo.bottom+12, size1.width, 12);
  
    
    
    
    CGSize size2=[IHUtility GetSizeByText:[NSString stringWithFormat:@"%d",model.view_Total] sizeOfFont:12 width:40];
     img=Image(@"see.png");
    _source.text=model.info_from;
    
    _source.frame=CGRectMake(12, _photo.bottom+12,WindowWith-size1.width-65-size2.width,12);
    
    [_seeNum setTitle:[NSString stringWithFormat:@"%d",model.view_Total]  forState:UIControlStateNormal];
    _seeNum.frame=CGRectMake(_time.left-12-( img.size.width+5+size2.width), _time.top, img.size.width+5+size2.width, img.size.height);
    ;
   

    
  
    
  }

@end











