//
//  HKSOGridModel.m
//  Sudoku
//
//  Created by Yaxi Gao on 9/19/14.
//  Copyright (c) 2014 Yaxi Gao Sean Okeeffe. All rights reserved.
//

#import "HKSOGridModel.h"

int initialGrid [9][9]={
    {7,0,0,6,0,0,0,3,8},
    {0,0,2,5,8,1,0,4,0},
    {0,9,0,0,0,0,0,0,0},
    {4,5,6,0,0,0,8,9,3},
    {2,0,9,0,0,4,6,0,0},
    {0,0,0,0,6,5,0,0,2},
    {0,0,5,4,0,6,0,1,7},
    {0,0,0,3,0,0,0,0,4},
    {9,4,0,0,7,0,2,0,0},
};

@implementation HKSOGridModel

- (int) getValueAtRow:(int) row andColumn:(int)col
{
    NSAssert((row >= 0) && (row <= 8), @"Grid row index out of range");
    NSAssert((col >= 0) && (col <= 8), @"Grid col index out of range");
    
    return initialGrid[row][col];
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


- (BOOL) boardCompleted
{
    for (int i = 0; i < 9; ++i) {
        for (int j = 0; j < 9; ++j) {
            if (initialGrid[i][j] == 0) {return NO;}
        }
    }
    return YES;
}


- (void) updateGridValues:(int)newVal atRow:(int) row andCol:(int) col
{
    NSAssert((row >= 0) && (row <= 8), @"Grid row index out of range");
    NSAssert((col >= 0) && (col <= 8), @"Grid col index out of range");
    NSAssert((newVal >= 1) && (newVal <= 9), @"Value out of range");
    
    initialGrid[row][col] = newVal;
}

@end
