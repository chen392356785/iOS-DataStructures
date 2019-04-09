//
//  MTNetworkData+ForModel.m
//  MiaoTuProject
//
//  Created by Mac on 16/4/1.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import "MTNetworkData+ForModel.h"
//#import "SDTimeLineCellModel.h"
@implementation MTNetworkData (ForModel)

-(NSArray *)getJsonForString:(NSString *)str{
    NSData *data =[str dataUsingEncoding:NSUTF8StringEncoding];
    
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:data
                                                   options:NSJSONReadingMutableContainers
                                                     error:nil];
    
    return arr;
}
-(NSDictionary *)getJsonDicForString:(NSString *)str{
    NSData *data =[str dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *arr = [NSJSONSerialization JSONObjectWithData:data
                                                   options:NSJSONReadingMutableContainers
                                                     error:nil];
    
    return arr;
}

-(NSDictionary *)parseGetLogin:(NSDictionary*)dic
{
    NSArray* array = [dic objectForKey:@"data"];
    NSMutableArray* mArray = [[NSMutableArray alloc] initWithCapacity:[array count]];
    for (NSDictionary* itemDic in array) {
       
        [mArray addObject:itemDic];
    }
    
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:mArray forKey:@"data"];
  
   return dic2;
}

-(NSDictionary *)parseGetTopicList:(NSDictionary*)dic page:(int)page tag:(int)tag
{
    NSArray* array = [dic objectForKey:@"content"];
    NSMutableArray* mArray = [[NSMutableArray alloc] initWithCapacity:[array count]];
    
    if (page==0) {
        if (tag==IH_QueryHotTopicList) {
            [IHUtility saveUserDefaluts:array key:kTopicDefaultUserList];
        }
        
    }
    
    for (NSDictionary* itemDic in array) {
        
        if (itemDic==nil) {
            continue;
        }
        MTTopicListModel *model=[self getTopicModelForDic:itemDic];
        [mArray addObject:model];
    }
    
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:mArray forKey:@"content"];
    
    return dic2;
}

-(MTTopicListModel *)getTopicModelForDic:(NSDictionary *)itemDic{
   // itemDic=@"";
    
    MTTopicListModel *model=[[MTTopicListModel alloc]initWithDictionary:itemDic error:nil];
    NSDictionary *userDic=[itemDic objectForKey:@"userChildrenInfo"];
    model.userChildrenInfo.heed_image_url=[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,[userDic objectForKey:@"heed_image_url"]];
    NSString *str=[itemDic objectForKey:@"topic_url"];
    if (str.length>0) {
        NSArray *arr=[self getJsonForString:str];
        
        NSMutableArray *imgArr=[[NSMutableArray alloc]initWithCapacity:arr.count];
        
        for (NSDictionary *dic2 in arr) {
            MTPhotosModel *mod=[[MTPhotosModel alloc]initWithDic:dic2];
            [imgArr addObject:mod];
        }
        model.imgArray=imgArr;
    }
    
    
    CGSize titleSize=[IHUtility GetSizeByText:model.topic_content sizeOfFont:14 width:WindowWith-30];
    int imgHeigh=7;
    if (model.imgArray.count>0) {
        imgHeigh=[IHUtility getNewImagesViewHeigh:model.imgArray imageWidth:WindowWith-30];
    }
    
    CGFloat cellHeigh=60+7+titleSize.height+7+imgHeigh+65;
    model.bodyHeigh=[NSNumber numberWithFloat:titleSize.height+imgHeigh+10+32];
    model.cellHeigh=[NSNumber numberWithFloat:cellHeigh];
    return model;
}


-(NSDictionary *)parseGetSupplyCommentList:(NSDictionary*)dic
{
    NSArray* array = [dic objectForKey:@"content"];
    NSMutableArray* mArray = [[NSMutableArray alloc] initWithCapacity:[array count]];
    for (NSDictionary* itemDic in array){
        CommentListModel *model=[[CommentListModel alloc]initWithDictionary:itemDic error:nil];
        
        CGSize size=[IHUtility GetSizeByText:model.comment_cotent sizeOfFont:15 width:WindowWith-75];
        
        model.cellHeigh=[NSNumber numberWithFloat:48+size.height];
        
        [mArray addObject:model];
    }
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:mArray forKey:@"content"];
    
    return dic2;
}

 


-(NSDictionary *)parseGetNearUserList:(NSDictionary*)dic
{
    NSDictionary* dic2 = [dic objectForKey:@"content"];
    NSArray *array=dic2[@"nearCompanyList"];
    
    NSMutableArray* mArray = [[NSMutableArray alloc] initWithCapacity:[array count]];
    for (NSDictionary* itemDic in array){
        MTNearUserModel *model=[[MTNearUserModel alloc]initWithDictionary:itemDic error:nil];
        [mArray addObject:model];
    }
    
    
    
    NSMutableDictionary* dic3 = [NSMutableDictionary dictionaryWithDictionary:dic2];
    [dic3 setObject:mArray forKey:@"nearCompanyList"];
    
    return dic3;
}


-(NSDictionary *)parseGetContactList:(NSDictionary *)dic
{
    NSDictionary *content=dic[@"content"];
    NSArray* array = [content objectForKey:@"userList"];
    NSMutableArray* mArray = [[NSMutableArray alloc] initWithCapacity:[array count]];
    
    
    NSDictionary *keyDic=content[@"userIdentiKeyList"];
    
    for (NSDictionary *dic in array) {
        
        MTNearUserModel *model=[[MTNearUserModel alloc]initWithDictionary:dic error:nil];
        NSMutableArray *arr2=[keyDic objectForKey:model.user_id];
        model.userIdentityKeyList=arr2 ;
        [mArray addObject:model];
    }
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:mArray forKey:@"content"];
    
    
    return dic2;

}


-(NSDictionary *)getThemeAndInformation:(NSDictionary *)dic
{
   
    NSArray *array = dic[@"content"][@"informationList"];
    NSArray *Array= dic[@"content"][@"selectTopicRecommendListInfo"];
    
    NSMutableArray* mArray = [[NSMutableArray alloc] initWithCapacity:[array count]];
    
    NSMutableArray *MArray=[[NSMutableArray alloc]initWithCapacity:[Array count]];
    
    for (NSDictionary *dic in array) {
     
        
        NewsListModel *model=[[NewsListModel alloc]initWithDictionary:dic error:nil];
        [mArray addObject:model];
        
        NSString * str=model.info_url;
        if (str.length>0) {
            
            NSArray *arr=[self getJsonForString:str];
            NSMutableArray *imgArr=[[NSMutableArray alloc]initWithCapacity:arr.count];
            
            for (NSDictionary * dic2 in arr) {
                MTPhotosModel * photoModel=[[MTPhotosModel alloc]initWithUrlDic:dic2];
                [imgArr addObject:photoModel];
            }
            model.imgArray=imgArr;
        }
    }
    
    for (NSDictionary *dic in Array) {
        HomePageTopicModel *model=[[HomePageTopicModel alloc]initWithDictionary:dic error:nil];
        [MArray addObject:model];
    }
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSMutableDictionary *dic3=[[NSMutableDictionary alloc]init];
    [dic3 setObject:mArray forKey:@"informationList"];
    [dic3 setObject:MArray forKey:@"selectTopicRecommendListInfo"];
    
    [dic2 setObject:dic3 forKey:@"content"];
    return dic2;

}


