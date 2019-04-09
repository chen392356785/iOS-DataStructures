//
//  CustomView+CustomCategory2.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/5/30.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "CustomView.h"

@interface CustomView (CustomCategory2)

@end

@interface LogisticsHeaderView : CustomView
@property(nonatomic,copy)DidSelectBtnBlock selectBtnBlock;
@end


@interface LogisticsAdressView : CustomView

@end



@interface MTBottomView : CustomView
- (instancetype)initWithImgArr:(NSArray *)ImgArr TitleArr:(NSArray *)titleArr;
@end


@interface BQView : CustomView{
    UIImageView *lastImg;
}
-(id)initWithFrame:(CGRect)frame ;
-(void)setData:(NSArray *)arr;
@end


@interface blankView : CustomView
@property (nonatomic,strong)SMLabel *label;
- (id)initWithFrame:(CGRect)frame;
//- (void)setLableText:(NSString *)text;
@end



@interface NavigiSliderView :CustomView
{
    UIView *_selView;
    UIButton *_selButton;
    UIImageView *_redImageView;
}

@property(nonatomic) NSInteger navSlideWidth;
@property(nonatomic) NSInteger  Count;
@property(nonatomic) NSInteger currIndex;
- (id)initWithFrame:(CGRect)frame setTitleArr:(NSArray *)titleArray isPoint:(BOOL)isPoint;
//-(void)slideScroll:(CGFloat) x;
//-(void)slideSelectedIndex:(NSInteger)index;

@property (nonatomic,copy) DidSelectheadImageBlock selectBlock;
@end

@interface NewsBottomView : CustomView
@property (nonatomic,strong)IHTextField *textfield;
@property (nonatomic,strong)UIButton *Btn;//发送

- (id)initWithFrame:(CGRect)frame;
@end

@interface NewsImgCommentView :CustomView

@property (nonatomic,strong)UIButton *commList;
@property (nonatomic,strong)IHTextField *commentLbl;
- (id)initWithFrame:(CGRect)frame;
- (void)setDataNum:(int)number;
@end

@interface EPCloudListBottonView : CustomView

@property (nonatomic,copy) DidSelectBtnBlock selectBlock;
- (id)initWithFrame:(CGRect)frame btnTitle:(NSArray *)titles images:(NSArray *)images;
@end


@interface EPCloudDetailTopView : CustomView<EDStarRatingProtocol>
{
    EDStarRating *_ratingImage;
    SMLabel *_companyLbl;
    SMLabel *_companyInfo;
    SMLabel *_companyType;
    SMLabel *_companyDetail;
    SMLabel *_companyBusiness;
    UIView *_backView;
    SMLabel *_adressLbl;
    SMLabel *_urlLbl;
    SMLabel *_emailLbl;
    SMLabel *_phoneLbl;
    UIButton *_btn;
    SMLabel *_commentNumLbl;
    UIAsyncImageView *_companyImg;
    UIView *_lineView;
    
    
}
@property (nonatomic,copy) DidSelectBtnBlock selectBlock;
@property (nonatomic,strong)EPCloudListModel *model;
- (id)initWithFrame:(CGRect)frame;
- (void)setDetail:(EPCloudListModel *)model;
@end



@interface BtnView : UIButton
- (id)initWithFrame:(CGRect)frame cornerRadius:(CGFloat)cornerRadius text:(NSString *)text image:(UIImage *)image;
@end


@interface EPCloudCumlativeListView : CustomView
@property(nonatomic,strong)SMLabel *lbl;
@property(nonatomic,strong)UIAsyncImageView *headImageView;
@property(nonatomic,copy)DidSelectheadImageBlock selectBlock;
-(id)initWithFrame:(CGRect)frame text:(NSString *)text ifImage:(BOOL)ifImage;
@end

@interface EPCloudCommentListTopView : CustomView<EDStarRatingProtocol>

{
    UIAsyncImageView *_companyImg;
    EDStarRating *_ratingImage;
    SMLabel *_companyLbl;
    SMLabel *_companyInfo;
    SMLabel *_commentNumLbl;
}
- (id)initWithFrame:(CGRect)frame;
- (void)setData:(EPCloudListModel *)model;
@end






@interface PersonLabelView : CustomView

- (id)initWithFrame:(CGRect)frame;
//-(void)setDataWithArrar:(NSArray *)arr;
@end




