//
//  PositionChooseViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/10/9.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "PositionChooseViewController.h"
#import "PositionChooseView.h"
@interface PositionChooseViewController ()
{
    NSInteger _i;
}
@end

@implementation PositionChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:self.text];
    
    PositionChooseView *chooseView=[[PositionChooseView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight) dic:self.dic];
    
    
    chooseView.selectBlock=^(NSString *str){
        
        for (NSDictionary *dic in self.arr) {
            
            for (NSDictionary *Dic in dic[@"childDic"]) {
       
                for (NSDictionary *dic3 in Dic[@"childDic"]) {
                    
                    if ([str isEqualToString:dic3[@"job_name"]]) {
						self->_i=[dic3[@"id"] integerValue];
                    }
                }

            }
        }
		NSDictionary *dic=@{@"key":str,@"id":[NSString stringWithFormat:@"%ld",self->_i]};
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationChoosePosition object:nil userInfo:dic];
        
        if (self.Poptype == 1) {
            NSArray *ViewControllers=self.navigationController.viewControllers;
            int index = (int)[ViewControllers indexOfObject:self];
            [self popViewController:index - 2];
        }else {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    };
    if (self.index) {
        UIButton *btn=[chooseView viewWithTag:self.index];
        [chooseView submitClick:btn];
    }
    
    [self.view addSubview:chooseView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
