//
//  StdRootController.m
//  StdFirstApp
//
//  Created by tianan-apple on 15/10/14.
//  Copyright (c) 2015年 tianan-apple. All rights reserved.
//

#import "StdRootController.h"
#import "PublicDefine.h"
#import "HomeViewController.h"
#import "NoticeViewController.h"
#import "ContactsViewController.h"
#import "SettingViewController.h"


@implementation StdRootController
-(void)SetUpStdRootView:(UITabBarController *)rootTab
{
    HomeViewController *homeViewController = [[HomeViewController alloc]init];
    homeViewController.view.backgroundColor = MyGrayColor;
    
    NoticeViewController *noticeViewController = [[NoticeViewController alloc]init];
    noticeViewController.view.backgroundColor = MyGrayColor;
    
    ContactsViewController *contactsViewController = [[ContactsViewController alloc]init];
    contactsViewController.view.backgroundColor = MyGrayColor;
    
    SettingViewController *settingViewController = [[SettingViewController alloc]init];
    settingViewController.view.backgroundColor = MyGrayColor;
    
  
    
    UINavigationController *home = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    
    UINavigationController *notice = [[UINavigationController alloc] initWithRootViewController:noticeViewController];
    
    UINavigationController *contacts = [[UINavigationController alloc] initWithRootViewController:contactsViewController];
    
    UINavigationController *setting = [[UINavigationController alloc] initWithRootViewController:settingViewController];

    rootTab.viewControllers = [NSArray arrayWithObjects:home, notice,contacts,setting, nil];
    
    rootTab.tabBar.frame=CGRectMake(0, fDeviceHeight-MainTabbarHeight, fDeviceWidth, MainTabbarHeight);
    
    
    for (UINavigationController *stack in rootTab.viewControllers) {
        [self setupNavigationBar:stack];
    }
   
    
    rootTab.tabBar.barStyle=UIBarStyleDefault;
    rootTab.tabBar.translucent=false;
    rootTab.tabBar.tintColor=tabTxtColor;
   
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    //NSLog(@"123123");
//    int index = viewController.selectedIndex;
//    NSString *titleName = nil;
//    switch (index) {
//        case 0:
//            titleName = @"FirstView";
//            break;
//        case 1:
//            titleName = @"SecondView";
//            break;
//        case 2:
//            titleName = @"ThirdView";
//            break;
//            
//        default:
//            break;
//    }
}

- (void)setupNavigationBar:(UINavigationController *)stack{
    UIImage *barImage = [UIImage imageNamed:@"redtop.png"];
    if(IOS7_OR_LATER)
        [stack.navigationBar setBackgroundImage:barImage forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    else
        [stack.navigationBar setBackgroundImage:barImage forBarMetrics:UIBarMetricsDefault];
    
}
@end
