//
//  GrandChildVC.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/2/14.
//  Copyright (c) 2014 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GrandChildVC : UIViewController <UIWebViewDelegate>


@property (retain, nonatomic) IBOutlet UIWebView *webView;
@property (retain, nonatomic) NSString *url;



@end
