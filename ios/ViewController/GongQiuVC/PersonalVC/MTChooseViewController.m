//
//  MTChooseViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/7/18.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTChooseViewController.h"
#import "CustomView+CustomCategory2.h"

@interface MTChooseViewController ()
{
    NSArray *_arr;
}
@end

@implementation MTChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:self.text];
    [self addPushViewWaitingView];
    //   self.view.backgroundColor=RGB(221, 221, 221);
    
    int dicType = 0;
    if (self.type==SelectLabelBlock) {
        dicType=2;
    }else if (self.type==SelectPositiontypeBlock){
        dicType=1;
    }
    
    
    [network selectPublicDicInfo:dicType success:^(NSDictionary *obj) {
        [self removePushViewWaitingView];
        self->_arr=obj[@"content"];
        
        NSMutableDictionary *Dic=[[NSMutableDictionary alloc]init];
        for (NSDictionary *dic in self->_arr) {
            NSMutableArray *Arr=[[NSMutableArray alloc]init];
            NSArray *arr=dic[@"data"];
            for (NSDictionary *obj in arr) {
                
                if (dicType==1) {
                    [Arr addObject:obj[@"job_name"]];
                }else if (dicType==2){
                    [Arr addObject:obj[@"title_name"]];
                }
            }
            
            [Dic setObject:Arr forKey:dic[@"title"]];
        }
        
        AreaView *areaV = [[AreaView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight) dataDic:Dic grade:1];
        areaV.btn.hidden=YES;
        areaV.backScroll.height = areaV.height;
        areaV.backScroll.backgroundColor=RGB(250, 250, 250);
        areaV.selectBlock=^(NSString *str1,NSString *str2){
            NSLog(@"%@",str2);
            [self.delegate displayTiyle:str2 type:self.type];
        };
        areaV.selectBtnBlock=^(NSInteger index){
            
            [self back:nil];
        };
        [self.view addSubview:areaV];
        
        
    } failure:^(NSDictionary *obj2) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
