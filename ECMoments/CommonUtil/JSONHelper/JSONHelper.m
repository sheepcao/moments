//
//  JSONHelper.m
//  ECMoments
//
//  Created by HSBC_XiAn_Core on 9/1/17.
//  Copyright © 2017 EricCao. All rights reserved.
//

#import "JSONHelper.h"

@implementation JSONHelper

+(id)parseJSONString:(NSString *)string ToModel:(id)modelClass WithCompletion:(void (^)(__weak id))completionHandler
{
    id model = [modelClass yy_modelWithJSON:string];
    
    // adding a completionHandler to do whatever needed after JSON parsed, such as fetching local storage,caching data,filter data etc...
    if (completionHandler) {
        completionHandler(model);
    }
    return model;
}

+(NSArray *)parseJSONArray:(NSString *)arrayString ToModel:(id)modelClass
{
    NSArray *modelArray = [NSArray yy_modelArrayWithClass:modelClass json:arrayString];

    return modelArray;
}

@end
