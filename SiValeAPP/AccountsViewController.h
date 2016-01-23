//
//  LoginViewController.h
//  SiValeAPP
//
//  Created by Luis Ordaz on 7/5/15.
//  Copyright (c) 2015 Luis Ordaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountCellTableViewCell.h"
#import "iOSRequest.h"
#import "CommonMethods.h"
#import "AddAccntViewController.h"
#import "GDataXMLNode.h"
#import "GenericSoapEnv.h"
#import "GenericSoapEnvFormatter.h"


@interface AccountsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *accountTable;
@property (strong,nonatomic) AddAccntViewController *addAccntView;

@end
