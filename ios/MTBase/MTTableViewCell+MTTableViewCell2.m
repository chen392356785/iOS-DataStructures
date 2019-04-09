//
//  MTTableViewCell+MTTableViewCell2.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/9/12.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "CustomView+AskBarSubViews.h"
#import "CustomView+CustomCategory2.h"
#import "MTTableViewCell+MTTableViewCell2.h"

@implementation MTTableViewCell (MTTableViewCell2)

@end


@implementation MTZhaoPingTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(MyJobType)type
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor=RGB(247, 248, 250);
        CurriculumVitaeView *view=[[CurriculumVitaeView alloc]initWithFrame:CGRectMake(0.016*WindowWith, 9, WindowWith-0.032*WindowWith, 112)];
        _view=view;
       // view.backgroundColor=[UIColor whiteColor];
        [self.contentView addSubview:view];
      
               if (type==ENT_CurriculumVitae) {
        
                   
                   UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(0.016*WindowWith, view.bottom, WindowWith-0.032*WindowWith, 45)];
                   bgView.backgroundColor=[UIColor whiteColor];
                   [self.contentView addSubview:bgView];
                   _bgView=bgView;
                   UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, bgView.width, 1)];
                   lineView.backgroundColor=cLineColor;
                   [bgView addSubview:lineView];
                   
                   
                   UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
                   btn.frame=CGRectMake(bgView.width-10-90, lineView.bottom+7, 90, 32);
                   [btn setLayerMasksCornerRadius:5 BorderWidth:1 borderColor:cGreenColor];
                   [btn setTitle:@"立即沟通" forState:UIControlStateNormal];
                   [btn addTarget:self action:@selector(communicate) forControlEvents:UIControlEventTouchUpInside];
                   [btn setTitleColor:cGreenColor forState:UIControlStateNormal];
                   btn.titleLabel.font=sysFont(15);
                   [bgView addSubview:btn];
                   
                   
                   btn=[UIButton buttonWithType:UIButtonTypeCustom];
                   btn.frame=CGRectMake(bgView.width-10-90-68, lineView.bottom+7, 50, 32);
                   [btn setLayerMasksCornerRadius:5 BorderWidth:1 borderColor:cGrayLightColor];
                   [btn setTitle:@"删除" forState:UIControlStateNormal];
                   [btn addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
                   [btn setTitleColor:cGrayLightColor forState:UIControlStateNormal];
                   btn.titleLabel.font=sysFont(15);
                   [bgView addSubview:btn];

            
               }
        
        
        
    }
    return self;
}

-(void)setDataWithModel:(jianliModel *)model{
   
   CGFloat height=[_view setDataWithModel:model];
    _view.height=height;
    
}


-(void)communicate{
    
    if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
        
        [self.delegate BCtableViewCell:self action:MTCommentActionTableViewCell indexPath:self.indexPath attribute:nil];
        
        
    }

    
}

-(void)delete{
    
    if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
        
        [self.delegate BCtableViewCell:self action:MTDeleteActionTableViewCell indexPath:self.indexPath attribute:nil];
        
        
    }

    
}

@end


@implementation MTJobWantedTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundView = nil;
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(6, 8, WindowWith - 12, 165 - 8)];
        backView.layer.cornerRadius = 3.0;
        backView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:backView];
        
        SMLabel *lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(10, 10, backView.width-20, 20) textColor:cGreenColor textFont:sysFont(15)];
        lbl.text = @"园林总经理";
        _positionLbl = lbl;
        [backView addSubview:lbl];
        
        CGSize size= [IHUtility GetSizeByText:@"￥5k－6k" sizeOfFont:13 width:100];
        lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(10, lbl.bottom + 5, size.width, 15) textColor:RGB(230, 129, 129) textFont:sysFont(13)];
        lbl.text = @"￥5k－6k";
        _salayLbl = lbl;
        [backView addSubview:lbl];
        
        UIImage *img = Image(@"Job_adress.png");
        UIImageView *adressImageV = [[UIImageView alloc] initWithFrame:CGRectMake(lbl.right + 10, lbl.top, img.size.width, img.size.height)];
        adressImageV.image = img;
        adressImageV.centerY = lbl.centerY;
        _adressImageV = adressImageV;
        [backView addSubview:adressImageV];
        
        size= [IHUtility GetSizeByText:@"长沙" sizeOfFont:13 width:100];
        lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(adressImageV.right+2, lbl.top, size.width, 15) textColor:cGrayLightColor textFont:sysFont(13)];
        lbl.text = @"长沙";
        _adressLbl = lbl;
        [backView addSubview:lbl];
        
        img = Image(@"Job_experience.png");
        UIImageView *JYImageV = [[UIImageView alloc] initWithFrame:CGRectMake(lbl.right + 10, lbl.top, img.size.width, img.size.height)];
        JYImageV.image = img;
        JYImageV.centerY = lbl.centerY;
        _JYImageV = JYImageV;
        [backView addSubview:JYImageV];
        
        size= [IHUtility GetSizeByText:@"经验不限" sizeOfFont:13 width:100];
        lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(JYImageV.right+2, lbl.top, size.width, 15) textColor:cGrayLightColor textFont:sysFont(13)];
        lbl.text = @"经验不限";
        _expLbl = lbl;
        [backView addSubview:lbl];
        
        img = Image(@"Job_academic.png");
        UIImageView *XLImageV = [[UIImageView alloc] initWithFrame:CGRectMake(lbl.right + 10, lbl.top, img.size.width, img.size.height)];
        XLImageV.image = img;
        XLImageV.centerY = lbl.centerY;
        _XLImageV = XLImageV;
        [backView addSubview:XLImageV];
        
        size= [IHUtility GetSizeByText:@"本科" sizeOfFont:13 width:100];
        lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(XLImageV.right+2, lbl.top, size.width, 15) textColor:cGrayLightColor textFont:sysFont(13)];
        lbl.text = @"本科";
        _studyLbl = lbl;
        [backView addSubview:lbl];
        
        UIAsyncImageView *hreardImg = [[UIAsyncImageView alloc] initWithFrame:CGRectMake(10, lbl.bottom + 10, 72, 72)];
        hreardImg.image= defalutHeadImage;
        hreardImg.layer.cornerRadius = 36;
        _heardImg= hreardImg;
        [backView addSubview:hreardImg];
        
        lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(hreardImg.right+8, hreardImg.top + 17, backView.width - hreardImg.right -16, 18.5) textColor:cGrayLightColor textFont:sysFont(13)];
        lbl.text = @"李开心  |  人事经理  |  50-99人";
        _infoLbl= lbl;
        [backView addSubview:lbl];
        
        lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(hreardImg.right+8, lbl.bottom + 5, backView.width - hreardImg.right -16, 16.5) textColor:cGrayLightColor textFont:sysFont(12)];
        lbl.text = @"湖南省开心农场有限公司";
        _companyLbl = lbl;
        [backView addSubview:lbl];
        
        lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(10, hreardImg.bottom, backView.width - 20, 16.5) textColor:cGrayLightColor textFont:sysFont(12)];
        lbl.text = @"发布日期：2016年8月8日";
        lbl.textAlignment = NSTextAlignmentRight;
        _timeLbl = lbl;
        [backView addSubview:lbl];
    }
    return self;
    
}

- (void)setCellDate:(PositionListModel *)model type:(CollecgtionType)type
{
    _positionLbl.text = model.job_name;
    
    _salayLbl.text = [NSString stringWithFormat:@"￥%@",model.salary];
    if ([model.salary isEqualToString:@""]) {
        _salayLbl.text = @"面议";
    }
    
    CGSize size= [IHUtility GetSizeByText:_salayLbl.text sizeOfFont:13 width:100];
    _salayLbl.width = size.width;
    
    _adressImageV.left = _salayLbl.right + 10;
    _adressLbl.left = _adressImageV.right + 2;
    
    _adressLbl.text = model.work_city;
    if ([model.work_city isEqualToString:@""]) {
        _adressLbl.text = @"不限";
    }
    
    size= [IHUtility GetSizeByText:_adressLbl.text sizeOfFont:13 width:100];
    _adressLbl.width = size.width;
    
    _JYImageV.left = _adressLbl.right + 10;
    _expLbl.left = _JYImageV.right + 2;
    
    _expLbl.text = model.experience;
    if ([model.experience isEqualToString:@""]) {
        _expLbl.text = @"不限";
    }
    size= [IHUtility GetSizeByText:_expLbl.text sizeOfFont:13 width:100];
    _expLbl.width = size.width;
    
    _XLImageV.left = _expLbl.right + 10;
    _studyLbl.left = _XLImageV.right + 2;
    _studyLbl.text = model.edu_require;
    if ([model.edu_require isEqualToString:@""]) {
        _studyLbl.text = @"不限";
    }
    size= [IHUtility GetSizeByText:_studyLbl.text sizeOfFont:13 width:100];
    _studyLbl.width = size.width;
    
    [_heardImg setImageAsyncWithURL:model.heed_image_url placeholderImage:defalutHeadImage];
    
    NSArray *array = @[model.nickname,model.position,model.staff_size];
    NSString *infoStr;
    for (NSString *str in array) {
        if (str.length >0) {
            if (infoStr.length>0) {
                infoStr = [NSString stringWithFormat:@"%@  |  %@",infoStr,str];
            }else {
                infoStr = str;
            }
        }
    }
    _infoLbl.text = infoStr;
    
    _companyLbl.text = model.company_name;
    
    if (type == ENT_UserDeliveryrecord) {
        _timeLbl.text = @"已投递";
    }else {
        NSString *time= [IHUtility FormatMonthAndDayByString:model.deploy_time];
        _timeLbl.text = [NSString stringWithFormat:@"发布日期：%@",time];
    }

}


@end


