//
//  CarOwnerChildrenViewController.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 17/1/5.
//  Copyright © 2017年 xubin. All rights reserved.
//

#import "CarOwnerChildrenViewController.h"

@interface CarOwnerChildrenViewController ()<UITableViewDelegate>
{
    MTBaseTableView *commTableView;
    int page;
    NSMutableArray *dataArray;
     EmptyPromptView *_EPView;
}

@end

@implementation CarOwnerChildrenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dataArray=[[NSMutableArray alloc]init];
    __weak CarOwnerChildrenViewController *weakSelf=self;
    if (self.type==ENT_cheyuan) {
        self.view.backgroundColor=cBgColor;
        
        commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight-70-42) tableviewStyle:UITableViewStylePlain];
        //commTableView.table.tableHeaderView=logisticsView;
        commTableView.table.delegate=self;
        commTableView.table.showsVerticalScrollIndicator=NO;
        
        commTableView.attribute=self;
        [commTableView setupData:dataArray index:62];
        [self CreateBaseRefesh:commTableView type:ENT_RefreshAll successRefesh:^(MJRefreshComponent *refreshView) {
            [weakSelf loadRefesh:refreshView];
        }];
        EmptyPromptView *EPView  = [[EmptyPromptView alloc] initWithFrame:commTableView.table.frame context:@"他还没有发布车源～"];
        EPView.hidden = YES;
        _EPView = EPView;
        [commTableView.table addSubview:EPView];
        [self beginRefesh:ENT_RefreshHeader];
        [self.view addSubview:commTableView];
 
    } else if (self.type == ENT_renzheng){
        
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, 123)];
        view.backgroundColor=cBgColor;
        
        UIImage *img=Image(@"driver_renzhengwancheng.png");
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 28, img.size.width, img.size.height)];
        imageView.image=img;
        imageView.centerX=view.centerX;
        [view addSubview:imageView];
        SMLabel *lbl=[[SMLabel alloc]initWithFrameWith:CGRectMake(0, imageView.bottom+8, 70, 14) textColor:cGrayLightColor textFont:sysFont(12)];
        lbl.centerX=imageView.centerX;
        lbl.textAlignment=NSTextAlignmentCenter;
        lbl.text=@"认证已完成";
        [view addSubview:lbl];
        
        commTableView=[[MTBaseTableView alloc]initWithFrame:CGRectMake(0, 0, WindowWith, WindowHeight-70-42) tableviewStyle:UITableViewStylePlain];
        commTableView.table.tableHeaderView=view;
        commTableView.table.delegate=self;
        commTableView.table.showsVerticalScrollIndicator=NO;
        
        commTableView.attribute=self;
        //dataArray=[NSMutableArray arrayWithArray:[ConfigManager getDirverInforamationList]];
        NSArray *arr=[ConfigManager getDirverInforamationList];
        for (NSInteger i=0;i<arr.count;i++) {
            NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithDictionary:arr[i]];
            if ([dic[@"text"] isEqualToString:@"姓名"]) {
                [dic setObject:_dic[@"user_name"] forKey:@"name"];
            }
            if ([dic[@"text"] isEqualToString:@"车辆类型"]) {
                [dic setObject:[NSString stringWithFormat:@"%@ %@米",_dic[@"carType_name"],_dic[@"car_height"]] forKey:@"name"];
            }
            if ([dic[@"text"] isEqualToString:@"车牌号码"]) {
                [dic setObject:_dic[@"car_num"] forKey:@"name"];
            }
            if ([dic[@"text"] isEqualToString:@"载重"]) {
                [dic setObject:[NSString stringWithFormat:@"%@吨",_dic[@"loads"]] forKey:@"name"];
            }
            if ([dic[@"text"] isEqualToString:@"驾驶证号"]) {
                [dic setObject:_dic[@"driving_user_num"] forKey:@"name"];
            }
            if ([dic[@"text"] isEqualToString:@"联系电话"]) {
                [dic setObject:_dic[@"mobile"] forKey:@"name"];
            }
            [dataArray addObject:dic];
        }
        
        
        [commTableView setupData:dataArray index:63];
        [self.view addSubview:commTableView];

        
        
        
    }
    
    
    
}


-(void)loadRefesh:(MJRefreshComponent *)refreshView{
    if (refreshView==commTableView.table.mj_header) {
        page=0;
    }
    
    
    [network selectFlowCarRouteList:[_dic[@"user_id"] intValue]
                             mobile:@""
                             page:page
                              num:pageNum
                          success:^(NSDictionary *obj) {
                              NSArray *arr=obj[@"content"];
                              if (refreshView==self->commTableView.table.mj_header) {
                                  
                                  [self->dataArray removeAllObjects];
                                  self->page=0;
                                  if (arr.count==0) {
                                      [self->dataArray addObjectsFromArray:arr];
                                      [self->commTableView.table reloadData];
                                  }
                                  [self->commTableView.table.mj_footer resetNoMoreData];
                              }
                              
                              if (arr.count>0) {
                                  self->page++;
                                  if (arr.count<pageNum) {
                                      [self->commTableView.table.mj_footer endRefreshingWithNoMoreData];
                                  }
                              }else{
                                  [self->commTableView.table.mj_footer endRefreshingWithNoMoreData];
                                  [self endRefresh];
                                  if (self->dataArray.count == 0) {
                                      self->_EPView.hidden = NO;
                                  }else{
                                      self->_EPView.hidden = YES;
                                  }

                                  return;
                              }
                              
                              [self->dataArray addObjectsFromArray:arr];
                              
                              [self->commTableView.table reloadData];
                              [self endRefresh];
                              
                              if (self->dataArray.count == 0) {
                                  self->_EPView.hidden = NO;
                              }else{
                                  self->_EPView.hidden = YES;
                              }

                          } failure:^(NSDictionary *obj2) {
                              [self endRefresh];
                          }];
    
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (self.type==ENT_cheyuan) {
        CheYuanModel *model=dataArray[indexPath.row];
        if ([model.remark isEqualToString:@""]) {
             return 118-43;
        }else{
            CGSize   size=[IHUtility GetSizeByText:model.remark sizeOfFont:12 width:WindowWith-24];
             return 118-33+size.height;
        }
       return 118;
    }else if (self.type==ENT_renzheng){
       return 49;
    }

    
    return 0;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
