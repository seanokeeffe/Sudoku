//
//  HKSOGridModel.h
//  Sudoku
//
//  Created by Yaxi Gao on 9/19/14.
//  Copyright (c) 2014 Yaxi Gao Sean Okeeffe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HKSOGridModel : NSObject

- (int) getValueAtRow:(int) row andColumn:(int)col;
- (BOOL) canAddThisValue:(int) val toRow:(int) row andCol:(int) col;
- (void) updateCurrentGrid:(int)newVal atRow:(int) row andCol:(int) col;
- (BOOL) boardCompleted;
- (void) resetGridValues;
- (void) startNewGame;

@end
