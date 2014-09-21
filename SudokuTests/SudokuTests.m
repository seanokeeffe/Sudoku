//
//  SudokuTests.m
//  SudokuTests
//
//  Created by HMC on 9/11/14.
//  Copyright (c) 2014 Hana Kim Sean Okeeffe. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HKSOGridModel.h"

@interface SudokuTests : XCTestCase {
    HKSOGridModel* _gridModel;
}

@end

@implementation SudokuTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _gridModel = [[HKSOGridModel alloc] init];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

@end
