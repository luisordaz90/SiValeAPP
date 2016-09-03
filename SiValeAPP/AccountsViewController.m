//
//  LoginViewController.m
//  SiValeAPP
//
//  Created by Luis Ordaz on 7/5/15.
//  Copyright (c) 2015 Luis Ordaz. All rights reserved.
//

#import "AccountsViewController.h"
#import <Crashlytics/Crashlytics.h>


@interface AccountsViewController ()

@property Boolean requestHasFinished;
@property DBManager *dbManager;
@property AccountManager *accounts;
@property CGSize screenDimensions;

@end

@implementation AccountsViewController

- (void)viewDidLoad {
    _screenDimensions = [CommonMethods getScreenDimensions];
    [_accountTable setFrame: CGRectMake(_accountTable.frame.origin.x, _accountTable.frame.origin.y, _screenDimensions.width, _screenDimensions.height - 74)];
    [_backgroundImage setFrame: CGRectMake(_backgroundImage.frame.origin.x, _backgroundImage.frame.origin.y, _screenDimensions.width, _screenDimensions.height)];
    [_placeholder setFrame:CGRectMake(_screenDimensions.width/2 - _placeholder.frame.size.width/2, _screenDimensions.height/2 - _placeholder.frame.size.height/2, _placeholder.frame.size.width, _placeholder.frame.size.height)];
    [super viewDidLoad];
    [CommonMethods initNavController:self withTitle:@"Inicio"];
    [self.navigationItem setRightBarButtonItem: [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"gear.png"] style:UIBarButtonItemStylePlain target:self action: @selector(addNewCard)]];
    self.accountTable.hidden = YES;
    _requestHasFinished = YES;
    _accounts = [AccountManager sharedManager];
    _dbManager = [DBManager sharedManager];
    self.accountTable.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    if([[_accounts getAccounts] count] && [_accounts getModificationStatus]){
        [_accounts setModification: NO];
        [self.accountTable reloadData];
        self.accountTable.hidden = NO;
        self.placeholder.hidden = YES;
    }
}

-(void)viewDidAppear:(BOOL)animated{
    
}

-(void)reloadCardSummary: (accountData *) account{
    //[[Crashlytics sharedInstance] crash];
    if(_requestHasFinished){
        UIView *loading = [CommonMethods generateLoadingView:CGRectMake(_screenDimensions.width/2 - 40, (_accountTable.frame.size.height/2 ) , 80, 80) andIndicatorDimensions:CGRectMake(21.5, 21.5, 37, 37) andAlpha:YES];
        [self.view addSubview:loading];
        [iOSRequest generalRequest:[GenericSoapEnvFormatter genericSoapRequest:@"getBalances" parameters:[NSArray arrayWithObjects: [account getSessionId], nil]] forAction:@"balances" onCompletion:^(NSDictionary *session){
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"reloadCardSummary Log: %@", session);
                if([session objectForKey:@"cveError"]){
                    NSLog(@"reloadCardSummary Log: Error %@ -> %@",[session objectForKey:@"cveError"], [session objectForKey:@"descError"]);
                }
                else
                    if([session objectForKey:@"saldo"]){
                        [account setLastLogin:[CommonMethods formattedDateString:[NSDate date]]];
                        [account setBalance:[session objectForKey:@"saldo"]];
                        [_accounts updateAccounts:account andKey:[account getAlias]];
                        [_dbManager.handler executeQuery:[NSString stringWithFormat:@"UPDATE available_accounts SET balance = %@, last_update = '%@' WHERE card_number = '%@'",[NSDecimalNumber decimalNumberWithString:[account getBalance]],[account getLastLogin], [account getCardNumber]]];
                        [self.accountTable reloadData];
                        _requestHasFinished = YES;
                    }
                    else
                        if(session == nil){
                            NSLog(@"reloadCardSummary Log: No connection");
                        _requestHasFinished = YES;
                        }
                        else{
                            NSLog(@"reloadCardSummary Log: SESSION expired, re-new session ticket");
                            _requestHasFinished = YES;
                            [self renewSessionTicket: account];
                        }
                [loading removeFromSuperview];
            });
        }];
        _requestHasFinished = NO;
    }
    else{
        NSLog(@"reloadCardSummary Log: Request pending, PLEASE WAIT...");
    }

}

-(void)renewSessionTicket: (accountData *) account{
    if(_requestHasFinished){
        UIView *loading = [CommonMethods generateLoadingView:CGRectMake(_screenDimensions.width/2 - 40, (_accountTable.frame.size.height/2 ) , 80, 80) andIndicatorDimensions:CGRectMake(21.5, 21.5, 37, 37) andAlpha:YES];
        [self.view addSubview:loading];
        [iOSRequest generalRequest:[GenericSoapEnvFormatter genericSoapRequest:@"login" parameters:[NSArray arrayWithObjects: @"",[account getCardNumber],[account getPassword],@"M", nil]] forAction:@"login" onCompletion:^(NSDictionary *session){
            NSLog(@"renewSessionTicket Log: %@",session);
            dispatch_async(dispatch_get_main_queue(), ^{
                if([[session objectForKey:@"cveError"] isEqualToString:@"0"]){
                    [account setSessionId:[session objectForKey: @"idSesion"]];
                    [_dbManager.handler executeQuery:[NSString stringWithFormat:@"UPDATE available_accounts SET SESSION_ID = %@, last_update = '%@' WHERE card_number = '%@'",[account getSessionId],[account getLastLogin], [account getCardNumber]]];
                    _requestHasFinished = YES;
                    [self reloadCardSummary: account];
                }
                else
                    if(session == nil){
                        NSLog(@"renewSessionTicket Log: No connection");
                        _requestHasFinished = YES;
                    }
                    else{
                        if([session objectForKey:@"cveError"]){
                            NSLog(@"renewSessionTicket Log: error %@ -> %@",[session objectForKey:@"cveError"], [session objectForKey:@"descError"]);
                        }
                        _requestHasFinished = YES;
                    }
                [loading removeFromSuperview];
            });
            
        }];
        _requestHasFinished = NO;
    }
    else{
        NSLog(@"renewSessionTicket Log: Request pending, PLEASE WAIT...");
    }
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addNewCard{
    
    self.addAccntView = [[AddAccntViewController alloc] initWithNibName:@"AddAccntViewController" bundle:nil];
    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"Atrás"
                                     style:UIBarButtonItemStylePlain
                                    target:nil
                                    action:nil];
    [self.navigationController pushViewController:self.addAccntView animated: YES];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_accounts.availableAccounts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    NSString *currKey = [[[_accounts getAccounts] allKeys] objectAtIndex:indexPath.row];

    AccountCellTableViewCell *cell = (AccountCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[AccountCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    accountData *currAccount = [[_accounts getAccounts] objectForKey:currKey];
    cell.delegate = self;
    [cell setCardIdentifier:currKey];
    [cell setCardAliasLabel: currKey];
    [cell setCardBalanceLabel:[currAccount getBalance]];
    [cell setCardNumberLabel:[currAccount getCardNumber]];
    [cell setLastLoginLabel:[currAccount getLastLogin]];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 210;
}

-(void)reloadCardBalance: (UITableViewCell *)cell{
    
    [self reloadCardSummary:[[_accounts getAccounts] objectForKey:((AccountCellTableViewCell *)cell).cardIdentifier]];
    
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
