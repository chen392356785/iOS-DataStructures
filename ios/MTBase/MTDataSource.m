//
//  MTDataSource.m
//  MiaoTuProject
//
//  Created by Mac on 16/3/10.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTDataSource.h"
#import "CustomScrollCell.h"
@implementation MTDataSource

@end

@implementation MapUserListDataSource


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *identify=@"MapUserListTableViewCell";
    MapUserListTableViewCell* cell=(MapUserListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify  ];
    
    if (cell==nil) {
        cell=[[MapUserListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (self.datasource.count==0) {
        return cell;
    }
    cell.indexPath=indexPath;
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame] ;
    cell.selectedBackgroundView.backgroundColor =RGB(221, 243, 238);
    MTNearUserModel *model=self.datasource[indexPath.row];
    cell.model=model;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    [cell setData:indexPath];
    return cell;
  
}



@end

@implementation GongQiuListDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *identify=@"GongQiuListTableViewCell";
    GongQiuListTableViewCell* cell=(GongQiuListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[GongQiuListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify type:self.type isCollection:NO isMe:NO];
    }
    if (self.datasource.count==0) {
        return cell;
    }
    MTSupplyAndBuyListModel *model=[self.datasource objectAtIndex:indexPath.row];
    cell.model=model;
    
    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    [cell setData:self.type isHomePage:NO];
    return cell;
    
}


@end
 


@implementation GongQiuDetailsListDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *identify=@"GongQiuDetailsListTableViewCell";
    GongQiuDetailsListTableViewCell* cell=(GongQiuDetailsListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[GongQiuDetailsListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    } 
    if (self.datasource.count==0) {
        return cell;
    }
    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    
    CommentListModel *mod=[self.datasource objectAtIndex:indexPath.row];
    cell.model=mod;
    [cell setData];
    
    return cell;
    
}


@end

@implementation GuangChangTopicDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *identify=@"GongQiuDetailsListTableViewCell";
    GuangChangTopicTableViewCell* cell=(GuangChangTopicTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[GuangChangTopicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify type:self.type isMe:NO];
    }
    if (self.datasource.count==0) {
        return cell;
    }
    MTTopicListModel *model=[self.datasource objectAtIndex:indexPath.row];
    
    cell.model=model;
    
    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    [cell setData:self.type isMe:NO];
   // [cell setData:self.type isMe:NO];
    return cell;
    
}


@end

@implementation MTContactDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
     NSString *identify=[NSString stringWithFormat:@"MTContactTableViewCell"];
    MTContactTableViewCell* cell=(MTContactTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[MTContactTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify type:self.type];
    }
    if (self.datasource.count==0) {
        return cell;
    }
    MTNearUserModel *model=self.datasource[indexPath.row];
    cell.model=model;
    [cell setDataWithType:self.type];
    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    
    return cell;
    
}



@end


