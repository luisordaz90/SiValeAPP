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
        UIView *whiteRoundedCornerView = [[UIView alloc] initWithFrame:CGRectMake(13,0,294,120)];
        _firstTitle = [[UILabel alloc] initWithFrame:CGRectMake(17, 7, 269, 21)];
        //_messageTextView = [[UILabel alloc] initWithFrame:CGRectMake(17, 7, 269, 21)];
        whiteRoundedCornerView.backgroundColor = [UIColor grayColor];
        whiteRoundedCornerView.layer.masksToBounds = NO;
        [whiteRoundedCornerView addSubview: _firstTitle];
        [self.contentView addSubview:whiteRoundedCornerView];
        [self.contentView sendSubviewToBack:whiteRoundedCornerView];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
