//
//  MTTabBar.m
//  MiaoTuProject
//
//  Created by Mac on 16/3/9.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTTabBar.h"

@implementation MTTabBar
- (void)addButtonWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage index :(int)index title:(NSString *)title{
    
    indexFlag=0;
    // [self setBackgroundColor:RGBA(255, 255, 255, 0.9)];
    
    CGRect rect = self.bounds;
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
    rect.size.height = TFTabBarHeight;
    rect.origin.y = -5;
    
    //   self.layer.masksToBounds = NO;
    //  self.layer.shadowOffset = CGSizeMake(0, 3);
    //  self.layer.shadowOpacity = 0.2;
    //  self.layer.shadowPath = [UIBezierPath bezierPathWithRect:rect].CGPath;
    //  self.layer.shadowColor = RGBA(59, 74, 116, 1).CGColor;
    
    
    
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    // [btn setBackgroundImage:[ConfigManager createImageWithColor:cLineColor] forState:UIControlStateSelected];
    // [btn setBackgroundImage:[ConfigManager createImageWithColor:cLineColor] forState:UIControlStateHighlighted];
    CGFloat btnWidth=WindowWith/4;
    
    CGFloat x=index*btnWidth;
    
    int y=3;
    if (index==5) {
        y=-16;
    }
    
    btn.frame=CGRectMake(x, 0, btnWidth, 57);
    UIImageView *btnImage=[[UIImageView alloc]initWithFrame:CGRectMake(btnWidth/2-image.size.width/2, y, image.size.width, image.size.height)];
    btnImage.tag=10+index;
    btnImage.image=image;
    [btn addSubview:btnImage];
    
    
    
    
    //    if (index!=2) {
    SMLabel *lbl=[[SMLabel alloc]initWithFrame:CGRectMake(0, btnImage.bottom+2, btnWidth, 10)];
    lbl.font=boldFont(10);
    lbl.textColor=RGB(157, 157, 169);
    lbl.text=title;
    lbl.tag=100+index;
    lbl.textAlignment=NSTextAlignmentCenter;
    [btn addSubview:lbl];
    //    }
    btn.tag=1000+index;
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    if (  index==4) {
        UIImage *img=Image(@"redpoint.png");
        UIImageView *redIMG=[[UIImageView alloc]initWithFrame:CGRectMake(x+btnImage.right, btnImage.top, img.size.width, img.size.height)];
        redIMG.image=img;
        redIMG.hidden=YES;
        
        _meRedImageView=redIMG;
        //        if (index==3) {
        //            _gcRedImageView=redIMG;
        //        }else if (index==4){
        //
        //        }
        [self addSubview:redIMG];
    }
    
    if (index==3) {
        CornerView *view=[[CornerView alloc]initWithFrame:CGRectMake(x+btnImage.right-8, btnImage.top, 15, 10) count:0];//
        _cornerview=view;
        
        //        [self addSubview:view];           //tabBar角标 学习
    }
    
    
    //如果是第一个按钮, 则选中(按顺序一个个添加)
    if (index == 0) {
        UIImage *img=Image(@"redpoint.png");
        UIImageView *redIMG=[[UIImageView alloc]initWithFrame:CGRectMake(x+btnImage.right, btnImage.top, img.size.width, img.size.height)];
        redIMG.image=img;
        redIMG.hidden=YES;
        
        _gcRedImageView=redIMG;
        [self addSubview:redIMG];
        
        [self clickBtn:btn];
    }
    
}




-(void)setMessageNum:(int)num{
    [_cornerview setNum:num];
    //  _gcRedImageView.hidden=ishidden;
}

-(void)setGCRedHidden:(BOOL)isHidden{
    _gcRedImageView.hidden=isHidden;
}


-(void)setMeRedHidden:(BOOL)isHidden{
    _meRedImageView.hidden=isHidden;
}

/**
 *  自定义TabBar的按钮点击事件
 */
- (void)clickBtn:(UIButton *)button {
    
    
    
    
    NSInteger index=button.tag-1000;
    
    if (indexFlag!=index) {
        [self animationWithIndex:index];
    }
    
    //    if (index==4||index==3) { //没登录
    if (index==3 ||index==1) { //没登录
        if (!USERMODEL.isLogin) {
            [[NSNotificationCenter defaultCenter]postNotificationName:NotificationLoginIn object:nil];
            return;
        }
    }
    
    if (index==5) {  //弹出效果 直接跳入
        [self.delegate tabBar:self selectedFrom:self.selectedBtn.tag to:button.tag];
        
        return;
    }
    
    NSInteger oldIndex=self.selectedBtn.tag-1000;
    
    if (index==oldIndex) {
        return;
    }
    
    SMLabel *lbl=[button viewWithTag:index+100];
    lbl.textColor=cGreenColor;
    
    
    NSArray * _tabConfigList = [ConfigManager getMainConfigList];
    NSDictionary *dic=[_tabConfigList objectAtIndex:index];
    NSString *imageNameSel = [dic objectForKey:@"highlightedImage"];
    
    UIImageView *imgView=[button viewWithTag:index+10];
    
    
    imgView.image=Image(imageNameSel);
    self.selectedBtn.selected = NO;
    
    if (oldIndex<0) {
        oldIndex=0;
    }
    
    lbl=[self.selectedBtn viewWithTag:oldIndex+100];
    lbl.textColor=RGB(157, 157, 169);
    
    imgView=[self.selectedBtn viewWithTag:oldIndex+10];
    NSDictionary *dic2=[_tabConfigList objectAtIndex:oldIndex];
    NSString *imageNameunSel = [dic2 objectForKey:@"image"];
    imgView.image=Image(imageNameunSel);
    
    //2.再将当前按钮设置为选中
    button.selected = YES;
    
    //3.最后把当前按钮赋值为之前选中的按钮
    self.selectedBtn = button;
    
    //1.先将之前选中的按钮设置为未选中
    
    //却换视图控制器的事情,应该交给controller来做
    //最好这样写, 先判断该代理方法是否实现
    
    if (index!=5) {
        if ([self.delegate respondsToSelector:@selector(tabBar:selectedFrom:to:)]) {
            [self.delegate tabBar:self selectedFrom:self.selectedBtn.tag to:button.tag];
        }
    }
    
}


- (void)animationWithIndex:(NSInteger) index {
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    
    for (NSInteger i=0; i<4; i++) {
        UIButton *btn=[self viewWithTag:1000+i];
        [tabbarbuttonArray addObject:btn];
    }
    //    for (UIButton *tabBarButton in self.subviews) {
    //        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
    //            [tabbarbuttonArray addObject:tabBarButton];
    //        }
    //    }
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.08;
    pulse.repeatCount= 1;
    pulse.autoreverses= YES;
    pulse.fromValue= [NSNumber numberWithFloat:0.7];
    pulse.toValue= [NSNumber numberWithFloat:1.3];
    [[tabbarbuttonArray[index] layer]
     addAnimation:pulse forKey:nil];
    
    indexFlag = (int)index;
    
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end


