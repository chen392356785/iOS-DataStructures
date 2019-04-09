//
//  AdditionalRequirementViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 17/1/9.
//  Copyright © 2017年 xubin. All rights reserved.
//

#import "AdditionalRequirementViewController.h"

@interface AdditionalRequirementViewController ()
{
    NSString *_zhuanghuoType;
    NSString *_luduan;
    NSString *_direverNumber;
    NSString *_payType;
    
}
@end

@implementation AdditionalRequirementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"其他要求"];
    _zhuanghuoType=self.ZhuanghuoType;
    _luduan=self.Luduan;
    _direverNumber=self.DireverNumber;
    _payType=self.PayType;
    
    
    NSArray *arr=@[@"装货型态",@"全程路段",@"跟车司机人数",@"支付方式"];
    for (NSInteger i=0; i<arr.count; i++) {
        RequirementChooseView *view=[[RequirementChooseView alloc]initWithFrame:CGRectMake(12, 9+50*i, WindowWith-24, 50) text:arr[i]];
        [self.view addSubview:view];
        if (i==0) {
           // CGSize size=[IHUtility GetSizeByText:@"装货形态" sizeOfFont:15 width:100];
            
           
            
            [view setDataWith:@[@"超高",@"超宽",@"超长"] isSigle:NO text:_ZhuanghuoType];
            view.selectArrBtnBlock=^(NSArray *arr){
                if (arr.count==1) {
                    self->_zhuanghuoType=[NSString stringWithFormat:@"%@",arr[0]];
                }else if (arr.count==2){
                    self->_zhuanghuoType=[NSString stringWithFormat:@"%@,%@",arr[0],arr[1]];
                }else if (arr.count==3){
                    self->_zhuanghuoType=[NSString stringWithFormat:@"%@,%@,%@",arr[0],arr[1],arr[2]];
                }
                
            };
        }else if (i==1){
            [view setDataWith:@[@"高速",@"非高速"] isSigle:YES text:_luduan];
            view.selectBtn=^(NSString *str){
                self->_luduan=str;
            };
        }else if (i==2){
            [view setDataWith:@[@"1人",@"2人"] isSigle:YES text:_direverNumber];
            view.selectBtn=^(NSString *str){
                self->_direverNumber=str;
            };
        }else if (i==3){
            [view setDataWith:@[@"现金",@"银行转账"] isSigle:YES text:_payType];
            view.selectBtn=^(NSString *str){
                self->_payType=str;
            };
        }
        
        
    }
    
    UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(26, WindowHeight-55, WindowWith-26*2, 40);
    btn.backgroundColor=cGreenColor;
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font=sysFont(17);
    [btn setLayerMasksCornerRadius:18 BorderWidth:0 borderColor:cGreenColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
}

-(void)back{
    
    self.selectBlock(_zhuanghuoType,_luduan,_direverNumber,_payType);
    [self back:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
