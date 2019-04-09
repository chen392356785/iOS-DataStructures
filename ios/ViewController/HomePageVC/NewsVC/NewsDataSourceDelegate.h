//
//  NewsDataSourceDelegate.h
//  MiaoTuProject
//
//  Created by Zmh on 30/6/16.
//  Copyright © 2016年 xubin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NewsDataSourceDelegate <NSObject>

@optional

- (void)disPalyNewsCollect:(NewsListModel *)model indexPath:(NSIndexPath *)indexPath;

@end

@protocol ImageScrollDelegate <NSObject>

- (void)scrollImage:(int)index;

@end
