//
//  EditInformationDelegate.h
//  MiaoTuProject
//
//  Created by 任雨浓 on 16/3/24.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EditInformationDelegate <NSObject>

@optional

-(void)displayTiyle:(NSString *)title
			   type:(EditBlock)type;

-(void)displayAdress:(NSString *)adress
				city:(NSString *)city
			province:(NSString *)province
				town:(NSString *)town
			latitude:(CGFloat)latitude
		   longitude:(CGFloat)longitude;

@end
