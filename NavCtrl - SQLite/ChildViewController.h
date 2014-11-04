//
//  ChildViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GrandChildVC.h"
#import "Company.h"
#import "Product.h"
#import "DAO.h"

@interface ChildViewController : UITableViewController <UIWebViewDelegate>

@property (nonatomic, strong) Company *company;
@property (nonatomic, strong) Product *product;
@property (nonatomic, strong) GrandChildVC *webVC;
@property (nonatomic, strong) DAO * dAO;


@end
