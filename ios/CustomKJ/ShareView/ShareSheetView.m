//
//  ShareSheetView.m
//  TaSayProject
//
//  Created by Mac on 15/8/5.
//  Copyright (c) 2015年 xubin. All rights reserved.
//

// 每个按钮的高度


#define BtnHeight 50
// 取消按钮上面的间隔高度
#define Margin 8

#define HJCColor(r, g, b) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0]
// 背景色
#define GlobelBgColor HJCColor(248, 248, 250)
// 分割线颜色
#define GlobelSeparatorColor HJCColor(226, 226, 226)
// 普通状态下的图片
#define normalImage1 [self createImageWithColor:HJCColor(248, 248, 250)]
// 高亮状态下的图片
#define highImage1 [self createImageWithColor:HJCColor(242, 242, 242)]

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
// 字体
#define HeitiLight(f) [UIFont fontWithName:@"STHeitiSC-Light" size:f]
#import "ShareSheetView.h"

@interface ShareSheetView ()
{
//    int _tag;
    NSArray *arr;
    UIImageView * _imageView;
}

@property (nonatomic, weak) ShareSheetView *actionSheet;
@property (nonatomic, weak) UIView *sheetView;

@end

@implementation ShareSheetView

- (instancetype)initWithFrame:(CGRect)frame styleType:(shareViewType )type{
    if (self = [super initWithFrame:frame]) {
        if (type == ShareSmalProgramType) {
            NSString *path=[[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
            NSDictionary *root=[[NSDictionary alloc] initWithContentsOfFile:path];
            arr = [root objectForKey:@"ShareCrowdFund"];
            [self creatBottomView];
        }else if (type == SharePostersType) {
            NSString *path=[[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
            NSDictionary *root=[[NSDictionary alloc] initWithContentsOfFile:path];
            arr = [root objectForKey:@"SharePosters"];
            [self createSharePosters];
        }
    }
    return self;
}
-(void)setCodImage:(NSString *)codImage {
    [_imageView sd_setImageWithURL:[NSURL URLWithString:codImage] placeholderImage:Image(@"")];
   
}
- (void) createSharePosters {
    ShareSheetView *actionSheet = self;
    self.actionSheet = actionSheet;
    // 黑色遮盖
    actionSheet.frame = [UIScreen mainScreen].bounds;
    actionSheet.backgroundColor = [UIColor blackColor];
    [[UIApplication sharedApplication].keyWindow addSubview:actionSheet];
    actionSheet.alpha = 0.0;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverClick)];
    [actionSheet addGestureRecognizer:tap];
    
    // sheet
    UIView *sheetView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    sheetView.backgroundColor = GlobelBgColor;
    sheetView.alpha =1;
    
    [[UIApplication sharedApplication].keyWindow addSubview:sheetView];
    self.sheetView = sheetView;
    sheetView.hidden = YES;
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, KtopHeitht+ kWidth(10)+KTabSpace, kWidth(260), kWidth(390))];
    _imageView.centerX = self.centerX;
    [[UIApplication sharedApplication].keyWindow addSubview: _imageView];
    
//    _tag = 4;
    SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, 20, ScreenWidth, 20) textColor:cBlackColor textFont:sysFont(15)];
    lbl.text=@"分享到";
    lbl.textAlignment=NSTextAlignmentCenter;
    [sheetView addSubview:lbl];
    
    float btnWidth=(WindowWith-28)/4;
    UIScrollView *scoll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, lbl.bottom, WindowWith, 227)];
    scoll.showsHorizontalScrollIndicator=NO;
    // scoll.contentSize=CGSizeMake(arr.count*btnWidth, scoll.height);
    [sheetView addSubview:scoll];
    for (int i=0; i<arr.count; i++) {
        
        NSDictionary *dic=[arr objectAtIndex:i];
        UIImage *img=Image(dic[@"image"]);
        int j=0, h=0;
        if (i>3) {
            j=4;
            h=100;
        }
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        float x=btnWidth/2-img.size.width/2+4;
        btn.frame=CGRectMake(btnWidth*(i-j)+x,15+h, btnWidth ,100);
        
        UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(btn.width/2-img.size.width/2, 5, img.size.width, img.size.height)];
        imgView.image=img;
        [btn addSubview:imgView];
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, imgView.bottom+7, btnWidth, 20) textColor:cBlackColor textFont:sysFont(13)];
        lbl.textAlignment=NSTextAlignmentCenter;
        lbl.text=dic[@"title"];
        [btn addSubview:lbl];
        
        //  btn.frame=CGRectMake(btnWidth*i+x,15, img.size.width, img.size.height);
        btn.tag=[dic[@"PlatformType"]intValue];
        //  [btn setBackgroundImage:img forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
        [scoll addSubview:btn];
    }
    
    UIImageView *lineIMG=[[UIImageView alloc]initWithFrame:CGRectMake(0, scoll.bottom, ScreenWidth, 1)];
    lineIMG.image=[IHUtility imageWithColor:cLineColor andSize:CGSizeMake(ScreenWidth, 1)];
    [sheetView addSubview:lineIMG];
    
    
    CGRect sheetViewF = sheetView.frame;
    sheetViewF.size.height = kWidth(200);
    sheetView.frame = sheetViewF;
    
    UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(0, lineIMG.bottom+25, ScreenWidth, 8)];
    //  bgView.backgroundColor=cHeadbkColor;
    [sheetView addSubview:bgView];
    
    // 取消按钮
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth - kWidth(40), 15, kWidth(25), kWidth(25))];
    [btn setBackgroundImage:[Image(@"icon_guanbi.png") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
//    [btn setBackgroundImage:highImage1 forState:UIControlStateHighlighted];
//    [btn setTitle:@"取 消" forState:UIControlStateNormal];
//    [btn setTitleColor:cGreenColor forState:UIControlStateNormal];
//    btn.titleLabel.font = sysFont(17);
    btn.tag = 0;
    [btn addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
    [self.sheetView addSubview:btn];
}

//分享朋友圈
- (void) creatBottomView {
	
    ShareSheetView *actionSheet = self;
    self.actionSheet = actionSheet;
    // 黑色遮盖
    actionSheet.frame = [UIScreen mainScreen].bounds;
    actionSheet.backgroundColor = [UIColor blackColor];
    [[UIApplication sharedApplication].keyWindow addSubview:actionSheet];
    actionSheet.alpha = 0.0;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverClick)];
    [actionSheet addGestureRecognizer:tap];
    
    // sheet
    UIView *sheetView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-kWidth(81), 0)];
    sheetView.backgroundColor = GlobelBgColor;
    sheetView.alpha =1;
    sheetView.centerX = self.centerX;
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:sheetView];
    self.sheetView = sheetView;
    sheetView.hidden = YES;
    
