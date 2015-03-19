//
//  MackenzieAppDelegate.m
//  Navigation
//
//  Created by Vinicius Miana on 2/21/14.
//  Copyright (c) 2014 Vinicius Miana. All rights reserved.
//

#import "MackenzieAppDelegate.h"
#import "LetrasTableViewController.h"
#import "BuscaViewController.h"

@implementation MackenzieAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    UITabBarController *tbc = [[UITabBarController alloc]init];
    
    tbc.view.backgroundColor = [UIColor whiteColor];
    tbc.tabBar.backgroundColor = [UIColor whiteColor];
    
    self.window = [[UIWindow alloc]
                   initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = tbc;


    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    BuscaViewController *viewController = [[BuscaViewController alloc]
                                           initWithNibName:nil
                                           bundle:nil];
    
    
    UINavigationController *navController = [[UINavigationController alloc]
                                             initWithRootViewController:viewController];
    navController.navigationBar.backgroundColor = [UIColor whiteColor];
    
    LetrasTableViewController *tvc = [[LetrasTableViewController alloc]init];
    
    navController.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Letras" image:nil tag:1];
    tvc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"TableView" image:nil tag:2];
    
    [tbc setViewControllers:[NSArray arrayWithObjects:navController, tvc, nil]];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
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
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
