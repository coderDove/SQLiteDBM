//
//  DBMDataBaseManager.h
//  DataBaseMapper
//
//  Created by Anton Golub on 4/30/14.
//  Copyright (c) 2014 Anton Golub. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DATA_BASE_NAME @"MappingDatabase.sqlite"

@interface DBMDataBaseManager : NSObject

- (BOOL) createDataBase:(NSString *)dataBaseName;
// Opens defined data base and sets it as current data base for manager
- (BOOL) openDatabase:(NSString *)dataBaseName;
- (void) closeDataBase;

- (NSArray *) tablesInDatabase:(NSString *)dataBaseName;
- (NSArray *) tablesInCurrentDataBase;

@end
