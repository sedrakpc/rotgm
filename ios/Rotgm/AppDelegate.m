//
//  AppDelegate.m
//  Citybus
//
//  Created by Sedrak Dalaloyan on 2/21/14.
//  Copyright (c) 2014 sedrakpc. All rights reserved.
//

#import "AppDelegate.h"
#import "SearchViewController.h"
#import "FavouritesViewController.h"
#import "Constants.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:@"ru_RU", nil] forKey:@"AppleLanguages"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //self.window.tintColor = DEFAULT_TINT_COLOR;
    //UITabBarController *tabBarController = [[UITabBarController alloc] init];
    //tabBarController.tabBar.translucent = NO;
    SearchViewController *searchVC = [[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
    UINavigationController *searchNavController = [[UINavigationController alloc] initWithRootViewController:searchVC];
    searchNavController.navigationBar.translucent = NO;
    searchNavController.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:1];
    //searchNavController.edgesForExtendedLayout = UIRectEdgeNone;
    //searchNavController.automaticallyAdjustsScrollViewInsets = NO;
    //navController.navigationBar.barTintColor = DEFAULT_TINT_COLOR;
    //[[UILabel appearanceWhenContainedIn:[UISearchBar class], nil] setTextColor:[UIColor redColor]];

    
    //FavouritesViewController *favouritesVC = [[FavouritesViewController alloc] initWithNibName:@"FavouritesViewController" bundle:nil];
//    UINavigationController *favouritesNavController = [[UINavigationController alloc] initWithRootViewController:favouritesVC];
    //favouritesNavController.navigationBar.translucent = NO;
    //favouritesNavController.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:0];
    
    
    //tabBarController.viewControllers = @[favouritesNavController, searchNavController];
    //tabBarController.selectedIndex = 1;
    self.window.rootViewController = searchNavController;
    [self.window makeKeyAndVisible];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{

}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:@"ru_RU", nil] forKey:@"AppleLanguages"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
