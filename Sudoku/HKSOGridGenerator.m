//
//  HKSOGridGenerator.m
//  Sudoku
//
//  Created by Yaxi Gao on 9/27/14.
//  Copyright (c) 2014 Hana Kim Sean Okeeffe. All rights reserved.
//

#import "HKSOGridGenerator.h"
#include <stdlib.h>

@interface HKSOGridGenerator () {
    NSArray* _gridValues;
}
@end

@implementation HKSOGridGenerator
- (id) init
{
    self = [super init];
    NSString* path;
    if (self) {
        int index = arc4random_uniform(100);
        if ((index % 2) == 0) {
            path = [[NSBundle mainBundle] pathForResource:@"grid1" ofType:@"txt"];
        } else {
            path = [[NSBundle mainBundle] pathForResource:@"grid2" ofType:@"txt"];
        }

        NSError* error;
        NSString* readString =[[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];

        _gridValues = [readString componentsSeparatedByString:@"\n"];
    }
    return self;
}

- (NSString*) getRandomGridValues
{
    int index = arc4random_uniform((int)_gridValues.count);
    return _gridValues[index];
}
@end
