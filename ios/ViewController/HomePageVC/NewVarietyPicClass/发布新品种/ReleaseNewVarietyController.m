//
//  ReleaseNewVarietyController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/7/31.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "DFIdentifierConstant.h"
#import "ReleaseNewVarietyController.h"
#import "ReleaseNewVarietyHeadView.h"
//#import "ZLPhotoActionSheet.h"
#import "ReleaseNewVarietyViewCell.h"
#import "NewVarietyPicModel.h"
#import "XHFriendlyLoadingView.h"
#import "PicReleaseSucces.h"

@interface  ReleaseNewVarietyController() <UITableViewDelegate,UITableViewDataSource,ReleaseNewVarietyDelegate,UITextFieldDelegate>{
    UITableView *_tableView;
    NSMutableArray *imgsArr;
    NSMutableArray *TempImgsArr;
    ReleaseNewVarietyHeadView *headView;
    ZLPhotoActionSheet *actionSheet;
    
    NSArray *sectionOneArray;
    NSMutableArray *seactTwoArray;
    
    BOOL isFirstAddPhoto;
    NewVarietyPicModel *CurrMode;
    NSIndexPath *_indexPath;
    
    NSString *nameStr;
    NSString *AddrStr;
    NSString *PicStr;
    NSString *guigStr;
    NSString *PhonStr;
    
    UITableView    *myTableView;
    NSMutableArray *phoneArray;
    
}

@end
static NSString *ReleaseNewVarietyViewCellID = @"ReleaseNewVarietyViewCell";
static NSString *ReleaseNewVarietyTypeCellId = @"ReleaseNewVarietyTypeCell";

#define myDotNumbers     @"0123456789.\n"
#define myNumbers          @"0123456789\n"

@implementation ReleaseNewVarietyController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    // 点击视图隐藏键盘
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = NO;
}