@implementation CurriculumVitaeTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor=RGB(247, 248, 250);
        UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(0.016*WindowWith, 0, WindowWith-0.032*WindowWith, 76)];
        _bgView=bgView;
        bgView.backgroundColor=[UIColor whiteColor];
        [self.contentView addSubview:bgView];
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0.032*WindowWith, 0.02*WindowWith, 208, 13) textColor:cGrayLightColor textFont:sysFont(13)];
        lbl.text=@"苗圃经理／湖南省开心农场有限公司";
        _companyLbl=lbl;
        [bgView addSubview:lbl];
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.right, lbl.top+1, bgView.width-lbl.right-0.032*WindowWith, 12) textColor:cGrayLightColor textFont:sysFont(12)];
        lbl.textAlignment=NSTextAlignmentRight;
        lbl.text=@"2015／1-2016/8";
        _timeLbl=lbl;
        [bgView addSubview:lbl];
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0.032*WindowWith, 0.016*WindowWith+lbl.bottom, WindowWith-0.032*WindowWith*2, 35) textColor:cGrayLightColor textFont:sysFont(11)];
        lbl.numberOfLines=0;
        _contentLbl=lbl;
        lbl.text=@"全面负责苗圃基地（接近700亩）所有日常管理（苗木栽种、出库、销售等）工作，配合公司项目进行苗木移植清点等；";
        [bgView addSubview:lbl];
        
        
     
        UIView  *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 1)];
        lineView.backgroundColor=cLineColor;
        
        [bgView addSubview:lineView];
        
    
    }
 
    return self;
}



-(void)setDataWithModel:(RecruitEdusModel *)model
{
    
    CGSize timeSize=[IHUtility GetSizeByText:[NSString stringWithFormat:@"%@-%@",model.start_date,model.end_date] sizeOfFont:12 width:200];
    CGSize size=[IHUtility GetSizeByText:[NSString stringWithFormat:@"%@/%@",model.major,model.school_name] sizeOfFont:13 width:self.width-timeSize.width-20];
    _companyLbl.text=[NSString stringWithFormat:@"%@/%@",model.major,model.school_name];
    _companyLbl.size=CGSizeMake(size.width, 15);
    
    
    _timeLbl.text=[NSString stringWithFormat:@"%@-%@",model.start_date,model.end_date];
   
    _timeLbl.frame=CGRectMake(WindowWith-0.032*WindowWith-timeSize.width-0.016*WindowWith, _companyLbl.top+1, timeSize.width, 12);
    _timeLbl.textAlignment=NSTextAlignmentRight;
    
    size=[IHUtility GetSizeByText:model.experience sizeOfFont:11 width:WindowWith-0.032*WindowWith*2];
    _contentLbl.text=model.experience;
    _contentLbl.size=CGSizeMake(size.width, size.height);
    
    _bgView.height=_contentLbl.bottom+0.016*WindowWith;
    
    
    
    
}


-(void)setDataModel2:(RecruitWorksModel *)model{
    
    
    CGSize timeSize=[IHUtility GetSizeByText:[NSString stringWithFormat:@"%@-%@",model.start_date,model.end_date] sizeOfFont:12 width:200];
    CGSize size=[IHUtility GetSizeByText:[NSString stringWithFormat:@"%@/%@",model.job_name,model.company_name] sizeOfFont:13 width:self.width-timeSize.width-20];
    _companyLbl.text=[NSString stringWithFormat:@"%@/%@",model.job_name,model.company_name];
    _companyLbl.size=CGSizeMake(size.width, 15);
    
    
    _timeLbl.text=[NSString stringWithFormat:@"%@-%@",model.start_date,model.end_date];
    _timeLbl.frame=CGRectMake(WindowWith-0.032*WindowWith-timeSize.width-0.016*WindowWith, _companyLbl.top+1, timeSize.width, 12);
     _timeLbl.textAlignment=NSTextAlignmentRight;
    size=[IHUtility GetSizeByText:model.work_content sizeOfFont:11 width:WindowWith-0.032*WindowWith*2];
    _contentLbl.text=model.work_content;
    _contentLbl.size=CGSizeMake(size.width, size.height);
    _bgView.height=_contentLbl.bottom+0.016*WindowWith;
}





@end


@implementation CurriculumVitaeTableViewCell2
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor=RGB(247, 248, 250);
        UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(0.016*WindowWith, 0, WindowWith-0.032*WindowWith, 25)];
        _bgView=bgView;
        bgView.backgroundColor=[UIColor whiteColor];
        [self.contentView addSubview:bgView];
        
      SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0.032*WindowWith, 0.02*WindowWith, WindowWith-0.032*WindowWith*2, 11) textColor:cGrayLightColor textFont:sysFont(11)];
        lbl.numberOfLines=0;
        lbl.text=@"工作经验丰富。";
        _lbl=lbl;
        [bgView addSubview:lbl];
        
        
      
        
        
    }
    
    return self;
}

-(void)setDataWith:(NSString *)text{
    
    CGSize size=[IHUtility GetSizeByText:text sizeOfFont:11 width:WindowWith-0.032*WindowWith*2];
    _lbl.text=text;
    _lbl.size=CGSizeMake(size.width, size.height);
    _bgView.height=size.height+15;
}




@end


@implementation MyPositionTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView  *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 8)];
        lineView.backgroundColor=cLineColor;
        [self.contentView addSubview:lineView];

        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0.046*WindowWith, lineView.bottom+10, 108, 15) textColor:cGreenColor textFont:sysFont(15)];
        lbl.text=@"园林总经理";
        _positionLbl=lbl;
        [self.contentView addSubview:lbl];
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.left, lbl.bottom+10, 60, 12) textColor:cGreenColor textFont:sysFont(12)];
        lbl.text=@"￥ 5k－6k";
        _salayLbl=lbl;
        [self.contentView addSubview:lbl];

        
        
        UIButton *adressBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *img=Image(@"Job_adress.png");
        [adressBtn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
        _adressBtn=adressBtn;
        [adressBtn setTitle:@"长沙" forState:UIControlStateNormal];
        [adressBtn setTitleColor:cGrayLightColor forState:UIControlStateNormal];
        adressBtn.titleLabel.font=sysFont(13);
        adressBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
        adressBtn.frame=CGRectMake(lbl.right+15, lbl.top, 41, img.size.height);
        [self.contentView addSubview:adressBtn];
        
        
        UIButton *experienceBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        img=Image(@"Job_experience.png");
        [experienceBtn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
        _experienceBtn=experienceBtn;
        [experienceBtn setTitle:@"5年" forState:UIControlStateNormal];
        [experienceBtn setTitleColor:cGrayLightColor forState:UIControlStateNormal];
        experienceBtn.titleLabel.font=sysFont(13);
        experienceBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
        experienceBtn.frame=CGRectMake(11+adressBtn.right, adressBtn.top, 41, img.size.height);
        [self.contentView addSubview:experienceBtn];
        
        
        
        UIButton *academicBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        img=Image(@"Job_academic.png");
        [academicBtn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
        _academicBtn=academicBtn;
        [academicBtn setTitle:@"本科" forState:UIControlStateNormal];
        [academicBtn setTitleColor:cGrayLightColor forState:UIControlStateNormal];
        academicBtn.titleLabel.font=sysFont(13);
        academicBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
        academicBtn.frame=CGRectMake(11+experienceBtn.right, adressBtn.top, 50, 13);
        [self.contentView addSubview:academicBtn];

        
        
        img=Image(@"GQ_Left.png");
      UIImageView  *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(WindowWith-img.size.width-12, 76/2-img.size.height/2, img.size.width, img.size.height)];
        imageView.image=img;
        
        [self.contentView addSubview:imageView];
        
        
        self.lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.left-50, imageView.top, 40, 13) textColor:cGrayLightColor textFont:sysFont(13)];
    
        self.lbl.centerY=imageView.centerY;
        [self.contentView addSubview:self.lbl];
        
        
    }
    
    return self;
}
-(void)setDataWithModel:(ReleasePositionModel *)model{
    
    CGSize size=[IHUtility GetSizeByText:model.job_name sizeOfFont:15 width:200];
    _positionLbl.text=model.job_name;
    _positionLbl.size=CGSizeMake(size.width, 15);
    
    
    size=[IHUtility GetSizeByText:[NSString stringWithFormat:@"￥ %@",model.salary] sizeOfFont:12 width:200];
    _salayLbl.text=[NSString stringWithFormat:@"￥ %@",model.salary];
    _salayLbl.size=CGSizeMake(size.width, size.height);
    
    
    
    UIImage *img=Image(@"Job_adress.png");
    size=[IHUtility GetSizeByText:model.work_city sizeOfFont:13 width:100];
    [_adressBtn setTitle:model.work_city forState:UIControlStateNormal];
    _adressBtn.size=CGSizeMake(size.width+5+img.size.width, img.size.height);
    _academicBtn.origin=CGPointMake(_salayLbl.right+0.04*WindowWith, _salayLbl.top);
    
    img=Image(@"Job_experience.png");
    size=[IHUtility GetSizeByText:model.experience sizeOfFont:13 width:100];
    [_experienceBtn setTitle:model.experience forState:UIControlStateNormal];
    _experienceBtn.frame=CGRectMake(_adressBtn.right+11, _adressBtn.top, size.width+5+img.size.width, img.size.height);
    
    
    img=Image(@"Job_academic.png");
    size=[IHUtility GetSizeByText:model.edu_require sizeOfFont:13 width:100];
    [_academicBtn setTitle:model.edu_require forState:UIControlStateNormal];
    _academicBtn.frame=CGRectMake(_experienceBtn.right+11, _adressBtn.top, size.width+5+img.size.width, img.size.height);

    if (model.status==0) {
        self.lbl.text=@"已关闭";
    }else{
        self.lbl.text=@"";
    }
    
    
    
}


@end



@implementation ChoosePositionTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=cBgColor;
//        UIView  *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 1)];
//        lineView.backgroundColor=cLineColor;
//        [self.contentView addSubview:lineView];
//        
//        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0.04*WindowWith, 15, 26, 13) textColor:cBlackColor textFont:sysFont(13)];
//        lbl.text=@"苗木";
//        _tilteLbl=lbl;
//        [self.contentView addSubview:lbl];
//        
//        
//        
//        
//     UIImage *img=Image(@"GQ_Left.png");
//        UIImageView  *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(WindowWith-img.size.width-12, lbl.top, img.size.width, img.size.height)];
//        imageView.image=img;
//        
//        [self.contentView addSubview:imageView];
//        
//        
//        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0.04*WindowWith, lbl.bottom+0.04*WindowWith, WindowWith-0.08*WindowWith, 11) textColor:cBlackColor textFont:sysFont(11)];
//        lbl.text=@"苗木管理 | 苗木技术 | 苗木销售 | 苗木采购 | 苗木其他";
//        lbl.numberOfLines=0;
//        _lbl=lbl;
//        [self.contentView addSubview:lbl];
        
        ChoosePositionView *view=[[ChoosePositionView alloc]initWithFrame:CGRectMake(15, 0, WindowWith-30, 150)];
        _view=view;
        view.selectBtnBlock=^(NSInteger index){
            [self dianji:index];
        };
        [self.contentView addSubview:view];
        
        
        
        
    }
    
    return self;
}

