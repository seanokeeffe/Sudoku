//
//  HKSOAboutViewController.m
//  Sudoku
//
//  Created by Sean on 9/27/14.
//  Copyright (c) 2014 Hana Kim Sean Okeeffe. All rights reserved.
//

#import "HKSOAboutViewController.h"

@interface HKSOAboutViewController () {
    UIWebView* _webView;
    
}

@end

@implementation HKSOAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"About";
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = CGRectGetWidth(self.view.frame);
    CGFloat height = CGRectGetHeight(self.view.frame);
    
    CGRect webFrame = CGRectMake(x, y, width, height);
    
    _webView = [[UIWebView alloc] initWithFrame:webFrame];
    
    NSString* htmlFile = [[NSBundle mainBundle] pathForResource:@"Sudoku_About" ofType:@"html"];
    NSData* htmlData = [NSData dataWithContentsOfFile:htmlFile];
    
    NSURL* baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    
    [_webView loadData:htmlData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:baseURL];
    
    [self.view addSubview:_webView];
    
    
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