-(NSDictionary *)getQueryCompanyList:(NSDictionary *)dic
{
    
    NSArray* array = [dic objectForKey:@"content"];
    NSMutableArray* mArray = [[NSMutableArray alloc] initWithCapacity:[array count]];
    
    for (NSDictionary *dic in array) {
        UserChildrenInfo *model=[[UserChildrenInfo alloc]initWithDictionary:dic error:nil];
        [mArray addObject:model];
    }
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:mArray forKey:@"content"];
    
    
    return dic2;
}



#pragma mark新版供求 
-(NSDictionary *)getSupplyAndBuyList:(NSDictionary *)dic page :(int)page{
    
    
    NSArray* array = [dic objectForKey:@"content"];
    
    
    if (page==0) {
        [IHUtility saveUserDefaluts:array key:kSupplyAndBuyDefaultUserList];
    }
    
    NSMutableArray* mArray = [[NSMutableArray alloc] initWithCapacity:[array count]];
    
    for (NSDictionary *dic in array) {
        MTNewSupplyAndBuyListModel*model=[self getNewSupplyAndBuyModel:dic];
        
        [mArray addObject:model];
    }
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:mArray forKey:@"content"];
    
    
    return dic2;
 
}

-(MTNewSupplyAndBuyListModel *)getNewSupplyAndBuyModel:(NSDictionary *)dic{
    MTNewSupplyAndBuyListModel *model=[[MTNewSupplyAndBuyListModel alloc]initWithDictionary:dic error:nil];
      model.userInfo.heed_image_url=[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,model.userInfo.heed_image_url];
    
    if (model.urls.length>0) {
        NSArray *arr2=[self getJsonForString:model.urls];
        NSMutableArray *imgArr=[[NSMutableArray alloc]initWithCapacity:arr2.count];
        for (id dic2 in arr2) {
            if ([dic2 isKindOfClass:[NSDictionary class]]) {
                MTPhotosModel *mod=[[MTPhotosModel alloc]initWithDic:dic2];
                [imgArr addObject:mod];
            }
        }
        model.imgArray=imgArr;
    }
    return model;
}


-(NSDictionary *)getQueryFindOutList:(NSDictionary *)dic
{
    NSArray* array = [dic objectForKey:@"content"];
    NSMutableArray* mArray = [[NSMutableArray alloc] initWithCapacity:[array count]];
    
    for (NSDictionary *dic in array) {
        UserChildrenInfo *model=[[UserChildrenInfo alloc]initWithDictionary:dic[@"userChildrenInfo"] error:nil];
       
        model.viewTime=dic[@"viewTime"];
        [mArray addObject:model];
    }
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:mArray forKey:@"userChildrenInfo"];
    
    
    return dic2;
}



-(NSDictionary *)getQueryClickLikeList:(NSDictionary *)dic{
    NSArray* array = [dic objectForKey:@"content"];
    NSMutableArray* mArray = [[NSMutableArray alloc] initWithCapacity:[array count]];
    
    for (NSDictionary *dic in array) {
        UserChildrenInfo *model=[[UserChildrenInfo alloc]initWithDictionary:dic error:nil];
        model.heed_image_url=[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,model.heed_image_url];
        
        [mArray addObject:model];
        
    }
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:mArray forKey:@"content"];
    
    return dic2;
    
}

-(NSDictionary *)getTopicForId:(NSDictionary *)dic{
    NSArray* array = [dic objectForKey:@"content"];
    NSMutableArray* mArray = [[NSMutableArray alloc] initWithCapacity:[array count]];
    
    for (NSDictionary *dic in array) {
        MTTopicListModel *model=[[MTTopicListModel alloc]initWithDictionary:dic error:nil];
       
        [mArray addObject:model];
        
    }
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:mArray forKey:@"content"];
    
    return dic2;

}


-(NSDictionary *)getFans:(NSDictionary *)dic{
    
    
    NSArray* array = [dic objectForKey:@"content"];
    NSMutableArray* mArray = [[NSMutableArray alloc] initWithCapacity:[array count]];
    
    for (NSDictionary *dic in array) {
        MTFansModel *model=[[MTFansModel alloc]initWithDictionary:dic error:nil];
        
        [mArray addObject:model];
        
    }
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:mArray forKey:@"content"];
    
    return dic2;

}

-(NSDictionary *)getConnection:(NSDictionary *)dic{
    
    
    NSArray* array = [dic objectForKey:@"content"];
    NSMutableArray* mArray = [[NSMutableArray alloc] initWithCapacity:[array count]];
    
    for (NSDictionary *dic in array) {
        MTConnectionModel *model=[[MTConnectionModel alloc]initWithDictionary:dic error:nil];
        
        [mArray addObject:model];
        
    }
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:mArray forKey:@"content"];
    
    return dic2;
    
}






-(NSDictionary*)getQuerySupplyList:(NSDictionary *)dic{
    
    NSArray* array = [dic objectForKey:@"content"];
    NSMutableArray* mArray = [[NSMutableArray alloc] initWithCapacity:[array count]];
 
    for (NSDictionary *dic in array) {
        MTSupplyListModel *model=[[MTSupplyListModel alloc]initWithDictionary:dic error:nil];
        [mArray addObject:model];
    }
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:mArray forKey:@"content"];
    
    return dic2;
 
}

-(NSDictionary *)getQueryBuyList:(NSDictionary *)dic{
    NSArray* array = [dic objectForKey:@"content"];
    NSMutableArray* mArray = [[NSMutableArray alloc] initWithCapacity:[array count]];
    
    for (NSDictionary *dic in array) {
        MTBuyListModel *model=[[MTBuyListModel alloc]initWithDictionary:dic error:nil];
        [mArray addObject:model];
        
    }
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:mArray forKey:@"content"];
    
    return dic2;
}

-(NSDictionary*)getSupplyAndBuyList:(NSDictionary *)dic2 type:(int)type page:(int)page{
    
    NSArray* array = [dic2 objectForKey:@"content"];
    NSMutableArray* mArray = [[NSMutableArray alloc] initWithCapacity:[array count]];
    
    
    if (page==0) {
        if (type==IH_QuerySupplyList) {
            [IHUtility saveUserDefaluts:array key:kSupplyDefaultUserList];
        }else if (type==IH_QueryBuyList){
            [IHUtility saveUserDefaluts:array key:kBuyDefaultUserList];
        }
    }
    
    for (NSDictionary *dic in array) {
        if (dic==nil) {
            continue;
        }
        MTSupplyAndBuyListModel *model=[self getSupplyAndBuyForDic:dic type:type];
        [mArray addObject:model];
    }
    NSMutableDictionary* dic3 = [NSMutableDictionary dictionaryWithDictionary:dic2];
    [dic3 setObject:mArray forKey:@"content"];
    
    return dic3;
}

