//
//  JoinTeacherController.m
//  MiaoTuProject
//
//  Created by Tomorrow on 2018/10/17.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "JoinTeacherController.h"
#import "ReleaseNewVarietyHeadView.h"
//#import "ZLPhotoActionSheet.h"

#include "ReleaseNewVarietyViewCell.h"


@interface JoinTeacherController () <UITableViewDelegate,UITableViewDataSource,ReleaseNewVarietyDelegate,UITextViewDelegate> {
    NSString *nameStr;
    NSString *phoneStr;
    NSString *CodeStr;
    NSString *QQStr;
    NSString *WXStr;
    NSString *PersonInfstr;
    NSArray *DataArr;
    UITableView *_tableView;
    UIButton *_submitBut;
    
    ReleaseNewVarietyHeadView *headView;
    ZLPhotoActionSheet *actionSheet;
    BOOL isFirstAddPhoto;
    NSMutableArray *TempImgsArr;
    NSMutableArray *imgsArr;
//    NSMutableArray *phoneArray;
    int channel;
}
@property (nonatomic, strong) UIButton *GetCodeNumBut;
@property (nonatomic, strong) PlaceholderTextView *personTextView;
@end


static NSString *ReleaseNewVarietyViewCellID = @"ReleaseNewVarietyViewCell";

@implementation JoinTeacherController

