//
//  JobIntentionViewController.m
//  MiaoTuProject
//
//  Created by Zmh on 14/9/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "JobIntentionViewController.h"
#import "MTChooseViewController.h"
//#import "InformationEditViewController.h"
#import "ChoosePositionViewController.h"
#import "JLAddressPickView.h"

@interface JobIntentionViewController ()<EditInformationDelegate,JLAddressActionSheetDelegate>
{
    
    UIView *_PositionView;
    SMLabel *_Positionlabel;
    
    UIView *_cityView;
    SMLabel *_citylabel;
    int job_type;
    JLAddressPickView *_adressPickView;
    
    NSString *proID;
    NSString *cityID;
    NSString *proStr;
    NSString *cityStr;
}
@end

@implementation JobIntentionViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [network selectPublicDicInfo:1 success:^(NSDictionary *obj) {
        [NSUserDefaults standardUserDefaults];
        
        [IHUtility saveUserDefaluts:obj[@"content"]  key:kUserDefalutPositionInfo];
        
    } failure:^(NSDictionary *obj2) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"管理求职意向"];
    self.view.backgroundColor = cLineColor;
    
    NSArray *arr = @[@"期望职位",@"期望工作城市"];
    for (int i = 0; i<arr.count; i++) {
        UIView *advantageView = [[UIView alloc] initWithFrame:CGRectMake(0, 9 + 50.7*i, WindowWith, 50)];
        advantageView.backgroundColor = [UIColor whiteColor];
        [_BaseScrollView addSubview:advantageView];
        
        CGSize size= [IHUtility GetSizeByText:arr[i] sizeOfFont:14 width:120];
        SMLabel *lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(17.5, 0, size.width, 20) textColor:cBlackColor textFont:sysFont(14)];
        lbl.text = arr[i];
        lbl.centerY = advantageView.height/2.0;
        [advantageView addSubview:lbl];
        
        UIImage *image = Image(@"iconfont-fanhui.png");
        UIImageView *rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
        rightImg.image = image;
        rightImg.centerY = advantageView.height/2.0;
        rightImg.right = advantageView.width - 12;
        rightImg.transform= CGAffineTransformMakeRotation(M_PI);
        [advantageView addSubview:rightImg];
        
        lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(lbl.right + 8, 0, rightImg.left -lbl.right -16 , 20) textColor:cGrayLightColor textFont:sysFont(14)];
        lbl.text = @"暂无";
        lbl.textAlignment = NSTextAlignmentRight;
        lbl.centerY = advantageView.height/2.0;
        [advantageView addSubview:lbl];
        
        //判断用户是否已经填写过求职意向 如果有就显示原先填写的信息
        if (self.purposeDic.allKeys.count > 0) {
            if (i==0) {
                lbl.text = self.purposeDic[@"job_name"];
                job_type = [self.purposeDic[@"job_name_id"] intValue];
            }else {
                lbl.text = self.purposeDic[@"work_city"];
                proStr = self.purposeDic[@"work_province"];
                proID = [NSString stringWithFormat:@"%@",self.purposeDic[@"province_id"]];
                cityStr = [NSString stringWithFormat:@"%@",self.purposeDic[@"work_city"]];
                cityID = [NSString stringWithFormat:@"%@",self.purposeDic[@"city_id"]];
            }
        }
        
        if (i==0){
            _PositionView = advantageView;
            _Positionlabel = lbl;
        }else {
            _cityView = advantageView;
            _citylabel = lbl;
        }
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBaseView:)];
    tap.numberOfTapsRequired= 1;
    tap.numberOfTouchesRequired= 1;
    [self.view addGestureRecognizer:tap];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(18, WindowHeight - 60, WindowWith - 36, 38)];
    [btn setTitle:@"保  存" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 20.0;
    btn.backgroundColor = cGreenColor;
    btn.titleLabel.font = sysFont(15);
    [btn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    //选择职位之后通过通知传递职位名称以及ID
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setPosition:) name:NotificationChoosePosition object:nil];
    
}
-(void)setPosition:(NSNotification *)dic{
    
    _Positionlabel.text=dic.userInfo[@"key"];
    job_type=[dic.userInfo[@"id"] intValue];
}
- (void)submit:(UIButton *)button{
    
    if (_Positionlabel.text.length==0|| [_Positionlabel.text isEqualToString:@"暂无"]) {
        [IHUtility addSucessView:@"未填写期望职位" type:2];
        return;
    }
    
    if (_citylabel.text.length==0|| [_citylabel.text isEqualToString:@"暂无"]) {
        [IHUtility addSucessView:@"未选择期望工作城市" type:2];
        return;
    }
    
    //如果已经保存过求职意向 再一次编辑保存时需调保存接口
    if (self.purposeDic.allKeys.count > 0) {
        //保存求职意向
        [network updateUserJobIntentionInfo:proID work_province:proStr city_id:cityID work_city:cityStr job_name_id:stringFormatInt(job_type) job_name:_Positionlabel.text success:^(NSDictionary *obj) {
            
            //保存成功之后返回上一级并将信息带到上级
            [self.delegate disPalyJobIntention:stringFormatInt(self->job_type) Pro_id:self->proID ProStr:self->proStr city_id:self->cityID cityStr:self->cityStr];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        } failure:^(NSDictionary *obj2) {
            
        }];
    }else{
        //保存成功之后返回上一级并将信息带到上级
        [self.delegate disPalyJobIntention:stringFormatInt(job_type) Pro_id:proID ProStr:proStr city_id:cityID cityStr:cityStr];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)tapBaseView:(UITapGestureRecognizer *)tap
{
    CGPoint point = [tap locationInView:self.view];
    if (CGRectContainsPoint(_PositionView.frame, point)){
        
        ChoosePositionViewController *vc=[[ChoosePositionViewController alloc]init];
        vc.Poptype = 1;
        vc.selectBlock=^(NSInteger index,NSString *str){
            self->_Positionlabel.text=str;
            self->job_type = (int)index;
        };
        [self pushViewController:vc];
        
    }else if (CGRectContainsPoint(_cityView.frame, point)){
        
        [self chooseAdress:@"城市选择" tag:1000];
    }
}
//选择地址
- (void)chooseAdress:(NSString *)title tag:(NSInteger)tag
{
    
    if(_adressPickView == nil)
    {
        _adressPickView = [[JLAddressPickView alloc] initWithParams:title type:0];
        _adressPickView.tag=tag;
        _adressPickView.ActionSheetDelegate = self;
    }
    [_adressPickView show];
    
}
//接收选择的城市和省份名称
- (void)ActionSheetDoneHandle:(JLAddressPickView *)pickViewComponent selectedProData:(NSString *)SelectedStr selectedCityData:(NSString *)SelectedCityStr
{
    
    _citylabel.text = SelectedCityStr;
    proStr = SelectedStr;
    cityStr = SelectedCityStr;
}
//接收选择的城市和省份ID
- (void)ActionSheetDoneHandle:(JLAddressPickView *)pickViewComponent selectedProIndex:(NSInteger)index selectedCityIndex:(NSInteger)cityIndex
{
    
    if (index>0) {
        proID = stringFormatInt((int)index);
    }
    
    if (cityIndex>0) {
        cityID = stringFormatInt((int)cityIndex);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