-(void)dianji:(NSInteger)index{
    if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
        
        [self.delegate BCtableViewCell:self action:MTDeleteActionTableViewCell indexPath:self.indexPath attribute:[NSString stringWithFormat:@"%ld",index]];
        
        
    }

}


-(void)setDataWith:(NSDictionary *)dic{
    
    NSString *text=dic.allKeys[0];
    
    
//    CGSize size=[IHUtility GetSizeByText:text sizeOfFont:13 width:200];
//    _tilteLbl.text=text;
//    _tilteLbl.size=CGSizeMake(size.width, 13);
//    
    NSArray *arr=dic[text];
    
    //NSMutableString *str=[[NSMutableString alloc]init];
    NSMutableArray *Arr=[[NSMutableArray alloc]init];
    for (NSInteger i=0; i<arr.count; i++) {
        NSDictionary *Dic=arr[i];
        [Arr addObject:Dic.allKeys[0]];
//        if (i==0) {
//           [str appendString:Dic.allKeys[0]];
//        }else{
//            [str appendString:[NSString stringWithFormat:@" | %@",Dic.allKeys[0]]];
//        }
        
//
    }
    CGFloat height=[_view setDataWithArr:Arr];
    _view.height=height;
//    size=[IHUtility GetSizeByText:str sizeOfFont:11 width:WindowWith-0.08*WindowWith];
//    _lbl.text=str;
//    _lbl.size=CGSizeMake(size.width, size.height);
    
    
    
    
}

@end



@implementation SearchPositionTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView  *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 1)];
        lineView.backgroundColor=cLineColor;
        [self.contentView addSubview:lineView];
        
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0.04*WindowWith, 15, WindowWith-0.08*WindowWith, 13) textColor:cBlackColor textFont:sysFont(13)];
        lbl.text=@"苗圃总经理";
        _tilteLbl=lbl;
        [self.contentView addSubview:lbl];
        
        

        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0.04*WindowWith, lbl.bottom+15, WindowWith-0.08*WindowWith, 11) textColor:cBlackColor textFont:sysFont(11)];
        lbl.text=@"施工-园林工程";
        _lbl=lbl;
        [self.contentView addSubview:lbl];
        
        
        
        
        
    }
    
    return self;
}


-(void)setDataWith:(SearchJobNameModel *)model{
  
    NSDictionary *options = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType};
    NSString *str=[NSString stringWithFormat:@"%@%@",@"<meta charset=\"UTF-8\" >",model.jobName];//:@"%@%@",@"<meta charset=\"UTF-8\">",model.content];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithData:[str dataUsingEncoding:NSUTF8StringEncoding]
                                                                                    options:options documentAttributes:nil error:nil];
   // CGSize size=[IHUtility GetSizeByText:attrString sizeOfFont:13 width:200];
    _tilteLbl.attributedText=attrString;
   
    
    
    NSString *text=[NSString stringWithFormat:@"%@-%@",model.firstJob,model.secondJob];
  CGSize  size=[IHUtility GetSizeByText:text sizeOfFont:11 width:200];
    _lbl.text=text;
    _lbl.size=CGSizeMake(size.width, 11);
    
    
    
}


@end

@implementation NewECloudConnectionSearchTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView  *lineView=[[UIView alloc]initWithFrame:CGRectMake(12, 39, WindowWith-24, 1)];
        lineView.backgroundColor=cLineColor;
        [self.contentView addSubview:lineView];
        
        self.imageView.image=Image(@"EP_search.png");
        
        self.imageView.origin=CGPointMake(lineView.left, 5);
        
        self.textLabel.frame=CGRectMake(self.imageView.right+15, self.imageView.top+2, WindowWith-self.imageView.right-30, 13);
        self.textLabel.font=sysFont(13);
        self.textLabel.textColor=cGrayLightColor;
    }
    
    return self;
}

-(void)setDataWith:(NSString *)text{
    self.textLabel.text=text;
}

@end




@implementation QuestionTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor=[UIColor whiteColor];
        UIView  *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 10)];
        lineView.backgroundColor=cLineColor;
        [self.contentView addSubview:lineView];
        
       
        UIAsyncImageView *headImageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(20, 30, 52, 52)];
        _headImageView=headImageView;
       
        [headImageView setLayerMasksCornerRadius:52/2 BorderWidth:1 borderColor:[UIColor whiteColor]];
        headImageView.image=defalutHeadImage;
        headImageView.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headTap)];
        [headImageView addGestureRecognizer:tap];

        
        
        
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(headImageView.right+10, headImageView.top+4, 60, 17) textColor:cBlackColor textFont:sysFont(15)];
        lbl.text=@"苏菲玛索";
        _nickName=lbl;
        [self.contentView addSubview:lbl];
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.right+8, lbl.top+2, 64, 13) textColor:cGrayLightColor textFont:sysFont(13)];
        lbl.text=@"|  销售达人";
        _titleLbl=lbl;
        [self.contentView addSubview:lbl];
        
        
        UIAsyncImageView *imageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(0, headImageView.centerY, WindowWith, 0.48*WindowWith)];
        imageView.image=DefaultImage_logo;
        _imageView=imageView;
        [self.contentView addSubview:imageView];
         [self.contentView addSubview:headImageView];
        
        
        
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(10,imageView.bottom+11,  WindowWith-20, 46) textColor:cBlackColor textFont:sysFont(16)];
        lbl.numberOfLines=2;
        _contentLbl=lbl;
        lbl.text=@"我是版主苏菲玛索，关于#苗木销售#的相关问题，问我吧！";
        [self.contentView addSubview:lbl];
        
        
        
        UIImage *img=Image(@"see.png");
        UIImageView  *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(lbl.left, lbl.bottom+10, img.size.width, img.size.height)];
        imageview.image=img;
        [self.contentView addSubview:imageview];
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageview.right+5, imageview.top, 50, 14) textColor:cBlackColor textFont:sysFont(14)];
        lbl.text=@"1356";
        _seeLbl=lbl;
        [self.contentView addSubview:lbl];
        
        
        
        
        img=Image(@"plnumber.png");
        imageview=[[UIImageView alloc]initWithFrame:CGRectMake(lbl.right+18, lbl.top, img.size.width, img.size.height)];
        imageview.image=img;
       
        [self.contentView addSubview:imageview];
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageview.right+5, imageview.top, 50, 14) textColor:cBlackColor textFont:sysFont(14)];
        lbl.text=@"656";
        _questionLbl=lbl;
        //_plLbl=lbl;
        [self.contentView addSubview:lbl];

        
        
       img=Image(@"redpoint.png");
  UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(headImageView.right, headImageView.top, img.size.width, img.size.height)];
        imgView.image=img;
        self.redImageView=imgView;
        imgView.hidden=YES;
        [self.contentView addSubview:imgView];
      
        
     //   lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(10, 10, bgView.width-20, bgView.height-20) textColor:[UIColor whiteColor] textFont:sysFont(20)];
      //  lbl.textAlignment=NSTextAlignmentCenter;
       // [lbl setLayerMasksCornerRadius:0 BorderWidth:1 borderColor:[UIColor whiteColor]];
        //lbl.text=@"＃苗木种植＃";
        //[bgView addSubview:lbl];
    
    }
    
    return self;
}


-(void)headTap{
    
    if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
        
        [self.delegate BCtableViewCell:self action:MTHeadViewActionTableViewCell indexPath:self.indexPath attribute:nil];
        
        
    }
    
    
}




-(void)setDataWithModel:(MyQuestionModel *)model i:(NSInteger)i{
    
     [_headImageView setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@%@",ConfigManager.ImageUrl,model.heed_image_url,smallHeaderImage] placeholderImage:defalutHeadImage];
    CGSize size=[IHUtility GetSizeByText:model.nickname sizeOfFont:15 width:150];
    
    _nickName.text=model.nickname;
    _nickName.size=CGSizeMake(size.width, 17);
    
    size=[IHUtility GetSizeByText:[NSString stringWithFormat:@"| %@",model.user_title] sizeOfFont:12 width:150];
    _titleLbl.text=[NSString stringWithFormat:@"| %@",model.user_title];
    _titleLbl.frame=CGRectMake(_nickName.right+8, _nickName.top+2, size.width+20, 12);
    
    [_imageView setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,model.show_pic] placeholderImage:DefaultImage_logo];
    
    size=[IHUtility GetSizeByText:model.view_num sizeOfFont:14 width:100];
    _seeLbl.text=model.view_num;
    _seeLbl.size=CGSizeMake(size.width, 14);
    
   
    
    size=[IHUtility GetSizeByText:model.question_num sizeOfFont:14 width:100];
    _questionLbl.text=model.question_num;
    _questionLbl.size=CGSizeMake(size.width, 14);
    
    
    NSDictionary *options = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType};
    NSString *str=[NSString stringWithFormat:@"%@%@",@"<meta charset=\"UTF-8\" >",model.Description];//:@"%@%@",@"<meta charset=\"UTF-8\">",model.content];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithData:[str dataUsingEncoding:NSUTF8StringEncoding]options:options documentAttributes:nil error:nil];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:4];//调整行间距
    [attrString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attrString length])];
    [attrString addAttribute:NSFontAttributeName value: boldFont(16) range:NSMakeRange(0,attrString.length)];
    
    _contentLbl.attributedText=attrString;
    
    if (i==1) {
        if ([model.user_id isEqualToString:USERMODEL.userID]) {
            self.redImageView.hidden=NO;
        }
        
    }
    
    
}

@end

