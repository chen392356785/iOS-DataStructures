//
//  PersonScoreViewController.m
//  MiaoTuProject
//
//  Created by Zmh on 30/11/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "PersonScoreViewController.h"
#import "ScoreHistoryViewController.h"
#import "MYTaskViewController.h"

@interface PersonScoreViewController ()<UITableViewDelegate>
{
    MTBaseTableView *commTableView;
//    int page;
    NSMutableArray *dataArray;
}
@end

@implementation PersonScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"我要赚更多"];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, 195)];
    topView.backgroundColor = [UIColor whiteColor];
    
    NSDictionary *dic=[IHUtility getUserDefalutsDicKey:kUserDefalutLoginInfo];
    
    UIAsyncImageView *userHeardImg = [[UIAsyncImageView alloc] initWithFrame:CGRectMake(0, 24, 65, 65)];
    [userHeardImg setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,dic[@"heed_image_url"]] placeholderImage:defalutHeadImage];
    userHeardImg.layer.cornerRadius = 32.5;
    userHeardImg.clipsToBounds = YES;
    userHeardImg.centerX = WindowWith/2.0;
    [topView addSubview:userHeardImg];
    
    NSString *scoreStr = [NSString stringWithFormat:@"%@",dic[@"experience_info"][@"residual_value"]];
    CGSize size = [IHUtility GetSizeByText:scoreStr sizeOfFont:27 width:WindowWith];
    SMLabel *scoreLbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(0, userHeardImg.bottom + 6, size.width+5, 26) textColor:cGreenColor textFont:boldFont(27)];
    scoreLbl.text = scoreStr;
    scoreLbl.centerX = userHeardImg.centerX;
    [topView addSubview:scoreLbl];
    
    SMLabel *Lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(scoreLbl.right, 0, 12, 12) textColor:cGreenColor textFont:sysFont(12)];
    Lbl.text = @"分";
    Lbl.bottom = scoreLbl.bottom;
    [topView addSubview:Lbl];
    
    UIButton *scoreBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    scoreBtn.frame = CGRectMake(0, scoreLbl.bottom + 10, 105, 34);
    scoreBtn.right = WindowWith/2.0 - 25;
    [scoreBtn setTitle:@"赚取积分" forState:UIControlStateNormal];
    [scoreBtn setTitleColor:cBlackColor forState:UIControlStateNormal];
    scoreBtn.titleLabel.font = sysFont(15);
    scoreBtn.layer.cornerRadius = 5;
    scoreBtn.layer.borderColor = cGrayLightColor.CGColor;
    scoreBtn.layer.borderWidth = 0.7;
    [scoreBtn addTarget:self action:@selector(MyScoreTask:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:scoreBtn];
    
    UIButton *historyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    historyBtn.frame = CGRectMake(0, scoreLbl.bottom + 10, 105, 34);
    historyBtn.left = WindowWith/2.0 + 25;
    [historyBtn setTitle:@"兑换记录" forState:UIControlStateNormal];
    [historyBtn setTitleColor:cBlackColor forState:UIControlStateNormal];
    historyBtn.titleLabel.font = sysFont(15);
    historyBtn.layer.cornerRadius = 5;
    historyBtn.layer.borderColor = cGrayLightColor.CGColor;
    historyBtn.layer.borderWidth = 0.7;
    [historyBtn addTarget:self action:@selector(MyScoreConvert:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:historyBtn];
    
    size = [IHUtility GetSizeByText:@"积分明细" sizeOfFont:13 width:WindowWith];
    Lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(0, scoreBtn.bottom + 15, size.width, 15) textColor:RGB(190, 190, 190) textFont:sysFont(13)];
    Lbl.text = @"积分明细";
    Lbl.centerX = userHeardImg.centerX;
    [topView addSubview:Lbl];
    
    UIImage *leftImg = Image(@"score_leftDetailed.png");
    UIAsyncImageView *leftImgView = [[UIAsyncImageView alloc] initWithFrame:CGRectMake(0, 0, Lbl.left - 20, leftImg.size.height)];
    leftImgView.image = leftImg;
    leftImgView.centerY = Lbl.centerY;
    [topView addSubview:leftImgView];
    
    UIImage *rightImg = Image(@"score_rightDetailed.png");
    UIAsyncImageView *rightImgView = [[UIAsyncImageView alloc] initWithFrame:CGRectMake(Lbl.right + 20, 0,WindowWith - Lbl.right - 20, rightImg.size.height)];
    rightImgView.image = rightImg;
    rightImgView.centerY = Lbl.centerY;
    [topView addSubview:rightImgView];
    
    dataArray=[[NSMutableArray alloc]init];
    
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight) tableviewStyle:UITableViewStylePlain];
    commTableView.attribute=self;
    commTableView.table.backgroundColor = cLineColor;
    commTableView.table.delegate=self;
    commTableView.table.tableHeaderView = topView;
    [commTableView setupData:dataArray index:57];
    
    [self.view addSubview:commTableView];
    [self loadRefesh];
    
}
-(void)loadRefesh{
    
    NSString *userID;
    if (!USERMODEL.isLogin) {
        userID = @"0";
    }else
    {
        userID = USERMODEL.userID;
    }
    [network userScoreDetailed:userID success:^(NSDictionary *obj) {
        NSArray *arr=obj[@"content"];
        
        [self->dataArray addObjectsFromArray:arr];
        [self->commTableView.table reloadData];
        [self endRefresh];
        
    } failure:^(NSDictionary *obj2) {
        [self endRefresh];
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}
//进入我的积分任务
- (void)MyScoreTask:(UIButton *)button
{
    MYTaskViewController *taskVC = [[MYTaskViewController alloc] init];
    [self pushViewController:taskVC];
}
-(void)backTopClick:(UIButton *)sender{
    [self scrollTopPoint:commTableView.table];
}

//进入积分兑换记录
- (void)MyScoreConvert:(UIButton *)button
{
    ScoreHistoryViewController *vc = [[ScoreHistoryViewController alloc] init];
    [self pushViewController:vc];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
