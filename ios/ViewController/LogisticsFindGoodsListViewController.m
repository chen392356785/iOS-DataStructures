//
//  LogisticsFindGoodsListViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/5/30.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "LogisticsFindGoodsListViewController.h"
//#import "UINavigationBar+Awesome.h"
#import "calendarView.h"
#import "AddressPickView.h"
#import "carSourceMoreView.h"
#import "LogisticsFindGoodsDetailsViewController.h"
#import "LogisticsCreatSourceViewController.h"
#import "LogisticsIdentViewController.h"
#import "LogisticsCarCertifyViewController.h"
@interface LogisticsFindGoodsListViewController ()<UITableViewDelegate>
{
    MTBaseTableView *commTableView;
//    int page;
//    NSMutableArray *dataArray;
    UIButton *_createBtn;
    calendarView *_calendarV;
    MTLogisticsChooseView *_logisticsView;
    carSourceMoreView *_carSV;
}
@end

@implementation LogisticsFindGoodsListViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    //    UIColor *color=RGBA(255, 255, 255, 0.8);
    //    [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:1]];
    //    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"货源"];
    [self creatTableView];
    
//    UIBarButtonItem *item1=[[UIBarButtonItem alloc]initWithImage:[Image(@"xunhuan.png") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]style:UIBarButtonItemStylePlain target:self action:@selector(ident)];
    UIBarButtonItem *item2=[[UIBarButtonItem alloc]initWithTitle:@"身份" style:UIBarButtonItemStylePlain target:self action:@selector(ident)];
    [item2 setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItems=@[item2];
}

-(void)ident
{
    LogisticsIdentViewController *vc=[[LogisticsIdentViewController alloc]init];
    [self pushViewController:vc];
}

