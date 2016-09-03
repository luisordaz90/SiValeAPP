//
//  GenericSoapEnvFormatter.h
//  
//
//  Created by Luis Ordaz on 11/19/15.
//
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"
#import "GenericSoapEnv.h"

@interface GenericSoapEnvFormatter : NSObject
+(NSData *)login: (NSArray *) parameters;
+(NSData *)getBalances: (NSArray *) parameters;
+(NSData *)getTransactions: (NSArray *) parameters;
+(NSData *) genericSoapRequest: (NSString *)action parameters: (NSArray *) parameters;
@end