//    _tag = 4;
	
    SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, kWidth(10), width(sheetView), kWidth(50)) textColor:cBlackColor textFont:sysFont(font(18))];
    lbl.text=@"分享到";
    lbl.textAlignment=NSTextAlignmentCenter;
    [sheetView addSubview:lbl];
    
    float btnWidth=kWidth(94);
        
    UIScrollView *scoll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, lbl.bottom, width(sheetView), kWidth(160))];
    scoll.showsHorizontalScrollIndicator=NO;
    // scoll.contentSize=CGSizeMake(arr.count*btnWidth, scoll.height);
    [sheetView addSubview:scoll];
    for (int i=0; i<arr.count; i++) {
        
        NSDictionary *dic=[arr objectAtIndex:i];
        UIImage *img=Image(dic[@"image"]);
        int j=0, h=0;
        if (i>3) {
            j=4;
            h=100;
        }
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//        float x=btnWidth/2-img.size.width/2+4;
        float x=(width(sheetView)-3*btnWidth)/4;
        btn.frame=CGRectMake(btnWidth*(i-j)+x,15+h, btnWidth ,100);
        
        UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(btn.width/2-img.size.width/2, 5, img.size.width, img.size.height)];
        imgView.image=img;
        [btn addSubview:imgView];
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, imgView.bottom+7, btnWidth, 20) textColor:cBlackColor textFont:sysFont(13)];
        lbl.textAlignment=NSTextAlignmentCenter;
        lbl.text=dic[@"title"];
        [btn addSubview:lbl];
        
        //  btn.frame=CGRectMake(btnWidth*i+x,15, img.size.width, img.size.height);
        btn.tag=[dic[@"PlatformType"]intValue];
        //  [btn setBackgroundImage:img forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
        [scoll addSubview:btn];
    }
    
    
    CGRect sheetViewF = sheetView.frame;
    sheetViewF.size.height = kWidth(200);
    sheetView.frame = sheetViewF;
    sheetView.layer.cornerRadius = kWidth(10);
    
    // 取消按钮
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, scoll.bottom + kWidth(10), kWidth(30), kWidth(30))];
    [btn setBackgroundImage:[Image(@"icon_gbtc.png")imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    btn.layer.cornerRadius = kWidth(15);
    btn.clipsToBounds = YES;
    btn.alpha = 0.7;
    btn.centerX = scoll.centerX;
//    [btn setBackgroundImage:highImage1 forState:UIControlStateHighlighted];
//    [btn setTitle:@"取 消" forState:UIControlStateNormal];
//    [btn setTitleColor:cGreenColor forState:UIControlStateNormal];
//    btn.titleLabel.font = sysFont(17);
    btn.tag = 0;
    [btn addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
    [sheetView addSubview:btn];
    
}

-(instancetype)initWithShare{
    ShareSheetView *actionSheet = [self init];
    self.actionSheet = actionSheet;
    
    // 黑色遮盖
    actionSheet.frame = [UIScreen mainScreen].bounds;
    actionSheet.backgroundColor = [UIColor blackColor];
    [[UIApplication sharedApplication].keyWindow addSubview:actionSheet];
    actionSheet.alpha = 0.0;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverClick)];
    [actionSheet addGestureRecognizer:tap];
    
    // sheet
    UIView *sheetView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    sheetView.backgroundColor = GlobelBgColor;
    sheetView.alpha =1;
    
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:sheetView];
    self.sheetView = sheetView;
    sheetView.hidden = YES;
    
