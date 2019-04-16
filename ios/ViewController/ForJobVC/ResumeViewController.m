//
//  ResumeViewController.m
//  MiaoTuProject
//
//  Created by Zmh on 13/9/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "ResumeViewController.h"
#import "EditPersonInformationViewController.h"
#import "AdvantageViewController.h"
#import "JobIntentionViewController.h"
#import "JLSimplePickViewComponent.h"
#import "AddWorkExpViewController.h"
#import "CurriculumVitaeViewController.h"
#import "XHFriendlyLoadingView.h"

@interface ResumeViewController ()<JLActionSheetDelegate,JLDatePickViewDelegate,AddExprienceDelegate,advantageBackDelegate,JobIntentionBackDelegate>
{
    UIView *_topView;
    UIAsyncImageView *_heardImg;
    SMLabel *_sexLbl;
    
    UIView *_advantageView;//我的优势
    UIView *_JobIntentionView;//求职意向
    UIView *_salaryView;//薪资
    UIView *_workYearView;//工作年限
    UIView *_educationView;//学历
    UIView *_hiddenView;
    
    SMLabel *_advantageLbl;
    SMLabel *_JobIntentionLbl;
    SMLabel *_salaryLbl;
    SMLabel *_workYearLbl;
    SMLabel *_educationLbl;
    
    UIButton *_JobingBtn;//在职
    UIButton *_UnemployedBtn;//待业
    
    UIButton *_addWorked;
    UIButton *_addEducation;
    
    NSMutableArray *workExpArr;
    NSMutableArray *studyExpArr;
    NSDictionary *dataDic;
    NSMutableDictionary *mainDic;;
    
    UIView *_addEducationView ;
    UIView *_addWorkedView;
    
    NSString *_advantageText;
    NSString *_workState;
    NSString *_positionType;
    NSString *_workCity;
    NSString *_workCityID;
    NSString *_workPro;
    NSString *_workProID;
//    int position_id;
    int disPlay;//1 不隐藏 0 隐藏
    int resume_id;//提交获取到的简历ID
    
    NSMutableArray *eduArr;
    NSMutableArray *workArr;
    NSDictionary *purposeDic;//求职意向数据字典
    
}
@end

