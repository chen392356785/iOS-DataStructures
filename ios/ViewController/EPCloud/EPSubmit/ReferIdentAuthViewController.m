//
//  ReferIdentAuthViewController.m
//  MiaoTuProject
//
//  Created by Zmh on 30/8/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "ReferIdentAuthViewController.h"

@interface ReferIdentAuthViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
{
    UIImageView *_imageV;
    NSMutableArray *imgsArray;
    NSString *type;
}
@end

@implementation ReferIdentAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"提交证明材料"];
    
    [self CreatScrollView];
    imgsArray = [NSMutableArray array];
    [imgsArray addObject:self.image];
}
- (void)CreatScrollView
{
    _BaseScrollView.backgroundColor = RGB(246, 247, 249);
    
    SMLabel *lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(40, 26, WindowWith - 80, 45) textColor:cBlackColor textFont:sysFont(15)];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.numberOfLines = 0;
    [_BaseScrollView addSubview:lbl];
    
    SMLabel *lbl1 = [[SMLabel alloc] initWithFrameWith:CGRectMake(40,lbl.bottom + 50 , WindowWith - 80, 15) textColor:cBlackColor textFont:sysFont(15)];
    lbl1.textAlignment = NSTextAlignmentCenter;
    [_BaseScrollView addSubview:lbl1];
    
    if ([self.typeText isEqualToString:@"（您选择提交名片）"]) {
        lbl.text = @"请确保您的 姓名、公司全称、公司简介 与您的名片完全一致，否则审核将会驳回";
        lbl.attributedText = [IHUtility changePartTextColor:lbl.text range:NSMakeRange(5, 13) value:cGreenLightColor];
        lbl1.text = [NSString stringWithFormat:@"您的认证材料：名片"];
        
        type = @"1";
        
    }else if ([self.typeText isEqualToString:@"（您选择提交工牌）"]) {
        lbl.text = @"请确保您的 姓名、公司全称、公司简介 与您的工牌完全一致，否则审核将会驳回";
        lbl.attributedText = [IHUtility changePartTextColor:lbl.text range:NSMakeRange(5, 13) value:cGreenLightColor];
        lbl1.text = [NSString stringWithFormat:@"您的认证材料：工牌"];
        
        type = @"2";
    }else if ([self.typeText isEqualToString:@"（您选择提交在职证明）"]) {
        lbl.text = @"请确保您的 姓名、公司全称 与您的在职证明完全一致，否则审核将会驳回";
        lbl.attributedText = [IHUtility changePartTextColor:lbl.text range:NSMakeRange(5, 8) value:cGreenLightColor];
        lbl1.text = [NSString stringWithFormat:@"您的认证材料：在职证明"];
        
        type = @"3";
        
    }else if ([self.typeText isEqualToString:@"（您选择提交营业执照）"]) {
        lbl.text = @"请确保您的 公司全称 与您的营业执照完全一致，否则审核将会驳回";
        lbl.attributedText = [IHUtility changePartTextColor:lbl.text range:NSMakeRange(5, 5) value:cGreenLightColor];
        lbl1.text = [NSString stringWithFormat:@"您的认证材料：营业执照"];
        
        type = @"4";
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(18, lbl1.bottom + 19, WindowWith - 36, 201)];
    view.layer.cornerRadius = 3.0;
    view.layer.borderColor= cGreenLightColor.CGColor;
    view.layer.borderWidth = 1.0;
    [_BaseScrollView addSubview:view];
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(14, 15, view.width - 28, view.height - 30)];
    imageV.image = self.image;
    imageV.layer.cornerRadius = 5.0;
    imageV.clipsToBounds = YES;
    _imageV = imageV;
    [view addSubview:imageV];
    
    UIButton *reButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 6, 60, 23)];
    reButton.right = view.width - 6;
    reButton.backgroundColor = cGreenLightColor;
    reButton.layer.cornerRadius = 3;
    [reButton setTitle:@"重新上传" forState:UIControlStateNormal];
    [reButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    reButton.titleLabel.font= sysFont(13);
    [reButton addTarget:self action:@selector(referImage:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:reButton];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, view.bottom + 47, 150, 35)];
    button.backgroundColor = cGreenLightColor;
    button.layer.cornerRadius = 17.5;
    button.centerX = WindowWith/2.0;
    [button setTitle:@"提 交" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font= sysFont(15);
    [button addTarget:self action:@selector(referInfo:) forControlEvents:UIControlEventTouchUpInside];
    
    [_BaseScrollView addSubview:button];
    
    lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(40,button.bottom + 15 , WindowWith - 80, 15) textColor:cBlackColor textFont:sysFont(15)];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.text = [NSString stringWithFormat:@"您的材料仅用于认证身份，不会公开"];
    [_BaseScrollView addSubview:lbl];
    
    _BaseScrollView.contentSize = CGSizeMake(WindowWith, lbl.bottom + 50);
}
- (void)referInfo:(UIButton *)button
{
    __weak ReferIdentAuthViewController *weakSelf = self;
    
    [self addWaitingView];
    [AliyunUpload uploadImage:imgsArray FileDirectory:ENT_fileImageBody success:^(NSString *obj) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self removeWaitingView];
            [weakSelf addSucessView:@"信息已成功提交！" type:1];
            NSArray *arr=[network getJsonForString:obj];
            MTPhotosModel *mod=[[MTPhotosModel alloc]initWithUrlDic:arr[0]];
            NSMutableString *str=[[NSMutableString alloc]initWithString:mod.imgUrl];
            NSRange range=[str rangeOfString:ConfigManager.ImageUrl];
            [str deleteCharactersInRange:range];
            
            NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:self.auth_id,@"auth_id",self->type,@"authtype_id",str,@"authimage_url",@"0",@"state", nil];
            [[NSNotificationCenter defaultCenter]postNotificationName:NotificationIdentAuth object:dictionary];
            NSDictionary *dic = [IHUtility getUserDefalutsDicKey:kUserDefalutLoginInfo];
            NSMutableDictionary *dic1=[[NSMutableDictionary alloc]initWithDictionary:dic];
            [dic1 setValue:dictionary forKey:@"authenticationInfo"];
            [IHUtility saveDicUserDefaluts:dic1 key:kUserDefalutLoginInfo];
            [weakSelf popViewController:(int)(self.navigationController.viewControllers.count - 3)];
        });
    }];
    
}
- (void)referImage:(UIButton *)button
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"打开相册" otherButtonTitles:@"打开相机📷", nil];
    
    [sheet showInView:self.view];
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
    [imgsArray removeAllObjects];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    _imageV.image = image;
    [imgsArray addObject:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //关闭控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
