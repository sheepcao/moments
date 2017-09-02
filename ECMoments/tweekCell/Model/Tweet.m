//
//  Tweet.m
//  ECMoments
//
//  Created by HSBC_XiAn_Core on 9/1/17.
//  Copyright © 2017 EricCao. All rights reserved.
//

#import "Tweet.h"


@implementation Tweet

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    
    return @{
             @"images"       : [TweetImage class],
             @"comments"       : [Comment class]
             
             };
}

+ (NSDictionary *)modelCustomPropertyMapper {
    NSDictionary *dic=@{@"unknownError" :@"unknown error",
                        @"contentSender":@"sender"};
    return dic;
}

@end

@implementation Comment
+ (NSDictionary *)modelCustomPropertyMapper {
    NSDictionary *dic=@{@"commentMsg":@"content"};
    return dic;
}
@end

@implementation ContentSender

@end

@implementation TweetImage

@end
