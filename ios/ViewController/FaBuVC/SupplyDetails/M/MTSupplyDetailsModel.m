//
//	MTSupplyDetailsModel.m
//
//	Create by 招兵 董 on 12/4/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "MTSupplyDetailsModel.h"

NSString *const kMTSupplyDetailsModelAddress = @"address";
NSString *const kMTSupplyDetailsModelBranchPoint = @"branch_point";
NSString *const kMTSupplyDetailsModelClickLikeTotal = @"clickLikeTotal";
NSString *const kMTSupplyDetailsModelCollectionTotal = @"collectionTotal";
NSString *const kMTSupplyDetailsModelCommentTotal = @"commentTotal";
NSString *const kMTSupplyDetailsModelCrownWidthE = @"crown_width_e";
NSString *const kMTSupplyDetailsModelCrownWidthS = @"crown_width_s";
NSString *const kMTSupplyDetailsModelHasClickLike = @"hasClickLike";
NSString *const kMTSupplyDetailsModelHasCollection = @"hasCollection";
NSString *const kMTSupplyDetailsModelHeightE = @"height_e";
NSString *const kMTSupplyDetailsModelHeightS = @"height_s";
NSString *const kMTSupplyDetailsModelNumber = @"number";
NSString *const kMTSupplyDetailsModelRodDiameter = @"rod_diameter";
NSString *const kMTSupplyDetailsModelSeedlingSourceAddress = @"seedling_source_address";
NSString *const kMTSupplyDetailsModelSellingPoint = @"selling_point";
NSString *const kMTSupplyDetailsModelShareTotal = @"shareTotal";
NSString *const kMTSupplyDetailsModelSupplyUrl = @"supply_url";
NSString *const kMTSupplyDetailsModelSupplyId = @"supply_id";
NSString *const kMTSupplyDetailsModelUnitPrice = @"unit_price";
NSString *const kMTSupplyDetailsModelUnivalent = @"univalent";
NSString *const kMTSupplyDetailsModelUploadtime = @"uploadtime";
NSString *const kMTSupplyDetailsModelUserChildrenInfo = @"userChildrenInfo";
NSString *const kMTSupplyDetailsModelVarieties = @"varieties";
NSInteger const kMaxImageCount = 9;

@interface MTSupplyDetailsModel ()

@end

@implementation MTSupplyDetailsModel

