//
//  LoginViewController.h
//  SiValeAPP
//
//  Created by Luis Ordaz on 7/5/15.
//  Copyright (c) 2015 Luis Ordaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountCellTableViewCell.h"
#import "AddAccntViewController.h"
#import "GenericSoapEnvFormatter.h"
#import "accountData.h"
#import "iOSRequest.h"
#import "CommonMethods.h"
#import "AccountManager.h"

@interface AccountsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, AccountCellTouch>
@property (weak, nonatomic) IBOutlet UITableView *accountTable;
@property (weak, nonatomic) IBOutlet UIImageView *placeholder;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (strong,nonatomic) AddAccntViewController *addAccntView;

@end