#pragma mark 封装模型数据共用
-(MTSupplyAndBuyListModel *)getSupplyAndBuyForDic:(NSDictionary *)dic type:(int)type{
    MTSupplyAndBuyListModel *model=[[MTSupplyAndBuyListModel alloc]initWithDictionary:dic error:nil];
    NSDictionary *userDic=[dic objectForKey:@"userChildrenInfo"];
  
    model.userChildrenInfo.heed_image_url=[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,[userDic objectForKey:@"heed_image_url"]];
    if (type==IH_QuerySupplyList) {   //供应
        model.seedling_source_address=dic[@"seedling_source_address"];
        model.supply_id=dic[@"supply_id"];
        model.supply_url=dic[@"supply_url"];
        model.unit_price=dic[@"unit_price"];
        model.selling_point=dic[@"selling_point"];
       
        model.mining_area=dic[@"mining_area"];
        CGFloat imgHeigh=0;
        if (model.supply_url.length>0) {
            NSArray *arr=[self getJsonForString:model.supply_url];
            NSMutableArray *imgArr=[[NSMutableArray alloc]initWithCapacity:arr.count];
            for (NSDictionary *dic2 in arr) {
                MTPhotosModel *mod=[[MTPhotosModel alloc]initWithDic:dic2];
                [imgArr addObject:mod];
            }
            model.imgArray=imgArr;
            if (model.imgArray.count>0) {
                imgHeigh=[IHUtility getNewImagesViewHeigh:model.imgArray imageWidth:WindowWith-30];
            }
        }
        
        CGFloat yaoqiuHeigh=0;
        
        if (model.selling_point.length>0) {
            CGSize yaoqiuSize=[IHUtility GetSizeByText:model.selling_point sizeOfFont:14 width:WindowWith-77-15];
            yaoqiuHeigh=yaoqiuSize.height;
        }
        
        CGFloat myHeigh=0;
        if (model.seedling_source_address.length>0) {
            CGSize mySize=[IHUtility GetSizeByText:model.seedling_source_address sizeOfFont:14 width:WindowWith-77-15];
            myHeigh=mySize.height;
        }
        
        int h=0;
        if (yaoqiuHeigh==0 && myHeigh==0) {
            h=0;
        }else if (yaoqiuHeigh>0 || myHeigh>0){
            h=12;
        }else if (yaoqiuHeigh >0&& myHeigh>0){
            h=24;
        }
        
        int bqHeigh=0;
        if (model.branch_point ==0
            && model.rod_diameter==0
            &&model.crown_width_e==0
            &&model.crown_width_s==0
            && model.height_e==0
            && model.height_s==0) {
            bqHeigh=0;
		}else if ((model.branch_point >0 &&
				   model.rod_diameter>0 &&
				   (model.crown_width_e>0
					||model.crown_width_s>0))
                  || (model.height_e>0
                      || model.height_s>0)){
                      bqHeigh=15;
                  }else{
                      bqHeigh=15;
                  }
        
        if (h==0 &&bqHeigh==0) {
            h=-15;
        }
        
        CGFloat heigh=45+imgHeigh+39+yaoqiuHeigh+myHeigh+h+bqHeigh;
        model.bodyHeigh = [NSNumber numberWithFloat:heigh];
        model.cellHeigh =[NSNumber numberWithFloat:heigh+60+55];
        
        
    }else if (type==IH_QueryBuyList){   // 求购
        model.mining_area=dic[@"mining_area"];
        model.payment_methods_dictionary_id=dic[@"payment_methods_dictionary_id"];
        model.urgency_level_id=dic[@"urgency_level_id"];
        model.use_mining_area=dic[@"use_mining_area"];
        model.want_buy_id=dic[@"want_buy_id"];
        model.want_buy_url=dic[@"want_buy_url"];
        model.selling_point=dic[@"selling_point"];
        
        if (model.want_buy_url.length>0) {
            NSArray *arr=[self getJsonForString:model.want_buy_url];
            NSMutableArray *imgArr=[[NSMutableArray alloc]initWithCapacity:arr.count];
            for (NSDictionary *dic2 in arr) {
                MTPhotosModel *mod=[[MTPhotosModel alloc]initWithDic:dic2];
                [imgArr addObject:mod];
            }
            model.imgArray=imgArr;
        }
        
        CGFloat imgHeigh=0;
        if (model.imgArray.count>0) {
            imgHeigh=[IHUtility getNewImagesViewHeigh:model.imgArray imageWidth:WindowWith-30];
        }
        
        CGFloat yaoqiuHeigh=0;
        
        if (model.selling_point.length>0) {
            CGSize yaoqiuSize=[IHUtility GetSizeByText:model.selling_point sizeOfFont:14 width:WindowWith-77-15];
            yaoqiuHeigh=yaoqiuSize.height;
        }
        
        CGFloat myHeigh=0;
        if (model.mining_area.length>0) {
            CGSize mySize=[IHUtility GetSizeByText:model.mining_area sizeOfFont:14 width:WindowWith-77-15];
            myHeigh=mySize.height;
        }
        CGFloat ymHeigh=0;
        if (model.use_mining_area.length>0) {
            CGSize ymSize=[IHUtility GetSizeByText:model.use_mining_area sizeOfFont:14 width:WindowWith-77-15];
            ymHeigh=ymSize.height;
        }
        
        
        if (yaoqiuHeigh>0) {
            yaoqiuHeigh=yaoqiuHeigh+12;
        }
        if (myHeigh>0) {
            myHeigh=myHeigh+12;
        }
        if (ymHeigh>0) {
            ymHeigh=ymHeigh+12;
        }
        int h=yaoqiuHeigh+myHeigh+ymHeigh;
        
        int bqHeigh=0;
        if (model.branch_point ==0
            && model.rod_diameter==0
            &&model.crown_width_e==0
            &&model.crown_width_s==0
            && model.height_e==0
            && model.height_s==0) {
            bqHeigh=0;
		}else if ((model.branch_point >0 &&
				   model.rod_diameter>0 &&
				   (model.crown_width_e>0
					||model.crown_width_s>0))
                  || (model.height_e>0
                      || model.height_s>0)){
                      bqHeigh=60;
                  }else{
                      bqHeigh=25;
                  }
        
        int payType=[model.payment_methods_dictionary_id intValue];
        int urgencyType=[model.urgency_level_id intValue];
        int payHeigh=0;
        if (payType==0 && urgencyType==0) {
            payHeigh=0;
        }else{
            payHeigh=25;
        }
        
        
        CGFloat heigh=45+imgHeigh+35+h+bqHeigh+payHeigh;
        model.bodyHeigh = [NSNumber numberWithFloat:heigh];
        model.cellHeigh =[NSNumber numberWithFloat:heigh+60+55];
    }
    return model;
}