@implementation AskBarContentCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *lineView = [UIView new];
        lineView.backgroundColor = cLineColor;
        [self.contentView addSubview:lineView];
        lineView.sd_layout.leftSpaceToView(self.contentView,0).topSpaceToView(self.contentView,0).widthIs(WindowWith).heightIs(10);
        
        AskBarContentView *contentView = [AskBarContentView new];
        contentView.selectBtnBlock = ^(NSInteger index){
            
            [self cellButtonAction:index];
        };
        _contentView = contentView;
        [self.contentView addSubview:contentView];
        contentView.sd_layout.leftSpaceToView(self.contentView,0).topSpaceToView(self.contentView,10).widthIs(WindowWith);
        
        [self setupAutoHeightWithBottomView:contentView bottomMargin:1];
    }
    
    return self;
}
- (void)cellButtonAction:(NSInteger)index
{
    if (index == agreeBlock) {
        if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
            [self.delegate BCtableViewCell:self action:MTAgreeActionTableViewCell indexPath:self.indexPath attribute:nil];
        }
    }else if (index == commentBlock){
        if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
            [self.delegate BCtableViewCell:self action:MTCommentActionTableViewCell indexPath:self.indexPath attribute:nil];
        }
    }else if (index == shareBlock){
        if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
            [self.delegate BCtableViewCell:self action:MTShareActionTableViewCell indexPath:self.indexPath attribute:nil];
        }
    }else if (index == SelectheadImageBlock){
        if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
            [self.delegate BCtableViewCell:self action:MTHeadViewActionTableViewCell indexPath:self.indexPath attribute:nil];
        }
    }else if (index == SelectTopViewBlock){
        if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
            [self.delegate BCtableViewCell:self action:MTHeadViewActionTableViewCell2 indexPath:self.indexPath attribute:nil];
        }
    }
    
}
- (void)setCellContent:(ReplyProblemListModel *)model
{
    [_contentView setData:model];
    [self setupAutoHeightWithBottomView:_contentView bottomMargin:1];
}
@end
@implementation QuestionCommentTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView  *lineView=[UIView new];
        lineView.backgroundColor=cLineColor;
        [self.contentView addSubview:lineView];
        lineView.sd_layout.leftSpaceToView(self.contentView,0).topSpaceToView(self.contentView,0).widthIs(WindowWith).heightIs(1);
        
        UIAsyncImageView *headImageView=[UIAsyncImageView new];
        [headImageView setLayerMasksCornerRadius:35/2 BorderWidth:0 borderColor:cGreenColor];
        headImageView.image=defalutHeadImage;
        headImageView.userInteractionEnabled = YES;
        _headImageView = headImageView;
        [self.contentView addSubview:headImageView];
        headImageView.sd_layout.leftSpaceToView(self.contentView,13).topSpaceToView(self.contentView,16).widthIs(35).heightIs(35);
        
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapHeardImg:)];
        tap1.numberOfTapsRequired = 1;
        tap1.numberOfTouchesRequired = 1;
        [headImageView addGestureRecognizer:tap1];
        
        SMLabel *lbl=[SMLabel new];
        lbl.text=@"拿破仑";
        lbl.textColor = cGrayLightColor;
        lbl.font = sysFont(12);
        _nameLbl = lbl;
        [self.contentView addSubview:lbl];
        lbl.sd_layout.leftSpaceToView(headImageView,10).topSpaceToView(self.contentView,19.5).heightIs(12);
        [lbl setSingleLineAutoResizeWithMaxWidth:200];
        
        
        lbl=[SMLabel new];
        lbl.numberOfLines=0;
        lbl.text=@"";
        lbl.textColor = cBlackColor;
        lbl.font = sysFont(13);
        _contentLbl = lbl;
        [self.contentView addSubview:lbl];
        
        _contentLbl.sd_layout.leftEqualToView(_nameLbl).topSpaceToView(_nameLbl,5).widthIs(WindowWith-48-40).autoHeightRatio(0);
        [_contentLbl setMaxNumberOfLinesToShow:0];
        
        
        lbl=[SMLabel new];
        lbl.textColor = cGrayLightColor;
        lbl.font = sysFont(10);
        lbl.text=@"北京市1天3小时前";
        _timeLbl = lbl;
        [self.contentView addSubview:lbl];
        _timeLbl.sd_layout.leftEqualToView(_contentLbl).topSpaceToView(_contentLbl,15).heightIs(10);
        [_timeLbl setSingleLineAutoResizeWithMaxWidth:150];
        
        UIImage *agreeImg=Image(@"GongQiuDetails_zan.png");
        UIImage *selectImg=Image(@"GongQiuDetails_iszan.png");
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setImage:[agreeImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [btn setImage:[selectImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
        [btn setImage:[selectImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
        btn.imageEdgeInsets=UIEdgeInsetsMake(0, -10, 0,0);
        [btn setTitleColor:cGrayLightColor forState:UIControlStateNormal];
        [btn setTitle:@"32" forState:UIControlStateNormal];
         [btn addTarget:self action:@selector(agree:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        btn.backgroundColor=RGB(246, 247, 249);
        btn.layer.cornerRadius=10;
        btn.titleLabel.font=sysFont(12);
        _btn= btn;
        
        _btn.sd_layout.rightSpaceToView(self.contentView,32.5).centerYEqualToView(_timeLbl).widthIs(60).heightIs(20);
        
        btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:cGrayLightColor forState:UIControlStateNormal];
        [btn setTitle:@"回复" forState:UIControlStateNormal];
         [btn addTarget:self action:@selector(agree:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        btn.backgroundColor=RGB(246, 247, 249);
        btn.layer.cornerRadius=10;
        btn.hidden = YES;
        btn.titleLabel.font=sysFont(12);
        _answerBtn= btn;
        _answerBtn.sd_layout.rightSpaceToView(self.contentView,32.5).centerYEqualToView(_timeLbl).widthIs(60).heightIs(20);
        
        btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:cGrayLightColor forState:UIControlStateNormal];
        [btn setTitle:@"忽略" forState:UIControlStateNormal];
         [btn addTarget:self action:@selector(agree:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        btn.backgroundColor=RGB(246, 247, 249);
        btn.layer.cornerRadius=10;
        btn.hidden = YES;
        btn.titleLabel.font=sysFont(12);
        _ignoreBtn= btn;
        
        _ignoreBtn.sd_layout.rightSpaceToView(_btn,12).centerYEqualToView(_timeLbl).widthIs(60).heightIs(20);
        
        [self setupAutoHeightWithBottomView:_btn bottomMargin:5];
        
        
    }
    
    return self;
}
- (void)TapHeardImg:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
        [self.delegate BCtableViewCell:self action:MTHeadViewActionTableViewCell indexPath:self.indexPath attribute:nil];
    }
    
}
- (void)agree:(UIButton *)button
{
    if (button == _btn) {
        if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
            [self.delegate BCtableViewCell:self action:MTFavriteActionTableViewCell indexPath:self.indexPath attribute:nil];
        }
    }else if (button == _answerBtn){
        if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
            [self.delegate BCtableViewCell:self action:MTActivityFollowBMTableViewCell indexPath:self.indexPath attribute:nil];
        }
    }else if (button == _ignoreBtn){
        if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
            [self.delegate BCtableViewCell:self action:MTDeleteActionTableViewCell indexPath:self.indexPath attribute:nil];
        }
    }
}
//评论列表
- (void)setDataWith:(AnswerCommentListModel *)model
{
    [_headImageView setImageAsyncWithURL:model.heed_image_url placeholderImage:defalutHeadImage];
    
    _nameLbl.text = model.nickname;
    [_nameLbl setSingleLineAutoResizeWithMaxWidth:200];
    
    _contentLbl.text = model.comment_content;
    _contentLbl.sd_layout.autoHeightRatio(0);
    [_contentLbl setMaxNumberOfLinesToShow:0];
    
    _timeLbl.text = [NSString stringWithFormat:@"%@%@",model.province,[IHUtility compareCurrentTimeString:model.create_time]];
    [_timeLbl setSingleLineAutoResizeWithMaxWidth:150];
    
    [_btn setTitle:stringFormatInt(model.clickNum) forState:UIControlStateNormal];
    if (model.isClick == 1) {
        _btn.selected = YES;
    }
    
//    [self setupAutoHeightWithBottomView:_btn bottomMargin:8];
}
//未回复的问题列表
-(void)setNoReplyData:(ReplyProblemListModel *)model
{
    [_headImageView setImageAsyncWithURL:model.heed_image_url placeholderImage:defalutHeadImage];
    
    _nameLbl.text = model.nickname;
    [_nameLbl setSingleLineAutoResizeWithMaxWidth:200];
    
    _contentLbl.text = model.title;
    _contentLbl.sd_layout.autoHeightRatio(0);
    [_contentLbl setMaxNumberOfLinesToShow:0];
    
    _timeLbl.text = [NSString stringWithFormat:@"%@%@",model.province,[IHUtility compareCurrentTimeString:model.create_time]];
    [_timeLbl setSingleLineAutoResizeWithMaxWidth:150];
    
//    [_btn setTitle:@"回复" forState:UIControlStateNormal];
    _btn.hidden = YES;
    _answerBtn.hidden = NO;
    _ignoreBtn.hidden = NO;
}
@end

@implementation MyReleaseSupplyOrBuyTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(buyType)type
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView  *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 5)];
        lineView.backgroundColor=cLineColor;
        [self.contentView addSubview:lineView];
        
        UIAsyncImageView *headImageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(13, 19, 35, 35)];
        [headImageView setLayerMasksCornerRadius:35/2 BorderWidth:0 borderColor:cGreenColor];
       // headImageView.image=defalutHeadImage;
        _headImageView=headImageView;
        [self.contentView addSubview:headImageView];
        
    
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(headImageView.right+10, headImageView.top+3.5, 36, 12) textColor:cGrayLightColor textFont:sysFont(12)];
        lbl.text=@"拿破仑";
        _nickName=lbl;
        [self.contentView addSubview:lbl];
        
        
        
        SMLabel *Lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(WindowWith-60, lbl.top, 30, 10) textColor:cGrayLightColor textFont:sysFont(10)];
        Lbl.text=@"08/21";
        _timeLbl=Lbl;
        [self.contentView addSubview:Lbl];
        
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.left-5, lbl.bottom+10, WindowWith-headImageView.right-40, 14) textColor:cBlackColor textFont:sysFont(14)];
        if (type==ENT_Supply) {
            lbl.text=@"【供应】南洋山";
        }else if(type==ENT_Buy){
            lbl.text=@"【求购】南洋山";
        }
       
        _titleLbl=lbl;
        [self.contentView addSubview:lbl];
        
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.left+5, lbl.bottom+10, WindowWith-headImageView.right-40, 13) textColor:cBlackColor textFont:sysFont(13)];
         lbl.text=@"#数量25株   #杆径20.0cm   #冠幅800.0cm   #…";
        _ganjingLbl=lbl;
        [self.contentView addSubview:lbl];
        
        
        lineView=[[UIView alloc]initWithFrame:CGRectMake(lbl.left, lbl.bottom+10, lbl.width, 1)];
        lineView.backgroundColor=cLineColor;
        _lineView=lineView;
        [self.contentView addSubview:lineView];
        
        
        EPImageView *epImageView=[[EPImageView alloc]initWithFrame:CGRectMake(lineView.left-10, lineView.bottom+10, lineView.width, (lineView.width+6)/3-6)];
        
        _epImageView=epImageView;
        [self addSubview:epImageView];
        
        
        
      
    
    }
    
    return self;
}