-(void)back:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void) getNewVarietyInfo {
    NSDictionary *dict = @{
                          @"user_id" : USERMODEL.userID,
                          };
    [self addPushViewWaitingView];
    [seactTwoArray removeAllObjects];
    [network httpRequestWithParameter:dict method:NewddNurserynewUrl success:^(NSDictionary *dic) {
        [self removePushViewWaitingView];
        NewVarietyPicContentModel *ContentModel = [[NewVarietyPicContentModel alloc] initWithDictionary:dic[@"content"] error:nil];
        for (NewVarietyPicModel *model in ContentModel.nurseryNewTypeList) {
            [self->seactTwoArray addObject:model];
        }
        for (NewMobileListModel *model in ContentModel.mobileList) {
            [self->phoneArray addObject:model];
        }
        self->CurrMode = self->seactTwoArray[0];
        [self->_tableView reloadData];
    } failure:^(NSDictionary *dic) {
        [self removePushViewWaitingView];
        XHFriendlyLoadingView *v=(XHFriendlyLoadingView*)[self.view viewWithTag:8172];
        [v showReloadViewWithText:reloadText];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    seactTwoArray = [[NSMutableArray alloc] init];
    TempImgsArr = [[NSMutableArray alloc] init];
    phoneArray = [[NSMutableArray alloc] init];
     [self getNewVarietyInfo];
   nameStr = @"";
   AddrStr = @"";
   PicStr = @"";
   guigStr = @"";
   PhonStr = @"";
    self.title = @"发布新品种";
    imgsArr = [[NSMutableArray alloc] init];
    sectionOneArray = @[
                        @"请输入植物的名称",
                        @"请输入市场价格",
                        @"请输入植物规格",
                        ];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight - KtopHeitht - kWidth(49)) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.estimatedSectionHeaderHeight = 8;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:_tableView];
    _tableView.estimatedSectionHeaderHeight = 0.;
    
    headView = [[ReleaseNewVarietyHeadView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, kWidth(158))];
    headView.delegage = self;
    if (self.isComeraDeviceRelease == YES) {
    }else {
        _tableView.tableHeaderView = headView;
    }
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, _tableView.bottom, iPhoneWidth, kWidth(49));
    [button setTitle:@"发布" forState:UIControlStateNormal];
    [button setTitleColor:kColor(@"#ffffff") forState:UIControlStateNormal];
    [button setBackgroundColor:kColor(@"#09bfaf")];
    button.titleLabel.font = sysFont(font(18));
    [self.view addSubview:button];
    [button addTarget:self action:@selector(releaseNewVarietyAction) forControlEvents:UIControlEventTouchUpInside];
    [self setActionSheet];
    
}
- (void) setActionSheet {
    actionSheet = [[ZLPhotoActionSheet alloc] init];
    //设置照片最大选择数
    actionSheet.maxSelectCount = 1;
    //设置照片最大预览数
    actionSheet.maxPreviewCount = 20;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView.tag == 100) {
        return 1;
    }
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 100) {
        return phoneArray.count;
    }
    
    if (section == 0) {
        return sectionOneArray.count;
    }
    return seactTwoArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView.tag == 100) {
        return 0;
    }
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 100) {
        return kWidth(37);
    }
    if (indexPath.section == 0) {
        return kWidth(50);
    }else {
        return kWidth(45);
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 100) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Tfcellid"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Tfcellid"];
        }
        NewMobileListModel *model = phoneArray[indexPath.row];
        cell.backgroundColor = cLineColor;
        cell.textLabel.text = model.mobile;
        cell.textLabel.font = sysFont(font(15));
        return cell;
    }
    if (indexPath.section == 0) {
        ReleaseNewVarietyViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReleaseNewVarietyViewCellID];
        if (cell == nil) {
            cell = [[ReleaseNewVarietyViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ReleaseNewVarietyViewCellID];
        }
        
        cell.selectionStyle = UITableViewCellStyleDefault ;
        cell.textField.placeholder = sectionOneArray[indexPath.row];
        cell.textField.delegate = self;
        cell.textField.tag = indexPath.row;
        if (indexPath.row == 1 || indexPath.row == 4) {
            cell.textField.keyboardType = UIKeyboardTypeDecimalPad;
        }
        if (indexPath.row == 4) {
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
            cell.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        }
        return cell;
    }
    ReleaseNewVarietyTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:ReleaseNewVarietyTypeCellId];
    if (cell == nil) {
        cell = [[ReleaseNewVarietyTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ReleaseNewVarietyTypeCellId];
    }
    NewVarietyPicModel *mode = seactTwoArray[indexPath.row];
    cell.selectionStyle = UITableViewCellStyleDefault ;
    if (mode == CurrMode) {
        [cell setTitle:mode.nurseryTypeName andImageStr:@"icon_HWZ"];
        _indexPath = indexPath;
    }else {
        [cell setTitle:mode.nurseryTypeName andImageStr:@"icon_wxz"];
    }
    return cell;
}


#pragma mark - 选择添加图片代理
- (void)showActionSheetPicSelectBlock:(PicSelectItemBlock)block {
    [actionSheet showWithSender:self animate:YES completion:^(NSArray<UIImage *> * _Nonnull selectPhotos) {
        for (int i=0; i<selectPhotos.count; i++) {
            UIImage *img2 = [selectPhotos objectAtIndex:i];
            if (!self->isFirstAddPhoto) {
                [self->imgsArr removeAllObjects];
                [self->imgsArr addObject:img2];
                self->isFirstAddPhoto=YES;
            }else{
                [self->imgsArr addObject:img2];
            }
        }
        if (self->imgsArr.count>=1) {
            NSMutableArray *arr2=[[NSMutableArray alloc]init];
            for (int i=0; i<1; i++) {
                [arr2 addObject:[self->imgsArr objectAtIndex:i]];
            }
            [self->imgsArr removeAllObjects];
            [self->imgsArr addObjectsFromArray:arr2];
        }
        block(self->imgsArr);
    }];
    
}
- (void)remoePicSelectUpDataUIFrame:(CGRect)frame andImageArr:(NSMutableArray *)imgarray{
    headView.frame = frame;
    [TempImgsArr removeAllObjects];
    TempImgsArr = imgarray;
    [_tableView reloadData];
}

