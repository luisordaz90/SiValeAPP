//
//  DBHandler.h
//  
//
//  Created by Luis Ordaz on 3/16/16.
//
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DBHandler : NSObject
-(instancetype)initWithDatabaseFilename:(NSString *)dbFilename;
-(void)copyDatabaseIntoDocumentsDirectory;
-(NSArray *)loadDataFromDB:(NSString *)query;
-(void)executeQuery:(NSString *)query;
@property (nonatomic, strong) NSMutableArray *columnNames;
@property (nonatomic) int affectedRows;
@property (nonatomic) long long lastInsertedRowID;
@end