-(void)creatTableView
{
    NSArray *arr = @[@"出发地",@"目的地",@"出发时间",@"更多"];
    MTLogisticsChooseView *logisticsView=[[MTLogisticsChooseView alloc]initWithOrgane:CGPointMake(0, 0) array:arr];
    [self.view addSubview:logisticsView];
    __weak LogisticsFindGoodsListViewController *weakSelf = self;
    
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, logisticsView.bottom, WindowWith, WindowHeight-43) tableviewStyle:UITableViewStylePlain];
    
    commTableView.table.delegate=self;
    commTableView.attribute=self;
    [commTableView setupData:@[@"1",@"1",@"1"] index:22];
    [self.view addSubview:commTableView];
    
    UIButton* createBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _createBtn=createBtn;
    createBtn.frame=CGRectMake(WindowWith/2-80/2, WindowHeight-60, 80, 40) ;
    [createBtn setTitle:@"发  布" forState:UIControlStateNormal];
    [createBtn setLayerMasksCornerRadius:20 BorderWidth:0.1 borderColor:cGreenColor];
    [createBtn setBackgroundColor:cGreenColor];
    createBtn.titleLabel.font=sysFont(15);
    [createBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [createBtn addTarget:self action:@selector(createBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:createBtn];
    
    //初始化日历
    calendarView *calendarV = [[calendarView alloc] initWithFrame:self.view.bounds day:30];
    calendarV.top = - self.view.height;
    _calendarV = calendarV;
    [calendarV.unlimitedBtn addTarget:self action:@selector(unlimitedTime:) forControlEvents:UIControlEventTouchUpInside];
    calendarV.calendarblock = ^(CalendarDayModel *model){
        //点击选中时间回调
    };
    [self.view addSubview:calendarV];
    
    //更多
    carSourceMoreView *carSV = [[carSourceMoreView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.height - logisticsView.height)];
    carSV.top = - self.view.height;
    _carSV = carSV;
    [self.view addSubview:carSV];
	
	__weak MTLogisticsChooseView *weak_logisticsView = logisticsView;

    logisticsView.selectBtnBlock=^(NSInteger index,UIButton *sender){
        if (index==SelectStartBlock) {
            NSLog(@"start");
            [weakSelf hideOtherView];
            [weakSelf selectedStartAddress];
            
        }else if (index==SelectEntBlock){
            NSLog(@"end");
            [weakSelf hideOtherView];
            [weakSelf selectedStartAddress];
        }else if (index==SelectTimeBlock){
            NSLog(@"time");
            if (sender.selected) {
                [UIView animateWithDuration:.3 animations:^{
                    carSV.top = -weakSelf.view.height-64 ;
                    calendarV.top = weak_logisticsView.bottom;
                }];
            }else {
                [UIView animateWithDuration:.3 animations:^{
                    calendarV.top = -weakSelf.view.height-64 ;
                }];
            }
            
        }else if (index==SelectMoreBlock){
            NSLog(@"more");
            if (sender.selected) {
                [UIView animateWithDuration:.3 animations:^{
                    carSV.top = weak_logisticsView.bottom;
                    calendarV.top = -weakSelf.view.height-64 ;
                }];
            }else {
                [UIView animateWithDuration:.3 animations:^{
                    carSV.top = -weakSelf.view.height-64 ;
                }];
            }
        }
    };
    
    //AddressPickView隐藏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeAlladdViews) name:@"AddressPickViewHidden" object:nil];
    
}
- (void)removeAlladdViews
{
    for (NSInteger i=0; i<4; i++) {
        UIButton *button =[_logisticsView viewWithTag:i+1000];
        button.selected=NO;
    }
}
- (void)hideOtherView
{
    __weak LogisticsFindGoodsListViewController *weakSelf = self;
    [UIView animateWithDuration:.3 animations:^{
        self->_carSV.top = -weakSelf.view.height-64 ;
        self->_calendarV.top = -weakSelf.view.height-64 ;
    }];
}

//不限装车时间
- (void)unlimitedTime:(UIButton *)button
{
    [UIView animateWithDuration:.3 animations:^{
        self->_calendarV.top = -self.view.height-64 ;
    }];
    
    [self removeAlladdViews];
}
- (void)createBtnClick:(UIButton *)button
{
    LogisticsCreatSourceViewController *logisticVC = [[LogisticsCreatSourceViewController alloc] init];
    logisticVC.type = @"1";
    [self pushViewController:logisticVC];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat y=scrollView.contentOffset.y;
    
    if (y<=0) {
        [UIView animateWithDuration:0.5f animations:^{
            self->_createBtn.alpha=1;
        } completion:^(BOOL finished) {
        }];
    }else{
        [UIView animateWithDuration:0.5f animations:^{
			self->_createBtn.alpha=0;
        } completion:^(BOOL finished) {
        }];
    }
	if (y>_boundHeihgt) {
		[UIView animateWithDuration:0.5f animations:^{
			self->backTopbutton.alpha=1;
			[self.view bringSubviewToFront:self->backTopbutton];
		} completion:^(BOOL finished) {
		}];
	}else{
		[UIView animateWithDuration:0.5f animations:^{
			self->backTopbutton.alpha=0;
			// [self.view bringSubviewToFront:backTopbutton];
		} completion:^(BOOL finished) {
		}];
	}
}

-(void)back:(id)sender{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:0.5 animations:^{
        self->_createBtn.alpha=1;
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 260;
}

-(void)BCtableViewCell:(IHTableViewCell *)cell action:(BCTableViewCellAction)action indexPath:(NSIndexPath *)indexPath attribute:(NSObject *)attribute
{
    if (action==MTHeadViewActionTableViewCell) {
        NSLog(@"header");
    }else if (action==MTQiangDanActionTableViewCell){
        NSLog(@"qiangdan");
        LogisticsCarCertifyViewController *vc=[[LogisticsCarCertifyViewController alloc]init];
        [self pushViewController:vc];
    }else if (action==MTShareActionTableViewCell){
        NSLog(@"share");
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LogisticsFindGoodsDetailsViewController *vc=[[LogisticsFindGoodsDetailsViewController alloc]init];
    [self pushViewController:vc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)selectedStartAddress
{
    
    AddressPickView *addressPickView = [AddressPickView shareInstance];
    [self.view addSubview:addressPickView];
    
    addressPickView.block = ^(NSString *province,NSString *city,NSString *town){
    };
}

@end
