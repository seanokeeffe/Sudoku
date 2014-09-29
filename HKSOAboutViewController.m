//
//  HKSOAboutViewController.m
//  Sudoku
//
//  Created by Sean on 9/27/14.
//  Copyright (c) 2014 Hana Kim Sean Okeeffe. All rights reserved.
//

#import "HKSOAboutViewController.h"

@interface HKSOAboutViewController () {
    UITextView* _aboutContent;
    UILabel *_title;
    UILabel *_copyright;
    
}

@end

@implementation HKSOAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"About";
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Wallpaper.jpg"]];
    
    CGFloat aboutContentWidth = self.view.frame.size.width - 100;
    CGFloat aboutContentHeight = self.view.frame.size.height - 550;
    CGFloat aboutContentx = self.view.center.x - aboutContentWidth/2;
    CGFloat aboutContenty = self.view.center.y - aboutContentHeight/2;
    CGRect aboutContentFrame = CGRectMake(aboutContentx, aboutContenty, aboutContentWidth, aboutContentHeight);
    _aboutContent = [[UITextView alloc] initWithFrame:aboutContentFrame];
    [_aboutContent setText:@"Welcome to Sudoku!\n\nThe rules are simple: Fill up the grid so that the numbers 1 through 9 appear once in every row, column, and 3x3 block!\n\nTo play this game, first select on a number, 1 through 9, on the bottom number pad.\nWhen the number you want is highlighted, press on the cell you want to put that number in.\n\nGood Luck!"];
    [_aboutContent setTextAlignment:NSTextAlignmentCenter];
    _aboutContent.backgroundColor = [UIColor clearColor];
    [_aboutContent setFont:[UIFont fontWithName:@"Helvetica Neue" size:30.0f]];
    
    CGFloat titleWidth = self.view.frame.size.width - 100;
    CGFloat titleHeight = 100;
    CGFloat titlex = self.view.center.x - titleWidth/2;
    CGFloat titley = aboutContenty - 100;
    CGRect titleFrame = CGRectMake(titlex, titley, titleWidth, titleHeight);
    
    _title = [[UILabel alloc] initWithFrame:titleFrame];
    _title.text = @"SUDOKU";
    _title.font = [UIFont fontWithName:@"HelveticaNeue-BoldItalic" size:50.0f];
    _title.textAlignment = NSTextAlignmentCenter;
    
    CGFloat copyrightWidth = 300;
    CGFloat copyrightHeight = 100;
    CGFloat copyrightx = self.view.frame.size.width - 300;
    CGFloat copyrighty = self.view.frame.size.height - 200;
    CGRect copyrightFrame = CGRectMake(copyrightx, copyrighty, copyrightWidth, copyrightHeight);
    
    _copyright = [[UILabel alloc] initWithFrame:copyrightFrame];
    _copyright.text = @"© Yaxi Gao and Sean O'Keeffe";
    _copyright.font = [UIFont fontWithName:@"HelveticaNeue-BoldItalic" size:15.0f];
    _copyright.textAlignment = NSTextAlignmentLeft;
    
    [self.view addSubview:backgroundView];
    [self.view addSubview:_title];
    [self.view addSubview:_aboutContent];
    [self.view addSubview:_copyright];
    
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
