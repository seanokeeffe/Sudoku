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

@end
