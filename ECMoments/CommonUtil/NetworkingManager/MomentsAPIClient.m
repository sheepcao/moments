//
//  MomentsAPIClient.m
//  ECMoments
//
//  Created by HSBC_XiAn_Core on 9/1/17.
//  Copyright © 2017 EricCao. All rights reserved.
//

#import "MomentsAPIClient.h"

@implementation MomentsAPIClient

static NSString * const MomentsAPIBaseURLString = @"http://thoughtworks-ios.herokuapp.com/";

+ (instancetype)sharedClient {
    static MomentsAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[MomentsAPIClient alloc] initWithBaseURL:[NSURL URLWithString:MomentsAPIBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedClient;
}


- (nullable NSURLSessionDataTask *)dataGET:(NSString *)URLString
                                parameters:(nullable id)parameters
                                   success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                   failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure
{
    NSURLSessionDataTask *dataTask = [super GET:URLString parameters:parameters progress:nil success:success failure:failure];
    return dataTask;
}


@end
