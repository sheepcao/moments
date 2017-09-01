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
    
    [[MomentsAPIClient sharedClient] dataGET:@"/user/jsmith/tweets" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, NSString *JSON) {
        [expectation fulfill];
        NSLog(@"json is : %@",JSON);
        XCTAssertNotNil(JSON,@"response data error");
        
        //parse start
        NSArray *array = [JSONHelper parseJSONArray:JSON ToModel:[Tweet class]];
        NSLog(@"array is : %@",array);
        XCTAssertGreaterThanOrEqual(array.count,22,@"array should be more that 22 elements");
        Tweet *tw = array[0];
        TweetImage *twImage = tw.images[0];
        XCTAssertNotNil(twImage.url,@"image url error");
        //end
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        XCTAssertNotNil(error,@"network error");
        
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
