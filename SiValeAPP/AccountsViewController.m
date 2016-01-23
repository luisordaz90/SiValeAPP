//
//  LoginViewController.m
//  SiValeAPP
//
//  Created by Luis Ordaz on 7/5/15.
//  Copyright (c) 2015 Luis Ordaz. All rights reserved.
//

#import "AccountsViewController.h"

@interface AccountsViewController ()

@property (nonatomic, strong) NSMutableDictionary *accounts;


@end

NSArray *dummyArray;

@implementation AccountsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [CommonMethods initNavController:self withTitle:@"Inicio"];
    [self.navigationItem setRightBarButtonItem: [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"gear.png"] style:UIBarButtonItemStylePlain target:self action: @selector(agregarNuevaTarjeta)]];
    self.accountTable.hidden = YES;
    NSLog(@"CANTIDAD: %lu", (unsigned long)[self.navigationController.viewControllers count]);
    
}

-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"CANTIDAD: %lu", (unsigned long)[self.navigationController.viewControllers count]);
    //if([self.accounts count] > 0){
        self.accountTable.hidden = YES;
        [iOSRequest generalRequest:[GenericSoapEnvFormatter genericSoapRequest:@"login" parameters:[NSArray arrayWithObjects: @"",@"5230130100509161",@"tumama88",@"M", nil]] forAction:@"login" onCompletion:^(NSDictionary *session){
        dispatch_async(dispatch_get_main_queue(), ^{
            self.accounts = [[NSMutableDictionary alloc] initWithDictionary: session];
           NSLog(@"SESSION: %@",session);
           NSLog(@"%@", [session objectForKey:@"nomTarjeta"]);
           NSLog(@"%@", [session objectForKey:@"numTarjeta"]);
            [self.accountTable reloadData];
            self.accountTable.hidden = NO;
            [self getCurrentBalance];
        });
        }];
        
   // }
}

-(void)viewDidAppear:(BOOL)animated{

}

-(void)getCurrentBalance{
    [iOSRequest generalRequest:[GenericSoapEnvFormatter genericSoapRequest:@"getTransactions" parameters:[NSArray arrayWithObjects: [self.accounts objectForKey:@"idSesion"] , nil]] forAction:nil onCompletion:^(NSDictionary *session){
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"SESSION: %@",session);
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)agregarNuevaTarjeta{
    self.addAccntView = [[AddAccntViewController alloc] initWithNibName:@"AddAccntViewController" bundle:nil];
    [self.navigationController pushViewController:self.addAccntView animated: YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.accounts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    AccountCellTableViewCell *cell = (AccountCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[AccountCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
   cell.firstTitle.attributedText = [[NSAttributedString alloc] initWithString:[self.accounts objectForKey:@"numTarjeta"] attributes:@{NSFontAttributeName :[UIFont fontWithName:@"HelveticaNeue-Light" size: 12], NSForegroundColorAttributeName :[UIColor blackColor]}];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
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
