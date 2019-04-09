//
//  ECloudHomePageChildrenViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/10/20.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "ECloudHomePageChildrenViewController.h"
#import "EPCloudDetailViewController.h"
#import "EPCloudConnectionViewController.h"
#import "NewECloudSearchViewController.h"
#import "EPCloudListViewController.h"
#import "MTOtherInfomationMainViewController.h"
#import "JionEPCloudViewController.h"
#import "CollectionHeaderView.h"
#import "XLPlainFlowLayout.h"
#define Scale  WindowWith/375.0
#define kHead  UICollectionElementKindSectionHeader
@interface ECloudHomePageChildrenViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIGestureRecognizerDelegate>
{
    UICollectionView *_collectionView;
    NSMutableArray *dataArr;
    NSMutableArray *_dataSource;
    //    NSMutableArray *dataSource;
    int page;
    UIButton *_createBtn;
}
@end

@implementation ECloudHomePageChildrenViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setHomeTabBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dataArr = [[NSMutableArray alloc] init];
    _dataSource=[[NSMutableArray alloc]init];
    page=0;
    
    __weak ECloudHomePageChildrenViewController *weakSelf=self;
    
    UIView *searchView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 40)];
    searchView.backgroundColor=RGB(247, 248, 250);
    [self.view addSubview:searchView];
    
    searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame=CGRectMake(20, 5, WindowWith-40, 30);
    searchBtn.backgroundColor=[UIColor whiteColor];
    [searchBtn setImage:Image(@"EP_search.png") forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(collection) forControlEvents:UIControlEventTouchUpInside];
    [searchView addSubview:searchBtn];
    
    XLPlainFlowLayout *layout = [[XLPlainFlowLayout alloc] init];
    
    if (self.type == ENT_company) {
        layout.itemSize = CGSizeMake((WindowWith-20*3*Scale)/2.0, 100*Scale + 30);//每个cell的高度为图片以及最后空白盖度缩放后的高度加上名字高度以及名字与图片的间距
        layout.sectionInset = UIEdgeInsetsMake(8, 20*Scale, 8 , 20*Scale);
        layout.minimumInteritemSpacing = 20*Scale;
        layout.minimumLineSpacing = 0;
    }else {
        layout.itemSize = CGSizeMake((WindowWith-30*4*Scale)/3.0, 100*Scale + 30);//每个cell的高度为图片缩放后的高度加上其他高度
        layout.sectionInset = UIEdgeInsetsMake(8, 30*Scale, 8 , 30*Scale);
        layout.minimumInteritemSpacing = 30*Scale;
        layout.minimumLineSpacing = 0;
    }
    layout.headerReferenceSize = CGSizeMake(WindowWith, 44);
    layout.naviHeight=0;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,  searchView.bottom, WindowWith, WindowHeight-searchView.bottom) collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    if (self.type==ENT_Connections) {
        [_collectionView registerClass:[EPCloudConnectionCollectionView class] forCellWithReuseIdentifier: @"EPCloudConnectionCollectionView"];
    }else{
        [_collectionView registerClass:[EPCloudCompanyCollectionView class] forCellWithReuseIdentifier: @"EPCloudCompanyCollectionView"];
    }
    
    [_collectionView registerClass:[CollectionHeaderView class] forSupplementaryViewOfKind:kHead withReuseIdentifier:@"header"];
    
    [self.view addSubview:_collectionView];
    if (self.type==ENT_company) {
        [self CreateCollectionViewRefesh:_collectionView type:ENT_RefreshFooter successRefesh:^(MJRefreshComponent *refreshView) {
            [weakSelf loadRefesh:refreshView];
        }];
        [self begincollectionViewRefesh:ENT_RefreshFooter];
        
    }else{
        [self loadRefesh];
    }
    
    UIButton* createBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    createBtn.frame=CGRectMake(WindowWith/2-128/2, WindowHeight-80, 128, 38) ;
     createBtn.frame=CGRectMake(WindowWith-kWidth(74), WindowHeight-80, kWidth(54), kWidth(54)) ;
    if (self.type==ENT_company) {
        [createBtn setTitle:@"加入\n企业云" forState:UIControlStateNormal];
    }else{
        [createBtn setTitle:@"加入\n人脉云" forState:UIControlStateNormal];
    }
    [createBtn addTarget:self action:@selector(pushToEp) forControlEvents:UIControlEventTouchUpInside];
    _createBtn=createBtn;
    
    createBtn.titleLabel.numberOfLines = 0;
    createBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [createBtn setLayerMasksCornerRadius:createBtn.height/2. BorderWidth:0.1 borderColor:cGreenColor];
    
