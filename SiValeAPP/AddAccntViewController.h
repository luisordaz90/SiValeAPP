//
//  AddAccntViewController.h
//  SiValeAPP
//
//  Created by Luis Ordaz on 7/8/15.
//  Copyright (c) 2015 Luis Ordaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iOSRequest.h"
#import "CommonMethods.h"
#import "AccountManager.h"
#import "GenericSoapEnvFormatter.h"
#import "accountData.h"
#import "iOSRequest.h"
#import "DBManager.h"

@interface AddAccntViewController : UIViewController <UITextViewDelegate>

@property (strong, nonatomic) UITextField *cardAlias;
@property (strong, nonatomic)  UITextField *cardNumber;
@property (strong, nonatomic)  UITextField *password;
@property (strong, nonatomic)  UILabel *lblCardAlias;
@property (strong, nonatomic)  UILabel *lblPassword;
@property (strong, nonatomic)  UILabel *lblCardNumber;
@property (strong, nonatomic)  UIView *container;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (strong, nonatomic) UIButton *registerButton;
- (IBAction)validateInformation:(id)sender;

@end
