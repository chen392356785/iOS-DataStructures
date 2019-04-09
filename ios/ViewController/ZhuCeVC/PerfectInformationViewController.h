//
//  PerfectInformationViewController.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/4/1.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "SMBaseViewController.h"
#import "EditInformationDelegate.h"
#import "KICropImageView.h"
@interface PerfectInformationViewController : SMBaseCustomViewController<EditInformationDelegate,HJCActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    KICropImageView* _cropImageView;
     BOOL isSelectedPhoto;
    MapAnnotationView *_nickNamelbl;
    int sex;
    MapAnnotationView *_companylbl;
    MapAnnotationView *_industrylbl;
    NSInteger _selIndex;
}
@property(nonatomic,strong)NSString *phoneStr;
@property(nonatomic,strong)NSString *passwordStr;
@end
