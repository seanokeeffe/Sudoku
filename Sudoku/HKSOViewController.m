//
//  HKSOViewController.m
//  Sudoku
//
//  Created by HMC on 9/11/14.
//  Copyright (c) 2014 Yaxi Gao Sean Okeeffe. All rights reserved.
//

#import "HKSOViewController.h"
#import "HKSOGridView.h"
#import "HKSONumPadView.h"
#import "HKSOGridModel.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>


@interface HKSOViewController () {
    HKSOGridView* _gridView;
    HKSOGridModel* _gridModel;
    HKSONumPadView* _numPadView;
    UIButton* _restart;
    UIButton* _newGame;
    AVAudioPlayer* _audioPlayerGridPressed;
    AVAudioPlayer* _audioPlayerWrongGridPressed;
}

@end

@implementation HKSOViewController

- (void)viewDidLoad
{
  
    
    NSURL *SoundURLGridPressed = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"button-11" ofType:@"wav"]];
    _audioPlayerGridPressed = [[AVAudioPlayer alloc] initWithContentsOfURL:SoundURLGridPressed error:nil];
    
    NSURL *SoundURLWrongGridPressed = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"button-18" ofType:@"wav"]];
    _audioPlayerWrongGridPressed = [[AVAudioPlayer alloc] initWithContentsOfURL:SoundURLWrongGridPressed error:nil];
    
    [super viewDidLoad];
    
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
    _numPadView = [[HKSONumPadView alloc] initWithFrame:numPadFrame];
    _numPadView.backgroundColor = [UIColor blackColor];
    
    // initialize gridModel
    _gridModel = [[HKSOGridModel alloc] init];
    
    // initialize restart button
    CGRect restartFrame = CGRectMake(x + 80, y + 120, 100, 70);
    _restart = [[UIButton alloc] initWithFrame:restartFrame];
    [_restart setTitle:[NSString stringWithFormat:@"Restart"] forState: UIControlStateNormal];
    [_restart setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [[_restart layer] setBorderWidth:2.0f];
    [[_restart layer] setBorderColor:[UIColor blackColor].CGColor];
    
    // initialize new game button
    CGRect newGameFrame = CGRectMake(x + 450, y + 120, 100, 70);
    _newGame = [[UIButton alloc] initWithFrame:newGameFrame];
    [_newGame setTitle:[NSString stringWithFormat:@"New Game"] forState: UIControlStateNormal];
    [_newGame setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [[_newGame layer] setBorderWidth:2.0f];
    [[_newGame layer] setBorderColor:[UIColor blackColor].CGColor];
    
    [self.view addSubview:_newGame];
    [self.view addSubview:_restart];
    [self initializeGrid];
    [self.view addSubview:_gridView];
    [self.view addSubview:_numPadView];
    [_gridView addTarget:(self) action:@selector(gridCellSelected:)];
    [_restart addTarget:(self) action:@selector(restartButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_newGame addTarget:(self) action:@selector(newGameButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void) initializeGrid
{
    for (int i = 0; i < 9; ++i) {
        for (int j = 0 ; j < 9; ++j)  {
            int value = [_gridModel getValueAtRow:i andColumn:j];
            [_gridView setValueAtRow:i andColumn:j toValue: value];
            if (value != 0) {
                [_gridView setToInitialAtRow:i andColumn:j];
            }
        }
    }
}

- (void) restartButtonPressed:(id) sender
{
    [_gridModel resetGridValues];
    [self initializeGrid];
}

- (void) newGameButtonPressed:(id) sender
{
    [_gridModel startNewGame];
    [self initializeGrid];
}


- (void) gridCellSelected:(id) sender
{
    
    
    
    int valueOfHighlightedButton = [_numPadView getHighlightedButton] + 1;
    if (valueOfHighlightedButton == 0) {
        return;
    }
    
    int row = ((UIButton*)sender).tag / 9;
    int col = ((UIButton*)sender).tag % 9;
    
    // If the value is consistent, we then update the cell.
    if ([_gridModel canAddThisValue:valueOfHighlightedButton toRow:row andCol: col]) {
        
        [_audioPlayerGridPressed prepareToPlay];
        [_audioPlayerGridPressed play];
        
        [_gridView setValueAtRow:row andColumn:col toValue: valueOfHighlightedButton];
        [_gridModel updateGridValues:valueOfHighlightedButton atRow:row andCol:col];
        // Check if the player completes the game.
        if ([_gridModel boardCompleted]) {
            UIAlertView* winAlert = [[UIAlertView alloc] initWithTitle:@"YOU WON!!" message:@"Congratulations" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
            [winAlert show];
        }
    } else {
        [_audioPlayerWrongGridPressed prepareToPlay];
        [_audioPlayerWrongGridPressed play];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
