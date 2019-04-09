//
//  IdentAuthViewController.m
//  MiaoTuProject
//
//  Created by Zmh on 30/8/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "IdentAuthViewController.h"
#import "ReferIdentAuthViewController.h"

#define Scale WindowWith/375.0
@interface IdentAuthViewController ()<UIScrollViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIScrollView *_scrollView;
    SMLabel *_lbl;
}
@end

@implementation IdentAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"身份认证"];
    
    [self CreatScrollView];
    
}
- (void)CreatScrollView
{
    _BaseScrollView.backgroundColor = RGB(246, 247, 249);
    SMLabel *titleLbl = [[SMLabel alloc]initWithFrameWith:CGRectMake(10, 50, WindowWith - 20, 15) textColor:cBlackColor textFont:sysFont(17)];
    titleLbl.text = @"第一步：选择认证材料类型（4选1）";
    titleLbl.textAlignment = NSTextAlignmentCenter;
    [_BaseScrollView addSubview:titleLbl];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(30, titleLbl.bottom + 45, WindowWith - 60, 267)];
    scrollView.clipsToBounds =  NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView = scrollView;
    [_BaseScrollView addSubview:scrollView];
    
    NSArray *Arr = @[@"Sample_BusinessCard",@"Sample_WorkCard",@"Sample_jobProof",@"Sample_Businesslicense"];
    NSArray *titleArr = @[@"名片",@"工牌",@"在职证明",@"营业执照"];
    scrollView.contentSize = CGSizeMake(scrollView.width * Arr.count, scrollView.height);
    for (int i = 0; i<Arr.count; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(7.5 +scrollView.width*i, 0, scrollView.width - 15, scrollView.height)];
        view.tag = 20 + i;
        view.layer.cornerRadius = 3.0;
        if (i==0) {
            view.backgroundColor = RGBA(6, 193, 174,0.2);
        }else {
            view.backgroundColor = RGBA(6, 193, 174,0.08);
        }
        
        UIImage *img = Image(Arr[i]);
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30 *Scale, img.size.width , img.size.height)];
        imageV.image = [UIImage imageNamed:Arr[i]];
        imageV.centerX = view.width/2.0;
        [view addSubview:imageV];
        if (i==1) {
            imageV.top = 20 *Scale;
        }
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 120, 35)];
        button.backgroundColor = cGreenLightColor;
        button.layer.cornerRadius = 17.5;
        button.centerX = view.width/2.0;
        [button setTitle:@"认证须知" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font= sysFont(15);
        [button addTarget:self action:@selector(CertificationNotice:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 10 + i;
        
        [view addSubview:button];
        
        SMLabel *lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(0, 0, 70, 15) textColor:cGrayLightColor textFont:sysFont(15)];
        lbl.text = titleArr[i];
        lbl.bottom = view.height - 13;
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.centerX = view.width/2.0;
        [view addSubview:lbl];
        
        button.bottom = lbl.top - 13;
        
        [scrollView addSubview:view];
        
    }
    
    SMLabel *Lbl = [[SMLabel alloc]initWithFrameWith:CGRectMake(10, 66 + scrollView.bottom, WindowWith - 20, 15) textColor:cBlackColor textFont:sysFont(17)];
    Lbl.text = @"第二步：拍摄提交证明材料";
    Lbl.textAlignment = NSTextAlignmentCenter;
    [_BaseScrollView addSubview:Lbl];
    
    SMLabel *lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(10, Lbl.bottom + 5 , WindowWith - 20, 15) textColor:cBlackColor textFont:sysFont(15)];
    lbl.text = @"（您选择提交名片）";
    lbl.textAlignment = NSTextAlignmentCenter;
    _lbl= lbl;
    [_BaseScrollView addSubview:lbl];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, lbl.bottom + 32, 120, 35)];
    button.backgroundColor = cGreenLightColor;
    button.layer.cornerRadius = 17.5;
    button.centerX = WindowWith/2.0;
    [button setTitle:@"上传照片" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font= sysFont(15);
    [button addTarget:self action:@selector(addPhontos:) forControlEvents:UIControlEventTouchUpInside];
    
    [_BaseScrollView addSubview:button];
    
    _BaseScrollView.contentSize=CGSizeMake(WindowWith, button.bottom + 80);
}

