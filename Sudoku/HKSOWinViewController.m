//
//  HKSOWinViewController.m
//  Sudoku
//
//  Created by Sean on 9/28/14.
//  Copyright (c) 2014 Hana Kim Sean Okeeffe. All rights reserved.
//

#import "HKSOWinViewController.h"

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
    CGFloat playAgainButtonx = self.view.center.x;
    CGFloat playAgainButtony = self.view.center.y + 300;
    CGFloat playAgainButtonWidth = 100;
    CGFloat playAgainButtonHeight = 50;
    CGRect playAgainButtonFrame = CGRectMake(playAgainButtonx, playAgainButtony, playAgainButtonWidth, playAgainButtonHeight);
    
    _playAgain = [[UIButton alloc] initWithFrame:playAgainButtonFrame];
    _playAgain.alpha = 0.0;
    [_playAgain setTitle:@"Play Again?" forState:UIControlStateNormal];
    [_playAgain setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    // you win label
    CGFloat youWinButtonx = self.view.center.x;
    CGFloat youWinButtony = self.view.center.y;
    CGFloat youWinButtonWidth = 200;
    CGFloat youWinButtonHeight = 100;
    CGRect youWinButtonFrame = CGRectMake(youWinButtonx, youWinButtony, youWinButtonWidth, youWinButtonHeight);
    
    _youWin = [[UILabel alloc] initWithFrame:youWinButtonFrame];
    _youWin.text = @"YOU WIN!";
    _youWin.textColor = [UIColor blackColor];
    
    // add target
    [_playAgain addTarget:self action:@selector(playAgainPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    // put everything on screen
    [self.view addSubview:_webView];
    [self.view addSubview:_playAgain];
    [self.view addSubview:_youWin];
}

- (void) setTarget:(id)target andAction:(SEL)action
{
    _target = target;
    _action = action;
}

- (void) playAgainPressed:(id) sender
{
    [_target performSelector:_action];
    
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
