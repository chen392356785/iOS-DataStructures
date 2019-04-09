//
//  EPCloudEditInformationViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/7/6.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "EPCloudEditInformationViewController.h"
#import "JLSimplePickViewComponent.h"
//#import "AliyunOSSUpload.h"
//#import "keychainItemManager.h"
#import "KICropImageView.h"
#import "InformationEditViewController.h"
#import "CustomView+CustomCategory2.h"

@interface EPCloudEditInformationViewController ()<JLActionSheetDelegate,HJCActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    NSMutableArray *headImageArray;
    NSInteger _selIndex;
    KICropImageView* _cropImageView;
    UIAsyncImageView *_headImageView;
}
@end

@implementation EPCloudEditInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"编辑基本信息"];
    headImageArray=[[NSMutableArray alloc]init];
    self.view.backgroundColor=cLineColor;
    
    NSArray *arr=[ConfigManager getEPCloudEditList];
    for (NSInteger i=0; i<arr.count; i++) {
        NSDictionary *dic=arr[i];
        
        if (i==0) {
            EPCloudCumlativeListView *view=[[EPCloudCumlativeListView alloc]initWithFrame:CGRectMake(0, 66.5*i, WindowWith, 66.5) text:dic[@"text"] ifImage:YES];
            view.tag=[dic[@"tag"] integerValue];
            _headImageView=view.headImageView;
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headTap:)];
            [view addGestureRecognizer:tap];
            [_BaseScrollView addSubview:view];
            
        }else
        {
            EPCloudCumlativeListView *view=[[EPCloudCumlativeListView alloc]initWithFrame:CGRectMake(0, 66.5*i, WindowWith, 66.5) text:dic[@"text"] ifImage:NO];
            view.tag=[dic[@"tag"] integerValue];
            
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTap:)];
            [view addGestureRecognizer:tap];
            
            [_BaseScrollView addSubview:view];
        }
    }
    // Do any additional setup after loading the view.
}

-(void)editWithTitle:(NSString *)title type:(EditBlock)type :(BOOL)isLongString text:(NSString *)text
{
    InformationEditViewController *editView=[[InformationEditViewController alloc]init];
    editView.titl=title;
    editView.delegate=self;
    editView.text=text;
    editView.isLongString=isLongString;
    editView.type=type;
    [self pushViewController:editView];
}

-(void)displayTiyle:(NSString *)title type:(EditBlock)type
{
    if (type==SelectCompanyBlock) {
        EPCloudCumlativeListView *view=[_BaseScrollView viewWithTag:1002];
        view.lbl.text=title;
        view.lbl.textColor=cBlackColor;
    }else if (SelectaBbreviationBlock){
        EPCloudCumlativeListView *view=[_BaseScrollView viewWithTag:1003];
        view.lbl.text=title;
        view.lbl.textColor=cBlackColor;
    }
}

