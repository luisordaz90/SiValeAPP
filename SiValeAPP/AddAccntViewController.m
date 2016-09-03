//
//  AddAccntViewController.m
//  SiValeAPP
//
//  Created by Luis Ordaz on 7/8/15.
//  Copyright (c) 2015 Luis Ordaz. All rights reserved.
//

#import "AddAccntViewController.h"

@interface AddAccntViewController ()

@property DBManager *dbManager;
@property AccountManager *accounts;
@property CGSize screenDimensions;
@property accountData *account;

@end

@implementation AddAccntViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [CommonMethods initNavController:self withTitle:@"Añada tarjeta"];
    _accounts = [AccountManager sharedManager];
    _dbManager = [DBManager sharedManager];
    _screenDimensions = [CommonMethods getScreenDimensions];
    [_backgroundImage setFrame: CGRectMake(_backgroundImage.frame.origin.x, _backgroundImage.frame.origin.y, _screenDimensions.width, _screenDimensions.height)];
    NSAttributedString *genericString = [CommonMethods createAttrString:@"Alias:" withFont:@"Avenir-Heavy" withSize:17 andColor:[UIColor whiteColor]];
    _container = [[UIView alloc] initWithFrame:CGRectMake(_screenDimensions.width/2 - 100, _screenDimensions.height * 0.17, 200, 310)];
    _container.backgroundColor = [UIColor clearColor];
    _lblCardAlias = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, genericString.size.width, genericString.size.height)];
    _lblCardAlias.attributedText = genericString;
    _cardAlias = [[UITextField alloc] initWithFrame:CGRectMake(0, _lblCardAlias.frame.origin.y + 24, 200, 30)];
    _cardAlias.backgroundColor = [UIColor whiteColor];
    _cardAlias.layer.cornerRadius = 5;
    genericString = [CommonMethods createAttrString:@"Número de tarjeta:" withFont:@"Avenir-Heavy" withSize:17 andColor:[UIColor whiteColor]];
    _lblCardNumber = [[UILabel alloc] initWithFrame:CGRectMake(0, _cardAlias.frame.origin.y + 40, genericString.size.width,genericString.size.height )];
    _lblCardNumber.attributedText = genericString;
    _cardNumber = [[UITextField alloc] initWithFrame:CGRectMake(0, _lblCardNumber.frame.origin.y + 24, 200, 30)];
    _cardNumber.keyboardType = UIKeyboardTypeNumberPad;
    _cardNumber.secureTextEntry = YES;
    _cardNumber.backgroundColor = [UIColor whiteColor];
    _cardNumber.layer.cornerRadius = 5;
    genericString = [CommonMethods createAttrString:@"Contraseña:" withFont:@"Avenir-Heavy" withSize:17 andColor:[UIColor whiteColor]];
    _lblPassword = [[UILabel alloc] initWithFrame:CGRectMake(0, _cardNumber.frame.origin.y + 40, genericString.size.width,genericString.size.height )];
    _lblPassword.attributedText = genericString;
    _password = [[UITextField alloc] initWithFrame:CGRectMake(0, _lblPassword.frame.origin.y + 24, 200, 30)];
    _password.secureTextEntry = YES;
    _password.backgroundColor = [UIColor whiteColor];
    _password.layer.cornerRadius = 5;
    _registerButton = [[UIButton alloc] initWithFrame:CGRectMake(_container.frame.size.width/2 - 90, _password.frame.origin.y + 50, 180, 30)];
    _registerButton.showsTouchWhenHighlighted = YES;
    _registerButton.layer.cornerRadius = 5;
    [_registerButton addTarget:self action:@selector(validateInformation:) forControlEvents:UIControlEventTouchUpInside];
    [_registerButton setBackgroundColor:[CommonMethods colorFromHexString:@"#45b3e7" andAlpha:NO]];
    [_registerButton setAttributedTitle:[CommonMethods createAttrString:@"Listo!" withFont:@"Avenir-Heavy" withSize:14 andColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [_container addSubview:_lblCardAlias];
    [_container addSubview:_cardAlias];
    [_container addSubview:_lblCardNumber];
    [_container addSubview:_cardNumber];
    [_container addSubview:_lblPassword];
    [_container addSubview:_password];
    [_container addSubview:_registerButton];
    [self.view addSubview:_container];
    UIControl *viewControl = (UIControl*)self.view;
    [viewControl addTarget:self action:@selector(dismissKeyboard) forControlEvents:UIControlEventTouchDown];
    
}

-(void)prepareAccountInfo: (NSString *)sessionID{
    UIView *loading = [CommonMethods generateLoadingView:CGRectMake(_screenDimensions.width/2 - 40, (_screenDimensions.height/2 + 40) , 80, 80) andIndicatorDimensions:CGRectMake(21.5, 21.5, 37, 37) andAlpha:YES];
    [self.view addSubview:loading];
    [iOSRequest generalRequest:[GenericSoapEnvFormatter genericSoapRequest:@"getBalances" parameters:[NSArray arrayWithObjects: sessionID, nil]] forAction:@"balances" onCompletion:^(NSDictionary *session){
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"prepareAccountInfo Log: %@", session);
            if([session objectForKey:@"saldo"]){
                [_account setBalance:[session objectForKey:@"saldo"]];
                [_account setLastLogin:[CommonMethods formattedDateString:[NSDate date]]];
                [_accounts updateAccounts:_account andKey:_cardAlias.text];
                [_dbManager.handler executeQuery:[NSString stringWithFormat:@"INSERT INTO available_accounts (CARD_NUMBER, PASSWORD, ALIAS, BALANCE, SESSION_ID, LAST_UPDATE) values ('%@','%@','%@',%@,'%@','%@')",[_account getCardNumber], [_account getPassword],[_account getAlias],[NSDecimalNumber decimalNumberWithString:[_account getBalance]],[_account getSessionId],[_account getLastLogin]]];
                if (_dbManager.handler.affectedRows != 0) {
                    NSLog(@"Query was executed successfully. Affected rows = %d", _dbManager.handler.affectedRows);
                }
                else{
                    NSLog(@"Could not execute the query.");
                }
                [_accounts setModification:YES];
                [self.navigationController popViewControllerAnimated:YES];
            }
            else{
                NSLog(@"ERROR");
            }
            [loading removeFromSuperview];
        });
    }];
}