//    [createBtn setLayerMasksCornerRadius:20 BorderWidth:0.1 borderColor:cGreenColor];
    [createBtn setBackgroundColor:cGreenColor];
    createBtn.titleLabel.font=sysFont(14);
//    createBtn.titleLabel.font=sysFont(15);
    [createBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:createBtn];
}

-(void)loadRefesh{
    [self addPushViewWaitingView];
    if (self.type==ENT_Connections) {
        
        [network selectRecommendUserInfo:[USERMODEL.userID intValue] success:^(NSDictionary *obj) {
            
            NSArray *arr=obj[@"content"];
            [self->dataArr addObjectsFromArray:arr];
            
            [self->_collectionView reloadData];
            
            [self removePushViewWaitingView];
        } failure:^(NSDictionary *obj2) {
            
        }];
        
    }else{
    
    }
}
-(void)backTopClick:(UIButton *)sender{
    [self scrollTopPoint:_collectionView];
}

-(void)loadRefesh:(MJRefreshComponent *)refreshView{
    
    [network selectCompanyRandListByLabelsuccess:^(NSDictionary *obj) {
        NSArray *Arr=obj[@"content2"];
        if (self->page==0) {
            [self->_dataSource addObjectsFromArray:Arr];
        }
        
        [network selectCompanyRandListpage:self->page num:pageNum success:^(NSDictionary *obj) {
            NSArray *Arr=obj[@"content2"];
            if (Arr.count>0) {
                self->page++;
                if (Arr.count<pageNum) {
                    [self->_collectionView.mj_footer endRefreshingWithNoMoreData];
                }
            }else{
                
                [self->_collectionView.mj_footer endRefreshingWithNoMoreData];
                [self endcollectionViewRefresh];
                return ;
            }
            
            [self->dataArr addObjectsFromArray:Arr];
            [self->_collectionView reloadData];
            [self endcollectionViewRefresh];
            
            [self removePushViewWaitingView];
        } failure:^(NSDictionary *obj2) {
            
        }];
    } failure:^(NSDictionary *obj2) {
        
    }];
}

-(void)collection{
    
    NewECloudSearchViewController *vc=[[NewECloudSearchViewController alloc]init];
    vc.type=self.type;
    [self.inviteParentController pushViewController:vc];
}

#pragma mark - collection数据源代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.type==ENT_company) {
        if (section==0) {
            return _dataSource.count;
        }
        return dataArr.count;
    }
    return dataArr.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if(self.type==ENT_company){
        return 2;
    }
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    __weak ECloudHomePageChildrenViewController *weakSelf=self;
    //企业云
    if (self.type == ENT_company) {
        EPCloudCompanyCollectionView * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EPCloudCompanyCollectionView" forIndexPath:indexPath];
        
        if (indexPath.section==0) {
            EPCloudListModel *model = _dataSource[indexPath.row];
            cell.selectBlock=^(NSInteger index){
                [weakSelf pushToCompany:indexPath];
            };
            [cell setCollectionViewCompanyData:model];
        }else if(indexPath.section==1){
            EPCloudListModel *model = dataArr[indexPath.row];
            cell.selectBlock=^(NSInteger index){
                [weakSelf pushToCompany:indexPath];
            };
            [cell setCollectionViewCompanyData:model];
        }
        
        return cell;
    }else {
        //人脉云
        EPCloudConnectionCollectionView * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EPCloudConnectionCollectionView" forIndexPath:indexPath];
        MTConnectionModel *model = dataArr[indexPath.row];
        cell.selectBlock=^(NSInteger index){
            [weakSelf pushToConnect:indexPath];
        };
        
        [cell setCollectionViewConnectionData:model];
        
        return cell;
    }
}
//点击企业
-(void)pushToCompany:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        EPCloudListModel *model=_dataSource[indexPath.row];
        [network getCompanyHomePage:[NSString stringWithFormat:@"%ld",model.company_id]success:^(NSDictionary *obj) {
            EPCloudListModel *model = obj[@"content"];
            
            EPCloudDetailViewController *detailVC =[[EPCloudDetailViewController alloc]init];
            detailVC.model = model;
            
            [self.inviteParentController pushViewController:detailVC];
            
        } failure:^(NSDictionary *obj2) {
            
        }];
        
    }else if(indexPath.section==1){
        
        EPCloudListModel *model=dataArr[indexPath.row];
        [network getCompanyHomePage:[NSString stringWithFormat:@"%ld",model.company_id]success:^(NSDictionary *obj) {
            EPCloudListModel *model = obj[@"content"];
            
            EPCloudDetailViewController *detailVC =[[EPCloudDetailViewController alloc]init];
            detailVC.model = model;
            [self.inviteParentController pushViewController:detailVC];
            
        } failure:^(NSDictionary *obj2) {
            
        }];
    }
}

