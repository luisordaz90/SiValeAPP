//
//  AccountManager.h
//  SiValeAPP
//
//  Created by Luis Ordaz on 7/21/16.
//  Copyright © 2016 Luis Ordaz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountManager : NSObject

@property (nonatomic, retain) NSMutableDictionary *availableAccounts;
@property Boolean modified;

+ (id)sharedManager;
-(void)updateAccounts: (NSObject *) account andKey: (NSString *) key;
-(NSMutableDictionary *)getAccounts;
-(void)setModification: (Boolean) mod;
-(Boolean)getModificationStatus;

@end
