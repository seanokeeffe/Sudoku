//
//  HKSOViewController.m
//  Sudoku
//
//  Created by HMC on 9/11/14.
//  Copyright (c) 2014 Hana Kim Sean Okeeffe. All rights reserved.
//

#import "HKSOViewController.h"
#import "HKSOGridView.h"


int initialGrid [9][9]={
    {7,0,0,4,2,0,0,0,9},
    {0,0,9,5,0,0,0,0,4},
    {0,2,0,6,9,0,5,0,0},
    {6,5,0,0,0,0,4,3,0},
    {0,8,0,0,0,6,0,0,7},
    {0,1,0,0,4,5,6,0,0},
    {0,0,0,8,6,0,0,0,2},
    {3,4,0,9,0,0,1,0,0},
    {8,0,0,3,0,2,7,4,0}
};

@interface HKSOViewController () {
    HKSOGridView* _gridView;
}

@end

@implementation HKSOViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // create grid frame
    CGRect frame = self.view.frame;
    CGFloat x = CGRectGetWidth(frame) * .1;
    CGFloat y = CGRectGetHeight(frame) * .1;
    CGFloat size = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame)) * .80;
    
    CGRect gridFrame = CGRectMake(x, y, size, size);
    
    // create grid view
    _gridView = [[HKSOGridView alloc] initWithFrame:gridFrame];
    _gridView.backgroundColor = [UIColor blackColor];

    [self initializeGrid];
    [self.view addSubview:_gridView];
    [_gridView addTarget:(self) action:@selector(gridCellSelected:)];
    
}

- (void) initializeGrid
{
    
    for (int i = 0; i < 9; ++i) {
        for (int j = 0 ; j < 9; ++j)  {
            [_gridView setValueAtRow:i andColumn:j toValue: initialGrid[i][j]];
        }
    }
}

- (void) gridCellSelected:(id) sender
{
    int tag = ((UIButton*)sender).tag;
    NSLog(@"Button %d was pressed", tag);
    NSLog(@"at row: %d", tag / 9);
    NSLog(@"and column: %d", tag % 9);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
