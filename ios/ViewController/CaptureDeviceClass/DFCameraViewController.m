//
//  DFCameraViewController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/9/25.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "DFCameraViewController.h"

#import <AVFoundation/AVFoundation.h>

@interface DFCameraViewController ()

//捕获设备，通常是前置摄像头，后置摄像头，麦克风（音频输入）
@property(nonatomic, strong)AVCaptureDevice *device;
//AVCaptureDeviceInput 代表输入设备，他使用AVCaptureDevice 来初始化
@property(nonatomic, strong)AVCaptureDeviceInput *input;
//当启动摄像头开始捕获输入
@property (nonatomic, strong) AVCaptureConnection * videoConnection;
@property (nonatomic, strong) AVCaptureStillImageOutput *ImageOutPut;
@property (nonatomic, strong) AVCaptureVideoDataOutput *videoOutPut;
//session：由他把输入输出结合在一起，并开始启动捕获设备（摄像头）
@property(nonatomic, strong)AVCaptureSession *session;
//图像预览层，实时显示捕获的图像
@property(nonatomic, strong)AVCaptureVideoPreviewLayer *previewLayer;

@property (nonatomic, strong) UIView *pinchView;

@property (nonatomic, assign) CGPoint centerPoint;

@end

@implementation DFCameraViewController
- (void) viewWillAppear:(BOOL)animated {
   [self.navigationController.navigationBar setBackgroundImage:[UIImage new]forBarMetrics:UIBarMetricsDefault];
}
- (void) viewWillDisappear:(BOOL)animated {
   [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
}
- (void)back:(id)sender {
    if (self.presentingViewController) {
        //判断1
        [self dismissViewControllerAnimated:YES completion:nil];
    } else if ([self.navigationController respondsToSelector:@selector(popViewControllerAnimated:)]) {
        //判断2
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self creatCamera];
}

#pragma mark - 创建相机
- (void)creatCamera {
    //生成会话，用来结合输入输出
    self.session = [[AVCaptureSession alloc]init];
    self.session.sessionPreset = AVCaptureSessionPresetHigh;
    //使用AVMediaTypeVideo 指明self.device代表视频，默认使用后置摄像头进行初始化
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //使用设备初始化输入
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    //生成输出对象
    self.ImageOutPut = [[AVCaptureStillImageOutput alloc] init];
    self.videoOutPut = [[AVCaptureVideoDataOutput alloc] init];
    if ([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    }
    if ([self.session canAddOutput:self.ImageOutPut]) {
        [self.session addOutput:self.ImageOutPut];
        // 根据设备输出获得连接
        self.videoConnection = [self.ImageOutPut connectionWithMediaType:AVMediaTypeVideo];
        if ([self.device.activeFormat isVideoStabilizationModeSupported:AVCaptureVideoStabilizationModeCinematic]) {
            // 如果支持防抖就打开防抖
            self.videoConnection.preferredVideoStabilizationMode = AVCaptureVideoStabilizationModeCinematic;
        }
    }
    if ([self.session canAddOutput:self.videoOutPut]) {
        [self.session addOutput:self.videoOutPut];
    }
    
    //使用self.session，初始化预览层，self.session负责驱动input进行信息的采集，layer负责把图像渲染显示
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.session];
    self.previewLayer.frame = CGRectMake(0, 0, iPhoneWidth, iPhoneHeight);
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];
    
    //开始启动
    [self.session startRunning];
    
    if ([self.device lockForConfiguration:nil]) {
        //默认闪光灯关闭
        if ([self.device isFlashModeSupported:AVCaptureFlashModeOff]) {
            [self.device setFlashMode:AVCaptureFlashModeOff];
        }
        //自动白平衡
        if ([self.device isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeAutoWhiteBalance]) {
            [self.device setWhiteBalanceMode:AVCaptureWhiteBalanceModeAutoWhiteBalance];
        }
        //对焦模式和对焦点
        self.centerPoint = CGPointMake(iPhoneWidth / 2, (iPhoneHeight - 190* TTUIScale()) / 2);
        if ([self.device isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus]) {
            [self.device setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
            [self.device setFocusPointOfInterest:self.centerPoint];
        }
        //曝光模式和曝光点
        if ([self.device isExposureModeSupported:AVCaptureExposureModeContinuousAutoExposure ]) {
            [self.device setExposureMode:AVCaptureExposureModeContinuousAutoExposure];
            [self.device setExposurePointOfInterest:self.centerPoint];
        }
        [self.device unlockForConfiguration];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 屏幕适配

CGFloat TTUIScale() {
    static CGFloat scale = 0.0;
    if (fabs(scale) < 1e-6) {
        // based on iPhone 6
        CGSize designSize = CGSizeMake(375, 667);
        CGSize currentSize = [UIScreen mainScreen].bounds.size;
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            // iPad使用缩放模式，调整系数
            if (currentSize.width / 320.0 > 3) {
                // ipad pro
                currentSize = CGSizeMake(375, 667);
            } else {
                currentSize = CGSizeMake(320, 480);
            }
        }
        
        scale = (currentSize.width / designSize.width + currentSize.height / designSize.height) / 2;
    }
    return scale;
}
@end
