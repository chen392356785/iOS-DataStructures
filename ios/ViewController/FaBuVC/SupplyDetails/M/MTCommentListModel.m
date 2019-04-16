//
//	MTCommentListModel.m
//
//	Create by 招兵 董 on 12/4/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "MTCommentListModel.h"

NSString *const kMTCommentListModelBusnessId = @"busness_id";
NSString *const kMTCommentListModelCommentCotent = @"comment_cotent";
NSString *const kMTCommentListModelCommentId = @"comment_id";
NSString *const kMTCommentListModelCommentTime = @"comment_time";
NSString *const kMTCommentListModelCommentType = @"comment_type";
NSString *const kMTCommentListModelHeedImageUrl = @"heed_image_url";
NSString *const kMTCommentListModelReplyCommentId = @"reply_comment_id";
NSString *const kMTCommentListModelReplyNickname = @"reply_nickname";
NSString *const kMTCommentListModelReplyUserId = @"reply_user_id";
NSString *const kMTCommentListModelUserChildrenInfo = @"userChildrenInfo";
NSString *const kMTCommentListModelUserId = @"user_id";

@interface MTCommentListModel ()
@end
@implementation MTCommentListModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kMTCommentListModelBusnessId] isKindOfClass:[NSNull class]]){
		self.busnessId = [dictionary[kMTCommentListModelBusnessId] integerValue];
	}

	if(![dictionary[kMTCommentListModelCommentCotent] isKindOfClass:[NSNull class]]){
		self.commentCotent = dictionary[kMTCommentListModelCommentCotent];
	}	
	if(![dictionary[kMTCommentListModelCommentId] isKindOfClass:[NSNull class]]){
		self.commentId = [dictionary[kMTCommentListModelCommentId] integerValue];
	}

	if(![dictionary[kMTCommentListModelCommentTime] isKindOfClass:[NSNull class]]){
		self.commentTime = dictionary[kMTCommentListModelCommentTime];
	}	
	if(![dictionary[kMTCommentListModelCommentType] isKindOfClass:[NSNull class]]){
		self.commentType = [dictionary[kMTCommentListModelCommentType] integerValue];
	}

	if(![dictionary[kMTCommentListModelHeedImageUrl] isKindOfClass:[NSNull class]]){
		self.heedImageUrl = dictionary[kMTCommentListModelHeedImageUrl];
	}	
	if(![dictionary[kMTCommentListModelReplyCommentId] isKindOfClass:[NSNull class]]){
		self.replyCommentId = dictionary[kMTCommentListModelReplyCommentId];
	}	
	if(![dictionary[kMTCommentListModelReplyNickname] isKindOfClass:[NSNull class]]){
		self.replyNickname = dictionary[kMTCommentListModelReplyNickname];
	}	
	if(![dictionary[kMTCommentListModelReplyUserId] isKindOfClass:[NSNull class]]){
		self.replyUserId = [dictionary[kMTCommentListModelReplyUserId] integerValue];
	}

	if(![dictionary[kMTCommentListModelUserChildrenInfo] isKindOfClass:[NSNull class]]){
		self.userChildrenInfo = [[MTCommentUserInfo alloc] initWithDictionary:dictionary[kMTCommentListModelUserChildrenInfo]];
	}

	if(![dictionary[kMTCommentListModelUserId] isKindOfClass:[NSNull class]]){
		self.userId = [dictionary[kMTCommentListModelUserId] integerValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kMTCommentListModelBusnessId] = @(self.busnessId);
	if(self.commentCotent != nil){
		dictionary[kMTCommentListModelCommentCotent] = self.commentCotent;
	}
	dictionary[kMTCommentListModelCommentId] = @(self.commentId);
	if(self.commentTime != nil){
		dictionary[kMTCommentListModelCommentTime] = self.commentTime;
	}
	dictionary[kMTCommentListModelCommentType] = @(self.commentType);
	if(self.heedImageUrl != nil){
		dictionary[kMTCommentListModelHeedImageUrl] = self.heedImageUrl;
	}
	if(self.replyCommentId != nil){
		dictionary[kMTCommentListModelReplyCommentId] = self.replyCommentId;
	}
	if(self.replyNickname != nil){
		dictionary[kMTCommentListModelReplyNickname] = self.replyNickname;
	}
	dictionary[kMTCommentListModelReplyUserId] = @(self.replyUserId);
	if(self.userChildrenInfo != nil){
		dictionary[kMTCommentListModelUserChildrenInfo] = [self.userChildrenInfo toDictionary];
	}
	dictionary[kMTCommentListModelUserId] = @(self.userId);
	return dictionary;

}

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeObject:@(self.busnessId) forKey:kMTCommentListModelBusnessId];	if(self.commentCotent != nil){
		[aCoder encodeObject:self.commentCotent forKey:kMTCommentListModelCommentCotent];
	}
	[aCoder encodeObject:@(self.commentId) forKey:kMTCommentListModelCommentId];	if(self.commentTime != nil){
		[aCoder encodeObject:self.commentTime forKey:kMTCommentListModelCommentTime];
	}
	[aCoder encodeObject:@(self.commentType) forKey:kMTCommentListModelCommentType];	if(self.heedImageUrl != nil){
		[aCoder encodeObject:self.heedImageUrl forKey:kMTCommentListModelHeedImageUrl];
	}
	if(self.replyCommentId != nil){
		[aCoder encodeObject:self.replyCommentId forKey:kMTCommentListModelReplyCommentId];
	}
	if(self.replyNickname != nil){
		[aCoder encodeObject:self.replyNickname forKey:kMTCommentListModelReplyNickname];
	}
	[aCoder encodeObject:@(self.replyUserId) forKey:kMTCommentListModelReplyUserId];	if(self.userChildrenInfo != nil){
		[aCoder encodeObject:self.userChildrenInfo forKey:kMTCommentListModelUserChildrenInfo];
	}
	[aCoder encodeObject:@(self.userId) forKey:kMTCommentListModelUserId];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.busnessId = [[aDecoder decodeObjectForKey:kMTCommentListModelBusnessId] integerValue];
	self.commentCotent = [aDecoder decodeObjectForKey:kMTCommentListModelCommentCotent];
	self.commentId = [[aDecoder decodeObjectForKey:kMTCommentListModelCommentId] integerValue];
	self.commentTime = [aDecoder decodeObjectForKey:kMTCommentListModelCommentTime];
	self.commentType = [[aDecoder decodeObjectForKey:kMTCommentListModelCommentType] integerValue];
	self.heedImageUrl = [aDecoder decodeObjectForKey:kMTCommentListModelHeedImageUrl];
	self.replyCommentId = [aDecoder decodeObjectForKey:kMTCommentListModelReplyCommentId];
	self.replyNickname = [aDecoder decodeObjectForKey:kMTCommentListModelReplyNickname];
	self.replyUserId = [[aDecoder decodeObjectForKey:kMTCommentListModelReplyUserId] integerValue];
	self.userChildrenInfo = [aDecoder decodeObjectForKey:kMTCommentListModelUserChildrenInfo];
	self.userId = [[aDecoder decodeObjectForKey:kMTCommentListModelUserId] integerValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	MTCommentListModel *copy = [MTCommentListModel new];

	copy.busnessId = self.busnessId;
	copy.commentCotent = [self.commentCotent copy];
	copy.commentId = self.commentId;
	copy.commentTime = [self.commentTime copy];
	copy.commentType = self.commentType;
	copy.heedImageUrl = [self.heedImageUrl copy];
	copy.replyCommentId = [self.replyCommentId copy];
	copy.replyNickname = [self.replyNickname copy];
	copy.replyUserId = self.replyUserId;
	copy.userChildrenInfo = [self.userChildrenInfo copy];
	copy.userId = self.userId;

	return copy;
}
@end



