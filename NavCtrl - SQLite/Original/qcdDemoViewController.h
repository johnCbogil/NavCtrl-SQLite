//
//  qcdDemoViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChildViewController.h"
#import "Company.h"
#import "Product.h"
#import "DAO.h"


@class ChildViewController;

@interface qcdDemoViewController : UITableViewController

// Link for the next view
@property (nonatomic, retain) IBOutlet ChildViewController * childVC;

@property (nonatomic, strong) DAO *dAO;

@property (nonatomic, strong) NSMutableData *responseData;

@end