@implementation ResumeViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    rightbutton.frame = CGRectMake(0, 0, 60, 30);
    rightbutton.hidden =YES;
    [rightbutton setTitle:@"发送" forState:UIControlStateNormal];
    [rightbutton setTitleColor:cGreenColor forState:UIControlStateNormal];
    rightbutton.titleLabel.font = sysFont(14);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"个人简历"];
    workExpArr = [[NSMutableArray alloc] init];
    studyExpArr = [[NSMutableArray alloc] init];
    eduArr = [[NSMutableArray alloc] init];
    workArr = [[NSMutableArray alloc] init];
    
    _workState = @"1";
    disPlay= 1;
    resume_id = 0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setUserInfo) name:NotificationUpdateUserinfo object:nil];
    
    [IHUtility saveUserDefaluts:@[] key:kJobExprience];
    [IHUtility saveUserDefaluts:@[] key:kStudyExprience];
    
    if (self.type) {
        //我的简历
        [self reloadWaitingView];
    }else {
        //创建简历
        [self initViews];
    }
    
}
#pragma mark网络断开 从新链接
-(void)reloadWaitingView{
    [self addPushViewWaitingView];
    [network selectPersonlRecruitDetail:0 user_id:[USERMODEL.userID intValue] success:^(NSDictionary *obj) {
        
        self->dataDic = obj[@"dic"][@"content"];
        self->resume_id = [self->dataDic[@"resume_id"] intValue];
        //教育经历
        NSArray *Arr = obj[@"content"][@"recruitEdus"];
        [self->eduArr addObjectsFromArray:Arr];;
        for (RecruitEdusModel *model in self->eduArr) {
            self->mainDic = [[NSMutableDictionary alloc] init];
            [self->mainDic setValue:model.major forKey:@"company"];
            [self->mainDic setValue:model.start_date forKey:@"startTime"];
            [self->mainDic setValue:model.school_name forKey:@"job"];
            [self->mainDic setValue:model.end_date forKey:@"endTime"];
            [self->mainDic setValue:model.experience forKey:@"content"];
            
            [self->studyExpArr addObject:self->mainDic];
        }
        [IHUtility saveUserDefaluts:self->studyExpArr key:kStudyExprience];
        
        //工作经历
        NSArray *Arr1 = obj[@"content"][@"recruitWorks"];
        [self->workArr addObjectsFromArray:Arr1];
        for (RecruitWorksModel *model in self->workArr) {
            self->mainDic = [[NSMutableDictionary alloc] init];
            [self->mainDic setValue:model.company_name forKey:@"company"];
            [self->mainDic setValue:model.start_date forKey:@"startTime"];
            [self->mainDic setValue:model.job_name forKey:@"job"];
            [self->mainDic setValue:model.end_date forKey:@"endTime"];
            [self->mainDic setValue:model.work_content forKey:@"content"];
            
            [self->workExpArr addObject:self->mainDic];
        }
        [IHUtility saveUserDefaluts:self->workExpArr key:kJobExprience];
        
        [self removePushViewWaitingView];
        
        [self initViews];
        
    } failure:^(NSDictionary *obj2) {
        [self removePushViewWaitingView];
        XHFriendlyLoadingView *v=(XHFriendlyLoadingView*)[self.view viewWithTag:8172];
        [v showReloadViewWithText:reloadText];
        
        if ([obj2[@"errorNo"] intValue]== 502) {
            [self initViews];
        }
    }];
}
- (void)initViews
{
    _BaseScrollView.backgroundColor = cLineColor;
    
    //用户信息
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WindowWith, 90)];
    topView.backgroundColor = [UIColor whiteColor];
    _topView = topView;
    [_BaseScrollView addSubview:topView];
    
    NSDictionary *dic=[IHUtility getUserDefalutsDicKey:kUserDefalutLoginInfo];
    UIAsyncImageView *heardImg = [[UIAsyncImageView alloc] initWithFrame:CGRectMake(18, 0, 72, 72)];
    heardImg.image = defalutHeadImage;
    [heardImg setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@%@",ConfigManager.ImageUrl,dic[@"heed_image_url"],smallHeaderImage] placeholderImage:defalutHeadImage];
    heardImg.centerY = topView.height/2.0;
    heardImg.layer.cornerRadius = 36.0;
    _heardImg = heardImg;
    [topView addSubview:heardImg];
    
    SMLabel *lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(heardImg.right+8, 29, WindowWith -heardImg.right - 16, 20) textColor:cGrayLightColor textFont:sysFont(14)];
    NSString *userSex;
    if ([dic[@"sexy"] integerValue]==1) {
        userSex=@"男";
    }else if ([dic[@"sexy"] integerValue]==2){
        userSex=@"女";
    }
    _sexLbl = lbl;
    lbl.text = [NSString stringWithFormat:@"%@  |  %@",dic[@"nickname"],userSex];
    [topView addSubview:lbl];
    
    lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(heardImg.right+8, lbl.bottom+5, WindowWith -heardImg.right - 16, 18) textColor:cGrayLightColor textFont:sysFont(13)];
    lbl.text = @"编辑个人信息";
    [topView addSubview:lbl];
    
    UIImage *img = Image(@"iconfont-fanhui.png");
    UIImageView *rightImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
    rightImageV.image = img;
    rightImageV.centerY = topView.height/2.0;
    rightImageV.right = topView.width - 12;
    rightImageV.transform= CGAffineTransformMakeRotation(M_PI);
    [topView addSubview:rightImageV];
    
    lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(12, topView.bottom, WindowWith -24, 30) textColor:cGrayLightColor textFont:sysFont(14)];
    lbl.text = @"简历详情";
    lbl.backgroundColor = [UIColor clearColor];
    [_BaseScrollView addSubview:lbl];
    
    //工作状态
    UIView *workStateView = [[UIView alloc]initWithFrame:CGRectMake(0, lbl.bottom, WindowWith, 70)];
    workStateView.backgroundColor = [UIColor whiteColor];
    [_BaseScrollView addSubview:workStateView];
    
    CGSize size= [IHUtility GetSizeByText:@"离职状态" sizeOfFont:13 width:120];
    lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(17.5, 10, size.width, 20) textColor:cBlackColor textFont:sysFont(13)];
    lbl.text = @"离职状态";
    [workStateView addSubview:lbl];
    
    img = Image(@"Job_workStateNo.png");
    UIImage *selectedImg = Image(@"Job_workStateYes.png");
    
    UIButton *slectedBtn = [[UIButton alloc] initWithFrame:CGRectMake(lbl.left, lbl.bottom + 8, img.size.width, img.size.height)];
    [slectedBtn setImage:img forState:UIControlStateNormal];
    [slectedBtn setImage:selectedImg forState:UIControlStateSelected];
    slectedBtn.selected = YES;
    if ([dataDic[@"workoff_status"] intValue] == 2) {
        slectedBtn.selected = NO;
    }
    slectedBtn.tag = 67;
    
    _UnemployedBtn =slectedBtn;
    [slectedBtn addTarget:self action:@selector(selectWorkState:) forControlEvents:UIControlEventTouchUpInside];
    [workStateView addSubview:slectedBtn];
    
    size = [IHUtility GetSizeByText:@"待业-正在找工作" sizeOfFont:13 width:120];
    lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(slectedBtn.right + 8, 0,size.width, 20) textColor:cGrayLightColor textFont:sysFont(13)];
    lbl.text = @"待业-正在找工作";
    lbl.centerY = slectedBtn.centerY;
    lbl.userInteractionEnabled = YES;
    [workStateView addSubview:lbl];
    
    UITapGestureRecognizer *tapJob = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapUnemployed:)];
    tapJob.numberOfTapsRequired= 1;
    tapJob.numberOfTouchesRequired= 1;
    [lbl addGestureRecognizer:tapJob];
    
    
    slectedBtn = [[UIButton alloc] initWithFrame:CGRectMake(lbl.right + 15, slectedBtn.top, img.size.width, img.size.height)];
    [slectedBtn setImage:img forState:UIControlStateNormal];
    [slectedBtn setImage:selectedImg forState:UIControlStateSelected];
    slectedBtn.tag = 66;
    _JobingBtn =slectedBtn;
    if ([dataDic[@"workoff_status"] intValue] == 1) {
        slectedBtn.selected = NO;
    }else if ([dataDic[@"workoff_status"] intValue] == 2){
        slectedBtn.selected = YES;
    }
    [slectedBtn addTarget:self action:@selector(selectWorkState:) forControlEvents:UIControlEventTouchUpInside];
    [workStateView addSubview:slectedBtn];
    
    lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(slectedBtn.right + 8, 0,size.width, 20) textColor:cGrayLightColor textFont:sysFont(13)];
    lbl.text = @"在职-考虑换工作";
    lbl.centerY = slectedBtn.centerY;
    lbl.userInteractionEnabled = YES;
    [workStateView addSubview:lbl];
    
    UITapGestureRecognizer *tapJob1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapJobState:)];
    tapJob1.numberOfTapsRequired= 1;
    tapJob1.numberOfTouchesRequired= 1;
    [lbl addGestureRecognizer:tapJob1];
    
    
    NSArray *arr = @[@"我的优势",@"管理求职意向",@"期望薪资",@"最高学历",@"工作经验"];
    for (int i = 0; i<5; i++) {
        UIView *advantageView = [[UIView alloc] initWithFrame:CGRectMake(0, workStateView.bottom + 0.7 + 50.7*i, WindowWith, 50)];
        advantageView.backgroundColor = [UIColor whiteColor];
        [_BaseScrollView addSubview:advantageView];
        
        CGSize size= [IHUtility GetSizeByText:arr[i] sizeOfFont:13 width:120];
        SMLabel *lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(17.5, 0, size.width, 20) textColor:cBlackColor textFont:sysFont(13)];
        lbl.text = arr[i];
        lbl.centerY = advantageView.height/2.0;
        [advantageView addSubview:lbl];
        
        UIImage *image = Image(@"iconfont-fanhui.png");
        UIImageView *rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
        rightImg.image = image;
        rightImg.centerY = advantageView.height/2.0;
        rightImg.right = advantageView.width - 12;
        rightImg.transform= CGAffineTransformMakeRotation(M_PI);
        [advantageView addSubview:rightImg];
        
        lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(lbl.right + 8, 0, rightImg.left -lbl.right -16 , 20) textColor:cGrayLightColor textFont:sysFont(13)];
        if (i!=0 && i!=1) {
            lbl.text = @"暂无";
        }
        lbl.textAlignment = NSTextAlignmentRight;
        lbl.centerY = advantageView.height/2.0;
        [advantageView addSubview:lbl];
        
        if (i==0) {
            _advantageView = advantageView;
            _advantageLbl = lbl;
            if (stringFormatString(dataDic[@"advantage"]).length > 0&&dataDic !=nil) {
                _advantageLbl.text = @"已填写";
                _advantageText = stringFormatString(dataDic[@"advantage"]);
            }
        }else if (i==1){
            _JobIntentionView = advantageView;
            _JobIntentionLbl = lbl;
            if (stringFormatString(dataDic[@"expect_job_name"]).length > 0&&dataDic !=nil) {
                _JobIntentionLbl.text = @"已填写";
//                position_id = [dataDic[@"expect_job_type"] intValue];
                _workCity = stringFormatString(dataDic[@"work_city"]);
                
                NSMutableDictionary *Dic = [[NSMutableDictionary alloc] init];
                [Dic setObject:dataDic[@"work_city"] forKey:@"work_city"];
                _workCity = dataDic[@"work_city"];
                [Dic setObject:dataDic[@"expect_job_name"] forKey:@"job_name_id"];
                _positionType = dataDic[@"expect_job_name"];
                [Dic setObject:dataDic[@"job_name"] forKey:@"job_name"];
                [Dic setObject:dataDic[@"province_id"] forKey:@"province_id"];
                _workProID =dataDic[@"province_id"];
                [Dic setObject:dataDic[@"city_id"] forKey:@"city_id"];
                _workCityID = dataDic[@"city_id"];
                [Dic setObject:dataDic[@"work_province"] forKey:@"work_province"];
                _workPro = dataDic[@"work_province"];
                
                purposeDic = Dic;
            }
        }else if (i==2){
            _salaryView = advantageView;
            _salaryLbl = lbl;
            if (stringFormatString(dataDic[@"salary"]).length > 0&&dataDic !=nil) {
                _salaryLbl.text = stringFormatString(dataDic[@"salary"]);
            }
        }else if (i==3){
            _educationView = advantageView;
            _educationLbl = lbl;
            if (stringFormatString(dataDic[@"highest_edu"]).length > 0&&dataDic !=nil) {
                _educationLbl.text = stringFormatString(dataDic[@"highest_edu"]);
            }
        }else if (i==4){
            
            _workYearView = advantageView;
            _workYearLbl = lbl;
            if (stringFormatString(dataDic[@"year_of_work"]).length > 0&&dataDic !=nil) {
                _workYearLbl.text = stringFormatString(dataDic[@"year_of_work"]);
            }
        }
    }
    UIView *addWorkedView = [[UIView alloc] initWithFrame:CGRectMake(0,_workYearView.bottom +12 , WindowWith, 50)];
    addWorkedView.backgroundColor = cLineColor;
    _addWorkedView = addWorkedView;
    
    UIButton *addWorked = [[UIButton alloc] initWithFrame:CGRectMake(0,0 , WindowWith, 50)];
    addWorked.backgroundColor = [UIColor whiteColor];
    [addWorked setTitle:@"+  添加工作经历" forState:UIControlStateNormal];
    [addWorked setTitleColor:cGreenColor forState:UIControlStateNormal];
    addWorked.titleLabel.font = sysFont(13);
    [addWorked addTarget:self action:@selector(addWorked:) forControlEvents:UIControlEventTouchUpInside];
    _addWorked = addWorked;
    [addWorkedView addSubview:addWorked];
    [_BaseScrollView addSubview:addWorkedView];
    
    UIView *addEducationView = [[UIView alloc] initWithFrame:CGRectMake(0,addWorkedView.bottom +5 , WindowWith, 50)];
    addEducationView.backgroundColor = cLineColor;
    _addEducationView = addEducationView;
    
    UIButton *addEducation = [[UIButton alloc] initWithFrame:CGRectMake(0,0 , WindowWith, 50)];
    addEducation.backgroundColor = [UIColor whiteColor];
    [addEducation setTitle:@"+  添加教育经历" forState:UIControlStateNormal];
    [addEducation setTitleColor:cGreenColor forState:UIControlStateNormal];
    addEducation.titleLabel.font = sysFont(13);
    [addEducation addTarget:self action:@selector(addEducation:) forControlEvents:UIControlEventTouchUpInside];
    _addEducation = addEducation;
    [addEducationView addSubview:addEducation];
    [_BaseScrollView addSubview:addEducationView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, addEducationView.bottom + 5 , WindowWith, 50)];
    view.backgroundColor = [UIColor whiteColor];
    _hiddenView = view;
    [_BaseScrollView addSubview:view];
    
    size= [IHUtility GetSizeByText:@"隐藏简历" sizeOfFont:14 width:120];
    SMLabel *label = [[SMLabel alloc] initWithFrameWith:CGRectMake(17.5, 0, size.width, 20) textColor:cBlackColor textFont:sysFont(14)];
    label.text = @"隐藏简历";
    label.centerY = view.height/2.0;
    [view addSubview:label];
    
    UISwitch *swi1=[[UISwitch alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    swi1.onTintColor=cGreenColor;
    swi1.centerY = view.height/2.0;
    swi1.right = view.width - 12;
    if ([dataDic[@"display"] intValue]!= 1) {
        [swi1 setOn:YES];
    }
    [swi1 addTarget:self action:@selector(getValue1:) forControlEvents:UIControlEventValueChanged];
    
    [view addSubview:swi1];
    
    _BaseScrollView.contentSize = CGSizeMake(WindowWith, view.bottom + 119);
    
    _BaseScrollView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBaseView:)];
    tap.numberOfTapsRequired= 1;
    tap.numberOfTouchesRequired= 1;
    [_BaseScrollView addGestureRecognizer:tap];
    
    UIView *BottomView = [[UIView alloc] initWithFrame:CGRectMake(0, WindowHeight-49, WindowWith, 49)];
    BottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:BottomView];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(18, 0, WindowWith - 36, 35)];
    [btn setTitle:@" 保存并预览简历" forState:UIControlStateNormal];
    btn.centerY = BottomView.height/2.0;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 19.0;
    btn.backgroundColor = cGreenColor;
    btn.titleLabel.font = sysFont(15);
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [BottomView addSubview:btn];
    
    //获取显示原有的工作经历
    [self reloadExprience:@"1"];
    //获取显示原有的教育经历
    [self reloadExprience:@"2"];
}
- (void)reloadExprience:(NSString *)type
{
    [workExpArr removeAllObjects];
    
    if ([type isEqualToString:@"1"]) {
        //获取工作经历
        NSArray *arr = [IHUtility getUserdefalutsList:kJobExprience];
        [workExpArr addObjectsFromArray:arr];
    }else {
        //获取教育经历
        NSArray *arr = [IHUtility getUserdefalutsList:kStudyExprience];
        [workExpArr addObjectsFromArray:arr];
    }
    
    //根据经历创建相对应的经历View
    for (int i=0; i<workExpArr.count; i++) {
        NSDictionary *dic = workExpArr[i];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,50.5 *i, WindowWith, 50)];
        view.backgroundColor = [UIColor whiteColor];
        view.userInteractionEnabled = YES;
        
        NSString *str;
        if ([type isEqualToString:@"1"]) {
            [_addWorkedView addSubview:view];
            str = dic[@"company"];
            view.tag = 8+i;
        }else {
            [_addEducationView addSubview:view];
            str = dic[@"job"];
            view.tag = 80+i;
        }
        
        CGSize size= [IHUtility GetSizeByText:str sizeOfFont:13 width:200];
        SMLabel *lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(17.5, 0, size.width, 20) textColor:cBlackColor textFont:sysFont(13)];
        lbl.text = str;
        lbl.centerY = view.height/2.0;
        [view addSubview:lbl];
        
        UIImage *image = Image(@"iconfont-fanhui.png");
        UIImageView *rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
        rightImg.image = image;
        rightImg.centerY = view.height/2.0;
        rightImg.right = view.width - 12;
        rightImg.transform= CGAffineTransformMakeRotation(M_PI);
        [view addSubview:rightImg];
        
        lbl = [[SMLabel alloc] initWithFrameWith:CGRectMake(lbl.right + 8, 0, rightImg.left -lbl.right -16 , 20) textColor:cGrayLightColor textFont:sysFont(13)];
        lbl.text = [NSString stringWithFormat:@"%@ - %@",dic[@"startTime" ],dic[@"endTime"]];
        lbl.textAlignment = NSTextAlignmentRight;
        lbl.centerY = view.height/2.0;
        [view addSubview:lbl];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapExpView:)];
        tap.numberOfTapsRequired= 1;
        tap.numberOfTouchesRequired= 1;
        [view addGestureRecognizer:tap];
    }
    
    if ([type isEqualToString:@"1"]) {
        _addWorked.top = 50.5*workExpArr.count;
        _addWorkedView.height = 50.5*workExpArr.count + _addWorked.height;
        _addEducationView.top = _addWorkedView.bottom + 5;
        _hiddenView.top = _addEducationView.bottom + 5;
    }else{
        _addEducation.top = 50.5*workExpArr.count;
        _addEducationView.height = 50.5*workExpArr.count + _addEducation.height;
        _hiddenView.top = _addEducationView.bottom + 5;
    }
    
    _BaseScrollView.contentSize = CGSizeMake(WindowWith, _hiddenView.bottom + 119);
}
//修改个人资料之后
- (void)setUserInfo{
    NSDictionary *dic=[IHUtility getUserDefalutsDicKey:kUserDefalutLoginInfo];
    [_heardImg setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@%@",ConfigManager.ImageUrl,dic[@"heed_image_url"],smallHeaderImage] placeholderImage:defalutHeadImage];
    
    NSString *userSex;
    if ([dic[@"sexy"] integerValue]==1) {
        userSex=@"男";
    }else if ([dic[@"sexy"] integerValue]==2){
        userSex=@"女";
    }
    _sexLbl.text = [NSString stringWithFormat:@"%@  |  %@",dic[@"nickname"],userSex];
}
- (void)tapUnemployed:(UITapGestureRecognizer *)tap
{
    [self selectWorkState:_UnemployedBtn];
}
- (void)tapJobState:(UITapGestureRecognizer *)tap
{
    [self selectWorkState:_JobingBtn];
}
//选择工作状态
- (void)selectWorkState:(UIButton *)button
{
    button.selected = YES;
    
    if (button.tag == 66) {
        UIButton *btn = [_BaseScrollView viewWithTag:67];
        btn.selected = NO;
        
        //在职
        _workState = @"2";
        
    }else {
        UIButton *btn = [_BaseScrollView viewWithTag:66];
        btn.selected = NO;
        
        //离职
        _workState = @"1";
    }
}
//添加工作经历
- (void)addWorked:(UIButton *)button
{
    AddWorkExpViewController *vc = [[AddWorkExpViewController alloc] init];
    vc.titleStr = @"工作经历";
    vc.delegate= self;
    [self pushViewController:vc];
}
//添加学历
- (void)addEducation:(UIButton *)button
{
    AddWorkExpViewController *vc = [[AddWorkExpViewController alloc] init];
    vc.titleStr = @"教育经历";
    vc.delegate= self;
    
    [self pushViewController:vc];
}

- (void)home:(id)sender
{
    [self btnAction:nil];
}
//保存简历
- (void)btnAction:(UIButton *)button
{
    //获取保存在本地的经历数据打包成数组上传服务器
    NSArray *JobArr = [IHUtility getUserdefalutsList:kJobExprience];
    NSMutableArray *JobExpArr = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in JobArr) {
        NSMutableDictionary *jobDic = [[NSMutableDictionary alloc] init];
        [jobDic setObject:dic[@"company"] forKey:@"company_name"];
        [jobDic setObject:dic[@"job"] forKey:@"job_name"];
        [jobDic setObject:dic[@"startTime"] forKey:@"start_date"];
        [jobDic setObject:dic[@"endTime"] forKey:@"end_date"];
        [jobDic setObject:dic[@"content"] forKey:@"work_content"];
        [jobDic setObject:@"" forKey:@"resume_id"];
        
        [JobExpArr addObject:jobDic];
    }
    
    NSArray *studyArr = [IHUtility getUserdefalutsList:kStudyExprience];
    NSMutableArray *eduExpArr = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in studyArr) {
        NSMutableDictionary *jobDic = [[NSMutableDictionary alloc] init];
        [jobDic setObject:dic[@"company"] forKey:@"major"];
        [jobDic setObject:dic[@"job"] forKey:@"school_name"];
        [jobDic setObject:dic[@"startTime"] forKey:@"start_date"];
        [jobDic setObject:dic[@"endTime"] forKey:@"end_date"];
        [jobDic setObject:dic[@"content"] forKey:@"experience"];
        [jobDic setObject:@"" forKey:@"resume_id"];
        
        [eduExpArr addObject:jobDic];
    }
    
    if ([self isWhetherResumeInfoFill]) {
        if ([_workYearLbl.text isEqualToString:@"应届生"]) {
            
            if (eduExpArr.count == 0) {
                [IHUtility addSucessView:@"未填写教育经历" type:2];
                return;
            }
        }else {
            if (workExpArr.count == 0) {
                [IHUtility addSucessView:@"未填写工作经历" type:2];
                return;
            }
            if (eduExpArr.count == 0) {
                [IHUtility addSucessView:@"未填写教育经历" type:2];
                return;
            }
        }
    }else{
        return;
    }
    
    [network saveUserResume:stringFormatInt(resume_id) workoff_status:_workState salary:_salaryLbl.text year_of_work:_workYearLbl.text highest_edu:_educationLbl.text advantage:_advantageText display:stringFormatInt(disPlay) expect_job_type:_positionType province_id:_workProID work_province:_workPro city_id:_workCityID work_city:_workCity recruitEdus:eduExpArr recruitWorks:JobExpArr success:^(NSDictionary *obj) {
        NSDictionary *dic = obj[@"content"];
        
        if (button) {
            CurriculumVitaeViewController *vc=[[CurriculumVitaeViewController alloc]init];
            vc.resume_id = [dic[@"resume_id"] intValue];
            vc.useId = [NSString stringWithFormat:@"%@",dic[@"user_id"]];
            vc.type = @"yes";
            
            [self pushViewController:vc];
            
        }else {
            //点击发送的时候 先调用保存接口 然后在调发送接口
            [self sendResume];
        }
        
    } failure:^(NSDictionary *obj2) {
        
    }];
}
- (void)sendResume
{
    [self addWaitingView];
    [network getDeliveryResume:USERMODEL.nickName hx_user_name:self.model.hx_user_name job_id:(int)self.model.job_id company_name:self.model.company_name staff_size:self.model.staff_size success:^(NSDictionary *obj) {
        
        [self addSucessView:@"投递成功" type:1];
        
        [self.Delegate disPalySendResumeSuccess];
        
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSDictionary *obj2) {
        
    }];
    
}
- (BOOL)isWhetherResumeInfoFill
{
    if (_salaryLbl.text.length==0||[_salaryLbl.text isEqualToString:@"暂无"]) {
        [IHUtility addSucessView:@"未选择期望薪资" type:2];
        return NO;
    }
    if (_workYearLbl.text.length==0||[_workYearLbl.text isEqualToString:@"暂无"]) {
        [IHUtility addSucessView:@"未选择工作经验" type:2];
        return NO;
    }
    
    if (_educationLbl.text.length==0||[_educationLbl.text isEqualToString:@"暂无"]) {
        [IHUtility addSucessView:@"未选择最高学历" type:2];
        return NO;
    }
    
    if (_advantageText.length<=0) {
        [IHUtility addSucessView:@"未填写我的优势" type:2];
        return NO;
    }
    
    if (_workCity.length<=0) {
        [IHUtility addSucessView:@"未填写求职意向" type:2];
        return NO;
    }
    return YES;
}
//隐藏简历
- (void)getValue1:(UISwitch *)sw
{
    if (sw.isOn) {
        disPlay = 0;
    }else {
        disPlay = 1;
    }
}
- (void)tapExpView:(UITapGestureRecognizer *)tap
{
    [workExpArr removeAllObjects];
    UIView *view = tap.view;
    UIView *superView = view.superview;
    
    AddWorkExpViewController *vc = [[AddWorkExpViewController alloc] init];
    vc.delegate= self;
    NSDictionary *dic;
    if (superView == _addWorkedView) {
        NSArray *arr = [IHUtility getUserdefalutsList:kJobExprience];
        [workExpArr addObjectsFromArray:arr];
        dic = workExpArr[view.tag-8];
        vc.titleStr = @"工作经历";
    }else {
        NSArray *arr = [IHUtility getUserdefalutsList:kStudyExprience];
        [workExpArr addObjectsFromArray:arr];
        dic = workExpArr[view.tag-80];
        vc.titleStr = @"教育经历";
    }
    
    vc.infoDic = dic;
    
    [self pushViewController:vc];
    
    
    
    
}

