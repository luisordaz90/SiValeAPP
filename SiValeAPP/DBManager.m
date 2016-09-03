//
//  DBManager.m
//  SiValeAPP
//
//  Created by Luis Ordaz on 8/5/16.
//  Copyright © 2016 Luis Ordaz. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager

+ (id)sharedManager {
    static DBManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        _handler = [[DBHandler alloc] initWithDatabaseFilename:@"master_db.sql"];
    }
    return self;
}

@end