#pragma mark 评论我的列表
@implementation CommentForMeListDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify=@"CommentForMeListTableViewCell";
    CommentForMeListTableViewCell* cell=(CommentForMeListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[CommentForMeListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (self.datasource.count==0) {
        return cell;
    }
    
    MTCommentMeModel *mod=[self.datasource objectAtIndex:indexPath.row];
    cell.model=mod;
    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    [cell setData];
    return cell;
    
}

@end

#pragma mark 地图搜索列表
@implementation MapSearchListDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify=@"MapSearchListTableViewCell";
    MapSearchListTableViewCell* cell=(MapSearchListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[MapSearchListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (self.datasource.count==0) {
        return cell;
    }
    
    UserChildrenInfo  *model=self.datasource[indexPath.row];
    
    [cell setData:model];
    
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
   

    return cell;
    
}
@end


#pragma mark 看过我的人
@implementation FindOutListDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify=@"FindOutListTableViewCell";
    FindOutListTableViewCell* cell=(FindOutListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[FindOutListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (self.datasource.count==0) {
        return cell;
    }
    UserChildrenInfo *model=self.datasource[indexPath.row];
    cell.model=model;
    [cell setData:model];
    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    
    return cell;
    
}


@end

#pragma mark 省份
@implementation ProvinceListDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify=@"ProvinceListTableViewCell";
    ProvinceListTableViewCell* cell=(ProvinceListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[ProvinceListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (self.datasource.count==0) {
        return cell;
    }
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    ProvinceModel *model=self.datasource[indexPath.row];
    [cell fillCellWithModel:model];
    cell.indexPath=indexPath;

    
    return cell;
    
}


@end

#pragma mark 城市
@implementation CityListDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify=@"CityListTableViewCell";
    CityListTableViewCell* cell=(CityListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[CityListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (self.datasource.count==0) {
        return cell;
    }
    
    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    SectionModel *model=self.datasource[indexPath.section];
    [cell fillCellWithModel:model :indexPath];
    
    return cell;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section/*当前是第几段*/
{
    
    SectionModel *model = self.datasource[section];
    
    return model.rows.count;
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.datasource.count;
}


-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *indexes=[[NSMutableArray alloc]init];
    for(SectionModel *model in self.datasource)
    {
        NSString *s=model.headerTitle;
        
        [indexes addObject:s];
    }
    return indexes;
}


@end

@implementation MTMyCollectionSupplyAndBuyDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *identify=@"GongQiuListTableViewCell";
    GongQiuListTableViewCell* cell=(GongQiuListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[GongQiuListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify type:self.type isCollection:YES  isMe:NO];
    }
    if (self.datasource.count==0) {
        return cell;
    }
    MyCollectionSupplyAndBuyModel *model=[self.datasource objectAtIndex:indexPath.row];
    cell.collmodel=model;
    cell.type2=self.type;
    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    [cell setCollectionData:self.type];
    return cell;
    
    
}

@end

@implementation MTMyCollectionTopicDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify=@"GongQiuDetailsListTableViewCell";
    GuangChangTopicTableViewCell* cell=(GuangChangTopicTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[GuangChangTopicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify type:self.type isMe:NO];
    }
    if (self.datasource.count==0) {
        return cell;
    }
    MyCollectionTopicModel *model=[self.datasource objectAtIndex:indexPath.row];
    
    cell.colmod=model;
    
    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    [cell setCollectionData:self.type];
    return cell;
    
    
}

@end

@implementation MTOtherChildSupplyBuyDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MTSupplyAndBuyListModel *model=[self.datasource objectAtIndex:indexPath.row];
    static NSString *identify=@"GongQiuListTableViewCell";
    GongQiuListTableViewCell* cell=(GongQiuListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    BOOL isMe=NO;
    if ([model.userChildrenInfo.user_id isEqualToString:USERMODEL.userID]) {
        isMe=YES;
    }
    CollecgtionType type2;
    if (self.type==ENT_gongying) {
        type2=ENT_PerSonGongYing;
    }else if (self.type==ENT_qiugou){
        type2=ENT_PerSonQiuGou;
    }
    
    if (cell==nil) {
        cell=[[GongQiuListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify type:type2 isCollection:NO  isMe:isMe];
    }
    if (self.datasource.count==0) {
        return cell;
    }

    cell.model=model;
    cell.type2=self.type;
    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    [cell setData:self.type isHomePage:YES];
    return cell;

}


@end

@implementation MTOtherChildTopicListDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify=@"GongQiuDetailsListTableViewCell";
    GuangChangTopicTableViewCell* cell=(GuangChangTopicTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    MTTopicListModel *model=[self.datasource objectAtIndex:indexPath.row];
    BOOL isMe=NO;
    if ([model.userChildrenInfo.user_id isEqualToString:USERMODEL.userID]) {
        isMe=YES;
    }
    
    if (cell==nil) {

        cell=[[GuangChangTopicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify type:ENT_Preson isMe:self.isMe];
    }
    if (self.datasource.count==0) {
        return cell;
    }
  
    
    cell.model=model;
    
    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;

    [cell setData:ENT_Preson isMe:self.isMe];

    return cell;
    
    
}


@end

@implementation MTMeListDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"MTMeListTableViewCell";
    MTMeListTableViewCell* cell = (MTMeListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell = [[MTMeListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
	if (self.datasource.count==0) {
        return cell;
    }
   
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    [cell setDataWithDic:self.datasource[indexPath.row]];
    
    if (!self.ifMe) {
        
        
        if (indexPath.row==2) {
			CGFloat size = SDImageCache.sharedImageCache.totalDiskSize/(1024 * 1024);
            NSString *text = [NSString stringWithFormat:@"占用：%.2f MB",size];
            SMLabel *lbl=[cell viewWithTag:101];
            lbl.frame=CGRectMake(0.355*WindowWith, 23, 0.92*WindowWith-0.355*WindowWith-10 ,14);
            lbl.textAlignment=NSTextAlignmentRight;
            lbl.textColor=[UIColor redColor];
            lbl.text=text;
            lbl.hidden=NO;
            
        }

    }else{
        // NSDictionary *dic=[IHUtility getUserDefalutsDicKey:kUserDefalutInit];
//      NSDictionary *dic=[IHUtility getUserDefalutsDicKey:kUserDefalutLoginInfo];
        if (indexPath.row==0) {
            NSDictionary *dic=[IHUtility getUserDefalutDic:kUserDefalutLoginInfo];
            UIImage *typeImg=Image(@"store.png");
             UIImage *img=Image(@"GQ_Left.png");
            
            NSString *text =@"未标注";
                      SMLabel *lbl=[cell viewWithTag:101];
            lbl.frame=CGRectMake(15+typeImg.size.width+100, 25, WindowWith-(15+typeImg.size.width+100)-20-img.size.width-10,15);
            lbl.textAlignment=NSTextAlignmentRight;
            
            lbl.textColor=cGrayLightColor;
            if (![dic[@"address"] isEqualToString:@""]) {
                text=@"已标注";
                lbl.textColor=cGreenColor;
            }if (WindowWith==320) {
                lbl.font=sysFont(14);
                 lbl.height=14;
            }

            lbl.text=text;
            lbl.hidden=NO;

        }
        
        
        
        if (indexPath.row==6) {
            
            
            //NSString *text = [NSString stringWithFormat:@"当前积分 %@",dic[@"experience_info"][@"residual_value"]];
            
//            SMLabel *lbl=[cell viewWithTag:101];
//            lbl.frame=CGRectMake(0.355*WindowWith, 23, 0.92*WindowWith-0.355*WindowWith-10 ,14);
//            lbl.textAlignment=NSTextAlignmentRight;
//            lbl.textColor=cGreenColor;
//            lbl.text=text;
            
//            lbl.hidden=NO;
//            if (dic[@"experience_info"][@"residual_value"] == nil) {
//                lbl.hidden=YES;
//            }
            
        }
        
    }
    
    
    
    return cell;
}


@end


#pragma mark 行业资讯
@implementation MTNewsDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsListModel * model=self.datasource[indexPath.row];
    NewsListTableViewCell *cell2=[[NewsListTableViewCell alloc]init];
    
    if (model.img_type==1) {
        static NSString *identify=@"NewsCell1";
        NewsCell1* cell=(NewsCell1 *)[tableView dequeueReusableCellWithIdentifier:identify];
        if (cell==nil) {
            cell=[[NewsCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleGray;
        [cell setData:model];
        
        if (self.datasource.count==0) {
            return cell;
        }
       
        return cell;
    }else if (model.img_type==2 || model.img_type==3)
    {
         NSString *identify=[NSString stringWithFormat:@"NewsCell2%ld",(long)indexPath.row];
        NewsCell2* cell=(NewsCell2 *)[tableView dequeueReusableCellWithIdentifier:identify];
        
        if (cell==nil) {
            cell=[[NewsCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleGray;
        [cell setData:model];
        
        if (self.datasource.count==0) {
            return cell;
        }
        
        return cell;
    }else if (model.img_type==0)
    {
        static NSString *identify=@"NewsCell3";
        NewsCell3* cell=(NewsCell3 *)[tableView dequeueReusableCellWithIdentifier:identify];
        
        if (cell==nil) {
            cell=[[NewsCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleGray;
        [cell setData:model];
        
        if (self.datasource.count==0) {
            return cell;
        }
        
        return cell;
    
   }else if (model.img_type==5){

    
    static NSString *identify=@"NewsCell4";
    NewsCell4* cell=(NewsCell4 *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[NewsCell4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleGray;
    [cell setData:model];
    
    if (self.datasource.count==0) {
        return cell;
    }
     
    return cell;

    
    
}
   else if (model.img_type==4)
    {
        static NSString *identify=@"NewsCell5";
        NewsCell5* cell=(NewsCell5 *)[tableView dequeueReusableCellWithIdentifier:identify];
        
        if (cell==nil) {
            cell=[[NewsCell5 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleGray;
        [cell setData:model];
        
        if (self.datasource.count==0) {
            return cell;
        }
        
        return cell;

    }
    
    
    
    return cell2;
}


@end

@implementation MTRecommentDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsListModel * model=self.datasource[indexPath.row];
    static NSString *identify=@"NewsCell1";
    NewsCell1* cell=(NewsCell1 *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[NewsCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleGray;
    [cell setData:model];
    
    if (self.datasource.count==0) {
        return cell;
    }
    
    return cell;

}

@end
@implementation MtActivityDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"ActivityTableViewCell";
    ActivityTableViewCell* cell=(ActivityTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[ActivityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (self.datasource.count==0 || self.datasource.count <= indexPath.row) {
        return cell;
    }
    ActivitiesListModel *model = self.datasource [indexPath.row];
    cell.mod=model;
    cell.ActvType = self.actvType;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    [cell setDataWithModel:model];
    cell.indexPath=indexPath;
    
    return cell;
}



@end



@implementation MTIdentDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSString *identify=[NSString stringWithFormat:@"MTIdentTableViewCell%ld",indexPath.row];
    MTIdentTableViewCell* cell=(MTIdentTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[MTIdentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (self.datasource.count==0) {
        return cell;
    }
    
    
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    [cell setDataWithDic:self.datasource[indexPath.row]];
    if (indexPath.row!=1) {
        [cell btnhide];
    }
    return cell;
}



@end


@implementation MTThemeListDataSource


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    CustomScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomScrollCell" forIndexPath:indexPath];
    [cell resetParallaxState];
    
    [cell parallaxWithView:cell.headerImageView offsetUp:50 offsetDown:50];
 
    [cell updateViewFrameWithScrollView:tableView];
     
    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    ThemeListModel *model = self.datasource [indexPath.row];
    cell.model=model;
    [cell setData];
    return cell;
}

@end


@implementation MTlogisticsFindCarDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify=@"LogisticsFindCarTableViewCell";
    LogisticsFindCarTableViewCell* cell=(LogisticsFindCarTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[LogisticsFindCarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (self.datasource.count==0) {
        return cell;
    }

    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
   
   
    return cell;
}



@end


@implementation MTlogisticsFindGoodsDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify=@"LogisticsFindGoodsTableViewCell";
    LogisticsFindGoodsTableViewCell* cell=(LogisticsFindGoodsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[LogisticsFindGoodsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (self.datasource.count==0) {
        return cell;
    }
    
    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    
    
    return cell;
}



@end

@implementation MTActivtiesClikeDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellid = @"ActivitiesClikeCell";
    
    ActivitiesClikeCell *cell = (ActivitiesClikeCell *)[tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (cell==nil) {
        cell=[[ActivitiesClikeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    
    UserChildrenInfo *model = self.datasource[indexPath.row];
    cell.indexPath = indexPath;
    
    [cell setUserInfo:model];
    return cell;
}

@end

@implementation MTNewTopicDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"MTNewTopicListTableViewCell";
    MTNewTopicListTableViewCell* cell=(MTNewTopicListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[MTNewTopicListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (self.datasource.count==0) {
        return cell;
    }
    ThemeListModel *model=self.datasource[indexPath.row];
    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    [cell setData:model];
    
    return cell;




}


@end




@implementation HomePageDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   
    
    if (indexPath.section==0) {
        NewsListModel *model=self.datasource[indexPath.section][indexPath.row];
       
        static NSString *identify=@"HomePageTableViewCell";
        HomePageTableViewCell* cell=(HomePageTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
        
        if (cell==nil) {
            cell=[[HomePageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        if (self.datasource.count==0) {
            return cell;
        }
         [cell setDataWithNewsModel:model];
        cell.indexPath=indexPath;
        cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame] ;
        cell.selectedBackgroundView.backgroundColor =RGBA(239, 239, 239,0.5);
        
        return cell;
        
    }else if(indexPath.section==1){
        static NSString *identify=@"HomePageHotTopicTableViewCell";
        HomePageHotTopicTableViewCell* cell=(HomePageHotTopicTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
        
        if (cell==nil) {
            cell=[[HomePageHotTopicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        if (self.datasource.count==0) {
            return cell;
        }
      
        cell.indexPath=indexPath;
        cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;

        HomePageTopicModel *model=self.datasource[indexPath.section][indexPath.row];
      
        [cell setDataWithIndepath:indexPath TopicModel:model];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame] ;
        cell.selectedBackgroundView.backgroundColor =RGB(239, 239, 239);
        
        return cell;
        
    }
    
    return nil;

    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section/*当前是第几段*/
{
    NSArray *arr=self.datasource[section];
  
    return arr.count;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  
    return self.datasource.count;
}





@end

@implementation EPCloudDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"EPCloudTableViewCell";
    
    EPCloudTableViewCell* cell=(EPCloudTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (cell==nil) {
        cell=[[EPCloudTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    if (self.datasource.count==0) {
        return cell;
    }
    EPCloudListModel *model=self.datasource[indexPath.row];
    [cell setlistModel:model];
    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    
    return cell;
    


    
}

@end


@implementation CompanyTrackDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"companyTrackCell";
    
    companyTrackCell* cell=(companyTrackCell *)[tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (cell==nil) {
        cell=[[companyTrackCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    if (self.datasource.count==0) {
        return cell;
    }
    
    CompanyTrackModel *model=self.datasource[indexPath.row];
    cell.indexPath=indexPath;
    [cell setTrackData:model];
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    
    return cell;
    
    
    
}

@end


@implementation EPCloudCumlativeDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"EPCloudCumlativeTableViewCell";
    EPCloudCumlativeTableViewCell* cell=(EPCloudCumlativeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[EPCloudCumlativeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (self.datasource.count==0) {
        return cell;
    }
   NSArray *arr=[ConfigManager getEPCloudCumlativeList];
    NSDictionary *dic=arr[indexPath.row];
    
    [cell setDataWithArr:dic];
    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    
    
    return cell;
    
    
}

@end

@class companyListModel;
@implementation EPCloudCommentListDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"EPCloudCommentListCell";
    EPCloudCommentListCell* cell=(EPCloudCommentListCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[EPCloudCommentListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (self.datasource.count==0) {
        return cell;
    }
 
    companyListModel *model = self.datasource[indexPath.row];
    [cell setDate:model];
    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    
    
    return cell;
    
    
}

@end





@implementation EPCloudConnectionDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"EPCloudConnectionTableViewCell";
    EPCloudConnectionTableViewCell* cell=(EPCloudConnectionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[EPCloudConnectionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (self.datasource.count==0) {
        return cell;
    }
   
    MTConnectionModel *model=self.datasource[indexPath.row];
    [cell setDataWithModel:model];
    
    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    
    
    return cell;
    
    
}



@end

@class MTFansModel;
@implementation EPCloudFansDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"EPCloudFansTableViewCell";
    EPCloudFansTableViewCell* cell=(EPCloudFansTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[EPCloudFansTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (self.datasource.count==0) {
        return cell;
    }
    
    MTFansModel *model=self.datasource[indexPath.row];
    cell.model=model;
    [cell setDataWith];
    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    
    
    return cell;
    
    
}



@end

@class InvatedFriendslistModel;
@implementation InvitedFriendsDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"FriendCell";
    FriendCell* cell=(FriendCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[FriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (self.datasource.count==0) {
        return cell;
    }
    
    InvatedFriendslistModel *model = self.datasource[indexPath.row];
    [cell setData:model];
    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    
    
    return cell;
    
    
}

@end


@implementation BindCompanyListDataCell

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"BindCompanyListCell";
    
    BindCompanyListCell* cell=(BindCompanyListCell *)[tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (cell==nil) {
        cell=[[BindCompanyListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        UIView *bgColorView = [[UIView alloc] initWithFrame:cell.frame];
        bgColorView.backgroundColor = [UIColor clearColor];
        
        UIView *view  = [[UIView alloc]initWithFrame:CGRectMake(6, 7, WindowWith-12, 91)];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.borderColor = RGB(85, 201, 196).CGColor;
        view.layer.borderWidth =2.0;
        
        UIImage *img = Image(@"EP_right.png");
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
        imageV.image = img;
        imageV.centerY = (view.height - 6)/2.0;
        imageV.right = view.width - 6;
        [view addSubview:imageV];
        [bgColorView addSubview:view];
        
        [cell setSelectedBackgroundView:bgColorView];
    }
    if (self.datasource.count==0) {
        return cell;
    }
    BindCompanyModel *model=self.datasource[indexPath.row];
    [cell setlistModel:model];
    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    
    return cell;
    
    
    
    
}


@end




@implementation MTNewSupplyAndBuyDataSoure
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"MTNewSupplyAndBuyTableViewCell";
    MTNewSupplyAndBuyTableViewCell* cell=(MTNewSupplyAndBuyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[MTNewSupplyAndBuyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (self.datasource.count==0) {
        return cell;
    }
    
      cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    
    
    return cell;
    
    
}



@end


@implementation MTChartsDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"MTChartsTableViewCell";
    MTChartsTableViewCell* cell=(MTChartsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[MTChartsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (self.datasource.count==0) {
        return cell;
    }
    VoteListModel *model = self.datasource[indexPath.row];
    
    [cell setDataWith:indexPath model:model];
    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    
    
    return cell;
    
    
}



@end



@implementation CrowdFundingDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"CrowdFundingTableViewCell";
    CrowdFundingTableViewCell* cell=(CrowdFundingTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[CrowdFundingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (self.datasource.count==0) {
        return cell;
    }
    CrowdListModel *model=self.datasource[indexPath.row];
    
    [cell setDataWith:model];

    
    //[cell setDataWith:indexPath model:model];
    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    
    
    return cell;
    
    
}



@end

@implementation EPCloudCompanyDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    static NSString *identify=@"TableViewCell";
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (self.datasource.count==0) {
        return cell;
    }
    EPCloudCompanyModel *model=self.datasource[indexPath.row];
    
    cell.textLabel.text = model.company_name;
    cell.textLabel.font = sysFont(14);
    
    return cell;
    
    
}

@end



@implementation ZhaoPingDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"MTZhaoPingTableViewCell";
    MTZhaoPingTableViewCell* cell=(MTZhaoPingTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
 
    if (cell==nil) {
        cell=[[MTZhaoPingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify type:self.Mytype];
    }
    if (self.datasource.count==0) {
        return cell;
    }
    
    jianliModel *model=self.datasource[indexPath.row];
    [cell setDataWithModel:model];
     cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
   
    
    return cell;
    
    
}



@end

@implementation JobWantedDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"MTJobWantedTableViewCell";
    MTJobWantedTableViewCell* cell=(MTJobWantedTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[MTJobWantedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (self.datasource.count==0) {
        return cell;
    }
    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    PositionListModel *model=self.datasource[indexPath.row];
    [cell setCellDate:model type:self.type];
    
    return cell;
    
    
}


@end



@implementation CurriculumVitaeDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        static NSString *identify=@"CurriculumVitaeTableViewCell2";
        CurriculumVitaeTableViewCell2* cell=(CurriculumVitaeTableViewCell2 *)[tableView dequeueReusableCellWithIdentifier:identify];
        NSString *text=self.datasource[indexPath.section];
        
        if (cell==nil) {
            cell=[[CurriculumVitaeTableViewCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        if (self.datasource.count==0) {
            return cell;
        }
        [cell setDataWith:text];
        cell.indexPath=indexPath;
        cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
        
        
        return cell;

    }else {
        static NSString *identify=@"CurriculumVitaeTableViewCell";
        CurriculumVitaeTableViewCell* cell=(CurriculumVitaeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
        
        if (cell==nil) {
            cell=[[CurriculumVitaeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        if (self.datasource.count==0) {
            return cell;
        }
        cell.indexPath=indexPath;
       
        cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
        
        if (indexPath.section==1) {
            RecruitWorksModel *model=self.datasource[indexPath.section][indexPath.row];
            
            [cell setDataModel2:model];
        }else{
            RecruitEdusModel *model=self.datasource[indexPath.section][indexPath.row];
            [cell setDataWithModel:model];
            
        }
        
        return cell;
   
    }
    
    return nil;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section/*当前是第几段*/
{
    NSArray *arr=self.datasource[section];
    
    if(section==0){
        return 1;
    }
    
    return arr.count;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.datasource.count;
}







@end



@implementation MyPositionDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"MyPositionTableViewCell";
    MyPositionTableViewCell* cell=(MyPositionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[MyPositionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (self.datasource.count==0) {
        return cell;
    }
    
    ReleasePositionModel *model=self.datasource[indexPath.row];
    [cell setDataWithModel:model];
    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
  
    
    return cell;
    
    
}



@end



@implementation ChoosePositionDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"ChoosePositionTableViewCell";
    ChoosePositionTableViewCell* cell=(ChoosePositionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[ChoosePositionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (self.datasource.count==0) {
        return cell;
    }
    NSDictionary *dic=self.datasource[indexPath.section];
//    _dic=dic;
	
    [cell setDataWith:dic];
    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    
    
    return cell;
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
 
  

    
    return self.datasource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return 1;
}





@end


@implementation SearchPositionDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"SearchPositionTableViewCell";
    SearchPositionTableViewCell* cell=(SearchPositionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[SearchPositionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (self.datasource.count==0) {
        return cell;
    }
    
    SearchJobNameModel *model=self.datasource[indexPath.row];
    [cell setDataWith:model];
    
    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    
    
    return cell;
    
    
}



@end


@implementation NewECloudConnectionSearchDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"NewECloudConnectionSearchTableViewCell";
    NewECloudConnectionSearchTableViewCell* cell=(NewECloudConnectionSearchTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[NewECloudConnectionSearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (self.datasource.count==0) {
        return cell;
    }
    
   
    [cell setDataWith:self.datasource[indexPath.row]];
    
    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    
    
    return cell;
    
    
}



@end

@implementation QuestionDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"QuestionTableViewCell";
    QuestionTableViewCell* cell=(QuestionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[QuestionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (self.datasource.count==0) {
        return cell;
    }
    
    MyQuestionModel *model=self.datasource[indexPath.row];
    
    [cell setDataWithModel:model i:self.integer];
    
    //[cell setDataWith:datasource[indexPath.row]];
    
    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    
    
    return cell;
    
    
}



@end

@implementation AskBarContentDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"QuestionTableViewCell";
    AskBarContentCell* cell=(AskBarContentCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[AskBarContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (self.datasource.count==0) {
        return cell;
    }
    
    
    [cell setCellContent:self.datasource[indexPath.row]];
    
    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    
    
    return cell;
    
    
}
@end

@implementation QuestionCommentDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"QuestionCommentTableViewCell";
    QuestionCommentTableViewCell* cell=(QuestionCommentTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[QuestionCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (self.datasource.count==0) {
        return cell;
    }
    
    if (self.type == ENT_Other) {
        [cell setDataWith:self.datasource[indexPath.row]];
    }else if (self.type == ENT_Self){
        [cell setNoReplyData:self.datasource[indexPath.row]];
    }
    
    
    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    
    
    return cell;
    
    
}

@end

@implementation MyReleaseSupplyOrBuyDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MTSupplyAndBuyListModel *model=self.datasource[indexPath.row];
    static NSString *identify=@"MyReleaseSupplyOrBuyTableViewCell";
    MyReleaseSupplyOrBuyTableViewCell* cell=(MyReleaseSupplyOrBuyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[MyReleaseSupplyOrBuyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify type:self.type];
    }
    if (self.datasource.count==0) {
        return cell;
    }
    
    
    //[cell setDataWith:datasource[indexPath.row]];
    [cell setDataWithMode:model];
    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    
    
    return cell;
    
    
}



@end



@implementation MyReleaseTopicDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"MyReleaseTopicTableViewCell";
    MyReleaseTopicTableViewCell* cell=(MyReleaseTopicTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[MyReleaseTopicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (self.datasource.count==0) {
        return cell;
    }
    
    MTTopicListModel *model=self.datasource[indexPath.row];
    //[cell setDataWith:datasource[indexPath.row]];
    [cell setDataWithModel:model];
    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    
    
    return cell;
    
    
}



@end



@implementation MyReleaseQuestionDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"MyReleaseQuestionTableViewCell";
    MyReleaseQuestionTableViewCell* cell=(MyReleaseQuestionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[MyReleaseQuestionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (self.datasource.count==0) {
        return cell;
    }
    
    
    //[cell setDataWith:datasource[indexPath.row]];
    MyQuestionModel *model=self.datasource[indexPath.row];
    [cell setDataWithModel:model];
    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    
    
    return cell;
    
    
}



@end



@implementation NurseryDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"NurseryTableViewCell";
    NurseryTableViewCell* cell=(NurseryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[NurseryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (self.datasource.count==0) {
        return cell;
    }
    
    
    NurseryListModel *model=self.datasource[indexPath.row];
    [cell setDataWithModel:model];
    
    //[cell setLayerMasksCornerRadius:1 BorderWidth:0.5 borderColor:RGB(240, 240, 240)];
    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    
    
    return cell;
    
    
}



@end

@implementation NewsSearchDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"NewsSearchTableViewCell";
    NewsSearchTableViewCell* cell=(NewsSearchTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell == nil) {
        cell = [[NewsSearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (self.datasource.count == 0) {
        return cell;
    }
    
    
    NewsSearchModel *model=self.datasource[indexPath.row];
    [cell setDataWith:model.info_title_html];
    
    //[cell setLayerMasksCornerRadius:1 BorderWidth:0.5 borderColor:RGB(240, 240, 240)];
    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    
    
    return cell;
    
    
}


@end


