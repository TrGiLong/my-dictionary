//
//  Help.m
//  Mydictionaries
//
//  Created by Tran Giang Long on 27.12.13.
//  Copyright (c) 2013 Tran Giang Long. All rights reserved.
//

#import "Help.h"
#import "SWRevealViewController.h"
@interface Help ()

@end

@implementation Help

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"";
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"help-eng" ofType:@"rtf"];
    NSURL *url=[NSURL fileURLWithPath:path];
    NSURLRequest *req=[NSURLRequest requestWithURL:url];
    [_webView loadRequest:req];
    self.webView.scrollView.scrollEnabled = NO;
   // self.webView.scrollView.bounces =NO;
    
   
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [webView.scrollView setContentSize: CGSizeMake(webView.frame.size.width, webView.scrollView.contentSize.height)];
    webView.scrollView.contentOffset = CGPointMake(120, 0);
    [webView.scrollView setZoomScale:4];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
