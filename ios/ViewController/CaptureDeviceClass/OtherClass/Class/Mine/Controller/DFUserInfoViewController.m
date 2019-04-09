//
//  DFUserInfoViewController.m
//  DF
//
//  Created by 苏浩楠 on 2017/11/30.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "AliyunManager.h"
#import "DFConstant.h"
#import "DFIconConstant.h"
#import "DFIdentifierConstant.h"
#import "DFUserInfoViewController.h"
#import "DFUserInfoTableViewCell.h"
#import "DFUserInfoTopViewCell.h"
#import "DFUserInfoView.h"
#import "DFUpdateNickViewController.h"
#import "DFUpdateSignatureViewController.h"

@interface DFUserInfoViewController ()<UITableViewDataSource,UITableViewDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) DFUserInfoView *userInfoView;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DFUserInfoViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 禁用返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 开启返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadUserInfo) name:UpdateUserInfoIdentifier object:nil];
    
    [self configureView];
}

#pragma mark - 刷新页面数据
- (void)reloadUserInfo {
    [self.tableView reloadData];
}

- (DFUserInfoView *)userInfoView {
    return (DFUserInfoView *)self.view;
}

#pragma mark - 配置页面
- (void)configureView {
    
    DFUserInfoView *userInfoView = [[DFUserInfoView alloc]init];
    self.view = userInfoView;
    
    DFNavigationView *navigationView = userInfoView.navigationView;
    [navigationView.backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    navigationView.titleLabel.text = DFUserInfoString();
    
    self.tableView = userInfoView.tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[DFUserInfoTopViewCell class] forCellReuseIdentifier:UserHeaderIdentifier];
    [self.tableView registerClass:[DFUserInfoTableViewCell class] forCellReuseIdentifier:UserInfoIdentifier];

}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        DFUserInfoTopViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UserHeaderIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        [cell.headerImgView sd_setImageWithURL:[NSURL URLWithString:UserModel.HeadImage] placeholderImage:kImage(UserIconDefault)];
        return cell;
    }else {
        DFUserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UserInfoIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        if (indexPath.row == 1) {
            cell.nameLab.text = DFNickString();
            cell.detailNameLab.text = UserModel.Nick;
        }else if (indexPath.row == 2) {
            cell.nameLab.text = DFSexString();
            cell.detailNameLab.text = ([UserModel.GenderType integerValue] == 1)  ? DFMaleString() : DFFemaleString();
        }else if (indexPath.row == 3) {
            cell.nameLab.text = DFSignatureString();
            cell.detailNameLab.text = UserModel.Signature;
        }
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0)
    {
        [self selectedHeadImage];
    }
    if (indexPath.row == 1)
    {
        DFUpdateNickViewController *nickNameVC = [[DFUpdateNickViewController alloc] init];
        [self.navigationController pushViewController:nickNameVC animated:YES];
    }
    else if (indexPath.row == 2)
    {
        UIActionSheet * action=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:DFCancleString() destructiveButtonTitle:nil otherButtonTitles:DFMaleString(),DFFemaleString(),nil];
        action.tag=1000;
        [action showInView:self.view];
    }
    else if (indexPath.row == 3)
    {
        DFUpdateSignatureViewController *personVC = [[DFUpdateSignatureViewController alloc] init];
        [self.navigationController pushViewController:personVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60 * TTUIScale();
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10 * TTUIScale();
}

#pragma mark - 选择头像
- (void)selectedHeadImage {
    UIActionSheet * action =[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:DFCancleString() destructiveButtonTitle:nil otherButtonTitles:DFCameraString(),DFAlbumString(),nil];
    [action showInView:self.view];
}

#pragma mark - UIActionSheet的代理方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag==1000)
    {
        if (buttonIndex==2)
        {
            return;
        }
        
        NSString * userGender;
        if (buttonIndex==0)
        {
            userGender =@"1";
        }
        else if (buttonIndex==1)
        {
            userGender =@"2";
        }

        [DFTool addWaitingView:self.view];
        [HttpRequest postUpdateUserInfoWith:UserModel.Id nick:UserModel.Nick headImage:UserModel.HeadImage signature:UserModel.Signature genderType:userGender success:^(NSDictionary *result) {
            [DFTool removeWaitingView:self.view];
            [DFTool showTips:DFSetSuccessString()];
            UserModel.GenderType = userGender;
            NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject:UserModel.GenderType  forKey:@"GenderType"];
            [userDefault synchronize];
            [self.tableView reloadData];
        } failure:^(NSError *error) {
             [DFTool removeWaitingView:self.view];
            [DFTool showTips:DFSetFailureString()];
         }];
    } else{
        if (buttonIndex == 0) {
            [self openSystermCamera];
        } else if (buttonIndex == 1) {
            [self openSystermAlbum];
        }
    }
}

