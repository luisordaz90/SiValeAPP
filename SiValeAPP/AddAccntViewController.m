//
//  AddAccntViewController.m
//  SiValeAPP
//
//  Created by Luis Ordaz on 7/8/15.
//  Copyright (c) 2015 Luis Ordaz. All rights reserved.
//

#import "AddAccntViewController.h"

@interface AddAccntViewController ()

@end

@implementation AddAccntViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [CommonMethods initNavController:self withTitle:@"Añada tarjeta"];
    NSLog(@"CANTIDAD: %lu", (unsigned long)[self.navigationController.viewControllers count]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