-(void)viewTap:(UITapGestureRecognizer *)tap
{
    EPCloudCumlativeListView *view=(EPCloudCumlativeListView *)tap.view;
    NSArray *arr=[ConfigManager getEPCloudEditList];
    NSString *str;
    for (NSDictionary *dic in arr) {
        if ([dic[@"tag"] integerValue]==view.tag) {
            str=dic[@"text"];
        }
    }
    
    if (view.tag==1002) {
        [ self editWithTitle:str type:SelectCompanyBlock :NO text:view.lbl.text];
    }else if (view.tag==1003){
        [self editWithTitle:str type:SelectaBbreviationBlock :NO text:view.lbl.text];
        
    }else if (view.tag==1004){
        NSArray *arr=[ConfigManager getCompanyNature];
        [self showPicViewWithArr:arr :@"公司性质" :21];
        
        
    }else if (view.tag==1005){
        
    }else if (view.tag==1006){
        
    }else if (view.tag==1007){
        
    }
    //    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    //    objc_setAssociatedObject(btn, "firstObject", @"", OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    //    objc_setAssociatedObject(btn, "secondObject", @"", OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    //    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)showPicViewWithArr:(NSArray *)arr :(NSString *)title :(NSInteger)tag
{
    JLSimplePickViewComponent *pickView =(JLSimplePickViewComponent*)[self.view viewWithTag:tag];
    if(pickView == nil)
    {
        
        pickView = [[JLSimplePickViewComponent alloc] initWithParams:title withData:arr];
        pickView.tag=tag;
        pickView.ActionSheetDelegate = self;
    }
    [pickView show];
    
}

-(void)ActionSheetDoneHandle:(JLSimplePickViewComponent*)pickViewComponent selectedData:(NSString *)SelectedStr
{
    if (pickViewComponent.tag==21) {
        NSLog(@"%@",SelectedStr);
        EPCloudCumlativeListView *view=[_BaseScrollView viewWithTag:1004];
        view.lbl.text=SelectedStr;
        view.lbl.textColor=cBlackColor;
    }
    else
    {
        NSLog(@"%@",SelectedStr);
    }
}

-(void)headTap:(UITapGestureRecognizer *)tap
{
    
    HJCActionSheet *sheet = [[HJCActionSheet alloc] initWithDelegate:self CancelTitle:@"取消" OtherTitles:@"拍照", @"从手机相册选择", nil];
    // 2.显示出来
    [sheet show];
}

// 3.实现代理方法，需要遵守HJCActionSheetDelegate代理协议
- (void)actionSheet:(HJCActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    UIImagePickerController * ip=[[UIImagePickerController alloc]init];
    ip.delegate=self;
    
    // ip.allowsEditing = YES;
    BOOL isOpen=[UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    if (isOpen)
    {
        if (buttonIndex==1) {
            ip.sourceType=UIImagePickerControllerSourceTypeCamera;
        }else if (buttonIndex==2){
            ip.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
        }
        //设置控件是打开相机还是相册，默认是相册，设置UIImagePickerControllerSourceTypeCamera 打开相机
    }
    [self presentViewController:ip animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage * img=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
    img=[UIImage rotateImage:img];
    leftbutton.hidden=YES;
    
    UIView *v=[self.view viewWithTag:2001];
    if (v) {
        [v removeFromSuperview];
    }
    
    v=[[UIView alloc]initWithFrame:self.view.bounds];
    v.backgroundColor=[UIColor blackColor];
    v.tag=2001;
    
    _cropImageView = [[KICropImageView alloc] initWithFrame:self.view.bounds];
    [_cropImageView setCropSize:CGSizeMake(_deviceSize.width-10,_deviceSize.width-10)];
    [_cropImageView setImage:img];
    [v addSubview:_cropImageView];
    
    
    UIView *bView=[[UIView alloc ]initWithFrame:CGRectMake(0, v.bottom-70, _deviceSize.width, 60)];
    bView.alpha=0.8;
    //  bView.backgroundColor=[UIColor blackColor];
    [v addSubview:bView];
    
    img=Image(@"btn_cancel.png");
    UIButton *calBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    calBtn.frame=CGRectMake(30, 0, img.size.width, img.size.height);
    [calBtn setBackgroundImage:img forState:UIControlStateNormal];
    [calBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [bView addSubview:calBtn];
    
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    img=Image(@"nav_ok.png");
    btn.frame=CGRectMake(WindowWith-30-img.size.width, 0,  img.size.width, img.size.height);
    [btn setBackgroundImage:img forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(saveImage) forControlEvents:UIControlEventTouchUpInside];
    [bView addSubview:btn];
    
    
    btn=[UIButton buttonWithType:UIButtonTypeCustom];
    img=Image(@"login_cx.png");
    btn.frame=CGRectMake(WindowWith/2-img.size.width/2, 0, img.size.width, img.size.height);
    [btn setBackgroundImage:img forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(headTap:) forControlEvents:UIControlEventTouchUpInside];
    
    [bView addSubview:btn];
    [_BaseScrollView addSubview:v];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)cancelClick{
    leftbutton.hidden=NO;
    UIView *v=[self.view viewWithTag:2001];
    [v removeFromSuperview];
}

-(void)saveImage{
    leftbutton.hidden=NO;
    CGFloat width = WindowWith;
    CGFloat x = (CGRectGetWidth(self.view.bounds) - width) / 2;
    CGFloat y = (CGRectGetHeight(self.view.bounds)/2 - width/ 2);
    UIView *v=[self.view viewWithTag:2001];
    [v removeFromSuperview];
    //判断先画一个大图，然后进行缩小动画。然后再删除。
    UIImage *img=Image(@"EP_defaultlogo.png");
    UIImageView *xzImg=[[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, width)];
    xzImg.layer.masksToBounds=YES;
    xzImg.layer.cornerRadius=img.size.height/2;
    xzImg.image=[_cropImageView cropImage];
    [self.view addSubview:xzImg];
    [UIView animateWithDuration:0.7 animations:^{
        xzImg.frame=self->_headImageView.frame;
    } completion:^(BOOL finished) {
        //[_photoButton setBackgroundImage:[_cropImageView cropImage] forState:UIControlStateNormal];
        [self->headImageArray removeAllObjects];
        self->_headImageView.image=[self->_cropImageView cropImage] ;
        [self->headImageArray addObject:[self->_cropImageView cropImage]];
        
        [xzImg removeFromSuperview];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