-(void)setDataWithMode:(MTSupplyAndBuyListModel *)model{
    
    [_headImageView setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@",model.userChildrenInfo.heed_image_url,smallHeaderImage] placeholderImage:defalutHeadImage];
    
    CGSize size=[IHUtility GetSizeByText:model.userChildrenInfo.nickname sizeOfFont:12 width:150];
    _nickName.text=model.userChildrenInfo.nickname;
    _nickName.size=CGSizeMake(size.width, 12);
    
    NSString *str=[IHUtility compareCurrentTimeString:model.uploadtime];
    _timeLbl.text=str;
    size=[IHUtility GetSizeByText:str sizeOfFont:10 width:100];
    _timeLbl.frame=CGRectMake(WindowWith-30-size.width, _nickName.top, size.width, 10);
    
     NSArray *Arr;
    if (model.supply_id) {
        NSString *supply=[NSString stringWithFormat:@"【供应】%@",model.varieties];
        _titleLbl.text=supply;
        Arr=[network getJsonForString:model.supply_url];
        
    }else{
        
        NSString *buy=[NSString stringWithFormat:@"【求购】%@",model.varieties];
        _titleLbl.text=buy;
        Arr=[network getJsonForString:model.want_buy_url];
    }
    
    NSArray *arr=[self getLabelViewList:model.rod_diameter crown_width_s:model.crown_width_s crown_width_e:model.crown_width_e height_s:model.height_s height_e:model.height_e branch_point:model.branch_point number:[model.number integerValue]];
    
    NSMutableString *s=[[NSMutableString alloc]initWithString:@""];
    if (arr.count!=0) {
        for (NSString *str in arr) {
           
            [s appendString:str];
            
        }

    }
    _ganjingLbl.text=s;
    
    if (Arr.count==0) {
        _epImageView.hidden = YES;
        _lineView.hidden=YES;
    }else{
        _epImageView.hidden = NO;
        [_epImageView setDataWith:Arr];
    }
    
    
    
    
    
    
    
    
}






-(NSMutableArray *)getLabelViewList:(CGFloat)rod_diameter
                      crown_width_s:(CGFloat)crown_width_s
                      crown_width_e:(CGFloat)crown_width_e
                           height_s:(CGFloat)height_s
                           height_e:(CGFloat)height_e
                       branch_point:(CGFloat)branch_point
                             number:(NSInteger)number
{
   
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    
    if (number>0) {
        NSString *str=[NSString stringWithFormat:@"#数量%ld株",number];
        [arr addObject:str];
    }
    
    if (rod_diameter>0) {
        NSString *str=[NSString stringWithFormat:@"#杆径%.1fcm",rod_diameter];
        [arr addObject:str];
    }
    if (crown_width_s>0 && crown_width_e>0) {
        NSString *str=[NSString stringWithFormat:@"#冠幅%.1f-%.1fcm",crown_width_s,crown_width_e];
        [arr addObject:str];
    }else if (crown_width_s>0 || crown_width_e>0){
        if (crown_width_s>0) {
            NSString *str=[NSString stringWithFormat:@"#冠幅%.1fcm",crown_width_s];
            [arr addObject:str];
        }else{
            NSString *str=[NSString stringWithFormat:@"#冠幅%.1fcm",crown_width_e];
            [arr addObject:str];
        }
        
        
    }
    
    if (height_s>0 && height_e>0) {
        NSString *str=[NSString stringWithFormat:@"#高度%.1f-%.1fcm",height_s,height_e];
        [arr addObject:str];
    }else if (height_s>0 || height_e>0){
        if (height_s>0) {
            NSString *str=[NSString stringWithFormat:@"#高度%.1fcm",height_s];
            [arr addObject:str];
        }else{
            NSString *str=[NSString stringWithFormat:@"#高度%.1fcm",height_e];
            [arr addObject:str];
        }
        
    }
    
    
    if (branch_point>0) {
        NSString *str=[NSString stringWithFormat:@"#分支点%.1fcm",branch_point];
        [arr addObject:str];
   
    }
  
    return arr;
}




@end




@implementation MyReleaseTopicTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView  *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 5)];
        lineView.backgroundColor=cLineColor;
        [self.contentView addSubview:lineView];
        
        UIAsyncImageView *headImageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(13, 19, 35, 35)];
        [headImageView setLayerMasksCornerRadius:35/2 BorderWidth:0 borderColor:cGreenColor];
        headImageView.image=defalutHeadImage;
        _headImageView=headImageView;
        [self.contentView addSubview:headImageView];
        
        
        
        
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(headImageView.right+10, headImageView.top+3.5, 36, 12) textColor:cGrayLightColor textFont:sysFont(12)];
        lbl.text=@"拿破仑";
        _nickName=lbl;
        [self.contentView addSubview:lbl];
        
        
        
        SMLabel *Lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(WindowWith-60, lbl.top, 30, 10) textColor:cGrayLightColor textFont:sysFont(10)];
        Lbl.text=@"08/21";
        _timeLbl=Lbl;
        [self.contentView addSubview:Lbl];
        
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.left, lbl.bottom+10, WindowWith-headImageView.right-40, 14) textColor:cBlackColor textFont:sysFont(14)];
        lbl.text=@"【大家对10月份这次政府出台的新规定有什么...";
        _titleLbl=lbl;
        [self.contentView addSubview:lbl];
        
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.left, lbl.bottom+10, WindowWith-headImageView.right-40, 13) textColor:cBlackColor textFont:sysFont(13)];
        lbl.text=@"政府出台新规，大规格乔木如何运输，森林城市...";
        _content=lbl;
        [self.contentView addSubview:lbl];
        
        
        lineView=[[UIView alloc]initWithFrame:CGRectMake(lbl.left, lbl.bottom+10, lbl.width, 1)];
        lineView.backgroundColor=cLineColor;
        _lineView=lineView;
        [self.contentView addSubview:lineView];
        
        
        EPImageView *epImageView=[[EPImageView alloc]initWithFrame:CGRectMake(lineView.left-10, lineView.bottom+10, lineView.width, (lineView.width+6)/3-6)];
        
        _epImageView=epImageView;
        [self addSubview:epImageView];
        
        
        
        
        
    }
    
    return self;
}

-(void)setDataWithModel:(MTTopicListModel *)model{
    
    [_headImageView setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@",model.userChildrenInfo.heed_image_url,smallHeaderImage] placeholderImage:defalutHeadImage];
    
    CGSize size=[IHUtility GetSizeByText:model.userChildrenInfo.nickname sizeOfFont:12 width:150];
    _nickName.text=model.userChildrenInfo.nickname;
    _nickName.size=CGSizeMake(size.width, 12);
    
    NSString *title1=@"";
    NSString *title2=@"";
    
     [_titleLbl setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
    
    if (model.topic_content.length>20) {
        title1=[model.topic_content substringToIndex:20];
        title2=[model.topic_content substringFromIndex:20];
        _titleLbl.text=title1;
        _content.text=title2;
        
    }else{
        _titleLbl.text=model.topic_content;
       
        _content.hidden=YES;
        
    }
    
    if (_content.hidden) {
        _lineView.origin=CGPointMake(_titleLbl.left, _titleLbl.bottom+10);
        _epImageView.origin=CGPointMake(_lineView.left-10, _lineView.bottom+10);
    }
    
    //_content.text=model.topic_content;
    
    NSString *str=[IHUtility compareCurrentTimeString:model.uploadtime];
    _timeLbl.text=str;
    size=[IHUtility GetSizeByText:str sizeOfFont:10 width:100];
    _timeLbl.frame=CGRectMake(WindowWith-30-size.width, _nickName.top, size.width, 10);
    
    NSArray *arr=[network getJsonForString:model.topic_url];
    if (arr.count!=0) {
        [_epImageView setDataWith:arr];
    }else{
        _lineView.hidden=YES;
    }
    
    
}




@end

@implementation MyReleaseQuestionTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView  *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 5)];
        lineView.backgroundColor=cLineColor;
        [self.contentView addSubview:lineView];
        
        UIImage *img=Image(@"My_Question.png");
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, 20, img.size.width, img.size.height)];
        imageView.image=img;
        _typeImageview=imageView;
        [self.contentView addSubview:imageView];
        
        
        
        
     SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+15, imageView.top+2, WindowWith-imageView.right-45, 16) textColor:cBlackColor textFont:sysFont(16)];
        lbl.text=@"我是版主苏菲玛索，关于#苗木销售#的...";
        _titleLbl=lbl;
        [self.contentView addSubview:lbl];

        lineView=[[UIView alloc]initWithFrame:CGRectMake(0, imageView.bottom+10, WindowWith, 1)];
        lineView.backgroundColor=cLineColor;
        [self.contentView addSubview:lineView];
        
        
        
        UIAsyncImageView *headImageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(13, lineView.bottom+14, 35, 35)];
        [headImageView setLayerMasksCornerRadius:35/2 BorderWidth:0 borderColor:cGreenColor];
        headImageView.image=defalutHeadImage;
        _headImageView=headImageView;
        headImageView.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headTap)];
        [headImageView addGestureRecognizer:tap];
        [self.contentView addSubview:headImageView];
        
        
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(headImageView.right+10, headImageView.top+3.5, 36, 12) textColor:cGrayLightColor textFont:sysFont(12)];
        lbl.text=@"拿破仑";
        _nickName=lbl;
        [self.contentView addSubview:lbl];
        
        
        
        SMLabel *Lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(WindowWith-60, lbl.top, 30, 10) textColor:cGrayLightColor textFont:sysFont(10)];
        Lbl.text=@"08/21";
        _timeLbl=Lbl;
        [self.contentView addSubview:Lbl];
        
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.left, lbl.bottom+10, WindowWith-headImageView.right-40, 38) textColor:cBlackColor textFont:sysFont(13)];
        lbl.text=@"爱上的黄金卡是伐啦还是地方都是开放和喀什活动就开始了发";
        _content=lbl;
        lbl.numberOfLines=0;
        [self.contentView addSubview:lbl];

        
        img=Image(@"delete1.png");
        imageView=[[UIImageView alloc]initWithFrame:CGRectMake(lbl.right-img.size.width, lbl.bottom+14, img.size.width, img.size.height)];
        imageView.image=img;
        _deleteImg=imageView;
        imageView.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap3=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(delete:)];
      
        [imageView addGestureRecognizer:tap3];
        [self.contentView addSubview:imageView];
        
        
        
        
        
        
        lineView=[[UIView alloc]initWithFrame:CGRectMake(0, lbl.bottom+13, WindowWith, 1)];
        lineView.backgroundColor=cLineColor;
        _lineView=lineView;
        lineView.hidden=YES;
        [self.contentView addSubview:lineView];

        
        
        
        UIAsyncImageView *headImageView2=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(13, lineView.bottom+15, 35, 35)];
        [headImageView2 setLayerMasksCornerRadius:35/2 BorderWidth:0 borderColor:cGreenColor];
        headImageView2.image=defalutHeadImage;
        _headImageView2=headImageView2;
        headImageView2.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headTap2)];
        headImageView2.hidden=YES;
        [headImageView2 addGestureRecognizer:tap2];
        [self.contentView addSubview:headImageView2];
        
        
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(headImageView2.right+10, headImageView2.top+3.5, 36, 12) textColor:cBlackColor textFont:sysFont(12)];
        lbl.text=@"拿破仑";
        _nickName2=lbl;
        lbl.hidden=YES;
        [self.contentView addSubview:lbl];
        
        
        
       Lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(WindowWith-60, lbl.top, 30, 10) textColor:cGrayLightColor textFont:sysFont(10)];
        Lbl.text=@"08/21";
        _timeLbl2=Lbl;
        Lbl.hidden=YES;
        [self.contentView addSubview:Lbl];
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.left, lbl.bottom+10, WindowWith-headImageView2.right-40, 38) textColor:cBlackColor textFont:sysFont(13)];
        lbl.text=@"爱上的黄金卡是伐啦还是地方都是开放和喀什活动就开始了发";
        _content2=lbl;
        lbl.numberOfLines=0;
        lbl.hidden=YES;
        [self.contentView addSubview:lbl];

        
        
        
    }
    
    return self;
}