//    _tag = 4;
	
    SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, 20, ScreenWidth, 20) textColor:cBlackColor textFont:sysFont(15)];
    lbl.text=@"分享到";
    lbl.textAlignment=NSTextAlignmentCenter;
    [sheetView addSubview:lbl];
    
    float btnWidth=(WindowWith-28)/4;
    arr =[ConfigManager getShareMenuList];
    UIScrollView *scoll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, lbl.bottom, WindowWith, 227)];
    scoll.showsHorizontalScrollIndicator=NO;
   // scoll.contentSize=CGSizeMake(arr.count*btnWidth, scoll.height);
    [sheetView addSubview:scoll];
    for (int i=0; i<arr.count; i++) {
        
        NSDictionary *dic=[arr objectAtIndex:i];
        UIImage *img=Image(dic[@"image"]);
        int j=0, h=0;
        if (i>3) {
            j=4;
            h=100;
        }
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
              float x=btnWidth/2-img.size.width/2+4;
        btn.frame=CGRectMake(btnWidth*(i-j)+x,15+h, btnWidth ,100);
        
        UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(btn.width/2-img.size.width/2, 5, img.size.width, img.size.height)];
        imgView.image=img;
        [btn addSubview:imgView];
        
        lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, imgView.bottom+7, btnWidth, 20) textColor:cBlackColor textFont:sysFont(13)];
        lbl.textAlignment=NSTextAlignmentCenter;
        lbl.text=dic[@"title"];
        [btn addSubview:lbl];
  
      //  btn.frame=CGRectMake(btnWidth*i+x,15, img.size.width, img.size.height);
        btn.tag=[dic[@"PlatformType"]intValue];
      //  [btn setBackgroundImage:img forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
        [scoll addSubview:btn];
    }
    
    
    
    
    UIImageView *lineIMG=[[UIImageView alloc]initWithFrame:CGRectMake(0, scoll.bottom, ScreenWidth, 1)];
    lineIMG.image=[IHUtility imageWithColor:cLineColor andSize:CGSizeMake(ScreenWidth, 1)];
    [sheetView addSubview:lineIMG];
 
 
    