//读取收藏 供应，求购
-(NSDictionary *)getCollectionSupplyAndWantBuyList:(NSDictionary *)dic type:(int)type{
    NSArray* array = [dic objectForKey:@"content"];
    NSMutableArray* mArray = [[NSMutableArray alloc] initWithCapacity:[array count]];
    
     for (NSDictionary *dic2 in array) {
         MyCollectionSupplyAndBuyModel *model=[[MyCollectionSupplyAndBuyModel alloc]init];
         model.collectionTime=dic2[@"collectionTime"];
         if (type==IH_GetMyCollectionSupplyList) {
             MTSupplyAndBuyListModel *mod=[self getSupplyAndBuyForDic:dic2[@"selectSupplyInfo"] type:IH_QuerySupplyList];
             
             model.supplyBuyInfo=mod;
         }else if (type==IH_GetMyCollectionBuyList){
             MTSupplyAndBuyListModel *mod=[self getSupplyAndBuyForDic:dic2[@"selectWantBuyInfo"] type:IH_QueryBuyList];
             model.supplyBuyInfo=mod;
         }
       
         [mArray addObject:model];
         
     }
    
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:mArray forKey:@"content"];
    
    return dic2;
}


//读取收藏 话题
-(NSDictionary *)getCollectionTopicList:(NSDictionary *)dic{
    NSArray* array = [dic objectForKey:@"content"];
    NSMutableArray* mArray = [[NSMutableArray alloc] initWithCapacity:[array count]];
    
    for (NSDictionary *dic2 in array) {
        MyCollectionTopicModel *model=[[MyCollectionTopicModel alloc]init];
        model.collectionTime=dic2[@"collectionTime"];
        model.topicInfo=[self getTopicModelForDic:dic2[@"selectTopicInfo"]];
        [mArray addObject:model];
    }
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:mArray forKey:@"content"];
    
    return dic2;
}

-(NSDictionary *)getCommentMeList:(NSDictionary *)dic{
    NSArray* array = [dic objectForKey:@"content"];
    NSMutableArray* mArray = [[NSMutableArray alloc] initWithCapacity:[array count]];
    
    for (NSDictionary *dic2 in array) {
        MTCommentMeModel *model=[[MTCommentMeModel alloc]initWithDictionary:dic2 error:nil];
        
 
        
         model.userInfo.heed_image_url=[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,model.userInfo.heed_image_url];
        
        NSString *str=model.content_url;
        if (str.length>0) {
            NSArray *arr=[self getJsonForString:str];
            NSMutableArray *imgArr=[[NSMutableArray alloc]initWithCapacity:arr.count];
            for (NSDictionary *dic2 in arr) {
                MTPhotosModel *mod=[[MTPhotosModel alloc]initWithDic:dic2];
                [imgArr addObject:mod];
            }
            model.imgArray=imgArr;
        }
 
        CGSize size=[IHUtility GetSizeByText:model.comment_c sizeOfFont:15 width: WindowWith-65-17];
        
        CGFloat heigh2=0;
        if (model.childrenComments.user_id>0) {
            NSString *comment=[NSString stringWithFormat:@"%@:%@",model.childrenComments.nickname,model.childrenComments.comment];
            
            CGSize size1=[IHUtility GetSizeByText:comment sizeOfFont:15 width:WindowWith-65-17-14];
            heigh2=size1.height+10;
        }
       
        model.cellHeigh=[NSNumber numberWithFloat:size.height+65+heigh2+72+20];
        
        [mArray addObject:model];
    }
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:mArray forKey:@"content"];
    
    return dic2;
    
}

//行业资讯
- (NSDictionary *)getNewsList:(NSDictionary *)dic
{
    NSLog(@"+++++++%@",dic);
    
    NSDictionary *listDic = [dic objectForKey:@"content"];
    NSArray* array;
    if (listDic[@"informationList"]) {
        array = [listDic objectForKey:@"informationList"];
    }
    NSDictionary *imagelistDic = [listDic objectForKey:@"informationImageList"];
    NSMutableArray* mArray = [[NSMutableArray alloc] initWithCapacity:[array count]];
    
    for (NSDictionary *dic in array) {
        NewsListModel *model=[[NewsListModel alloc]initWithDictionary:dic error:nil];
        
        NSArray *imgArr = [imagelistDic objectForKey:stringFormatInt(model.info_id)];
        if (imgArr !=nil) {
            NSMutableArray* imgArray = [[NSMutableArray alloc] initWithCapacity:[imgArr count]];
            for (NSDictionary *imgDic in imgArr) {
                NewsImageModel *imgModel = [[NewsImageModel alloc] initWithDictionary:imgDic error:nil];
                imgModel.descriptionStr = imgDic[@"description"];
                [imgArray addObject:imgModel];
            }
            
            model.imgModels = imgArray;
        }
        NSString * str=model.info_url;
        if (str.length>0) {
            
            NSArray *arr=[self getJsonForString:str];
            NSMutableArray *imgArr=[[NSMutableArray alloc]initWithCapacity:arr.count];
            
            for (NSDictionary * dic2 in arr) {
                MTPhotosModel * photoModel=[[MTPhotosModel alloc]initWithUrlDic:dic2];
                [imgArr addObject:photoModel];
            }
            model.imgArray=imgArr;
        }
        
        CGFloat cellHeigh;
        SMLabel * _tittle=[[SMLabel alloc]init];
        _tittle.numberOfLines=0;
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"         %@",model.info_title]];
        
        [attrString addAttribute:NSFontAttributeName value: boldFont(15) range:NSMakeRange(0,attrString.length)];
        
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:6];//调整行间距
        [attrString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attrString length])];
        [attrString addAttribute:NSForegroundColorAttributeName value:RGB(44, 44, 46) range:NSMakeRange(0,attrString.length)];
        _tittle.attributedText=attrString;
        
        
        CGSize size=[_tittle sizeThatFits:CGSizeMake(WindowWith-24, CGFLOAT_MAX)];
