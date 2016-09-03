//
//  accountData.m
//  
//
//  Created by Luis Ordaz on 3/16/16.
//
//

#import "accountData.h"

@implementation accountData
-(id)init {
    return [self initWithData:nil cardNumber: nil password:nil sessionId:nil];
}

-(id) initWithData: (NSString *) alias cardNumber:(NSString *) cardNumber  password: (NSString *) password sessionId: (NSString *) sessionId{
    _alias = alias;
    _cardNumber = cardNumber;
    _password = password;
    _sessionId = sessionId;
    return self;
}

-(void)setCardNumber: (NSString *)cardNumber{
    _cardNumber = cardNumber;
}

-(NSString *)getCardNumber{
    return _cardNumber;
}

-(void)setPassword:(NSString *)password{
    _password = password;
}

-(NSString *)getPassword{
    return _password;
}

-(void)setSessionId:(NSString *)sessionId{
    _sessionId = sessionId;
}

-(NSString *)getSessionId{
    return _sessionId;
}

-(void)setBalance: (NSString *)balance{
    _balance = balance;
}

-(NSString *)getBalance{
    return _balance;
}

-(void)setAlias: (NSString *)alias{
    _alias = alias;
}

-(NSString *)getAlias{
    return _alias;
}

-(void)setLastLogin: (NSString *)lastLogin{
    _lastLogin = lastLogin;
}

-(NSString *)getLastLogin{
    return _lastLogin;
}



@end