- (void)back:(id)sender {
    if (self.presentingViewController) {
        //判断1
        [self dismissViewControllerAnimated:YES completion:nil];
    } else if ([self.navigationController respondsToSelector:@selector(popViewControllerAnimated:)]) {
        //判断2
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (PlaceholderTextView *)personTextView {
    if (_personTextView == nil) {
        _personTextView = [[PlaceholderTextView alloc] initWithFrame:CGRectMake(kWidth(18), kWidth(8), iPhoneWidth - kWidth(36), kWidth(130))];
        _personTextView.backgroundColor = kColor(@"#f9f9f9");
        _personTextView.layer.cornerRadius = kWidth(4);
        _personTextView.delegate = self;
        _personTextView.placeholderColor = kColor(@"#727272");
        _personTextView.placeholderFont = sysFont(14);
        _personTextView.font = sysFont(14);
        _personTextView.placeholder = @"个人简介";
    }
    return _personTextView;
}
- (UIButton *)GetCodeNumBut {
    if (_GetCodeNumBut == nil) {
        _GetCodeNumBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _GetCodeNumBut.size = CGSizeMake(kWidth(98), kWidth(37));
        _GetCodeNumBut.backgroundColor = kColor(@"#29daa2");
        [_GetCodeNumBut setTintColor:kColor(@"#ffffff")];
        _GetCodeNumBut.layer.cornerRadius = kWidth(4);
        _GetCodeNumBut.titleLabel.font = boldFont(14);
        [_GetCodeNumBut setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_GetCodeNumBut addTarget:self action:@selector(getCodeNameAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _GetCodeNumBut;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"加入讲师";
    TempImgsArr = [[NSMutableArray alloc] init];
//    phoneArray = [[NSMutableArray alloc] init];
    imgsArr = [[NSMutableArray alloc] init];
    [self inPutTextnameInit];
    [self createTableview];
}
- (void) inPutTextnameInit {
    nameStr = @"";
    phoneStr = @"";
    CodeStr = @"";
    QQStr = @"";
    WXStr = @"";
    PersonInfstr = @"";
    DataArr = @[
                    @" 请输入您的名字（必填）",
                    @" 请输入您的手机号（必填）",
                    @" 请输入验证码（必填）",
                    @" QQ（选填）",
                    @" 微信（选填）",
                    @" 个人简介",
                    ];
}

- (void) createTableview {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, iPhoneHeight - KtopHeitht - kWidth(49)) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.estimatedSectionHeaderHeight = 8;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:_tableView];
    _tableView.estimatedSectionHeaderHeight = 0.;
    
    _submitBut = [UIButton buttonWithType:UIButtonTypeSystem];
    _submitBut.frame = CGRectMake(0,_tableView.bottom, iPhoneWidth, kWidth(49));
    _submitBut.backgroundColor = kColor(@"#29daa2");
    [_submitBut setTitle:@"确认" forState:UIControlStateNormal];
    [_submitBut setTitleColor:kColor(@"#ffffff") forState:UIControlStateNormal];
    _submitBut.titleLabel.font = boldFont(17);
    [_submitBut addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_submitBut];
    
    headView = [[ReleaseNewVarietyHeadView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, kWidth(158))];
    headView.delegage = self;
    headView.photoLabel.text = @"上传头像（必传）";
    headView.photoLabel.font = sysFont(14);
    headView.photoLabel.textColor = kColor(@"#727272");
    _tableView.tableFooterView = headView;
    [self setActionSheet];
}
- (void) setActionSheet {
    actionSheet = [[ZLPhotoActionSheet alloc] init];
    //设置照片最大选择数
    actionSheet.maxSelectCount = 1;
    //设置照片最大预览数
    actionSheet.maxPreviewCount = 20;
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




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return DataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == DataArr.count-1) {
        return kWidth(142);
    }
    return kWidth(49);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReleaseNewVarietyViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReleaseNewVarietyViewCellID];
    if (cell == nil) {
        cell = [[ReleaseNewVarietyViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ReleaseNewVarietyViewCellID];
    }
    cell.lineLabel.hidden = YES;
    cell.textField.frame = CGRectMake(kWidth(18), kWidth(8), iPhoneWidth - kWidth(36), kWidth(37));
    cell.textField.backgroundColor = kColor(@"#f9f9f9");
    cell.textField.layer.cornerRadius = kWidth(4);
    cell.textField.font = sysFont(14);
    cell.selectionStyle = UITableViewCellStyleDefault;
    [cell.textField setValue:[NSNumber numberWithInt:5] forKey:@"paddingLeft"];
    if (indexPath.row == 1) {
        cell.textField.frame = CGRectMake(kWidth(18), kWidth(8), iPhoneWidth - kWidth(36) - kWidth(108), kWidth(37));
        self.GetCodeNumBut.frame = CGRectMake(maxX(cell.textField) + kWidth(10), minY(cell.textField), self.GetCodeNumBut.size.width, self.GetCodeNumBut.size.height);
        [cell addSubview:self.GetCodeNumBut];
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
        cell.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    if (indexPath.row == 2 || indexPath.row == 3) {
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
        cell.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    if (indexPath.row == 5) {
        [cell.textField removeFromSuperview];
        [cell addSubview:self.personTextView];
        
    }
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:DataArr[indexPath.row] attributes:
                                      @{NSForegroundColorAttributeName:kColor(@"#727272"),
                                        NSFontAttributeName:cell.textField.font
                                        }];
    cell.textField.attributedPlaceholder = attrString;
    return cell;
}
#pragma - mark  获取验证码
- (void)getCodeNameAction:(UIButton *)but {
    ReleaseNewVarietyViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    phoneStr = cell.textField.text;
    if (![IHUtility isValidateMobile:phoneStr] || phoneStr.length <= 0) {
        [self addSucessView:[NSString stringWithFormat:@"手机号格式错误"] type:2];
        return;
    }
    [self addWaitingView];
    [network getSendRegisterSms:phoneStr type:8 chanle:channel  success:^(NSDictionary *obj) {
        self->channel++;
        [self removeWaitingView];
        [self addSucessView:@"验证码发送成功，请耐心等待哦^_^" type:1];
        [ConfigManager countdownSecond:60  returnTitle:^(NSString *title)
         {
             if (ConfigManager.seconds>0) {
                 [but setTitle:title forState:UIControlStateNormal];
                 but.userInteractionEnabled = NO;
             }
             else
             {
                 [but setTitle:@"重新获取" forState:UIControlStateNormal];
                 but.userInteractionEnabled = YES;
             }
         }];
    }];
}
#pragma - mark  提交
- (void)submitAction {
	
	for (int i = 0; i<DataArr.count; i++) {
		ReleaseNewVarietyViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
		if (i == 0) {
			nameStr = cell.textField.text;
			if (nameStr.length <= 0) {
				[self showTextHUD:@"请输入您的名字"];
				return;
			}
		}
		if (i == 1) {
			phoneStr = cell.textField.text;
			if (phoneStr.length <= 0) {
				[self showTextHUD:@"请输入您的手机号"];
				return;
			}
		}
		if (i == 2) {
			CodeStr = cell.textField.text;
			if (CodeStr.length <= 0) {
				[self showTextHUD:@"请输入验证码"];
				return;
			}
		}if (i == 3) {
			QQStr = cell.textField.text;
		}
		if (i == 4) {
			WXStr = cell.textField.text;
		}
		if (i == 4) {
			PersonInfstr = _personTextView.text;
		}
	}
	
    [self sendNewVariety];
}
- (void) sendNewVariety {
    NSLog(@"%@--%@ -- %@-- %@ -- %@ - %@ - %@",nameStr,phoneStr,CodeStr,QQStr,WXStr,PersonInfstr,TempImgsArr);
    
    //*
    if (![IHUtility isValidateMobile:phoneStr] && phoneStr.length > 0) {
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
                               @"code"           :self->CodeStr,
                               @"mobile"         :self->phoneStr,
                               @"headPic"        :obj,
                               @"name"           :self->nameStr,
                               @"intro"          :self->PersonInfstr,
                               @"wx"             :self->WXStr,
                               @"qq"             :self->QQStr,
                            };
        NSLog(@"--------           %@%@",@"http://8yyq8.com",obj);
        NSLog(@"--------           %@%@",@"https://image.8yyq8.com",obj);
        //*
        [network httpRequestWithParameter:dict method:addTeacherUrl success:^(NSDictionary *dic) {
            //            NSLog(@"00000----- %@",dic);
            [self removeWaitingView];
            [self addSucessView:@"您的资料已提交成功，正在安排审核！" type:1];
            [self dismissViewControllerAnimated:YES completion:nil];
        } failure:^(NSDictionary *dic) {
            [self removeWaitingView];
            //           NSLog(@"11111----- %@",dic);
        }];
        //*/
	} failure:^(NSError *error) {
		[self removeWaitingView];
	}];
    
}

@end