//        NSLog(@"%d---%f",model.img_type,size.height);
        
        if (model.img_type==0) {
            
                      cellHeigh=12+size.height+12+(WindowWith-24)*0.32+12+12+12+5;
            
             model.cellHeigh=[NSNumber numberWithFloat:cellHeigh];
        }
        else if (model.img_type==1){
            cellHeigh=12+WindowWith*0.186+12+5;
            model.cellHeigh=[NSNumber numberWithFloat:cellHeigh];
        }else if (model.img_type==2 || model.img_type==3){
            cellHeigh=12+size.height+12+(WindowWith-48)*0.23+12+12+5;
           
                if (size.height>15) {
                    cellHeigh=12+size.height+12+(WindowWith-48)*0.23+12+12+5+10;
                }
             
            
            model.cellHeigh=[NSNumber numberWithFloat:cellHeigh];
        }else if (model.img_type==4){
            cellHeigh=12+size.height+12+(WindowWith-24)*0.55+12+12+12+3;
             model.cellHeigh=[NSNumber numberWithFloat:cellHeigh];
        }else if (model.img_type==5){
            cellHeigh=12+size.height+12+12+12+3;
             model.cellHeigh=[NSNumber numberWithFloat:cellHeigh];
        }
        [mArray addObject:model];
        
    }
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:mArray forKey:@"content"];
    
    return dic2;
}

//- (NSDictionary *)getNewsList:(NSDictionary *)dic
//{
//    
//    NSArray* array = [dic objectForKey:@"content"];
//    NSMutableArray* mArray = [[NSMutableArray alloc] initWithCapacity:[array count]];
//    
//    for (NSDictionary *dic in array) {
//        NewsListModel *model=[[NewsListModel alloc]initWithDictionary:dic error:nil];
//        
//        NSString * str=model.info_url;
//        if (str.length>0) {
//            
//            NSArray *arr=[self getJsonForString:str];
//            NSMutableArray *imgArr=[[NSMutableArray alloc]initWithCapacity:arr.count];
//            
//            for (NSDictionary * dic2 in arr) {
//                MTPhotosModel * photoModel=[[MTPhotosModel alloc]initWithUrlDic:dic2];
//                [imgArr addObject:photoModel];
//            }
//            model.imgArray=imgArr;
//        }
//        
//        
//        [mArray addObject:model];
//        
//    }
//    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
//    [dic2 setObject:mArray forKey:@"content"];
//    
//    return dic2;
//}





-(NSDictionary *)getActivityList:(NSDictionary *)dic tag:(int)tag{
    NSArray* array = [dic objectForKey:@"content"];
    NSMutableArray* mArray = [[NSMutableArray alloc] initWithCapacity:[array count]];
    
    for (NSDictionary *dic in array) {
//        NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
        
        ActivitiesListModel *model = [[ActivitiesListModel alloc] initWithDictionary:dic error:nil];
        if (dic[@"require_field"] != nil) {
            NSDictionary *dic4 = [self getJsonDicForString:dic[@"require_field"]];
            model.userinfoDic = dic4;
        }
        model.activities_id = dic[@"activities_id"];
        model.activities_address_lat = dic[@"activities_address_lat"];
        model.activities_address_lon = dic[@"activities_address_lon"];
        model.activities_address = dic[@"activities_address"];
        model.html_content = dic[@"html_content"];
//        model.zcouList = dic[@"zcouList"];
        if (tag==IH_AllActivityList ) {
            model.user_upper_limit_num = dic[@"user_upper_limit_num"];
            model.registration_user = dic[@"registration_user"];
            model.activities_content_text = dic[@"activities_content_text"];
            model.shareTotal = dic[@"shareTotal"];
            model.clickLikeTotal = dic[@"clickLikeTotal"];
            model.commentTotal = dic[@"commentTotal"];
            model.sign_up_num = dic[@"sign_up_num"];
            model.hasClickLike = dic[@"hasClickLike"];
            model.model = [NSString stringWithFormat:@"%@",dic[@"model"]];
//            NSDictionary *dic4 = [self getJsonDicForString:dic[@"require_field"]];
//            model.userinfoDic = dic4;
        }else if (tag == IH_UserActivityList){
            model.user_id = dic[@"user_id"];
            model.a_order_id = dic[@"a_order_id"];
            model.order_status = dic[@"order_status"];
            model.activities_uploadtime = dic[@"activities_uploadtime"];
            model.order_num = dic[@"order_num"];
            model.unit_price = dic[@"unit_price"];
            model.contacts_people = dic[@"contacts_people"];
            model.email = dic[@"email"];
            model.order_no = dic[@"order_no"];
            model.crowd_status = [NSString stringWithFormat:@"%@",dic[@"crowd_status"]];
            model.crowd_id = [NSString stringWithFormat:@"%@",dic[@"crowd_id"]];
            model.total_money = [NSString stringWithFormat:@"%@",dic[@"total_money"]];
            model.obtain_money = [NSString stringWithFormat:@"%@",dic[@"obtain_money"]];
        }
        model.onlookers_user = [NSString stringWithFormat:@"%@",dic[@"onlookers_user"]];
        model.collectionTotal = [NSString stringWithFormat:@"%@",dic[@"collectionTotal"]];
        model.curtime = dic[@"curtime"];
        model.hasCollection = [NSString stringWithFormat:@"%@",dic[@"hasCollection"]];
        model.cellHeigh=[NSNumber numberWithFloat:kWidth(130)];
//        if (WindowWith==320) {
//           model.cellHeigh=[NSNumber numberWithFloat:270];
//        }else if (WindowWith==414){
//            model.cellHeigh=[NSNumber numberWithFloat:308];
//        }
        [mArray addObject:model];
    }
    
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:mArray forKey:@"content"];
    
    return dic2;

}


- (NSDictionary *)getaddActivties:(NSDictionary *)Dic tag:(int)tag
{

       NSDictionary *dic = [Dic objectForKey:@"content"];
        
        ActivitiesListModel *model = [[ActivitiesListModel alloc] initWithDictionary:dic error:nil];
        model.activities_id = dic[@"activities_id"];
        model.activities_address_lat = dic[@"activities_address_lat"];
        model.activities_address_lon = dic[@"activities_address_lon"];
        model.activities_address = dic[@"activities_address"];
        model.user_upper_limit_num = dic[@"user_upper_limit_num"];
        model.registration_user = dic[@"registration_user"];
        model.activities_content_text = dic[@"activities_content_text"];
        model.html_content = dic[@"html_content"];
        model.shareTotal = dic[@"shareTotal"];
        model.clickLikeTotal = dic[@"clickLikeTotal"];
        model.commentTotal = dic[@"commentTotal"];
        model.sign_up_num = dic[@"sign_up_num"];
        model.hasClickLike = dic[@"hasClickLike"];
        model.onlookers_user = [NSString stringWithFormat:@"%@",dic[@"onlookers_user"]];
        model.collectionTotal = [NSString stringWithFormat:@"%@",dic[@"collectionTotal"]];
        model.curtime = dic[@"curtime"];

        model.hasCollection = [NSString stringWithFormat:@"%@",dic[@"hasCollection"]];
        if (dic[@"require_field"] != nil) {
            NSDictionary *dic4 = [self getJsonDicForString:dic[@"require_field"]];
            model.userinfoDic = dic4;
        }
    
        if (tag == IH_AddActivties) {
            model.user_id = dic[@"user_id"];
            model.a_order_id = dic[@"a_order_id"];
            model.order_status = dic[@"order_status"];
            model.activities_uploadtime = dic[@"activities_uploadtime"];
            model.order_num = dic[@"order_num"];
            model.unit_price = dic[@"unit_price"];
            model.contacts_people = dic[@"contacts_people"];
            model.email = dic[@"email"];
            model.order_no = dic[@"order_no"];
            model.job = dic[@"job"];
            model.company_name = dic[@"company_name"];
        }
    
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:model forKey:@"content"];
    
    return dic2;

    
}


