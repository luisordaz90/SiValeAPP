//
//  accountData.h
//  
//
//  Created by Luis Ordaz on 3/16/16.
//
//

#import <Foundation/Foundation.h>

@interface accountData : NSObject
@property (strong, nonatomic) NSString * cardNumber;
@property (strong, nonatomic) NSString * password;
@property (strong, nonatomic) NSString * sessionId;
@property (strong, nonatomic) NSString * balance;
@property (strong, nonatomic) NSString * alias;
@property (strong, nonatomic) NSString * lastLogin;

-(id) initWithData: (NSString *) alias cardNumber: (NSString *) cardNumber  password: (NSString *) password sessionId: (NSString *) sessionId;
-(void)setCardNumber: (NSString *)cardNumber;
-(NSString *)getCardNumber;
-(void)setPassword:(NSString *)password;
-(NSString *)getPassword;
-(void)setSessionId:(NSString *)sessionId;
-(NSString *)getSessionId;
-(void)setBalance: (NSString *)balance;
-(NSString *)getBalance;
-(void)setAlias: (NSString *)alias;
-(NSString *)getAlias;
-(void)setLastLogin:(NSString *)lastLogin;
-(NSString *)getLastLogin;
@end
