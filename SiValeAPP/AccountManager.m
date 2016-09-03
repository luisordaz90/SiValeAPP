//
//  AccountManager.m
//  SiValeAPP
//
//  Created by Luis Ordaz on 7/21/16.
//  Copyright © 2016 Luis Ordaz. All rights reserved.
//

#import "AccountManager.h"

@implementation AccountManager

//@synthesize availableAccounts;

#pragma mark Singleton Methods

+ (id)sharedManager {
    static AccountManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        _availableAccounts = [[NSMutableDictionary alloc] init];
        _modified = YES;
    }
    return self;
}

-(void)setModification: (Boolean) mod{
    _modified = mod;
}


-(void)updateAccounts: (NSObject *) account andKey: (NSString *) key{
    [_availableAccounts setObject:account forKey: key];
    [self setModification:YES];
}

-(NSMutableDictionary *)getAccounts{
    return _availableAccounts;
}

-(Boolean)getModificationStatus{
    return _modified;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}


@end
