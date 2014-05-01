//
//  DBMDataBaseManager.m
//  DataBaseMapper
//
//  Created by Anton Golub on 4/30/14.
//  Copyright (c) 2014 Anton Golub. All rights reserved.
//

#import "DBMDataBaseManager.h"
#import <sqlite3.h>
#import "DBMSQLiteDefinedValues.h"

@interface DBMDataBaseManager ()

@property (nonatomic, assign) sqlite3 *currentDatabase;

- (NSString *) documentsDirectoryPath;

@end


@implementation DBMDataBaseManager

#pragma mark - Public methods
- (BOOL) createDataBase:(NSString *)dataBaseName {
    BOOL success = NO;
    sqlite3 *creatingDataBase = nil;
    
    // Composing full path name to database
    NSString *dataBaseFullPath = [[self documentsDirectoryPath] stringByAppendingPathComponent:dataBaseName];

    if (dataBaseFullPath) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        // Create database only if it is not existed
        if (![fileManager fileExistsAtPath:dataBaseFullPath]) {
            const char *dbPath = [dataBaseFullPath UTF8String];
            
            if (sqlite3_open(dbPath, &creatingDataBase) == SQLITE_OK) {
                const char *sqlStatement = "CREATE TABLE IF NOT EXISTS TABLE_1 (ID INTEGER PRIMARY KEY AUTOINCREMENT, TEXT_FIELD TEXT, INTEGER_FIELD INTEGER)";
                if (sqlite3_exec(creatingDataBase, sqlStatement, NULL, NULL, NULL) != SQLITE_OK) {
                    success = NO;
                } else {
                    success = YES;
                    self.currentDatabase = creatingDataBase;
                    NSLog(@"Data base is created");
                }
                sqlite3_close(creatingDataBase);
            } else {
                success = NO;
            }
        } else {
            NSLog(@"Data base with such name is already existed");
            success = NO;
        }
    }
    
    return success;
}


- (BOOL) openDatabase:(NSString *)dataBaseName {
    BOOL success = NO;
    sqlite3 *openingDatabase = nil;
    
    // Composing full path name to database
    NSString *dataBaseFullPath = [[self documentsDirectoryPath] stringByAppendingPathComponent:dataBaseName];
    
    if (dataBaseFullPath) {
        const char *dbPath = [dataBaseFullPath UTF8String];
        if (sqlite3_open(dbPath, &openingDatabase) == SQLITE_OK) {
            success = YES;
            self.currentDatabase = openingDatabase;
            NSLog(@"Data base is opened");
        } else {
            NSLog(@"Data base can not be opened");
            success = NO;
        }
    }
    
    return success;
}


- (void) closeDataBase {
    if (self.currentDatabase != NULL) {
        sqlite3_close(self.currentDatabase);
        self.currentDatabase = NULL;
    }
}


// sqlite_master structure: type; name; tbl_name; rootpage; sql
// All tables record in sqlite_master table have type 'table'
- (NSArray *) tablesInDatabase:(NSString *)dataBaseName {
    NSMutableArray *tablesList = [NSMutableArray array];
    
    if ([self openDatabase:DATA_BASE_NAME]) {
        [tablesList addObjectsFromArray:[self tablesInCurrentDataBase]];
        [self closeDataBase];
    }
    
    return tablesList;
}


- (NSArray *) tablesInCurrentDataBase {
    sqlite3_stmt *statement = nil;
    NSMutableArray *tablesList = [NSMutableArray array];
    
    if (self.currentDatabase != NULL) {
        // Qureing all user table names from master table
        const char *sqlStatetment = "SELECT * FROM sqlite_master WHERE type = 'table'";
        
        if (sqlite3_prepare_v2(self.currentDatabase, sqlStatetment, -1, &statement, NULL) == SQLITE_OK) {
            // Looping through all records via 'step'
            while (sqlite3_step(statement) == SQLITE_ROW) {
                // Selecting value from third row in result statement - tbl_name value
                NSString *tableName = [NSString stringWithUTF8String:(const char *) sqlite3_column_text(statement, DBMSqliteMasterTableColumnTableNameIndex)];
                [tablesList addObject:tableName];
            }
            
            sqlite3_finalize(statement);
        } else {
            NSLog(@"No data base is currently being opened");
        }
    }
        
    return tablesList;
}


#pragma mark - Private instance
- (NSString *) documentsDirectoryPath {
    NSString *documentsPath = nil;
    
    NSArray *dirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if ([dirs count] > 0) {
        documentsPath = [dirs objectAtIndex:0];
    }
    
    return documentsPath;
}


@end
