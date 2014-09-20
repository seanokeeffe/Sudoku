//
//  HKSOGridModel.m
//  Sudoku
//
//  Created by Yaxi Gao on 9/19/14.
//  Copyright (c) 2014 Hana Kim Sean Okeeffe. All rights reserved.
//

#import "HKSOGridModel.h"


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

@implementation HKSOGridModel

- (int) getValueAtRow:(int) row andColumn:(int)col
{
    return initialGrid[row][col];
}

- (BOOL) canAddThisValue:(int) val toRow:(int) row andCol:(int) col
{
    if ([self checkRowValue:(int)val atRow:(int) row andCol:(int) col] && ([self checkColValue:(int)val atRow:(int) row andCol:(int) col]) && ([self checkBlockValue:(int)val atRow:(int) row andCol:(int) col])) {
        return YES;
    } else {
        return NO;
    }
}
        
- (BOOL) checkRowValue:(int)val atRow:(int) row andCol:(int) col
{
    for (int j = 0; j < 9; ++j) {
        if (val == initialGrid[row][j]) {
            return NO;
        }
    }
    return YES;
}

- (BOOL) checkColValue:(int)val atRow:(int) row andCol:(int) col
{
    for (int i = 0; i < 9; ++i) {
        if (val == initialGrid[i][col]) {
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
            if (val == initialGrid[i][j]) {
                return NO;
            }
        }
    }
    return YES;
}

- (BOOL) boardCompleted {
    for (int i = 0; i < 9; ++i) {
        for (int j = 0; j < 9; ++j) {
            if (initialGrid[i][j] == 0) {return NO;}
        }
    }
    return YES;
}

- (void) updateGridValues:(int)newVal atRow:(int) row andCol:(int) col
{
    initialGrid[row][col] = newVal;
}

@end