- (void) releaseNewVarietyAction {
    NSDictionary *dic=[IHUtility getUserDefalutsDicKey:kUserDefalutLoginInfo];
    if ([dic[@"mobile"] isEqualToString:@""]) {
        [self showLoginViewWithType:ENT_Lagin];
        return;
    }
    
	for (int i = 0; i<self->sectionOneArray.count; i++) {
		ReleaseNewVarietyViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
		if (i == 0) {
			nameStr = cell.textField.text;
			if (nameStr.length <= 0) {
				[self showTextHUD:@"请填写名称"];
				return;
			}
		}
		if (i == 1) {
			PicStr = cell.textField.text;
			if (PicStr.length <= 0) {
				[self showTextHUD:@"请填写价格"];
				return;
			}
		}if (i == 2) {
			guigStr = cell.textField.text;
			if (guigStr.length <= 0) {
				[self showTextHUD:@"请填写规格"];
				return;
			}
		}
	}
    [self sendNewVariety];
}
- (void) sendNewVariety {
    NSLog(@"%@--%@ -- %@-- %@ -- %@ - %ld",nameStr,AddrStr,PicStr,guigStr,PhonStr,TempImgsArr.count);
//*
    if (self.isComeraDeviceRelease == YES) {
        [TempImgsArr addObject:self.pic_imag];
    }
    if (![IHUtility isValidateMobile:PhonStr] && PhonStr.length > 0) {
        [self showTextHUD:@"请输入您的联系方式"];
        [self addSucessView:[NSString stringWithFormat:@"手机号格式错误"] type:2];
        return;
    }
    if (TempImgsArr.count <= 0) {
        [self showTextHUD:@"请添加上传图片"];
        return;
    }
    [self addWaitingView];
    /*  img-cn-beijing.aliyuncs.com  */
    [AliyunUpload uploadImage:TempImgsArr FileDirectory:ENT_fileImageCont success:^(NSString *obj) {
        NSDictionary *dict = @{
                               @"userId"         : USERMODEL.userID,
							   @"plantType"      : self->CurrMode.nursery_type_id,
							   @"plantName"      : self->CurrMode.nurseryTypeName,
                               @"plantTitle"     : self->nameStr,
                               @"src_pic"        : obj,
                               @"loadingPrice"   : self->PicStr,
                               @"remark"         : self->guigStr,
                               @"nurseryAddress" : self->AddrStr,
                               @"mobile"         : self->PhonStr,
                               };
        NSLog(@"--------           %@%@",@"http://8yyq8.com",obj);
        NSLog(@"--------           %@%@",@"https://image.8yyq8.com",obj);
//*
        [network httpRequestWithParameter:dict method:NewaddNewDetailUrl success:^(NSDictionary *dic) {
//            NSLog(@"00000----- %@",dic);
            [self removeWaitingView];
            if (self.isComeraDeviceRelease == YES) {
                [self ShowPicReleaseSucces];
            }else {
                [self addSucessView:@"发布成功" type:1];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        } failure:^(NSDictionary *dic) {
            [self removeWaitingView];
//           NSLog(@"11111----- %@",dic);
        }];
 //*/
	} failure:^(NSError *error) {
		[self removeWaitingView];
	}];

}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField.tag == 4 && textField.text.length < 1) {
        [self showListV:textField];
    }
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"1");//输入文字时 一直监听
    if (textField.tag == 1) {
        // 判断是否输入内容，或者用户点击的是键盘的删除按钮
        if (![string isEqualToString:@""]) {
            NSCharacterSet *cs;
            // 小数点在字符串中的位置 第一个数字从0位置开始
            NSInteger dotLocation = [textField.text rangeOfString:@"."].location;
            // 判断字符串中是否有小数点，并且小数点不在第一位
            // NSNotFound 表示请求操作的某个内容或者item没有发现，或者不存在
            // range.location 表示的是当前输入的内容在整个字符串中的位置，位置编号从0开始
            if (dotLocation == NSNotFound && range.location != 0) {
                // 取只包含“myDotNumbers”中包含的内容，其余内容都被去掉
                /* [NSCharacterSet characterSetWithCharactersInString:myDotNumbers]的作用是去掉"myDotNumbers"中包含的所有内容，只要字符串中有内容与"myDotNumbers"中的部分内容相同都会被舍去在上述方法的末尾加上invertedSet就会使作用颠倒，只取与“myDotNumbers”中内容相同的字符
                 */
                cs = [[NSCharacterSet characterSetWithCharactersInString:myDotNumbers] invertedSet];
                if (range.location >= 9) {
                    NSLog(@"单笔金额不能超过亿位");
                    if ([string isEqualToString:@"."] && range.location == 9) {
                        return YES;
                    }
                    return NO;
                }
            }else {
                cs = [[NSCharacterSet characterSetWithCharactersInString:myNumbers] invertedSet];
            }
            // 按cs分离出数组,数组按@""分离出字符串
            
            NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
            BOOL basicTest = [string isEqualToString:filtered];
            if (!basicTest) {
                NSLog(@"只能输入数字和小数点");
                return NO;
            }
            if (dotLocation != NSNotFound && range.location > dotLocation + 2) {
                NSLog(@"小数点后最多两位");
                return NO;
            }
            if (textField.text.length > 11) {
                return NO;
            }
        }
    }
    
    
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (textField.tag == 4) {
        if (text.length < 1) {
            [_tableView addSubview:myTableView];
        }else {
            [myTableView removeFromSuperview];
        }
    }
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"3");//文本彻底结束编辑时调用
    if (textField.tag == 4) {
        [myTableView removeFromSuperview];
    }
}
-(BOOL)textFieldShouldClear:(UITextField *)textField {
    NSLog(@"5");// 点击‘x’清除按钮时 调用
    if (textField.tag == 4) {
//        [_tableView addSubview:myTableView];   //手机号码
    }
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 100) {
        ReleaseNewVarietyViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
        NewMobileListModel *model = phoneArray[indexPath.row];
        cell.textField.text = model.mobile;
        [cell.textField resignFirstResponder];
    }else {
        if (indexPath.section == 1) {
            CurrMode = seactTwoArray[indexPath.row];
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:_indexPath,indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }
    }
    
}
- (void) showListV:(UITextField *)Tf {
    CGRect rectInTableView = [_tableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    CGRect rect = [_tableView convertRect:rectInTableView toView:[_tableView superview]];
    CGFloat conentY = _tableView.contentOffset.y;
    CGFloat cellHeight;
    if (phoneArray.count >= 4) {
        cellHeight = 4 * kWidth(37.0);
    }else {
        cellHeight = phoneArray.count * 37;
    }
    if (myTableView == nil) {
         myTableView = [[UITableView alloc] initWithFrame:CGRectMake(Tf.frame.origin.x, rect.origin.y - cellHeight + conentY, Tf.frame.size.width, cellHeight) style:UITableViewStylePlain];
    }
    myTableView.tag = 100;
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.backgroundColor = cBgColor;
    [_tableView addSubview:myTableView];
}
- (void) ShowPicReleaseSucces {
    PicReleaseSucces *succesVc = [[PicReleaseSucces alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth - kWidth(106), kWidth(260))];
    [self showPopupWithStyle:CNPPopupStyleCentered popupView:succesVc];
    succesVc.CancelBlock = ^{
        [self dismissPopupController];
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    succesVc.TryAgainBlock = ^{
        if (self.isComeraDeviceRelease) {
            [self dismissPopupController];
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }
    };
   
}
#pragma mark - 界面弹出框
- (void)showPopupWithStyle:(CNPPopupStyle)popupStyle popupView:(UIView *)popupView{
    self.popupViewController = [[CNPPopupController alloc] initWithContents:@[popupView]];
    self.popupViewController.theme = [CNPPopupTheme defaultTheme:popupView.frame.size.width];
    self.popupViewController.theme.popupStyle = popupStyle;
    self.popupViewController.theme.presentationStyle = CNPPopupPresentationStyleSlideInFromBottom;
    self.popupViewController.TapBgDis = NO;
    [self.popupViewController presentPopupControllerAnimated:YES];
}

- (void)dismissPopupController{
    [[NSNotificationCenter defaultCenter]postNotificationName:ResetCameraStatusIdentifier object:nil];
    [self.popupViewController dismissPopupControllerAnimated:YES];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [self.view endEditing:NO];;
}
@end
