//
//  CustomView+CustomCategory3.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/7/28.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "CustomView.h"
#import "SDWeiXinPhotoContainerView.h"

@interface CustomView (CustomCategory3)

@end



@interface MTSupplyAndBuyDetailsImageView : CustomView
{
//    UIAsyncImageView *_lastImg;
    SDWeiXinPhotoContainerView *_picContainerView;
}
-(void)setData:(NSArray *)arr;
-(CGFloat)returnImagesHightWithArr:(NSArray *)arr;
@end



@interface EPCloudScrollView : CustomView
-(void)setDataWithModel:(NSArray *)arr;
@end



@interface CrowdFundingTopView : CustomView<UITextViewDelegate>
{
    UIView *_progressView;
//    UIView *_view;
    UIAsyncImageView *_headImageView;
    SMLabel *_titleLbl;
    SMLabel *_timeLbl;
    SMLabel *_progressLbl;
    SMLabel *_priceLbl;
    UIImageView *_typeImageView;
    SMLabel *_nickName;
    SMLabel *_chajiaLbl;
    SMLabel *_jiezhiLbl;
    UIAsyncImageView *_ImageView;
//    SMLabel *_bottomLbl;
    UIButton *_editBtn;
  
}
-(void)setDatawith:(CrowdOrderModel *)model;
@property (nonatomic,copy) DidSelectBtnBlock selectBlock;
@property(nonatomic,strong)PlaceholderTextView *placeholderTextView;
@end

@interface ApliayView : CustomView 
@property (nonatomic,copy) DidSelectBtnBlock  selectBlock;

- (void) setPlayMoneyNum:(NSString *)titleStr;


- (id)initWithFrame:(CGRect)frame;
@end

@interface CrowdFundingShareView : CustomView<UITextViewDelegate>
{
      PlaceholderTextView *_placeholderTextView;
//    UIView *_bkView;
//    UIAsyncImageView *_imageView;
//    SMLabel *_lbl;
}
-(void)show;
@end

@interface JionCompanyCloud : CustomView
- (id)initWithFrame:(CGRect)frame;
@property (nonatomic,copy) DidSelectBtnBlock selectBlock;
@end

@interface BombBoxView : CustomView
@property (nonatomic,copy) DidSelectBtnBlock selectBlock;

//有按钮弹框
-(id)initWithFrame:(CGRect)frame context:(NSString *)context title:(NSString *)title buttonArr:(NSArray *)buttonArr;

//没有按钮弹框
-(id)initWithFrame:(CGRect)frame context:(NSString *)context title:(NSString *)title;
@end

@interface EmptyPromptView : CustomView {
    UIImageView *_imageView;
}
@property (nonatomic, copy) NSString *imagNameStr;
- (id)initWithFrame:(CGRect)frame context:(NSString *)context;
@end


@interface CertificationNoticeView : CustomView
- (id)initWithFrame:(CGRect)frame title:(NSString *)title imageName:(NSString *)imageName content:(NSString *)content;
@end

@class PositionListModel;
@interface PositionRequirementView : CustomView
{
    SMLabel *_positionLbl;
    SMLabel *_salayLbl;
    SMLabel *_adressLbl;
    SMLabel *_expLbl;
    SMLabel *_studyLbl;
    SMLabel *_companyLbl;
    SMLabel *_infoLbl;
    
    UIAsyncImageView *_heardImg;
    UIImageView *_adressImageV;
    UIImageView *_JYImageV;
    UIImageView *_XLImageV;

}
@property (nonatomic,copy) DidSelectBtnBlock selectBlock;
@property (nonatomic,strong)UIButton *button;

- (void)setCellDate:(PositionListModel *)model;
@end

@class jianliModel;
@interface CurriculumVitaeView : CustomView
{
    SMLabel *_positionLbl;
    SMLabel *_nickLbl;
    SMLabel *_statusLbl;
    UIButton *_adressBtn;
    UIButton *_experienceBtn;
    UIButton *_academicBtn;
    UIAsyncImageView *_headImageView;
    SMLabel *_salaryLbl;
    SMLabel *_youshiLbl;
}
-(CGFloat)setDataWithModel:(jianliModel *)model;
@end

@interface ContentView : CustomView
{
    CGSize _size;
    SMLabel *_lbl;
    UIView *_lineView;
    UIButton *_btn;
   
    
    
    
}
@property (nonatomic,copy) DidSelectBtnBlock selectBlock;
- (id)initWithFrame:(CGRect)frame title:(NSString *)title content:(NSString *)content btnHidden:(BOOL)btnHidden;
@end

@interface SelectedView : CustomView
@property (nonatomic,copy) DidSelectBtnBlock selectBlock;
@property (nonatomic,strong)UIImageView *imageView;

- (id)initWithFrame:(CGRect)frame array:(NSArray *)array imageArr:(NSArray *)imageArr rectY:(CGFloat)y rectX:(CGFloat)x width:(CGFloat)width;
@end

//按钮排版试图
@interface ButtonTypesetView : CustomView

@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,copy) DidSelectBtnBlock selectBlock;

- (id)initWithFrame:(CGRect)frame dataArr:(NSArray *)dataArr title:(NSString *)title;

@end



@interface NurseryLabelView : CustomView//苗木云列表lblView
-(CGFloat)setDataWithArr:(NSArray *)arr;
@end


#import "NSDate+WQCalendarLogic.h"
@interface WeatherCellView : CustomView
{
    SMLabel *_lbl;
    SMLabel *_timelbl;//日期
    UIAsyncImageView *_weatherImg;
    SMLabel *_weatherlbl;
    SMLabel *_templbl;
    
    
}
- (void)setData:(NSDictionary *)dic;
@end








