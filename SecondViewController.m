//
//  SecondViewController.m
//  KaoYan
//
//  Created by sherlock de Mac mini on 14-5-26.
//  Copyright (c) 2014年 CCNU. All rights reserved.
//

#import "SecondViewController.h"
#import "MBProgressHUD.h"

@interface SecondViewController ()


@property (strong, nonatomic) IBOutlet UIWebView *bbsView;


@end

@implementation SecondViewController



-(void)viewDidLoad
{
    [super viewDidLoad];
    self.bbsView.delegate = self;
    NSURL *bbsURL = [NSURL URLWithString:@"http://bbs.freekaoyan.com"];
    NSURLRequest *bbsRequest = [NSURLRequest requestWithURL:bbsURL];
    [self.bbsView loadRequest:bbsRequest];
        
}

#pragma mark - webView delegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUDForView:self.bbsView animated:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [MBProgressHUD hideHUDForView:self.bbsView animated:YES];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.bbsView animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading...";
}


@end
