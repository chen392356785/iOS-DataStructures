//
//  FabuBuyModel.h
//  MiaoTuProject
//
//  Created by Tomorrow on 2019/3/30.
//  Copyright © 2019 听花科技. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@interface FabuBuyModel : JSONModel

@property (nonatomic, copy) NSString <Optional> * supplyurl;
@property (nonatomic, copy) NSString <Optional> * userId;
@property (nonatomic, copy) NSString <Optional> * companyId;   //    公司苗圃ID
@property (nonatomic, copy) NSString <Optional> * companyname; //    公司/苗圃名称
@property (nonatomic, copy) NSString <Optional> * plantType;   //    主营品种类型id
@property (nonatomic, copy) NSString <Optional> * varieties;//主营品种名称
@property (nonatomic, copy) NSString <Optional> * number;//数量
@property (nonatomic, copy) NSString <Optional> * unit;//数量单位
@property (nonatomic, copy) NSString <Optional> * raiseMethod;//培育方式
@property (nonatomic, copy) NSString <Optional> * windPoint;//分支点
@property (nonatomic, copy) NSString <Optional> * height;//高度
@property (nonatomic, copy) NSString <Optional> * crownWidth;//冠幅
@property (nonatomic, copy) NSString <Optional> * spec;//规格
@property (nonatomic, copy) NSString <Optional> * specJson;//规格json
@property (nonatomic, copy) NSString <Optional> * univalent;//单价
@property (nonatomic, copy) NSString <Optional> * type;//种类
@property (nonatomic, copy) NSString <Optional> * soilBall;//球土质
@property (nonatomic, copy) NSString <Optional> * insectPest;//病虫害
@property (nonatomic, copy) NSString <Optional> * culturalMethod;//栽培方式
@property (nonatomic, copy) NSString <Optional> * density;//    茂密度
@property (nonatomic, copy) NSString <Optional> * hasTrunk;//有无明显主杆
@property (nonatomic, copy) NSString <Optional> * urgencyLevelId;//    栽培方式
@property (nonatomic, copy) NSString <Optional> * model;//    造型
@property (nonatomic, copy) NSString <Optional> * soilBallDress;//土球起挖包扎
@property (nonatomic, copy) NSString <Optional> * safeguard;//保护措施
@property (nonatomic, copy) NSString <Optional> * soilBallSize;//土球直径
@property (nonatomic, copy) NSString <Optional> * soilThickness;//土球厚度
@property (nonatomic, copy) NSString <Optional> * soilBallShape;//土球形状
@property (nonatomic, copy) NSString <Optional> * trim;//育苗器是否做过收支的修剪
@property (nonatomic, copy) NSString <Optional> * waterFertilizer;//水肥
@property (nonatomic, copy) NSString <Optional> * loadLift;//装车起吊技术
@property (nonatomic, copy) NSString <Optional> * roadWay;//苗圃内转运及道路方便程度



@end



@interface FabuQiuGModel : JSONModel                //
@property (nonatomic, copy) NSString <Optional> * userId;               //用户id
@property (nonatomic, copy) NSString <Optional> * plantType;                //品种类型id
@property (nonatomic, copy) NSString <Optional> * varieties;                //品种类型名称
@property (nonatomic, copy) NSString <Optional> * number;               //数量
@property (nonatomic, copy) NSString <Optional> * unit;             //数量单位
@property (nonatomic, copy) NSString <Optional> * companyName;              //公司/苗圃名称
@property (nonatomic, copy) NSString <Optional> * companyId;                //公司/苗圃id
@property (nonatomic, copy) NSString <Optional> * windPoint;                //分枝点
@property (nonatomic, copy) NSString <Optional> * height;               //高度
@property (nonatomic, copy) NSString <Optional> * crownWidth;               //冠幅
@property (nonatomic, copy) NSString <Optional> * spec;             //规格
@property (nonatomic, copy) NSString <Optional> * specJson;             //    规格json
@property (nonatomic, copy) NSString <Optional> * univalent;                //单价
@property (nonatomic, copy) NSString <Optional> * paymentMethodsDictionaryId;               //付款方式
@property (nonatomic, copy) NSString <Optional> * urgencyLevelId;               //紧张程度
@property (nonatomic, copy) NSString <Optional> * miningArea;               //    采苗区域
@property (nonatomic, copy) NSString <Optional> * useMiningArea;                //用苗区域
@property (nonatomic, copy) NSString <Optional> * infoActive;               //求购信息时效
@property (nonatomic, copy) NSString <Optional> * timeunit;               //求购信息时效单位
@property (nonatomic, copy) NSString <Optional> * wantBuyUrl;               //求购图片
@property (nonatomic, copy) NSString <Optional> * wantbuyMasterUrl;             //    求购缩略图
@end                //
