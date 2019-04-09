//
//  CustomView.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/3/15.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARSegmentPageControllerHeaderProtocol.h"

@interface CustomView : UIView

@end

@interface LookMeView : CustomView

-(void)setData:(NSArray *)arr num:(int)num;

@end

@interface MTTopView : CustomView
{
    SMLabel *_nicknamelbl;
    SMLabel *_contentlbl;
    LookMeView *_lookView;
    CornerView *_cornerview;
}

-(void) setData:(NSArray *)arr num:(int)num;
@property(nonatomic,copy)DidSelectTopViewBlock selectBlock;
@end

@interface CommentMeView : CustomView
{
    CornerView *_cornerview;
}
-(void)setData:(int)num;
@property(nonatomic,copy)DidSelectTopViewBlock selectBlock;
@end

@interface GroupView : CustomView

@property(nonatomic,copy)DidSelectTopViewBlock selectBlock;
@end


@interface AgreeView : CustomView
{
   
    UIScrollView *_scroll;
    SMLabel *_lbl ;
}
@property (nonatomic,strong) UIButton *agreeBtn;
-(void)setAddNum:(int)num;
-(void)setData:(NSArray *)arr totalNum:(NSString *)totalNum hasClickLike:(BOOL)hasClickLike;
- (instancetype)initWithFrame:(CGRect)frame number:(NSString *)number;
@property (nonatomic,copy) DidSelectheadImageBlock selectBlock;
@end


typedef void (^isDidSelectBlock) (BOOL isClick);
@interface CustomAgreeView : CustomView
{
    
    UILabel *_TimeLabel;
    UIButton *_agreeBut;
    
}
@property (nonatomic,strong) UIButton *agreeBtn;
-(void)setSubViewData:(MTSupplyAndBuyListModel *)model;
- (instancetype)initWithFrame:(CGRect)frame;
@property (nonatomic,copy) isDidSelectBlock AgreeBlock;
@property (nonatomic,copy) DidSelectBlock liuyanBlock;
@end



@interface CommentNumberView : CustomView
- (instancetype)initWithOrgin:(CGPoint)orgin  number:(NSString *)number;
@end


@interface CommentCellView : CustomView
@property (nonatomic,copy) DidSelectheadImageBlock selectBlock;
@end

@class MTTopicListModel;
@interface BottomView : CustomView
{
    
}
- (instancetype)initWithisSelf:(BOOL)isSelf type:(CollecgtionType)type;
-(void)setDataWithModel:(MTTopicListModel *)model;
-(void)setDataWithActivModel:(ActivitiesListModel *)model;
@property (nonatomic,copy) DidSelectheadImageBlock selectBlock;
@property (nonatomic,strong) UIButton *agreeBtn;
@property (nonatomic,strong) UIButton *signBtn;
@end


#import "ZLPhotoActionSheet.h"
#import "PlaceholderTextView.h"
@interface ReleaseView : CustomView<UITextViewDelegate>
{
    UILabel *_placeholderLabel;
}
//- (instancetype)initWithisBuy:(BOOL)isBuy Frame:(CGRect)frame;
@property(nonatomic,strong) IHTextField *ganJingTextField;
@property(nonatomic,strong) IHTextField *guanFuTextField;
@property(nonatomic,strong) UITextView *textView;
@property(nonatomic,strong) PlaceholderTextView *placeholderTextView;
@end


@protocol personInfoDelegate <NSObject>

-(void)personDelegate:(NSInteger )index;

@end
@class MTNearUserModel;
@class BQView;
@class PersonLabelView;
@interface PersonInformationView :UIImageView<ARSegmentPageControllerHeaderProtocol>
{   SMLabel *_nickNameLbl;
    UIImageView *_sexImageView;
    UIAsyncImageView *_headerImageView;
    UIAsyncImageView *_VipImageView;
    SMLabel *_companyNameLbl;
    UIButton *_companyBtn;
    UIButton *_certifyBtn;
    UIButton *_distanceBtn;
    UIImageView *_imgView;
    BQView *_bqView;
    PersonLabelView *_personLabelView;
    UIButton *_btn;
    SMLabel *_fansLbl;
    SMLabel *_guanzhuLbl;
    SMLabel *_bgLbl;
    UIView *_companyView;
    //UIButton *_companyBtn;
    NSInteger companyId;
}

@property(nonatomic,copy)DidSelectBtnBlock selectBtnBlock;
@property(nonatomic,assign) id<personInfoDelegate>delegate;
-(void)quxiaofollow;
-(void)follow;
-(void)setDataWithdic:(NSDictionary *)dic ;
-(void)setUserChildrenInfo:(UserChildrenInfo *)model ;
-(void)setbuttonValuettention;
- (void)setbuttonValueCancel;

@end


@interface PersonInformationBottomView : CustomView
- (instancetype)initWithisSelf:(BOOL)isSelf;
@property(nonatomic,assign) id<personInfoDelegate>delegate;
@end


//@protocol NumberKeyBoardDelegate <NSObject>
//
//- (void) numberKeyBoardInput:(NSInteger) number;
//- (void) numberKeyBoardBackspace;
//- (void) numberKeyBoardFinish;
//
//@end

typedef void(^numberKeyboardBlock)(NSString *String);
typedef void(^numberKeyboardBlock2)(NSString *String);
@interface KeybordView : CustomView<UITextFieldDelegate>
{   
    UITextField *_textFieldTo;
    UITextField *_textFieldFrom;
}
//- (void)customView:(CGRect)frame;
- (instancetype)initWith;
@property(nonatomic)ReleaseType type;
@property (nonatomic,copy) numberKeyboardBlock block;
@property (nonatomic,copy) numberKeyboardBlock2 block2;

-(void)creatViewWiyhType:(ReleaseType)type;
@end

@interface ActivityVoteTopView : CustomView
{
    UIAsyncImageView *_topImage;
    SMLabel *_titleLbl;
    SMLabel *_timerLbl;
    SMLabel *_numberLbl;
    int second;
    NSTimer *timer;
}
@property (nonatomic,strong)UIButton *btn;
- (id)initWithFrame:(CGRect)frame;

- (void)setTopData:(NSString *)title time:(NSString *)time totlNum:(NSString *)totleNum imgUrl:(NSString *)url;
@end
