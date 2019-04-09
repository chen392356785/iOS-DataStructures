//
//  HomSearchModel.h
//  MiaoTuProject
//
//  Created by tinghua on 2018/9/21.
//  Copyright © 2018年 听花科技. All rights reserved.
//

#import "JSONModel.h"

@interface HomSearchModel : JSONModel

@property (nonatomic,copy) NSString <Optional> *address;
@property (nonatomic,copy) NSString <Optional> *fensicount;
@property (nonatomic,copy) NSString <Optional> *hImage;
@property (nonatomic,copy) NSString <Optional> *imageUrl;
@property (nonatomic,copy) NSString <Optional> *mobile;
@property (nonatomic,copy) NSString <Optional> *nickname;
@property (nonatomic,copy) NSString <Optional> *num;
@property (nonatomic,copy) NSString <Optional> *other_id;
@property (nonatomic,copy) NSString <Optional> *page;
@property (nonatomic,copy) NSString <Optional> *qiyeimageUrl;
@property (nonatomic,copy) NSString <Optional> *tid;
@property (nonatomic,copy) NSString <Optional> *title;
@property (nonatomic,copy) NSString <Optional> *type;
@property (nonatomic,copy) NSString <Optional> *user_id;
@end
