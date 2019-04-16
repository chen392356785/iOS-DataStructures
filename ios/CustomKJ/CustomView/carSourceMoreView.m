//
//  carSourceMoreView.m
//  MiaoTuProject
//
//  Created by Zmh on 27/5/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "carSourceMoreView.h"

@implementation carSourceMoreView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame dic:(NSDictionary *)dic
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTapGestureRecognizerToSelf];
        [self setUI:dic];
    }
    return self;
}
//添加轻拍手势隐藏更多页面
-(void)addTapGestureRecognizerToSelf
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenBottomView)];
    [self addGestureRecognizer:tap];
}
//隐藏”更多“界面
- (void)hiddenBottomView {
    if (self.hidden) {
        return;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    }completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

-(void)setUI:(NSDictionary *)dic{
    _dic=dic;
    _arr=[[NSMutableArray alloc]init];
    self.backgroundColor= RGBA(0, 0, 0, 0.4);
    topY = 0;
    
    NSDictionary *sourceDic = dic;
    NSArray *classArr = [sourceDic allKeys];
//    _classArr = classArr;
    UIView *classview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 374)];
//    _classView = classview;
    classview.backgroundColor = [UIColor whiteColor];
    for (int i=0; i < classArr.count; i ++) {
        NSDictionary *Dic=@{classArr[i]:@[]};
        [_arr addObject:Dic];
        NSArray *arr = [sourceDic objectForKey:classArr[i]];
        int row = (int)(arr.count-1)/3 + 1;
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, topY,self.width , row*43 + 13)];
        view.tag=1000+i;
        topY = topY + view.height;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 13, 30, 35)];
        label.backgroundColor = [UIColor clearColor];
        label.font = sysFont(14);
        label.textColor = RGB(108, 123, 138);
        label.text = classArr[i];
        label.numberOfLines = 0;
        [view addSubview:label];
        
        for (int j=0; j<arr.count; j++) {
            
            float width = (kScreenWidth - (13*3 + 7 +label.right))/3.0;
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(j%3 *(width+13) + label.right + 7, (int)(j/3)*43+13, width, 30)];
            [button setBackgroundImage:[ConfigManager createImageWithColor:RGB(237, 240, 245)] forState:UIControlStateNormal];
            [button setBackgroundImage:[ConfigManager createImageWithColor:RGB(85, 201, 196)] forState:UIControlStateSelected];
            button.tag=i*100+j;
            button.titleLabel.font = sysFont(15);
            [button setTitle:arr[j] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [button setTitleColor:RGB(108, 123, 138) forState:UIControlStateNormal];
            [button addTarget:self action:@selector(selectedClass:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:button];
            
        }
        
        [classview addSubview:view];
    }
    
    UIButton *canlcebutton = [[UIButton alloc] initWithFrame:CGRectMake(20, topY, (kScreenWidth - 50) /3.0, 40)];
    
    [canlcebutton setTitle:@"清空" forState:UIControlStateNormal];
    [canlcebutton setTitleColor:RGB(85, 201, 196) forState:UIControlStateNormal];
    canlcebutton.layer.borderColor = RGB(85, 201, 196).CGColor;
    canlcebutton.layer.borderWidth = 1.0;
    self.cancleBtn = canlcebutton;
    [canlcebutton addTarget:self action:@selector(qingkong) forControlEvents:UIControlEventTouchUpInside];
    [classview addSubview:canlcebutton];
    
    UIButton *referbutton = [[UIButton alloc] initWithFrame:CGRectMake(canlcebutton.right + 10, topY, (kScreenWidth - 50) /3.0 * 2 , 40)];
    [referbutton setTitle:@"确定" forState:UIControlStateNormal];
    [referbutton addTarget:self action:@selector(queding) forControlEvents:UIControlEventTouchUpInside];
    [referbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    referbutton.backgroundColor = RGB(85, 201, 196);
    [classview addSubview:referbutton];
    self.referBtn = referbutton;
    [self addSubview:classview];
    
    classview.height=referbutton.bottom+20;

}


-(void)qingkong{
    
   //[_arr removeAllObjects];
    
    [self removeAllSubviews];
    [self setUI:_dic];
    
//    for (int i=0; i < _classArr.count; i ++) {
//        
//        NSDictionary *Dic=@{_classArr[i]:@[]};
//        [_arr addObject:Dic];
//        
//         NSArray *arr = [_dic objectForKey:_classArr[i]];
//        for (int j=0; j<arr.count; j++){
//            UIView *view=[_classView viewWithTag:1000+i];
//            UIButton *btn=[view viewWithTag:100*i+j];
//            btn.selected=NO;
//        }
//
//    }
    
}

-(void)queding{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    }completion:^(BOOL finished) {
        self.hidden = YES;
    }];
    self.selectBlock(_arr);
   
   // NSLog(@"%@",_arr);
}

- (void)selectedClass:(UIButton *)button
{
    
  
    NSArray *classArr = [_dic allKeys];
    
    button.selected = !button.selected;
    
    NSArray *arr1=[[NSArray alloc]initWithArray:_arr];
    for (NSInteger i=0; i<classArr.count; i++) {
        NSArray *arr=_dic[classArr[i]];
        for (NSString *str in arr) {
            
            if ( [str isEqualToString:button.titleLabel.text]) {
                
                for (NSDictionary *dic in arr1) {
                    if ([dic.allKeys[0] isEqualToString:classArr[i]]) {
                        NSMutableArray *Arr=[[NSMutableArray alloc]initWithArray:dic[dic.allKeys[0]]];
                        
                        if (button.selected) {
                            [Arr addObject:button.titleLabel.text];
                            
                        }else{
                            [Arr removeObject:button.titleLabel.text];
                        }

                        
                        NSMutableDictionary *Dic=[[NSMutableDictionary alloc]initWithDictionary:dic];
                        [Dic setObject:Arr forKey:classArr[i]];
                        [_arr removeObject:dic];
                        [_arr addObject:Dic];
                    }
                }
                
            }
        }
        
        
    }

    
    
    
    
    
}
@end
