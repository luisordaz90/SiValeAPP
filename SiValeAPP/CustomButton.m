//
//  CustomButton.m
//  SiValeAPP
//
//  Created by Luis Ordaz on 8/5/16.
//  Copyright © 2016 Luis Ordaz. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton


+ (instancetype)buttonWithType:(UIButtonType)buttonType {
    CustomButton *button = [super buttonWithType:buttonType];
    [button postButtonWithTypeInit];
    return button;
}

/// Because we can't override init on a uibutton, do init steps here.
- (void)postButtonWithTypeInit {
    //self = [[UIButton alloc] initWithFrame:CGRectMake(73.5, 142, 147, 30)];
    //[self initWithFrame:CGRectMake(73.5, 142, 147, 30)];
    self.layer.frame = CGRectMake(73.5, 142, 147, 30);
}
     
/// Make your button have a custom appearance when highlighted here.
- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
