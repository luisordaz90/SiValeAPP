//
//  AccountCellTableViewCell.m
//  SiValeAPP
//
//  Created by Luis Ordaz on 7/6/15.
//  Copyright (c) 2015 Luis Ordaz. All rights reserved.
//

#import "AccountCellTableViewCell.h"

@implementation AccountCellTableViewCell



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        CGFloat cardHolderWidth = [CommonMethods getScreenDimensions].width - 26;
        _whiteRoundedCornerView = [[UIView alloc] initWithFrame:CGRectMake(13,0,cardHolderWidth,190)];
        _refreshBttn = [[UIButton alloc] initWithFrame:CGRectMake(cardHolderWidth/4, 142, cardHolderWidth/2, 30)];
        _refreshBttn.showsTouchWhenHighlighted = YES;
        _whiteRoundedCornerView.layer.cornerRadius = 10;
        _whiteRoundedCornerView.backgroundColor = [CommonMethods colorFromHexString:@"#1b99d5" andAlpha:NO];
        _whiteRoundedCornerView.layer.masksToBounds = NO;
        _refreshBttn.layer.cornerRadius = 5;
        [_refreshBttn addTarget:self action:@selector(reloadCardData:) forControlEvents:UIControlEventTouchUpInside];
        [_refreshBttn setBackgroundColor:[CommonMethods colorFromHexString:@"#45b3e7" andAlpha:NO]];
        [_refreshBttn setAttributedTitle:[CommonMethods createAttrString:@"Actualizar" withFont:@"Avenir-Heavy" withSize:14 andColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        _cardAlias = [[UILabel alloc] init];
        _cardNumber = [[UILabel alloc] init];
        _cardBalance = [[UILabel alloc] init];
        _lastLogin = [[UILabel alloc] init];
        [_whiteRoundedCornerView addSubview: _cardAlias];
        [_whiteRoundedCornerView addSubview: _cardNumber];
        [_whiteRoundedCornerView addSubview: _cardBalance];
        [_whiteRoundedCornerView addSubview: _lastLogin];
        [_whiteRoundedCornerView addSubview: _refreshBttn];
        [self.contentView addSubview: _whiteRoundedCornerView];
        [self.contentView sendSubviewToBack: _whiteRoundedCornerView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void) setCardIdentifier:(NSString *)cardIdentifier{
    _cardIdentifier = cardIdentifier;
}

-(void)reloadCardData: (id) sender{
    if([self.delegate respondsToSelector:@selector(reloadCardBalance:)])
    {
        [self.delegate reloadCardBalance: self];
    }
}

-(void)repaintButton: (id) sender{
    [_refreshBttn setBackgroundColor:[CommonMethods colorFromHexString:@"#45b3e7" andAlpha:NO]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void) setCardAliasLabel: (NSString *) string{
    
    NSAttributedString *inputString = [CommonMethods createAttrString:string withFont:@"Avenir-Heavy" withSize:14 andColor:[UIColor blackColor]];
    CGSize frameSize = [inputString size];
    
    _cardAlias.frame = CGRectMake((self.whiteRoundedCornerView.frame.size.width/2) - frameSize.width/2, 8, frameSize.width, frameSize.height);
    
    _cardAlias.attributedText = inputString;
    
}

- (void) setCardNumberLabel: (NSString *) string{
    
    string = [@"****-****-****-" stringByAppendingString:[string substringFromIndex:12]];
    
    NSAttributedString *inputString = [CommonMethods createAttrString:string withFont:@"Avenir-Heavy" withSize:14 andColor:[UIColor blackColor]];
    CGSize frameSize = [inputString size];
    
    _cardNumber.frame = CGRectMake((self.whiteRoundedCornerView.frame.size.width/2) - frameSize.width/2, 84, frameSize.width, frameSize.height);
    
    _cardNumber.attributedText = inputString;
    
}

- (void) setCardBalanceLabel: (NSString *) string{
    
    string = [@"$" stringByAppendingString:string];
    
    NSAttributedString *inputString = [CommonMethods createAttrString:string withFont:@"Avenir-Heavy" withSize:32 andColor:[UIColor blackColor]];
    CGSize frameSize = [inputString size];
    
    _cardBalance.frame = CGRectMake((self.whiteRoundedCornerView.frame.size.width/2) - frameSize.width/2, 35, frameSize.width, frameSize.height);
    
    _cardBalance.attributedText = inputString;
    
}

-(void) setLastLoginLabel: (NSString *) string{
    string = [@"Último acceso: " stringByAppendingString:string];
    
    NSAttributedString *inputString = [CommonMethods createAttrString:string withFont:@"Avenir-Heavy" withSize:14 andColor:[UIColor blackColor]];
    CGSize frameSize = [inputString size];
    
    _lastLogin.frame = CGRectMake((self.whiteRoundedCornerView.frame.size.width/2) - frameSize.width/2, 110, frameSize.width, frameSize.height);
    
    _lastLogin.attributedText = inputString;
}

@end
