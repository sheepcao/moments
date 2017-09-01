//
//  JSONHelper.h
//  ECMoments
//
//  Created by HSBC_XiAn_Core on 9/1/17.
//  Copyright © 2017 EricCao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONHelper : NSObject

/**
adding a completionHandler to do whatever needed after JSON parsed, such as fetching local storage,caching data,filter data etc... 
 
 @return the data model
 */
+(id)parseJSONString:(NSString *)string ToModel:(id)modelClass WithCompletion:(void (^)(__weak id))completionHandler;
+(NSArray *)parseJSONArray:(NSString *)arrayString ToModel:(id)modelClass;
@end
