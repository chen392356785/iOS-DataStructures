//
//  MTTableViewCell+MTTableViewCell2.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/9/12.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTTableViewCell.h"
@class EPImageView;

//#import "CustomView+CustomCategory2.h"

@interface MTTableViewCell (MTTableViewCell2)

@end



@interface MTZhaoPingTableViewCell : MTTableViewCell//招聘
{
    UIView *_bgView;
    CurriculumVitaeView *_view;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(MyJobType)type;
@property(nonatomic,assign)MyJobType Mytype;
-(void)setDataWithModel:(jianliModel *)model;
@end


@class PositionListModel;
@interface MTJobWantedTableViewCell : MTTableViewCell
{
    SMLabel *_positionLbl;
    SMLabel *_salayLbl;
    SMLabel *_adressLbl;
    SMLabel *_expLbl;
    SMLabel *_studyLbl;
    SMLabel *_companyLbl;
    SMLabel *_infoLbl;
    SMLabel *_timeLbl;
    
    UIAsyncImageView *_heardImg;
    UIImageView *_adressImageV;
    UIImageView *_JYImageV;
    UIImageView *_XLImageV;
    
}
- (void)setCellDate:(PositionListModel *)model type:(CollecgtionType)type;

@end



@class RecruitEdusModel;
@class RecruitWorksModel;
@interface CurriculumVitaeTableViewCell : MTTableViewCell//简历详情(工作经历 教育经历)
{
    SMLabel *_positionLbl;
    SMLabel *_companyLbl;
    SMLabel *_timeLbl;
    SMLabel *_contentLbl;
     UIView *_bgView;
}
-(void)setDataModel2:(RecruitWorksModel *)model;
-(void)setDataWithModel:(RecruitEdusModel *)model;
@end


@interface CurriculumVitaeTableViewCell2 : MTTableViewCell//简历详情(工作经历 教育经历)
{
    SMLabel *_lbl;
    UIView *_bgView;
}
-(void)setDataWith:(NSString *)text;
@end

@class ReleasePositionModel;
@interface MyPositionTableViewCell : MTTableViewCell //我发布的职位
{
     SMLabel *_positionLbl;
     SMLabel *_salayLbl;
    UIButton *_adressBtn;
    UIButton *_experienceBtn;
    UIButton *_academicBtn;
    
    
}
@property(nonatomic,strong)SMLabel *lbl;
-(void)setDataWithModel:(ReleasePositionModel *)model;
@end



@interface ChoosePositionTableViewCell : MTTableViewCell//选择职位
{
    SMLabel *_tilteLbl;
    SMLabel *_lbl;
    ChoosePositionView *_view;
    
}
-(void)setDataWith:(NSDictionary *)dic;

@end


@class SearchJobNameModel;
@interface SearchPositionTableViewCell : MTTableViewCell//搜索职位
{
    SMLabel *_tilteLbl;
    SMLabel *_lbl;
    
    
}
-(void)setDataWith:(SearchJobNameModel *)model;
@end



@interface NewECloudConnectionSearchTableViewCell : MTTableViewCell//搜索历史
-(void)setDataWith:(NSString *)text;
@end

@class MyQuestionModel;
@interface QuestionTableViewCell : MTTableViewCell//问吧cell
{
    UIAsyncImageView *_headImageView;
    SMLabel *_nickName;
    SMLabel *_titleLbl;
    SMLabel *_contentLbl;
    UIAsyncImageView *_imageView;
    SMLabel *_seeLbl;
    SMLabel *_questionLbl;
    UIAsyncImageView *_bgView;
    UIImageView *_image;
}
-(void)setDataWithModel:(MyQuestionModel *)model i:(NSInteger)i;
@property(nonatomic,strong)UIImageView *redImageView;
@end

//问吧详情cell
@class AskBarContentView;
@interface AskBarContentCell : MTTableViewCell
{
    