#pragma mark - 调用相机
- (void)openSystermCamera {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    //没有相机功能
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:DFLetterString() message:DFNoVideoString() delegate:nil cancelButtonTitle:DFSureString() otherButtonTitles:nil];
        [alertView show];
        return;
    }
    UIImagePickerController  *picker = [[UIImagePickerController alloc] init];//初始化
    picker.delegate = self;
    picker.allowsEditing = YES;//设置可编辑
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - 调用相册
- (void)openSystermAlbum {
    UIImagePickerController * pickerImage = [[UIImagePickerController alloc] init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        pickerImage.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
    }
    pickerImage.delegate = self;
    pickerImage.allowsEditing = YES;
    [self presentViewController:pickerImage animated:YES completion:nil];
}

#pragma mark - 照相机回调方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [DFTool addWaitingView:self.view];
    //获取到程序拾取的图像
    UIImage  * img = [DFTool image_NewImageSimple:[info objectForKey:UIImagePickerControllerEditedImage] scaledToSize:CGSizeMake(120, 120)];
    //用到图片处理类
    [picker dismissViewControllerAnimated:YES completion:^
     {
         //  NSString *headUrl = @"https://tinghua.img-cn-beijing.aliyuncs.com/";
         NSString *headUrl = @"http://tinghua.img-cn-beijing.aliyuncs.com/";
         AliyunManager * manger = [[AliyunManager alloc]init];
         NSString * fileName=[NSString stringWithFormat:@"%@.png",[manger createImageName]];
         NSString * path    =[NSString stringWithFormat:@"Users/%@",fileName];
         NSData   * data    =[UIImage compressImage:img toMaxLength:1024*5 maxWidth:MAXFLOAT];
         [manger uploadObject:path withData:data withCallBack:^(OSSTask *response) {
             NSString *imagePath = [headUrl stringByAppendingString:path];
             /**
              *  头像上传成功OSS后上传到服务器再
              */
             [HttpRequest postUpdateUserInfoWith:UserModel.Id nick:UserModel.Nick headImage:imagePath signature:UserModel.Signature genderType:UserModel.GenderType success:^(NSDictionary *result)
              {
                  [DFTool removeWaitingView:self.view];
                  
                  if (!TTValidateDictionary(result)) {
                      return ;
                  }
                  
                  if ([result[DFErrCode]integerValue] == 200) {
                      
                      if (TTValidateDictionary(result[DFData])) {
                          UserModel.HeadImage = [result[DFData] objectForKey:@"HeadImage"];
                          NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
                          [userDefault setObject:UserModel.HeadImage forKey:@"HeadImage"];
                          [userDefault synchronize];
                          [DFTool showTips:DFSetSuccessString()];
                      }
                  }
                  [self.tableView reloadData];
              } failure:^(NSError *error) {
                  [DFTool removeWaitingView:self.view];
              }];

         }];
     }];
}

#pragma mark -  当用户取消时，调用该方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)backAction {
    [[NSNotificationCenter defaultCenter]postNotificationName:ResetCameraStatusIdentifier object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
