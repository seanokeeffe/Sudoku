//
//  HKSOGridModel.m
//  Sudoku
//
//  Created by Yaxi Gao on 9/19/14.
//  Copyright (c) 2014 Yaxi Gao Sean Okeeffe. All rights reserved.
//

#import "HKSOGridModel.h"
#import "HKSOGridGenerator.h"

@interface HKSOGridModel() {
    HKSOGridGenerator* _gridGenerator;
    NSString* _gridValues;
    int currentGrid [9][9];
}
@end


@implementation HKSOGridModel

- (id) init
{
    self = [super init];
    if (self) {
        _gridGenerator = [[HKSOGridGenerator alloc] init];
        [self startNewGame];
    }
    
    return self;
}

- (void) setCurrentGrid:(NSString*) values
{
    _gridValues = values;
    [self parseGridValues];
}

// parse _gridValues string to fill in currentGrid array
- (void) parseGridValues
{
    for (int i = 0; i < 9; ++i) {
        for (int j = 0; j < 9; ++j) {
            int index = i * 9 + j;
            if ([_gridValues characterAtIndex:index] == '.') {
                currentGrid[i][j] = 0;
            } else {
                currentGrid[i][j] = (int)[_gridValues characterAtIndex:index] - 48;
            }
        }
    }
}

- (int) getValueAtRow:(int) row andColumn:(int)col
{
    NSAssert((row >= 0) && (row <= 8), @"Grid row index out of range");
    NSAssert((col >= 0) && (col <= 8), @"Grid col index out of range");
    
    return currentGrid[row][col];
}


- (BOOL) canAddThisValue:(int) val toRow:(int) row andCol:(int) col
{
    NSAssert((row >= 0) && (row <= 8), @"Grid row index out of range");
    NSAssert((col >= 0) && (col <= 8), @"Grid col index out of range");
    NSAssert((val >= 1) && (val <= 9), @"Value out of range");
    
    // Check if the value is consistent for its row, column, and block.
    if ([self checkRowValue:(int)val atRow:(int) row andCol:(int) col] && ([self checkColValue:(int)val atRow:(int) row andCol:(int) col]) && ([self checkBlockValue:(int)val atRow:(int) row andCol:(int) col])) {
        return YES;
    } else {
        return NO;
    }
}
        
- (BOOL) checkRowValue:(int)val atRow:(int) row andCol:(int) col
{
    for (int j = 0; j < 9; ++j) {
        if (val == currentGrid[row][j]) {
            return NO;
        }
    }
    return YES;
}

- (BOOL) checkColValue:(int)val atRow:(int) row andCol:(int) col
{
    for (int i = 0; i < 9; ++i) {
        if (val == currentGrid[i][col]) {
            return NO;
        }
    }
    return YES;
}

- (BOOL) checkBlockValue:(int)val atRow:(int) row andCol:(int) col
{
    int blockRow = (row / 3) * 3;
    int blockCol = (col / 3) * 3;
    
    for (int i = blockRow; i < blockRow + 3; ++i) {
        for (int j = blockCol; j < blockCol + 3; ++j) {
            if (val == currentGrid[i][j]) {
                return NO;
            }
        }
    }
    return YES;
}

// check if the player wins the game
- (BOOL) boardCompleted
{
    for (int i = 0; i < 9; ++i) {
        for (int j = 0; j < 9; ++j) {
            if (currentGrid[i][j] == 0) {return NO;}
        }
    }
    return YES;
}

// update currentGrid array to reflect cell changes
- (void) updateCurrentGrid:(int)newVal atRow:(int) row andCol:(int) col
{
    NSAssert((row >= 0) && (row <= 8), @"Grid row index out of range");
    NSAssert((col >= 0) && (col <= 8), @"Grid col index out of range");
    NSAssert((newVal >= 1) && (newVal <= 9), @"Value out of range");
    
    currentGrid[row][col] = newVal;
}

- (void) resetGridValues
{
    [self parseGridValues];
}

- (void) startNewGame
{
    _gridValues = [_gridGenerator getRandomGridValues];
    [self parseGridValues];
}

@end
