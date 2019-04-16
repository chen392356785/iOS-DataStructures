//
//  ECloudMiaomuyunMainViewController.m
//  MiaoTuProject
//
//  Created by 徐斌 on 2016/11/8.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "ECloudMiaomuyunMainViewController.h"
#import "NurseryCloudViewController.h"
#import "NewECloudSearchViewController.h"
//#import "MyNerseryViewController.h"
#import "CategorySelectedViewController.h"
#import "NerseryMoreViewController.h"
#define ItemWidth   WindowWith*0.72/3
#define Scale  WindowWith/375.0
@interface ECloudMiaomuyunMainViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate>
{
    UICollectionView *_collectionView;
    NSMutableArray *dataArray;
    NSMutableArray *dataSource;
    NSMutableArray *listArray;
    NSMutableArray *parentIdArr;
    int parent_id;
    UIButton *_createBtn;
    MTBaseTableView *commTableView;
    int page;
//    NSMutableArray *nurseryNameArr;
    NSString *parent_nursery_name;
    NSInteger i;
    NSMutableDictionary *dataSourceDic;
}
@end

@implementation ECloudMiaomuyunMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArray = [[NSMutableArray alloc]init];
    dataSource = [[NSMutableArray alloc]init];
    listArray = [NSMutableArray new];
    parentIdArr = [[NSMutableArray alloc]init];
    page=0;
//    nurseryNameArr=[[NSMutableArray alloc]init];
    dataSourceDic=[[NSMutableDictionary alloc]init];
    //[self setbackTopFrame:WindowHeight-100];
    UIView *searchView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 40)];
    searchView.backgroundColor=RGB(247, 248, 250);
    [self.view addSubview:searchView];
    
    searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame=CGRectMake(20, 5, WindowWith-40, 30);
    searchBtn.backgroundColor=[UIColor whiteColor];
    [searchBtn setImage:Image(@"EP_search.png") forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchClick:) forControlEvents:UIControlEventTouchUpInside];
    [searchView addSubview:searchBtn];
    
//    __weak ECloudMiaomuyunMainViewController *weakSelf=self;
	
    //    commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, searchView.bottom , WindowWith*0.28, WindowHeight-searchView.bottom) tableviewStyle:UITableViewStylePlain];
    //    //dataArray=[[NSMutableArray alloc]init];
    //    commTableView.table.showsVerticalScrollIndicator=NO;
    //    commTableView.attribute=self;
    //
    //    commTableView.table.delegate=self;
    //    [commTableView setupData:listArray index:58];
    //    commTableView.backgroundColor = RGB(243, 243, 243);
    //
    //    [self.view addSubview:commTableView];
    
    //    [self addPushViewWaitingView];
    [network GetMiaoMuYunListSuccess:^(NSDictionary *obj) {
        
        [self->dataArray addObjectsFromArray:obj[@"content"]];
        NSDictionary *dic=self->dataArray[0];
        [self->dataSource addObjectsFromArray:dic[@"list"]];
        //
        //        NSMutableArray *arr=[[NSMutableArray alloc]init];
        //        for (NSDictionary *dic in dataArray) {
        //            [listArray addObject:dic[@"parent_nursery_name"]];
        //            [parentIdArr addObject:dic[@"parent_id"]];
        //        }
        //        [commTableView.table reloadData];
        //        parent_id=[parentIdArr[0] intValue];
        //        parent_nursery_name=listArray[0];
        //         [commTableView.table selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.itemSize = CGSizeMake(ItemWidth-0.5,ItemWidth-0.5);//每个cell的高度为图片缩放后的高度加上其他高度
        layout.sectionInset = UIEdgeInsetsMake(0.1, 0.1,0.1,0.1);
        layout.minimumInteritemSpacing = 0.5f;
        layout.minimumLineSpacing=0.5f;
        [layout setHeaderReferenceSize:CGSizeMake(WindowWith,41)];
        self->_collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, searchView.bottom  , WindowWith,WindowHeight-searchView.bottom) collectionViewLayout:layout];
        self->_collectionView.dataSource = self;
        self->_collectionView.delegate = self;
        self->_collectionView.backgroundColor =[UIColor whiteColor];
        self->_collectionView.userInteractionEnabled=YES;
        [self->_collectionView registerClass:[ECloudMiaoMuYunCollectionView class] forCellWithReuseIdentifier: @"ECloudMiaoMuYunCollectionView"];
        
        [self->_collectionView registerClass:[CloudMiaoMuYunHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CloudMiaoMuYunHeaderView"];
        [self.view addSubview:self->_collectionView];
        
        [self->_collectionView reloadData];
        
        //        [self CreateCollectionViewRefesh:_collectionView type:ENT_RefreshFooter successRefesh:^(MJRefreshComponent *refreshView) {
        //            [weakSelf loadRefesh:refreshView];
        //        }];
        //        [self begincollectionViewRefesh:ENT_RefreshFooter];
        UIButton* createBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
//        createBtn.frame=CGRectMake(WindowWith/2-128/2, WindowHeight-80, 128, 38) ;
        createBtn.frame=CGRectMake(WindowWith-kWidth(70), WindowHeight-80, kWidth(54), kWidth(54)) ;
        
        [createBtn setTitle:@"发布\n苗木云" forState:UIControlStateNormal];
        createBtn.titleLabel.numberOfLines = 0;
        createBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [createBtn addTarget:self action:@selector(cliker:) forControlEvents:UIControlEventTouchUpInside];
        self->_createBtn=createBtn;
        [createBtn setLayerMasksCornerRadius:createBtn.height/2. BorderWidth:0.1 borderColor:cGreenColor];
//        [createBtn setLayerMasksCornerRadius:20 BorderWidth:0.1 borderColor:cGreenColor];
        [createBtn setBackgroundColor:cGreenColor];
        createBtn.titleLabel.font=sysFont(14);
        [createBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:createBtn];
        
        //[self removePushViewWaitingView];
    } failure:^(NSDictionary *obj2) {
        
    }];
    //
    // Do any additional setup after loading the view.
}