NSString *const kUserChildrenInfoCity = @"city";
NSString *const kUserChildrenInfoCompanyArea = @"company_area";
NSString *const kUserChildrenInfoCompanyCity = @"company_city";
NSString *const kUserChildrenInfoCompanyLat = @"company_lat";
NSString *const kUserChildrenInfoCompanyLon = @"company_lon";
NSString *const kUserChildrenInfoCompanyName = @"company_name";
NSString *const kUserChildrenInfoCompanyProvince = @"company_province";
NSString *const kUserChildrenInfoCompanyStreet = @"company_street";
NSString *const kUserChildrenInfoDistance = @"distance";
NSString *const kUserChildrenInfoEmail = @"email";
NSString *const kUserChildrenInfoHeedImageUrl = @"heedImageUrl";
NSString *const kUserChildrenInfoHxUserName = @"hx_user_name";
NSString *const kUserChildrenInfoITypeId = @"i_type_id";
NSString *const kUserChildrenInfoIdentityKey = @"identity_key";
NSString *const kUserChildrenInfoIsVip = @"isVip";
NSString *const kUserChildrenInfoMobile = @"mobile";
NSString *const kUserChildrenInfoNickname = @"nickname";
NSString *const kUserChildrenInfoPosition = @"position";
NSString *const kUserChildrenInfoProvince = @"province";
NSString *const kUserChildrenInfoSexy = @"sexy";
NSString *const kUserChildrenInfoTitle = @"title";
NSString *const kUserChildrenInfoUserAuthentication = @"user_authentication";
NSString *const kUserChildrenInfoUserId = @"user_id";

