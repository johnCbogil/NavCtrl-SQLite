//
//  Product.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/6/14.
//  Copyright (c) 2014 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *URL;
@property (nonatomic) int *companyID;


@end
