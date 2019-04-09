//
//  ScoreConvertViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/11/30.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "ScoreConvertViewController.h"
#import "PersonScoreViewController.h"
#import "ScoreHistoryViewController.h"
@interface ScoreConvertViewController ()<UITableViewDelegate>
{
    MTBaseTableView *commTableView;
    int page;
    NSMutableArray *dataArray;
    NSIndexPath *_indexPath;
    SMLabel *_timeLbl;
    SMLabel *_statusLbl;
    SMLabel *_lbl;
    SMLabel *_scoreLbl;
}

@end

@implementation ScoreConvertViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self setTitle:@"积分兑换"];
    __weak ScoreConvertViewController *weakSelf=self;
    dataArray = [[NSMutableArray alloc]init];
    
    NSDictionary *dic=[IHUtility getUserDefalutsDicKey:kUserDefalutLoginInfo];
    
    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 85+40)];
    topView.backgroundColor=[UIColor whiteColor];
    
    UIView *TapView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 85)];
    [topView addSubview:TapView];
    UIAsyncImageView  *headImageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(12, 10, 65, 65)];
    [headImageView setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,dic[@"heed_image_url"]] placeholderImage:defalutHeadImage];
    [headImageView setLayerMasksCornerRadius:65/2 BorderWidth:0 borderColor:cGreenColor];
    [TapView addSubview:headImageView];
    
    NSString *name=dic[@"nickname"];
    if (name.length>6) {
        name=[dic[@"nickname"] substringToIndex:6];
    }
    
    CGSize size=[IHUtility GetSizeByText:name sizeOfFont:15 width:100];
    SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(headImageView.right+12, 0, size.width, 15) textColor:cBlackColor textFont:sysFont(15)];
    lbl.text=name;
    lbl.centerY=headImageView.centerY;
    [TapView addSubview:lbl];
    
    size=[IHUtility GetSizeByText:[NSString stringWithFormat:@"%@",dic[@"experience_info"][@"residual_value"]] sizeOfFont:27 width:150];
    
    UIView *scoreView=[[UIView alloc]initWithFrame:CGRectMake(WindowWith-36-size.width, 0, size.width+36, 85)];
    [TapView addSubview:scoreView];
    
    UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushToScoreVC)];
    [TapView addGestureRecognizer:tap];
    
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, 0, size.width, 27) textColor:cGreenColor textFont:sysFont(27)];
    lbl.text=[NSString stringWithFormat:@"%@",dic[@"experience_info"][@"residual_value"]];
    lbl.centerY=headImageView.centerY;
    _scoreLbl=lbl;
    [scoreView addSubview:lbl];
    
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.right, lbl.top+13, 12, 12) textColor:cGreenColor textFont:sysFont(12)];
    lbl.text=@"分";
    
    [scoreView addSubview:lbl];
    
    UIImage *img=Image(@"iconfont-fanhui.png");
    
    UIImageView *toImageView=[[UIImageView alloc]initWithFrame:CGRectMake(lbl.right+5, 0, img.size.width, img.size.height)];
    toImageView.image=img;
    toImageView.centerY=headImageView.centerY;
    [scoreView addSubview:toImageView];
    
    //1.view当前的当前状态
    CGAffineTransform tranform = toImageView.transform;
    //2.创建一个平移,并且得到计算好的结果
    //tx, ty, 平移量
    CGAffineTransform translate = CGAffineTransformTranslate(tranform/*当前的状态*/, 0, 0);
    
    CGAffineTransform scale = CGAffineTransformScale(translate, 1, 1); //包含平移
    //2.创建一个旋转
    //旋转角度为弧度,顺时针为正数,逆时针为负数
    CGAffineTransform rotate = CGAffineTransformRotate(scale, -180 * M_PI / 180/*单位为弧度*/);//包含缩放
    
    toImageView.transform=rotate;
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 85, WindowWith, 40)];
    view.backgroundColor=RGB(247, 248, 250);
    [topView addSubview:view];
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 39.5, WindowWith, 0.5)];
    lineView.backgroundColor=RGB(232, 121, 117);
    [view addSubview:lineView];
    
    UIImageView *timebgImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0.293*WindowWith, 0, WindowWith-0.293*WindowWith, 40)];
    timebgImageView.image=Image(@"Score_timebg.png");
    [view addSubview:timebgImageView];
    
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(10, 0, timebgImageView.width-20, 40) textColor:[UIColor whiteColor] textFont:sysFont(14)];
    lbl.text=@"限时限量，本场还有宝贝可以继续抢购";
    _lbl=lbl;
    [timebgImageView addSubview:lbl];
    
    UIImageView *timeImageView=[[UIImageView alloc]initWithFrame:CGRectMake(12, 8, 28, 26)];
    timeImageView.image=Image(@"Score_time.png");
    
    [view addSubview:timeImageView];
    
    size=[IHUtility GetSizeByText:@"10：00" sizeOfFont:17 width:100];
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(timeImageView.right+5, 0, size.width, size.height) textColor:RGB(232, 121, 117) textFont:sysFont(17)];
    lbl.text=@"10:00";
    _timeLbl=lbl;
    [view addSubview:lbl];
    
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(timeImageView.right+8, lbl.bottom, 60, 15) textColor:RGB(232, 121, 117) textFont:sysFont(12)];
    lbl.text=@"开抢中";
    _statusLbl=lbl;
    // lbl.textAlignment=NSTextAlignmentCenter;
    [view addSubview:lbl];
    
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight) tableviewStyle:UITableViewStylePlain];
    
    dataArray=[[NSMutableArray alloc]init];
    
    commTableView.attribute=self;
    commTableView.table.delegate=self;
    commTableView.table.showsVerticalScrollIndicator=NO;
    commTableView.table.tableHeaderView=topView;
    [commTableView setupData:dataArray index:55];
    // commTableView.backgroundColor = cLineColor;
    
    // __weak ScoreConvertViewController *weakSelf=self;
    
    [self CreateBaseRefesh:commTableView type:ENT_RefreshAll successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefesh:refreshView];
    }];
    [self.view addSubview:commTableView];
    [self beginRefesh:ENT_RefreshHeader];
}