@interface MTCommentUserInfo ()

@end

@implementation MTCommentUserInfo



/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kUserChildrenInfoCity] isKindOfClass:[NSNull class]]){
		self.city = dictionary[kUserChildrenInfoCity];
	}
	if(![dictionary[kUserChildrenInfoCompanyArea] isKindOfClass:[NSNull class]]){
		self.companyArea = dictionary[kUserChildrenInfoCompanyArea];
	}
	if(![dictionary[kUserChildrenInfoCompanyCity] isKindOfClass:[NSNull class]]){
		self.companyCity = dictionary[kUserChildrenInfoCompanyCity];
	}
	if(![dictionary[kUserChildrenInfoCompanyLat] isKindOfClass:[NSNull class]]){
		self.companyLat = [dictionary[kUserChildrenInfoCompanyLat] integerValue];
	}
	
	if(![dictionary[kUserChildrenInfoCompanyLon] isKindOfClass:[NSNull class]]){
		self.companyLon = [dictionary[kUserChildrenInfoCompanyLon] integerValue];
	}
	
	if(![dictionary[kUserChildrenInfoCompanyName] isKindOfClass:[NSNull class]]){
		self.companyName = dictionary[kUserChildrenInfoCompanyName];
	}
	if(![dictionary[kUserChildrenInfoCompanyProvince] isKindOfClass:[NSNull class]]){
		self.companyProvince = dictionary[kUserChildrenInfoCompanyProvince];
	}
	if(![dictionary[kUserChildrenInfoCompanyStreet] isKindOfClass:[NSNull class]]){
		self.companyStreet = dictionary[kUserChildrenInfoCompanyStreet];
	}
	if(![dictionary[kUserChildrenInfoDistance] isKindOfClass:[NSNull class]]){
		self.distance = [dictionary[kUserChildrenInfoDistance] integerValue];
	}
	
	if(![dictionary[kUserChildrenInfoEmail] isKindOfClass:[NSNull class]]){
		self.email = dictionary[kUserChildrenInfoEmail];
	}
	if(![dictionary[kUserChildrenInfoHeedImageUrl] isKindOfClass:[NSNull class]]){
		self.heedImageUrl = dictionary[kUserChildrenInfoHeedImageUrl];
	}
	if(![dictionary[kUserChildrenInfoHxUserName] isKindOfClass:[NSNull class]]){
		self.hxUserName = dictionary[kUserChildrenInfoHxUserName];
	}
	if(![dictionary[kUserChildrenInfoITypeId] isKindOfClass:[NSNull class]]){
		self.iTypeId = [dictionary[kUserChildrenInfoITypeId] integerValue];
	}
	
	if(![dictionary[kUserChildrenInfoIdentityKey] isKindOfClass:[NSNull class]]){
		self.identityKey = [dictionary[kUserChildrenInfoIdentityKey] integerValue];
	}
	
	if(![dictionary[kUserChildrenInfoIsVip] isKindOfClass:[NSNull class]]){
		self.isVip = [dictionary[kUserChildrenInfoIsVip] integerValue];
	}
	
	if(![dictionary[kUserChildrenInfoMobile] isKindOfClass:[NSNull class]]){
		self.mobile = dictionary[kUserChildrenInfoMobile];
	}
	if(![dictionary[kUserChildrenInfoNickname] isKindOfClass:[NSNull class]]){
		self.nickname = dictionary[kUserChildrenInfoNickname];
	}
	if(![dictionary[kUserChildrenInfoPosition] isKindOfClass:[NSNull class]]){
		self.position = dictionary[kUserChildrenInfoPosition];
	}
	if(![dictionary[kUserChildrenInfoProvince] isKindOfClass:[NSNull class]]){
		self.province = dictionary[kUserChildrenInfoProvince];
	}
	if(![dictionary[kUserChildrenInfoSexy] isKindOfClass:[NSNull class]]){
		self.sexy = [dictionary[kUserChildrenInfoSexy] integerValue];
	}
	
	if(![dictionary[kUserChildrenInfoTitle] isKindOfClass:[NSNull class]]){
		self.title = dictionary[kUserChildrenInfoTitle];
	}
	if(![dictionary[kUserChildrenInfoUserAuthentication] isKindOfClass:[NSNull class]]){
		self.userAuthentication = [dictionary[kUserChildrenInfoUserAuthentication] integerValue];
	}
	
	if(![dictionary[kUserChildrenInfoUserId] isKindOfClass:[NSNull class]]){
		self.userId = [dictionary[kUserChildrenInfoUserId] integerValue];
	}
	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.city != nil){
		dictionary[kUserChildrenInfoCity] = self.city;
	}
	if(self.companyArea != nil){
		dictionary[kUserChildrenInfoCompanyArea] = self.companyArea;
	}
	if(self.companyCity != nil){
		dictionary[kUserChildrenInfoCompanyCity] = self.companyCity;
	}
	dictionary[kUserChildrenInfoCompanyLat] = @(self.companyLat);
	dictionary[kUserChildrenInfoCompanyLon] = @(self.companyLon);
	if(self.companyName != nil){
		dictionary[kUserChildrenInfoCompanyName] = self.companyName;
	}
	if(self.companyProvince != nil){
		dictionary[kUserChildrenInfoCompanyProvince] = self.companyProvince;
	}
	if(self.companyStreet != nil){
		dictionary[kUserChildrenInfoCompanyStreet] = self.companyStreet;
	}
	dictionary[kUserChildrenInfoDistance] = @(self.distance);
	if(self.email != nil){
		dictionary[kUserChildrenInfoEmail] = self.email;
	}
	if(self.heedImageUrl != nil){
		dictionary[kUserChildrenInfoHeedImageUrl] = self.heedImageUrl;
	}
	if(self.hxUserName != nil){
		dictionary[kUserChildrenInfoHxUserName] = self.hxUserName;
	}
	dictionary[kUserChildrenInfoITypeId] = @(self.iTypeId);
	dictionary[kUserChildrenInfoIdentityKey] = @(self.identityKey);
	dictionary[kUserChildrenInfoIsVip] = @(self.isVip);
	if(self.mobile != nil){
		dictionary[kUserChildrenInfoMobile] = self.mobile;
	}
	if(self.nickname != nil){
		dictionary[kUserChildrenInfoNickname] = self.nickname;
	}
	if(self.position != nil){
		dictionary[kUserChildrenInfoPosition] = self.position;
	}
	if(self.province != nil){
		dictionary[kUserChildrenInfoProvince] = self.province;
	}
	dictionary[kUserChildrenInfoSexy] = @(self.sexy);
	if(self.title != nil){
		dictionary[kUserChildrenInfoTitle] = self.title;
	}
	dictionary[kUserChildrenInfoUserAuthentication] = @(self.userAuthentication);
	dictionary[kUserChildrenInfoUserId] = @(self.userId);
	return dictionary;
	
}

@end