/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kMTSupplyDetailsModelAddress] isKindOfClass:[NSNull class]]){
		self.address = dictionary[kMTSupplyDetailsModelAddress];
	}
	if(![dictionary[kMTSupplyDetailsModelBranchPoint] isKindOfClass:[NSNull class]]){
		self.branchPoint = [dictionary[kMTSupplyDetailsModelBranchPoint] integerValue];
	}
	
	if(![dictionary[kMTSupplyDetailsModelClickLikeTotal] isKindOfClass:[NSNull class]]){
		self.clickLikeTotal = [dictionary[kMTSupplyDetailsModelClickLikeTotal] integerValue];
	}
	
	if(![dictionary[kMTSupplyDetailsModelCollectionTotal] isKindOfClass:[NSNull class]]){
		self.collectionTotal = [dictionary[kMTSupplyDetailsModelCollectionTotal] integerValue];
	}
	
	if(![dictionary[kMTSupplyDetailsModelCommentTotal] isKindOfClass:[NSNull class]]){
		self.commentTotal = [dictionary[kMTSupplyDetailsModelCommentTotal] integerValue];
	}
	
	if(![dictionary[kMTSupplyDetailsModelCrownWidthE] isKindOfClass:[NSNull class]]){
		self.crownWidthE = [dictionary[kMTSupplyDetailsModelCrownWidthE] integerValue];
	}
	
	if(![dictionary[kMTSupplyDetailsModelCrownWidthS] isKindOfClass:[NSNull class]]){
		self.crownWidthS = [dictionary[kMTSupplyDetailsModelCrownWidthS] integerValue];
	}
	
	if(![dictionary[kMTSupplyDetailsModelHasClickLike] isKindOfClass:[NSNull class]]){
		self.hasClickLike = [dictionary[kMTSupplyDetailsModelHasClickLike] integerValue];
	}
	
	if(![dictionary[kMTSupplyDetailsModelHasCollection] isKindOfClass:[NSNull class]]){
		self.hasCollection = [dictionary[kMTSupplyDetailsModelHasCollection] integerValue];
	}
	
	if(![dictionary[kMTSupplyDetailsModelHeightE] isKindOfClass:[NSNull class]]){
		self.heightE = [dictionary[kMTSupplyDetailsModelHeightE] integerValue];
	}
	
	if(![dictionary[kMTSupplyDetailsModelHeightS] isKindOfClass:[NSNull class]]){
		self.heightS = [dictionary[kMTSupplyDetailsModelHeightS] integerValue];
	}
	
	if(![dictionary[kMTSupplyDetailsModelNumber] isKindOfClass:[NSNull class]]){
		self.number = [dictionary[kMTSupplyDetailsModelNumber] integerValue];
	}
	
	if(![dictionary[kMTSupplyDetailsModelRodDiameter] isKindOfClass:[NSNull class]]){
		self.rodDiameter = [dictionary[kMTSupplyDetailsModelRodDiameter] floatValue];
	}
	
	if(![dictionary[kMTSupplyDetailsModelSeedlingSourceAddress] isKindOfClass:[NSNull class]]){
		self.seedlingSourceAddress = dictionary[kMTSupplyDetailsModelSeedlingSourceAddress];
	}
	if(![dictionary[kMTSupplyDetailsModelSellingPoint] isKindOfClass:[NSNull class]]){
		self.sellingPoint = dictionary[kMTSupplyDetailsModelSellingPoint];
	}
	if(![dictionary[kMTSupplyDetailsModelShareTotal] isKindOfClass:[NSNull class]]){
		self.shareTotal = [dictionary[kMTSupplyDetailsModelShareTotal] integerValue];
	}
	
	if(![dictionary[kMTSupplyDetailsModelSupplyUrl] isKindOfClass:[NSNull class]]){
		self.supplyUrl = dictionary[kMTSupplyDetailsModelSupplyUrl];
	}
	if(![dictionary[kMTSupplyDetailsModelSupplyId] isKindOfClass:[NSNull class]]){
		self.supplyId = [dictionary[kMTSupplyDetailsModelSupplyId] integerValue];
	}
	
	if(![dictionary[kMTSupplyDetailsModelUnitPrice] isKindOfClass:[NSNull class]]){
		self.unitPrice = [dictionary[kMTSupplyDetailsModelUnitPrice] floatValue];
	}
	
	if(![dictionary[kMTSupplyDetailsModelUnivalent] isKindOfClass:[NSNull class]]){
		self.univalent = dictionary[kMTSupplyDetailsModelUnivalent];
	}
	if(![dictionary[kMTSupplyDetailsModelUploadtime] isKindOfClass:[NSNull class]]){
		self.uploadtime = dictionary[kMTSupplyDetailsModelUploadtime];
	}
	if(![dictionary[kMTSupplyDetailsModelUserChildrenInfo] isKindOfClass:[NSNull class]]){
		self.userChildrenInfo = [[MTSupplyUserInfo alloc] initWithDictionary:dictionary[kMTSupplyDetailsModelUserChildrenInfo]];
	}
	
	if(![dictionary[kMTSupplyDetailsModelVarieties] isKindOfClass:[NSNull class]]){
		self.varieties = dictionary[kMTSupplyDetailsModelVarieties];
	}
	
	self.contacts = dictionary[@"contacts"];
	self.contactsMobile = dictionary[@"contactsMobile"];
	self.companyName = dictionary[@"companyName"];
	self.companyAddress = dictionary[@"companyAddress"];
	self.spec = dictionary[@"spec"];
	self.density = dictionary[@"density"];
	self.hasTrunk = dictionary[@"hasTrunk"];
	self.type = dictionary[@"type"];
	self.model = dictionary[@"model"];
	self.culturalMethod = dictionary[@"culturalMethod"];
	self.specUnit = dictionary[@"specUnit"];
	self.unit = dictionary[@"unit"];
	self.soilBallDress = dictionary[@"soilBallDress"];
	self.soilBall = dictionary[@"soilBall"];
	self.raiseMethod = dictionary[@"raiseMethod"];
	self.safeguard = dictionary[@"safeguard"];
	self.soilBallSize = dictionary[@"soilBallSize"];
	self.soilThickness = dictionary[@"soilThickness"];
	self.soilBallShape = dictionary[@"soilBallShape"];
	self.insectPest = dictionary[@"insectPest"];
	self.trim = dictionary[@"trim"];
	self.waterFertilizer = dictionary[@"waterFertilizer"];
	self.loadLift = dictionary[@"loadLift"];
	self.roadWay = dictionary[@"roadWay"];
	self.remark = dictionary[@"remark"];
	
	NSData *josnData = [_supplyUrl dataUsingEncoding:NSUTF8StringEncoding];
	NSArray *tempArray = [NSJSONSerialization JSONObjectWithData:josnData options:NSJSONReadingMutableContainers error:NULL];
	_imageArray = [tempArray valueForKey:@"t_url"];
	
	CGFloat viewWidth = iPhoneWidth - 26.0f;
	CGFloat buttonWidth = 0.0f;
	CGFloat buttonHeight = 0.0f;
	NSInteger imageCount = _imageArray.count;
	CGRect buttonFrame = CGRectZero;
	if (imageCount == 1) {
		buttonWidth = viewWidth;
		buttonHeight = 219.0f;
		(self.imageButtonFrames[0]) = CGRectMake(0.0f, 0.0f, buttonWidth, buttonHeight);
		buttonFrame = (_imageButtonFrames[0]);
	} else if (imageCount == 2) {
		buttonWidth = (viewWidth-10) *0.5f;
		buttonHeight = buttonWidth;
		(self.imageButtonFrames[0]) = CGRectMake(0.0f, 0.0f,buttonWidth, buttonHeight);
		(self.imageButtonFrames[1]) = CGRectMake(buttonWidth+10.0f, 0.0f,buttonWidth, buttonHeight);
		buttonFrame = (self.imageButtonFrames[0]);
	} else {
		
		buttonWidth = (viewWidth-20.0f)/3.0f;
		buttonHeight = buttonWidth;
		for (int i = 0; i<kMaxImageCount; i++) {
			if (i < tempArray.count) {
				// 图片所在行
				NSInteger row = i / 3;
				// 图片所在列
				NSInteger col = i % 3;
				CGFloat margin = 10.0f;
				// PointX
				CGFloat picX = 0.0f + (buttonWidth + margin) * col;
				// PointY
				CGFloat picY = 0.0f + (buttonHeight + margin) * row;
				buttonFrame = CGRectMake(picX, picY, buttonWidth, buttonHeight);
				self.imageButtonFrames[i] = buttonFrame;
			} else {
				self.imageButtonFrames[i] = CGRectZero;
			}
		}
		
	}
	
	_imageContainerHeight = CGRectGetMaxY(buttonFrame);
	CGSize size = [_remark boundingRectWithSize:CGSizeMake(viewWidth,1000.0f) options:0 attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13.0f]} context:NULL].size;
	CGFloat remarkHeight = MAX(20.0f,size.height);
	
	_rowHeight = _imageContainerHeight + remarkHeight + 780.0f;
	
	return self;
}

- (CGRect *)imageButtonFrames {
	if (_imageButtonFrames == NULL) {
		_imageButtonFrames = (CGRect *)malloc(sizeof(CGRect) * kMaxImageCount);
	}
	return _imageButtonFrames;
}

- (void)dealloc
{
	if (_imageButtonFrames != NULL) {
		free(_imageButtonFrames);
	}
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


@implementation MTSupplyUserInfo

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



@end

