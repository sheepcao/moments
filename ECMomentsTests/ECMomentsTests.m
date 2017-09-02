//
//  ECMomentsTests.m
//  ECMomentsTests
//
//  Created by EricCao on 8/31/17.
//  Copyright © 2017 EricCao. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MomentsAPIClient.h"
#import "Tweet.h"
#import "JSONHelper.h"
#import "MomentsViewModel.h"
#import "TweetViewModel.h"

@interface ECMomentsTests : XCTestCase

@end

@implementation ECMomentsTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testFetchData {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Handler called"];
    
    MomentsViewModel *momentsViewModel = [[MomentsViewModel alloc] init];
    

    [momentsViewModel loadTweetsWithCount:6 WithBlock:^(NSError *error) {
        [expectation fulfill];

        TweetViewModel *tweetVM = momentsViewModel.tweetsToShow[0];
        XCTAssertTrue([tweetVM.senderName isEqualToString: @"Joe Portman"]);

        for (TweetViewModel *tweetVM in momentsViewModel.tweetsToShow) {
            NSLog(@"tweetVM:%f \n",tweetVM.cellHeight);

        }
        
    }];

    [self waitForExpectationsWithTimeout:15.0 handler:nil];
}




- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
