//
//  ThirdViewController.m
//  KaoYan
//
//  Created by sherlock de Mac mini on 14-5-26.
//  Copyright (c) 2014年 CCNU. All rights reserved.
//

#import "ThirdViewController.h"
#import "MBProgressHUD.h"

@interface ThirdViewController ()

@property (strong, nonatomic) IBOutlet UIWebView *experienceView;
@end

@implementation ThirdViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.experienceView.delegate = self;
   NSURL *experienceURL = [NSURL URLWithString:@"http://3g.exam8.com/kaoyan/193.0/"];
    NSURLRequest *experienceRequest = [NSURLRequest requestWithURL:experienceURL];
    [self.experienceView loadRequest:experienceRequest];
}

#pragma mark -webView delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideAllHUDsForView:self.experienceView animated:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [MBProgressHUD hideHUDForView:self.experienceView animated:YES];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.experienceView animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading...";
}


@end