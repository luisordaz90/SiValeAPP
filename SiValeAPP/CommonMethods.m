//
//  CommonMethods.m
//  SiValeAPP
//
//  Created by Luis Ordaz on 7/8/15.
//  Copyright (c) 2015 Luis Ordaz. All rights reserved.
//

#import "CommonMethods.h"

@implementation CommonMethods

+ (UIColor *)colorFromHexString:(NSString *)hexString andAlpha: (BOOL) alpha{
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    if(!alpha)
        return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
    else
        return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:0.6];
}

+(void)initNavController:(UIViewController *)viewController withTitle:(NSString *)title{
    UILabel *navTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 15, 20)];
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName : [UIFont fontWithName:@"Avenir-Black" size:16], NSForegroundColorAttributeName : [UIColor whiteColor]}];
    //UIBarButtonItem *logo = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"pcloud-logo.png"] style:UIBarButtonItemStylePlain target:self action: nil];
    //UIBarButtonItem *gear = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"gear.png"] style:UIBarButtonItemStylePlain target:self action: nil];
    //logo.tintColor = [UIColor whiteColor];
    //gear.tintColor = [UIColor whiteColor];
    navTitle.attributedText = attString;
    viewController.navigationController.navigationBar.barTintColor = [CommonMethods colorFromHexString:@"#103f91" andAlpha:NO];
    //[viewController.navigationItem setLeftBarButtonItem:logo];
    //[viewController.navigationItem setRightBarButtonItem:gear];
    [viewController.navigationItem setTitleView: navTitle];
    
}
@end