-(NSDictionary *)GetThemeList:(NSDictionary *)dic page:(int)page{
    NSArray* array = [dic objectForKey:@"content"];
    NSMutableArray* mArray = [[NSMutableArray alloc] initWithCapacity:[array count]];
    
    if (page==0) {
        [IHUtility saveUserDefaluts:array key:kThemeDefaultUserList];
    }
    
    for (NSDictionary *dic in array) {
        ThemeListModel *model=[self parseThemeList:dic];
        [mArray addObject:model];
    }
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:mArray forKey:@"content"];
    
    return dic2;
}

-(ThemeListModel*)parseThemeList:(NSDictionary *)dic{
    ThemeListModel *model=[[ThemeListModel alloc]initWithDictionary:dic error:nil];
    model.content_url=[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,dic[@"content_url"]];
    return model;
}

- (NSDictionary *)getNewsDetailContent:(NSDictionary *)dic
{
    NSDictionary *Dic = [dic objectForKey:@"content"];
    NewDetailModel *model = [[NewDetailModel alloc] init];
    model.html_content = Dic[@"html_content"];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSDictionary *modic in Dic[@"informationInfoList"]) {
        NewsListModel *mod = [[NewsListModel alloc] initWithDictionary:modic error:nil];
        
        NSString * str=mod.info_url;
        if (str.length>0) {
            
            NSArray *arr=[self getJsonForString:str];
            NSMutableArray *imgArr=[[NSMutableArray alloc]initWithCapacity:arr.count];
            
            for (NSDictionary * dic2 in arr) {
                MTPhotosModel * photoModel=[[MTPhotosModel alloc]initWithUrlDic:dic2];
                [imgArr addObject:photoModel];
            }
            mod.imgArray=imgArr;
        }
        
        mod.cellHeigh=[NSNumber numberWithFloat:0.266*WindowWith];
        [array addObject:mod];

    }

    model.listModel = array;
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:model forKey:@"content"];
    return dic2;
    
}

- (NSDictionary *)getImageNewsDetailContent:(NSDictionary *)dic
{
    NSDictionary *Dic = [dic objectForKey:@"content"];
    NSDictionary *infoDic = [Dic objectForKey:@"information"];
    NSArray *imageArr = [Dic objectForKey:@"images"];
    
    NewsListModel *model = [[NewsListModel alloc] initWithDictionary:infoDic error:nil];
    
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *imageDic in imageArr) {
        NewsImageModel *mod = [[NewsImageModel alloc] initWithDictionary:imageDic error:nil];
        mod.descriptionStr = imageDic[@"description"];
        [arr addObject:mod];
    }
    
    model.imgModels = arr;
    
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:model forKey:@"content"];
    return dic2;
    
}

- (NSDictionary *)getPushNewsDetailContent:(NSDictionary *)dic
{
    NSDictionary *Dic = [dic objectForKey:@"content"];
    NSDictionary *infoDic = [Dic objectForKey:@"information"];
    NSArray *imageArr = [Dic objectForKey:@"images"];
    NSArray *infoListArr = [Dic objectForKey:@"informationInfoList"];
    
    NewsListModel *model = [[NewsListModel alloc] initWithDictionary:infoDic error:nil];
    NSString * str=model.info_url;
    if (str.length>0) {
        
        NSArray *arr1=[self getJsonForString:str];
        NSMutableArray *imgArr=[[NSMutableArray alloc]initWithCapacity:arr1.count];
        
        for (NSDictionary * dic2 in arr1) {
            MTPhotosModel * photoModel=[[MTPhotosModel alloc]initWithUrlDic:dic2];
            [imgArr addObject:photoModel];
        }
        model.imgArray=imgArr;
    }

    NewDetailModel *detailModel = [[NewDetailModel alloc] init];
    if (imageArr != nil) {
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *imageDic in imageArr) {
            NewsImageModel *mod = [[NewsImageModel alloc] initWithDictionary:imageDic error:nil];
            mod.descriptionStr = imageDic[@"description"];
            [arr addObject:mod];
        }
        
        model.imgModels = arr;
    }else if (infoListArr != nil){
        
         NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *modic in Dic[@"informationInfoList"]) {
            NewsListModel *mod = [[NewsListModel alloc] initWithDictionary:modic error:nil];
            
            NSString * str=mod.info_url;
            if (str.length>0) {
                
                NSArray *arr1=[self getJsonForString:str];
                NSMutableArray *imgArr=[[NSMutableArray alloc]initWithCapacity:arr1.count];
                
                for (NSDictionary * dic2 in arr1) {
                    MTPhotosModel * photoModel=[[MTPhotosModel alloc]initWithUrlDic:dic2];
                    [imgArr addObject:photoModel];
                }
                mod.imgArray=imgArr;
            }

            [arr addObject:mod];
            

        }
        detailModel.listModel = arr;
        detailModel.html_content = Dic[@"html_content"];

    }
    
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:model forKey:@"content"];
    [dic2 setObject:detailModel forKey:@"detailContent"];
    return dic2;
}

- (NSDictionary *)getEPCloudlistData:(NSDictionary *)dic
{
    NSArray *Arr=dic[@"content"][@"companyInfos"];
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *Dic in Arr) {
//        [Dic propertyCode];
        EPCloudListModel *model = [[EPCloudListModel alloc] initWithDictionary:Dic error:nil];
        
//        model.logo=[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,[Dic objectForKey:@"logo"]];
        
        [array addObject:model];
        
        NSString * str=model.company_image;
        if (str.length>0) {
            
            NSArray *arr1=[self getJsonForString:str];
            NSMutableArray *imgArr=[[NSMutableArray alloc]initWithCapacity:arr1.count];
            
            for (NSDictionary * dic2 in arr1) {
                MTPhotosModel * photoModel=[[MTPhotosModel alloc]initWithUrlDic:dic2];
                [imgArr addObject:photoModel];
            }
            model.imageArr=imgArr;
        }

    }
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:array forKey:@"content"];

    return dic2;
}

- (NSDictionary *)getCompanyTrackData:(NSDictionary *)dic
{
    NSArray *Arr=dic[@"content"][@"companyNews"];
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *Dic in Arr) {
        [Dic propertyCode];

        CompanyTrackModel *model = [[CompanyTrackModel alloc] initWithDictionary:Dic error:nil];
        model.heed_image_url=[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,[Dic objectForKey:@"heed_image_url"]];
        [array addObject:model];
    }
    
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:array forKey:@"content"];
    [dic2 setObject:dic[@"content"][@"totalCount"] forKey:@"totalCount"];
    
    return dic2;
}