-(void)loadRefesh:(MJRefreshComponent *)refreshView{
    
//    NSDictionary *dic=dataSourceDic[parent_nursery_name];
    //
    //    if (dic&&page<=[dic[@"page"] intValue]&&i==0) {
    //        [self endcollectionViewRefresh];
    //       [dataSource removeAllObjects];
    //        [dataSource addObjectsFromArray:dic[@"arr"]];
    //        page=[dic[@"page"] intValue];
    //
    //        [_collectionView reloadData];
    //
    //            i=1;
    //
    //        if ([dic[@"isEnd"] isEqualToString:@"Yes"]) {
    //            [_collectionView.mj_footer endRefreshingWithNoMoreData];
    //        }
    //
    //    }else{
    i=1;
    
    [network selectNurseryTypeByParentid:parent_id
                                    page:page
                                     num:pageNum success:^(NSDictionary *obj) {
                                         
                                         NSArray *Arr=obj[@"content"];
                                         
                                         if (self->page==0) {
                                             [self->dataSource removeAllObjects];
                                             
                                         }
                                         //  NSString *isEnd=@"NO";
                                         
                                         if (Arr.count>0) {
                                             self->page++;
                                             if (Arr.count<pageNum) {
                                                 //     isEnd=@"Yes";
                                                 [self->_collectionView.mj_footer endRefreshingWithNoMoreData];
                                             }
                                         }else{
                                             
                                             //    isEnd=@"Yes";
                                             [self->_collectionView.mj_footer endRefreshingWithNoMoreData];
                                             [self endcollectionViewRefresh];
                                             
                                             return ;
                                         }
                                         
                                         [self->dataSource addObjectsFromArray:Arr];
                                         //                                             NSArray *arr=[[NSArray alloc]initWithArray:dataSource];
                                         //                                             NSDictionary *Dic=[NSDictionary dictionaryWithObjectsAndKeys:stringFormatInt(page),@"page",
                                         //                                                                arr,@"arr",
                                         //                                                                isEnd,@"isEnd",
                                         //                                                                nil];
                                         //                                             [dataSourceDic setObject:Dic forKey:parent_nursery_name];
                                         // [IHUtility saveDicUserDefaluts:dic key:parent_nursery_name];
                                         
                                         
                                         [self->_collectionView reloadData];
                                         [self endcollectionViewRefresh];
                                         
                                         [self removePushViewWaitingView];
                                         
                                     } failure:^(NSDictionary *obj2) {
                                         
                                     }];
    // }
}

-(void)searchClick:(UIButton *)sender{
    NewECloudSearchViewController *vc=[[NewECloudSearchViewController alloc]init];
    vc.type=ENT_nursery;
    [self.inviteParentController pushViewController:vc];
}

-(void)backTopClick:(UIButton *)sender{
    [self scrollTopPoint:_collectionView];
}

-(void)cliker:(UIButton *)sender{
    
    if (!USERMODEL.isLogin) {
        [self prsentToLoginViewController];
        return ;
    }
    
    CategorySelectedViewController *vc=[[CategorySelectedViewController alloc]init];
    [self.inviteParentController pushViewController:vc];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (WindowHeight-40)/6;
}

