//
//  DFDiscernListModel.h
//  DF
//
//  Created by Tata on 2017/12/1.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DFDiscernListModel : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *NickName;

@property (nonatomic, copy) NSString *HeadImage;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, copy) NSString *ImagePath;

@property (nonatomic, copy) NSString *CreateTime;

@property (nonatomic, strong) NSArray *CommentList;

@end
