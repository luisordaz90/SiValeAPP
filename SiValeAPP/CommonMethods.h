//
//  CommonMethods.h
//  SiValeAPP
//
//  Created by Luis Ordaz on 7/8/15.
//  Copyright (c) 2015 Luis Ordaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface CommonMethods : NSObject

+(void) initNavController: (UIViewController *) navController withTitle: (NSString *)title;
+(NSAttributedString *)createAttrString: (NSString *) text withFont: (NSString *) font withSize: (CGFloat) size andColor: (UIColor *) color;
+(NSString *)formattedDateString: (NSDate *) currDate;
+(UIColor *)colorFromHexString:(NSString *)hexString andAlpha: (BOOL) alpha;
+(UIView *)generateLoadingView: (CGRect) dimensions andIndicatorDimensions:(CGRect)indicator_dimensions andAlpha: (BOOL) alpha;
+(CGSize) getScreenDimensions;
@end