-(void)BCtableViewCell:(IHTableViewCell *)cell action:(BCTableViewCellAction)action indexPath:(NSIndexPath *)indexPath attribute:(NSObject *)attribute{//cell分支点击
    
    if (action==MYActionMiaoMuYunSelectCell) {
        
        [commTableView.table selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        
        i=0;
        page=0;
        parent_id=[parentIdArr[indexPath.row] intValue];
        parent_nursery_name=listArray[indexPath.row];
        
        NSDictionary *dic=dataSourceDic[parent_nursery_name];
        if (dic/*&&page<=[dic[@"page"] intValue]&&i==0*/) {
            // [self endcollectionViewRefresh];
            [dataSource removeAllObjects];
            [dataSource addObjectsFromArray:dic[@"arr"]];
            page=[dic[@"page"] intValue];
            
            [_collectionView reloadData];
            
            i=1;
            
            if ([dic[@"isEnd"] isEqualToString:@"Yes"]) {
                [_collectionView.mj_footer endRefreshingWithNoMoreData];
            }else {
                [_collectionView.mj_footer resetNoMoreData];
            }
        }else{
            [self begincollectionViewRefesh:ENT_RefreshFooter];
        }
        //[self loadRefesh:ENT_RefreshFooter];
    }
}
#pragma mark - collection数据源代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *arr=dataArray[section][@"list"];
    if (arr.count>8) {
        return 8;
    }
    return arr.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return dataArray.count;
}

-(void)itemClick:(IHTapGesureRecornizer *)tap{
    
    NSDictionary *dic=(NSDictionary*)tap.objectValue;
    NSLog(@"dic=%@",dic);
    
    NurseryCloudViewController *vc=[[NurseryCloudViewController alloc]init];
    vc.nursery_type_id=dic[@"nursery_type_id"];
    vc.nursery_type_name=dic[@"nursery_type_name"];
    [self.inviteParentController pushViewController:vc];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ECloudMiaoMuYunCollectionView * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ECloudMiaoMuYunCollectionView" forIndexPath:indexPath];
    
    NSDictionary *detailDic=[dataArray objectAtIndex:indexPath.section][@"list"][indexPath.row];
    
    [cell.imgView setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,detailDic[@"nursery_image"]] placeholderImage:Image(@"cs_xz.png")];
    cell.titleLab.text =[detailDic objectForKey:@"nursery_type_name"];
    
    IHTapGesureRecornizer *tap=[[IHTapGesureRecornizer alloc]initWithTarget:self action:@selector(itemClick:)];
    tap.objectValue=detailDic;
    [cell.contentView addGestureRecognizer:tap];
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView =nil;
    __weak ECloudMiaomuyunMainViewController *weakSelf=self;
    if (kind ==UICollectionElementKindSectionHeader) {
        //定制头部视图的内容
        
        CloudMiaoMuYunHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CloudMiaoMuYunHeaderView" forIndexPath:indexPath];
        NSDictionary *dic=[dataArray objectAtIndex:indexPath.section];
        headerView.tag=indexPath.section;
        NSMutableArray *listArr=[[NSMutableArray alloc]initWithArray:dic[@"list"]];
        if (listArr.count>=8) {
            headerView.btn.hidden=NO;
            headerView.imageView.hidden=NO;
        }else{
            headerView.btn.hidden=YES;
            headerView.imageView.hidden=YES;
        }
        headerView.selectBlock=^(NSInteger index){
            NSDictionary *dic=[self->dataArray objectAtIndex:index];
            [weakSelf pushToMoreNerseryVC:dic];
            
        };
        [headerView.imgView setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,dic[@"parent_nursery_image"]] placeholderImage:Image(@"ep_header.png")];
        headerView.titleLab.text =[dic objectForKey:@"parent_nursery_name"];
        reusableView = headerView;
    }
    
    return reusableView;
}

-(void)pushToMoreNerseryVC:(NSDictionary *)dic{
    NerseryMoreViewController *vc=[[NerseryMoreViewController alloc]init];
    vc.dic=dic;
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    NerseryLeftTableViewCell *cell=[commTableView.table cellForRowAtIndexPath:indexPath];
    //    cell.selected=YES;
    
    [commTableView.table selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    parent_id=[parentIdArr[indexPath.row] intValue];
    i=0;
    page=0;
    [self begincollectionViewRefesh:ENT_RefreshFooter];
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
