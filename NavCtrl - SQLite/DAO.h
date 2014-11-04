//
//  DAO.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/7/14.
//  Copyright (c) 2014 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Company.h"
#import "Product.h"
#import "sqlite3.h"
#import "Reachability.h"



@interface DAO : NSObject

{
    sqlite3 *johnDB;
}

@property (nonatomic, strong) NSMutableArray *companyList;
@property (nonatomic, strong) NSMutableArray *productsList;




-(void)displayData;
-(void)addProductsToCompanies;
-(void)deleteData:(NSString *)productName;




@end
