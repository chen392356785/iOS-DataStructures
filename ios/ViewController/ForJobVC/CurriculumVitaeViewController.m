//
//  CurriculumVitaeViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/9/12.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "CurriculumVitaeViewController.h"
#import "ChatViewController.h"
@interface CurriculumVitaeViewController ()<UITableViewDelegate,ChatViewControllerDelegate>
{
    MTBaseTableView *commTableView;
//    int page;
    NSMutableArray *dataArray;
    NSDictionary *_dic;
}
@end

@implementation CurriculumVitaeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dataArray=[[NSMutableArray alloc]init];
    [network selectPersonlRecruitDetail:self.resume_id
                                user_id:[self.useId intValue]
                                success:^(NSDictionary *obj) {
                                    
                                    NSDictionary *dic=obj[@"content"];
                                    NSMutableArray *arr=[[NSMutableArray alloc]init];
                                    NSMutableArray *Arr=[[NSMutableArray alloc]init];
                                    [arr addObjectsFromArray:dic[@"recruitEdus"]];
                                    [Arr addObjectsFromArray:dic[@"recruitWorks"]];
                                    [self->dataArray addObject:obj[@"content"][@"advantage"]];
                                    [self->dataArray addObject:Arr];
                                    [self->dataArray addObject:arr];
                                    
                                    self->_dic=obj[@"dic"][@"content"];
                                    
                                    [self creatTableView:obj[@"dic"][@"content"]];
                                    
                                    
                                } failure:^(NSDictionary *obj2) {
                                    
                                }];
}

