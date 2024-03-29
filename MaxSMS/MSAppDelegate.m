//
//  MaxSMSAppDelegate.m
//  MaxSMS
//
//  Created by Maxwell Swadling on 28/11/10.
//  Copyright 2010 Maxwell Swadling. All rights reserved.
//

#import "MSAppDelegate.h"
#import "MSMainViewController.h"

@implementation MSAppDelegate


@synthesize window;
@synthesize mainViewController;
@synthesize sentFromText = _sentFromText;
@synthesize sentFromText2 = _sentFromText2;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.  
    
    // Add the main view controller's view to the window and display.
    mainViewController = (UITabBarController *) self.window.rootViewController;
  
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent
                                              animated:YES];
    
    UIImage* buttonImage =[[UIImage imageNamed:@"button.png"] stretchableImageWithLeftCapWidth:5.0 topCapHeight:0.0];
    
    [[UINavigationBar appearance] setBackgroundImage:buttonImage forBarMetrics:UIBarMetricsDefault];
    
    UITabBarController *tabbar = (UITabBarController *) mainViewController;
    
    [[tabbar tabBar] setBackgroundImage:buttonImage];
    [[tabbar tabBar] setTintColor:[UIColor whiteColor]];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


@end
