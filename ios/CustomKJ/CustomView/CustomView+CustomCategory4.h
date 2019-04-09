//
//  CustomView+CustomCategory4.h
//  MiaoTuProject
//
//  Created by 徐斌 on 2016/11/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "CustomView.h"

@interface CustomView (CustomCategory4)

@end

@interface WeatherView : CustomView
{
    SMLabel *_timeLbl;//时间
    SMLabel *_pmLbl;//上下午
    SMLabel *_adressLbl;//当前城市
    SMLabel *_weatherLbl;//天气
    SMLabel *_kongqiLbl;//空气
    SMLabel *_wenduLbl;//当前温度
    SMLabel *_wenduchaLbl;//温度差
    UIImageView *_weatherImageView;//天气图片
    UIButton *_btn;//空气

}
-(void)setweatherDic:(NSDictionary *)obj cityID:(NSString *)cityID cityName:(NSString *)cityName;
@end

@interface seedCloudInfoView : CustomView
{
    SMLabel *_lbl;
}
@property (nonatomic,strong)IHTextField *textFied;
@property (nonatomic,strong)UIImageView *downImg;
-(void)setTextContent:(NSString *)text;
@end


@interface NerseryNumView : CustomView<UITextFieldDelegate>
{
    SMLabel *_lbl;
}
@property (nonatomic,strong)IHTextField *numLbl;
@property (nonatomic,strong)UIView *backView;
@property (nonatomic,copy) DidSelectBtnBlock selectBlock;
@end


@interface NerseryAdvantageView : CustomView
{
    SMLabel *_lbl;
    UIView *_backView;
}
@property (nonatomic,copy) DidSelectBtnBlock selectBlock;
-(void)setTextContent:(NSString *)text;
@end


@interface ScoreConvertView : CustomView
{
 
    UIImageView *_imageView;
    UIButton *_btn;
    UIButton *_btn2;
    UIButton *_btn3;
    SMLabel *_lbl;
    
    
}
@property(nonatomic,copy)DidSelectBtnBlock selectBlock;
@end

@interface PlantSelectedView : CustomView
{
    UIScrollView *_scrollView;
    NSInteger btnTag;
    NSArray *dataArr;
    
    NSString *_text;
    
}
@property (nonatomic,copy) DidSelectBtnBlock selectBlock;
- (void)setPlantBtn:(NSArray *)array text:(NSString *)text;
@end

@class AdView;
@class HeadBannerView;

typedef void (^DidSelectTagBlock)(NSInteger index,NSDictionary * dic);
@interface HomePageTopView : CustomView {
    NSArray *_tagArr;
}
@property(nonatomic,copy)DidSelectTagBlock selectBlock;
@property (nonatomic,strong) void (^callBack)(NSInteger index,NSDictionary * dic);
@property(nonatomic,strong)AdView *v;
@property(nonatomic,strong)WeatherView *weatherView;
@property(nonatomic,strong)UIImageView *redImageView;

@property(nonatomic,strong)HeadBannerView *BannerV;
@property(nonatomic,strong)CornerView *BadgeView;   //角标

@property (nonatomic,strong) NSMutableArray * banArrM;
/**数据*/
@property (nonatomic,strong) NSMutableArray *dataArrM;

@end



@interface ChoosePositionView : CustomView//选择职位
-(CGFloat)setDataWithArr:(NSArray *)arr;
@property(nonatomic,copy)DidSelectBtnBlock selectBtnBlock;
@end



@interface CarDetailTopView : CustomView
- (id)initWithFrame:(CGRect)frame imageUrl:(NSString *)imageUrl name:(NSString *)name address:(NSString *)address;
@end


@interface LogisticsAddressView : CustomView
@property(nonatomic,strong)SMLabel *lbl;
@property(nonatomic,strong)IHTextField *TextField;
@property(nonatomic,copy)DidSelectBtnBlock selectBlock;
- (id)initWithFrame:(CGRect)frame ViewColor:(UIColor *)color text:(NSString *)text place:(NSString *)place;
@end


@interface LogisticsInformationView : CustomView
-(id)initWithFrame:(CGRect)frame text:(NSString *)text isMust:(BOOL)isMust;
@end


@interface RequirementChooseView : CustomView//要求选择
{
    NSArray *_arr;
    NSMutableArray *_Arr;
}
-(id)initWithFrame:(CGRect)frame text:(NSString *)text ;//是否多选
-(void)setDataWith:(NSArray *)arr isSigle:(BOOL)isSigle text:(NSString *)text;
@property(nonatomic,copy)DidSelectCityBlock selectBtn;
@property(nonatomic,copy)DicSelectTypdeBlock selectArrBtnBlock;
@end