- (NSDictionary *)getCompanyCommentListData:(NSDictionary *)dic
{
    NSArray *Arr = dic[@"content"];
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *Dic in Arr) {
//        [Dic propertyCode];
        companyListModel *model = [[companyListModel alloc] initWithDictionary:Dic error:nil];
        model.heed_image_url=[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,[Dic objectForKey:@"heed_image_url"]];
        CGSize size = [IHUtility GetSizeByText:model.comment_content sizeOfFont:14 width:WindowWith-65];
        CGFloat cellHeight = size.height + 65;
        model.cellHeigh=[NSNumber numberWithFloat:cellHeight];
        [array addObject:model];
    }
    
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:array forKey:@"content"];
    return dic2;
}

- (NSDictionary *)getinvatedFriendsList:(NSDictionary *)dic
{
    NSDictionary *Dic = dic[@"content"];
    NSArray *userArr = Dic[@"userInfo"];
    
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *userDic in userArr) {
//        [userDic propertyCode];
        InvatedFriendslistModel *model  = [[InvatedFriendslistModel alloc]initWithDictionary:userDic error:nil];
        model.heed_image_url=[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,[userDic objectForKey:@"heed_image_url"]];
        [arr addObject:model];
    }
    
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:arr forKey:@"content"];
    [dic2 setObject:Dic[@"active_desc"] forKey:@"active_desc"];
    [dic2 setObject:Dic[@"totalNum"] forKey:@"totalNum"];
    [dic2 setObject:Dic[@"totalMoney"] forKey:@"totalMoney"];
    return dic2;
}

- (NSDictionary *)getBindCompanyListData:(NSDictionary *)dic
{
    NSArray *arr= dic[@"content"];
    
    NSMutableArray *array =[ NSMutableArray array];
    for (NSDictionary *Dic in arr) {
//        [Dic propertyCode];
        BindCompanyModel *model = [[BindCompanyModel alloc] initWithDictionary:Dic error:nil];
        [array addObject:model];
    }
    
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:array forKey:@"content"];
    return dic2;
    
}

- (NSDictionary *)getVoteListData:(NSDictionary *)dic
{
    NSDictionary *contentDic= dic[@"content"];
    
    NSMutableArray *array =[ NSMutableArray array];
    for (NSDictionary *Dic in contentDic[@"data"]) {
//        [Dic propertyCode];

        VoteListModel *model = [[VoteListModel alloc] initWithDictionary:Dic error:nil];
        model.head_image=[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,[Dic objectForKey:@"head_image"]];
        [array addObject:model];
    }
    
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:array forKey:@"content"];
    [dic2 setObject:contentDic[@"totalNum"] forKey:@"totalNum"];
    [dic2 setObject:contentDic[@"surplus"] forKey:@"surplus"];
    [dic2 setObject:contentDic[@"curDate"] forKey:@"curDate"];
    [dic2 setObject:contentDic[@"total_piao"] forKey:@"total_piao"];
    return dic2;
    
}

- (NSDictionary *)getVoteChartisListData:(NSDictionary *)dic
{
    NSDictionary *conDic= dic[@"content"];
    NSArray *arr = conDic[@"voteList"];
    NSMutableArray *array =[ NSMutableArray array];
    for (NSDictionary *Dic in arr) {
//        [Dic propertyCode];
        VoteListModel *model = [[VoteListModel alloc] initWithDictionary:Dic error:nil];
        model.head_image=[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,[Dic objectForKey:@"head_image"]];
        model.totalNum = [NSString stringWithFormat:@"%@",conDic[@"totalNum"]];
        [array addObject:model];
    }
    
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:array forKey:@"content"];
    return dic2;
    
}

- (NSDictionary *)getVoteDetailtData:(NSDictionary *)dic
{
    NSDictionary *conDic= dic[@"content"];
   NSDictionary *Dic = conDic[@"voteProject"];

    //        [Dic propertyCode];
    VoteListModel *model = [[VoteListModel alloc] initWithDictionary:Dic error:nil];
    model.head_image=[NSString stringWithFormat:@"%@%@",ConfigManager.ImageUrl,[Dic objectForKey:@"head_image"]];
    model.totalNum = [NSString stringWithFormat:@"%@",conDic[@"totalNum"]];

    
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:model forKey:@"content"];
    [dic2 setObject:conDic[@"surplus"] forKey:@"surplus"];
    [dic2 setObject:conDic[@"total_piao"] forKey:@"total_piao"];
    return dic2;
    
}

-(MTNewSupplyAndBuyListModel *)getNewSupplyAndBuyForOld:(MTSupplyAndBuyListModel*)model type:(int)type{
    MTNewSupplyAndBuyListModel *mod=[[MTNewSupplyAndBuyListModel alloc]init];
    mod.crown_width_s=stringFormatDouble(model.crown_width_s) ;
    mod.crown_width_e=stringFormatDouble(model.crown_width_e) ;
    mod.userInfo=model.userChildrenInfo;
    mod.type=stringFormatInt(type);
    if (type==1) {
        mod.news_id=model.supply_id;
        mod.unit_price=model.unit_price;
    }else if (type==2){
        mod.news_id=model.want_buy_id;
//        mod.unit_price=model.unit_price;
    }
    mod.uploadtime=model.uploadtime;
    mod.varieties=model.varieties;
    mod.imgArray=model.imgArray;
    mod.height_s=stringFormatDouble(model.height_s);
    mod.height_e=stringFormatDouble(model.height_e);
    mod.rod_diameter=stringFormatDouble(model.rod_diameter);
    mod.branch_point=stringFormatDouble(model.branch_point);
    
    
    
    return mod;
    
}

- (NSDictionary *)getAddCrowdOrderData:(NSDictionary *)dic
{
    NSDictionary *Dic= dic[@"content"];
    
    CrowdOrderModel *model = [[CrowdOrderModel alloc] init];
    NSDictionary *crowdInfoDic = Dic[@"crowdInfo"];
    
    CrowdInfoModel *infoModel = [[CrowdInfoModel alloc] initWithDictionary:crowdInfoDic error:nil];
    model.infoModel = infoModel;
    
    ActivitiesListModel *ListInfoModel = [[ActivitiesListModel alloc] initWithDictionary:Dic[@"selectActivitiesListInfo"] error:nil];
    model.selectActivitiesListInfo = ListInfoModel;
//    [crowdInfoDic propertyCode];
    
    
    NSArray *arr = Dic[@"crowdList"];
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *listDic in arr) {
        CrowdListModel *listModel = [[CrowdListModel alloc] initWithDictionary:listDic error:nil];
        [array addObject:listModel];
    }
    
    model.listModels = [array mutableCopy];
    model.diffDay=Dic[@"diffDay"];
    NSDictionary *orderInfoDic = Dic[@"orderInfo"];
    CrowdOrderInfoModel *orderInfoModel = [[CrowdOrderInfoModel alloc] initWithDictionary:orderInfoDic error:nil];
