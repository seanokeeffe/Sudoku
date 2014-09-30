//
//  HKSOWinViewController.m
//  Sudoku
//
//  Created by Sean on 9/28/14.
//  Copyright (c) 2014 Yaxi Gao Sean Okeeffe. All rights reserved.
//

#import "HKSOWinViewController.h"
#import "HKSOViewController.h"

@interface HKSOWinViewController ()
{
    UIWebView* _webView;
    UIButton* _playAgain;
    UILabel* _youWin;
    id _target;
    SEL _action;
}
@end

@implementation HKSOWinViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //gif background
    NSString* videoPath = [[NSBundle mainBundle] pathForResource:@"SudokuWin" ofType:@"gif"];
    NSData* video = [NSData dataWithContentsOfFile:videoPath];
    
    _webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    [_webView loadData:video MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    _webView.scalesPageToFit = YES;
    
    // create play again button
    CGFloat playAgainButtonWidth = self.view.frame.size.width;
    CGFloat playAgainButtonHeight = 50;
    CGFloat playAgainButtonx = self.view.center.x - playAgainButtonWidth/2;
    CGFloat playAgainButtony = self.view.center.y + 300;
    CGRect playAgainButtonFrame = CGRectMake(playAgainButtonx, playAgainButtony, playAgainButtonWidth, playAgainButtonHeight);
    
    _playAgain = [[UIButton alloc] initWithFrame:playAgainButtonFrame];
    _playAgain.alpha = 1.0;
    [_playAgain setTitle:@"Play Again?" forState:UIControlStateNormal];
    [_playAgain setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_playAgain.titleLabel setFont:[UIFont fontWithName:@"MarkerFelt-Thin" size:50.0f]];
    
    // you win label
    CGFloat youWinButtonWidth = self.view.frame.size.width;
    CGFloat youWinButtonHeight = 100;
    CGFloat youWinButtonx = self.view.center.x - youWinButtonWidth/2;
    CGFloat youWinButtony = self.view.center.y;
    CGRect youWinButtonFrame = CGRectMake(youWinButtonx, youWinButtony, youWinButtonWidth, youWinButtonHeight);
    
    _youWin = [[UILabel alloc] initWithFrame:youWinButtonFrame];
    _youWin.text = @"YOU WIN!";
    _youWin.textColor = [UIColor blackColor];
    [_youWin setTextAlignment:NSTextAlignmentCenter];
    [_youWin setFont:[UIFont fontWithName:@"MarkerFelt-Thin" size:100.0f]];
    
    // add target
    [_playAgain addTarget:self action:@selector(playAgainPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    // put everything on screen
    [self.view addSubview:_webView];
    [self.view addSubview:_playAgain];
    [self.view addSubview:_youWin];
}

- (void) setTarget:(id) target andAction:(SEL)action
{
    _target = target;
    _action = action;
}

- (void) playAgainPressed:(id) sender
{
    NSLog(@"Play Again pressed");
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
    [_target performSelector:_action withObject:_playAgain];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
