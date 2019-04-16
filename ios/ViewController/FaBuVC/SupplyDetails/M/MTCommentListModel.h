//
//	MTCommentListModel.h
//
//	Create by 招兵 董 on 12/4/2019
//	Copyright © 2019. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@class MTCommentUserInfo;

@interface MTCommentListModel : NSObject

@property (nonatomic, assign) NSInteger busnessId;
@property (nonatomic, strong) NSString * commentCotent;
@property (nonatomic, assign) NSInteger commentId;
@property (nonatomic, strong) NSString * commentTime;
@property (nonatomic, assign) NSInteger commentType;
@property (nonatomic, strong) NSString * heedImageUrl;
@property (nonatomic, strong) NSString * replyCommentId;
@property (nonatomic, strong) NSString * replyNickname;
@property (nonatomic, assign) NSInteger replyUserId;
@property (nonatomic, strong) MTCommentUserInfo * userChildrenInfo;
@property (nonatomic, assign) NSInteger userId;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end


@interface MTCommentUserInfo : NSObject

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

-(NSDictionary *)toDictionary;

@end