-(void)creatTableView:(NSDictionary *)dic{
    
    __weak CurriculumVitaeViewController *weakSelf=self;
    [weakSelf setNavBarItem:NO];
    
    searchBtn.hidden=YES;
    
    [self setTitle:[NSString stringWithFormat:@"%@",dic[@"nickname"]]];
    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 125)];
    topView.backgroundColor=[UIColor whiteColor];
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 9)];
    lineView.backgroundColor=RGB(247, 248, 250);
    [topView addSubview:lineView];
    
    CGSize size=[IHUtility GetSizeByText:dic[@"nickname"] sizeOfFont:15 width:200];
    SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0.032*WindowWith, 0.032*WindowWith+lineView.bottom, size.width, size.height) textColor:cGreenColor textFont:sysFont(15)];
    
    lbl.text=dic[@"nickname"];
    NSString *name=dic[@"nickname"];
    if (name.length>4) {
        name=[name substringToIndex:4];
        lbl.text=name;
    }
    [topView addSubview:lbl];
    
    UIAsyncImageView *headImageView=[[UIAsyncImageView alloc]initWithFrame:CGRectMake(WindowWith-0.192*WindowWith-0.032*WindowWith, lbl.top, 0.192*WindowWith, 0.192*WindowWith)];
    [headImageView setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@%@",ConfigManager.ImageUrl,dic[@"heed_image_url"],smallHeaderImage] placeholderImage:defalutHeadImage];
    [headImageView setLayerMasksCornerRadius:0.192*WindowWith/2 BorderWidth:0 borderColor:cGreenColor];
    [topView addSubview:headImageView];
    
    UIButton *adressBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *img=Image(@"Job_adress.png");
    [adressBtn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    size=[IHUtility GetSizeByText:dic[@"work_city"] sizeOfFont:13 width:100];
    [adressBtn setTitle:dic[@"work_city"] forState:UIControlStateNormal];
    [adressBtn setTitleColor:cGrayLightColor forState:UIControlStateNormal];
    adressBtn.titleLabel.font=sysFont(13);
    adressBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
    adressBtn.frame=CGRectMake(lbl.left, lbl.bottom+12, img.size.width+5+size.width, img.size.height);
    [topView addSubview:adressBtn];
    
    
    UIButton *experienceBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    img=Image(@"Job_experience.png");
    [experienceBtn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    size=[IHUtility GetSizeByText:dic[@"year_of_work"] sizeOfFont:13 width:200];
    [experienceBtn setTitle:dic[@"year_of_work"] forState:UIControlStateNormal];
    [experienceBtn setTitleColor:cGrayLightColor forState:UIControlStateNormal];
    experienceBtn.titleLabel.font=sysFont(13);
    experienceBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
    experienceBtn.frame=CGRectMake(11+adressBtn.right, adressBtn.top, img.size.width+5+size.width, img.size.height);
    [topView addSubview:experienceBtn];
    
    UIButton *academicBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    img=Image(@"Job_academic.png");
    [academicBtn setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    size=[IHUtility GetSizeByText:dic[@"highest_edu"] sizeOfFont:13 width:200];
    [academicBtn setTitle:dic[@"highest_edu"] forState:UIControlStateNormal];
    [academicBtn setTitleColor:cGrayLightColor forState:UIControlStateNormal];
    academicBtn.titleLabel.font=sysFont(13);
    academicBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
    academicBtn.frame=CGRectMake(11+experienceBtn.right, adressBtn.top, img.size.width+5+size.width, 13);
    [topView addSubview:academicBtn];
    
    size=[IHUtility GetSizeByText:[NSString stringWithFormat:@"期望的职位  %@",dic[@"expect_job_name"]] sizeOfFont:12 width:200];
    SMLabel *jobLbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.left, adressBtn.bottom+12, size.width, 12) textColor:cGrayLightColor textFont:sysFont(12)];
    
    jobLbl.text=[NSString stringWithFormat:@"期望的职位  %@",dic[@"expect_job_name"]];
    
    [topView addSubview:jobLbl];
    
    size=[IHUtility GetSizeByText:[NSString stringWithFormat:@"邮箱  %@",dic[@"email"]] sizeOfFont:12 width:200];
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.left, jobLbl.bottom+12, size.width, 12) textColor:cGrayLightColor textFont:sysFont(12)];
    if (![dic[@"email"] isEqualToString:@""]&&![dic[@"email"] isEqualToString:@"选填"]) {
        
        lbl.text=[NSString stringWithFormat:@"邮箱  %@",dic[@"email"]];
        
    }else{
        lbl.hidden=YES;
    }
    
    [topView addSubview:lbl];
    
    size=[IHUtility GetSizeByText:[NSString stringWithFormat:@"期望薪资  %@",dic[@"salary"]] sizeOfFont:12 width:200];
    
    SMLabel  *Lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(lbl.left, lbl.bottom+12, size.width, 12) textColor:cGrayLightColor textFont:sysFont(12)];
    if (lbl.hidden) {
        Lbl.top=lbl.top;
    }
    if ([dic[@"email"] isEqualToString:@""]) {
        Lbl.top=jobLbl.bottom+12;
    }
    Lbl.text=[NSString stringWithFormat:@"期望薪资  %@",dic[@"salary"]];
    [topView addSubview:Lbl];
    
    lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(Lbl.right+0.1*WindowWith, Lbl.top, 110, 12) textColor:cGrayLightColor textFont:sysFont(12)];
    
    lbl.text=@"在职－考虑换工作";
    if ([dic[@"workoff_status"] isEqualToString:@"1"]) {
        lbl.text=@"待业－正在找工作";
    }
    [topView addSubview:lbl];
    
    lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0.016*WindowWith, lbl.bottom+0.016*WindowWith)];
    lineView.backgroundColor=RGB(247, 248, 250);
    [topView addSubview:lineView];
    
    lineView=[[UIView alloc]initWithFrame:CGRectMake(WindowWith-0.016*WindowWith, 0, 0.016*WindowWith, lbl.bottom+0.016*WindowWith)];
    lineView.backgroundColor=RGB(247, 248, 250);
    [topView addSubview:lineView];
    
    topView.height=lbl.bottom+0.016*WindowWith;
    
    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight-49) tableviewStyle:UITableViewStyleGrouped];
    commTableView.table.showsVerticalScrollIndicator=NO;
    commTableView.table.delegate=self;
    commTableView.attribute=self;
    
    commTableView.table.tableHeaderView=topView;
    [commTableView setupData:dataArray index:41];
    [self.view addSubview:commTableView];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame=CGRectMake(0, WindowHeight-45, WindowWith-50, 38);
    btn.backgroundColor=cGreenColor;
    [btn setTintColor:[UIColor whiteColor]];
    [btn setTitle:@"立即沟通" forState:UIControlStateNormal];
    
    if ([self.useId isEqualToString:USERMODEL.userID]) {
        btn.hidden=YES;
    }
    [btn addTarget:self action:@selector(submitClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font=sysFont(18.8);
    [self.view addSubview:btn];
    btn.centerX=self.view.centerX;
    btn.layer.cornerRadius=20;
}
- (void)back:(id)sender
{
    if (self.type.length>0) {
        [self popViewController:0];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)submitClick:(UIButton *)sender{
    
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    ChatViewController *vc=[[ChatViewController alloc]initWithChatter:_dic[@"hx_user_name"] conversationType:eConversationTypeChat];
    vc.nickName=_dic[@"nickname"];
    vc.delelgate=self;
    vc.toUserID=[NSString stringWithFormat:@"%ld",(long)_dic[@"user_id"]];
    vc.HeadimgUrl=[NSString stringWithFormat:@"%@%@%@",ConfigManager.ImageUrl,_dic[@"heed_image_url"],smallHeaderImage];
    
    [self pushViewController:vc];
}

-(void)share{
    
    NSLog(@"%@",[NSString stringWithFormat:@"%@resume.html?id=%@",shareURL,_dic[@"resume_id"]] );
    
    [self ShareUrl:self withTittle:[NSString stringWithFormat:@"【招聘】强烈推荐！%@求职%@",_dic[@"nickname"],_dic[@"job_name"]] content:[NSString stringWithFormat:@"经验: %@  期望薪资: %@",_dic[@"highest_edu"],_dic[@"salary"]] withUrl: [NSString stringWithFormat:@"%@recruit/preview.html?id=%@",shareURL,_dic[@"resume_id"]] imgUrl:[NSString stringWithFormat:@"%@%@%@",ConfigManager.ImageUrl,_dic[@"heed_image_url"],smallHeaderImage]];
}

-(void)collection
{
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    
    [self addSucessView:@"收藏成功" type:1];
    UIImage *img=Image(@"activ_detailCollect.png");
    [searchBtn setBackgroundImage:img forState:UIControlStateNormal];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        NSString *text=dataArray[indexPath.section];
        CGSize size=[IHUtility GetSizeByText:text sizeOfFont:11 width:WindowWith-0.032*WindowWith*2];
        return size.height+15;
    }
    
    if (indexPath.section==1) {
        RecruitWorksModel *model=dataArray[indexPath.section][indexPath.row];
        CGSize  size=[IHUtility GetSizeByText:model.work_content sizeOfFont:11 width:WindowWith-0.032*WindowWith*2];
        return size.height+0.02*WindowWith+13+0.032*WindowWith;
        
    }else{
        RecruitEdusModel *model=dataArray[indexPath.section][indexPath.row];
        CGSize  size=[IHUtility GetSizeByText:model.experience sizeOfFont:11 width:WindowWith-0.032*WindowWith*2];
        return size.height+0.02*WindowWith+13+0.032*WindowWith;
    }
    return 76;
}

//段头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

#pragma mark - 外观代理
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 52)];
    view.backgroundColor=[UIColor whiteColor];
    
    
    SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0.032*WindowWith , 24, WindowWith-0.032*WindowWith, 15) textColor:cGreenColor textFont:sysFont(15)];
    lbl.text=@"工作职责";
    [view addSubview:lbl];
    
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 9)];
    lineView.backgroundColor=RGB(247, 248, 250);
    [view addSubview:lineView];
    
    lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith*0.016, 50)];
    lineView.backgroundColor=RGB(247, 248, 250);
    [view addSubview:lineView];
    
    lineView=[[UIView alloc]initWithFrame:CGRectMake(WindowWith-0.016*WindowWith, 0, WindowWith*0.016, 50)];
    lineView.backgroundColor=RGB(247, 248, 250);
    [view addSubview:lineView];
    
    if (section==1){
        
        lbl.text=@"工作经历";
        
    }else if (section==2){
        lbl.text=@"教育经历";
    }
    return view;
}

// 根据环信id得到要显示头像路径，如果返回nil，则显示默认头像
- (NSString *)avatarWithChatter:(NSString *)chatter{
    NSString *str=[NSString stringWithFormat:@"%@%@%@",ConfigManager.ImageUrl,_dic[@"heed_image_url"],smallHeaderImage];
    NSString *userID=[_dic[@"hx_user_name"] lowercaseString];
    
    if ([chatter isEqualToString:userID]) {
        return str;
    }else{
        return USERMODEL.userHeadImge80;
    }
    return nil;
}

// 根据环信id得到要显示用户名，如果返回nil，则默认显示环信id
- (NSString *)nickNameWithChatter:(NSString *)chatter{
    return chatter;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
