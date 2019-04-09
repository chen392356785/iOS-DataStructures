//
//  CustomView+CustomCategory.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/3/23.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "CustomView.h"
@class UserChildrenInfo;
@interface CustomView (CustomCategory)

@end
@interface EditInformationView : CustomView
@property(nonatomic,strong)SMLabel *lbl;
@property(nonatomic,strong)UIImageView *imageView;
- (instancetype)initWithFrame:(CGRect)frame name:(NSString *)name;
@property (nonatomic,copy) DidSelectheadImageBlock selectBlock;
@end


@interface LabelView : CustomView
- (instancetype)initWithFrame:(CGRect)frame;
-(void)setData:(NSMutableArray *)arr;
@end


@interface MapAnnotationView : CustomView
- (instancetype)initWithFrame:(CGRect)frame name:(NSString *)name ifMust:(BOOL)ifMust;
@property(nonatomic,strong)SMLabel *lbl;
@property (nonatomic,copy) DidSelectheadImageBlock selectBlock;
@end

@interface CancelView : CustomView
{
    SMLabel *_timelbl;
}
@property(nonatomic,strong)UIButton *cancelBtn;
- (instancetype)initWithFrame:(CGRect)frame ;
-(void)setData:(NSString *)time;
@end
@class HeadButton;

@interface HeaderView : CustomView
{
    HeadButton *_headView;
    SMLabel *_nicknamelbl;
    SMLabel *_jobLbl;
    UIImageView *_sexImgeView;
    UIImageView *_typeImageView;
    SMLabel *_addresslbl;
    UIImageView *_idtypeImageView;
    UIImageView *_idImageView;
}
-(void)setData:(UserChildrenInfo *)model type:(buyType)type;

@property (nonatomic,copy) DidSelectheadImageBlock selectBlock;
@end


@interface TopicBottomView : CustomView
{
    UIButton *_commentBtn;
    UIButton *_agreeBtn;
}
@property(nonatomic,strong)MTTopicListModel *model;
-(void)setData :(MTTopicListModel *)model;
@property (nonatomic,copy) DidSelectCommentButtonBlock selectBlock;
@end


#pragma mark 弹出视图
#import "keychainItemManager.h"
@interface CatapultView : CustomView
{
    UIView *_view;
    UIImageView *_imageView;
}
@property(nonatomic,strong)UIImageView *imageView;
 @property(nonatomic,copy)DidSelectBtnBlock selectBtnBlock;
-(instancetype)initWithFrame:(CGRect)frame withView:(UIView *)centerView;
@end

#pragma mark 分享
@interface ShareView : CustomView
{
    SMLabel *_label;
    UIButton *_WXBtn;
    UIButton *_PYQBtn;
}
-(void)hideView;
-(instancetype)initWithIsFriendFrame:(CGRect)frame;
@property(nonatomic,copy)DidSelectBtnBlock selectBtnBlock;
@property(nonatomic,strong)UIView *centerView;
- (void)setdata:(NSString *)content;
@end

@interface CornerView : UIView{
    UIImageView *_countImage;
    SMLabel *_numlbl;
}
- (id)initWithFrame:(CGRect)frame count:(int)count ;

@property(nonatomic)int num;
@end




#pragma mark 活动详情中间部分
@interface ActivityMidView :CustomView
{
    
    SMLabel *_timelabel;
    SMLabel *_priceLabel;
    
}
@property (nonatomic,strong)SMLabel *connectUser;
@property (nonatomic,strong)SMLabel *addressLabel;
@property (nonatomic,strong)UIView *addressView;
@property (nonatomic,strong)UIView *connectUserView;
- (void)setDataWith:(NSString *)time address:(NSString *)address unit_price:(NSString *)price endTime:(NSString *)endtime;
@end



@interface ActivityDetailView : CustomView<UIWebViewDelegate>
{
    SMLabel *_lbl;
    UIView *_lineView;
    UIImageView *_rightImag;
    UIView *_bottomLineView;
    UIImageView *_imageview1;
    UIImageView *_imageview2;
    UIImageView *_imageview3;
    UIImageView *_imageview4;
}
@property (nonatomic,strong)SMLabel *moreLabel;
@property (nonatomic,strong) UIWebView *contentLabel;;
@property(nonatomic,copy)DidSelectYZMBlock selectUrlBlock;
-(void)setcontentText:(CGFloat)Height;
@end


#pragma mark 气泡弹出
@interface MTOppcenteView : CustomView
- (instancetype)initWithOrgane:(CGPoint)organe BtnType:(BtnType)BtnType;
@end


@interface MTLogisticsChooseView : CustomView
{
//    UIButton *_btn;
    NSArray *_arr;
}
- (instancetype)initWithOrgane:(CGPoint)organe array:(NSArray *)arr;
@property(nonatomic,copy)LogisDidSelectBtnBlock selectBtnBlock;
@property(nonatomic,strong)UIButton *btn;
@end

@interface SourceAdressView : CustomView<UITextFieldDelegate>
@property (nonatomic,strong) IHTextField *startAdressText;
@property (nonatomic,strong) IHTextField *endAdressText;
@property (nonatomic,strong) IHTextField *goodNameText;
@property (nonatomic,strong) IHTextField *goodsNumText;
@end

@interface CarTypeView : CustomView<UITextFieldDelegate>
@property (nonatomic,strong) IHTextField *carTypeText;
@property (nonatomic,strong) IHTextField *bearWeightText;//承载重量
@property (nonatomic,strong) IHTextField *bearVolumeText;//承载体积
@property (nonatomic,strong) IHTextField *carNumText;
@end

@interface CarStartTimeView : CustomView<UITextFieldDelegate>
@property (nonatomic,strong)SMLabel *titlelabel;
@property (nonatomic,strong)IHTextField *textfiled;
- (instancetype)initWithFrame:(CGRect)frame array:(NSArray *)arr;

@end

@interface ActivtiesOrderView : CustomView<UITextFieldDelegate>
{
    UIView *_bottomView;
}
@property (nonatomic,strong)UIButton *referBtu;
@property (nonatomic,strong)IHTextField *companyText;
@property (nonatomic,strong)IHTextField *jobText;
@property (nonatomic,strong)IHTextField *nameText;
@property (nonatomic,strong)IHTextField *phoneText;

- (id)initWithFrame:(CGRect)frame
         activImage:(NSString *)imageUrl
              price:(NSString *)price
                dic:(NSDictionary *)infoDic;
    
- (void)cancleOrder;

@end

@interface SearchView : CustomView<UITextFieldDelegate>

@property(nonatomic,copy)DidSelectBtnBlock selectBtnBlock;
@property (nonatomic,strong)UITextField *textfiled;
@property (nonatomic,strong)UIButton *button;
- (id)initWithFrame:(CGRect)frame;
@end

@interface bindGoodView : CustomView
- (id)initWithFrame:(CGRect)frame;
@end


@interface WeatherOtherInfoView : CustomView
{
    UIAsyncImageView *_imageView;
    SMLabel *_nameLbl;
    SMLabel *_contentLbl;
}

- (void)setWeatherData:(NSString *)name content:(NSString *)content image:(UIImage *)image;
@end











