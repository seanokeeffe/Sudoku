//
//  HKSOViewController.m
//  Sudoku
//
//  Created by HMC on 9/11/14.
//  Copyright (c) 2014 Hana Kim Sean Okeeffe. All rights reserved.
//

#import "HKSOViewController.h"
#import "HKSOGridView.h"
#import "HKSONumPadView.h"
#import "HKSOGridModel.h"


@interface HKSOViewController () {
    HKSOGridView* _gridView;
    HKSOGridModel* _gridModel;
    HKSONumPadView* _numPadView;
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

    // create numPad view
    y = y + size + 100;
    CGRect numPadFrame = CGRectMake(x, y, size, 80);
    
    _gridModel = [[HKSOGridModel alloc] init];
    _numPadView = [[HKSONumPadView alloc] initWithFrame:numPadFrame];
    _numPadView.backgroundColor = [UIColor blackColor];
    
    [self initializeGrid];
    [self.view addSubview:_gridView];
    [self.view addSubview:_numPadView];
    [_gridView addTarget:(self) action:@selector(gridCellSelected:)];
    
}

- (void) initializeGrid
{
    
    for (int i = 0; i < 9; ++i) {
        for (int j = 0 ; j < 9; ++j)  {
            int value = [_gridModel getValueAtRow:i andColumn:j];
            [_gridView setValueAtRow:i andColumn:j toValue: value];
        }
    }
}

- (void) gridCellSelected:(id) sender
{
    int valueOfHighlightedButton = [_numPadView highlightedButton] + 1;
    int row = ((UIButton*)sender).tag % 9;
    int col = ((UIButton*)sender).tag / 9;
    if ([_gridModel canAddThisValue:valueOfHighlightedButton toRow:row andCol: col]) {
        [_gridView setValueAtRow:row andColumn:col toValue: valueOfHighlightedButton];
        [_gridModel updateGridValues:valueOfHighlightedButton atRow:row andCol:col];
        if ([_gridModel boardCompleted]) {
            /////////////
        }
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