//    [orderInfoDic propertyCode];
    model.orderInfoModel = orderInfoModel;
    
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:model forKey:@"content"];
    return dic2;

}


- (NSDictionary *)getEPCloudUserInfoData:(NSDictionary *)dic
{
    NSDictionary *Dic= dic[@"content"];
    
    JionEPCloudInfoModel *model = [[JionEPCloudInfoModel alloc] initWithDictionary:Dic error:nil];
    
    ExperienceinfoModel *experienceInfoModel = [[ExperienceinfoModel alloc] initWithDictionary:Dic[@"experience_info"] error:nil];
    model.experienceInfoModel = experienceInfoModel;
    
    UserChildrenInfo *userInfoModel = [[UserChildrenInfo alloc] initWithDictionary:Dic[@"addressInfo"] error:nil];
    model.addressInfoModel = userInfoModel;
    
    MTCompanyModel *companyModel  = [[MTCompanyModel alloc] initWithDictionary:Dic[@"companyinfo"] error:nil];
    model.companyinfoModel = companyModel;
    
    ExperienceNoticeInfoModel *noticeInfoModel = [[ExperienceNoticeInfoModel alloc] initWithDictionary:Dic[@"experienceNoticeInfo"] error:nil];
    model.experienceNoticeModel = noticeInfoModel;
    
    AuthInfoModel *authInfomodel  = [[AuthInfoModel alloc] initWithDictionary:Dic[@"authenticationInfo"] error:nil];
    model.authInfoModel = authInfomodel;
    
    
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:model forKey:@"content"];
    [dic2 setObject:Dic forKey:@"dic"];
    return dic2;
    
}

- (NSDictionary *)searchCompanyList:(NSDictionary *)dic
{
    NSArray *arr = dic[@"content"];
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *Dic in arr) {
        EPCloudCompanyModel *model = [[EPCloudCompanyModel alloc] initWithDictionary:Dic error:nil];
        [array addObject:model];
    }

    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:array forKey:@"content"];
    return dic2;
}
- (NSDictionary *)CompanyInfoWith:(NSDictionary *)dic
{
    
    NSDictionary *Dic=dic[@"content"]; 



    MTCompanyModel *model = [[MTCompanyModel alloc] initWithDictionary:Dic error:nil];
    
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    if (model !=nil) {
        [dic2 setObject:model forKey:@"content"];
        [dic2 setObject:Dic forKey:@"data"];
    }


    return dic2;
}

-(NSDictionary *)searchJianliList:(NSDictionary *)dic{
    
    NSArray *arr = dic[@"content"][@"resumeList"];
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *Dic in arr) {
        jianliModel *model = [[jianliModel alloc] initWithDictionary:Dic error:nil];
        [array addObject:model];
    }
    
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic[@"content"]];
    [dic2 setObject:array forKey:@"resumeList"];
    
    return dic2;

    
    
}


-(NSDictionary *)searchJianliListJobName:(NSDictionary *)dic{
    
    NSArray *arr = dic[@"content"];
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *Dic in arr) {
        jianliModel *model = [[jianliModel alloc] initWithDictionary:Dic error:nil];
        [array addObject:model];
    }
    
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:array forKey:@"content"];
    
    return dic2;
    
    
    
}

-(NSDictionary *)recommendConnection:(NSDictionary *)dic{
    
    NSArray *arr = dic[@"content"];
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *Dic in arr) {
        MTConnectionModel *model = [[MTConnectionModel alloc] initWithDictionary:Dic error:nil];
        [array addObject:model];
    }
    
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:array forKey:@"content"];
    
    return dic2;
 
    
}

-(NSDictionary *)recommendCompany:(NSDictionary *)dic{
    
    NSArray *arr = dic[@"content"];
    
       NSMutableArray *Array=[NSMutableArray array];
  
        for (NSDictionary *Dic in arr) {
            
            EPCloudListModel *Model=[[EPCloudListModel alloc]init];
            Model.company_id=[Dic[@"company_id"] intValue];
            Model.company_name=Dic[@"company_name"];
            
            NSString * str=Dic[@"company_image"];
            if (str.length>0) {
                
                NSArray *arr1=[self getJsonForString:str];
                NSMutableArray *imgArr=[[NSMutableArray alloc]initWithCapacity:arr1.count];
                
                for (NSDictionary * dic2 in arr1) {
                    MTPhotosModel * photoModel=[[MTPhotosModel alloc]initWithUrlDic:dic2];
                    [imgArr addObject:photoModel];
                }
                Model.imageArr=imgArr;
            }

            [Array addObject:Model];
        }

    
    
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
//    [dic2 setObject:array forKey:@"content"];
    [dic2 setObject:Array forKey:@"content2"];
    return dic2;
  
}

-(NSDictionary *)selectMyQuestionByUserId:(NSDictionary *)dic{
    
    NSArray *arr = dic[@"content"];
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *Dic in arr) {
        MyQuestionModel *model = [[MyQuestionModel alloc] initWithDictionary:Dic error:nil];
        [array addObject:model];
    }
    
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:array forKey:@"content"];
    
    return dic2;

}


-(NSDictionary *)selectNurseryDetailListByPage:(NSDictionary *)dic{
    
    NSArray *arr = dic[@"content"];
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *Dic in arr) {
        NurseryListModel *model = [[NurseryListModel alloc] initWithDictionary:Dic error:nil];
        NSMutableArray *Arr=[[NSMutableArray alloc]init];
        if (model.loading_price.length>0) {
            [Arr addObject:[NSString stringWithFormat:@"装车价: ￥%@",model.loading_price]];
        }
        if (model.num.length>0) {
            [Arr addObject:[NSString stringWithFormat:@"数量: %@株",model.num]];
        }
        if (model.heignt.length>0) {
            [Arr addObject:[NSString stringWithFormat:@"高度: %@cm",model.heignt]];
        }
        
        
        if (model.crown.length>0) {
            [Arr addObject:[NSString stringWithFormat:@"冠幅: %@cm",model.crown]];
        }
        if (model.diameter.length>0) {
            [Arr addObject:[NSString stringWithFormat:@"胸径: %@cm",model.diameter]];
        }
        if (model.branch_point.length>0) {
            [Arr addObject:[NSString stringWithFormat:@"分枝点: %@cm",model.branch_point]];
        }
        NurseryLabelView *labelView=[[NurseryLabelView alloc]init];
      CGFloat y=[labelView setDataWithArr:Arr];
        
        model.cellHeigh=[NSNumber numberWithFloat:340-111-68+y+(WindowWith-12*2-10+6)/3-6];
        
        [array addObject:model];
    }
    
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:array forKey:@"content"];
    
    return dic2;
    
}




@end