    AskBarContentView *_contentView;
}
- (void)setCellContent:(ReplyProblemListModel *)model;
@end


@interface QuestionCommentTableViewCell : MTTableViewCell//问吧评论cell
{
    UIAsyncImageView *_headImageView;
    SMLabel *_nameLbl;
    SMLabel *_contentLbl;
    SMLabel *_timeLbl;
    UIButton *_btn;
    UIButton *_ignoreBtn;
    UIButton *_answerBtn;
}
//评论列表
- (void)setDataWith:(AnswerCommentListModel *)model;
//未回复的问题列表
-(void)setNoReplyData:(ReplyProblemListModel *)model;
@end


@interface MyReleaseSupplyOrBuyTableViewCell : MTTableViewCell//我的发布供求
{
    UIAsyncImageView *_headImageView;
    SMLabel *_nickName;
    SMLabel *_titleLbl;
    SMLabel *_ganjingLbl;
    EPImageView *_epImageView;
    UIView *_lineView;
    SMLabel *_timeLbl;
    
    
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(buyType)type;
-(void)setDataWithMode:(MTSupplyAndBuyListModel *)model;
@end


@interface MyReleaseTopicTableViewCell : MTTableViewCell//我的发布话题
{
    UIAsyncImageView *_headImageView;
    SMLabel *_nickName;
    SMLabel *_titleLbl;
    SMLabel *_content;
    EPImageView *_epImageView;
    UIView *_lineView;
    SMLabel *_timeLbl;
}
-(void)setDataWithModel:(MTTopicListModel *)model;
@end

@class MyQuestionModel;
@interface MyReleaseQuestionTableViewCell : MTTableViewCell//我的发布问吧
{
    
    UIAsyncImageView *_headImageView;
     UIAsyncImageView *_headImageView2;//回复
    SMLabel *_nickName;
     SMLabel *_nickName2;//回复
    SMLabel *_titleLbl;
    SMLabel *_content;
    SMLabel *_content2;//回复
    SMLabel *_timeLbl;
     SMLabel *_timeLbl2;//回复
    UIImageView*_deleteImg;
    UIView *_lineView;
    UIImageView *_typeImageview;

}
-(void)setDataWithModel:(MyQuestionModel *)model;
@end

@class NurseryListModel;
@interface NurseryTableViewCell : MTTableViewCell//苗木云列表cell
{
    EPImageView *_epImageView;
    NurseryLabelView *_nueseryLableView;
    SMLabel *_titleLbl;
    UIImageView *_personImageView;
    UIImageView *_telphoneImageView;
    UIImageView *_adressImageView;
    SMLabel *_personLbl;
    SMLabel *_telphoneLbl;
    SMLabel *_adressLbl;
    UIView *_lineView;
    
    UIView *_lineView1;
     UIView *_lineView2;
     UIView *_lineView3;
    
}
-(void)setDataWithModel:(NurseryListModel *)model;
@end

@class MyNerseryModel;
@interface MyNerseryTableViewCell : MTTableViewCell
{
    SMLabel *_nameLbl;
    SMLabel *_addressLbl;
    SMLabel *_statusLbl;
    UIAsyncImageView *_imageView;
    SMLabel *_numLbl;
    SMLabel *_PriceLbl;
}
@property(nonatomic,copy)DidSelectBtnBlock selectBlock;
-(void)setDataWithModel:(MyNerseryModel *)model;
@end


@interface NewsSearchTableViewCell : MTTableViewCell
{
    UIView *_lineView;
}
-(void)setDataWith:(NSString *)htmlText;
@end

@class CouponListModel;
@interface ScoreTableViewCell : MTTableViewCell//积分兑换
{
    SMLabel *_nameLbl;
    SMLabel *_lbl1;
    SMLabel *_lbl2;
    SMLabel *_lbl3;
    SMLabel *_couponLbl;
    UIButton *_btn;
    SMLabel *_statusLbl;
}
-(void)setDataWithModel:(CouponListModel *)model;
@end


@interface NerseryLeftTableViewCell : MTTableViewCell
{
    UIView *_lineView;
}
-(void)setDataWithText:(NSString *)text;
@end

@interface RecommendGroupTableViewCell : MTTableViewCell
{
    SMLabel *_namelbl;
    UIButton *_peopleNumBtn;
    SMLabel *_desclbl;
    UIButton *_applyBtn;
    UIButton *_btn;
    UIView *_view;
    UIView *_lineView;
}
-(CGFloat)setData:(NSDictionary *)dic;
@end

