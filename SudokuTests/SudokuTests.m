//
//  SudokuTests.m
//  SudokuTests
//
//  Created by HMC on 9/11/14.
//  Copyright (c) 2014 Yaxi Gao Sean Okeeffe. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HKSOGridModel.h"

@interface SudokuTests : XCTestCase {
    HKSOGridModel *_gridModel;
}

@end

@implementation SudokuTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _gridModel = nil;
    _gridModel = [[HKSOGridModel alloc] init];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

// Tests for the getValueAtRowandColumn method.
// Fucntionality: Gets the correct value at the specified row and column.
// Assumptions: Assume that inputs will be in valid range from 0-8.
- (void)testGetValueatRowandColumn
{

    XCTAssertTrue([_gridModel getValueAtRow:0 andColumn:0]==7,@"Top Left Corner Value");
    NSLog(@"value at 8,8: %d",[_gridModel getValueAtRow:8 andColumn:8]);
    XCTAssertTrue([_gridModel getValueAtRow:8 andColumn:8]==0,@"Bottom Right Corner Value");
    XCTAssertTrue([_gridModel getValueAtRow:3 andColumn:7]==9,@"Cell in the middle");
    
    XCTAssertFalse([_gridModel getValueAtRow:1 andColumn:5]==0,@"Negative testing case");
    
    [_gridModel updateCurrentGrid:7 atRow:3 andCol:1];
    XCTAssertTrue([_gridModel getValueAtRow:3 andColumn:1]==7,@"test get method after updating");
    
    XCTAssertThrowsSpecific([_gridModel getValueAtRow:0 andColumn:10], NSException);
    XCTAssertThrowsSpecific([_gridModel getValueAtRow:-1 andColumn:5], NSException);
}

// Tests for the canAddThisValuetoRowandCol method.
// Funcitonality: Checks for consistency, i.e. the specified value to add to the row and column is a valid move in Sudoku.
// Assumptions: Assuming that row and column values will be in valid range from 0-8 and the values will be in range 1-9.
- (void)testCanAddThisValuetoRowandCol
{
    XCTAssertFalse([_gridModel canAddThisValue:7 toRow:6 andCol:4],@"Checking inconsitent row case");
    XCTAssertFalse([_gridModel canAddThisValue:3 toRow:8 andCol:7],@"Checking inconsistent column case");
    XCTAssertFalse([_gridModel canAddThisValue:6 toRow:5 andCol:1],@"Checking inconsistent block case");
    
    XCTAssertTrue([_gridModel canAddThisValue:1 toRow:2 andCol:6],@"Checking consistent entry");
    XCTAssertTrue([_gridModel canAddThisValue:2 toRow:6 andCol:1],@"Checking consistent entry");
    XCTAssertTrue([_gridModel canAddThisValue:5 toRow:8 andCol:8],@"Checking consistent entry for corner");
    
    [_gridModel updateCurrentGrid:1 atRow:0 andCol:1];
    XCTAssertFalse([_gridModel canAddThisValue:1 toRow:2 andCol:2],@"Checking inconsistency after inserting new value in the same block");
    [_gridModel updateCurrentGrid:2 atRow:7 andCol:1];
    XCTAssertFalse([_gridModel canAddThisValue:2 toRow:6 andCol:1],@"Checking inconsistency after inserting new value in the same column");
    [_gridModel updateCurrentGrid:9 atRow:5 andCol:3];
    XCTAssertFalse([_gridModel canAddThisValue:9 toRow:5 andCol:6],@"Checking inconsistency after inserting new value in the same row");
    
    XCTAssertThrowsSpecific([_gridModel canAddThisValue:10 toRow:0 andCol:0], NSException);
    XCTAssertThrowsSpecific([_gridModel canAddThisValue:9 toRow:10 andCol:0], NSException);
    XCTAssertThrowsSpecific([_gridModel canAddThisValue:6 toRow:0 andCol:-4], NSException);
}

// Tests for the updateCurrentGridatRowandCol method.
// Functionality: Updates the grid at the specified location with a new given value.
// Assumption: Assume that this is only called on valid spots with valid values.
- (void)testupdateCurrentGridatRowandCol
{
    [_gridModel updateCurrentGrid:5 atRow:2 andCol:4];
    XCTAssertTrue([_gridModel getValueAtRow:2 andColumn:4]==5,@"test update for a previously empty cell");
    [_gridModel updateCurrentGrid:9 atRow:3 andCol:1];
    XCTAssertTrue([_gridModel getValueAtRow:3 andColumn:1]==9,@"test update for an initial cell");
    [_gridModel updateCurrentGrid:3 atRow:5 andCol:5];
    [_gridModel updateCurrentGrid:9 atRow:5 andCol:5];
    XCTAssertTrue([_gridModel getValueAtRow:5 andColumn:5]==9,@"test update after another update");
    
    XCTAssertThrowsSpecific([_gridModel updateCurrentGrid:10 atRow:0 andCol:6], NSException);
    XCTAssertThrowsSpecific([_gridModel updateCurrentGrid:7 atRow:-1 andCol:8], NSException);
    XCTAssertThrowsSpecific([_gridModel updateCurrentGrid:6 atRow:8 andCol:15], NSException);
    
}