-(void)headTap{
    
    if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
        [self.delegate BCtableViewCell:self action:MTHeadViewActionTableViewCell indexPath:self.indexPath attribute:nil];
    }

    
}

-(void)headTap2{
    
    if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
        [self.delegate BCtableViewCell:self action:MTHeadViewActionTableViewCell2 indexPath:self.indexPath attribute:nil];
    }
    
    
}

-(void)delete:(id)sender{
    
    if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
        [self.delegate BCtableViewCell:self action:MTDeleteActionTableViewCell indexPath:self.indexPath attribute:nil];
    }
 
}


-(void)setDataWithModel:(MyQuestionModel *)model{
    
   
    
    NSDictionary *options = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType};
    NSString *str=[NSString stringWithFormat:@"%@%@",@"<meta charset=\"UTF-8\" >",model.Description];//:@"%@%@",@"<meta charset=\"UTF-8\">",model.content];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithData:[str dataUsingEncoding:NSUTF8StringEncoding]
                                                                                    options:options documentAttributes:nil error:nil];
     [attrString addAttribute:NSFontAttributeName value: boldFont(16) range:NSMakeRange(0,attrString.length)];
    
    _titleLbl.attributedText=attrString;
    // [_titleLbl setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    [_headImageView setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@%@",ConfigManager.ImageUrl,model.heed_image_url,smallHeaderImage] placeholderImage:defalutHeadImage];
    
    CGSize size=[IHUtility GetSizeByText:model.nickname sizeOfFont:12 width:150];
    _nickName.text=model.nickname;
    _nickName.size=CGSizeMake(size.width, 14);
    
    str=[IHUtility compareCurrentTimeString:model.create_time];
    _timeLbl.text=str;
    size=[IHUtility GetSizeByText:str sizeOfFont:10 width:100];
    _timeLbl.frame=CGRectMake(WindowWith-30-size.width, _nickName.top, size.width, 10);
   
    _content.text=model.title;
    size=[IHUtility GetSizeByText:model.title sizeOfFont:13 width:WindowWith-_headImageView.right-40];
    _content.size=CGSizeMake(size.width, size.height);
   
    UIImage *img=Image(@"delete1.png");
    _deleteImg.origin=CGPointMake(WindowWith-40-img.size.width, _content.bottom+14);
  
    
    _lineView.origin=CGPointMake(0, _content.bottom+13);
    
    if ([model.answer_status intValue]==1) {
        _deleteImg.hidden=YES;
        _lineView.hidden=NO;
        _typeImageview.image=Image(@"My_Answer.png");
        _headImageView2.origin=CGPointMake(_headImageView.left, _lineView.bottom+15);
        _nickName2.origin=CGPointMake(_nickName.left, _headImageView2.top+3.5);
        _content2.origin=CGPointMake(_nickName2.left, _nickName2.bottom+10);
       // _timeLbl2.top=_nickName2.top;
        _headImageView2.hidden=NO;
        _nickName2.hidden=NO;
        _timeLbl2.hidden=NO;
        _content2.hidden=NO;
        [_headImageView2 setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@%@",ConfigManager.ImageUrl,model.answerInfo.heed_image_url,smallHeaderImage] placeholderImage:defalutHeadImage];
        
        
        str=[IHUtility compareCurrentTimeString:model.answerInfo.answer_time];
        _timeLbl2.text=str;
        size=[IHUtility GetSizeByText:str sizeOfFont:10 width:100];
        _timeLbl2.frame=CGRectMake(WindowWith-30-size.width, _nickName2.top, size.width, 10);
        
        NSString *name=model.answerInfo.nickname;
        NSString *leven=model.nickname;
        
        NSMutableAttributedString * attributedText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ 回复 %@",name,leven] attributes:@{NSFontAttributeName:sysFont(12)}];
        
        size=[IHUtility GetSizeByText:[attributedText string] sizeOfFont:12 width:1000];
        if (size.width>WindowWith-_headImageView2.right-_timeLbl2.width-40) {
            if (name.length >5) {
                name = [NSString stringWithFormat:@"%@...",[name substringToIndex:5]];
            }
            
            if (leven.length > 5) {
                leven = [NSString stringWithFormat:@"%@...",[leven substringToIndex:5]];
            }
        }
        
        attributedText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ 回复 %@",name,leven] attributes:@{NSFontAttributeName:sysFont(12)}];
        
        [attributedText addAttribute:NSForegroundColorAttributeName value:cGreenColor range:NSMakeRange(0,name.length)];
        
        [attributedText addAttribute:NSForegroundColorAttributeName value: cGrayLightColor range:NSMakeRange(name.length+3,leven.length+1)];
        
        _nickName2.attributedText=attributedText;
        size=[IHUtility GetSizeByText:[attributedText string] sizeOfFont:12 width:WindowWith-_headImageView2.right-_timeLbl2.width-10];
        _nickName2.size=CGSizeMake(size.width, 12);
        
        _content2.text=model.answerInfo.answer_content;
        size=[IHUtility GetSizeByText:model.answerInfo.answer_content sizeOfFont:13 width:WindowWith-_headImageView.right-40];
        _content2.size=CGSizeMake(size.width, size.height);
        
    }else{
        _headImageView2.hidden=YES;
        _nickName2.hidden=YES;
        _timeLbl2.hidden=YES;
        _content2.hidden=YES;
        _deleteImg.hidden=NO;
        _lineView.hidden=YES;
         _typeImageview.image=Image(@"My_Question.png");
    }
}

@end

@implementation NurseryTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      
        UIView  *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith-10, 10)];
        lineView.backgroundColor=RGB(247, 248, 250);
        [self.contentView addSubview:lineView];
        
        lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 10, 1, 100)];
        lineView.backgroundColor=cLineColor;
        _lineView1=lineView;
        [self.contentView addSubview:lineView];

        
        lineView=[[UIView alloc]initWithFrame:CGRectMake(WindowWith-10, 10, 1, 100)];
        lineView.backgroundColor=cLineColor;
        _lineView2=lineView;
        [self.contentView addSubview:lineView];
        
        lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith-10, 1)];
        lineView.backgroundColor=cLineColor;
        _lineView3=lineView;
        [self.contentView addSubview:lineView];

        
        
        
        EPImageView *epImageView=[[EPImageView alloc]initWithFrame:CGRectMake(2, lineView.bottom+12, WindowWith-14, (WindowWith-12*2-10+6)/3-6)];
        _epImageView=epImageView;
        [self.contentView addSubview:epImageView];
        
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(epImageView.left+10, epImageView.bottom+15, WindowWith-24, 14) textColor:cBlackColor textFont:sysFont(14)];
        lbl.text=@"红叶石楠";
        _titleLbl=lbl;
        [self.contentView addSubview:lbl];
        
        NurseryLabelView *lableView=[[NurseryLabelView alloc]initWithFrame:CGRectMake(12, lbl.bottom+15, WindowWith-24-10, 64)];
        _nueseryLableView=lableView;
        [self.contentView addSubview:lableView];
        
        
        
        lineView=[[UIView alloc]initWithFrame:CGRectMake(lbl.left, lableView.bottom+22, WindowWith-lbl.left*2, 1)];
        lineView.backgroundColor=RGB(247, 248, 250);
        _lineView=lineView;
        [self.contentView addSubview:lineView];
        
        
        UIImage *img=Image(@"Nursery_lianxiren.png");
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(lineView.left, lineView.bottom+11, img.size.width, img.size.height)];
        imageView.image=img;
        _personImageView=imageView;
        [self.contentView addSubview:imageView];
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+5, imageView.top+2, 84, 12) textColor:cBlackColor textFont:sysFont(12)];
        lbl.text=@"联系人：姜小文";
        _personLbl=lbl;
        [self.contentView addSubview:lbl];
        
        
        
        img=Image(@"Nurser_telphone.png");
        imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0.528*WindowWith, imageView.top, img.size.width, img.size.height)];
        imageView.image=img;
        _telphoneImageView=imageView;
        [self.contentView addSubview:imageView];
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+5, imageView.top+2, 115, 12) textColor:cBlackColor textFont:sysFont(12)];
        lbl.text=@"电话：13888888888";
        _telphoneLbl=lbl;
        [self.contentView addSubview:lbl];
       
        
        
        img=Image(@"Nursery_adress.png");
        imageView=[[UIImageView alloc]initWithFrame:CGRectMake(lineView.left+2, imageView.bottom+12, img.size.width, img.size.height)];
        imageView.image=img;
        _adressImageView=imageView;
        [self.contentView addSubview:imageView];
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+5, imageView.top+5, WindowWith-imageView.right-15, 12) textColor:cBlackColor textFont:sysFont(12)];
        lbl.text=@"苗源地址：湖南省长沙市岳麓区玉兰路988号";
        _adressLbl=lbl;
        [self.contentView addSubview:lbl];
        
        
       
        
        
        
        
    }
    
    return self;
}


