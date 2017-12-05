//
//  AppDelegate.m
//  ONE
//
//  Created by 崔一鸣 on 2017/10/1.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import "AppDelegate.h"
#import "ONEHomeViewController.h"
#import "ONEMineViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ONEHomeViewController *homeView = [[ONEHomeViewController alloc] init];
    ONEMineViewController *mineView = [[ONEMineViewController alloc] init];
    
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:homeView];
    UINavigationController *movieNav = [[UINavigationController alloc] initWithRootViewController:mineView];
    
    NSArray *array = [NSArray arrayWithObjects:@"首页", @"我的", nil];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.edgesForExtendedLayout = UIRectEdgeNone;
    tabBarController.viewControllers = [NSArray arrayWithObjects:homeNav, movieNav, nil];
    int i = 0;
    for (UITabBarItem *item in tabBarController.tabBar.items) {
        item.title = array[i++];
    }
    
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