@class MTNearUserModel;
@class UserChildrenInfo;
@interface VisitingCardView : CustomView{
    UIAsyncImageView *_headImageView;
    SMLabel *_nickName;
    SMLabel *_gongqiuLbl;
    UIButton *_company;
    UIButton *_position;
    UIButton *_instrust;
    UIButton *_adress;
    UIButton *_telephone;
    UIButton *_email;
    UIButton *_phone;
    UIView *_lineView;
    SMLabel *_zhuyingLbl;
    SMLabel *_lbl;
    UIView *_view;
    UIView *_v;
}
-(void)setdataWithModel:(UserChildrenInfo *)model arr:(NSArray *)arr dic:(NSDictionary *)dic;
- (id)initWith;
-(void)show;
@end


@class EPImageView;
@interface ConnectionsView : CustomView
{
    UIAsyncImageView *_headImageView;
    SMLabel *_nickName;
    SMLabel *_tilte;
    SMLabel *_bqLbl;
    UIButton *_btn;
    UIImageView *_zuo;
    UIImageView *_you;
    SMLabel *_number;
    EPImageView *_EPImageview;
    SMLabel *_supply;
    SMLabel *_wantBuy;
    SMLabel *_fans;
    
}
@property(nonatomic,strong)UIButton *btn;
- (id)initWithFrame:(CGRect)frame;
-(void)setDataWithModel:(MTConnectionModel *)model zuo:(BOOL)zuo you:(BOOL)you indexPath:(NSIndexPath *)indexPath;
-(void)setDataWithModel:(MTConnectionModel *)model;

-(void)setDataWithModel:(MTConnectionModel *)model  j:(NSInteger)j;
@property(nonatomic,copy)DidSelectBtnBlock selectBtnBlock;

@end




@interface CompanyView : CustomView<EDStarRatingProtocol>
{
    EDStarRating *_ratingImage;
    UIAsyncImageView *_bkImageView;
    UIAsyncImageView *_logoImageView;
    SMLabel *_companyName;
    SMLabel *_intrudetion;
    SMLabel *_title;
    UIView *_lineView;
    
    
}
- (id)initWithFrame:(CGRect)frame;
-(void)setDataWithModel:(MTCompanyModel *)model;
@end







@interface EPCloudCommentView : CustomView<EDStarRatingProtocol,UITextViewDelegate>

{
//    EDStarRating *_ratingImage;
    NSString *score;
    NSString *content;
    UIView *_backView;
    
    
}

@property(nonatomic,copy)DidSelectLoginBlock selectBlock;
@property (nonatomic,strong)UIButton *btn;
@property (nonatomic,strong)EDStarRating *ratingImage;
@property (nonatomic,strong)UITextView *textView;
- (id)initWithFrame:(CGRect)frame;
@end



@interface AreaView : CustomView
{

    int type;
    float top;
    NSDictionary *_dataDic;
    UIButton *_btn;
    UIView *cityView;
    UIButton *_backBtn;
    NSString *_proviceText;
}
@property (nonatomic,strong)UIScrollView *backScroll;;
@property(nonatomic,strong)UIButton *btn;
@property(nonatomic,copy)DidSelectLoginBlock selectBlock;
@property(nonatomic,copy)DidSelectBtnBlock selectBtnBlock;
@property(nonatomic,copy)DidSelectCityBlock selectCityBlock;


- (id)initWithFrame:(CGRect)frame dataDic:(NSDictionary *)dataDic grade:(int)grade;
@end




@interface EPImageView : CustomView
@property(nonatomic,assign) NSInteger cornerRedius;
-(void)setDataWith:(NSArray *)arr;
@end




@interface CommentAndLikeView : CustomView
@property(nonatomic,copy)DidSelectBtnBlock selectBtnBlock;
-(void)show;

@end


@interface VotoView : CustomView
{
    UIAsyncImageView *_imageView;
    SMLabel *_namelbl;
     SMLabel *_voteNumlbl;
}
-(void)show;
-(void)hide;
- (id)initWithFrame:(CGRect)frame;
- (void)setContent:(VoteListModel*)model lmitNum:(NSString *)limitNum surplus:(NSString *)surplus;
@property(nonatomic,copy)DidSelectBtnBlock selectBtnBlock;
@end


@interface BuyVotoNumView : CustomView
{
    UIAsyncImageView *_imageView;
    SMLabel *_namelbl;
    SMLabel *_voteNumlbl;
    UITextField *_textfd;
    NSString *_yupiaoStr;
}
- (id)initWithFrame:(CGRect)frame;
- (void)setContent:(VoteListModel*)model lmitNum:(NSString *)limitNum surplus:(NSString *)surplus;
@property(nonatomic,copy)DidSelectStrBlock selectBtnBlock;
@property(nonatomic,copy)DidSelectBlock buyVotoBtnBlock;
@property(nonatomic,copy)DidSelectBlock hideBtnBlock;

@end