- (void)tapBaseView:(UITapGestureRecognizer *)tap
{
    CGPoint point = [tap locationInView:_BaseScrollView];
    if (CGRectContainsPoint(_topView.frame, point)) {
        
        EditPersonInformationViewController *editVC=[[EditPersonInformationViewController alloc]init];
        
        
        [self pushViewController:editVC];
        
        
    }else if (CGRectContainsPoint(_advantageView.frame, point)){
        
        AdvantageViewController *VC = [[AdvantageViewController alloc] init];
        VC.delegate = self;
        VC.content = _advantageText;
        
        
        [self pushViewController:VC];
        
        
    }else if (CGRectContainsPoint(_JobIntentionView.frame, point)){
        
        JobIntentionViewController *VC = [[JobIntentionViewController alloc] init];
        VC.delegate = self;
        VC.purposeDic = purposeDic;
        
        [self pushViewController:VC];
        
        
    }else if (CGRectContainsPoint(_salaryView.frame, point)){
        
        [self showPicViewWithArr:@[@"面议",@"3k以下",@"3k-5k",@"5k-10k",@"10k-20k",@"20k-50k",@"50k以上"] :@"薪资" :23];
        
    }else if (CGRectContainsPoint(_workYearView.frame, point)){
        [self showPicViewWithArr:@[@"应届生",@"一年内",@"1-3年",@"3-5年",@"5-10年",@"10年以上"] :@"经验" :25];
        
    }else if (CGRectContainsPoint(_educationView.frame, point)){
        
        [self showPicViewWithArr:@[@"高中",@"中专",@"大专",@"本科",@"硕士",@"博士"] :@"学历" :24];
    }
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
    
    if (pickViewComponent.tag == 23) {
        _salaryLbl.text = SelectedStr;
    }else if (pickViewComponent.tag == 24){
        _educationLbl.text = SelectedStr;
    }else if (pickViewComponent.tag == 25){
        _workYearLbl.text = SelectedStr;
    }
}
//添加经历回调
- (void)disPalyAddExprience:(NSString *)type
{
    
    [self reloadExprience:type];
}
//我的优势回调
- (void)disPalyAdvantageContent:(NSString *)content
{
    _advantageLbl.text = @"已填写";
    _advantageText = content;
}
//管理求职意向
- (void)disPalyJobIntention:(NSString *)positionType Pro_id:(NSString *)Pro_id ProStr:(NSString *)proStr city_id:(NSString *)city_id cityStr:(NSString *)cityStr
{
    _JobIntentionLbl.text = @"已填写";
    _positionType = positionType;
    
    _workCity = cityStr;
    _workCityID = city_id;
    
    _workPro = proStr;
    _workProID = Pro_id;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
