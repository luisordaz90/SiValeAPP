//
//  DBManager.h
//  SiValeAPP
//
//  Created by Luis Ordaz on 8/5/16.
//  Copyright © 2016 Luis Ordaz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBHandler.h"

@interface DBManager : NSObject

@property (nonatomic, retain) DBHandler *handler;
+ (id)sharedManager;

@end
