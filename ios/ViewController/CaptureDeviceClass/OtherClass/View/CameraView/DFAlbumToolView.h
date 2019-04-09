//
//  DFAlbumToolView.h
//  DF
//
//  Created by Tata on 2017/11/22.
//  Copyright © 2017年 Tata. All rights reserved.
//

#import "ClassyLiveLayout.h"

@protocol DFAlbumToolDelegate <NSObject>

- (void)reselectPhoto;

- (void)confirmPhoto;

@end

@interface DFAlbumToolView : SHPAbstractView

@property (nonatomic, weak) id <DFAlbumToolDelegate> delegate;

@end
