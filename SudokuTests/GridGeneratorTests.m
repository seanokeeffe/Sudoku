//
//  GridGeneratorTests.m
//  Sudoku
//
//  Created by Sean on 9/28/14.
//  Copyright (c) 2014 Yaxi Gao Sean Okeeffe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "HKSOGridGenerator.h"

@interface GridGeneratorTests : XCTestCase
{
    HKSOGridGenerator* _gridGenerator;
}
@end


@implementation GridGeneratorTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _gridGenerator = [[HKSOGridGenerator alloc] init];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testValidSubstring
{
    // check if the gridvalue string indeed comes from the two given files
    
    NSString* gridOnePath = [[NSBundle mainBundle] pathForResource:@"grid1" ofType:@"txt"];
    NSString* gridTwoPath = [[NSBundle mainBundle] pathForResource:@"grid2" ofType:@"txt"];
    
    NSError* error;
    NSString* gridOneContent = [NSString stringWithContentsOfFile:gridOnePath encoding:NSUTF8StringEncoding error:&error];
    NSString* gridTwoContent = [NSString stringWithContentsOfFile:gridTwoPath encoding:NSUTF8StringEncoding error:&error];
    
    for (int i = 0; i < 11; ++i) {
        NSString* randomGrid = [_gridGenerator getRandomGridValues];
        
        if (([gridOneContent rangeOfString:randomGrid].location == NSNotFound) && ([gridTwoContent rangeOfString:randomGrid].location == NSNotFound)) {
            XCTFail(@"String not it given text files");
        }
    }

}

- (void) testStringLength
{
    // check if the gridvalue string has the right length
    
    for (int i = 0; i < 11; ++i) {
        NSString* randomGrid = [_gridGenerator getRandomGridValues];
        XCTAssertTrue([randomGrid length] == 81, @"String is not a valid length");
    }
}


@end
