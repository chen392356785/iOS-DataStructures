//
//	MTSupplyDetailsModel.h
//
//	Create by 招兵 董 on 12/4/2019
//	Copyright © 2019. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@class MTSupplyUserInfo;

/**
 供应详情实体
 */
@interface MTSupplyDetailsModel : NSObject

@property (nonatomic, strong) NSString * address;
@property (nonatomic, assign) NSInteger branchPoint;
@property (nonatomic, assign) NSInteger clickLikeTotal;
@property (nonatomic, assign) NSInteger collectionTotal;
@property (nonatomic, assign) NSInteger commentTotal;
@property (nonatomic, assign) NSInteger crownWidthE;
@property (nonatomic, assign) NSInteger crownWidthS;
@property (nonatomic, assign) NSInteger hasClickLike;
@property (nonatomic, assign) NSInteger hasCollection;
@property (nonatomic, assign) NSInteger heightE;
@property (nonatomic, assign) NSInteger heightS;
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, assign) CGFloat rodDiameter;
@property (nonatomic, strong) NSString * seedlingSourceAddress;
@property (nonatomic, strong) NSString * sellingPoint;
@property (nonatomic, assign) NSInteger shareTotal;
@property (nonatomic, strong) NSString * supplyUrl;
@property (nonatomic, assign) NSInteger supplyId;
@property (nonatomic, assign) CGFloat unitPrice;
@property (nonatomic, strong) NSString * univalent;
@property (nonatomic, strong) NSString * uploadtime;
///contacts
@property (nonatomic,copy) NSString *contacts;
///contactsMobile
@property (nonatomic,copy) NSString *contactsMobile;
///companyAddress
@property (nonatomic,copy) NSString *companyAddress;
///companyName
@property (nonatomic,copy) NSString *companyName;
///spec
@property (nonatomic,copy) NSString *spec;
///density
@property (nonatomic,copy) NSString *density;
///hasTrunk
@property (nonatomic,copy) NSString *hasTrunk;
///type
@property (nonatomic,copy) NSString *type;
///model
@property (nonatomic,copy) NSString *model;
///culturalMethod
@property (nonatomic,copy) NSString *culturalMethod;
///specUnit
@property (nonatomic,copy) NSString *specUnit;
///unit
@property (nonatomic,copy) NSString *unit;

///soilBallDress
@property (nonatomic,copy) NSString *soilBallDress;
///soilBall
@property (nonatomic,copy) NSString *soilBall;
///raiseMethod
@property (nonatomic,copy) NSString *raiseMethod;
///safeguard
@property (nonatomic,copy) NSString *safeguard;
///soilBallSize
@property (nonatomic,copy) NSString *soilBallSize;
///soilThickness
@property (nonatomic,copy) NSString *soilThickness;
///soilBallShape
@property (nonatomic,copy) NSString *soilBallShape;
///insectPest
@property (nonatomic,copy) NSString *insectPest;
///trim
@property (nonatomic,copy) NSString *trim;
///waterFertilizer
@property (nonatomic,copy) NSString *waterFertilizer;
///loadLift
@property (nonatomic,copy) NSString *loadLift;
///roadWay
@property (nonatomic,copy) NSString *roadWay;
///remark
@property (nonatomic,copy) NSString *remark;
@property (nonatomic, strong) NSString * varieties;


@property (nonatomic, strong) MTSupplyUserInfo * userChildrenInfo;


-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

///rowHeight
@property (nonatomic,assign,readonly) CGFloat rowHeight;
///imageContainerH
@property (nonatomic,assign,readonly) CGFloat imageContainerHeight;
///imageArray
@property (nonatomic,strong,readonly) NSArray <NSString *> *imageArray;
///imageButtonFrames
@property (nonatomic,assign) CGRect *imageButtonFrames;

@end


/**
 供应详情用户资料
 */
@interface MTSupplyUserInfo : NSObject

@property (nonatomic, strong) NSString * city;
@property (nonatomic, strong) NSString * companyArea;
@property (nonatomic, strong) NSString * companyCity;
@property (nonatomic, assign) NSInteger companyLat;
@property (nonatomic, assign) NSInteger companyLon;
@property (nonatomic, strong) NSString * companyName;
@property (nonatomic, strong) NSString * companyProvince;
@property (nonatomic, strong) NSString * companyStreet;
@property (nonatomic, assign) NSInteger distance;
@property (nonatomic, strong) NSString * email;
@property (nonatomic, strong) NSString * heedImageUrl;
@property (nonatomic, strong) NSString * hxUserName;
@property (nonatomic, assign) NSInteger iTypeId;
@property (nonatomic, assign) NSInteger identityKey;
@property (nonatomic, assign) NSInteger isVip;
@property (nonatomic, strong) NSString * mobile;
@property (nonatomic, strong) NSString * nickname;
@property (nonatomic, strong) NSString * position;
@property (nonatomic, strong) NSString * province;
@property (nonatomic, assign) NSInteger sexy;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, assign) NSInteger userAuthentication;
@property (nonatomic, assign) NSInteger userId;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
