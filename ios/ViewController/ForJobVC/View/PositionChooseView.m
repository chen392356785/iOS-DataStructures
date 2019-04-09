//
//  PositionChooseView.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/10/9.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "PositionChooseView.h"

@implementation PositionChooseView

- (id)initWithFrame:(CGRect)frame dic:(NSDictionary *)dic{
    
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=RGB(247, 248, 250);
        //self.arr=@[@"苗木管理",@"苗木技术",@"苗木销售",@"苗木采购",@"苗木其他"];
        
        self.dic=dic;
        self.arr=[[NSMutableArray alloc]init];
        NSArray *arr=self.dic[self.dic.allKeys[0]];
        for (NSInteger i=0; i<arr.count; i++) {
            NSDictionary *Dic=arr[i];
            
            [self.arr addObject:Dic.allKeys[0]];
        }
  
        for (NSUInteger i=0; i<self.arr.count; i++) {
            
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(0, 0.16*WindowWith*i, 0.293*WindowWith, 0.16*WindowWith);
            btn.titleLabel.font=sysFont(13);
            [btn setTitle:self.arr[i] forState:UIControlStateNormal];
            [btn setTitleColor:cBlackColor forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(submitClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag=1000+i;
            if (i==0) {
                btn.backgroundColor=[UIColor whiteColor];
                [btn setTitleColor:cGreenColor forState:UIControlStateNormal];
            }
            [self addSubview:btn];
        }
        
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0.293*WindowWith, 0, WindowWith-0.293*WindowWith, WindowHeight)];
        view.backgroundColor=[UIColor whiteColor];
        _view=view;
        [self addSubview:view];
        
        //self.Array=@[@"苗圃总经理",@"苗圃主管",@"苗圃副经理",@"苗圃副主管"];
        
        self.Array=[[NSMutableArray alloc]initWithArray:arr];
        
        NSArray *Arr=arr[0][self.arr[0]];
        
        [self creatView:Arr];
     }
    return self;
}

-(void)creatView:(NSArray *)Arr{
    
    int x=0;
    int y=0;
    
    for (NSInteger i=0; i<Arr.count; i++) {
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        int font=13;
        if (WindowWith==320) {
            font=11;
        }else if (WindowWith==414){
            font=15;
        }
        CGSize size=[IHUtility GetSizeByText:Arr[i] sizeOfFont:font width:200];
        [btn setTitle:Arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:cBlackColor forState:UIControlStateNormal];
        btn.titleLabel.font=sysFont(font);
        btn.tag=2000+i;
        [btn setLayerMasksCornerRadius:5 BorderWidth:1 borderColor:cGrayLightColor];
        [btn addTarget:self action:@selector(submitClick2:) forControlEvents:UIControlEventTouchUpInside];
        if (i%2==0) {
            btn.frame=CGRectMake(0.073*WindowWith, 0.04*WindowWith+y, size.width+0.053*WindowWith, 0.08*WindowWith);
            
            y=btn.bottom;
            x=btn.right;
            
        }else{
            
            btn.frame=CGRectMake(0.073*WindowWith+x, y-0.08*WindowWith, size.width+0.053*WindowWith, 0.08*WindowWith);
        }
        [_view addSubview:btn];
    }
}

-(void)submitClick:(UIButton *)sender{
    
    for (NSUInteger i=0; i<self.arr.count; i++){
        UIButton *btn=[self viewWithTag:1000+i];
        btn.backgroundColor=[UIColor clearColor];
        [btn setTitleColor:cBlackColor forState:UIControlStateNormal];
    }
    
    sender.backgroundColor=[UIColor whiteColor];
    [sender setTitleColor:cGreenColor forState:UIControlStateNormal];
    
    [_view removeAllSubviews];
    NSArray *Arr=self.Array[sender.tag-1000][sender.titleLabel.text];
    
    [self creatView:Arr];
}

-(void)submitClick2:(UIButton *)sender{
    
    self.selectBlock(sender.titleLabel.text);
}

@end
