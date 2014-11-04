//
//  qcdDemoViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//
// nskeyedarchiver
// nscoder
// nsuserdefaults
// encode classes and properties w/ nscoder
// only need to save companies array
// oren said not to touch viewcontroller but BNR says to add code to viewDIdLoad


#import "qcdDemoViewController.h"


@interface qcdDemoViewController ()
{
    Reachability *internetReachableFoo;
}

@end

@implementation qcdDemoViewController

// initWithSytle sets up the tableview
- (id)initWithStyle:(UITableViewStyle)style
{
    // initialize the tableview
    self = [super initWithStyle:style];
    
    if (self) {
}
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   // [self testInternetConnection];
    self.dAO  = [[DAO alloc]init];
    
    
    [self.dAO displayData];
    [self.dAO addProductsToCompanies];
    
    self.title = @"Mobile Device Makers";
   
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    [self getRequest];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dAO.companyList count];
}

// Ask the data source for a cell to insert in a particular location
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    // Take an item from the companyList and store it in a company object
    Company *company = [self.dAO.companyList objectAtIndex:[indexPath row]];
    
    
    // Display the company name and image in the order of the indexPath
    cell.textLabel.text = [NSString stringWithFormat:@"%@ $%@", company.name, company.stockPrice];
    cell.imageView.image = [UIImage imageNamed:company.logo];

    
    return cell;
}

                        

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/






#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Instantiate the next view
    self.childVC = [[ChildViewController alloc]init];
    
    //share the companyVC's dao with the childVC by assigning it as the childVC's dAO property
    self.childVC.dAO = self.dAO;
    
    // Displays the list of products
    self.childVC.company = self.dAO.companyList[indexPath.row]; // indexPath.row is an int that represents the index of the selected company in the companylist
    
    // Display the appropriate view title based on the indexPath
    self.childVC.title = self.childVC.company.name;
    
    // Push to the childVC view
    [self.navigationController pushViewController:self.childVC animated:YES];
    
}







#pragma mark - connection methods

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    self.responseData = [[NSMutableData alloc]init];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}
-(NSCachedURLResponse *)connection:(NSURLConnection *)connection
                 willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    return nil;
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    
    // Assign the response data to a string
     NSString *string = [[[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding] autorelease];

     NSLog(@"API Request Finish Loading");
    
     NSArray *components = [string componentsSeparatedByString:@"\n"];

    // Assign each stockprice to the appropriate company
    for(int i=0; i<self.dAO.companyList.count; i++) {
        [self.dAO.companyList[i] setStockPrice:components[i]];
        
    }
    
    
    [self.tableView reloadData];
    
}



- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"error = %@", [error localizedDescription]);
    NSString *message = [NSString stringWithFormat:@"%@", [error localizedDescription]];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:message delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
    [alert show];
}




-(void)getRequest{
    
    // Create the request
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://finance.yahoo.com/d/quotes.csv?s=AAPL+SSNLF+AMZN+GOOG&f=l1"]];
    
    NSMutableURLRequest *getRequest = [NSMutableURLRequest requestWithURL:url];
    
    getRequest.HTTPMethod = @"GET";
    
    [getRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [getRequest setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    // Create URL connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:getRequest delegate:self];
    conn = nil;
    
}

@end
