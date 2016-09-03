//
//  AppDelegate.m
//  SiValeAPP
//
//  Created by Luis Ordaz on 7/5/15.
//  Copyright (c) 2015 Luis Ordaz. All rights reserved.
//

#import "AppDelegate.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

@interface AppDelegate ()

@property DBManager *dbManager;
@property AccountManager *accounts;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Fabric with:@[[Crashlytics class]]];
    // TODO: Move this to where you establish a user session
    [self logUser];
    // Override point for customization after application launch.
    
    _accounts = [AccountManager sharedManager];
    _dbManager = [DBManager sharedManager];
    
    NSArray *accountArray = [_dbManager.handler loadDataFromDB:@"SELECT CARD_NUMBER, PASSWORD, ALIAS, BALANCE, SESSION_ID, LAST_UPDATE FROM available_accounts"];
    //NSLog(@"%@", accountArray);
    if( [accountArray count]> 0){
        for( int i = 0; i < [accountArray count]; i++){
            accountData *account = [[accountData alloc] init];
            [account setCardNumber:[[accountArray objectAtIndex:i] objectAtIndex:0]];
            [account setPassword:[[accountArray objectAtIndex:i] objectAtIndex:1]];
            [account setAlias:[[accountArray objectAtIndex:i] objectAtIndex:2]];
            [account setBalance:[[accountArray objectAtIndex:i] objectAtIndex:3]];
            [account setSessionId:[[accountArray objectAtIndex:i] objectAtIndex:4]];
            [account setLastLogin:[[accountArray objectAtIndex:i] objectAtIndex:5]];
            [_accounts updateAccounts:account andKey:[account getAlias]];
        }
    }
    
    //NSLog(@"AppDelegate: available Accounts - %@",[_accounts getAccounts]);
    
    _firstController = [[AccountsViewController alloc] init];
    _baseController = [[UINavigationController alloc] initWithRootViewController:_firstController];
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _window.rootViewController = _baseController;
    [_window makeKeyAndVisible];
    return YES;
}

- (void) logUser {
    // TODO: Use the current user's information
    // You can call any combination of these three methods
    [CrashlyticsKit setUserIdentifier:@"12345"];
    [CrashlyticsKit setUserEmail:@"user@fabric.io"];
    [CrashlyticsKit setUserName:@"Test User"];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
