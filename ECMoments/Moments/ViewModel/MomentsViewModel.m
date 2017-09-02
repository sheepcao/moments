//
//  MomentsViewModel.m
//  ECMoments
//
//  Created by HSBC_XiAn_Core on 9/2/17.
//  Copyright © 2017 EricCao. All rights reserved.
//

#import "MomentsViewModel.h"
#import "MomentsAPIClient.h"
#import "JSONHelper.h"
#import "Tweet.h"
#import "TweetViewModel.h"

@implementation MomentsViewModel

static NSString * const tweetsServicePathString = @"/user/jsmith/tweets";
static NSString * const userServicePathString = @"/user/jsmith";


-(NSArray *)tweetsToShow
{
    if (!_tweetsToShow) {
        _tweetsToShow = [[NSArray alloc] init];
    }
    return _tweetsToShow;
}

-(NSArray *)allTweetsModels
{
    if (!_allTweetsModels) {
        _allTweetsModels = [[NSArray alloc] init];
    }
    return _allTweetsModels;
}

-(void)loadUserProfileWithBlock:(void(^)(NSError *error ,UserProfile *profile))block
{
    [[MomentsAPIClient sharedClient] dataGET:userServicePathString parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, NSString *JSON) {
        UserProfile *profile = [self profileFromJSONString:JSON];
        if (block) {
            block(nil,profile);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (block) {
            block(error,nil);
        }
    }];
}


-(void)loadAllTweetsWithBlock:(void(^)(NSError *error))block
{
    [[MomentsAPIClient sharedClient] dataGET:tweetsServicePathString parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, NSString *JSON) {
        self.allTweetsModels = [NSArray arrayWithArray:[self tweetsFromJSONString:JSON]];
        ECLog(@"array is : %@",self.allTweetsModels);
        if (block) {
            block(nil);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (block) {
            block(error);
        }
    }];
}

-(NSArray *)tweetsFromJSONString:(NSString *)JSONString
{
    NSArray *tweetsArray = [JSONHelper parseJSONArray:JSONString ToModel:[Tweet class]];
    
    NSMutableArray *tweetsViewModelArray = [NSMutableArray arrayWithCapacity:tweetsArray.count];
    
    [tweetsArray enumerateObjectsUsingBlock:^(Tweet *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        TweetViewModel *tweetVM = [[TweetViewModel alloc] initWithTweet:obj];
        if(tweetVM.contentString || tweetVM.picNamesArray.count > 0)
        {
            [tweetsViewModelArray addObject:tweetVM];
        }
    }];
    return tweetsViewModelArray;
    
}
-(UserProfile *)profileFromJSONString:(NSString *)JSONString
{
    UserProfile *profile = [JSONHelper parseJSONString:JSONString ToModel:[UserProfile class] WithCompletion:nil];
    return profile;
    
}

- (void)loadTweetsWithCount:(NSInteger)count WithBlock:(void(^)(NSError *error))block
{
    
    if (self.allTweetsModels.count == 0) {
        [self loadAllTweetsWithBlock:^(NSError *error) {
            self.tweetsToShow = [NSArray arrayWithArray:[self insertObjToShowWithCount:count]];
            block(error);
        }];
    }else
    {
        self.tweetsToShow = [NSArray arrayWithArray:[self insertObjToShowWithCount:count]];
        block(nil);

    }
}

-(NSMutableArray *)insertObjToShowWithCount:(NSInteger)count
{
    NSMutableArray *showTweets = [[NSMutableArray alloc] initWithCapacity:count];
    
    [self.allTweetsModels enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [showTweets addObject:obj];
        
        if (idx >= count-1) {
            *stop = YES;
        }
    }];
    return showTweets;
}

@end
