//
//  NerseryMoreViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/12/29.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "NerseryMoreViewController.h"
#import "NurseryCloudViewController.h"
//#import "NewECloudSearchViewController.h"
//#import "MyNerseryViewController.h"
//#import "CategorySelectedViewController.h"
#define ItemWidth   WindowWith*0.72/3
#define Scale  WindowWith/375.0
@interface NerseryMoreViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UICollectionView *_collectionView;
    NSMutableArray *dataArray;
     int page;
}
@end

@implementation NerseryMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:self.dic[@"parent_nursery_name"]];
     dataArray=[[NSMutableArray alloc]init];
    page=0;
    //dataArray=self.dic[@"list"];
    __weak NerseryMoreViewController *weakSelf=self;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.itemSize = CGSizeMake(ItemWidth-0.5,ItemWidth-0.5);//每个cell的高度为图片缩放后的高度加上其他高度
    layout.sectionInset = UIEdgeInsetsMake(0.1, 0.1,0.1,0.1);
    layout.minimumInteritemSpacing = 0.5f;
    layout.minimumLineSpacing=0.5f;
   //[layout setHeaderReferenceSize:CGSizeMake(WindowWith,41)];
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0  , WindowWith,WindowHeight) collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor =[UIColor whiteColor];
    _collectionView.userInteractionEnabled=YES;
    [_collectionView registerClass:[ECloudMiaoMuYunCollectionView class] forCellWithReuseIdentifier: @"ECloudMiaoMuYunCollectionView"];
    
    [self.view addSubview:_collectionView];
    
    [self CreateCollectionViewRefesh:_collectionView type:ENT_RefreshFooter successRefesh:^(MJRefreshComponent *refreshView) {
        [weakSelf loadRefesh:refreshView];
    }];
    [self begincollectionViewRefesh:ENT_RefreshFooter];

   // [_collectionView reloadData];
}

-(void)loadRefesh:(MJRefreshComponent *)refreshView{
    
    [network selectNurseryTypeByParentid:[self.dic[@"parent_id"] intValue]
                                    page:page
                                     num:pageNum success:^(NSDictionary *obj) {
                                         
                                         NSArray *Arr=obj[@"content"];
                                         
                                         if (self->page==0) {
                                             [self->dataArray removeAllObjects];
                                         }
                                         
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
                                         
                                         [self->dataArray addObjectsFromArray:Arr];
                                         
                                         
                                         [self->_collectionView reloadData];
                                         [self endcollectionViewRefresh];
                                         
                                         [self removePushViewWaitingView];
                                         
                                     } failure:^(NSDictionary *obj2) {
                                         
                                     }];
}

-(void)backTopClick:(UIButton *)sender{
    [self scrollTopPoint:_collectionView];
}

-(void)itemClick:(IHTapGesureRecornizer *)tap{
    
    
    NSDictionary *dic=(NSDictionary*)tap.objectValue;
    NSLog(@"dic=%@",dic);
    
    NurseryCloudViewController *vc=[[NurseryCloudViewController alloc]init];
    vc.nursery_type_id=dic[@"nursery_type_id"];
    vc.nursery_type_name=dic[@"nursery_type_name"];
    [self pushViewController:vc];
}

#pragma mark - collection数据源代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ECloudMiaoMuYunCollectionView * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ECloudMiaoMuYunCollectionView" forIndexPath:indexPath];
    
    NSDictionary *detailDic=[dataArray objectAtIndex:indexPath.row];
    
    [cell.imgView setImageAsyncWithURL:[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,detailDic[@"nursery_image"]] placeholderImage:Image(@"cs_xz.png")];
    cell.titleLab.text =[detailDic objectForKey:@"nursery_type_name"];
    
    IHTapGesureRecornizer *tap=[[IHTapGesureRecornizer alloc]initWithTarget:self action:@selector(itemClick:)];
    tap.objectValue=detailDic;
    [cell.contentView addGestureRecognizer:tap];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
