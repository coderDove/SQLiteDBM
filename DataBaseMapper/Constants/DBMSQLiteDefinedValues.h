//
//  SQLiteDefined.h
//  DataBaseMapper
//
//  Created by Anton Golub on 5/1/14.
//  Copyright (c) 2014 Anton Golub. All rights reserved.
//

// Enum with index numbers for all columns in SQLite data base table sqlite_master
typedef NS_ENUM (NSInteger, DBMSqliteMasterTableColumnsIndexes) {
    DBMSqliteMasterTableColumnTypeIndex = 0,
    DBMSqliteMasterTableColumnNameIndex = 1,
    DBMSqliteMasterTableColumnTableNameIndex = 2,
    DBMSqliteMasterTableColumnRootPageIndex = 3,
    DBMSqliteMasterTableColumnSqlIndex = 4
};


// Enum with index numerbs for all columns in SQLite data base for table_info results
typedef NS_ENUM (NSInteger, DBMSqliteTablesInfoColumnsIndexes) {
    DBMSqliteTablesInfoColumnCIDIndex = 0,
    DBMSqliteTablesInfoColumnNameIndex = 1,
    DBMSqliteTablesInfoColumnTypeIndex = 2,
    DBMSqliteTablesInfoColumnNotNullIndex = 3,
    DBMSqliteTablesInfoColumnDfltValueIndex = 4,
    DBMSqliteTablesInfoColumnPKIndex = 5
};


