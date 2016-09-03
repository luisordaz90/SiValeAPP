//
//  AccountCellTableViewCell.h
//  SiValeAPP
//
//  Created by Luis Ordaz on 7/6/15.
//  Copyright (c) 2015 Luis Ordaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonMethods.h"

@protocol AccountCellTouch <NSObject>
@optional
-(void)reloadCardBalance: (UITableViewCell *)cell;
@end

@interface AccountCellTableViewCell : UITableViewCell
@property (weak, nonatomic) id<AccountCellTouch> delegate;
@property (strong, nonatomic) UILabel *cardAlias;
@property (strong, nonatomic) UILabel *cardNumber;
@property (strong, nonatomic) UILabel *cardBalance;
@property (strong, nonatomic) UILabel *lastLogin;
@property (strong, nonatomic) NSString *cardIdentifier;
@property (strong,nonatomic) UIButton *refreshBttn;
@property (strong, nonatomic) UIView *whiteRoundedCornerView;
-(void) setCardAliasLabel: (NSString *) string;
-(void) setCardBalanceLabel: (NSString *) string;
-(void) setCardNumberLabel: (NSString *) string;
-(void) setLastLoginLabel: (NSString *) string;

@end