// Tests for the boardCompleted method.
// Funcitonality: Tests for board and game completion.
// Comment: "Z" is to force test to run last.
- (void)testZBoardComplete
{
    XCTAssertFalse([_gridModel boardCompleted],@"Check when board is incomplete");
    
    [_gridModel updateCurrentGrid:1 atRow:0 andCol:1];
    [_gridModel updateCurrentGrid:4 atRow:0 andCol:2];
    [_gridModel updateCurrentGrid:2 atRow:0 andCol:4];
    [_gridModel updateCurrentGrid:9 atRow:0 andCol:5];
    [_gridModel updateCurrentGrid:5 atRow:0 andCol:6];
    [_gridModel updateCurrentGrid:6 atRow:1 andCol:0];
    [_gridModel updateCurrentGrid:3 atRow:1 andCol:1];
    [_gridModel updateCurrentGrid:7 atRow:1 andCol:6];
    [_gridModel updateCurrentGrid:9 atRow:1 andCol:8];
    [_gridModel updateCurrentGrid:5 atRow:2 andCol:0];
    [_gridModel updateCurrentGrid:8 atRow:2 andCol:2];
    [_gridModel updateCurrentGrid:7 atRow:2 andCol:3];
    [_gridModel updateCurrentGrid:4 atRow:2 andCol:4];
    [_gridModel updateCurrentGrid:3 atRow:2 andCol:5];
    [_gridModel updateCurrentGrid:1 atRow:2 andCol:6];
    [_gridModel updateCurrentGrid:2 atRow:2 andCol:7];
    [_gridModel updateCurrentGrid:6 atRow:2 andCol:8];
    [_gridModel updateCurrentGrid:2 atRow:3 andCol:3];
    [_gridModel updateCurrentGrid:1 atRow:3 andCol:4];
    [_gridModel updateCurrentGrid:7 atRow:3 andCol:5];
    [_gridModel updateCurrentGrid:7 atRow:4 andCol:1];
    [_gridModel updateCurrentGrid:8 atRow:4 andCol:3];
    [_gridModel updateCurrentGrid:3 atRow:4 andCol:4];
    [_gridModel updateCurrentGrid:5 atRow:4 andCol:7];
    [_gridModel updateCurrentGrid:1 atRow:4 andCol:8];
    [_gridModel updateCurrentGrid:3 atRow:5 andCol:0];
    [_gridModel updateCurrentGrid:8 atRow:5 andCol:1];
    [_gridModel updateCurrentGrid:1 atRow:5 andCol:2];
    [_gridModel updateCurrentGrid:9 atRow:5 andCol:3];
    [_gridModel updateCurrentGrid:4 atRow:5 andCol:6];
    [_gridModel updateCurrentGrid:7 atRow:5 andCol:7];
    [_gridModel updateCurrentGrid:8 atRow:6 andCol:0];
    [_gridModel updateCurrentGrid:2 atRow:6 andCol:1];
    [_gridModel updateCurrentGrid:9 atRow:6 andCol:4];
    [_gridModel updateCurrentGrid:3 atRow:6 andCol:6];
    [_gridModel updateCurrentGrid:1 atRow:7 andCol:0];
    [_gridModel updateCurrentGrid:6 atRow:7 andCol:1];
    [_gridModel updateCurrentGrid:7 atRow:7 andCol:2];
    [_gridModel updateCurrentGrid:5 atRow:7 andCol:4];
    [_gridModel updateCurrentGrid:2 atRow:7 andCol:5];
    [_gridModel updateCurrentGrid:9 atRow:7 andCol:6];
    [_gridModel updateCurrentGrid:8 atRow:7 andCol:7];
    [_gridModel updateCurrentGrid:3 atRow:8 andCol:2];
    [_gridModel updateCurrentGrid:1 atRow:8 andCol:3];
    [_gridModel updateCurrentGrid:8 atRow:8 andCol:5];
    [_gridModel updateCurrentGrid:6 atRow:8 andCol:7];
    [_gridModel updateCurrentGrid:5 atRow:8 andCol:8];
    
    XCTAssertTrue([_gridModel boardCompleted],@"Check that the board is complete");
}



@end
