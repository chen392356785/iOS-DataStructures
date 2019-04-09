//
//  MTDataSource+DataSource2.m
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/11/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTDataSource+DataSource2.h"

@implementation MTDataSource (DataSource2)

@end

@implementation MyNerseryDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"MyNerseryTableViewCell";
    MyNerseryTableViewCell* cell=(MyNerseryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[MyNerseryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (self.datasource.count == 0) {
        return cell;
    }
    
    MyNerseryModel *model=self.datasource[indexPath.row];
    [cell setDataWithModel:model];
    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    
    
    return cell;
    
    
}



@end



@implementation ScoreHistoryDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"ScoreHistoryCell";
    ScoreHistoryCell* cell=(ScoreHistoryCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[ScoreHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (self.datasource.count==0) {
        return cell;
    }
    
    ScoreHistoryModel *model=self.datasource[indexPath.row];
    [cell setHistory:model];
    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    
    
    return cell;
    
    
}

@end

@implementation ScoreConvertDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"ScoreConvertCell";
    ScoreConvertCell* cell=(ScoreConvertCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[ScoreConvertCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (self.datasource.count==0) {
        return cell;
    }
    
    ScoreDetailModel *model=self.datasource[indexPath.row];
    [cell setDetail:model];
    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    
    
    return cell;
    
    
}

@end


@implementation ScoreDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"ScoreTableViewCell";
    ScoreTableViewCell* cell=(ScoreTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[ScoreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (self.datasource.count==0) {
        return cell;
    }
    
    CouponListModel *model=self.datasource[indexPath.row];
    [cell setDataWithModel:model];
  
    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    
    
    return cell;
    
    
}

@end



@implementation NerseryLeftDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"NerseryLeftTableViewCell";
    NerseryLeftTableViewCell* cell=(NerseryLeftTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[NerseryLeftTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (self.datasource.count==0) {
        return cell;
    }
//    if (indexPath.row==0) {
//        cell.selected=YES;
//    }
    
    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;

    [cell setDataWithText:self.datasource[indexPath.row]];
    

    
    return cell;
    
    
}


@end

@implementation RecommendGroupDataSource


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"RecommendGroupTableViewCell";
    RecommendGroupTableViewCell* cell=(RecommendGroupTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[RecommendGroupTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (self.datasource.count==0) {
        return cell;
    }
    NSDictionary *dic=self.datasource[indexPath.row];
    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    [cell setData:dic];
   
 
    return cell;
 
}


@end

@implementation FindCarDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"FindCarTableViewCell";
    FindCarTableViewCell* cell=(FindCarTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[FindCarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (self.datasource.count==0) {
        return cell;
    }
    FindCarModel *model=self.datasource[indexPath.row];
    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    [cell setDataWithModel:model];
    
    
    return cell;
    
}



@end

@implementation LogisicsMyFaBuDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"LogisyicsMyFaBuTableViewCell";
    LogisyicsMyFaBuTableViewCell* cell=(LogisyicsMyFaBuTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[LogisyicsMyFaBuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (self.datasource.count==0) {
        return cell;
    }
    OwnerFaBuModel *model=self.datasource[indexPath.row];
    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    [cell setDataWith:model];
    
    
    return cell;
    
}



@end

@implementation DriverCheYuanDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"DriverCheYuanTableViewCell";
    DriverCheYuanTableViewCell* cell=(DriverCheYuanTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[DriverCheYuanTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (self.datasource.count==0) {
        return cell;
    }
    CheYuanModel *model=self.datasource[indexPath.row];;
    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    [cell setDataWith:model];
    
    
    return cell;
    
}



@end


@implementation DriverRenZhengDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"DriverRenZhengTableViewCell";
    DriverRenZhengTableViewCell* cell=(DriverRenZhengTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        cell=[[DriverRenZhengTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (self.datasource.count==0) {
        return cell;
    }
     NSDictionary *dic=self.datasource[indexPath.row];
    cell.indexPath=indexPath;
    cell.delegate=(id<BCBaseTableViewCellDelegate>)self.attributes;
    [cell setDataWith:dic];
    
    
    return cell;
    
}

@end


