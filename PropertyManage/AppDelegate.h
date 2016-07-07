//
//  AppDelegate.h
//  PropertyManage
//
//  Created by tianan-apple on 16/6/6.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AFNetworking.h"//网络请求三方
#import "loginInfo.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


/**
 *  当前经度
 */
@property (copy, nonatomic) NSString *currentLong;

/**
 *  当前纬度
 */
@property (copy, nonatomic) NSString *currentLat;

/**
 *  网络请求单例
 */
@property (strong, nonatomic) AFHTTPSessionManager *httpManager;

@property (strong, nonatomic) UITabBarController *tabBarViewController;
@property (assign, nonatomic) BOOL isLogin;
@property (strong, nonatomic) loginInfo *myLoginInfo;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

