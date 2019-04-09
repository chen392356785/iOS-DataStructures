//
//  SMBaseViewController.h
//  SkillExchange
//
//  Created by xu bin on 15/3/10.
//  Copyright (c) 2015年 xubin. All rights reserved.
//

#import "MTLoginView.h"
#import "UMShare.h"
#import "IHBaseViewController.h"
#import "CNPPopupController.h"//弹出视图
#import <CoreLocation/CoreLocation.h>

#define  backBtnY  WindowHeight - TFTabBarHeight - 42 - 10
 
typedef void (^successRefeshBlock) (MJRefreshComponent *refreshView);
typedef void (^shareBackBlock) (id data, NSError *error);

typedef enum{
   ENT_RefreshAll,   // 加载全部
   ENT_RefreshHeader,  //加载 下拉刷新
   ENT_RefreshFooter,  //加载上拉加载
}RefreshEnumType;

@class XHFriendlyLoadingView;
@interface SMBaseViewController : IHBaseViewController<UIGestureRecognizerDelegate,CLLocationManagerDelegate,UITextFieldDelegate>

{
    MTBaseTableView *commBaseTableView;
    UICollectionView *CollectionView;
    UITableView *mTableView;
    UIButton *moreBtn;
    UIButton *searchBtn;
    UIButton *backTopbutton;
    UIView *_barlineView;
    UIButton *_backBtn;
    XHFriendlyLoadingView* _HUD;

}

@property(nonatomic,weak)SMBaseViewController *inviteParentController;
@property(nonatomic,strong)CLLocationManager *locationManager;
@property(nonatomic,copy)successRefeshBlock successRefeshBlock;
@property(nonatomic,copy)ShowUserLocationBlock showUserLocationBlock;

@property(nonatomic,copy)shareBackBlock ShareBlock;

//是否隐藏导航
@property (nonatomic,assign)BOOL naviBarHidden;


// 渐变颜色 1  -- 渐变颜色2  bounds
- (CAGradientLayer *) retureCagradColor:(UIColor *)color1 andColor:(UIColor *)color2 andBounds:(CGRect )bounds;


//封装下拉刷新
-(void)setbackTopFrame:(CGFloat)y;
-(void)scrollTopPoint:(UIScrollView *)scroll;
-(void)beginRefesh:(RefreshEnumType)type;
-(void)endRefresh;

-(void)endTableViewRefresh;
-(void)beginTableViewRefesh:(RefreshEnumType)type;
-(void)CreateTableViewRefesh:(UITableView *)TableView
                        type:(RefreshEnumType)type
               successRefesh:(void(^)(MJRefreshComponent *refreshView))successRefesh;
-(void)CreateBaseRefesh:(MTBaseTableView *)commtableView
                   type:(RefreshEnumType)type
          successRefesh:(void(^)(MJRefreshComponent *refreshView))successRefesh;

- (void)addBaseTableViewRefesh:(UITableView *)tableView
                          type:(RefreshEnumType)type
                 successRefesh:(void(^)(MJRefreshComponent *refreshView))successRefesh;

-(void)CreateCollectionViewRefesh:(UICollectionView *)collectionView
                             type:(RefreshEnumType)type
                    successRefesh:(void(^)(MJRefreshComponent *refreshView))successRefesh;
-(void)begincollectionViewRefesh:(RefreshEnumType)type;
-(void)endcollectionViewRefresh;
-(void)reloadWaitingView;
-(void)addPushViewWaitingView;
-(void)removePushViewWaitingView;
-(void)prsentToLoginViewController;
-(void)addWaitingView;
-(void)removeWaitingView;
-(void)addSucessView:(NSString *)str type:(int)type;
-(void)showTextHUD:(NSString *)str; //仅显示文字提示
- (void) showWaitingHUD:(NSString *)str;
- (void)HUDHidden;
-(void)shareView2:(buyType)type object:(id)object vc:(UIViewController *)vc;  //生成海报
-(void)shareView:(buyType)type object:(id)object  vc:(UIViewController *)vc; // 分享供应求购
-(void)ShareApp:(NSInteger)index;  //分享app
//分享小程序码到微信httpMethod == 1 GET请求
- (void) shareSmallProgramCodeOject:(NSDictionary *)paramet httpMethod:(NSInteger)httpMethod methoe:(NSString *)url Vc:(UIViewController *)vc completion:(void (^) (id data, NSError *error)) completion;
-(void)ShareUrl:(UIViewController *)vc withTittle:(NSString *)tittle content:(NSString *)content withUrl:(NSString *)urlStr imgUrl:(NSString *)imgURL;//分享链接
-(void)taskShareApp:(UIViewController *)vc;//每日任务分享
-(void)showLoginViewWithType:(LaginType)type;
-(void)presentViewController:(UIViewController *)viewcontroller;
-(void)showUserLocation :(void(^)(NSString *province,NSString *city,CGFloat latitude,CGFloat longtitude))success;
-(void)Shareinformation:(NSString *)userId name:(NSString *)name phone:(NSString *)phone adress:(NSString *)adress imgUrl:(NSString *)imgUrl vc:(UIViewController *)vc;
-(void)refreshTableViewLoading2:(UITableView *)_commTableView
                           data:(NSMutableArray *)dataArray
                       dateType:(NSString *)dateType;
//数据缓存 1小时刷新一次
-(void)setHomeTabBarHidden:(BOOL)isHidden;
-(void)refreshTableViewLoading:(MTBaseTableView *)_commTableView
                          data:(NSMutableArray *)dataArray
                      dateType:(NSString *)dateType;


-(void)setNavBarItem:(BOOL)hasCollection;
- (void)setApleaNavgationItem:(BOOL)hasCollection;
-(void)share;
-(void)collection;

@end


@interface SMBaseCustomViewController : SMBaseViewController<UITextFieldDelegate,UITextViewDelegate>
{
    AppUserSettings *_usersettings;
    UIScrollView *_BaseScrollView;
    IHTextField *_activityTextField;
    UITextView *_activityTextView;
    float _scrollOffset_y;
    float _moreOffset_y;
    
    
    BOOL _hadKeyboardShow;
    CGSize _addContentSize;
}

@property(nonatomic,strong)AppUserSettings *_usersettings;
@property(nonatomic,strong)UIScrollView *_BaseScrollView;
@property(nonatomic,strong)UITextField *_activityTextField;

- (void)registerForKeyboardNotifications;

@end