- (void)CertificationNotice:(UIButton *)button
{
    NSString *title;
    NSString *imageName;
    NSString *content;
    if (button.tag == 10) {
        title = @"名片认证须知";
        imageName = @"Sample_BusinessCard";
        content = [NSString stringWithFormat:@"1.上传名片正面，保证清晰可辩认 \n2.%@帐号姓名应与名片一致 \n3.%@注册的手机号与名片中一致 \n4.%@职务与名片中一致 \n5.不可上传电子截屏",KAppName,KAppName,KAppName];
    }else if (button.tag == 11) {
        title = @"工牌认证须知";
        imageName = @"Sample_WorkCard";
        content = [NSString stringWithFormat:@"1.上传工牌正面，保证姓名、职务、头像与个人信息一致 \n2.确保工牌上公章上的公司全称，与您个人信息中公司全称一致 \n3.确保所有信息清晰可辩认 \n4.不可上传电子截屏"];
    }else if (button.tag == 12) {
        title = @"在职证明认证须知";
        imageName = @"Sample_jobProof";
        content = @"1.上传在职证明，保证清晰可辩认 \n2.确保工牌上公章上的公司全称，与您个人信息中公司全称一致 \n3.不可上传电子截屏";
    }else if (button.tag == 13) {
        title = @"营业执照认证须知";
        imageName = @"Sample_Businesslicense";
        content = @"1.上传公司营业执照正面，确保所有清晰可辩认 \n2.确保营业执照上公章上的公司全称，与您个人信息中公司全称一致";
    }
    CertificationNoticeView *view = [[CertificationNoticeView alloc] initWithFrame:self.view.window.bounds title:title imageName:imageName content:content];
    view.alpha = 0;
    view.frame = CGRectZero;
    [self.view.window addSubview:view];
    
    [UIView animateWithDuration:.5 animations:^{
        view.frame = self.view.window.bounds;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.3 animations:^{
            view.alpha = 1;
        }];
    }];
}
- (void)addPhontos:(UIButton *)button
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"打开相册" otherButtonTitles:@"打开相机📷", nil];
    
    [sheet showInView:self.view];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float x = scrollView.contentOffset.x;
    int tag = x/_scrollView.width + 20;
    if (scrollView == _scrollView) {
        for (int i = 0; i<4; i++) {
            UIView *view = [_scrollView viewWithTag:i+20];
            view.backgroundColor = RGBA(6, 193, 174,0.08);
        }
        UIView *view = [_scrollView viewWithTag:tag];
        view.backgroundColor = RGBA(6, 193, 174,0.2);
        
        if (tag == 20) {
            _lbl.text = @"（您选择提交名片）";
        }else if (tag == 21){
            _lbl.text = @"（您选择提交工牌）";
        }else if (tag==22){
            _lbl.text = @"（您选择提交在职证明）";
        }else if (tag==23){
            _lbl.text = @"（您选择提交营业执照）";
        }
    }
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //来源
    UIImagePickerControllerSourceType soureType = 0;
    if ( buttonIndex == 0) {
        
        soureType = UIImagePickerControllerSourceTypePhotoLibrary;
    }else if (buttonIndex == 1){
        soureType = UIImagePickerControllerSourceTypeCamera;
        
    }else{
        return;
    }
    //创建控制器
    UIImagePickerController *imagePC = [[UIImagePickerController alloc] init];
    imagePC.sourceType = soureType;
    imagePC.delegate = self;
    imagePC.allowsEditing = NO;
    
    [self presentViewController:imagePC animated:YES completion:nil];
}

- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize{
    UIGraphicsBeginImageContext(newSize);
    
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma -mark  //拍照的回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //获取选中的图片
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    ReferIdentAuthViewController *vc = [[ReferIdentAuthViewController alloc] init];
    vc.image = image;
    vc.typeText = _lbl.text;
    vc.auth_id = self.auth_id;
    [self pushViewController:vc];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //关闭控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
