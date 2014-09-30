//
//  HKSOViewController.h
//  Sudoku
//
//  Created by HMC on 9/11/14.
//  Copyright (c) 2014 Yaxi Gao Sean Okeeffe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HKSOGridView.h"
#import <AudioToolbox/AudioToolbox.h>

@interface HKSOViewController : UIViewController

- (void) gridCellSelected:(id)sender;
- (void) newGameButtonPressed:(id) sender;

@end