-(void)setDataWithModel:(NurseryListModel *)model{
    NSArray *arr=[network getJsonForString:model.show_pic];
    [_epImageView setDataWith:arr];
    _titleLbl.text=model.plant_name;
    NSMutableArray *Arr=[[NSMutableArray alloc]init];
    if (model.loading_price.length>0) {
        [Arr addObject:[NSString stringWithFormat:@"装车价: ￥%@",model.loading_price]];
    }
    if (model.num.length>0) {
        [Arr addObject:[NSString stringWithFormat:@"数量: %@%@",model.num,model.unit]];
    }
    if (model.heignt.length>0) {
        [Arr addObject:[NSString stringWithFormat:@"高度: %@cm",model.heignt]];
    }
    
    
    if (model.crown.length>0) {
        [Arr addObject:[NSString stringWithFormat:@"冠幅: %@cm",model.crown]];
    }
    if (model.diameter.length>0) {
        [Arr addObject:[NSString stringWithFormat:@"胸径: %@cm",model.diameter]];
    }
    if (model.branch_point.length>0) {
        [Arr addObject:[NSString stringWithFormat:@"分枝点: %@cm",model.branch_point]];
    }
 
    CGFloat y=[_nueseryLableView setDataWithArr:Arr];
    _nueseryLableView.top=_titleLbl.bottom+15;
    _lineView.top=_titleLbl.bottom+15+y+22;
    
    _personImageView.top=_lineView.bottom+11;
    
    CGSize size=[IHUtility GetSizeByText:[NSString stringWithFormat:@"联系人：%@",model.nickname] sizeOfFont:12 width:0.35*WindowWith];
    _personLbl.size=CGSizeMake(size.width, 12);
    _personLbl.text=[NSString stringWithFormat:@"联系人：%@",model.nickname];
    _personLbl.top=_personImageView.top+2;
    
    
    _telphoneImageView.top=_personImageView.top;
    _telphoneLbl.top=_telphoneImageView.top+2;
    size=[IHUtility GetSizeByText:[NSString stringWithFormat:@"电话：%@",model.mobile] sizeOfFont:12 width:0.35*WindowWith];
    _telphoneLbl.text=[NSString stringWithFormat:@"电话：%@",model.mobile];
    _telphoneLbl.size=CGSizeMake(size.width, 12);
    
    
    _adressImageView.top=_personImageView.bottom+12;
    _adressLbl.top=_adressImageView.top+5;
   //  size=[IHUtility GetSizeByText:[NSString stringWithFormat:@"苗源地址：%@",model.nursery_address] sizeOfFont:12 width:0.8*WindowWith];
    _adressLbl.text=[NSString stringWithFormat:@"苗源地址：%@",model.nursery_address];
   // _adressLbl.size=CGSizeMake(size.width, 12);
    
    _lineView1.height=[model.cellHeigh doubleValue]-10;
    
    _lineView2.height=[model.cellHeigh doubleValue]-10;
    
    _lineView3.top=[model.cellHeigh doubleValue]-1;
}




@end



@implementation MyNerseryTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView  *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 5)];
        lineView.backgroundColor=RGB(247, 248, 250);
        [self.contentView addSubview:lineView];
        
     
        UIAsyncImageView *imageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(12, 12+5, 65, 65)];
        imageView.image=DefaultImage_logo;
        _imageView=imageView;
        [self.contentView addSubview:imageView];
        
        
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(12+imageView.right, imageView.top, 56, 14) textColor:cBlackColor textFont:sysFont(14)];
        lbl.text=@"红叶石楠";
        _nameLbl=lbl;
        [self.contentView addSubview:lbl];
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.right+5, 19, 48, 12) textColor:cBlackColor textFont:sysFont(12)];
        lbl.text=@"（株洲）";
        _addressLbl=lbl;
        [self.contentView addSubview:lbl];
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, 12, WindowWith-15, 13) textColor:RGB(245, 168, 68) textFont:sysFont(13)];
        lbl.text=@"待审核";
        lbl.centerY=_addressLbl.centerY;
        _statusLbl=lbl;
        lbl.textAlignment=NSTextAlignmentRight;
        [self.contentView addSubview:lbl];
        
        
        
      
 
        
     
        
        
       
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+12.5, _nameLbl.bottom+15, 150, 14) textColor:cBlackColor textFont:sysFont(12)];
        lbl.text=@"装车价：￥40";
        _PriceLbl=lbl;
        [self.contentView addSubview:lbl];

        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.right+12.5, _nameLbl.bottom+15, 150, 14) textColor:cBlackColor textFont:sysFont(12)];
        lbl.text=@"数量：10000株";
        lbl.bottom=imageView.bottom;
        _numLbl=lbl;
        [self.contentView addSubview:lbl];
        
        
        
        UIImage *img=Image(@"delete1.png");
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
        btn.frame=CGRectMake(WindowWith-10-10-img.size.width, lbl.bottom-img.size.height-5,img.size.width , img.size.height);
        [btn addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        
        lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 5, 1, 90)];
        lineView.backgroundColor=cLineColor;
       
        [self.contentView addSubview:lineView];
        
        
        lineView=[[UIView alloc]initWithFrame:CGRectMake(WindowWith-10, 5, 1, 90)];
        lineView.backgroundColor=cLineColor;
        
        [self.contentView addSubview:lineView];
        
        lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 94, WindowWith-10, 1)];
        lineView.backgroundColor=cLineColor;
       
        [self.contentView addSubview:lineView];
        

        
        
      
    }
    
    return self;
}

-(void)delete{
    if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
        [self.delegate BCtableViewCell:self action:MTDeleteActionTableViewCell indexPath:self.indexPath attribute:nil];
    }

}

-(void)setDataWithModel:(MyNerseryModel *)model{
    CGSize size=[IHUtility GetSizeByText:model.plant_name sizeOfFont:14 width:150];
    _nameLbl.text=model.plant_name;
    _nameLbl.size=CGSizeMake(size.width, 20);
    
    size=[IHUtility GetSizeByText:[NSString stringWithFormat:@"（%@）",model.location] sizeOfFont:12 width:150];
    _addressLbl.text=[NSString stringWithFormat:@"（%@）",model.location];
    _addressLbl.frame=CGRectMake(_nameLbl.right+5, 18, size.width, 16);
    
  
        NSString * str=[IHUtility compareCurrentTimeString:model.create_time];
        
        size=[IHUtility GetSizeByText:str sizeOfFont:10 width:150];
        _statusLbl.text=str;
        _statusLbl.font=sysFont(10);
        //_statusLbl.size=CGSizeMake(size.width, 13);
        _statusLbl.textColor=cGrayLightColor;
        
    
   NSArray *arr=[network getJsonForString:model.show_pic];
    if (arr.count>0) {
        
        MTPhotosModel *Model=[[MTPhotosModel alloc]initWithDic:arr[0]];
         [_imageView setImageAsyncWithURL:Model.thumbUrl placeholderImage:DefaultImage_logo];
    }
    
    
   
    _PriceLbl.text=[NSString stringWithFormat:@"装车价：￥%@",model.loading_price];
    
    _numLbl.text=[NSString stringWithFormat:@"数量：%ld%@",model.num,model.unit];
    
    
}


@end

@implementation NewsSearchTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        
       
        
        self.textLabel.frame=CGRectMake(12, 14, WindowWith-24, 14);
        self.textLabel.font=sysFont(14);
        self.textLabel.numberOfLines=0;
        self.textLabel.textColor=cBlackColor;
        
        UIView  *lineView=[[UIView alloc]initWithFrame:CGRectMake(12, self.textLabel.bottom+13, WindowWith-12, 1)];
        lineView.backgroundColor=cLineColor;
        _lineView=lineView;
        [self.contentView addSubview:lineView];
   
    
    }
    
    return self;
}
-(void)setDataWith:(NSString *)htmlText{
    
    NSDictionary *options = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType};
    NSString *str=[NSString stringWithFormat:@"%@%@",@"<meta charset=\"UTF-8\" >",htmlText];//:@"%@%@",@"<meta charset=\"UTF-8\">",model.content];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithData:[str dataUsingEncoding:NSUTF8StringEncoding]
                                                                                    options:options documentAttributes:nil error:nil];
    self.textLabel.attributedText = attrString;
    CGSize size=[IHUtility GetSizeByText:[attrString string] sizeOfFont:14 width:WindowWith-24];
    self.textLabel.size=CGSizeMake(size.width, size.height);
    self.textLabel.font = sysFont(14);

    _lineView.origin=CGPointMake(12, self.textLabel.bottom+13);
    
}


@end

@implementation ScoreTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        UIView  *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 10)];
        lineView.backgroundColor=RGB(247, 248, 250);
        [self.contentView addSubview:lineView];
        
        lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 10, 10, 0.4*WindowWith)];
        lineView.backgroundColor=RGB(247, 248, 250);
        [self.contentView addSubview:lineView];
        
        lineView=[[UIView alloc]initWithFrame:CGRectMake(WindowWith-10, 10, 10, 0.4*WindowWith)];
        lineView.backgroundColor=RGB(247, 248, 250);
        [self.contentView addSubview:lineView];
        
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10,10 , WindowWith-20, 0.4*WindowWith)];
        imageView.image=Image(@"Score_bg.png");
        imageView.userInteractionEnabled=YES;
        [self.contentView addSubview:imageView];
        
        
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0.36*imageView.width, 0.053*WindowWith, imageView.width-0.36*imageView.width, 21) textColor:[UIColor whiteColor] textFont:sysFont(19)];
        lbl.text=@"24小时个人推荐券";
        _nameLbl=lbl;
        [imageView addSubview:lbl];
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.left, lbl.bottom+0.0106*WindowWith, lbl.width, 13) textColor:[UIColor whiteColor] textFont:sysFont(11)];
        lbl.text=@". 个人头像推荐至首页";
        _lbl1=lbl;
        [imageView addSubview:lbl];
        
       
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.left, lbl.bottom+0.0106*WindowWith, lbl.width, 13) textColor:[UIColor whiteColor] textFont:sysFont(11)];
        lbl.text=@". 限当前登录账号使用";
        _lbl2=lbl;
        [imageView addSubview:lbl];
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.left, lbl.bottom+0.0106*WindowWith, lbl.width, 13) textColor:[UIColor whiteColor] textFont:sysFont(11)];
        lbl.text=@". 兑换即生效，有效期为24小时";
        _lbl3=lbl;
        [imageView addSubview:lbl];
        
        
      
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0.06*WindowWith, imageView.height-0.032*WindowWith-12, 200, 12) textColor:cGrayLightColor textFont:sysFont(12)];
        lbl.text=@"消耗：388 积分";
        _couponLbl=lbl;
        [imageView addSubview:lbl];

        
