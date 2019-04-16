//
//  AppDelegate.h
//  SkillExchange
//
//  Created by lfl on 15-3-3.
//  Copyright (c) 2015年 xubin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "EaseMob.h"
#import "LaunchPageView.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
//    EMConnectionState _connectionState;
    LaunchPageView *_launchView;
}

- (CGFloat)autoScaleW:(CGFloat)w;
- (CGFloat)autoScaleH:(CGFloat)h;

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, assign)CGFloat autoSizeScaleW;

//当前屏幕与设计尺寸(iPhone6)高度比例
@property (nonatomic, assign)CGFloat autoSizeScaleH;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
-(void)addSucessView:(NSString *)str type:(int)type;
+ (AppDelegate *)sharedAppDelegate;
@end