//点击人脉
-(void)pushToConnect:(NSIndexPath *)indexPath{
    MTConnectionModel *model=dataArr[indexPath.row];
    [self addWaitingView];
    [network selectUseerInfoForId:[model.user_id intValue]
                          success:^(NSDictionary *obj) {
                              
                              MTNearUserModel *mod=[[MTNearUserModel alloc]initWithDictionary:obj[@"content"] error:nil];
                              UserChildrenInfo *usermodel=[[UserChildrenInfo alloc]initWithModel:mod];
                              [network selectUserCloudInfoById:[USERMODEL.userID intValue]follow_id:[model.user_id intValue]success:^(NSDictionary *obj) {
                                  [self removeWaitingView];
                                  MTOtherInfomationMainViewController *controller=[[MTOtherInfomationMainViewController alloc]initWithUserID:model.user_id :NO dic:obj[@"content"]];
                                  controller.userMod=usermodel;
                                  controller.dic=obj[@"content"];
                                  [self.inviteParentController pushViewController:controller];
                              } failure:^(NSDictionary *obj2) {
                                  
                              }];
                          } failure:^(NSDictionary *obj2) {
                              
                          }];
}

//添加视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    __weak ECloudHomePageChildrenViewController *weakSelf=self;
    
    if ([kind isEqualToString:kHead]) //段头
    {
        //2.就从段头的复用对列找可以复用的段头
        CollectionHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kHead withReuseIdentifier:@"header" forIndexPath:indexPath];
        
        if (self.type==ENT_company) {
            if (indexPath.section==0) {
                [header setDataWith:@"EP_tuijian.png" title:@"战略合作企业"];
                header.selectBtnBlock=^(NSInteger index){
                    [weakSelf pushToCompanyList:1];
                };
            }else{
                [header setDataWith:@"EP_hot.png" title:@"入驻企业"];
                header.selectBtnBlock=^(NSInteger index){
                    [weakSelf pushToCompanyList:2];
                };
            }
        }else{
            [header setDataWith:@"EP_partner.png" title:@"推荐用户"];
            header.selectBtnBlock=^(NSInteger index){
                [weakSelf pushToConnection];
            };
        }
        return header;
    }else{
        return nil;
    }
}

//查看更多
-(void)pushToCompanyList:(NSInteger)company_label_id{
    EPCloudListViewController *vc=[[EPCloudListViewController alloc]init];
    vc.company_label_id=company_label_id;
    [self.inviteParentController pushViewController:vc];
}


-(void)pushToConnection{
    EPCloudConnectionViewController *vc=[[EPCloudConnectionViewController alloc]init];
    
    [self.inviteParentController pushViewController:vc];
}

//底部按钮点击 加入园林云及更多
-(void)cliker:(UIButton *)sender{
    if (self.type==ENT_Connections) {
        if (sender.tag==1001) {
            EPCloudConnectionViewController *vc=[[EPCloudConnectionViewController alloc]init];
            
            [self.inviteParentController pushViewController:vc];
            
        }else{
            if (!USERMODEL.isLogin) {
                [self prsentToLoginViewController];
                return ;
            }
            JionEPCloudViewController *vc=[[JionEPCloudViewController alloc]init];
            [self.inviteParentController pushViewController:vc];
        }
    }else{
        if (sender.tag==1001) {
            EPCloudListViewController *vc=[[EPCloudListViewController alloc]init];
            [self.inviteParentController pushViewController:vc];
        }else{
            
        }
    }
}

-(void)pushToEp{
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    JionEPCloudViewController *vc=[[JionEPCloudViewController alloc]init];
    [self.inviteParentController pushViewController:vc];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat y=scrollView.contentOffset.y;
    
    if (y<=0) {
        [UIView animateWithDuration:0.5f animations:^{
            self->_createBtn.alpha=1;
        } completion:^(BOOL finished) {
        }];
    }else{
        [UIView animateWithDuration:0.5f animations:^{
            self->_createBtn.alpha=0;
        } completion:^(BOOL finished) {
        }];
    }
    if (y>_boundHeihgt) {
        [UIView animateWithDuration:0.5f animations:^{
            self->backTopbutton.alpha=1;
            [self.view bringSubviewToFront:self->backTopbutton];
        } completion:^(BOOL finished) {
        }];
    }else{
        [UIView animateWithDuration:0.5f animations:^{
            self->backTopbutton.alpha=0;
            
            // [self.view bringSubviewToFront:backTopbutton];
        } completion:^(BOOL finished) {
        }];
    }
}

- (void)scrollViewDidEndDecelerating:(MTBaseTableView *)scrollView
{
    [UIView animateWithDuration:0.5 animations:^{
        self->_createBtn.alpha=1;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
