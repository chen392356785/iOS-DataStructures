//
//  DFPhotoToolView.h
//  DF
//
//  Created by Tata on 2017/11/21.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "ClassyLiveLayout.h"

@protocol DFPhotoToolDelegate <NSObject>

- (void)takePhotos;

- (void)checkAlbum;

- (void)changeCamera;

@end

@interface DFPhotoToolView : SHPAbstractView

@property (nonatomic, weak) id <DFPhotoToolDelegate> delegate;

@end
