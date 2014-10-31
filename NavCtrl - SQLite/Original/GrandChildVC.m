//
//  GrandChildVC.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/2/14.
//  Copyright (c) 2014 Aditya Narayan. All rights reserved.
//

#import "GrandChildVC.h"

@interface GrandChildVC ()

@end

@implementation GrandChildVC







- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Load the URL from the previous view
    NSURL *websiteUrl = [NSURL URLWithString:(@"%@", self.url) ];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl];
    [self.webView loadRequest:urlRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}














/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