//        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imageView.width-15-36, lbl.top, 36, 12) textColor:cGrayLightColor textFont:sysFont(12)];
//        lbl.text=@"使用中";
//        [imageView addSubview:lbl];

        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(imageView.width-100, 0, 80, 25);
        btn.centerY=lbl.centerY;
        //[btn setLayerMasksCornerRadius:5 BorderWidth:0.5 borderColor:cGreenColor];
        [btn setTitle:@"立即抢购" forState:UIControlStateNormal];
        [btn setTitleColor:cGreenColor forState:UIControlStateNormal];
        btn.titleLabel.font=sysFont(12);
        [imageView addSubview:btn];
        _btn=btn;
        [btn addTarget:self action:@selector(dianji2) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    
    return self;
}

-(void)dianji2{
    
    if ([self.delegate respondsToSelector:@selector(BCtableViewCell:action:indexPath:attribute:)]) {
        [self.delegate BCtableViewCell:self action:MTQiangDanActionTableViewCell indexPath:self.indexPath attribute:nil];
    }

    
}
-(void)setDataWithModel:(CouponListModel *)model{
    _nameLbl.text=model.name;
    if ([model.type isEqualToString:@"1"]) {
        _lbl1.text=@".个人头像推荐至首页";
       
    }else{
       
        _lbl1.text=@".将您的企业显示在首页";
        
        
    }
    _lbl2.text=@".限当前登录账号使用";
    _lbl3.text=[NSString stringWithFormat:@".兑换即生效，有效期为%@小时",model.couponHour];
    
    NSString *amount=model.amount;
    if (model.couponStatus==false) {
       
        
          NSMutableAttributedString * attributedText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"消耗：%@ 积分",amount] attributes:@{NSFontAttributeName:sysFont(12)}];
         [attributedText addAttribute:NSForegroundColorAttributeName value:cGreenColor range:NSMakeRange(3,amount.length)];
        _couponLbl.attributedText=attributedText;
        [_btn setTitle:@"即将开抢" forState:UIControlStateNormal];
        _btn.enabled=NO;
         [_btn setTitleColor:cGreenColor forState:UIControlStateNormal];
        [_btn setLayerMasksCornerRadius:5 BorderWidth:0.5 borderColor:cGreenColor];
        
    }else if (model.couponStatus==true){
    
        if ([model.userStatus isEqualToString:@"0"]) {
            
            if ([model.buyStatus isEqualToString:@"0"]) {
                
                _couponLbl.text=[NSString stringWithFormat:@"消耗：%@ 积分",model.amount];
                [_btn setTitle:@"已抢光" forState:UIControlStateNormal];
                [_btn setTitleColor:cGrayLightColor forState:UIControlStateNormal];
                 [_btn setLayerMasksCornerRadius:5 BorderWidth:0.5 borderColor:[UIColor clearColor]];
                _btn.enabled=NO;
                
            }else{
                
                
                NSMutableAttributedString * attributedText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"消耗：%@ 积分",amount] attributes:@{NSFontAttributeName:sysFont(12)}];
                [attributedText addAttribute:NSForegroundColorAttributeName value:cGreenColor range:NSMakeRange(3,amount.length)];
                _couponLbl.attributedText=attributedText;
                
                [_btn setTitle:@"立即兑换" forState:UIControlStateNormal];
                [_btn setLayerMasksCornerRadius:5 BorderWidth:0.5 borderColor:cGreenColor];
                 [_btn setTitleColor:cGreenColor forState:UIControlStateNormal];
                
                
            }
            
            
        }else{
           
             _couponLbl.text=[NSString stringWithFormat:@"消耗：%@ 积分",model.amount];
            [_btn setTitle:@"使用中" forState:UIControlStateNormal];
            [_btn setTitleColor:cGrayLightColor forState:UIControlStateNormal];
             [_btn setLayerMasksCornerRadius:5 BorderWidth:0.5 borderColor:[UIColor clearColor]];
            _btn.enabled=NO;
            
            
            
        }
        
    
    }
    
}




@end


@implementation NerseryLeftTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor=RGB(243, 243, 243);
       
        UIView  *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, (WindowHeight-40)/6)];
        lineView.backgroundColor=RGB(243, 243, 243);
        _lineView=lineView;
        [self.contentView addSubview:lineView];
     
        
        
        self.textLabel.center=self.contentView.center;
    
        self.textLabel.font=sysFont(14);
        self.textLabel.textColor=cBlackColor;
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        [self.contentView addGestureRecognizer:tap];
        
    }
    
    return self;
}

-(void)tapClick:(UITapGestureRecognizer *)tap{
    
    [self.delegate BCtableViewCell:self action:MYActionMiaoMuYunSelectCell indexPath:self.indexPath attribute:nil];
    
}

-(void)setDataWithText:(NSString *)text{
    CGSize size=[IHUtility GetSizeByText:text sizeOfFont:14 width:WindowWith*0.14];
    self.textLabel.text=text;
    self.textLabel.numberOfLines=0;
    self.textLabel.size=CGSizeMake(size.width, size.height);
    self.textLabel.center=self.contentView.center;
    
}



-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    
    if (selected) {
        self.backgroundColor=[UIColor whiteColor];
        _lineView.backgroundColor=cGreenColor;
         self.textLabel.textColor=cGreenColor;
    }else{
        self.backgroundColor=RGB(243, 243, 243);
        _lineView.backgroundColor=RGB(243, 243, 243);
         self.textLabel.textColor=cBlackColor;
    }
   
    
    
    
}



@end


@implementation RecommendGroupTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(11, 15, 40, 40)];
        imgView.image=Image(@"Group_head.png");
        [imgView setLayerMasksCornerRadius:20 BorderWidth:0 borderColor:[UIColor clearColor]];
        [self.contentView addSubview:imgView];
        
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(imgView.right+12, 16, WindowWith-109-6-imgView.right, 16) textColor:RGB(6, 193, 174) textFont:sysFont(17)];
        lbl.text=@"湖南苗圃基地交流群";
        _namelbl=lbl;
        [self.contentView addSubview:lbl];
        
       
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *img=Image(@"Group_people.png");
        [btn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
        [btn setTitle:@"当前50人，可容纳2000人" forState:UIControlStateNormal];
        [btn setTitleColor:cBlackColor forState:UIControlStateNormal];
        btn.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
        btn.titleLabel.font=sysFont(15);
        btn.frame=CGRectMake(lbl.left, lbl.bottom+7, 180, img.size.height);
        _btn=btn;
        [self.contentView addSubview:btn];
        
        
        
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(btn.left, btn.bottom+8, WindowWith-btn.left-12, 74)];
        view.backgroundColor=RGB(248, 248, 248);
        _view=view;
        [self.contentView addSubview:view];
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(8, 8, 70, 16) textColor:cBlackColor textFont:sysFont(15)];
        lbl.text=@"群公告：";
        [view addSubview:lbl];
        
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.left, lbl.bottom+4, view.width-lbl.left*2, 15) textColor:RGB(135, 134, 140) textFont:sysFont(13)];
        lbl.text=@"只有湖南人苗圃专业人士才能加入";
        lbl.numberOfLines=0;
        _desclbl=lbl;
        [view addSubview:lbl];
        
        UIButton *applyBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        applyBtn.frame=CGRectMake(WindowWith - 80 - 10, 12, 80, 25);
        [applyBtn setLayerMasksCornerRadius:12 BorderWidth:1 borderColor:RGB(232, 121, 117)];
        [applyBtn setTitle:@"+ 申请加入" forState:UIControlStateNormal];
        applyBtn.titleLabel.font = sysFont(14);
        _applyBtn = applyBtn;
        [applyBtn setTitleColor:RGB(232, 121, 117) forState:UIControlStateNormal];
        [applyBtn addTarget:self action:@selector(applyClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:applyBtn];
        
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(lbl.left, 69, WindowWith, 1)];
        lineView.backgroundColor=cLineColor;
        _lineView=lineView;
        [self.contentView addSubview:lineView];
    }
    
    return self;
}

-(void)applyClick:(UIButton *)sender{
    [self.delegate BCtableViewCell:self action:MTActionApplyChatGroupTableViewCell indexPath:self.indexPath attribute:nil];
}

-(CGFloat)setData:(NSDictionary *)dic{
    
    NSArray *arr=[IHUtility getUserdefalutsList:USERMODEL.userID];
    for (NSDictionary *Dic in arr) {
        
      //  if ([dic[@"group_id"] isEqualToString:Dic.allKeys[0]]) {
            
        //}
        if ([Dic[dic[@"group_id"]][@"ifJion"] isEqualToString:@"Yes"]) {
            _applyBtn.hidden=YES;
        }
        
    }
     UIImage *img=Image(@"Group_people.png");
    NSInteger affiliations_count=[dic[@"affiliations_count"] intValue];
    NSInteger maxusers=[dic[@"maxusers"] intValue];
    
    [_btn setTitle:[NSString stringWithFormat:@"当前%ld人，可容纳%ld人",affiliations_count ,maxusers] forState:UIControlStateNormal];
    CGSize size=[IHUtility GetSizeByText:[NSString stringWithFormat:@"当前%ld人，可容纳%ld人",affiliations_count ,maxusers] sizeOfFont:15 width:200];
    _btn.size=CGSizeMake(size.width+img.size.width+5, img.size.height);
    
    
    _namelbl.text=[dic objectForKey:@"group_name"];
    _desclbl.text=[dic objectForKey:@"description"];
    
    size=[IHUtility GetSizeByText:[dic objectForKey:@"description"] sizeOfFont:13 width:_view.width-16];
    _desclbl.size=CGSizeMake(size.width, size.height);
    
    _view.height=_desclbl.bottom+12;
    
    _lineView.frame=CGRectMake(11, _view.bottom+9, WindowWith-11, 1);
    
    CGFloat height=_lineView.bottom;
    return height;
    
}

@end