-(void)pushToScoreVC{
    
    PersonScoreViewController *vc=[[PersonScoreViewController alloc]init];
    [self pushViewController:vc];
}

-(void)setData:(CouponListModel *)model{
    
    if (model.couponStatus==false) {
        
        _lbl.text=@"限时限量，提前设置提醒不错过~";
        _statusLbl.text=@"即将开抢";
    }else if (model.couponStatus==true){
        
        if ([model.buyStatus isEqualToString:@"0"]) {
            
            _lbl.text=@"限时限量，提前设置提醒不错过~";
            _statusLbl.text=@"明日开抢";
        }else{
            _lbl.text=@"限时限量，本场还有宝贝可以继续抢购";
            _statusLbl.text=@"开抢中";
        }
    }
    _timeLbl.text=model.buyTime;
}

-(void)loadRefesh:(MJRefreshComponent *)refreshView{
    if (refreshView==commTableView.table.mj_header) {
        page=0;
    }
    [network selectCouponInfoListSuccess:^(NSDictionary *obj) {
        NSArray *arr=obj[@"couponInfos"];
        if (arr.count > 0) {
            CouponListModel *model=arr[0];
            [self setData:model];
        }
		if (refreshView==self->commTableView.table.mj_header) {
            
			[self->dataArray removeAllObjects];
			self->page=0;
            if (arr.count==0) {
				[self->dataArray addObjectsFromArray:arr];
				[self->commTableView.table reloadData];
            }
			[self->commTableView.table.mj_footer resetNoMoreData];
        }
        
        if (arr.count>0) {
			self->page++;
            if (arr.count<pageNum) {
				[self->commTableView.table.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
			[self->commTableView.table.mj_footer endRefreshingWithNoMoreData];
            [self endRefresh];
            return;
        }
        
		[self->dataArray addObjectsFromArray:arr];
        
		[self->commTableView.table reloadData];
        [self endRefresh];
    } failure:^(NSDictionary *obj2) {
        [self endRefresh];
    }];
}

-(void)BCtableViewCell:(IHTableViewCell *)cell action:(BCTableViewCellAction)action indexPath:(NSIndexPath *)indexPath attribute:(NSObject *)attribute{//cell分支点击
    
    __weak ScoreConvertViewController *weakSelf=self;
    if (action==MTQiangDanActionTableViewCell) {
        ScoreConvertView *view=[[ScoreConvertView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, kScreenHeight)];
        UIWindow * window =[[[UIApplication sharedApplication] delegate] window];
        view.selectBlock=^(NSInteger index){
            if (index==openBlock) {
                
                [weakSelf pushToHistory];
            }else{
                [weakSelf score:indexPath];
            }
        };
        [window addSubview:view];
    }
}

-(void)pushToHistory{//查看详情
    ScoreHistoryViewController *vc=[[ScoreHistoryViewController alloc]init];
    [self pushViewController:vc];
}

-(void)score:(NSIndexPath *)indexPath{//点击兑换
    
    CouponListModel *model=dataArray[indexPath.row];
    [network placeOrder:[model.Id intValue] amount:[model.amount intValue] success:^(NSDictionary *obj) {
        
        if ([obj[@"errorNo"] intValue]==0) {
            NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithDictionary:[IHUtility getUserDefalutsDicKey:kUserDefalutLoginInfo]];
            int score=[dic[@"experience_info"][@"residual_value"] intValue]-[model.amount intValue];
            NSMutableDictionary *Dic=[[NSMutableDictionary alloc]initWithDictionary:dic[@"experience_info"]];
            [Dic setObject:[NSString stringWithFormat:@"%d",score] forKey:@"residual_value"];
            //[Dic setValue:score forKey:@"residual_value"];
            
            [dic setObject:Dic forKey:@"experience_info"];
            
            [IHUtility setUserDefaultDic:dic key:kUserDefalutLoginInfo];
            
			self->_scoreLbl.text=[NSString stringWithFormat:@"%d",score];
            CGSize size=[IHUtility GetSizeByText:[NSString stringWithFormat:@"%@",dic[@"experience_info"][@"residual_value"]] sizeOfFont:27 width:150];
			self->_scoreLbl.size=CGSizeMake(size.width, 27);
            
            model.userStatus=@"1";
            
			[self->dataArray replaceObjectAtIndex:indexPath.row withObject:model];
            
			[self->commTableView.table reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            
        }else if ([obj[@"errorNo"] intValue]==602){
            [IHUtility addSucessView:@"积分不足" type:2];
        }
        
    } failure:^(NSDictionary *obj2) {
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 10+0.4*WindowWith;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
