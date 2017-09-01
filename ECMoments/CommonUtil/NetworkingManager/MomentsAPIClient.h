//
//  MomentsAPIClient.h
//  ECMoments
//
//  Created by HSBC_XiAn_Core on 9/1/17.
//  Copyright © 2017 EricCao. All rights reserved.
//

#import <AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface MomentsAPIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

- (nullable NSURLSessionDataTask *)dataGET:(NSString *)URLString
                                parameters:(nullable id)parameters
                                   success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                   failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;
@end
NS_ASSUME_NONNULL_END
