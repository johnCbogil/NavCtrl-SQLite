//
//  DAO.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/7/14.
//  Copyright (c) 2014 Aditya Narayan. All rights reserved.
//

#import "DAO.h"

@implementation DAO



-(void)displayData {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // Assign the file path for the DB in the Simulator
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *dbInSim = [NSString stringWithFormat:@"%@/John.sql",path];
    NSLog(@"%@", dbInSim);
    
    // Assign the file path for the DB on the Desktop
    NSString *dbOnDesktop = @"/Users/adityanarayan/Desktop/John.sql";
    
    // If the file does not exist inside the simulator
    if (![fileManager fileExistsAtPath:dbInSim]){
        
        // Convert both filepaths into a URL
        NSURL *dbInSimAsURL = [NSURL fileURLWithPath:dbInSim];
        NSURL *dbOnDesktopAsURL = [NSURL fileURLWithPath:dbOnDesktop];
        
        // copy the URL from Desktop to Sim
        NSError * error = nil;
        [[NSFileManager defaultManager] copyItemAtURL:dbOnDesktopAsURL toURL:dbInSimAsURL error:&error];
        if (error != nil) {
            NSLog(@"ERROR!!! %@",error.localizedDescription);
        }
    }
    
    sqlite3_stmt *statement ;
    
    // If the sqlite connection is OK
    if (sqlite3_open([dbInSim UTF8String], &johnDB)==SQLITE_OK)
    {
        self.companyList = [[NSMutableArray alloc]init];
        self.productsList = [[NSMutableArray alloc]init];
        
        [self.companyList removeAllObjects];
        [self.productsList removeAllObjects];
        
        // Select all data from companies table
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM companies"];
        const char *query_sql = [querySQL UTF8String];
        
        // Convert the SQL text into a prepared statement
        if (sqlite3_prepare(johnDB, query_sql, -1, &statement, NULL) == SQLITE_OK)
        {
            // While the SQL statement is being evaluated
            while (sqlite3_step(statement)== SQLITE_ROW)
            {
                NSString *name = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                NSString *companyID = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                NSString *logo = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                
                Company *company = [[Company alloc]init];
                [company setName:name];
                [company setLogo:logo];
                 NSInteger myInt = [companyID intValue];
                [company setCompanyID:myInt];
                [self.companyList addObject:company];
            }
        }
        
        
        // Repeat SQL connection for products instead of companies
        
        NSString *productQuerySQL = [NSString stringWithFormat:@"SELECT * FROM products"];
        const char *productQuery_sql = [productQuerySQL UTF8String];
        
        if (sqlite3_prepare(johnDB, productQuery_sql, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement)== SQLITE_ROW)
            {
                NSString *name = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                NSString *image = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                NSString *URL = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                NSString *companyID = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];

                
                Product *product = [[Product alloc]init];
                [product setName: name];
                NSInteger myInt = [companyID intValue];
                [product setCompanyID:myInt];
                [product setImage:image];
                [product setURL:URL];
                [self.productsList addObject: product];
    }
    
}
    }



}



-(void)addProductsToCompanies{
    
    // Iterate through each company
    for(int i=0; i<[self.companyList count]; i++)
    {
        // Assign each company to its own company object
        Company *company = self.companyList[i];
        
        // Allocate productsList property
        company.productsList = [[NSMutableArray alloc]init];
        
        // Iterate through each product
        for(int j=0; j<[self.productsList count]; j++)
        {
            // Assign each product to its own product object
            Product *product = self.productsList[j];
            
            // If the companyID's match
            if(company.companyID == product.companyID){
                
                // Add the product to the appropriate company's productList
                [company.productsList addObject: product];
                
            }
        }
    }
    
    
    
}




-(void)deleteData:(NSString *)productName
{
    char *error;
     NSString * deleteQuery = [NSString stringWithFormat:@"DELETE FROM products WHERE Name IS '%@'", productName];
    
    // Execute the query
    if (sqlite3_exec(johnDB, [deleteQuery UTF8String], NULL, NULL, &error)==SQLITE_OK)
    {
        NSLog(@"product Deleted");
 
    }

}
@end
