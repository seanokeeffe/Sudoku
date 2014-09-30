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
#import "HKSOAboutViewController.h"
#import "HKSOWinViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>


@interface HKSOViewController () {
    
    HKSOGridView* _gridView;
    HKSOGridModel* _gridModel;
    HKSONumPadView* _numPadView;
    HKSOWinViewController* _winView;
    UIButton* _restart;
    UIButton* _newGame;
    UIButton* _info;
    AVAudioPlayer* _audioPlayerGridPressed;
    AVAudioPlayer* _audioPlayerWrongGridPressed;

}

@end



@implementation HKSOViewController

- (void)viewDidLoad
{
  
    [super viewDidLoad];
    
    // create the background
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Wallpaper.jpg"]];
    
    // Initialize misc
    self.view.backgroundColor = [UIColor whiteColor];
    CGRect frame = self.view.frame;
    self.title = @"Sudoku";
    _winView = [[HKSOWinViewController alloc] init];
    [_winView setTarget:self andAction:@selector(newGameButtonPressed:)];
    
    // Sound set up
    NSURL *SoundURLGridPressed = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"button-11" ofType:@"wav"]];
    _audioPlayerGridPressed = [[AVAudioPlayer alloc] initWithContentsOfURL:SoundURLGridPressed error:nil];
    NSURL *SoundURLWrongGridPressed = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"button-18" ofType:@"wav"]];
    _audioPlayerWrongGridPressed = [[AVAudioPlayer alloc] initWithContentsOfURL:SoundURLWrongGridPressed error:nil];
    
    // create gridView
    CGFloat gridx    = CGRectGetWidth(frame) * .1;
    CGFloat gridy    = CGRectGetHeight(frame) * .1;
    CGFloat gridSize = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame)) * .80;
    CGRect gridFrame = CGRectMake(gridx, -gridSize, gridSize, gridSize); // -gridSize to initally place it off screen
    
    _gridView = [[HKSOGridView alloc] initWithFrame:gridFrame];
    _gridView.backgroundColor = [UIColor blackColor];

    // create numPad view
    CGFloat numPadx      = gridx;
    CGFloat numPady      = gridy + gridSize + 100; // A little past the grid
    CGFloat numPadWidth  = gridSize;
    CGFloat numPadHeight = 80;
    CGRect numPadFrame   = CGRectMake(numPadx, numPady, numPadWidth, numPadHeight);
    
    _numPadView = [[HKSONumPadView alloc] initWithFrame:numPadFrame];
    _numPadView.backgroundColor = [UIColor blackColor];
    _numPadView.alpha = 0.0; // initally transparent
    
    // create gridModel
    _gridModel = [[HKSOGridModel alloc] init];
    
    // create restart button
    CGFloat restartx      = numPadx + 80; // A little in from the end
    CGFloat restarty      = numPady + 120;
    CGFloat restartWidth  = 100;
    CGFloat restartHeight = 50;
    CGRect restartFrame   = CGRectMake(-restartWidth, restarty, restartWidth, restartHeight); // initially off the screen
    
    _restart = [[UIButton alloc] initWithFrame:restartFrame];
    [_restart setTitle:[NSString stringWithFormat:@"Restart"] forState: UIControlStateNormal];
    [_restart setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_restart setBackgroundImage:[UIImage imageNamed:@"Button-Normal.png"]
                        forState:UIControlStateNormal];
    [_restart setBackgroundImage:[UIImage imageNamed:@"Button-Highlighted.png"]
                        forState:UIControlStateHighlighted];

    
    // initialize new game button
    CGFloat newGameWidth  = 100;
    CGFloat newGameHeight = 50;
    CGFloat newGamex      = numPadx+numPadWidth-newGameWidth-80;
    CGFloat newGamey      = restarty;
    CGRect newGameFrame   = CGRectMake(frame.size.width, newGamey, newGameWidth, newGameHeight); // initially off the screen
    
    _newGame = [[UIButton alloc] initWithFrame:newGameFrame];
    [_newGame setTitle:[NSString stringWithFormat:@"New Game"] forState: UIControlStateNormal];
    [_newGame setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_newGame setBackgroundImage:[UIImage imageNamed:@"Button-Normal.png"]
                        forState:UIControlStateNormal];
    [_newGame setBackgroundImage:[UIImage imageNamed:@"Button-Highlighted.png"]
                        forState:UIControlStateHighlighted];
    
    // create info button
    CGFloat infox          = self.view.center.x - 50;
    CGFloat infoy          = newGamey;
    CGFloat infoWidth      = 100;
    CGFloat infoHeight     = 50;
    CGRect infoButtonFrame = CGRectMake(infox, frame.size.height, infoWidth, infoHeight); //initally off screen
    
    _info = [[UIButton alloc] initWithFrame:infoButtonFrame];
    [_info setTitle:[NSString stringWithFormat:@"Info"] forState:UIControlStateNormal];
    [_info setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_info setBackgroundImage:[UIImage imageNamed:@"Button-Normal.png"]
                        forState:UIControlStateNormal];
    [_info setBackgroundImage:[UIImage imageNamed:@"Button-Highlighted.png"]
                        forState:UIControlStateHighlighted];
    
    // Add everything to screen
    [self initializeGrid];
    [self.view addSubview:backgroundView];
    [self.view addSubview:_gridView];
    [self.view addSubview:_numPadView];
    [self.view addSubview:_newGame];
    [self.view addSubview:_info];
    [self.view addSubview:_restart];
    
    // Target action setup
    [_gridView addTarget:(self) action:@selector(gridCellSelected:)];
    [_restart addTarget:(self) action:@selector(restartButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_info addTarget:(self) action:@selector(infoButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_newGame addTarget:(self) action:@selector(newGameButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    // Animate
    [UIView animateWithDuration:1.5 animations:^{
        _gridView.frame = CGRectMake(gridx, gridy, gridSize, gridSize);
        _numPadView.alpha = 1.0;
        _restart.frame = CGRectMake(restartx, restarty, restartWidth, restartHeight);
        _info.frame = CGRectMake(infox, infoy, infoWidth, infoHeight);
        _newGame.frame = CGRectMake(newGamex, newGamey, newGameWidth, newGameHeight);}];
    
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

- (void) infoButtonPressed:(id) sender
{
    HKSOAboutViewController *aboutViewController = [[HKSOAboutViewController alloc] init];
    [self.navigationController pushViewController:aboutViewController animated:YES];
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
    
    int row = (int)((UIButton*)sender).tag / 9;
    int col = ((UIButton*)sender).tag % 9;
    
    // If the value is consistent, we then update the cell.
    if ([_gridModel canAddThisValue:valueOfHighlightedButton toRow:row andCol: col]) {
        [_audioPlayerGridPressed prepareToPlay];
        [_audioPlayerGridPressed play];
        
        [_gridView setValueAtRow:row andColumn:col toValue: valueOfHighlightedButton];
        [_gridModel updateCurrentGrid:valueOfHighlightedButton atRow:row andCol:col];
        
        // Check if the player completes the game.
        if ([_gridModel boardCompleted]) {
            [self.navigationController modalPresentationStyle];
            [self.navigationController presentViewController:_winView animated:YES completion:nil];
            
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