//    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(0, lineIMG.bottom, ScreenWidth, 38)];
//    [btn2 setBackgroundImage:normalImage1 forState:UIControlStateNormal];
//    [btn2 setBackgroundImage:highImage1 forState:UIControlStateHighlighted];
//    [btn2 setTitle:@"举报" forState:UIControlStateNormal];
//    [btn2 setTitleColor:[IHUtility colorWithHexString:@"#eb4748"] forState:UIControlStateNormal];
//    btn2.titleLabel.font = sysFont(14);
//    btn2.tag = TopicReport;
//    [btn2 addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    CGRect sheetViewF = sheetView.frame;
    sheetViewF.size.height = 321;
    sheetView.frame = sheetViewF;
    
    UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(0, lineIMG.bottom+25, ScreenWidth, 8)];
  //  bgView.backgroundColor=cHeadbkColor;
    [sheetView addSubview:bgView];
    
    // 取消按钮
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, sheetView.frame.size.height - 53, ScreenWidth, 53)];
    [btn setBackgroundImage:normalImage1 forState:UIControlStateNormal];
    [btn setBackgroundImage:highImage1 forState:UIControlStateHighlighted];
    [btn setTitle:@"取 消" forState:UIControlStateNormal];
    [btn setTitleColor:cGreenColor forState:UIControlStateNormal];
    btn.titleLabel.font = sysFont(17);
    btn.tag = 0;
    [btn addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
    [self.sheetView addSubview:btn];
    
    return actionSheet;
}
- (void) creteBottomUI {
    
    
}


-(void)shareClick:(UIButton *)sender{
    self.selectShareMenu(sender.tag);
    [self coverClick];
}

- (void)coverClick{
    CGRect sheetViewF = self.sheetView.frame;
    sheetViewF.origin.y = ScreenHeight;
    [_imageView removeFromSuperview];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.sheetView.frame = sheetViewF;
        self.actionSheet.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.actionSheet removeFromSuperview];
        [self.sheetView removeFromSuperview];
    }];
}


- (void)show{
    self.sheetView.hidden = NO;
    
    CGRect sheetViewF = self.sheetView.frame;
    sheetViewF.origin.y = ScreenHeight;
    self.sheetView.frame = sheetViewF;
    
    CGRect newSheetViewF = self.sheetView.frame;
    newSheetViewF.origin.y = ScreenHeight - self.sheetView.frame.size.height;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.sheetView.frame = newSheetViewF;
        
        self.actionSheet.alpha = 0.3;
    }];
}

//弹出到屏幕中心
- (void) showCentY{
    self.sheetView.hidden = NO;
    CGRect sheetViewF = self.sheetView.frame;
    sheetViewF.origin.y = ScreenHeight;
    self.sheetView.frame = sheetViewF;
    
    CGRect newSheetViewF = self.sheetView.frame;
    newSheetViewF.origin.y = (ScreenHeight - self.sheetView.frame.size.height)/2.;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.sheetView.frame = newSheetViewF;
        
        self.actionSheet.alpha = 0.3;
    }];
}


- (UIImage*)createImageWithColor:(UIColor*)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