- (IBAction)validateInformation:(id)sender {
    [self dismissKeyboard];
    if([[_accounts getAccounts] objectForKey:_cardAlias.text] == nil){
        UIView *loading = [CommonMethods generateLoadingView:CGRectMake(_screenDimensions.width/2 - 40, (_screenDimensions.height/2 + 40) , 80, 80) andIndicatorDimensions:CGRectMake(21.5, 21.5, 37, 37) andAlpha:YES];
        [self.view addSubview:loading];
        [iOSRequest generalRequest:[GenericSoapEnvFormatter genericSoapRequest:@"login" parameters:[NSArray arrayWithObjects: @"",_cardNumber.text,_password.text,@"M", nil]] forAction:@"login" onCompletion:^(NSDictionary *session){
            NSLog(@"validateInformation Log: %@",session);
            dispatch_async(dispatch_get_main_queue(), ^{
                if([[session objectForKey:@"cveError"] isEqualToString:@"0"]){
                    _account = [[accountData alloc] initWithData: _cardAlias.text cardNumber: [session objectForKey:@"numTarjeta"] password:_password.text sessionId:[session objectForKey:@"idSesion"]];
                    [self prepareAccountInfo:[session objectForKey:@"idSesion"]];
                }
                else{
                    NSLog(@"ERROR");
                }
                [loading removeFromSuperview];
            });
        }];
    }
    else{
        NSLog(@"ERROR");
    }
}

-(void)dismissKeyboard{
    [_cardAlias resignFirstResponder];
    [_cardNumber resignFirstResponder];
    [_password resignFirstResponder];
    NSLog(@"RESIGN");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textViewDidChange:(UITextView *)textView{
    
    // 3rd set the new enterd text as attributed string to textview
    [textView setAttributedText:[CommonMethods createAttrString:textView.text withFont:@"Avenir-Heavy" withSize:14 andColor:[UIColor blackColor]]];

}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
