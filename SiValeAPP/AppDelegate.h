//
//  AppDelegate.h
//  SiValeAPP
//
//  Created by Luis Ordaz on 7/5/15.
//  Copyright (c) 2015 Luis Ordaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountsViewController.h"
#import "AccountManager.h"
#import "DBManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) AccountsViewController *firstController;
@property (strong, nonatomic) UINavigationController *baseController;


@end

