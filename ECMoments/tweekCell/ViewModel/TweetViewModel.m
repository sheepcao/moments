//
//  TweetViewModel.m
//  ECMoments
//
//  Created by HSBC_XiAn_Core on 9/2/17.
//  Copyright © 2017 EricCao. All rights reserved.
//

#import "TweetViewModel.h"

@implementation TweetViewModel

- (instancetype)initWithTweet:(Tweet *)tweet
{
    self = [super init];
    if (self) {
        self.tweet = tweet;
        self.contentString = self.tweet.content;
        self.senderName = self.tweet.contentSender.nick;
        self.picNamesArray = self.tweet.images;
        self.senderIconUrl = self.tweet.contentSender.avatar;
        self.commentsArray = self.tweet.comments;
        self.errorMessage = self.tweet.error ? self.tweet.error : self.tweet.unknownError;
        
        self.labelStatus = LabelStatusFold;
        
    }
    return self;
}


@end
