//
//  DBMViewController.m
//  DataBaseMapper
//
//  Created by Anton Golub on 4/30/14.
//  Copyright (c) 2014 Anton Golub. All rights reserved.
//

#import "DBMViewController.h"
#import "DBMDataBaseManager.h"

@interface DBMViewController ()

@end

@implementation DBMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    DBMDataBaseManager *dbManager = [[DBMDataBaseManager alloc] init];
    
    [dbManager closeDataBase];
    
    [dbManager createDataBase:DATA_BASE_NAME];
    NSArray *tablesList = [dbManager tablesInDatabase:DATA_BASE_NAME];
    
    NSLog(@"%@", tablesList);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
