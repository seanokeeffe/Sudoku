//
//  HKSOViewController.m
//  Sudoku
//
//  Created by HMC on 9/11/14.
//  Copyright (c) 2014 Hana Kim Sean Okeeffe. All rights reserved.
//

#import "HKSOViewController.h"

@interface HKSOViewController ()

@end

@implementation HKSOViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    CGRect mainFrame = self.view.frame;
    CGFloat x = CGRectGetWidth(mainFrame) * 0.5;
    CGFloat y = CGRectGetHeight(mainFrame) * 0.5;
    
    CGRect buttonFrame = CGRectMake(x, y, 100, 100);
    UIButton* button = [[UIButton alloc] initWithFrame:buttonFrame];
    [button setTitle:@"Button" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blueColor];
    button.tag = 1;
    
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlStateHighlighted];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) buttonPressed:(id)sender
{
    NSLog(@"Button %d was pressed", ((UIButton*)sender).tag);
}

@end
